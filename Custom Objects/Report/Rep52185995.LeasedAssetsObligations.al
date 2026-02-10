namespace MNS.MNS;

using Microsoft.FixedAssets.FixedAsset;
using Microsoft.HumanResources.Employee;
using Microsoft.FixedAssets.Setup;
using Microsoft.Foundation.Company;

report 52185995 "Leased Assets & Obligations"
{
    ApplicationArea = All;
    Caption = 'Leased Assets & Obligations';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Leased Assets & Obligations.rdl';
    //The system should be able to capture leased assets with their obligations i.e., monthly amount payable, location, 
    //officer in charge, description, serial number, lease period, expiry date etc.
    dataset
    {
        dataitem(FixedAsset; "Fixed Asset")
        {
            DataItemTableView = where("Acquisition Type" = const(Leased));
            column(No; "No.")
            {
            }

            column(AcquisitionType; "Acquisition Type")
            {
            }
            column(LeaseCommenceDate; "Lease Commence Date")
            {
            }
            column(LeaseEndDate; "Lease End Date")
            {
            }
            column(ResponsibleEmployee; EmployeeName)
            {
            }
            column(FAClassCode; "FA Class Code")
            {
            }
            column(FA_Location_Code; "FA Location Code") { }
            column(AssetLocation; AssetLocation) { }
            column(LeasePeriod; LeasePeriod) { }
            column(MonthlyAmountPayable; MonthlyAmountPayable) { }

            column(Description; Description)
            {
            }
            column(SerialNo; "Serial No.")
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
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                LeasePeriod := 0;
                LeasePeriod := FixedAsset."Lease End Date" - FixedAsset."Lease Commence Date";


                FALocations.RESET;
                FALocations.SetRange("Code", FixedAsset."FA Location Code");
                if FALocations.Find('-') then begin
                    AssetLocation := FALocations.Name;
                end;


                Employee.RESET;
                Employee.SetRange("No.", FixedAsset."Responsible Employee");
                if Employee.Find('-') then begin
                    EmployeeName := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                end;

                Lease.RESET;
                Lease.SetRange(Lease."Building Asset No.", FixedAsset."No.");
                if Lease.Find('-') then begin
                    MonthlyAmountPayable := Lease."Total VAT Amount" + Lease."Total Amount Excl. VAT";
                end;
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
        FALocations: Record "FA Location";
        AssetLocation: Text;
        LeasePeriod: Integer;
        Employee: Record Employee;
        EmployeeName: Text[1000];
        Lease: Record Lease;
        MonthlyAmountPayable: Decimal;
}
