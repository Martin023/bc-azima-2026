#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185540 pageextension52185540 extends "Warranty Ledg. Entries Preview" 
{
    layout
    {
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Code")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify("Item No. (Serviced)")
        {
            ApplicationArea = Basic;
        }
        modify("Serial No. (Serviced)")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item Group (Serviced)")
        {
            ApplicationArea = Basic;
        }
        modify("Service Order No.")
        {
            ApplicationArea = Basic;
        }
        modify("Service Contract No.")
        {
            ApplicationArea = Basic;
        }
        modify("Fault Reason Code")
        {
            ApplicationArea = Basic;
        }
        modify("Fault Code")
        {
            ApplicationArea = Basic;
        }
        modify("Symptom Code")
        {
            ApplicationArea = Basic;
        }
        modify("Resolution Code")
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
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Work Type Code")
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Global Dimension 1 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Global Dimension 2 Code")
        {
            ApplicationArea = Basic;
        }
        modify(Open)
        {
            ApplicationArea = Basic;
        }
        modify("Vendor No.")
        {
            ApplicationArea = Basic;
        }
        modify("Vendor Item No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Customer No."(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No. (Serviced)"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serial No. (Serviced)"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item Group (Serviced)"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Order No."(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Contract No."(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fault Reason Code"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fault Code"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Symptom Code"(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resolution Code"(Control 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Type Code"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 1 Code"(Control 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 2 Code"(Control 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Open(Control 59)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor No."(Control 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor Item No."(Control 65)".

        modify("Dimension Set ID")
        {
            Visible = false;
        }
    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 3)".

        modify(SetDimensionFilter)
        {
            Visible = false;
        }
    }
}
