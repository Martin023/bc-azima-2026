#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185478 "Group Account Sig"
{
    Format = VariableText;
    schema
    {
        textelement(Name)
        {
            tableelement("Account Signatories";"Account Signatories")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';
                fieldelement(a;"Account Signatories"."Account No")
                {
                    FieldValidate = No;
                }
                fieldelement(b;"Account Signatories"."Entry No")
                {
                    FieldValidate=No;
                }
                fieldelement(c;"Account Signatories"."Member No.")
                {
                    FieldValidate=No;
                }
                fieldelement(d;"Account Signatories".Names)
                {
                    FieldValidate=No;
                }
                fieldelement(e;"Account Signatories"."Date Of Birth")
                {
                    FieldValidate=No;
                }
                fieldelement(f;"Account Signatories"."Staff/Payroll")
                {
                    FieldValidate=No;
                }
                fieldelement(g;"Account Signatories"."ID Number")
                {
                    FieldValidate=no;
                }
                fieldelement(h;"Account Signatories".Signatory)
                {
                    FieldValidate=No;
                }
                fieldelement(i;"Account Signatories"."Must Sign")
                {
                    FieldValidate=no;
                }
                fieldelement(j;"Account Signatories"."Must be Present")
                {
                    FieldValidate=No;
                }
                fieldelement(k;"Account Signatories"."Expiry Date")
                {
                    FieldValidate=no;
                }
                fieldelement(l;"Account Signatories".Type)
                {
                    FieldValidate=no;
                }
                fieldelement(m;"Account Signatories".Gender)
                {
                    FieldValidate=no;
                }
                fieldelement(n;"Account Signatories"."Phone No.")
                {
                    FieldValidate=no;
                }
                fieldelement(o;"Account Signatories"."Account Type")
                {
                    FieldValidate=no;
                }
                fieldelement(p;"Account Signatories"."PIN Number")
                {
                    FieldValidate=no;
                    MinOccurs=zero;
                }
               
            }
        }
    }
    trigger OnPostXmlPort()
    var
        myInt: Integer;
    begin
        Message('Members Upload completed successfully');
    end;
}