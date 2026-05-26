table 52185452 "E-Channels Cue Table"
{
    Caption = 'E-Channels Cue Table';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "M-Banking Registered Users"; Integer)
        {
            Caption = 'Mbanking Registered Users';
            FieldClass = Flowfield;
            CalcFormula = Count("Savings Accounts" WHERE("Transactional Mobile No" = FILTER(<> '')));

        }
        field(3; "M-BankingAppsPendingApproval"; Integer)
        {
            Caption = 'MBanking Applications';
            FieldClass = Flowfield;
            CalcFormula = Count("M-SACCO Applications" WHERE(Status = Filter(Pending)));
        }
        field(4; "Posted Mobile Transactions"; Integer)
        {
            Caption = 'Posted Mobile Transactions';
            FieldClass = Flowfield;
            CalcFormula = Count("Sky M-Banking Trans. Buffer" WHERE(Posted = FILTER(True)));
        }
        field(40; "Pending Mobile Transactions"; Integer)
        {
            Caption = 'Pending Mobile Transactions';
            FieldClass = Flowfield;
            CalcFormula = Count("Sky M-Banking Trans. Buffer" WHERE(Posted = FILTER(False)));
        }
        field(5; "Disbursed Mobile Loans"; Decimal)
        {
            Caption = 'Disbursed Mobile Loans';
            FieldClass = Flowfield;
            // CalcFormula = sum("Sky Mobile Loans"."Approved Amount" WHERE(Posted = FILTER(True)));
            CalcFormula = sum("Mobile loan App. Buffer"."Approved Amount" WHERE(Posted = FILTER(True), Deactivated = FILTER(false)));

        }
        field(22; "Msacco Loan Application List"; Integer)
        {
            Caption = ' Mobile Loans';
            FieldClass = Flowfield;
            CalcFormula = Count(Loans WHERE(Posted = CONST(false), "Dummy Appraisal" = FILTER(False), "Picked Mobile Loan" = FILTER(True), Status = FILTER(Open)));
        }
        field(6; "Created Virtual Members"; Integer)
        {
            Caption = 'Created Virtual Members';
            FieldClass = Flowfield;
            CalcFormula = Count("Sky Virtual Member" WHERE(Validated = CONST(true),
                            "Sent To Application" = CONST(true),
                            "Source Application" = CONST(USSD),
                            Status = CONST(Approved)));
        }
        field(7; "Business Accounts"; Integer)
        {
            Caption = 'Business Accounts';
            FieldClass = Flowfield;
            CalcFormula = Count("Sky Business Accounts");
        }
        field(8; "Mortagage Requisitions"; Integer)
        {
            Caption = 'Mortagage Requisitions';
            FieldClass = Flowfield;
            CalcFormula = Count("Sky Mortgage");
        }
        field(9; "Actioned Morgage"; Integer)
        {
            Caption = 'Actioned Morgage';
            FieldClass = Flowfield;
            CalcFormula = Count("Sky Mortgage" WHERE(Actioned = FILTER(True)));
        }
        field(10; "Insurance Requisition"; Integer)
        {
            Caption = 'Insurance Requisition ';
            FieldClass = Flowfield;
            CalcFormula = Count("Sky Insurance");
        }
        field(11; "Insurance Actioned"; Integer)
        {
            Caption = 'Insurance Actioned';
            FieldClass = Flowfield;
            CalcFormula = Count("Sky Insurance" WHERE("Actioned" = FILTER(TRUE)));
        }
        
        // field(14; "Web Portal Users"; Integer)
        // {
        //     Caption = 'Web Portal Users';
        //     FieldClass = Flowfield;
        //     CalcFormula = Count("Sky Portal Users." WHERE(Blocked = FILTER(FALSE)));
        // }
        field(15; "Checkoff Advice"; Integer)
        {
            Caption = 'Checkoff Advice';
            FieldClass = Flowfield;
            CalcFormula = Count("Checkoff Advice Line" WHERE("Captured  By" = CONST('WEBPORTAL')));
        }
        field(16; "PESA Agents"; Integer)
        {
            Caption = 'PESA Agents';
            FieldClass = Flowfield;
            CalcFormula = Count("Agent Applications" WHERE("Approval Status" = FILTER(Approved)));
        }
        field(17; "PESA  Agent Transactions"; Integer)
        {
            Caption = 'PESA  Agent Transactions';
            FieldClass = Flowfield;
            CalcFormula = Count("Sky Agents Transactions");
        }
        field(18; "PESA  Agent Withdrawals"; Integer)
        {
            Caption = 'PESA  Agent Withdrawals';
            FieldClass = Flowfield;
            CalcFormula = Count("Sky Agent Withdrawals Buffer" WHERE(Posted = FILTER(True)));
        }
        field(19; "Internet Banking Users"; Integer)
        {
            Caption = 'Active Internet Banking Users';
            FieldClass = Flowfield;
            CalcFormula = Count("Online Users" WHERE(Blocked = FILTER(FALSE)));
        }
        // field(20; "Online Loans"; Integer)
        // {
        //     Caption = 'Online Loans Applications';
        //     FieldClass = Flowfield;
        //     // CalcFormula = Count("Online Loans Applications");
        // }
        field(21; "Internet Banking Transactions"; Integer)
        {
            Caption = 'Internet Banking Transactions';
            FieldClass = Flowfield;
            CalcFormula = Count("Online Transactions" WHERE(Posted = FILTER(True)));
        }
        field(23; "Posted ATM Transactions"; Integer)
        {
            Caption = 'Posted ATM Transactions';
            FieldClass = Flowfield;
            CalcFormula = Count("Sky ATM Transactions Buffer" WHERE(Posted = FILTER(True)));
        }
        field(230; "Pending ATM Transactions"; Integer)
        {
            Caption = 'Pending ATM Transactions';
            FieldClass = Flowfield;
            CalcFormula = Count("Sky ATM Transactions Buffer" WHERE(Posted = FILTER(False)));
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
