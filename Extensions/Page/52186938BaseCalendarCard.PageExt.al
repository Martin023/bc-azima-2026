#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186938 pageextension52186938 extends "Base Calendar Card" 
{
    layout
    {
        // modify("Code")
        // {
        //     ApplicationArea = Basic;
        // }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("Customized Changes Exist")
        {
            ApplicationArea = Basic;
        }
        modify("Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customized Changes Exist"(Control 6)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "BaseCalendarEntries(Control 23)".


        //Unsupported feature: Property Deletion (PartType) on "BaseCalendarEntries(Control 23)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("&Where-Used List")
        {
            ApplicationArea = Basic;
        }
        modify("&Maintain Base Calendar Changes")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Where-Used List"(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Maintain Base Calendar Changes"(Action 9)".

    }

    //Unsupported feature: Property Modification (Id) on ""&Where-Used List"(Action 10).OnAction.CalendarMgt(Variable 1000)".

    //var
        //>>>> ORIGINAL VALUE:
        //"&Where-Used List" : 1000;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"&Where-Used List" : 1002;
        //Variable type has not been exported.
}
