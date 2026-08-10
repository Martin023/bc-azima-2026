#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185496 "Counter Summary Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/CounterSummaryReport.rdl';

    dataset
    {
        dataitem(Treasury_transaction; "Cashier Transactions")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Transaction Date";

            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Address; CompanyAddress) { }
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

            dataitem(TransLines; Integer)
            {
                DataItemTableView = sorting(Number) where(Number = filter(1 .. 2));

                // column(RowNo; RowNo) { } //- numbering is now handled in RDLC
                column(GroupDetails; GroupDetails) { }
                column(TransType; TransType) { }
                column(UserName; Treasury_transaction.Cashier) { }
                column(TrxDate; TrxDate) { }
                column(TrxTime; TrxTime) { }
                column(Amount; LineAmount) { }
                column(DebitAmt; LineDebitAmt) { }
                column(CreditAmt; LineCreditAmt) { }

                trigger OnAfterGetRecord()
                begin
                    if Number = 1 then begin
                        if not Treasury_transaction.Posted then
                            CurrReport.Skip();
                        if Treasury_transaction."Transaction Description" <> '' then
                            GroupDetails := Treasury_transaction."Transaction Description"
                        else
                            GroupDetails := Format(Treasury_transaction.Type);

                        TransType := Format(Treasury_transaction.Type);
                        TrxDate := Format(Treasury_transaction."Transaction Date", 0, '<Day,2>/<Month,2>/<Year4>');
                        TrxTime := Format(Treasury_transaction."Transaction Time", 0, '<Hours24,2>:<Minutes,2>:<Seconds,2>');
                        LineAmount := Treasury_transaction.Amount;
                        
                        LineDebitAmt := 0;
                        LineCreditAmt := 0;
                        
                        //if Treasury_transaction.Type in[Treasury_transaction.Type::"Cash Withdrawal", Treasury_transaction.Type::"MPESA Withdrawal", Treasury_transaction.Type::"Cheque Withdrawal", Treasury_transaction.Type::"Bankers Cheque"] then
                        if Treasury_transaction.Type in[Treasury_transaction.Type::"Cash Withdrawal"] then
                            LineDebitAmt := Treasury_transaction.Amount
                        else
                            LineCreditAmt := Treasury_transaction.Amount;

                    end else if Number = 2 then begin
                        if not Treasury_transaction.Posted then
                            CurrReport.Skip();
                        if Treasury_transaction.Type <> Treasury_transaction.Type::"Cash Withdrawal" then
                            CurrReport.Skip();
                        if Treasury_transaction."Charge Amount" <= 0 then
                            CurrReport.Skip();

                        GroupDetails := 'Withdrawal Charges';
                        TransType := 'Charge';
                        TrxDate := Format(Treasury_transaction."Transaction Date", 0, '<Day,2>/<Month,2>/<Year4>');
                        TrxTime := Format(Treasury_transaction."Transaction Time", 0, '<Hours24,2>:<Minutes,2>:<Seconds,2>');
                        
                        LineAmount := Treasury_transaction."Charge Amount";
                        LineDebitAmt := 0;
                        LineCreditAmt := Treasury_transaction."Charge Amount";
                    end;
                    if GroupFilter <> '' then begin
                        if StrPos(UpperCase(GroupDetails), UpperCase(GroupFilter)) = 0 then
                            CurrReport.Skip();
                    end;

                    // Increment row number only after verifying the record is valid to print
                    // RowNo += 1; // numbering is now handled in RDLC
                end;
            }

            trigger OnPreDataItem()
            begin
                if CashierCode <> '' then
                    Treasury_transaction.SetRange(Cashier, CashierCode);

                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);

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
        layout
        {
            area(content)
            {
                group(Filters)
                {
                    Caption = 'Custom Filters';
                    
                    field(CashierCode; CashierCode)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cashier';
                        TableRelation = "User Setup"."User ID";
                        ToolTip = 'Select the cashier from the dropdown list.';
                    }
                    field(GroupFilter; GroupFilter)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Grouping Filter';
                        ToolTip = 'Type a keyword to filter by group (e.g. "Cash Withdrawal", "Deposit", "Withdrawal Charges"). Leave blank for all.';
                    }
                }
            }
        }
        actions { }
    }

    trigger OnPreReport()
    begin
        PrintingDate := Format(Today, 0, '<Day,2>/<Month,2>/<Year4>');
        PrintingTime := Format(Time);
        PrintedBy := UserId;
    end;

    var
        CompanyInfo: Record "Company Information";
        CompanyAddress: Text;
        DateFilterTxt: Text;
        
        CompanyName: Text;
        BuldingName: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;
        PrintingDate: Text;
        PrintingTime: Text;
        PrintedBy: Text;

        GroupDetails: Text;
        TransType: Text;
        TrxDate: Text;
        TrxTime: Text;
        LineAmount: Decimal;
        LineDebitAmt: Decimal;
        LineCreditAmt: Decimal;
        CashierCode: Code[50];
        GroupFilter: Text;
        // RowNo: Integer; // numbering is now handled in RDLC
}