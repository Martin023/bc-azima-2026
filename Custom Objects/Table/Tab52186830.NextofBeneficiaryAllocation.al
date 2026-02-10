table 52186830 "NextofKin Payment Allocation"
{
    Caption = 'Next of Kin Beneficiary Allocation';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Header No."; Code[20])
        {
            Caption = 'Header No.';
            Editable = false;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;

        }
        field(3; "Identification Type"; Enum "Identification Type")
        {
            Editable = false;

        }
        field(4; Identification; Code[20])
        {
            Editable = false;


            trigger OnValidate()
            begin
                Identification := DelChr(Identification, '=', 'A|B|C|D|E|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|.|,|!|@|#|$|%|^|&|*|(|)|[|]|{|}|/|\|"|;|:|<|>|?|+|-|_');
            end;
        }
        field(5; Name; Text[50])
        {
            NotBlank = true;
            Editable = false;


            trigger OnValidate()
            begin
                Name := UpperCase(Name);
            end;
        }
        field(6; Relationship; Text[30])
        {
            Description = 'LookUp to Relationships Table';
            TableRelation = "Relationship Types";
            Editable = false;

        }
        field(7; "Date of Birth"; Date)
        {
            Editable = false;

            trigger OnValidate()
            var
                DateofBirthError: Label 'This date cannot be greater than today.';
            begin
                if "Date of Birth" > Today then
                    Error(DateofBirthError);
            end;
        }
        field(8; Telephone; Code[20])
        {
            Editable = false;

            Caption = 'Mobile No.';
            CharAllowed = '0123456789';
        }

        field(9; Email; Text[30])
        {
            Editable = false;

        }
        field(10; "Principal Member No."; Code[50])
        {
            Editable = false;

            Description = 'LookUp to Member Application Table';
            TableRelation = Members."No.";
        }
        field(11; Allocation; Decimal)
        {
            Editable = false;

        }
        field(12; "Beneficiary Member No."; Code[50])
        {
            TableRelation = Members where("Principle Member" = field("Principal Member No."));
            trigger OnValidate()
            var
                Sav: Record "Savings Accounts";
                NextofKinPmtAlloc: Record "NextofKin Payment Allocation";
                ErrNok: Label 'Kindly specify a different beneficiary member no for the payment allocation!';
                NoFosaAcc: Label 'Kindly create a Fosa Disbursement account for %1 before proceeding.!';
            begin
                Sav.Reset();
                Sav.SetRange("Member No.", "Beneficiary Member No.");
                Sav.SetRange("Loan Disbursement Account", true);
                If not Sav.FindFirst() then
                    Error(NoFosaAcc, Sav."Member No.");
                "Disbursement Account" := Sav."No.";

                NextofKinPmtAlloc.Reset();
                NextofKinPmtAlloc.SetRange("Header No.", Rec."Header No.");
                NextofKinPmtAlloc.SetFilter("Line No.", '<>%1', Rec."Line No.");
                NextofKinPmtAlloc.SetRange("Beneficiary Member No.", Rec."Beneficiary Member No.");
                if NextofKinPmtAlloc.FindFirst() then
                    Error(ErrNok);
            end;
        }
        field(13; "Beneficiary Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(14; "Disbursement Account"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Pay Next of Kin Account"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec.TestField("Beneficiary Member No.");
            end;

        }
        field(16; "Next of Kin Account Paid"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "DateTime Paid"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Header No.", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnModify()
    begin
        Rec.TestField("Next of Kin Account Paid", false);
    end;
}
