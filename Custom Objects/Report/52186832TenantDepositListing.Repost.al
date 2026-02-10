Report 52186832 "Tenant Listing"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Tenant Listing.rdl';

    dataset
    {
        dataitem("Receipts Header"; "Receipts Header")
        {
            DataItemTableView = where("Customer Type" = filter(Tenant), "Rent Type" = filter("Rent Deposit"));
            column(No_; "No.")
            {
            }
            column(Customer_Type; "Customer Type")
            {
            }
            column(Tenant; Tenant)
            {
            }
            column(Tenant_Name; "Tenant Name")
            {
            }
            column(Dim4; Dim4)
            {
            }
            column(Invoices; Invoices)
            {
            }
            column(Amount_Recieved; "Amount Recieved")
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
            column(Rent_Type; "Rent Type")
            {

            }
            column(Total_Amount; "Total Amount")
            {

            }
            column(Date_Posted; "Date Posted")
            {

            }
            column(Transaction_Date; "Transaction Date")
            {

            }
            column(ChqDate; ChqDate)
            {

            }
            column(ChqNo; ChqNo)
            {

            }
            column(PayMode; PayMode)
            {

            }
            column(PropertyName; PropertyName)
            {

            }
            column(FloorNo; FloorNo)
            {

            }
            column(Unit; Unit)
            {

            }
            column(SqFt; SqFt)
            {

            }

            trigger OnAfterGetRecord()
            begin

                ReceiptLines.Reset();
                ReceiptLines.SetRange(No, "Receipts Header"."No.");
                ReceiptLines.SetRange("Account No.", "Receipts Header".Tenant);
                if ReceiptLines.Find('-') then begin
                    ChqDate := ReceiptLines."Cheque/Deposit Slip Date";
                    ChqNo := ReceiptLines."Cheque/Deposit Slip No";
                    PayMode := ReceiptLines."Pay Mode";
                end;

                Lease.Reset();
                Lease.SetRange("Tenant No.", "Receipts Header".Tenant);
                if Lease.FindFirst() then begin
                    PropertyName := Lease."Property Name";
                    FloorNo := Lease."Floor Name";
                    Unit := Lease."Unit Description";
                    SqFt := Lease."Area square ft";
                end;
            end;

            trigger OnPreDataItem()
            begin
                "Receipts Header".SetFilter("Date Posted", '%1', AsAt);
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
                field(AsAt; AsAt)
                {
                    ApplicationArea = Basic;
                    Caption = 'As At';
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
        StartDate: Date;
        Desc: Text[250];
        PayDate: Date;
        AsAt: Date;
        EndDate: Date;
        Company: Record "Company Information";
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        TarrifCodes: Record "Tariff Code s";
        ReceiptLines: Record "Receipt Line";
        ChqNo: Code[20];
        ChqDate: Date;
        PayMode: Option;
        Lease: Record Lease;
        PropertyName: Text[100];
        Unit: Code[200];
        FloorNo: Text[200];
        SqFt: Decimal;
}

