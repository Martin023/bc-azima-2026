#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186942 pageextension52186942 extends "Base Calendar Entries Subform"
{
    layout
    {
        modify(CurrentCalendarCode)
        {
            ApplicationArea = Basic;
        }
        modify("Period Start")
        {
            ApplicationArea = Basic;
        }
        modify("Period Name")
        {
            ApplicationArea = Basic;
        }
        modify(WeekNo)
        {
            ApplicationArea = Basic;
        }
        modify(Nonworking)
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentCalendarCode(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Start"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Name"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "WeekNo(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Nonworking(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".

    }

    //Unsupported feature: Property Modification (Id) on "CurrentCalendarCode(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //CurrentCalendarCode : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CurrentCalendarCode : 1003;
    //Variable type has not been exported.

    var
        ItemPeriodLength: Option Day,Week,Month,Quarter,Year,Period;


    //Unsupported feature: Code Modification on "OnFindRecord".

    //trigger OnFindRecord()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    EXIT(PeriodFormMgt.FindDate(Which,Rec,PeriodType));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    EXIT(PeriodFormMgt.FindDate(Which,Rec,ItemPeriodLength));
    */
    //end;


    //Unsupported feature: Code Modification on "OnNextRecord".

    //trigger OnNextRecord()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    EXIT(PeriodFormMgt.NextDate(Steps,Rec,PeriodType));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    EXIT(PeriodFormMgt.NextDate(Steps,Rec,ItemPeriodLength));
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetCalendarCode(PROCEDURE 1)".


    local procedure ShowMonthlyCalendar()
    var
        GraphicCalendar: Page "Monthly Calendar";
    begin
        // GraphicCalendar.SetCalendarCode(1,0,'','',CurrentCalendarCode,"Period Start");
        GraphicCalendar.Run;
    end;
}
