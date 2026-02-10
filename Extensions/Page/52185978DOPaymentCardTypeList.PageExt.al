#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185978 pageextension52185978 extends "Workflow Webhook Entries"
{

    //Unsupported feature: Property Modification (Name) on ""Workflow Webhook Entries"(Page 830)".

    Caption = 'Card Type List';

    //Unsupported feature: Property Modification (SourceTable) on ""Workflow Webhook Entries"(Page 830)".


    //Unsupported feature: Property Modification (SourceTableView) on ""Workflow Webhook Entries"(Page 830)".

    layout
    {

        //Unsupported feature: Property Modification (Level) on "Control1(Control 1)".


        //Unsupported feature: Property Modification (ControlType) on "Control1(Control 1)".


        //Unsupported feature: Property Insertion (GroupType) on "Control1(Control 1)".

        // modify(Group)
        // {

        //     //Unsupported feature: Property Modification (Level) on "Group(Control 2)".


        //     //Unsupported feature: Property Modification (ControlType) on "Group(Control 2)".


        //     //Unsupported feature: Property Modification (Name) on "Group(Control 2)".


        //     //Unsupported feature: Property Insertion (SourceExpr) on "Group(Control 2)".

        //     //ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ContainerType) on "Control1(Control 1)".


        //Unsupported feature: Property Deletion (GroupType) on "Group(Control 2)".

        modify(RecordIDText)
        {
            Visible = false;
        }
        modify("Date-Time Initiated")
        {
            Visible = false;
        }
        modify("Initiated By User ID")
        {
            Visible = false;
        }
        modify(Response)
        {
            Visible = false;
        }
        modify("Last Modified By User ID")
        {
            Visible = false;
        }
        modify("Last Date-Time Modified")
        {
            Visible = false;
        }
        modify(NotificationStatusText)
        {
            Visible = false;
        }
        modify(NotificationErrorText)
        {
            Visible = false;
        }
        addfirst(content)
        {
        }
    }
    actions
    {
        // modify("Action")
        // {
        //     Visible = false;
        // }
        modify(CancelRequest)
        {
            Visible = false;
        }
        modify(Resubmit)
        {
            Visible = false;
        }
        modify(Refresh)
        {
            Visible = false;
        }
        modify("Record")
        {
            Visible = false;
        }
    }

    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT ShowAllResponses THEN
      SETFILTER(Response,FORMAT(Response::Pending));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF NOT FINDFIRST THEN
      CreateDefaults;
    */
    //end;

    //Unsupported feature: Property Deletion (Editable).


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
