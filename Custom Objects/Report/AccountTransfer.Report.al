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
            
            // Moved Created By to the header level
            column(HeaderCreatedBy; TransferHeader."Created By") { }

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

                        GroupDetails := Format(TransferHeader."Transfer Type") + ' Transfer Out';
                        TransferSource.Reset();
                        TransferSource.SetRange("No.", TransferHeader.No);
                        if TransferSource.FindFirst() then
                            GroupDetails := GroupDetails + ' (From: ' + TransferSource."Source Account Name" + ')';

                        if TransferHeader.Remarks <> '' then
                            GroupDetails := TransferHeader.Remarks + ' - ' + GroupDetails;

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

                        GroupDetails := Format(TransferHeader."Transfer Type") + ' Transfer In';
                        TransferDest.Reset();
                        TransferDest.SetRange("No.", TransferHeader.No);
                        if TransferDest.FindFirst() then
                            GroupDetails := GroupDetails + ' (To: ' + TransferDest."Destination Account Name" + ')';

                        if TransferHeader.Remarks <> '' then
                            GroupDetails := TransferHeader.Remarks + ' - ' + GroupDetails;

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

        GroupDetails: Text;
        TransType: Text;
        TrxDate: Text;
        TrxTime: Text;
        LineAmount: Decimal;
        LineDebitAmt: Decimal;
        LineCreditAmt: Decimal;
        UserCode: Code[50];
        GroupFilter: Text;
}