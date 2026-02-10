table 52186560 "CRB DPI File Submissions"
{
    Caption = 'CRB Daily Payment Information File Submissions';
    DataClassification = ToBeClassified;

    LookupPageId = "CRB DPI File Submissions";
    DrillDownPageId = "CRB DPI File Submissions";
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Loan No."; Code[50])
        {
            Caption = 'Loan No.';
            TableRelation = Loans."Loan No.";
            Editable = false;

            trigger OnValidate()
            var
                TheLoan: Record Loans;
            begin
                TheLoan.Get("Loan No.");

                "Account Number" := TheLoan."Loan No.";
                "Original Amount" := Format((TheLoan."Approved Amount" * 100) div 1).Replace(',', '');
                "Currency of Facility" := TheLoan."Currency Code";
            end;
        }
        field(3; "Log Date Time"; DateTime)
        {
            Caption = 'Log Date Time';
            Editable = false;
        }
        field(4; "CRB Institution"; Code[50])
        {
            Caption = 'CRB Institution';
            Editable = false;
        }
        field(5; "Snapshot Date"; Text[10])
        {
            Caption = 'Snapshot Date';
            Editable = false;
        }
        field(6; "Client Type"; Code[5])
        {
            Caption = 'Client Type';
            Editable = false;
            // TODO
            // A – Individual Credit Consumer
            // B – Non-Individual Credit Consumer
        }
        field(7; Surname; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Forename 1"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'First Name';
            Editable = false;
        }
        field(9; "Forename 2"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Given Name';
            Editable = false;
        }
        field(10; "Forename 3"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Other Names';
            Editable = false;
        }
        field(11; "Company Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Company Name';
            Editable = false;
        }
        field(12; "Primary Id Doc Type"; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary Identification Document Type';
            Editable = false;

            // TODO
            // 001 – National ID
            // 002 – Passport
            // 003 – Alien Registration
            // 004 – Service ID
            // 005 - Company Registration No
        }
        field(13; "Primary Id Doc No."; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary Identification Document Number';
            Editable = false;
        }
        field(14; "Account Number"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Loan Number';
            Editable = false;
        }
        field(15; "Currency of Facility"; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Currency Code';
            Editable = false;

            // TODO
            // KES – Kenya Shilling
        }
        field(16; "Original Amount"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Approved Loan Amount';
            Editable = false;
        }
        field(17; "Payment Amount"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Paid Loan Amount';
            Editable = false;
        }
        field(18; "Payment Date"; Text[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Loan Payment Date';
            Editable = false;
        }
        field(19; "Current Balance"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Current Loan Balance';
            Editable = false;
        }
        field(20; "Installments in Arrears"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Installments in Arrears';
            Editable = false;
        }
        field(21; "Days in Arrears"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'Number of days the loan is overdue';
            Editable = false;
        }
        field(22; "Account Status"; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Account Status';
            Editable = false;

            // TODO
            // A - Closed
            // B - Dormant
            // C - Write-Off
            // D - Legal
            // E - Collection
            // F - Active
            // G - Facility Reshceduled
            // H - Settled
            // J - Called Up
            // K - Suspended
            // L - Client Deceased
            // M - Deffered/Moratotium
            // N - Not Updated
            // P - Disputed
        }

        field(23; "CL Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Log Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(100; "Is Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Is Sent?';
            Editable = false;
        }
        field(101; "API Status"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(102; "API Response"; Text[2048])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(103; "Batch No."; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Entry No.", "Loan No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        myInt: Integer;
    begin
        "Log Date Time" := CurrentDateTime;
        "Log Date" := Today;
    end;

    trigger OnDelete()
    begin
        Error('%1, deletion is NOT allowed!', UserId);
    end;
}
