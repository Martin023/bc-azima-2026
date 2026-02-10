xmlport 52185551 "Savings Account"
{
    Caption = 'SavingsAccts';
    Format = VariableText;
    schema
    {
        textelement(Name)
        {
            tableelement(SavingsAccounts; "Savings Accounts")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';

                fieldelement(a; SavingsAccounts."No.")
                {
                    FieldValidate = no;
                }
                fieldelement(b; SavingsAccounts."Member No.")
                {
                    FieldValidate = no;
                }
                fieldelement(c; SavingsAccounts.Name)
                {
                    FieldValidate = no;
                }

                fieldelement(d; SavingsAccounts."Product Type")
                {
                    FieldValidate = no;
                }
                fieldelement(e; SavingsAccounts."Customer Posting Group")
                {
                    FieldValidate = no;
                }
                fieldelement(f; SavingsAccounts."Product Name")
                {
                    FieldValidate = no;
                }
                fieldelement(g; SavingsAccounts."Global Dimension 1 Code")
                {
                    FieldValidate = no;
                }
                fieldelement(h; SavingsAccounts."Global Dimension 2 Code")
                {
                    FieldValidate = no;
                }

                fieldelement(i; SavingsAccounts."Responsibility Center")
                {
                    FieldValidate = no;
                }
                fieldelement(j; SavingsAccounts.Status)
                {
                    FieldValidate = no;
                }
                fieldelement(k; SavingsAccounts."Monthly Contribution")
                {
                    FieldValidate = no;
                }
                fieldelement(l; SavingsAccounts."Can Guarantee Loan")
                {
                    FieldValidate = no;
                }
                fieldelement(m; SavingsAccounts."Loan Disbursement Account")
                {
                    FieldValidate = no;
                }

                fieldelement(n; SavingsAccounts."Product Category")
                {
                    FieldValidate = no;
                }
                fieldelement(o; SavingsAccounts."Transactional Mobile No")
                {
                    FieldValidate = no;
                }
                fieldelement(p; SavingsAccounts."Old Member No.")
                {
                    FieldValidate = no;
                }
                fieldelement(q; SavingsAccounts."Old Account No")
                {
                    FieldValidate = no;
                    MinOccurs=zero;
                }
            }
        }
    }
    trigger OnPostXmlPort()
    var
        myInt: Integer;
    begin
        Message('Process completed successfully');
    end;
}
