#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186032 pageextension52186032 extends "Manager Time Sheet List" 
{
    Caption = 'Manager Time Sheet List';
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
        modify("Open Exists")
        {
            ApplicationArea = Basic;
        }
        modify("Submitted Exists")
        {
            ApplicationArea = Basic;
        }
        modify("Rejected Exists")
        {
            ApplicationArea = Basic;
        }
        modify("Approved Exists")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Exists")
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


        //Unsupported feature: Property Deletion (ToolTipML) on ""Open Exists"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Submitted Exists"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Rejected Exists"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Approved Exists"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Exists"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Comment(Control 17)".

    }
    actions
    {
        // modify("&Edit Time Sheet")
        // {
        //     ApplicationArea = Basic;
        // }
        modify(Comments)
        {
            ApplicationArea = Basic;
        }
        modify("Posting E&ntries")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Edit Time Sheet"(Action 5)".

        modify(MoveTimeSheetsToArchive)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Comments(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting E&ntries"(Action 16)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
