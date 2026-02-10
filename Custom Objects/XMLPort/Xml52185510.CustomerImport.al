
xmlport 52185510 CustomerImport
{
    Format = VariableText;
    Caption = 'CustomerImport';
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(Customer; Customer)
            {
                AutoReplace = false;
                AutoUpdate = true;
                fieldelement(No; Customer."No.")
                {
                    FieldValidate = no;
                }
                fieldelement(Name; Customer.Name)
                {
                    FieldValidate = no;
                }
                fieldelement(Address; Customer.Address)
                {
                    FieldValidate = no;
                }
                fieldelement(PhoneNo; Customer."Phone No.")
                {
                    FieldValidate = no;
                }
                fieldelement(CreditLimitLCY; Customer."Credit Limit (LCY)")
                {
                    FieldValidate = no;
                }
                fieldelement(CustomerPostingGroup; Customer."Customer Posting Group")
                {
                    FieldValidate = no;
                }
                fieldelement(PricesIncludingVAT; Customer."Prices Including VAT")
                {
                    FieldValidate = no;
                }
                fieldelement(GenBusPostingGroup; Customer."Gen. Bus. Posting Group")
                {
                    FieldValidate = no;
                }
                fieldelement(EMail; Customer."E-Mail")
                {
                    FieldValidate = no;
                }
                fieldelement(TaxLiable; Customer."Tax Liable")
                {
                    FieldValidate = no;
                }
                fieldelement(VATBusPostingGroup; Customer."VAT Bus. Posting Group")
                {
                    FieldValidate = no;
                }
                fieldelement(AccountType; Customer."Account Type")
                {
                    FieldValidate = no;
                }
                fieldelement(EmployeeJobGroup; Customer."Employee Job Group")
                {
                    FieldValidate = no;
                }
                fieldelement(Status; Customer.Status)
                {
                    FieldValidate = no;
                }
                fieldelement(KRAPIN; Customer."KRA PIN")
                {
                    MinOccurs = zero;
                    FieldValidate = no;
                }
                fieldelement(OldNo; Customer."Old No.")
                {
                    MinOccurs = zero;
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
