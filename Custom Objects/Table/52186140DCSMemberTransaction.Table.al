table 52186140 "DCS Member Transaction"
{

    fields
    {
        field(1; "Member No"; Code[20])
        {
        }
        field(2; "Last Update"; DateTime)
        {
        }
        field(3; "Gross Salary"; Decimal)
        {
        }
        field(4; Earnings; Decimal)
        {
        }
        field(5; Deductions; Decimal)
        {
        }
        field(6; "Net Pay"; Decimal)
        {
        }
        field(7; "Loan Balance"; Decimal)
        {
        }
        field(8; "Expected Loan Repayment"; Decimal)
        {
            CalcFormula = Sum("DCS Loan Summary"."Expected Repayment" WHERE("Account No" = FIELD("Member No")));
            FieldClass = FlowField;
        }
        field(9; "Last Repayment Date"; Date)
        {
        }
        field(10; "Total Loan Repayments"; Decimal)
        {
            CalcFormula = Sum("DCS Loan Summary"."Total Paid" WHERE("Account No" = FIELD("Member No")));
            FieldClass = FlowField;
        }
        field(11; "Number of Active Loans"; Decimal)
        {
        }
        field(12; "Date of Join"; Date)
        {
            Description = 'Date of joining sacco';
        }
        field(13; Loan; Decimal)
        {
        }
        field(14; "Default Status"; Option)
        {
            OptionCaption = ' ,Watch,Doubtfull,Substandard,Default';
            OptionMembers = " ",Watch,Doubtfull,Substandard,Default;
        }
        field(15; "Standing Orders"; Decimal)
        {
        }
        field(16; "Direct Debits"; Decimal)
        {
        }
        field(17; "Deposits Contribution"; Decimal)
        {
        }
        field(18; "Loan Repayment Frequency"; Integer)
        {
        }
        field(19; "Loans Borrowing History"; Integer)
        {
        }
        field(20; "Deposit Guaranteed"; Decimal)
        {
        }
        field(21; "Share Capital"; Decimal)
        {
        }
        field(22; Basic; Decimal)
        {
        }
        field(23; "Other Income"; Decimal)
        {
        }
        field(24; "Qualified Amount"; Decimal)
        {
        }
        field(25; Bridge; Decimal)
        {
        }
        field(26; "Pressent VAF"; Decimal)
        {
        }
        field(27; Installments; Decimal)
        {
        }
        field(28; "Loan Security"; Decimal)
        {
        }
        field(29; "Interest Rate"; Decimal)
        {
        }
        field(30; "Requested Amount"; Decimal)
        {
        }
        field(101; Defaulter; Boolean)
        {
        }
        field(102; "Has FOSA Committments"; Boolean)
        {
        }
        field(103; "Salary Channelled Internally"; Boolean)
        {
        }
        field(106; "No. of Active Loans"; Integer)
        {
        }
        field(107; "Last Deposit Date"; Date)
        {
        }
        field(108; "MSACCO Trans Ferquency"; Integer)
        {
        }
        field(109; "MSACCO Last Trans Date"; Date)
        {
        }
        field(110; "Long Term Repayments"; Decimal)
        {
        }
        field(111; "Short Term Repayments"; Decimal)
        {
        }
        field(112; "Loan Span"; Option)
        {
            OptionCaption = ' ,Short Term,Long Term';
            OptionMembers = " ","Short Term","Long Term";
        }
    }

    keys
    {
        key(Key1; "Member No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Last Update" := CurrentDateTime;
    end;

    trigger OnModify()
    begin
        "Last Update" := CurrentDateTime;
        StartDate := CalcDate('-4M', Today);
        Vend.Reset;
        //Vend.SETRANGE("BOSA Account No","Member No");
        if Vend.FindFirst then begin
            TransSumm.Reset;
            TransSumm.SetRange("Account No", Vend."No.");
            TransSumm.SetRange("Posting Date", StartDate, Today);
            TransSumm.CalcSums(Amount);
            "Net Pay" := (TransSumm.Amount / 4) * -1;
            Validate("Net Pay");
        end;
    end;

    var
        TransSumm: Record "Account Trans Summary";
        Vend: Record Vendor;
        StartDate: Date;
}

