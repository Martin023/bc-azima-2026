#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185539 pageextension52185539 extends "Resource Ledg. Entries Preview" 
{
    layout
    {
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Entry Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Resource No.")
        {
            ApplicationArea = Basic;
        }
        modify("Resource Group No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Job No.")
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
        modify("Work Type Code")
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
        modify("Direct Unit Cost")
        {
            ApplicationArea = Basic;
        }
        modify("Unit Cost")
        {
            ApplicationArea = Basic;
        }
        modify("Total Cost")
        {
            ApplicationArea = Basic;
        }
        modify("Unit Price")
        {
            ApplicationArea = Basic;
        }
        modify("Total Price")
        {
            ApplicationArea = Basic;
        }
        modify(Chargeable)
        {
            ApplicationArea = Basic;
        }
        modify("User ID")
        {
            ApplicationArea = Basic;
        }
        modify("Source Code")
        {
            ApplicationArea = Basic;
        }
        modify("Reason Code")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry Type"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource No."(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource Group No."(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job No."(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 1 Code"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 2 Code"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Type Code"(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Direct Unit Cost"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost"(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Cost"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Price"(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Price"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Chargeable(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""User ID"(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Code"(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reason Code"(Control 37)".

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

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 51)".

        modify(SetDimensionFilter)
        {
            Visible = false;
        }
    }
}
