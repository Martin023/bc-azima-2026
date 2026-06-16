table 52185773 "Transaction Types"
{
    LookupPageID = "Transaction Types SetUp";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; Type; Enum "Fosa Transaction Types")
        {
            // OptionCaption = 'Cash Deposit,Cash Withdrawal,Credit Receipt,Credit Cheque,Bankers Cheque,Cheque Deposit,Cheque Withdrawal,Salary Processing,EFT,RTGS,Overdraft,Standing Order,Dividend,Dividends Capt. Incentives,MPESA Deposit,MPESA Withdrawal,Account Activate,Failed STO Fee,Account Closure,Share Capital Transfer,Board Salary,Transfers,ATM Applications,Member Withdrawal,ATM Replacement,Statement,Bounced Cheque,Lien,Cheque Application,Bank Transfer Mode,Sacco_Bank Cheques,Savings Penalty,Delegates Payment,Delegates Special,BBF Payment,Cancel Bankers Cheque,Sky Mobile,Loan Reschedule,Moratorium fee,Loan Restructure';
            // OptionMembers = "Cash Deposit","Cash Withdrawal","Credit Receipt","Credit Cheque","Bankers Cheque","Cheque Deposit","Cheque Withdrawal","Salary Processing",EFT,RTGS,Overdraft,"Standing Order",Dividend,"Dividends Capt. Incentives","MPESA Deposit","MPESA Withdrawal","Account Activate","Failed STO Fee","Account Closure","Share Capital Transfer","Board Salary",Transfers,"ATM Applications","Member Withdrawal","ATM Replacement",Statement,"Bounced Cheque",Lien,"Cheque Application","Bank Transfer Mode","Sacco_Bank Cheques","Savings Penalty","Delegates Payment","Delegates Special","BBF Payment","Cancel Bankers Cheque","Sky Mobile",LoanTransfer,"Loan Reschedule","Moratorium fee","Loan Restructure";
        }
        field(4; "Product Type"; Code[20])
        {
            TableRelation = "Product Factory"."Product ID" WHERE("Product Class Type" = CONST(Savings));

            trigger OnValidate()
            var
                ProductFactory: Record "Product Factory";
            begin
                if ProductFactory.Get("Product Type") then
                    "Product Name" := ProductFactory."Product Description";
            end;
        }
        field(5; "Default Mode"; Option)
        {
            OptionCaption = 'Cash,Cheque';
            OptionMembers = Cash,Cheque;
        }
        field(12; "Requires Finger Verification"; Boolean)
        {
        }
        field(13; "Product Name"; Text[50])
        {
            Editable = false;
        }
        field(14; "Upper Limit"; Decimal)
        {
        }
        field(15; Category; Option)
        {
            OptionCaption = ' ,Cashier';
            OptionMembers = " ",Cashier;
        }
        field(16; "Exclude Salary Deductions"; Boolean)
        {
        }
        field(17; "Sal. Deposit Deduction"; Decimal)
        {
            MinValue = 0;
            MaxValue = 100000;
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

