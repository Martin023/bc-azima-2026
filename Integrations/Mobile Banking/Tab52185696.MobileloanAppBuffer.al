table 52185696 "Mobile loan App. Buffer"
{
    Caption = 'Mobile loan App. Buffer';
    DataClassification = ToBeClassified;

    DrillDownPageId = "Sky Mobile Loans";
    LookupPageId = "Sky Mobile Loans";

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Account No"; Text[30])
        {
            Editable = false;
        }
        field(3; Date; DateTime)
        {
        }
        field(4; "Requested Amount"; Decimal)
        {
            Editable = false;
        }
        field(5; Posted; Boolean)
        {
            Editable = true;
        }
        field(6; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Pending,Successful,Failed,Pending Guarantors,Appraisal,Approved';
            OptionMembers = Pending,Successful,Failed,"Pending Guarantors",Appraisal,Approved;
        }
        field(7; "Date Posted"; DateTime)
        {
        }
        field(8; Remarks; Text[200])
        {
            Editable = false;
        }
        field(9; DocumentNo; Text[30])
        {
            Editable = false;
        }
        field(10; "Latest Salary Amount"; Decimal)
        {
            Editable = false;
        }
        field(11; "STO Amount"; Decimal)
        {
        }
        field(12; "Net Salary"; Decimal)
        {
        }
        field(13; "Total loans"; Decimal)
        {
        }
        field(14; "Approved Amount"; Decimal)
        {
        }
        field(15; "Commision Amount"; Decimal)
        {
        }
        field(16; "Loan Product Type"; Code[20])
        {
            TableRelation = "Product Factory"."Product ID";
        }
        field(17; Amount; Decimal)
        {
        }
        field(18; "Session ID"; Text[50])
        {
        }
        field(19; "Date Entered"; Date)
        {
        }
        field(20; "Time Entered"; Time)
        {
        }
        field(21; "Telephone No"; Text[20])
        {
        }
        field(22; "Message Text"; Text[250])
        {
        }
        field(23; "Member No."; Code[20])
        {
            TableRelation = Members."No.";
        }
        field(24; "Entry Code"; Text[20])
        {
        }
        field(50050; Deactivated; Boolean)
        {
        }
        field(50051; "Deactivated By"; Code[50])
        {
        }
        field(50052; "Date Deactivated"; Date)
        {
        }
        field(50053; "Micro Loan Category"; Code[20])
        {
        }
        field(50054; "Needs Guarantors"; Boolean)
        {
        }
        field(50055; "Micro Loan"; Boolean)
        {
        }
        field(50056; Blocked; Boolean)
        {
        }
        field(50057; "Salary Loan"; Boolean)
        {
        }
        field(50058; "Account Name"; Text[200])
        {
        }
        field(50059; "Loan Name"; Text[200])
        {
        }
        field(50060; "Expected Guarantors"; Integer)
        {
        }
        field(50061; Password; Text[200])
        {
        }
        field(50062; "Loan Period"; Integer)
        {
        }
        field(50063; "Loan Purpose"; Code[20])
        {
            TableRelation = "Loan Purpose".Code;
        }
        field(50064; Source; Code[20])
        {
        }
        field(50065; "Loan No."; Code[20])
        {
            TableRelation = Loans."Loan No.";
        }
        field(50066; Branch; Code[20])
        {
        }
        field(50067; Category; Code[20])
        {
        }
        field(50068; "Interest Recoverd Upfront"; Boolean)
        {
        }
        field(50069; "Needs Change"; Boolean)
        {
        }
        field(50070; "Needs Change Reason"; Code[100])
        {
        }
        field(50071; "Employer Code"; Code[100])
        {
        }
        field(50072; "Try Posting Count"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50073; Installments; Integer)
        {
        }
        field(50074; "Loan Record Created?"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
        // Secondary keys for non-primary fields
        key(IdxPosted; "Posted")
        {
            Clustered = false;
        }

        key(IdxStatus; "Status")
        {
            Clustered = false;
        }

        key(IdxDeactivated; "Deactivated")
        {
            Clustered = false;
        }

        key(IdxMemberNo; "Member No.")
        {
            Clustered = false;
        }

        key(IdxLoanProductType; "Loan Product Type")
        {
            Clustered = false;
        }

        key(IdxLoanNo; "Loan No.")
        {
            Clustered = false;
        }

        // Composite keys for efficient queries involving multiple fields
        key(IdxPostedStatus; "Posted", "Status")
        {
            Clustered = false;
        }

        key(IdxPostedDeactivated; "Posted", "Deactivated")
        {
            Clustered = false;
        }

        key(IdxStatusDeactivated; "Status", "Deactivated")
        {
            Clustered = false;
        }

        key(IdxMemberNoLoanProductType; "Member No.", "Loan Product Type")
        {
            Clustered = false;
        }

        key(IdxMemberNoLoanNo; "Member No.", "Loan No.")
        {
            Clustered = false;
        }

        key(IdxLoanProductTypeLoanNo; "Loan Product Type", "Loan No.")
        {
            Clustered = false;
        }

        key(IdxPostedStatusDeactivated; "Posted", "Status", "Deactivated")
        {
            Clustered = false;
        }

        key(IdxMemberNoLnPrdTypLnNo; "Member No.", "Loan Product Type", "Loan No.")
        {
            Clustered = false;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Error('Deletion not allowed');
    end;
}
