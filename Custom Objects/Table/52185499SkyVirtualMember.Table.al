table 52185499 "Sky Virtual Member"
{
    DrillDownPageId = "Created Sky Virtual Member";
    LookupPageId = "Created Sky Virtual Member";

    fields
    {
        field(1; "Entry No"; Integer)
        {
        }
        field(2; Telephone; Text[13])
        {
        }
        field(3; Names; Text[50])
        {
        }
        field(4; "Date Of Birth"; Date)
        {
        }
        field(5; Gender; Option)
        {
            OptionCaption = '  ,Male,Female';
            OptionMembers = "  ",Male,Female;
        }
        field(6; Citizenship; Text[30])
        {
        }
        field(7; "Entry Date"; Date)
        {
        }
        field(8; "Entry Time"; Time)
        {
        }
        field(9; "Reffered By"; Code[20])
        {
        }
        field(10; "Employer Name"; Text[50])
        {
        }
        field(11; "Payroll Number"; Code[30])
        {
        }
        field(12; Validated; Boolean)
        {
        }
        field(13; "Sent To Application"; Boolean)
        {
        }
        field(14; "ID Number"; Code[30])
        {
        }
        field(15; "Employer Code"; Code[10])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if Customer.Get("Employer Code") then
                    "Employer Name" := Customer.Name;
            end;
        }
        field(16; "Actioned By"; Code[50])
        {
        }
        field(17; Email; Text[30])
        {
        }
        field(18; "Session ID"; Code[50])
        {
        }
        field(19; "Service Number"; Text[30])
        {
        }
        field(20; Employer; Text[50])
        {
        }
        field(21; "Referer Member No"; Code[30])
        {
            TableRelation = Members;
        }
        field(22; "Name on IPRS"; Code[100])
        {
        }
        field(23; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Open,Pending,Approved,Rejected,Created';
            OptionMembers = Open,Pending,Approved,Rejected,Created;
        }
        field(24; "No. Series"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(25; "No."; Code[50])
        {
        }
        field(26; Address; Text[250])
        {
        }
        field(27; "Passport Number"; Code[30])
        {
        }
        field(28; "Source Application"; Option)
        {
            OptionMembers = USSD,"Members Portal","Mobile App";
        }
        field(29; "Pushed by Member No"; Code[20])
        {
            TableRelation = Members."No.";
        }
        field(30; "Pushed by Name"; Text[100])
        {
            CalcFormula = Lookup(Members.Name WHERE("No." = FIELD("Pushed by Member No")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Entry No", "No.")
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
            // NosMngtSet.InitSeries('M_PAPP', xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        Customer: Record Customer;
        SaleSetp: Record "Sales & Receivables Setup";
        NosMngtSet: Codeunit NoSeriesManagement;
        "No. Series": Record Customer;
}

