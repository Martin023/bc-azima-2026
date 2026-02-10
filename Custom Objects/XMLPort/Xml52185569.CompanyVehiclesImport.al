
xmlport 52185569 CompanyVehiclesImport
{
    Format = VariableText;
    Caption = 'CompanyVehiclesImport';
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(CompanyVehicles; "Company Vehicles")
            {
                AutoReplace = false;
                AutoUpdate = true;
                fieldelement(No; CompanyVehicles."No.")
                {
                    FieldValidate = no;
                }
                fieldelement(RegistrationNo; CompanyVehicles."Registration No.")
                {
                    FieldValidate = no;
                }
                fieldelement(Description; CompanyVehicles.Description)
                {
                    FieldValidate = no;
                }
                fieldelement(Capacity; CompanyVehicles.Capacity)
                {
                    FieldValidate = no;
                }
                fieldelement(AssetNo; CompanyVehicles."Asset No.")
                {
                    FieldValidate = no;
                }
                fieldelement(YearofManufacture; CompanyVehicles."Year of Manufacture")
                {
                    FieldValidate = no;
                }
                fieldelement(Color; CompanyVehicles.Color)
                {
                    FieldValidate = no;
                }
                fieldelement(LoadLimit; CompanyVehicles."Load Limit")
                {
                    FieldValidate = no;
                }
                fieldelement(EngineNo; CompanyVehicles."Engine No.")
                {
                    FieldValidate = no;
                }
                fieldelement(VehicleFrameNumber; CompanyVehicles."Vehicle Frame Number")
                {
                    FieldValidate = no;
                }
                fieldelement(LogbookNo; CompanyVehicles."Logbook No.")
                {
                    FieldValidate = no;
                }
                fieldelement(PurchaseDate; CompanyVehicles."Purchase Date")
                {
                    FieldValidate = no;
                }
                fieldelement(PurchaseVendorCompany; CompanyVehicles."Purchase Vendor/Company")
                {
                    FieldValidate = no;
                }
                fieldelement(VendorContactDetails; CompanyVehicles."Vendor Contact Details")
                {
                    FieldValidate = no;
                }
                fieldelement(PurchasePrice; CompanyVehicles."Purchase Price")
                {
                    FieldValidate = no;
                }
                fieldelement(InsuranceCompany; CompanyVehicles."Insurance Company")
                {
                    FieldValidate = no;
                }
                fieldelement(InsurancePolicyNo; CompanyVehicles."Insurance Policy No.")
                {
                    FieldValidate = no;
                }
                fieldelement(InsuranceExpiryDate; CompanyVehicles."Insurance Expiry Date")
                {
                    FieldValidate = no;
                }
                fieldelement(Dateoflastinsurace; CompanyVehicles."Date of last insurace")
                {
                    FieldValidate = no;
                }
                fieldelement(GlobalDimension1Code; CompanyVehicles."Global Dimension 1 Code")
                {
                    FieldValidate = no;
                }
                fieldelement(GlobalDimension2Code; CompanyVehicles."Global Dimension 2 Code")
                {
                    FieldValidate = no;
                }
                fieldelement(ResponsibilityCenter; CompanyVehicles."Responsibility Center")
                {
                    FieldValidate = no;
                }
                fieldelement(TypeofVehicle; CompanyVehicles."Type of Vehicle")
                {
                    FieldValidate = no;
                }
                fieldelement(VehicleStatus; CompanyVehicles."Vehicle Status")
                {
                    FieldValidate = no;
                }
                fieldelement(Model; CompanyVehicles.Model)
                {
                    FieldValidate = no;
                }
            }
        }
    }
    trigger OnPostXmlPort()
    var
        myInt: Integer;
    begin
        Message('Upload completed successfully');
    end;

}