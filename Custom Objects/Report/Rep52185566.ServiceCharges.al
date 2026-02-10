report 52185566 "Service Charges"
{
    ApplicationArea = All;
    Caption = 'Service Charges';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Service Charges.rdl';

    dataset
    {
        dataitem(Lease; Lease)
        {
            RequestFilterFields = "No.", "Property No.", "Property Name", "Property Type";
            column(No; "No.")
            {
            }
            column(TenantNo; "Tenant No.")
            {
            }
            column(TenantName; "Tenant Name")
            {
            }
            column(DateRegistered; "Date Registered")
            {
            }
            column(LastBillDate; "Last Bill Date")
            {
            }
            column(MeterNo; "Meter No.")
            {
            }
            column(NairobiCurReading; "Nairobi Cur Reading")
            {
            }
            column(NextBillDate; "Next Bill Date")
            {
            }
            column(PreviousReading; "Previous Reading")
            {
            }
            column(PropertyNo; "Property No.")
            {
            }
            column(PropertyType; "Property Type")
            {
            }
            column(PropertyName; "Property Name")
            {
            }
            column(UnitCode; "Unit Code")
            {
            }
            column(UnitDescription; "Unit Description")
            {
            }
            column(UnitType; "Unit Type")
            {
            }
            column(UnitTypeDescription; "Unit Type Description")
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
            dataitem(LeaseLines; "Lease Line")
            {
                RequestFilterFields = "Charge No.", "Charge Name";
                DataItemLink = "Lease No." = FIELD("No.");
                column(Lease_No_; "Lease No.") { }
                column(Charge_No_; "Charge No.") { }
                column(Charge_Name; "Charge Name") { }
                column(Amount; Amount) { }
                column(Amount_Exclusive_VAT; "Amount Exclusive VAT") { }
                column(Total_Amount_Inclusive_VAT; "Total Amount Inclusive VAT") { }

                trigger OnAfterGetRecord()
                begin
                    Lease_No_ := '';
                    Charge_No_ := '';
                    Charge_Name := '';
                    Amount := 0;
                    Amount_Exclusive_VAT := 0;
                    Total_Amount_Exclusive_VAT := 0;
                    Total_Amount_Inclusive_VAT := 0;

                    Leaselines.Reset();
                    LeaseLines.SetRange("Lease No.", Lease."No.");
                    if LeaseLines.Find('-') then begin
                        repeat
                            Charge_No_ := LeaseLines."Charge No.";
                            Charge_Name := LeaseLines."Charge Name";
                            Amount := LeaseLines.Amount;
                            Amount_Exclusive_VAT := LeaseLines."Amount Exclusive VAT";
                            Total_Amount_Inclusive_VAT := LeaseLines."Total Amount Inclusive VAT";
                        until LeaseLines.Next = 0
                    end;


                end;
            }
            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
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
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
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
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Lease_No_: CODE[20];
        Charge_No_: CODE[20];
        Charge_Name: CODE[20];
        Amount: Decimal;
        Amount_Exclusive_VAT: Decimal;
        Total_Amount_Exclusive_VAT: Decimal;
        Total_Amount_Inclusive_VAT: Decimal;
}
