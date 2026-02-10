report 52187008 "Vehicle Depreciation"
{
    ApplicationArea = All;
    Caption = 'Vehicle Depreciation';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Vehicle Depreciation.rdl';
    dataset
    {
        dataitem(CompanyVehicles; "Company Vehicles")
        {
            // column(AssetNo; "Asset No.")
            // {
            // }
            column(Capacity; Capacity)
            {
            }
            column(Color; Color)
            {
            }
            column(Dateoflastinsurace; "Date of last insurace")
            {
            }
            column(Description; Description)
            {
            }
            column(EngineNo; "Engine No.")
            {
            }
            column(InsuranceCompany; "Insurance Company")
            {
            }
            column(InsuranceExpiryDate; "Insurance Expiry Date")
            {
            }
            column(InsurancePolicyNo; "Insurance Policy No.")
            {
            }
            column(LoadLimit; "Load Limit")
            {
            }
            column(LogbookNo; "Logbook No.")
            {
            }
            column(No; "No.")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(PurchaseDate; "Purchase Date")
            {
            }
            column(PurchasePrice; "Purchase Price")
            {
            }
            column(PurchaseVendorCompany; "Purchase Vendor/Company")
            {
            }
            column(RegistrationNo; "Registration No.")
            {
            }
            column(Status; Status)
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column(VehicleFrameNumber; "Vehicle Frame Number")
            {
            }
            column(VehicleType; "Type of Vehicle")
            {
            }
            column(VendorContactDetails; "Vendor Contact Details")
            {
            }
            column(YearofManufacture; "Year of Manufacture")
            {
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
}
