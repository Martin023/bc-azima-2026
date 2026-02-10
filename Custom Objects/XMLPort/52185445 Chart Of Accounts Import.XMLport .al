#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185445 "Chart Of Accounts"
{
    Format = VariableText;

    schema
    {
        textelement(NME)
        {
            tableelement("Chart"; "G/L Account")
            {
                 AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'Charts';
                fieldelement(a; Chart."No.")
                {
                }
                fieldelement(b; Chart."Old Acc. No.")
                {
                }
                fieldelement(c; Chart.Name)
                {
                    FieldValidate = No;
                }
                fieldelement(d; Chart."Account Type")
                {
                    FieldValidate = No;
                }
                fieldelement(e;Chart."Account Category")
                {
                    FieldValidate = No;
                }
                fieldelement(f; Chart."Income/Balance")
                {
                    FieldValidate = No;
                }
                fieldelement(g; Chart."Debit/Credit")
                {
                    FieldValidate = yes;
                }
                fieldelement(h; Chart."Direct Posting")
                {
                    FieldValidate = No;
                }
                fieldelement(i; Chart.Blocked)
                {
                    FieldValidate = No;
                }
                fieldelement(j;Chart."Gen. Posting Type")
                {
                    FieldValidate = No;
                }
                fieldelement(k; Chart."Gen. Bus. Posting Group")
                {
                    FieldValidate = No;
                }
                fieldelement(l; Chart."Gen. Prod. Posting Group")
                {
                    FieldValidate = No;
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
