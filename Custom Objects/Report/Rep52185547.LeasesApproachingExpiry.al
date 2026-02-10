report 52185547 "Leases Approaching Expiry"
{
    ApplicationArea = All;
    Caption = 'Leases Approaching Expiry';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Leases Approaching Expiry.rdl';
    dataset
    {
        dataitem(Lease; Lease)
        {
            RequestFilterFields = "No.", Expired, "Expiry Date";

            column(No; "No.")
            {
            }
            column(LeaseCommenceDate; "Lease Commence Date")
            {
            }
            column(MonthsToExpiry; MonthsToExpiry)
            {
            }
            column(TenantNo; "Tenant No.")
            {
            }
            column(TenantName; "Tenant Name")
            {
            }
            column(UnitCode; "Unit Code")
            {
            }
            column(FlooNo; "Floor No.")
            {
            }
            column(Areasquareft; "Area square ft")
            {
            }
            column(DateRegistered; "Date Registered")
            {
            }
            column(EscalationForLeases; "Escalation For Leases")
            {
            }
            column(EscalationFrequency; "Escalation Frequency")
            {
            }
            column(Expired; Expired)
            {
            }
            column(ExpiryDate; "Expiry Date")
            {
            }
            column(FloorNo; "Floor No.")
            {
            }
            column(FloorName; "Floor Name")
            {
            }
            column(LeasePeriod; "Lease Period")
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
            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord()
            begin
                GenSetup.Get;

                //if Calcdate(Lease."Expiry Date" - Today) <=  Format(GenSetup."Deadline Notification") then
                if Lease."Expiry Date" > TODAY then BEGIN
                    //LeaseStartDate := Lease."Date Registered";
                    //LeaseEndDate := Lease."Expiry Date";
                    DaysToExpiry := Lease."Expiry Date" - TODAY;
                    //MonthsToExpiry := 0;
                    if DaysToExpiry < 0 then
                        CurrReport.Skip
                    else
                        MonthsToExpiry := Round(((DaysToExpiry) / 30), 1, '<');
                END;
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


    Var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        LeaseStartDate: Date;
        LeaseEndDate: Date;
        DaysToExpiry: Integer;
        MonthsToExpiry: Integer;
        GenSetup: Record "General Setup";
}
