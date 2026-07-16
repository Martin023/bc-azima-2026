#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185441 "Securities register"
{
    Format = VariableText;
    schema
    {
        textelement(Name)
        {
            tableelement(Collateral; "Securities Register")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';
                fieldelement(a; Collateral."No.")
                {
                    FieldValidate = No;

                }
                fieldelement(b; Collateral."Account No.")
                {
                    FieldValidate = No;
                    //2
                }
                fieldelement(c; Collateral."Account Name")
                {
                    FieldValidate = No;
                    //3
                }
                fieldelement(d; Collateral."Collateral Type")
                {
                    FieldValidate = no;
                    //4
                }
                fieldelement(e; Collateral.Collateral)
                {
                    FieldValidate = no;
                    //5
                }
                fieldelement(f; Collateral."Collateral Name")
                {
                    FieldValidate = No;
                    //6
                }
                fieldelement(g; Collateral."Collateral Reg No.")
                {
                    FieldValidate = No;
                    //7
                }
                fieldelement(h; Collateral."Collateral Multiplier")
                {
                    FieldValidate = No;
                    //8
                }
                fieldelement(i; Collateral."Market Value")
                {
                    FieldValidate = No;
                    //9
                }
                fieldelement(j; Collateral."Collateral Limit")
                {
                    FieldValidate = No;
                    //10
                }
                fieldelement(k; Collateral.Status)
                {
                    FieldValidate = No;
                    //11
                }
                fieldelement(l; Collateral."Last Valuation Date")
                {
                    FieldValidate = No;
                    //12
                }
                fieldelement(m; Collateral."Forced Sale Value")
                {
                    FieldValidate = No;
                    //13
                }
                fieldelement(n; Collateral."Collateral Perfected")
                {
                    MinOccurs = Zero;
                    FieldValidate = No;
                    //14
                }
                fieldelement(o; Collateral."Next Valuation Date")
                {
                    FieldValidate = No;
                    //13
                }
                fieldelement(p; Collateral."Collateral Ref No.")
                {
                    FieldValidate = No;
                    //13
                }
                fieldelement(q; Collateral."Global Dimension 1 Code")
                {
                    FieldValidate = No;
                    //13
                }
                fieldelement(r; Collateral."Global Dimension 2 Code")
                {
                    FieldValidate = No;
                    MinOccurs = zero;
                    //13
                }

                fieldelement(t; Collateral."Loan Product")
                {
                    FieldValidate = No;
                    MinOccurs = zero;
                    //15
                }
                fieldelement(u; Collateral."Loan Amount")
                {
                    FieldValidate = No;
                    MinOccurs = zero;
                    //16
                }
                fieldelement(v; Collateral."Loan No.")
                {
                    FieldValidate = No;
                    MinOccurs = zero;
                    //17
                }
                fieldelement(s; Collateral."Loan Name")
                {
                    FieldValidate = No;
                    MinOccurs = zero;
                    //14
                }
                fieldelement(w; Collateral."Collateral Name")
                {
                    FieldValidate = No;
                    MinOccurs = zero;
                    //8
                }




            }
        }
    }

    trigger OnPostXmlPort()
    var
        myInt: Integer;
    begin
        Message('Process completed successful');
    end;
}
