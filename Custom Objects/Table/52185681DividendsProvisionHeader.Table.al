table 52185681 "Dividends Provision Header"
{
    DrillDownPageID = "Dividends Provision List";
    LookupPageID = "Dividends Provision List";

    fields
    {
        field(1; "No."; Code[30])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    NoSetup.Get;
                    NoSeriesMgt.TestManual(NoSetup."Dividend Rate No.");
                    "No. Series" := '';
                end;
                if UserSetup.Get(UserId) then begin
                    "Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                    "Responsibility Center" := UserSetup."Responsibility Centre";
                end;
            end;
        }
        field(2; "Posting Date"; Date)
        {
        }
        field(3; "Document No."; Code[30])
        {
            Editable = true;
        }
        field(4; "Distributed Amount"; Decimal)
        {
            CalcFormula = sum("Dividend Provision"."Gross Dividends" WHERE("Dividends No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; Posted; Boolean)
        {
            Editable = false;
        }
        field(6; "No. Series"; Code[20])
        {
            Description = 'Stores the number series in the database';
        }
        field(7; Cashier; Code[30])
        {
            Editable = false;
            TableRelation = "User Setup";
        }
        field(8; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending Approval,,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",,Approved,Rejected;
        }
        field(9; "Posted By"; Code[30])
        {
            Editable = false;
        }
        field(10; "Time Posted"; Time)
        {
            Editable = false;
        }
        field(11; Description; Text[30])
        {
        }
        field(12; "Responsibility Center"; Code[10])
        {
            Editable = false;
            TableRelation = "Responsibility Center";
        }
        field(13; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(14; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(15; "Start Date"; Date)
        {

            trigger OnValidate()
            begin
                "End Date" := CalcDate('<CM>', "Start Date");
                "Document No." := Format("End Date", 0, '<Month Text>') + ' - ' + Format(Date2DMY("End Date", 3));
                Description := Format("End Date", 0, '<Month Text>') + ' - ' + Format(Date2DMY("End Date", 3));
                "Posting Date" := CalcDate('<CM>', "Start Date");
            end;
        }
        field(16; "End Date"; Date)
        {
            Editable = false;
        }
        field(17; "No of Accs."; Integer)
        {
            CalcFormula = Count("Dividend Provision" WHERE("Dividends No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(39; "Employer Code"; Code[20])
        {
            TableRelation = Customer WHERE("Account Type" = CONST(Employer));
        }
        field(40; "Product Type"; Code[30])
        {
            TableRelation = "Product Factory"."Product ID" where("Product Class Type" = filter(Savings), "Dividend Calc. Method" = filter(<> " "));
        }
    }

    keys
    {
        key(Key1; "Start Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Dividend Rate No.");
            "No." := NoSeriesMgt.GetNextNo(NoSetup."Dividend Rate No.");
            // NoSeriesMgt.InitSeries(NoSetup."Dividend Rate No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        Cashier := UserId;
        "Document No." := "No.";
        UserSetup.Get(UserId);
        //BEGIN
        UserSetup.TestField("Global Dimension 1 Code");
        UserSetup.TestField("Global Dimension 2 Code");
        UserSetup.TestField("Responsibility Centre");
        "Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        "Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        "Responsibility Center" := UserSetup."Responsibility Centre";
        //END;
    end;

    var
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        UserSetup: Record "User Setup";
        NoSetup: Record "Credit Nos. Series";
        CUST: Record Customer;
}

