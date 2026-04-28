table 52187040 "Dispatch ATM Header"
{
    Caption = 'Dispatch ATM Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[50])
        {
            Editable = false;
            trigger OnValidate()
            begin

                if "No." <> xRec."No." then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."Dispatch ATM Header No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "User ID"; Code[50])
        {
            Caption = 'Captured By';
            Editable = false;

            //TableRelation = User;
        }
        field(3; "Date Of Dispatch"; Date)
        {
            Caption = 'Date Of Dispatch';
            Editable = false;
        }

        field(11; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(10; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

        }
        field(5; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionMembers = "Open","Pending","Approved","Rejected";
        }
        field(6; "Record Count"; Integer)
        {
            CalcFormula = Count("ATM Card Storage");
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Total Received"; Integer)
        {
            CalcFormula = Count("ATM Card Storage");
            Editable = true;
            FieldClass = FlowField;
        }
        field(8; "To Branch"; Integer)
        {
            CalcFormula = Count("ATM Card Storage");
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "No. Series"; Code[20])
        {
            Editable = false;
            TableRelation = "No. Series";
        }
        field(12; "Date Of Return"; Date)
        {
            // Editable = false;
            // TableRelation = "No. Series";
        }
    }
    keys
    {
    }

    trigger OnInsert()
    begin

        if "No." = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Dispatch ATM Header No.");
            "No." := NoSeriesMgt.GetNextNo(NoSetup."Dispatch ATM Header No.");
            // NoSeriesMgt.InitSeries(NoSetup."Dispatch ATM Header No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "User ID" := UpperCase(UserId);
        "Date Of Dispatch" := Today;

    end;

    var
        NoSetup: Record "Banking No Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";

}

