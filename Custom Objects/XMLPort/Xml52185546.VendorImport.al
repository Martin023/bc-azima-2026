

xmlport 52185546 VendorImport
{
    Format=VariableText;
    Caption = 'VendorImport';
    schema
    {
        textelement(RootNodeName)
        
        {
            
            tableelement(Vendor; Vendor)
            {
                AutoReplace = false;
                AutoUpdate = true;
                fieldelement(No; Vendor."No.")
                {
                }
                fieldelement(Name; Vendor.Name)
                {
                }
                fieldelement(Address; Vendor.Address)
                {
                }
                fieldelement(PhoneNo; Vendor."Phone No.")
                {
                }
                fieldelement(GlobalDimension1Code; Vendor."Global Dimension 1 Code")
                {
                }
                fieldelement(GlobalDimension2Code; Vendor."Global Dimension 2 Code")
                {
                }
                fieldelement(VendorPostingGroup; Vendor."Vendor Posting Group")
                {
                }
                fieldelement(Blocked; Vendor.Blocked)
                {
                }
                fieldelement(Status; Vendor.Status)
                {
                }
                fieldelement(VendorCreditLimitLCY; Vendor."Vendor Credit Limit(LCY)")
                {
                }
                fieldelement(KRAPinNo; Vendor."KRA Pin No.")
                {
                }
                fieldelement(POBoxNumber; Vendor."P.O.Box Number")
                {
                }
                fieldelement(PhysicalAddress; Vendor."Physical Address.")
                {
                }
                fieldelement(VendorType; Vendor."Vendor Type")
                {
                }
            }
        }
    }
    trigger OnPostXmlPort()
    var
        myInt: Integer;
    begin
        Message('Processing completed successfully');
    end;
}
