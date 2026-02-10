table 52185475 "Sky Safcom Corporate Charges"
{

    fields
    {
        field(2; Minimum; Decimal)
        {
        }
        field(3; Maximum; Decimal)
        {
        }
        field(4; Charge; Decimal)
        {
        }
        field(5; Category; Option)
        {
            OptionMembers = Safaricom,Bank;
        }
        field(6; "Transaction Type"; Option)
        {
            OptionMembers = " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account",Paybill,"Mobile App Login","Pesalink Transfer",Airtime,"Bank Deposit","Bank Agent Deposit","Bank Transfer","Agent Withdrawal","Check Beneficiary","Pin Reset";
        }
    }

    keys
    {
        key(Key1; Minimum, Category, "Transaction Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

