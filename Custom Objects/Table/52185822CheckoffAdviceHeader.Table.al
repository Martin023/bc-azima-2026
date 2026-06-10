table 52185822 "Checkoff Advice Header"
{

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."Advice No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Employer Code"; Code[20])
        {
            TableRelation = Customer WHERE("Account Type" = CONST("Employer Code")
                                            //"Advice Method" = FILTER(<> " ")
                                            );

            trigger OnValidate()
            begin
                if Emp.Get("Employer Code") then begin
                    "Employer Name" := Emp.Name;
                end;
            end;
        }
        field(3; "Employer Name"; Text[50])
        {
        }
        field(4; "Start Date"; Date)
        {

            trigger OnValidate()
            begin
                Period := Format("Start Date", 0, Text000);
                Validate(Period);
            end;
        }
        field(5; "End Date"; Date)
        {

            trigger OnValidate()
            begin
                //"End Date":=CALCDATE('CM',"Start Date");
            end;
        }
        field(6; "No. Series"; Code[10])
        {
        }
        field(7; "Captured By"; Code[50])
        {
        }
        field(8; "Date Entered"; Date)
        {
        }
        field(9; Period; Code[20])
        {

            trigger OnValidate()
            begin
                Period := Period + ' ' + Format(Date2DMY("Start Date", 3));
                Validate("End Date");
            end;
        }
        field(10; Processed; Boolean)
        {
        }
        field(11; "Loan Issue Cut OFF Date"; Date)
        {
        }
        field(12; "Loan Interest Cut OFF Date"; Date)
        {
        }
        field(13; "MKey Generated"; Boolean)
        {
            Editable = false;
        }
        field(50; "Amali Ref"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Amali Advise Type"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Amali Posted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Processed = true then
            Error(Txt0001)
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Advice No.");
            "No." := NoSeriesMgt.GetNextNo(NoSetup."Advice No.");
            // NoSeriesMgt.InitSeries(NoSetup."Advice No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Date Entered" := Today;
        "Captured By" := UserId;
    end;

    var
        NoSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        Text000: Label '<Month Text>';
        Emp: Record Customer;
        Txt0001: Label 'You cannot delete processed buffer';
}

