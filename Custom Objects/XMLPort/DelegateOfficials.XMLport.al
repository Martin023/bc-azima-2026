#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185469 "Delegate Officials"
{
    Format = VariableText;

    schema
    {
        textelement(NME)
        {
            tableelement("Delegate Members"; "Delegate Members")
            {
                MinOccurs = Zero;
                XmlName = 'JOURNAL';
                fieldelement(a; "Delegate Members".Code)
                {
                    FieldValidate = no;
                }
                fieldelement(b; "Delegate Members"."Delegate MNO.")
                {
                    FieldValidate = no;
                    MinOccurs = zero;
                }
                fieldelement(c; "Delegate Members"."Retire Date")
                {
                    FieldValidate = no;
                }
                fieldelement(d; "Delegate Members"."Delegate Name")
                {
                    FieldValidate = no;
                    MinOccurs = zero;
                }
                fieldelement(e; "Delegate Members".Position)
                {
                    FieldValidate = no;
                    MinOccurs = zero;
                }
                fieldelement(f; "Delegate Members".Status)
                {
                    FieldValidate = no;
                    MinOccurs = zero;
                }
                fieldelement(g; "Delegate Members".Retired)
                {
                    FieldValidate = no;
                    MinOccurs = zero;
                }
                fieldelement(h; "Delegate Members"."Electoral Zone")
                {
                    FieldValidate = no;
                    MinOccurs = zero;
                }
                fieldelement(i; "Delegate Members"."Electoral Zone Name")
                {
                    FieldValidate = no;
                    MinOccurs = zero;
                }
                fieldelement(j; "Delegate Members"."Appointment Date")
                {
                }
                fieldelement(k; "Delegate Members"."Expiry Date")
                {
                    FieldValidate = no;
                    MinOccurs = zero;
                }
                fieldelement(l; "Delegate Members"."Global Dimension 1 Code")
                {
                    FieldValidate = no;
                    MinOccurs = zero;
                }
                fieldelement(m; "Delegate Members"."Global Dimension 2 Code")
                {
                    FieldValidate = no;
                    MinOccurs = zero;
                }
                fieldelement(n; "Delegate Members"."ID No.")
                {
                    FieldValidate = no;
                    MinOccurs = zero;
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
