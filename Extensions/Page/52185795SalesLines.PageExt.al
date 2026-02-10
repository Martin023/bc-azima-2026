#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185795 pageextension52185795 extends "Sales Lines"
{
    layout
    {
       



        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Sell-to Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify("Line No.")
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
            trigger OnAfterValidate()
            var
                Items: record Item;
                myInt: Integer;
            begin
                Items.reset();
                Items.setrange("No.", rec."No.");
                if Items.find('-') then begin
                    rec."Disposal Expiry" := Items."Disposal Date";
                    rec."Disposal Reason" := Items."Disposal Reason";
                end;
            end;
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify(Reserve)
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Reserved Qty. (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify("Line Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Job No.")
        {
            ApplicationArea = Basic;
        }
        modify("Work Type Code")
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
        modify("ShortcutDimCode[3]")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[4]")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[5]")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[6]")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[7]")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[8]")
        {
            ApplicationArea = Basic;
        }
        modify("Shipment Date")
        {
            ApplicationArea = Basic;
        }
        modify("Outstanding Quantity")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Customer No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reserve(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 52)".

        modify("Qty. to Ship")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Reserved Qty. (Base)"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Amount"(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job No."(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Type Code"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Date"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Outstanding Quantity"(Control 16)".

    }
    actions
    {
        modify("Show Document")
        {
            ApplicationArea = Basic;
        }
        modify("Reservation Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Item &Tracking Lines")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Show Document"(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reservation Entries"(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item &Tracking Lines"(Action 6500)".

    }
}
