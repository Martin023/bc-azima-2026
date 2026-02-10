#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185460 JOURNAL
{
    Format = VariableText;

    schema
    {
        textelement(NME)
        {
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
            {
                MinOccurs = Zero;
                XmlName = 'JOURNAL';
                fieldelement(a; "Gen. Journal Line"."Journal Template Name")
                {
                }
                fieldelement(b; "Gen. Journal Line"."Journal Batch Name")
                {
                }
                fieldelement(c; "Gen. Journal Line"."Posting Date")
                {
                    FieldValidate = No;
                }
                fieldelement(d; "Gen. Journal Line"."Document No.")
                {
                    FieldValidate = No;
                }
                fieldelement(e; "Gen. Journal Line"."Account Type")
                {
                    FieldValidate = No;
                }
                fieldelement(f; "Gen. Journal Line"."Account No.")
                {
                    FieldValidate = No;
                }
                fieldelement(g; "Gen. Journal Line".Amount)
                {
                    FieldValidate = yes;
                }
                fieldelement(h; "Gen. Journal Line".Description)
                {
                    FieldValidate = No;
                }
                fieldelement(i; "Gen. Journal Line"."Line No.")
                {
                    FieldValidate = No;
                }
                fieldelement(j; "Gen. Journal Line"."Shortcut Dimension 1 Code")
                {
                    FieldValidate = No;
                }
                fieldelement(k; "Gen. Journal Line"."Shortcut Dimension 2 Code")
                {
                    FieldValidate = No;
                }
                fieldelement(l; "Gen. Journal Line"."Loan No")
                {
                    FieldValidate = No;
                }
                fieldelement(m; "Gen. Journal Line"."Transaction Type")
                {
                    FieldValidate = No;
                }
                 fieldelement(n; "Gen. Journal Line"."Fixed Deposit Contract")
                {
                    FieldValidate = No;
                }
                fieldelement(o; "Gen. Journal Line"."Bal. Account No.")
                {
                    FieldValidate = No;
                }
                fieldelement(p; "Gen. Journal Line"."Bal. Account Type")
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
        Message('Upload completed successfully');
    end;
    
    
}
