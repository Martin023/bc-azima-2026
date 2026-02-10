page 52186234 "Property Charges"
{
    PageType = List;
    SourceTable = "Property Charges";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Property Code"; Rec."Property Code")
                {
                    Editable = false;
                }
                field("Code"; Rec.Code)
                {
                    Editable = true;
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                }
                field("Account No."; Rec."Account No.")
                {
                    Editable = false;
                }
                field(Vatable; Rec.Vatable)
                {
                    Editable = false;
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    Editable = false;
                }
                field("Uses Rates"; Rec."Uses Rates")
                {
                    Editable = false;
                }
                field("Charge Management Incl. VAT"; Rec."Charge Management Incl. VAT")
                {
                }
                field("Mgt on Rent Only"; Rec."Mgt on Rent Only")
                {
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    Editable = false;
                }
                field("Charge Management Fee"; Rec."Charge Management Fee")
                {
                }
                field("Charge Letting Fee"; Rec."Charge Letting Fee")
                {
                }
                field("Charge Reletting Fee"; Rec."Charge Reletting Fee")
                {
                }
            }
        }
    }

    actions
    {
    }
}

