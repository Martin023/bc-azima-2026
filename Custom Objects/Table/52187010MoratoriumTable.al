table 52187010 "Moratorium Loan"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Moratorium Loan List";
    LookupPageId = "Moratorium Loan List";

    fields
    {
        field(1; "M-Num"; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
                SeriesSetup: Record "Credit Nos. Series";
                NoSeriesMgt: Codeunit "No. Series";
            begin
                if "M-Num" <> xRec."M-Num" then begin
                    SeriesSetup.Get;
                    NoSeriesMgt.TestManual(SeriesSetup."Mora-Num");
                    "No. Series" := '';
                end;
            end;

        }
        field(2; "Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans."Loan No." where("Moratorium Loan" = const(false), Posted = filter(true), "Outstanding Balance" = filter(> 1000), "Member No." = field("Member No."));
            trigger OnValidate()
            var
                myInt: Integer;
                Member: Record Members;
                loans: Record Loans;
                DateCal: DateFormula;
            begin

                Rec."Created By" := UserId;
                Evaluate(DateCal, '0D');
                "Moratorium-Duration" := DateCal;
                if loans.Get(Rec."Loan No") then begin
                    loans.CalcFields(loans."Outstanding Balance", loans."Outstanding Interest");
                    Rec."Outsanding Balance" := loans."Outstanding Balance";
                    Rec."Outsanding Interest" := loans."Outstanding Interest";
                    Rec."Loan Type" := loans."Loan Product Type Name";
                    if Member.Get(loans."Member No.") then begin
                        "Member Name" := Member.Name;
                        "Member No." := Member."No.";
                        "Employer Code" := Member."Employer Code";


                    end;
                end;


            end;
        }
        field(3; "Member Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Employer Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Pending,Approved,Rejected;
            OptionCaption = 'Open,Pending,Approved,Rejected';
        }
        field(6; "Start Date Moratorium"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
                DateCal: DateFormula;
            begin
                Evaluate(DateCal, '0D');
                if "Start Date Moratorium" < Today then Error('BackDating is not allowed');

            end;

        }
        field(7; "End Date Moratorium"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(8; "Created By"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Captured By';
        }
        field(9; "Approved By"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Loan Type"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Outsanding Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Outsanding Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Member No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Loan No" := '';
                "Loan Type" := '';
                "Outsanding Balance" := 0;
                "Created By" := UserId;

            end;
        }
        field(14; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Moratorium-Duration"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(16; Processed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "Rejection Reason"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "M-Num")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        UserSet: Record "User Setup";
        SeriesSetup: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit "No. Series";
    begin
        if "M-Num" = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Mora-Num");
            "M-Num" := NoSeriesMgt.GetNextNo(SeriesSetup."Mora-Num");
            // NoSeriesMgt.InitSeries(SeriesSetup."Mora-Num", xRec."No. Series", 0D, "M-Num", "No. Series");
        end;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin


    end;

}