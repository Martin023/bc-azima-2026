xmlport 52185600 "Upload Savings Records"
{
    Caption = 'SavingsAccts';
    Format=VariableText;
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
                }
                fieldelement(b; SavingsAccounts."Member No.")
                {
                }
                fieldelement(c; SavingsAccounts.Name)
                {
                }

                fieldelement(d; SavingsAccounts."Product Type")
                {
                }
                fieldelement(e; SavingsAccounts."Customer Posting Group")
                {
                }
                fieldelement(f; SavingsAccounts."Product Name")
                {
                }
                fieldelement(g; SavingsAccounts."Global Dimension 1 Code")
                {
                }
                fieldelement(h; SavingsAccounts."Global Dimension 2 Code")
                {
                }

                fieldelement(i; SavingsAccounts."Responsibility Center")
                {
                }
                fieldelement(j; SavingsAccounts.Status)
                {
                }
                fieldelement(k; SavingsAccounts."Monthly Contribution")
                {
                }
                fieldelement(l; SavingsAccounts."Can Guarantee Loan")
                {
                }
                fieldelement(m; SavingsAccounts."Loan Disbursement Account")
                {
                }

                fieldelement(n; SavingsAccounts."Product Category")
                {
                }
                fieldelement(o; SavingsAccounts."Transactional Mobile No")
                {
                }
                fieldelement(p; SavingsAccounts."Old Member No.")
                {
                }
                fieldelement(q; SavingsAccounts."Old Account No")
                {
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
