table 52185530 "HR Notification Log"
{
    Caption = 'HR Notification Log';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "HR Employees"."No.";
        }
        field(3; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            FieldClass = FlowField;
            CalcFormula = lookup("HR Employees"."Full Name" where("No." = field("Employee No.")));
            Editable = false;
        }
        field(4; "Notification Type"; Option)
        {
            Caption = 'Notification Type';
            OptionMembers = "Contract Expiry","Retirement";
            OptionCaption = 'Contract Expiry,Retirement';
        }
        field(5; "Warning Date"; Date)
        {
            Caption = 'Warning Date';
        }
        field(6; "Notification Sent Date"; DateTime)
        {
            Caption = 'Notification Sent Date';
        }
        field(7; "Recipient Email"; Text[250])
        {
            Caption = 'Recipient Email';
        }
        field(8; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Pending,Sent,Failed;
            OptionCaption = 'Pending,Sent,Failed';
        }
        field(9; "Error Message"; Text[250])
        {
            Caption = 'Error Message';
        }
        field(10; "Days/Months Remaining"; Integer)
        {
            Caption = 'Days/Months Remaining';
        }
        field(11; "Employee Department"; Code[20])
        {
            Caption = 'Employee Department';
        }
        field(12; "Employee Position"; Text[100])
        {
            Caption = 'Employee Position';
        }
        field(13; "Contract End Date"; Date)
        {
            Caption = 'Contract End Date';
        }
        field(14; "Retirement Date"; Date)
        {
            Caption = 'Retirement Date';
        }
        field(15; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(16; "Created Date Time"; DateTime)
        {
            Caption = 'Created Date Time';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Employee No.", "Notification Type", "Warning Date")
        {
        }
        key(Key3; "Notification Sent Date")
        {
        }
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created Date Time" := CurrentDateTime;
    end;
}
