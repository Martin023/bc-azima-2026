
xmlport 52185572 DelegatesImports
{
    Format=VariableText;
    Caption = 'DelegatesImports';
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(DelegateMembers; "Delegate Members")
            {
                 AutoReplace = false;
                AutoUpdate = true;
                fieldelement(Code; DelegateMembers."Code")
                {
                    FieldValidate=no;
                }
                fieldelement(DelegateMNO; DelegateMembers."Delegate MNO.")
                {
                     FieldValidate=no;
                }
                fieldelement(RetireDate; DelegateMembers."Retire Date")
                {
                     FieldValidate=no;
                }
                fieldelement(DelegateName; DelegateMembers."Delegate Name")
                {
                     FieldValidate=no;
                }
                fieldelement(Position; DelegateMembers.Position)
                {
                     FieldValidate=no;
                }
                fieldelement(Status; DelegateMembers.Status)
                {
                     FieldValidate=no;
                }
                fieldelement(Retired; DelegateMembers.Retired)
                {
                     FieldValidate=no;
                }
                fieldelement(ElectoralZone; DelegateMembers."Electoral Zone")
                {
                     FieldValidate=no;
                }
                fieldelement(ElectoralZoneName; DelegateMembers."Electoral Zone Name")
                {
                     FieldValidate=no;
                }
                fieldelement(AppointmentDate; DelegateMembers."Appointment Date")
                {
                     FieldValidate=no;
                }
                fieldelement(ExpiryDate; DelegateMembers."Expiry Date")
                {
                     FieldValidate=no;
                }
                fieldelement(GlobalDimension1Name; DelegateMembers."Global Dimension 1 Name")
                {
                     FieldValidate=no;
                }
                fieldelement(GlobalDimension2Code; DelegateMembers."Global Dimension 2 Code")
                {
                     FieldValidate=no;
                }
                fieldelement(IDNo; DelegateMembers."ID No.")
                {
                     FieldValidate=no;
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
