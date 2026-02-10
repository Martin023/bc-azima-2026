Report 52186732 "Tenant Debtor Listing"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Tenant Debtor Listing.rdl';

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
            dataitem(Lease; Lease)
            {
                DataItemLink = "Tenant No." = field("No.");

                column(ReportForNavId_1; 1)
                {
                }
                column(Property_Name; "Property Name")
                {
                }
                column(Floor_Name; "Floor Name")
                {
                }
                column(Start; StartDate)
                {
                }
                column("End"; EndDate)
                {
                }
                column(Unit_Code; "Unit Code")
                {
                }
                column(Unit_Description; "Unit Description")
                {
                }
                column(Unit_Type; "Unit Type")
                {
                }
                column(Area_square_ft; "Area square ft")
                {
                }
                column(Total_Amount_Excl__VAT; "Total Amount Excl. VAT")
                {
                }
                column(Total_VAT_Amount; "Total VAT Amount")
                {
                }
                column(Last_Bill_Date; "Last Bill Date")
                {
                }
                column(Next_Bill_Date; "Next Bill Date")
                {
                }
                column(BillDate; BillDate)
                {

                }
                column(SNo; SNo)
                {

                }
                trigger OnAfterGetRecord()
                begin
                    SNo += 1;
                end;

            }

            trigger OnAfterGetRecord()
            var

            begin

                Desc := '';
                TenantBalance := 0;
                DaysArrears := 0;
                PayDate := 0D;
                AmtInvoiced := 0;
                AmtReceived := 0;
                BillDate := 0D;

                RecptHeader.Reset();
                RecptHeader.SetRange(Tenant, Lease."Tenant No.");
                if RecptHeader.Find('-') then begin
                    RecptHeader.CalcFields("Amount Invoiced", "Total Amount");
                    AmtInvoiced := RecptHeader."Amount Invoiced";
                    AmtReceived := RecptHeader."Total Amount";
                    Desc := RecptHeader.Dim4;
                    PayDate := RecptHeader."Date Posted";
                    BillDate := Lease."Next Bill Date";
                end;
                TenantBalance := AmtReceived - AmtInvoiced;
                // DaysArrears := Abs(PayDate - BillDate);
            end;

            trigger OnPreDataItem()
            begin
                // if StartDate = 0D then Error('Kindly set the start date');
                // if EndDate = 0D then Error('Kindly set the end date');
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
        BillDate: Date;
        RecptHeader: Record "Receipts Header";
        PostedInvoices: Record "Sales Invoice Header";
        AmtInvoiced: Decimal;
        AmtReceived: Decimal;
        TenantBalance: Decimal;
        PayDate: Date;
        Desc: Text;
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
        wtax: Decimal;
}

