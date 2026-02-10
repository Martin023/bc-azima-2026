table 52185761 "M-SACCO Loans"
{

    fields
    {
        field(1; "Entry no"; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Account No"; Text[30])
        {
            Editable = true;
        }
        field(3; Date; DateTime)
        {
        }
        field(4; "Requested Amount"; Decimal)
        {
            Editable = true;
        }
        field(5; Posted; Boolean)
        {
            Editable = true;
        }
        field(6; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Pending,Successful,Failed,Appraisal';
            OptionMembers = Pending,Successful,Failed,Appraisal;
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
            Editable = true;
        }
        field(10; "Latest Salary Amount"; Decimal)
        {
            Editable = true;
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
        field(16; "Loan Product Type"; Option)
        {
            OptionCaption = 'Salary Advance,Instant Loan,Other Loans,Salary In Advance,Dividend Loan,Emergency Loan,School Fees Loan';
            OptionMembers = "Salary Advance","Instant Loan","Other Loans","Salary In Advance","Dividend Loan","Emergency Loan","School Fees Loan";
        }
        field(17; Amount; Decimal)
        {
        }
        field(18; "Loan Code"; Code[10])
        {
        }
        field(19; Installment; Decimal)
        {
        }
        field(20; "Loan Purpose"; Code[20])
        {
        }
        field(21; "Loan No"; Code[20])
        {
        }
        field(22; "Ghris Password"; Text[30])
        {
        }
        field(23; Branch; Text[30])
        {

            trigger OnValidate()
            begin
                if Branch = '1' then
                    Branch := 'Nairobi'
                else
                    if Branch = '2' then
                        Branch := 'Nakuru'
                    else
                        if Branch = '3' then
                            Branch := 'Eldoret'
                        else
                            if Branch = '4' then
                                Branch := 'Kisumu'
                            else
                                if Branch = '5' then
                                    Branch := 'Mombasa'
                                else
                                    if Branch = '6' then
                                        Branch := 'Nanyuki';
            end;
        }
    }

    keys
    {
        key(Key1; "Entry no")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //ERROR('Deletion not allowed');
    end;

    trigger OnModify()
    begin
        //ERROR('Modification not allowed');
    end;
}

