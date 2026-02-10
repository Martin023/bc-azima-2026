#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52187417 "ATM Inventory Xml"
{
    Format = VariableText;
    FormatEvaluate = Legacy;
    Direction = Both;

    schema
    {
        textelement(Root)
        {
            tableelement("ATMInventory"; "ATM Inventory")
            {
                fieldattribute(AccNo; "ATMInventory"."Account No.")
                {
                }
                fieldattribute(RefNo; "ATMInventory"."Reference No")
                {
                }
                // fieldattribute(MemberName; "ATMInventory"."Member Name")
                // {
                // }
                // fieldattribute(IDNo; "ATMInventory"."ID No.")
                // {
                // }
                // fieldattribute(DateOfDispatch; "ATMInventory"."Date Of Dispatch")
                // {
                // }
                // fieldattribute(PhoneNo; "ATMInventory"."Phone No.")
                // {
                // }
                // fieldattribute(Dimension1; "ATMInventory"."Global Dimension 1 Code")
                // {
                // }
                // fieldattribute(Dimension2; "ATMInventory"."Global Dimension 2 Code")
                // {
                // }
                fieldattribute(ExpiryDate; "ATMInventory"."Expiry Date")
                {
                }
                // fieldattribute(Status; "ATMInventory".Status)
                // {
                // }
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

