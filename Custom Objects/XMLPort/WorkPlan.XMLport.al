#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185493 WorkPlan
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Workplan Activities"; "Workplan Activities")
            {
                XmlName = 'WorkPlan';
                fieldelement(a; "Workplan Activities"."Workplan Code")
                {
                }
                fieldelement(b; "Workplan Activities"."Activity Code")
                {
                }
                fieldelement(c; "Workplan Activities"."Activity Description")
                {
                }
                fieldelement(d; "Workplan Activities"."Account Type")
                {
                }
                fieldelement(e; "Workplan Activities".Type)
                {
                }
                fieldelement(m; "Workplan Activities"."Expense Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(g; "Workplan Activities"."No.")
                {
                }
                fieldelement(i; "Workplan Activities"."Global Dimension 1 Code")
                {
                }
                fieldelement(j; "Workplan Activities"."Global Dimesnsion 2 Code")
                {
                }
                fieldelement(k; "Workplan Activities"."Proc. Method No.")
                {
                }
                fieldelement(l; "Workplan Activities".Quantity)
                {
                }
                fieldelement(n; "Workplan Activities"."Amount to Transfer")
                {
                    MinOccurs = Zero;
                }
                fieldelement(m; "Workplan Activities"."Expense Code")
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterInsertRecord()
                begin
                    /*
                    "Workplan Activities"."Uploaded to Procurement Workpl" := TRUE;
                    "Workplan Activities".MODIFY;
                    */

                end;
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
}
