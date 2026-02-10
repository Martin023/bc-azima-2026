#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186360 pageextension52186360 extends "Attendee Subform" 
{
    layout
    {
        modify("Attendance Type")
        {
            ApplicationArea = Basic;
        }
        modify("Attendee Type")
        {
            ApplicationArea = Basic;
        }
        modify("Attendee No.")
        {
            ApplicationArea = Basic;
        }
        modify("Attendee Name")
        {
            ApplicationArea = Basic;
        }
        modify("Send Invitation")
        {
            ApplicationArea = Basic;
        }
        modify("Invitation Response Type")
        {
            ApplicationArea = Basic;
        }
        modify("Invitation Sent")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Attendance Type"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Attendee Type"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Attendee No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Attendee Name"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Send Invitation"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invitation Response Type"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invitation Sent"(Control 14)".

    }
    actions
    {
        modify("Make &Phone Call")
        {
            ApplicationArea = Basic;
        }
        modify(Card)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Make &Phone Call"(Action 1901742104)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 1901313204)".

    }

    //Unsupported feature: Variable Insertion (Variable: SegLine) (VariableCollection) on "MakePhoneCall(PROCEDURE 2)".


    //Unsupported feature: Variable Insertion (Variable: Todo) (VariableCollection) on "MakePhoneCall(PROCEDURE 2)".


    //Unsupported feature: Code Modification on "MakePhoneCall(PROCEDURE 2)".

    //procedure MakePhoneCall();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Attendee Type" = "Attendee Type"::Salesperson THEN
          ERROR(Text004);
        IF Cont.GET("Attendee No.") THEN BEGIN
          IF Task.FindAttendeeTask(Task,Attendee) THEN
            TempSegmentLine."To-do No." := Task."No.";
          TempSegmentLine."Contact No." := Cont."No.";
          TempSegmentLine."Contact Company No." := Cont."Company No.";
          TempSegmentLine."Campaign No." := Task."Campaign No.";
          TempSegmentLine.CreatePhoneCall;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
          IF Todo.FindAttendeeTodo(Todo,Attendee) THEN
            SegLine."To-do No." := Todo."No.";
          SegLine."Contact No." := Cont."No.";
          SegLine."Contact Company No." := Cont."Company No.";
          SegLine."Campaign No." := Todo."Campaign No.";
          SegLine.CreateCall;
        END;
        */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "MakePhoneCall(PROCEDURE 2).TempSegmentLine(Variable 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "MakePhoneCall(PROCEDURE 2).Task(Variable 1000)".

}
