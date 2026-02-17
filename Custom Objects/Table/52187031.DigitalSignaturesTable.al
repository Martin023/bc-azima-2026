table 52187031 "Digital Signature"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[50])
        {
            Editable = false;
        }
        field(2; "No. Series"; Code[50])
        {
            TableRelation = Loans."Loan No.";

        }
        field(3; "Payroll No."; Code[50])
        {
            TableRelation = "HR Employees"."No." where(Status = const(Active));
            trigger OnValidate()
            var
                Members: Record Members;
                ImageData: Record "Image Data";
            begin
                Members.Reset();
                Members.SetRange("Payroll/Staff No.", "Payroll No.");
                if Members.FindFirst() then begin
                    "Member No." := Members."No.";
                    ImageData.Reset();
                    ImageData.SetRange("Member No", Members."No.");
                    if ImageData.FindFirst() then begin
                        ImageData.CalcFields(Signature);
                        if not ImageData.Signature.HasValue then
                            Error('This staff does not have a signature');
                    end else
                        Error('This staff does not have a signature');
                end else
                    Error('This payroll number does not exist in member register');
            end;
        }
        field(4; "Member No."; Code[50])
        {

        }
        field(5; "Member Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Name where("No." = field("Member No.")));
        }
        field(6; "Has Signature"; Boolean)
        {

        }
        field(7; "Entered By"; Code[100])
        {

        }
        field(8; "Date Entered"; DateTime)
        {

        }
        field(9; "Date Last Modified"; DateTime)
        {

        }
        field(10; "Modified By"; Code[100])
        {

        }
        field(11; "Signature Process"; Enum "Digital Signature Process")
        {

        }
        field(12; "Signature Name"; Enum "Digital Signature Name")
        {

        }

    }
    keys
    {
        key(Key1; "No.")
        {

        }
    }

    trigger OnInsert()
    var
        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
    begin
        if "No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Digital Signature Nos.");
            "No." := NoSeriesMgt.GetNextNo(SeriesSetup."Digital Signature Nos.");
            // NoSeriesMgt.InitSeries(SeriesSetup."Digital Signature Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Entered By" := UserId;
        "Date Entered" := CurrentDateTime;

    end;

    trigger OnModify()
    begin
        "Modified By" := UserId;
        "Date Last Modified" := CurrentDateTime;
        Modify();
    end;
}
