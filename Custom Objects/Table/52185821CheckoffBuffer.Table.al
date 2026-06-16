table 52185821 "Checkoff Buffer"
{

    fields
    {
        field(1; No; Integer)
        {
        }
        field(2; Name; Text[50])
        {
        }
        field(3; Payroll; Code[20])
        {
        }
        field(4; "Account No"; Code[20])
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                // if SavingsAcc.get(Rec."Account No") then begin
                //     if Members.Get((SavingsAcc."Member No.")) then begin
                //         if Members."Member Class" = 'B' then begin
                //             Members."Member Class" := 'A';
                //             members.Modify;
                //         end;
                //     end;
                // end;
            end;

        }
        field(5; "Loan No"; Code[20])
        {
        }
        field(6; Type; Option)
        {
            OptionCaption = ' ,sInterest,sLoan,sShare,wCont,sJoining,Investment,wLoan';
            OptionMembers = " ",sInterest,sLoan,sShare,wCont,sJoining,Investment,wLoan;
        }
        field(7; Amount; Decimal)
        {
        }
        field(8; Interest; Decimal)
        {
        }
        field(9; "Search Code"; Code[20])
        {
        }
        field(10; "Checkoff No"; Code[10])
        {
        }
        field(11; "Employer Code"; Code[20])
        {
            TableRelation = Customer;
        }
        field(12; "Member No."; Code[20])
        {
        }
        field(13; "Savings Account"; Boolean)
        {
        }
        field(14; "Credit Account"; Boolean)
        {
        }
        field(15; "ID No."; Code[20])
        {
        }
        field(16; "Upload Response"; Integer)
        {
            Editable = false;
        }
        field(17; "Upload No."; Code[20])
        {
        }
        field(18; "Record Found"; Boolean)
        {
            Editable = false;
        }
        field(19; "User Id"; Code[40])
        {
        }
        field(20; Balance; Decimal)
        {
        }

        field(21; "Product Code"; Code[20])
        {
        }

        field(22; Remarks; Text[50])
        {
        }
        field(23; "Other Comments"; Text[50])
        {
        }
        field(40; Status; Enum "Savings Account Status")
        {
            Caption = 'Member Status';
            // OptionCaption = ' ,New,Active,Dormant,Frozen,Withdrawal Application,Withdrawn,Deceased,Defaulter,Closed';
            // OptionMembers = " ",New,Active,Dormant,Frozen,"Withdrawal Application",Withdrawn,Deceased,Defaulter,Closed;
        }
    }

    keys
    {
        key(Key1; No, "Checkoff No")
        {
            Clustered = true;
        }
        key(key2; "Checkoff No", "Upload No.")
        {

        }
        key(key3; "Checkoff No", No, "Member No.")
        { }
    }

    fieldgroups
    {
    }

    var
        Txt00001: Label 'You cannot delete processed buffer';
        SavingsAcc: Record "Savings Accounts";
        Members: Record Members;
}

