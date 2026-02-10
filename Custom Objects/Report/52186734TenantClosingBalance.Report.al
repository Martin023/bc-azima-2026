Report 52186734 "Tenant Arrears Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Tenant Arrears Report.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where("Account Type" = filter(Tenant));
            column(No_; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Balance__LCY_; "Balance (LCY)")
            {
            }
            column(Phone_No_; "Phone No.")
            {
            }
            column(E_Mail; "E-Mail")
            {
            }
            column(Credit_Amount; "Credit Amount")
            {
            }
            column(Debit_Amount; "Debit Amount")
            {
            }

            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(AmtInvoiced; AmtInvoiced)
            {

            }
            column(AmtReceived; AmtReceived)
            {

            }
            column(TenantBalance; TenantBalance)
            {

            }
            column(Desc; Desc)
            {

            }
            column(PayDate; PayDate)
            {

            }
            column(DaysArrears; DaysArrears)
            {

            }
            column(WTax; WTax)
            {

            }
            column(DocDate; DocDate)
            {

            }
            column(WaivedAmt; WaivedAmt)
            {

            }
            column(ClosingBal; ClosingBal)
            {

            }
            column(OpeningBal; OpeningBal)
            {

            }
            column(PropertyName; PropertyName)
            {

            }
            column(FloorName; FloorName)
            {

            }
            column(UnitCode; UnitCode)
            {

            }
            column(BillDate; BillDate)
            {

            }
            column(SNo; SNo)
            {

            }

            trigger OnAfterGetRecord()
            var

            begin
                SNo += 1;
                Desc := '';
                TenantBalance := 0;
                DaysArrears := 0;
                PayDate := 0D;
                AmtInvoiced := 0;
                AmtReceived := 0;
                BillDate := 0D;

                // DaysArrears := MaximumDate - Customer."Last Transaction Date";
                if DaysArrears < 0 then
                    DaysArrears := 0;

                RecptHeader.Reset();
                RecptHeader.SetRange(Tenant, Customer."No.");
                if RecptHeader.Find('-') then begin
                    RecptHeader.CalcFields("Amount Invoiced", "Total Amount");
                    AmtInvoiced := RecptHeader."Amount Invoiced";
                    AmtReceived := RecptHeader."Total Amount";
                    Desc := RecptHeader.Dim4;
                    PayDate := RecptHeader."Date Posted";
                    DocDate := RecptHeader.Date;

                    TenantBalance := AmtReceived - AmtInvoiced;

                    RecptLine.Reset();
                    RecptLine.SetRange(No, RecptHeader."No.");
                    if RecptLine.FindFirst() then begin
                        WTax := RecptLine."Withholding Tax Amount";
                    end;
                end;

                Lease.Reset();
                Lease.SetRange("Tenant No.", Customer."No.");
                if Lease.Find('-') then begin
                    BillDate := Lease."Next Bill Date";
                    PropertyName := Lease."Property Name";
                    FloorName := Lease."Floor Name";
                    UnitCode := Lease."Unit Code";

                end;

                CustLedgerEntry.Reset();
                CustLedgerEntry.SetRange("Customer No.", Customer."No.");
                CustLedgerEntry.SetFilter("Posting Date", '<%1', StartDate);
                if CustLedgerEntry.Find('-') then begin
                    repeat
                        CustLedgerEntry.CalcFields("Amount (LCY)");
                        OpeningBal += CustLedgerEntry."Amount (LCY)";
                    until CustLedgerEntry.Next() = 0;
                end;

                SalesCrMemo.Reset();
                SalesCrMemo.SetRange("Sell-to Customer No.", Customer."No.");
                if SalesCrMemo.FindFirst() then begin
                    WaivedAmt := SalesCrMemo."Amount Including VAT";
                end;

                ClosingBal := ((Customer."Balance (LCY)" + AmtInvoiced) - AmtReceived - WaivedAmt - WTax);

            end;

            trigger OnPreDataItem()
            begin
                If Customer.GetFilter("Date Filter") = '' then
                    Customer.SetFilter("Date Filter", '..%1', Today);
                MaximumDate := Customer.GetRangeMax("Date Filter");

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
                field(StartDate; StartDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Start Date';
                }
                field(EndDate; EndDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'End Date';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        SNo: Integer;
        StartDate: Date;
        EndDate: Date;
        MaximumDate: Date;
        DocDate: Date;
        WTax: Decimal;
        ClosingBal: Decimal;
        OpeningBal: Decimal;
        BillDate: Date;
        WaivedAmt: Decimal;
        DiscountAmt: Decimal;
        PropertyName: Text[100];
        FloorName: Text[100];
        UnitCode: Code[20];
        CustLedgerEntry: Record "Cust. Ledger Entry";
        RecptHeader: Record "Receipts Header";
        PostedInvoices: Record "Sales Invoice Header";
        RecptLine: Record "Receipt Line";
        AmtInvoiced: Decimal;
        AmtReceived: Decimal;
        TenantBalance: Decimal;
        PayDate: Date;
        Desc: Text;
        SalesCrMemo: Record "Sales Cr.Memo Header";
        SalesCrLine: Record "Sales Cr.Memo Line";
        DaysArrears: Integer;
        Company: Record "Company Information";
        IntEarned: Decimal;
        NoOfDays: Integer;
        Inv: Record "Investment Header";
        InvLine: Record "Investment Lines";
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        TarrifCodes: Record "Tariff Code s";
        Lease: Record Lease;
}

