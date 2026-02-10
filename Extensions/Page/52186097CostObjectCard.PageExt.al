#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186097 pageextension52186097 extends "Cost Object Card" 
{
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("Line Type")
        {
            ApplicationArea = Basic;
        }
        modify(Totaling)
        {
            ApplicationArea = Basic;
        }
        modify(Comment)
        {
            ApplicationArea = Basic;
        }
        modify("Net Change")
        {
            ApplicationArea = Basic;
        }
        modify("Sorting Order")
        {
            ApplicationArea = Basic;
        }
        modify("Blank Line")
        {
            ApplicationArea = Basic;
        }
        modify("New Page")
        {
            ApplicationArea = Basic;
        }
        modify(Blocked)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Type"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Totaling(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Comment(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Net Change"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sorting Order"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Blank Line"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""New Page"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Blocked(Control 19)".

    }
    actions
    {
        modify("E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify("&Balance")
        {
            ApplicationArea = Basic;
        }
        // modify(PageDimensionValues)
        // {

        //     //Unsupported feature: Property Modification (Name) on "PageDimensionValues(Action 7)".

        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Insertion (RunObject) on "PageDimensionValues(Action 7)".

        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""E&ntries"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Balance"(Action 5)".

        modify(PageDimensionValues)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "PageDimensionValues(Action 7)".

    }
}
