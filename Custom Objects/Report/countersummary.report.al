#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185496 "Counter Summary Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/CounterSummaryReport.rdl';

    dataset
    {
        dataitem(Treasury_transaction; "Cashier Transactions")
        {
            RequestFilterFields = "Transaction Date", Cashier;

            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Address; CompanyAddress) { }
            
            // NEWLY ADDED COLUMNS FOR THE EOD-STYLE HEADER
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(CompanyName; CompanyName) { }
            column(BuldingName; BuldingName) { }
            column(CompanyTelephone; CompanyTelephone) { }
            column(CompanyEmail; CompanyEmail) { }
            column(PrintingDate; PrintingDate) { }
            column(PrintingTime; PrintingTime) { }
            column(PrintedBy; PrintedBy) { }

            column(DateFilterTxt; DateFilterTxt) { }
            column(PrintDateTime; Format(CurrentDateTime, 0, '<Day,2>/<Month,2>/<Year4> <Hours24,2>:<Minutes,2>')) { }
            
            column(GroupDetails; GroupDetails) { }
            column(TransType; Format(Type)) { }
            column(UserName; Cashier) { }
            column(TrxDate; Format("Transaction Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(TrxTime; Format("Transaction Time", 0, '<Hours24,2>:<Minutes,2>:<Seconds,2>')) { }
            column(Amount; Amount) { }
            column(DebitAmt; DebitAmt) { }
            column(CreditAmt; CreditAmt) { }

            trigger OnAfterGetRecord()
            begin
                // DETERMINE GROUPING DETAILS FROM TRANSACTION
                if "Transaction Description" <> '' then
                    GroupDetails := "Transaction Description"
                else
                    GroupDetails := Format(Type);

                // ALLOCATE DEBIT AND CREDIT COLUMNS BASED ON TRANSACTION NATURE
                DebitAmt := 0;
                CreditAmt := 0;
                
                if Type in[Type::"Cash Withdrawal", Type::"MPESA Withdrawal", Type::"Cheque Withdrawal", Type::"Bankers Cheque"] then
                    DebitAmt := Amount
                else
                    CreditAmt := Amount;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);

                // POPULATING THE NEW HEADER VARIABLES
                CompanyName := CompanyInfo.Name;
                BuldingName := CompanyInfo."Building Name";
                CompanyAddress := CompanyInfo.Address + ' -Post Code: ' + CompanyInfo."Post Code" + ' -City:' + CompanyInfo.City + ' Region: ' + CompanyInfo."Country/Region Code";
                CompanyTelephone := CompanyInfo."Phone No." + ',' + CompanyInfo."Phone No. 2";
                CompanyEmail := CompanyInfo."E-Mail";

                if GetFilter("Transaction Date") <> '' then
                    DateFilterTxt := GetFilter("Transaction Date")
                else
                    DateFilterTxt := Format(Today, 0, '<Day,2>/<Month,2>/<Year4>');
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout { }
        actions { }
    }

    trigger OnPreReport()
    begin
        // CAPTURING PRINT DETAILS
        PrintingDate := Format(Today, 0, '<Day,2>/<Month,2>/<Year4>');
        PrintingTime := Format(Time);
        PrintedBy := UserId;
    end;

    var
        CompanyInfo: Record "Company Information";
        CompanyAddress: Text;
        DateFilterTxt: Text;
        GroupDetails: Text;
        DebitAmt: Decimal;
        CreditAmt: Decimal;
        
        // ADDED VARIABLES FOR THE HEADER
        CompanyName: Text;
        BuldingName: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;
        PrintingDate: Text;
        PrintingTime: Text;
        PrintedBy: Text;
}