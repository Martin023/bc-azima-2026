#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186438 pageextension52186438 extends "Item Availability by Variant"
{
    layout
    {
        modify(PeriodType)
        {
            ToolTip = 'Day';
            OptionCaption = 'Day,Week,Month,Quarter,Year,Period';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "PeriodType(Control 33)".


            //Unsupported feature: Property Modification (Name) on "PeriodType(Control 33)".

        }
        modify(AmountType)
        {
            ToolTip = 'Net Change';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on "PeriodType(Control 33).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        FindPeriod('');
        UpdateSubForm;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF ItemPeriodLength = ItemPeriodLength::Period THEN
          PeriodItemPeriodLengthOnValida;
        IF ItemPeriodLength = ItemPeriodLength::Year THEN
          YearItemPeriodLengthOnValidate;
        IF ItemPeriodLength = ItemPeriodLength::Quarter THEN
          QuarterItemPeriodLengthOnValid;
        IF ItemPeriodLength = ItemPeriodLength::Month THEN
          MonthItemPeriodLengthOnValidat;
        IF ItemPeriodLength = ItemPeriodLength::Week THEN
          WeekItemPeriodLengthOnValidate;
        IF ItemPeriodLength = ItemPeriodLength::Day THEN
          DayItemPeriodLengthOnValidate;
        */
        //end;


        //Unsupported feature: Code Modification on "AmountType(Control 34).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        FindPeriod('');
        UpdateSubForm;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF AmountType = AmountType::"Balance at Date" THEN
          BalanceatDateAmountTypeOnValid;
        IF AmountType = AmountType::"Net Change" THEN
          NetChangeAmountTypeOnValidate;
        */
        //end;
        modify(DateFilter)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "ItemAvailLocLines(Control 1)".

    }
    actions
    {
        modify("<Action4>")
        {
            ApplicationArea = Basic;
        }
        modify(Period)
        {
            ApplicationArea = Basic;
        }
        modify(Location)
        {
            ApplicationArea = Basic;
        }
        modify("BOM Level")
        {
            ApplicationArea = Basic;
        }
        modify(PreviousPeriod)
        {

            //Unsupported feature: Property Modification (Name) on "PreviousPeriod(Action 27)".

            ToolTip = 'Previous Period';
            ApplicationArea = Basic;
        }
        modify(NextPeriod)
        {

            //Unsupported feature: Property Modification (Name) on "NextPeriod(Action 26)".

            ToolTip = 'Next Period';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""<Action4>"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Period(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Location(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BOM Level"(Action 5)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "PreviousPeriod(Action 27)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "PreviousPeriod(Action 27)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "NextPeriod(Action 26)".

        addafter(Period)
        {
            action(Variant)
            {
                ApplicationArea = Basic;
                Caption = 'Variant';
                Image = ItemVariant;
                RunObject = Page "Item Availability by Variant";
                RunPageLink = "No." = field("No."),
                              "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = field("Global Dimension 2 Filter"),
                              "Location Filter" = field("Location Filter"),
                              "Drop Shipment Filter" = field("Drop Shipment Filter"),
                              "Variant Filter" = field("Variant Filter");
            }
        }
    }

    var
        ItemPeriodLength: Option Day,Week,Month,Quarter,Year,Period;


    //Unsupported feature: Code Modification on "FindPeriod(PROCEDURE 2)".

    //procedure FindPeriod();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF GETFILTER("Date Filter") <> '' THEN BEGIN
      Calendar.SETFILTER("Period Start",GETFILTER("Date Filter"));
      IF NOT PeriodFormMgt.FindDate('+',Calendar,PeriodType) THEN
        PeriodFormMgt.FindDate('+',Calendar,PeriodType::Day);
      Calendar.SETRANGE("Period Start");
    END;
    PeriodFormMgt.FindDate(SearchText,Calendar,PeriodType);
    IF AmountType = AmountType::"Net Change" THEN BEGIN
      SETRANGE("Date Filter",Calendar."Period Start",Calendar."Period End");
      IF GETRANGEMIN("Date Filter") = GETRANGEMAX("Date Filter") THEN
        SETRANGE("Date Filter",GETRANGEMIN("Date Filter"));
    END ELSE
      SETRANGE("Date Filter",0D,Calendar."Period End");
    DateFilter := GETFILTER("Date Filter");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF GETFILTER("Date Filter") <> '' THEN BEGIN
      Calendar.SETFILTER("Period Start",GETFILTER("Date Filter"));
      IF NOT PeriodFormMgt.FindDate('+',Calendar,ItemPeriodLength) THEN
        PeriodFormMgt.FindDate('+',Calendar,ItemPeriodLength::Day);
      Calendar.SETRANGE("Period Start");
    END;
    PeriodFormMgt.FindDate(SearchText,Calendar,ItemPeriodLength);
    #8..13
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "GetLastVariant(PROCEDURE 3)".


    local procedure PeriodItemPeriodLengthOnPush()
    begin
        // FindPeriod('');
        UpdateSubForm;
    end;

    local procedure YearItemPeriodLengthOnPush()
    begin
        //FindPeriod('');
        UpdateSubForm;
    end;

    local procedure QuarterItemPeriodLengthOnPush()
    begin
        //FindPeriod('');
        UpdateSubForm;
    end;

    local procedure MonthItemPeriodLengthOnPush()
    begin
        //FindPeriod('');
        UpdateSubForm;
    end;

    local procedure WeekItemPeriodLengthOnPush()
    begin
        //FindPeriod('');
        UpdateSubForm;
    end;

    local procedure DayItemPeriodLengthOnPush()
    begin
        // FindPeriod('');
        UpdateSubForm;
    end;

    local procedure NetChangeAmountTypeOnPush()
    begin
        //FindPeriod('');
        UpdateSubForm;
    end;

    local procedure BalanceatDateAmountTypeOnPush()
    begin
        // FindPeriod('');
        UpdateSubForm;
    end;

    local procedure DayItemPeriodLengthOnValidate()
    begin
        DayItemPeriodLengthOnPush;
    end;

    local procedure WeekItemPeriodLengthOnValidate()
    begin
        WeekItemPeriodLengthOnPush;
    end;

    local procedure MonthItemPeriodLengthOnValidat()
    begin
        MonthItemPeriodLengthOnPush;
    end;

    local procedure QuarterItemPeriodLengthOnValid()
    begin
        QuarterItemPeriodLengthOnPush;
    end;

    local procedure YearItemPeriodLengthOnValidate()
    begin
        YearItemPeriodLengthOnPush;
    end;

    local procedure PeriodItemPeriodLengthOnValida()
    begin
        PeriodItemPeriodLengthOnPush;
    end;

    local procedure NetChangeAmountTypeOnValidate()
    begin
        NetChangeAmountTypeOnPush;
    end;

    local procedure BalanceatDateAmountTypeOnValid()
    begin
        BalanceatDateAmountTypeOnPush;
    end;

    //Unsupported feature: Property Modification (Length) on "FindPeriod(PROCEDURE 2).SearchText(Parameter 1000)".


    //Unsupported feature: Property Modification (Data type) on "FindPeriod(PROCEDURE 2).SearchText(Parameter 1000)".

}
