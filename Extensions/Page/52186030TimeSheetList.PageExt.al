#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186030 pageextension52186030 extends "Time Sheet List" 
{
    Caption = 'Time Sheet List';
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Starting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Ending Date")
        {
            ApplicationArea = Basic;
        }
        modify("Resource No.")
        {
            ApplicationArea = Basic;
        }
        modify(Comment)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Date"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ending Date"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Comment(Control 10)".

    }
    actions
    {
        modify("Create Time Sheets")
        {
            ApplicationArea = Basic;
        }
        // modify(EditTimeSheet)
        // {

        //     //Unsupported feature: Property Modification (Name) on "EditTimeSheet(Action 5)".

        //     ApplicationArea = Basic;
        // }
        modify(Comments)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Time Sheets"(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "EditTimeSheet(Action 5)".

        modify(MoveTimeSheetsToArchive)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Comments(Action 8)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
