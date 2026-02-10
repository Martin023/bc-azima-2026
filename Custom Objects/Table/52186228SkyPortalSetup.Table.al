table 52186228 "Sky Portal Setup"
{

    fields
    {
        field(1; "Code"; Code[30])
        {
        }
        field(2; "Vendor Commission Account"; Code[20])
        {
            TableRelation = Vendor;
        }
        field(3; "Sacco Fee Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(4; "Bank Account"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(5; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Mpesa Withdrawal,Mpesa Deposit,Utility Payment,Loan Repayment,Balance Enquiry,Mini-Statement,Loan Disbursement,Account Transfer,Pay Loan From Account,Paybill,Mobile App Login,Pesalink Transfer,Airtime,Bank Deposit,Bank Agent Deposit,Bank Transfer,Agent Withdrawal,Check Beneficiary,Pin Reset';
            OptionMembers = " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account",Paybill,"Mobile App Login","Pesalink Transfer",Airtime,"Bank Deposit","Bank Agent Deposit","Bank Transfer","Agent Withdrawal","Check Beneficiary","Pin Reset";
        }
        field(6; "Vendor Commission"; Decimal)
        {
        }
        field(7; "Sacco Fee"; Decimal)
        {
        }
        field(8; "Safaricom Account"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(9; "Safaricom Fee"; Decimal)
        {
        }
        field(10; "Pre-Payment Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(11; "SMS Charge"; Decimal)
        {
        }
        field(12; "SMS Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(13; "Transaction Limit"; Decimal)
        {

            trigger OnLookup()
            begin
                if "Transaction Limit" > 0 then begin
                    if ("Transaction Type" <> "Transaction Type"::"Mpesa Withdrawal") and ("Transaction Type" <> "Transaction Type"::"Utility Payment") then
                        Error('This option is not applicable for this transaction');
                end;
            end;
        }
        field(14; "Non-Member Debit Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(15; "Daily Limit"; Decimal)
        {
        }
        field(16; "Weekly Limit"; Decimal)
        {
        }
        field(17; "Monthly Limit"; Decimal)
        {
        }
        field(19; "Charge Type"; Option)
        {
            OptionMembers = "Fixed",Percentage,Staggered;
        }
        field(20; "Restrict to Employer"; Code[20])
        {
            TableRelation = Customer WHERE("Account Type" = CONST(Employer));
        }
        field(21; "Charge Agents"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

