table 52185481 "Sky Mobile Loan Appraisal"
{

    fields
    {
        field(1; "Account No."; Code[20])
        {
        }
        field(2; Name; Text[200])
        {
        }
        field(3; "Member No."; Code[20])
        {
        }
        field(4; "Phone No."; Code[20])
        {
        }
        field(5; "ID No."; Code[20])
        {
        }
        field(6; Email; Text[100])
        {
        }
        field(7; "Account Balance"; Decimal)
        {
        }
        field(8; MBoosta; Decimal)
        {
        }
        field(9; "MBoosta Msg"; Text[200])
        {
        }
        field(10; "Salary In Advance"; Decimal)
        {
        }
        field(11; "Salary In Advance Msg"; Text[200])
        {
        }
        field(12; "Finje Chap Chap"; Decimal)
        {
        }
        field(13; "Finje Chap Chap Msg"; Text[200])
        {
        }
        field(14; "Jisort Advance"; Decimal)
        {
        }
        field(15; "Jisort Advance Msg"; Text[200])
        {
        }
        field(16; "Salary Advance"; Decimal)
        {
        }
        field(17; "Salary Advance Msg"; Text[200])
        {
        }
        field(50050; "User ID"; Code[50])
        {
        }
        field(50051; "As At"; Date)
        {
        }
        field(50052; "Date-Time"; DateTime)
        {
        }
        field(50053; "Salary 1"; Decimal)
        {
        }
        field(50054; "Salary Date 1"; Date)
        {
        }
        field(50055; "Salary 2"; Decimal)
        {
        }
        field(50056; "Salary Date 2"; Date)
        {
        }
        field(50057; "Salary 3"; Decimal)
        {
        }
        field(50058; "Salary Date 3"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Account No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

