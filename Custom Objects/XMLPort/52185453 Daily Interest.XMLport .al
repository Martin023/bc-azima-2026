xmlport 52185553 DailyInterest
{
    Caption = 'Daily interest';
    Format=VariableText;
    schema
    {
        textelement(Name)
        {
            tableelement("Daily Loans Interest Buffer";"Daily Loans Interest Buffer")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';
                
                fieldelement(a; "Daily Loans Interest Buffer"."Loan No.")
                {
                }
               fieldelement(b; "Daily Loans Interest Buffer"."Interest Date")
                {
                }
                 fieldelement(c; "Daily Loans Interest Buffer".No)
                {
                }

                
                fieldelement(d; "Daily Loans Interest Buffer"."Account Type")
                {
                }
                fieldelement(e; "Daily Loans Interest Buffer"."Account No")
                {
                }
                fieldelement(f; "Daily Loans Interest Buffer"."Loan Product type")
                {
                }
                fieldelement(g; "Daily Loans Interest Buffer"."Interest Amount")
                {
                }
                fieldelement(h; "Daily Loans Interest Buffer"."User ID")
                {
                }
                fieldelement(i; "Daily Loans Interest Buffer".Transferred)
                {
                }
                fieldelement(j; "Daily Loans Interest Buffer".Posted)
                {
                }
                fieldelement(k; "Daily Loans Interest Buffer"."Repayment Amount")
                {
                }
                fieldelement(l; "Daily Loans Interest Buffer"."Monthly Repayment")
                {
                }
                fieldelement(m; "Daily Loans Interest Buffer"."Interest Matured")
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

