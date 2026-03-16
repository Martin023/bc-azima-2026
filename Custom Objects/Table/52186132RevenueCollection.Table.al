table 52186132 "Revenue Collection"
{

    Caption = 'Revenue Collection';
    DataClassification = ToBeClassified;
    LookupPageId = "Revenue Collection List";
    DrillDownPageId = "Revenue Collection List";

    fields
    {
        field(1; "No."; Code[50])
        {
            Caption = 'No.';
        }
        field(2; "No. Series"; Code[50])
        {
            Caption = 'No. Series';
        }
        field(3; "Created At"; DateTime)
        {
            Caption = 'Created At';
        }
        field(4; "Created By"; Code[100])
        {
            Caption = 'Created By';
        }
        field(5; Status; Enum "Workflow Status Main Flags")
        {
            Caption = 'Status';

            trigger OnValidate()
            begin
                if Rec.Status = Rec.Status::Approved then begin
                    "Approved At" := CurrentDateTime;
                    "Approved By" := UserId;
                    Modify();
                end;
            end;
        }
        field(6; "Approved At"; DateTime)
        {
            Caption = 'Approved At';
        }
        field(7; "Approved By"; Code[100])
        {
            Caption = 'Approved By';
        }
        field(8; "Employer Code"; Code[100])
        {
            Caption = 'Employer Code';
            TableRelation = Customer WHERE("Account Type" = CONST(Employer));
        }
        field(9; "Employer Name"; Text[100])
        {
            Caption = 'Employer Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Employer Code")));
        }
        field(10; "Posting Period"; Date)
        {
            Caption = 'Period';
            TableRelation = "Interest Due Period"."Interest Due Date";
        }
        field(11; "Cheque No."; Code[100])
        {
            Caption = 'Cheque No.';
        }
        field(12; "Amount Collected"; Decimal)
        {
            Caption = 'Amount Collected';
        }
        field(13; "Processing Fee"; Decimal)
        {
            Caption = 'Processing Fee';
        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        UserSetUp: Record "User Setup";
        CreditNosSeries: Record "Credit Nos. Series";
    begin
        if "No." = '' then begin
            CreditNosSeries.Get;
            CreditNosSeries.TestField(CreditNosSeries."Revenue Collection Nos.");
            "No." := NoSeriesMgt.GetNextNo(CreditNosSeries."Revenue Collection Nos.");  
            // NoSeriesMgt.InitSeries(CreditNosSeries."Revenue Collection Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;


        if UserSetup.Get(UserId) then begin
            UserSetup.TestField("Responsibility Centre");
            "Created At" := CurrentDateTime;
            "Created By" := UserId;
        end else
            Error('You must be set up in user setup');
    end;

    var
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
}
