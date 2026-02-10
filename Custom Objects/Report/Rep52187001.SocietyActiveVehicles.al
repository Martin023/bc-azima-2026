report 52187001 "Society Active Vehicles"
{
    ApplicationArea = All;
    Caption = 'Society Active Vehicles';
    //UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Society Active Vehicles.rdl';
    dataset
    {
        dataitem(CompanyVehicles; "Company Vehicles")
        {
            //RequestFilterFields = "Vehicle Status";
            column(No_; "No.")
            {
            }

            column(AssetNo; "Asset No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Capacity; Capacity)
            {
            }
            column(Dateoflastinsurace; "Date of last insurace")
            {
            }
            column(LogbookNo; "Logbook No.")
            {
            }
            column(InsuranceExpiryDate; "Insurance Expiry Date")
            {
            }
            column(InsurancePolicyNo; "Insurance Policy No.")
            {
            }
            column(VehicleType; "Type of Vehicle")
            {
            }
            column(VehicleFrameNumber; "Vehicle Frame Number")
            {
            }
            column(YearofManufacture; "Year of Manufacture")
            {
            }
            column(No; "No.")
            {
            }
            column(Movement_Status; "Movement Status")
            {
            }
            column(EngineNo; "Engine No.")
            {
            }
            column(InsuranceCompany; "Insurance Company")
            {
            }
            column(RegistrationNo; "Registration No.")
            {
            }
            column(Color; Color)
            {
            }
            column(Logbook_No_; "Logbook No.")
            {
            }
            column(Engine_No_; "Engine No.")
            {
            }
            column(Vehicle_Frame_Number; "Vehicle Frame Number")
            {
            }
            column(Purchase_Vendor_Company; "Purchase Vendor/Company")
            {
            }
            column(Purchase_Date; "Purchase Date")
            {
            }
            column(Purchase_Price; "Purchase Price")
            {
            }
            column(Insurance_Company; "Insurance Company")
            {
            }
            column(Insurance_Policy_No_; "Insurance Policy No.")
            {
            }
            column(Insurance_Expiry_Date; "Insurance Expiry Date")
            {
            }
            column(Date_of_last_insurace; "Date of last insurace")
            {
            }
            column(Vehicle_Make; "Vehicle Make")
            {
            }
            column(Vehicle_Status; "Vehicle Status")
            {
            }
            column(Load_Limit; "Load Limit")
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
                //CompanyVehicles.Get(CompanyVehicles."Vehicle Status" = CompanyVehicles."Vehicle Status"::"Active");

                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
            end;
            // dataitem("Fixed Asset"; "Fixed Asset")
            // {
            //     column(FixedAssetNo; "No.")
            //     {
            //     }
            //     column(FixedAssetName; "Description")
            //     {
            //     }
            //     column(Insured; Insured)
            //     {
            //     }
            //}
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
        FixedAsset: Record "Fixed Asset";
        CompanyInformation: Record "Company Information";
        FixedAssetNo: Code[20];
        FixedAssetName: Text[50];
        Insured: Boolean;
        EmployerName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
