#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186709 pageextension52186709 extends "Service Lines Subform" 
{
    layout
    {
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify("Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify(Nonstock)
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
        modify("Currency Code")
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
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure")
        {
            ApplicationArea = Basic;
        }
        modify("Unit Cost (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Line Discount %")
        {
            ApplicationArea = Basic;
        }
        modify("Line Discount Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Allow Invoice Disc.")
        {
            ApplicationArea = Basic;
        }
        modify("Inv. Discount Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Serv. Price Adjmt. Gr. Code")
        {
            ApplicationArea = Basic;
        }
        modify("Contract No.")
        {
            ApplicationArea = Basic;
        }
        modify("Shipment No.")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Appl.-to Service Entry")
        {
            ApplicationArea = Basic;
        }
        modify("Appl.-from Item Entry")
        {
            ApplicationArea = Basic;
        }
        modify("Appl.-to Item Entry")
        {
            ApplicationArea = Basic;
        }
        modify("Job No.")
        {
            ApplicationArea = Basic;
        }
        modify("Job Task No.")
        {
            ApplicationArea = Basic;
        }
        modify("Job Line Type")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 94)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Customer No."(Control 86)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 92)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Nonstock(Control 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Return Reason Code"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 100)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost (LCY)"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount %"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount Amount"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Invoice Disc."(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inv. Discount Amount"(Control 80)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serv. Price Adjmt. Gr. Code"(Control 74)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contract No."(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment No."(Control 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item No."(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-to Service Entry"(Control 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-from Item Entry"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-to Item Entry"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job No."(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Task No."(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Line Type"(Control 18)".

    }
    local procedure GetSelectedLine(var FromServLine: Record "Service Line")
    begin
        FromServLine.Copy(Rec);
        CurrPage.SetSelectionFilter(FromServLine);
    end;
}
