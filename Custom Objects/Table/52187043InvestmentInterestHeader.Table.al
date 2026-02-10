table 52187043 "Investment Interest Header"
{
    DrillDownPageID = "Investment Interest List";
    LookupPageID = "Investment Interest Header";

    fields
    {
        field(1; "No."; Code[30])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."Investment Interest Nos");
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
            CalcFormula = lookup("Investment Lines"."Investment Amount");
            // CalcFormula = ("Investment Lines" WHERE(No = FIELD("No.")));
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
        field(7; Cashier; Code[50])
        {
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(8; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending Approval,,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",,Approved,Rejected;
        }
        field(9; "Posted By"; Code[100])
        {
        }
        field(10; "Time Posted"; Time)
        {
        }
        field(11; Description; Text[30])
        {
        }
        field(12; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center";
        }
        field(13; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(14; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(15; "Interest Due Date"; Date)
        {
            Caption = 'Interest Due Date';
            Editable = true;
            //TableRelation = "Interest Due Period" WHERE(Closed = FILTER(false));

            // trigger OnValidate()
            // begin
            //     Description := '';
            //     "Document No." := '';
            //     "Document No." := CopyStr(Format('INT') + ' ' + CopyStr(Format("Interest Due Date", 0, '<Month Text>'), 1, 3) + ' ' + Format(Date2DMY("Interest Due Date", 3)), 1, 20);
            // end;
        }

        field(17; "Actual Date Posted"; Date)
        {
            Editable = false;
        }
        field(18; "Line Count"; Integer)
        {
            CalcFormula = Count("Investment Interest Lines" WHERE("Investment Header No" = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Document No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Investment Nos");
            NoSeriesMgt.InitSeries(NoSetup."Investment Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Posting Date" := Today;
        "Document No." := "No.";
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        NoSetup: Record "Banking No Setup";
        CUST: Record Customer;
}

