

xmlport 52185558 BankImport
{
    Format = VariableText;
    Caption = 'BankImport';
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(BankAccount; "Bank Account")
            {
                AutoReplace = false;
                AutoUpdate = true;
                fieldelement(No; BankAccount."No.")
                {
                    FieldValidate = no;
                }
                fieldelement(Name; BankAccount.Name)
                {
                    FieldValidate = no;
                }
                fieldelement(PhoneNo; BankAccount."Phone No.")
                {
                    FieldValidate = no;
                }
                fieldelement(BankAccountNo; BankAccount."Bank Account No.")
                {
                    FieldValidate = no;
                }
                fieldelement(GlobalDimension1Code; BankAccount."Global Dimension 2 Code")
                {
                    FieldValidate = no;
                }
                fieldelement(GlobalDimension2Code; BankAccount."Global Dimension 2 Code")
                {
                    FieldValidate = no;
                }
                fieldelement(BankAccPostingGroup; BankAccount."Bank Acc. Posting Group")
                {
                    FieldValidate = no;
                }
                fieldelement(Blocked; BankAccount.Blocked)
                {
                    FieldValidate = no;
                }
                fieldelement(County; BankAccount.County)
                {
                    FieldValidate = no;
                }
                fieldelement(SWIFTCode; BankAccount."SWIFT Code")
                {
                    FieldValidate = no;
                }
                fieldelement(BankType; BankAccount."Bank Type")
                {
                    FieldValidate = no;
                }
                fieldelement(CurrencyCode; BankAccount."Currency Code")
                {
                    FieldValidate = no;
                }
                fieldelement(maxwith; BankAccount."Max. Witholding Balance")
                {
                    FieldValidate = no;
                }
                fieldelement(replenbal; BankAccount."Replenishment Balance")
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
