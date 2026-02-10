#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185474 pageextension52185474 extends "Resource Groups" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Statistics)
        {
            ApplicationArea = Basic;
        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify("Dimensions-Single")
        {
            ApplicationArea = Basic;
        }
        modify("Dimensions-&Multiple")
        {
            ApplicationArea = Basic;
        }
        modify(Costs)
        {
            ApplicationArea = Basic;
        }
        modify(Prices)
        {
            ApplicationArea = Basic;
        }
        modify(ResGroupCapacity)
        {
            ApplicationArea = Basic;
        }
        modify("Res. Group All&ocated per Job")
        {
            ApplicationArea = Basic;
        }
        modify("Res. Group Allocated per Service &Order")
        {
            ApplicationArea = Basic;
        }
        modify("Res. Group Availa&bility")
        {
            ApplicationArea = Basic;
        }
        modify("New Resource")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimensions-Single"(Action 10)".


        //Unsupported feature: Code Modification on ""Dimensions-&Multiple"(Action 22).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(ResGr);
            DefaultDimMultiple.SetMultiRecord(ResGr,FIELDNO("No."));
            DefaultDimMultiple.RUNMODAL;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(ResGr);
            DefaultDimMultiple.SetMultiResGr(ResGr);
            DefaultDimMultiple.RUNMODAL;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimensions-&Multiple"(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Costs(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Prices(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ResGroupCapacity(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Res. Group All&ocated per Job"(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Res. Group Allocated per Service &Order"(Action 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Res. Group Availa&bility"(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""New Resource"(Action 1907852105)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
