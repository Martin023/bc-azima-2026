#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185547 "Fixed Asset"
{
    Format = VariableText;
    schema
    {
        textelement(Name)
        {
            tableelement("Fixed Asset"; "Fixed Asset")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';
                fieldelement(a; "Fixed Asset"."No.")
                {
                    FieldValidate = No;
                }
                fieldelement(b; "Fixed Asset".Description)
                {
                    FieldValidate = No;
                }
                fieldelement(c; "Fixed Asset"."FA Class Code")
                {
                    FieldValidate = No;
                }
                fieldelement(d; "Fixed Asset"."FA Subclass Code")
                {
                    FieldValidate = No;
                }
                fieldelement(e; "Fixed Asset"."Global Dimension 1 Code")
                {
                    FieldValidate = No;
                }
                fieldelement(f; "Fixed Asset"."Global Dimension 2 Code")
                {
                    FieldValidate = No;
                }
                fieldelement(g; "Fixed Asset"."Serial No.")
                {
                    FieldValidate = No;
                }
                fieldelement(h; "Fixed Asset"."FA Posting Group")
                {
                    FieldValidate = No;
                }
                fieldelement(i; "Fixed Asset"."Vehicle Registration No.")
                {
                    FieldValidate = No;
                }
                fieldelement(j; "Fixed Asset"."Registration No.")
                {
                    FieldValidate = No;
                }
                fieldelement(k; "Fixed Asset"."Responsibility Center")
                {
                    FieldValidate = No;
                }

                fieldelement(l; "Fixed Asset"."Vehicle Status")
                {
                    FieldValidate = No;
                }
                fieldelement(m; "Fixed Asset".Status)
                {
                    FieldValidate = No;
                }

                fieldelement(n; "Fixed Asset"."Vehicle Make")
                {
                    FieldValidate = No;
                }
                fieldelement(o; "Fixed Asset"."Asset Tag")
                {
                    FieldValidate = No;
                }
                fieldelement(p; "Fixed Asset"."REG No.")
                {
                    MinOccurs = zero;
                    FieldValidate = No;
                }
                fieldelement(q; "Fixed Asset"."Responsible Employee")
                {
                    FieldValidate = No;
                }
                fieldelement(r; "Fixed Asset".Status)
                {
                    FieldValidate = No;
                }
                fieldelement(s; "Fixed Asset"."Marked for Disposal")
                {
                    MinOccurs = zero;
                    FieldValidate = No;
                }








            }
        }
    }

    trigger OnPostXmlPort()
    var
        myInt: Integer;
    begin
        Message('Upload of loans successful');
    end;
}