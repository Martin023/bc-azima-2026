table 52186275 "NCBA Pension Buffer"
{
    Caption = 'NCBA Pension Buffer';
    DataClassification = ToBeClassified;
    LookupPageID = "NCBA Pension List";

    fields
    {
        field(1; "pensionNumber"; Code[50])
        {
            Caption = 'Pension Number';
            Editable = false;
        }
        field(2; Company; Text[100])
        {
            Caption = 'Company';
            Editable = false;
        }
        field(3; "referenceNumber"; Code[50])
        {
            Caption = 'Reference Number';
            Editable = false;
        }
        field(4; Posted; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
        }
        field(5; "Needs change"; Boolean)
        {
            Caption = 'Needs change';
        }
        field(6; "accountNo"; Code[30])
        {
            Caption = 'Account No';
            TableRelation = "Savings Accounts"."No." WHERE("Product Type" = CONST('ODS'));
        }
        field(7; Amount; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
        }
        field(8; Name; Text[150])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(9; "postingDate"; DateTime)
        {
            Caption = ' Posting Date';
            Editable = false;
        }
        field(10; "dateEntered"; DateTime)
        {
            Caption = 'Date Entered';
            Editable = false;
        }
        field(11; modifiedAt; DateTime)
        {
            Caption = 'Date Modified';
            Editable = false;
            DataClassification = SystemMetadata;
        }
        field(12; modifiedBy; Text[50])
        {
            Caption = 'Modified By';
            Editable = false;
            DataClassification = SystemMetadata;
        }
        field(13; "Income Type"; Enum "Salary Income Types")
        {
            Caption = 'Income Type';
        }
    }
    keys
    {
        key(PK; "referenceNumber")
        {
            Clustered = true;
        }
        key(secondKey; "pensionNumber")
        {
        }
        key(thirdKey; "postingDate")
        {
        }
    }

    trigger OnInsert()
    begin
        dateEntered := CurrentDateTime();
    end;

    trigger OnModify()
    begin
        modifiedAt := CurrentDateTime();
        modifiedBy := UserId();
    end;
}
