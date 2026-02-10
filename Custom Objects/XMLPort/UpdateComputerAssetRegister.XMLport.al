#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185532 "Update Computer Asset Register"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(AsstReg)
        {
            tableelement("Computer Asset Register"; "Computer Asset Register")
            {
                AutoUpdate = true;
                XmlName = 'Asset';
                fieldelement(a; "Computer Asset Register".No)
                {
                }
                fieldelement(b; "Computer Asset Register".Location)
                {
                }
                fieldelement(c; "Computer Asset Register"."Responsibility Center")
                {
                }
                fieldelement(e; "Computer Asset Register"."Asset Description")
                {
                }
                fieldelement(d; "Computer Asset Register".Manufacturer)
                {
                    FieldValidate = no;
                }
                fieldelement(aa; "Computer Asset Register"."Staff No")
                {
                    FieldValidate = no;
                }
                fieldelement(f; "Computer Asset Register"."Allocated User")
                {
                }
                fieldelement(j; "Computer Asset Register"."System Software")
                {
                    FieldValidate = no;
                }
                fieldelement(k; "Computer Asset Register".Applications)
                {
                    FieldValidate = no;
                }
                fieldelement(l; "Computer Asset Register"."Processor Type")
                {
                    FieldValidate = no;
                }
                fieldelement(m; "Computer Asset Register"."Memory Size")
                {
                    FieldValidate = no;
                }
                fieldelement(o; "Computer Asset Register"."Asset Serial No")
                {
                }
                fieldelement(p; "Computer Asset Register"."Year of Purchase")
                {
                }
                fieldelement(q; "Computer Asset Register"."Purchase Amount")
                {
                }
                fieldelement(r; "Computer Asset Register".Status)
                {
                }
                fieldelement(s; "Computer Asset Register"."Year of Service Left")
                {
                    MinOccurs = Zero;
                }
                fieldelement(t; "Computer Asset Register"."Expected Value at end of Life")
                {
                    MinOccurs = Zero;
                }
                fieldelement(x; "Computer Asset Register".Disposed)
                {
                    MinOccurs = Zero;
                }
                fieldelement(y; "Computer Asset Register"."Date Disposed")
                {
                    MinOccurs = Zero;
                }
                fieldelement(z; "Computer Asset Register".Center)
                {
                    FieldValidate = yes;
                    MinOccurs = Zero;
                }
                fieldelement(ab; "Computer Asset Register"."Created By")
                {
                }
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort()
    begin
        Message('Computer Asset Register Update Complete');
    end;
}
