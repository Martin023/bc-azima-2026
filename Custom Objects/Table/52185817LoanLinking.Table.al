table 52185817 "Loan Linking"
{

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SeriesSetup.Get;
                    NoSeriesMgt.TestManual(SeriesSetup."Loan Linking");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Date; Date)
        {
        }
        field(3; "Entered By"; Code[30])
        {
        }
        field(4; Status; Option)
        {
            OptionCaption = 'Open,Pendig,Approved';
            OptionMembers = Open,Pendig,Approved;
        }
        field(5; Processed; Boolean)
        {
        }
        field(6; "Employer Code"; Code[30])
        {
            TableRelation = Customer WHERE("Account Type" = CONST(Employer));
        }
        field(7; "No. Series"; Code[20])
        {
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

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Loan Linking");
            "No." := NoSeriesMgt.GetNextNo(SeriesSetup."Loan Linking");
            // NoSeriesMgt.InitSeries(SeriesSetup."Loan Linking", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Entered By" := UserId;
        Date := Today;
    end;

    var
        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
}

