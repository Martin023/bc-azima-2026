#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185998 pageextension52185998 extends "Cash Flow Forecast Chart"
{

    //Unsupported feature: Property Modification (Name) on ""Cash Flow Forecast Chart"(Page 869)".

    Caption = 'Cash Flow';
    layout
    {

        //Unsupported feature: Property Modification (Name) on "Control1(Control 1)".

        modify(StatusText)
        {
            ApplicationArea = Basic;
        }
        modify(BusinessChart)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "StatusText(Control 12)".


        //Unsupported feature: Property Deletion (Visible) on "StatusText(Control 12)".


        //Unsupported feature: Property Deletion (Visible) on "BusinessChart(Control 5)".

        modify(NotSetupLbl)
        {
            Visible = false;
        }
    }
    actions
    {

        //Unsupported feature: Property Modification (ActionType) on ""Chart Options"(Action 25)".


        //Unsupported feature: Property Modification (Name) on ""Chart Options"(Action 25)".


        //Unsupported feature: Property Modification (Level) on "Show(Action 9)".

        modify(AccumulatedCash)
        {

            //Unsupported feature: Property Modification (Level) on "AccumulatedCash(Action 20)".

            ApplicationArea = Basic;
        }
        modify(ChangeInCash)
        {

            //Unsupported feature: Property Modification (Level) on "ChangeInCash(Action 19)".

            ApplicationArea = Basic;
        }
        modify(Combined)
        {

            //Unsupported feature: Property Modification (Level) on "Combined(Action 21)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Modification (Level) on "StartDate(Action 15)".

        modify(FisrtEntryDate)
        {

            //Unsupported feature: Property Modification (Level) on "FisrtEntryDate(Action 11)".

            ApplicationArea = Basic;
        }
        modify(WorkDate)
        {

            //Unsupported feature: Property Modification (Level) on "WorkDate(Action 10)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Modification (Level) on "PeriodLength(Action 14)".

        modify(Day)
        {

            //Unsupported feature: Property Modification (Level) on "Day(Action 7)".

            ApplicationArea = Basic;
        }
        modify(Week)
        {

            //Unsupported feature: Property Modification (Level) on "Week(Action 8)".

            ApplicationArea = Basic;
        }
        modify(Month)
        {

            //Unsupported feature: Property Modification (Level) on "Month(Action 4)".

            ApplicationArea = Basic;
        }
        modify(Quarter)
        {

            //Unsupported feature: Property Modification (Level) on "Quarter(Action 6)".

            ApplicationArea = Basic;
        }
        modify(Year)
        {

            //Unsupported feature: Property Modification (Level) on "Year(Action 3)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Modification (Level) on "GroupBy(Action 16)".

        modify(PosNeg)
        {

            //Unsupported feature: Property Modification (Level) on "PosNeg(Action 17)".

            ApplicationArea = Basic;
        }
        modify(Account)
        {

            //Unsupported feature: Property Modification (Level) on "Account(Action 18)".

            ApplicationArea = Basic;
        }
        modify(SourceType)
        {

            //Unsupported feature: Property Modification (Level) on "SourceType(Action 22)".

            ApplicationArea = Basic;
        }
        modify("Recalculate Forecast")
        {

            //Unsupported feature: Property Modification (Name) on ""Recalculate Forecast"(Action 26)".

            Caption = 'Refresh';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Chart Options"(Action 25)".


        //Unsupported feature: Property Deletion (Visible) on ""Chart Options"(Action 25)".


        //Unsupported feature: Property Deletion (Visible) on "Show(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AccumulatedCash(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ChangeInCash(Action 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Combined(Action 21)".


        //Unsupported feature: Property Deletion (Visible) on "StartDate(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "FisrtEntryDate(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "WorkDate(Action 10)".


        //Unsupported feature: Property Deletion (Visible) on "PeriodLength(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Day(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Week(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Month(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quarter(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Year(Action 3)".


        //Unsupported feature: Property Deletion (Visible) on "GroupBy(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PosNeg(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Account(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SourceType(Action 22)".

        modify("Manual Adjustment")
        {
            Visible = false;
        }
        modify("Edit Manual Revenues")
        {
            Visible = false;
        }
        modify("Edit Manual Expenses")
        {
            Visible = false;
        }
        modify("Open Assisted Setup")
        {
            Visible = false;
        }

        //Unsupported feature: Code Modification on ""Recalculate Forecast"(Action 26).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        RecalculateAndUpdateChart;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        NeedsUpdate := TRUE;
        UpdateStatus;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Recalculate Forecast"(Action 26)".


        //Unsupported feature: Property Deletion (Visible) on ""Recalculate Forecast"(Action 26)".

        modify(ChartInformation)
        {
            Visible = false;
        }
        //moveafter(ActionContainer2;Show)
    }


    //Unsupported feature: Code Modification on "OnFindRecord".

    //trigger OnFindRecord()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    UpdateChart;
    IsChartDataReady := TRUE;
    IF NOT IsCashFlowSetUp THEN
      EXIT(TRUE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    UpdateChart;
    IsChartDataReady := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateChart(PROCEDURE 6)".

    //procedure UpdateChart();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT NeedsUpdate THEN
      EXIT;
    IF NOT IsChartAddInReady THEN
      EXIT;
    IF NOT IsCashFlowSetUp THEN
      EXIT;

    IF CashFlowChartMgt.UpdateData(Rec) THEN
      Update(CurrPage.BusinessChart);
    UpdateStatus;

    NeedsUpdate := FALSE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    #8..12
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateStatus(PROCEDURE 8)".

    //procedure UpdateStatus();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    NeedsUpdate := NeedsUpdate OR IsSetupChanged;
    IF NOT NeedsUpdate THEN
      EXIT;

    OldCashFlowChartSetup := CashFlowChartSetup;
    StatusText := CashFlowChartSetup.GetCurrentSelectionText;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    NeedsUpdate := NeedsUpdate OR IsSetupChanged;

    OldCashFlowChartSetup := CashFlowChartSetup;

    IF NeedsUpdate THEN
      StatusText := CashFlowChartSetup.GetCurrentSelectionText;
    */
    //end;

    //Unsupported feature: Property Modification (ExternalDataType) on ""BusinessChart@-5::DataPointClicked"(EVENT 12).point(Parameter 1000)".


    //Unsupported feature: Property Modification (ExternalDataType) on ""BusinessChart@-5::DataPointDoubleClicked"(EVENT 13).point(Parameter 1000)".


    //Unsupported feature: Property Deletion (ShowFilter).

}
