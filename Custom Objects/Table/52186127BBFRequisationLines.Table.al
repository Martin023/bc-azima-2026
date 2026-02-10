table 52186127 "BBF Requisation Lines"
{
    LookupPageID = "Next of KIN";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Member No"; Code[20])
        {
            Description = 'LookUp to Member Application Table';
            TableRelation = Members WHERE("No." = FIELD("Member No"));
        }
        field(3; Name; Text[50])
        {
            Editable = false;
            NotBlank = true;
        }
        field(4; Relationship; Text[30])
        {
            Description = 'LookUp to Relationships Table';
            Editable = true;
            TableRelation = "Relationship Types";
        }
        field(5; Beneficiary; Boolean)
        {
            Editable = false;
        }
        field(6; "Date of Birth"; Date)
        {
            Editable = false;

            trigger OnValidate()
            var
                DateofBirthError: Label 'This date cannot be greater than today.';
            begin
            end;
        }
        field(7; Address; Text[30])
        {
            Editable = false;
        }
        field(8; Telephone; Code[20])
        {
            CharAllowed = '0123456789';
            Editable = false;
        }
        field(9; Fax; Code[10])
        {
        }
        field(10; Email; Text[30])
        {
        }
        field(11; "ID No."; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                "ID No." := DelChr("ID No.", '=', 'A|B|C|D|E|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|.|,|!|@|#|$|%|^|&|*|(|)|[|]|{|}|/|\|"|;|:|<|>|?|+|-|_');
                // FieldLength("ID No.", 10);
            end;
        }
        field(12; "%Allocation"; Decimal)
        {
            Editable = false;
            MinValue = 0;
        }
        field(13; Type; Option)
        {
            Editable = true;
            OptionCaption = 'Next of Kin,Spouse,Benevolent Beneficiary,Family Member';
            OptionMembers = "Next of Kin",Spouse,"Benevolent Beneficiary","Family Member";
        }
        field(14; Deceased; Boolean)
        {
            Editable = false;
        }
        // field(15; "BBF Entitlement Code"; Code[50])
        // {
        //     Editable = true;
        //     TableRelation = "BBF Entitlement".Code;
        // }
        field(16; "BBF Entitlement"; Decimal)
        {
            Editable = true;
        }
        field(17; "Line No."; Code[50])
        {
            Editable = false;
            TableRelation = "Payments Header"."No." WHERE("Payment Type" = CONST("Benevolent Claim"));
        }
        field(18; "Account No."; Code[80])
        {
            Editable = false;
        }
        field(19; "Next of Kin"; Text[150])
        {
            TableRelation = "Next of KIN".Name WHERE("Is a Beneficiary" = CONST(true),
                                                      Deceased = CONST(false),
                                                      "Record ID" = FIELD("Member No"));

            trigger OnValidate()
            var
                Entitlement: Record "BBF Entitlement";
                MaxKinNo: Integer;
                ErrorOnMaxEntitlement: Label 'Member has exhausted the Max. No. of -%1- entitlement under this category.Category is %2.';
                RunPeriodicTrans: Codeunit "Sacco Transactions";
                SavingsAccounts: Record "Savings Accounts";
            begin
            end;
        }
        field(20; Posted; Boolean)
        {
        }
        field(21; "Header No"; Code[20])
        {
        }
        field(22; "Loan No."; Code[20])
        {
            TableRelation = Loans WHERE("Loan Account" = FIELD("Account No."));
        }
        field(23; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Loan,Repayment,Interest Due,Interest Paid,Bills,Appraisal';
            OptionMembers = " ",Loan,Repayment,"Interest Due","Interest Paid",Bills,Appraisal;
        }
        field(24; "Pay To Name"; Text[50])
        {
        }
        field(25; "Pay To ID"; Code[20])
        {

            trigger OnValidate()
            var
                Entitlement: Record "BBF Entitlement";
                MaxKinNo: Integer;
                RunPeriodicTrans: Codeunit "Sacco Transactions";
                SavingsAccounts: Record "Savings Accounts";
                ErrorOnMaxEntitlement: Label 'Member has exhausted the Max. No. of -%1- entitlement under this category.Category is %2.';
                SinkFundReportInformation: Record "SinkFund Report Information";
                SaccoAmount: Decimal;
                DeathDate: Date;
                BBFRequisationHeader: Record "BBF Requisation Header";
                Members: Record Members;
            begin

            end;
        }
        field(26; "Pay To Relationship"; Text[30])
        {
            Description = 'LookUp to Relationships Table';
            TableRelation = "Relationship Types";
        }
        field(27; "Sacco Income Recovable"; Decimal)
        {
            Editable = false;
        }
        field(28; "Total Amount"; Decimal)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Header No", "Member No")
        {
            Clustered = true;
            SumIndexFields = "%Allocation";
        }
    }

    fieldgroups
    {
    }

    var
        NOK: Record "Next of KIN";
        TotalA: Decimal;
        NOK1: Record "Next of KIN";
        AccountM: Record Members;
        KinDetails: Record "Next of KIN";
        AccountF: Record "Savings Accounts";
        BHeader: Record "Payments Header";
        ErrorOnDelMod: Label 'You cannot DELETE or MODIFY a Document whose status is %1';
        BBFRequisationHeader: Record "BBF Requisation Header";
        BBFEntitlement: Record "BBF Entitlement";
        SinkFundReportInformation: Record "SinkFund Report Information";
        MaxKinNo: Integer;

    //[Scope('OnPrem')]
    procedure FieldLength(VarVariant: Text; FldLength: Integer): Text
    var
        FieldLengthError: Label 'Field cannot be more than %1 Characters.';
    begin
        if StrLen(VarVariant) > FldLength then
            Error(FieldLengthError, FldLength);
    end;
}

