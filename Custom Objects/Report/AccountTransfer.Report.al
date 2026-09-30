#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185571 "Account Transfer"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/AccountTransfer.Report.rdl';
    Caption = 'Account Transfer Summary';

    dataset
    {
        dataitem(TransferHeader; "Account Transfer Header")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Transaction Date", No, Posted;

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
            column(HeaderCreatedBy; TransferHeader."Created By") { }
            column(ReportTitle; ReportTitleTxt) { }

            dataitem(TransLines; Integer)
            {
                DataItemTableView = sorting(Number) where(Number = filter(1 .. 2));

                column(GroupDetails; GroupDetails) { }
                column(TransType; TransType) { }
                column(TrxDate; TrxDate) { }
                column(TrxTime; TrxTime) { }
                column(Amount; LineAmount) { }
                column(DebitAmt; LineDebitAmt) { }
                column(CreditAmt; LineCreditAmt) { }

                trigger OnAfterGetRecord()
                begin
                    if Number = 1 then begin
                        // ------ 1. DEBIT/SOURCE LINES ------
                        if TransferHeader."Total Debits" = 0 then
                            CurrReport.Skip();

                        TransferSource.Reset();
                        TransferSource.SetRange("No.", TransferHeader.No);
                        TransferSource.SetFilter("Source Amount", '>0'); // Ignore 0.00 lines
                        
                        if TransferSource.FindSet() then begin
                            if TransferSource.Count = 1 then begin
                                // SINGLE SOURCE ACCOUNT
                                GroupDetails := 'ACCOUNT TRANSFER FROM - ' + TransferSource."Source Account No." + ': ' + TransferSource."Product Name" + 
                                                ' - ' + Format(TransferHeader."Transfer Type") + ' Transfer Out (From: ' + TransferSource."Source Account Name" + ')';
                            end else begin
                                // MULTIPLE SOURCE ACCOUNTS
                                AccountList := '';
                                repeat
                                    if AccountList = '' then
                                        AccountList := TransferSource."Source Account No."
                                    else
                                        AccountList += ', ' + TransferSource."Source Account No.";
                                until TransferSource.Next() = 0;

                                // Reset back to first to grab the primary name
                                TransferSource.FindFirst();
                                GroupDetails := 'ACCOUNT TRANSFER FROM - Multiple Accounts (' + AccountList + ') - ' + 
                                                Format(TransferHeader."Transfer Type") + ' Transfer Out (From: ' + TransferSource."Source Account Name" + '...)';
                            end;
                        end else begin
                            GroupDetails := 'ACCOUNT TRANSFER FROM - ' + Format(TransferHeader."Transfer Type") + ' Transfer Out';
                        end;

                        TransType := 'Transfer Out';
                        TrxDate := Format(TransferHeader."Transaction Date", 0, '<Day,2>/<Month,2>/<Year4>');
                        TrxTime := Format(TransferHeader."Transaction Time", 0, '<Hours24,2>:<Minutes,2>:<Seconds,2>');
                        
                        LineAmount := TransferHeader."Total Debits";
                        LineDebitAmt := TransferHeader."Total Debits";
                        LineCreditAmt := 0;

                    end else if Number = 2 then begin
                        // ------ 2. CREDIT/DESTINATION LINES ------
                        if TransferHeader."Total Credits" = 0 then
                            CurrReport.Skip();

                        TransferDest.Reset();
                        TransferDest.SetRange("No.", TransferHeader.No);
                        TransferDest.SetFilter("Destination Amount", '>0'); // Ignore 0.00 lines
                        
                        if TransferDest.FindSet() then begin
                            if TransferDest.Count = 1 then begin
                                // SINGLE DESTINATION ACCOUNT
                                GroupDetails := 'ACCOUNT TRANSFER TO - ' + TransferDest."Destination Account No." + ': ' + TransferDest."Product Name" + 
                                                ' - ' + Format(TransferHeader."Transfer Type") + ' Transfer In (To: ' + TransferDest."Destination Account Name" + ')';
                            end else begin
                                // MULTIPLE DESTINATION ACCOUNTS
                                AccountList := '';
                                repeat
                                    if AccountList = '' then
                                        AccountList := TransferDest."Destination Account No."
                                    else
                                        AccountList += ', ' + TransferDest."Destination Account No.";
                                until TransferDest.Next() = 0;

                                // Reset back to first to grab the primary name
                                TransferDest.FindFirst();
                                GroupDetails := 'ACCOUNT TRANSFER TO - Multiple Accounts (' + AccountList + ') - ' + 
                                                Format(TransferHeader."Transfer Type") + ' Transfer In (To: ' + TransferDest."Destination Account Name" + '...)';
                            end;
                        end else begin
                            GroupDetails := 'ACCOUNT TRANSFER TO - ' + Format(TransferHeader."Transfer Type") + ' Transfer In';
                        end;

                        TransType := 'Transfer In';
                        TrxDate := Format(TransferHeader."Transaction Date", 0, '<Day,2>/<Month,2>/<Year4>');
                        TrxTime := Format(TransferHeader."Transaction Time", 0, '<Hours24,2>:<Minutes,2>:<Seconds,2>');
                        
                        LineAmount := TransferHeader."Total Credits";
                        LineDebitAmt := 0;
                        LineCreditAmt := TransferHeader."Total Credits";
                    end;
                    
                    if GroupFilter <> '' then begin
                        if StrPos(UpperCase(GroupDetails), UpperCase(GroupFilter)) = 0 then
                            CurrReport.Skip();
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TransferHeader.CalcFields("Total Debits", "Total Credits");
                
                // Formulate the dynamic title
                ReportTitleTxt := 'Account Transfer Summary For ' + TransferHeader.No + ' on ' + Format(TransferHeader."Transaction Date", 0, '<Day,2>/<Month,2>/<Year4>');
            end;

            trigger OnPreDataItem()
            begin
                if UserCode <> '' then
                    SetRange("Created By", UserCode);

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
                    
                    field(UserCode; UserCode)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Created By (User)';
                        TableRelation = "User Setup"."User ID";
                        ToolTip = 'Select the user from the dropdown list.';
                    }
                    field(GroupFilter; GroupFilter)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Grouping Filter';
                        ToolTip = 'Type a keyword to filter by group (e.g. "Transfer Out", "Self Transfer"). Leave blank for all.';
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
        TransferSource: Record "Account Transfer Source";
        TransferDest: Record "Account Transfer Destination";
        CompanyAddress: Text;
        DateFilterTxt: Text;
        
        CompanyName: Text;
        BuldingName: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;
        PrintingDate: Text;
        PrintingTime: Text;
        PrintedBy: Text;
        ReportTitleTxt: Text;

        GroupDetails: Text;
        TransType: Text;
        TrxDate: Text;
        TrxTime: Text;
        LineAmount: Decimal;
        LineDebitAmt: Decimal;
        LineCreditAmt: Decimal;
        UserCode: Code[50];
        GroupFilter: Text;
        AccountList: Text;
}