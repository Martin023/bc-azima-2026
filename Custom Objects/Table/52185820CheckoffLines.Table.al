table 52185820 "Checkoff Lines"
{
    DrillDownPageID = "Checkoff Lines";
    LookupPageID = "Checkoff Lines";

    fields
    {
        field(1; "Entry No"; Integer)
        {
        }
        field(2; "Checkoff Header"; Code[20])
        {
        }
        field(3; "Member No."; Code[20])
        {
            TableRelation = Members."No.";
            trigger OnValidate()
            begin
                Member.reset;
                Member.SetRange("No.", rec."Member No.");
                if Member.find('-') then begin
                    name := Member.Name;
                end;
            end;
        }
        field(4; "Account No."; Code[20])
        {
        }
        field(5; "Payroll No."; Code[20])
        {
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; "Loan No."; Code[20])
        {
        }
        field(8; Multiple; Boolean)
        {
        }
        field(9; "Credit Account"; Boolean)
        {
        }
        field(10; Name; Text[50])
        {
        }
        field(11; "Savings Account"; Boolean)
        {
        }
        field(12; "ID Number"; Code[11])
        {
        }
        field(13; Posted; Boolean)
        {
        }
        field(14; Type; Option)
        {
            OptionCaption = ' ,sInterest,sLoan,sShare,wCont,sJoining,Investment,wLoan';
            OptionMembers = " ",sInterest,sLoan,sShare,wCont,sJoining,Investment,wLoan;
        }
        field(15; "Employer Code"; Code[100])
        {
            CalcFormula = Lookup(Members."Employer Code" where("No." = field("Member No.")));
            FieldClass = FlowField;
        }
        field(16; "Clears Loan"; Boolean)
        {
            Editable = false;
        }
        field(17; "Refundable Amount"; Decimal)
        {
            Editable = false;
        }
        field(22; Remarks; Text[50])
        {
        }
        field(23; "Product Code"; Code[20])
        {
        }
        field(24; "Customer No."; Code[20])
        {
            CalcFormula = Lookup("Checkoff Header"."Account No." WHERE("No." = FIELD("Checkoff Header")));
            FieldClass = FlowField;
        }
        // field(25; "Transaction Type"; Enum "Transaction Types")
        // {
        // }
        field(25; "Loan Underpayment amount"; Decimal)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Entry No", "Checkoff Header")
        {
            Clustered = true;
        }
        key(Key2; "Checkoff Header", Posted)
        {

        }
        key(Key3; "Checkoff Header", "Member No.", Multiple)
        { }
    }

    fieldgroups
    {
    }
    var
        Member: record Members;
}

