#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185465 "ITEM QTY"
{
    Format = VariableText;

    schema
    {
        textelement(NME)
        {
            tableelement("Item Journal Line"; "Item Journal Line")
            {
                XmlName = 'JOURNAL';
                fieldelement(a; "Item Journal Line"."Journal Template Name")
                {
                }
                fieldelement(b; "Item Journal Line"."Line No.")
                {
                }
                fieldelement(c; "Item Journal Line"."Item No.")
                {
                }
                fieldelement(h; "Item Journal Line"."Posting Date")
                {
                }
                fieldelement(j; "Item Journal Line"."Entry Type")
                {
                }
                fieldelement(d; "Item Journal Line".Description)
                {
                }
                fieldelement(e; "Item Journal Line"."Location Code")
                {
                }
                fieldelement(f; "Item Journal Line"."Inventory Posting Group")
                {
                }
                fieldelement(g; "Item Journal Line".Quantity)
                {
                }
                fieldelement(h; "Item Journal Line"."Unit Cost")
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
}
