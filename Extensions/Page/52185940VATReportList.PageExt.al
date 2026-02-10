#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185940 pageextension52185940 extends "VAT Report List" 
{
    Caption = 'VAT Report List';
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Report Config. Code")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Report Type")
        {
            ApplicationArea = Basic;
        }
        modify("Start Date")
        {
            ApplicationArea = Basic;
        }
        modify("End Date")
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Report Config. Code"(Control 4)".


        //Unsupported feature: Property Deletion (Visible) on ""VAT Report Config. Code"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Report Type"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Start Date"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""End Date"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 12)".

    }
    actions
    {
        modify(Card)
        {
            ApplicationArea = Basic;
        }
        // modify(ActionContainer5)
        // {
        //     Visible = false;
        // }
        modify("Create From VAT Return Period")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 18)".

        modify("Open VAT Return Period Card")
        {
            Visible = false;
        }
        modify("Report Setup")
        {
            Visible = false;
        }
    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (DeleteAllowed).


    //Unsupported feature: Property Deletion (SourceTableView).


    //Unsupported feature: Property Deletion (UsageCategory).

}
