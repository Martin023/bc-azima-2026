#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186943 pageextension52186943 extends "Customized Cal. Entries Subfm" 
{
    layout
    {
        // modify(CurrentSourceType)
        // {
        //     ApplicationArea = Basic;
        // }
        // modify(CurrentSourceCode)
        // {
        //     ApplicationArea = Basic;
        // }
        // modify(CurrentAdditionalSourceCode)
        // {
        //     ApplicationArea = Basic;
        // }
        // modify(CurrentCalendarCode)
        // {
        //     ApplicationArea = Basic;
        // }
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

        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentSourceType(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentSourceCode(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentAdditionalSourceCode(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentCalendarCode(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Start"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Name"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "WeekNo(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Nonworking(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".

    }

    //Unsupported feature: Property Modification (Id) on "PeriodFormMgt(Variable 1000)".

    //var
        //>>>> ORIGINAL VALUE:
        //PeriodFormMgt : 1000;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //PeriodFormMgt : 1006;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (OptionString) on "CurrentSourceType(Variable 1007)".

    //var
        //>>>> ORIGINAL VALUE:
        //CurrentSourceType : Company,Customer,Vendor,Location,"Shipping Agent",Service;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CurrentSourceType : Company,Customer,Vendor,Location,"Shipping Agent";
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


    local procedure GetCurrentDate(): Date
    begin
        //exit("Period Start");
    end;
}
