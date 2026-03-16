table 52185847 "End Year Transfer Header"
{
    DrillDownPageID = "End Year Interest List";
    LookupPageID = "End Year Interest List";

    fields
    {
        field(1; "No."; Code[30])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    NoSetup.Get;
                    NoSeriesMgt.TestManual(NoSetup."FOSA Interest Nos");
                    "No. Series" := '';
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
            CalcFormula = Sum("End Year Interest Buffer"."Interest Amount" WHERE(No = FIELD("No.")));
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
        field(11; Description; Text[50])
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
                "End Date" := CalcDate('<CY>', "Start Date");
                Validate("End Date");
            end;
        }
        field(16; "End Date"; Date)
        {
            Editable = false;
            trigger OnValidate()
            begin
                Description := Format("End Date", 0, '<Month Text>') + ' ' + Format(Date2DMY("End Date", 3)) + ' ' + 'End year Interest';
            end;
        }
        field(17; "Product Type"; Code[100])
        {
            TableRelation = "Product Factory"."Product ID" where("Earns Interest" = const(true), "Product Class Type" = filter(Savings), "Product Category" = filter(<> "Fixed Deposit"));
            trigger OnValidate()
            var
                ProdFact: Record "Product Factory";
            begin
                ProdFact.Reset();
                ProdFact.SetRange("Product ID", rec."Product Type");
                if ProdFact.FindFirst() then begin
                    Rec."Product Name" := ProdFact."Product Description";
                end;
            end;
        }
        field(18; "Product Name"; Text[50])
        {

        }
    }

    keys
    {
        key(Key1; "Start Date", "Product Type")
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
            NoSetup.TestField(NoSetup."FOSA Interest Nos");
            "No." := NoSeriesMgt.GetNextNo(NoSetup."FOSA Interest Nos");
            // NoSeriesMgt.InitSeries(NoSetup."FOSA Interest Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        Cashier := UserId;
        "Document No." := "No.";
        UserSetup.Get(UserId); //THEN
                               // BEGIN
        UserSetup.TestField("Global Dimension 1 Code");
        UserSetup.TestField("Global Dimension 2 Code");
        UserSetup.TestField("Responsibility Centre");

        "Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        "Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        "Responsibility Center" := UserSetup."Responsibility Centre";
        // END;
    end;

    trigger OnModify()
    begin
        if UserSetup.Get(UserId) then begin
            "Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
        end;
    end;

    var
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        UserSetup: Record "User Setup";
        NoSetup: Record "Banking No Setup";
        CUST: Record Customer;
}

