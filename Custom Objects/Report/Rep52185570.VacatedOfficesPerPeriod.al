report 52185570 "Vacated Offices Per Period"
{
    ApplicationArea = All;
    Caption = 'Vacated Offices Per Period';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Vacated Offices Per Period.rdl';
    dataset
    {
        dataitem("Property Details"; "Property Details")
        {
            RequestFilterFields = "No.", "Property Type";
            Column(PropertyNo_; "No.")
            {
            }
            // column(L_R__No_;"Fixed Asset No.")
            // {
            // }
            column(Property_Name; Description)
            {
            }
            column(LandRefNo; "Fixed Asset No.")
            {
            }
            column(PeriodStartDate; StartDate)
            {
            }
            column(PeriodEndDate; EndDate)
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
            dataitem(Lease; Lease)
            {
                DataItemLinkReference = "Property Details";
                DataItemLink = "Property No." = FIELD("No.");
                //DataItemTableView = WHERE (Terminated= CONST(True), Expired= CONST(True));
                column(LeaseNo; "No.")
                {
                }
                column(Areasquareft; "Area square ft")
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
                column(LeaseCommenceDate; "Lease Commence Date")
                {
                }
                column(Expiry_Date; "Expiry Date")
                {
                }
                column(Termination_Date; "Termination Date")
                {
                }
                column(PropertyNo; "Property No.")
                {
                }
                column(PropertyName; "Property Name")
                {
                }
                column(PropertyType; "Property Type")
                {
                }
                column(Terminated; Terminated)
                {
                }
                column(TenantNo; "Tenant No.")
                {
                }
                column(TenantName; "Tenant Name")
                {
                }
                column(TerminationDate; "Termination Date")
                {
                }
                column(UnitType; "Unit Type")
                {
                }
                column(UnitCode; "Unit Code")
                {
                }
                column(UnitDescription; "Unit Description")
                {
                }
                column(UnitTypeDescription; "Unit Type Description")
                {
                }
                column(No; "No.")
                {
                }
                column(LRNo; "L.R. No.")
                {
                }
                column(DateRegistered; "Date Registered")
                {
                }

                dataitem(LeaseLine; "Lease Line")
                {
                    DataItemLink = "Lease No." = FIELD("No.");
                    column(Lease_No_; "Lease No.")
                    {
                    }
                    column(Date_Vacated; "Date Vacated")
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        StartDate := 0D;
                        EndDate := 0D;
                        PeriodStartDate := 0D;
                        PeriodEndDate := 0D;

                        PropertyDetails.RESET;
                        PropertyDetails.SETRANGE("No.", "Property No");
                        if "Property No" <> '' then begin
                            PeriodStartDate := StartDate;
                            PeriodEndDate := EndDate;
                        end;
                    end;
                }
            }
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
    }
    trigger OnPreReport()
    begin
        if StartDate = 0D then Error('Kindly set the start date');
        if EndDate = 0D then Error('Kindly set the end date');
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        CompanyInformation: Record "Company Information";
        StartDate: Date;
        EndDate: Date;
        PropertyDetails: Record "Property Details";
        PeriodStartDate: Date;
        PeriodEndDate: Date;
}
