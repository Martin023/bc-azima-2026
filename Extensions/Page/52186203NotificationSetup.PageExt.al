#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186203 pageextension52186203 extends "Notification Setup" 
{

    //Unsupported feature: Property Insertion (DelayedInsert) on ""Notification Setup"(Page 1512)".

    layout
    {
        modify("Notification Type")
        {
            ApplicationArea = Basic;
        }
        modify("Notification Method")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Notification Method"(Control 5)".


            //Unsupported feature: Property Modification (Name) on ""Notification Method"(Control 5)".

        }
        modify(Schedule)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Notification Type"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Notification Method"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Schedule(Control 8)".

        // modify("Display Target")
        // {
        //     Visible = false;
        // }
        addafter("Notification Method")
        {
            // field("Non-Aggregated Notifications";"Non-Aggregated Notifications")
            // {
            //     ApplicationArea = Basic;
            // }
        }
    }
    actions
    {
        modify("Notification Schedule")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Notification Schedule"(Action 7)".

    }


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF NOT HASFILTER THEN
          SETRANGE("User ID","User ID");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF NOT HASFILTER THEN
          SETRANGE("User ID",'');
        */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
