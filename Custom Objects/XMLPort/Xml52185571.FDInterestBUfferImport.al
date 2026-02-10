
xmlport 52185571 FDInterestBUfferImport
{
    Format=VariableText;
    Caption = 'FDInterestBUfferImport';
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(InterestBuffer; "Interest Buffer")
            {
                AutoReplace = false;
                AutoUpdate = true;

                fieldelement(No; InterestBuffer.No)
                {
                    FieldValidate=no;
                }
                fieldelement(AccountNo; InterestBuffer."Account No")
                {
                     FieldValidate=no;
                }
                fieldelement(ProductType; InterestBuffer."Product Type")
                {
                     FieldValidate=no;
                }
                fieldelement(InterestDate; InterestBuffer."Interest Date")
                {
                     FieldValidate=no;
                }
                fieldelement(InterestAmount; InterestBuffer."Interest Amount")
                {
                     FieldValidate=no;
                }
                fieldelement(AccountMatured; InterestBuffer."Account Matured")
                {
                     FieldValidate=no;
                }
                fieldelement(Transferred; InterestBuffer.Transferred)
                {
                     FieldValidate=no;
                }
                fieldelement(Description; InterestBuffer.Description)
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

