#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186783 pageextension52186783 extends "Posted Return Shipment Subform" 
{
    layout
    {
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        // modify("Cross-Reference No.")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Return Reason Code")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Bin Code")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure")
        {
            ApplicationArea = Basic;
        }
        modify("Direct Unit Cost")
        {
            ApplicationArea = Basic;
        }
        modify("Quantity Invoiced")
        {
            ApplicationArea = Basic;
        }
        modify("Return Qty. Shipped Not Invd.")
        {
            ApplicationArea = Basic;
        }
        modify("Job No.")
        {
            ApplicationArea = Basic;
        }
        modify("Prod. Order No.")
        {
            ApplicationArea = Basic;
        }
        modify("Appl.-to Item Entry")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = Basic;
        }
        modify(Correction)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cross-Reference No."(Control 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Return Reason Code"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Direct Unit Cost"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity Invoiced"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Return Qty. Shipped Not Invd."(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job No."(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prod. Order No."(Control 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-to Item Entry"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Correction(Control 20)".

    }
    actions
    {
        modify("&Undo Return Shipment")
        {
            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify(Comments)
        {

            //Unsupported feature: Property Modification (Name) on "Comments(Action 1907504604)".

            ApplicationArea = Basic;
        }
        modify(ItemTrackingEntries)
        {

            //Unsupported feature: Property Modification (Name) on "ItemTrackingEntries(Action 1905987604)".

            ApplicationArea = Basic;
        }
        modify(ItemCreditMemoLines)
        {

            //Unsupported feature: Property Modification (Name) on "ItemCreditMemoLines(Action 1903100004)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Undo Return Shipment"(Action 1901653604)".


        //Unsupported feature: Property Deletion (Image) on ""&Undo Return Shipment"(Action 1901653604)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1900295304)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Comments(Action 1907504604)".

        modify(DocumentLineTracking)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ItemTrackingEntries(Action 1905987604)".


        //Unsupported feature: Code Modification on "ItemCreditMemoLines(Action 1903100004).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            PageShowItemPurchCrMemoLines;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ShowItemPurchCrMemoLines;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ItemCreditMemoLines(Action 1903100004)".


        //Unsupported feature: Property Deletion (Image) on "ItemCreditMemoLines(Action 1903100004)".

    }

    //Unsupported feature: Property Modification (Name) on "PageShowItemPurchCrMemoLines(PROCEDURE 2)".


    local procedure ShowItemTrackingLines()
    begin
        Rec.ShowItemTrackingLines;
    end;

    local procedure ShowLineComments()
    begin
        Rec.ShowLineComments;
    end;
}
