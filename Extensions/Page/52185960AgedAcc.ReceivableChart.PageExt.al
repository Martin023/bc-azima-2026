#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185960 pageextension52185960 extends "Aged Acc. Receivable Chart" 
{
    layout
    {
        modify(StatusText)
        {
            ApplicationArea = Basic;
        }
        // modify(BusinessChart)
        // {
        //     ToolTip = 'Test';
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "StatusText(Control 2)".

    }
    actions
    {
        modify(DayPeriod)
        {
            ToolTip = 'Show pending payments summed for one day. Overdue payments are shown as amounts on specific days from the due date going back two weeks from today''s date.';
            ApplicationArea = Basic;
        }
        modify(WeekPeriod)
        {
            ApplicationArea = Basic;
        }
        modify(MonthPeriod)
        {
            ToolTip = 'Show pending payments summed for one month. Overdue payments are shown as amounts within specific months from the due date going back one year from today''s date.';
            ApplicationArea = Basic;
        }
        modify(QuarterPeriod)
        {
            ApplicationArea = Basic;
        }
        modify(YearPeriod)
        {
            ApplicationArea = Basic;
        }
        modify(All)
        {
            ApplicationArea = Basic;
        }
        modify(ChartInformation)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on "ChartInformation(Action 11).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MESSAGE(AgedAccReceivable.Description(TRUE));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MESSAGE(AgedAccReceivable.Description(PerCustomer));
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ChartInformation(Action 11)".

    }

    var
        PerCustomer: Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "No." <> xRec."No." THEN BEGIN
          CustomerNo := "No.";
          UpdateChart;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF PerCustomer AND ("No." <> xRec."No.") THEN BEGIN
        #2..4
        */
    //end;


    //Unsupported feature: Code Insertion on "OnClosePage".

    //trigger OnClosePage()
    //var
        //BusChartUserSetup: Record "Business Chart User Setup";
    //begin
        /*
        BusChartUserSetup."Period Length" := BusinessChartBuffer."Period Length";
        BusChartUserSetup.SaveSetupPage(BusChartUserSetup,PAGE::"Aged Acc. Receivable Chart");
        */
    //end;


    //Unsupported feature: Code Modification on ""BusinessChart@-3::DataPointClicked"(EVENT 1)".

    //trigger "BusinessChart@-3::DataPointClicked"(EVENT 1)()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        BusinessChartBuffer.SetDrillDownIndexes(point);
        AgedAccReceivable.DrillDown(BusinessChartBuffer,CustomerNo,TempEntryNoAmountBuf);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        BusinessChartBuffer.SetDrillDownIndexes(point);
        IF PerCustomer THEN
          AgedAccReceivable.DrillDown(BusinessChartBuffer,CustomerNo,TempEntryNoAmountBuf)
        ELSE
          AgedAccReceivable.DrillDownByGroup(BusinessChartBuffer,TempEntryNoAmountBuf);
        */
    //end;


    //Unsupported feature: Code Modification on "UpdatePage(PROCEDURE 2)".

    //procedure UpdatePage();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        EnableActions;
        UpdateStatusText;
        UpdateChart;
        SavePeriodSelection;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateChart(PROCEDURE 1)".

    //procedure UpdateChart();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF NOT isInitialized THEN
          EXIT;

        IF CustomerNo = '' THEN
          EXIT;

        IF UpdatedCustomerNo = CustomerNo THEN
          EXIT;

        BusinessChartBuffer."Period Filter Start Date" := WORKDATE;
        AgedAccReceivable.UpdateDataPerCustomer(BusinessChartBuffer,CustomerNo,TempEntryNoAmountBuf);
        BusinessChartBuffer.Update(CurrPage.BusinessChart);
        UpdatedCustomerNo := CustomerNo;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        IF PerCustomer AND (CustomerNo = '') THEN
        #8..10
        IF PerCustomer THEN
          AgedAccReceivable.UpdateDataPerCustomer(BusinessChartBuffer,CustomerNo,TempEntryNoAmountBuf)
        ELSE
          AgedAccReceivable.UpdateDataPerGroup(BusinessChartBuffer,TempEntryNoAmountBuf);
        BusinessChartBuffer.Update(CurrPage.BusinessChart);
        */
    //end;

    procedure SetPerCustomer()
    begin
        PerCustomer := true;
    end;

    //Unsupported feature: Property Modification (ExternalDataType) on ""BusinessChart@-3::DataPointClicked"(EVENT 1).point(Parameter 1000)".


    //Unsupported feature: Property Modification (ExternalDataType) on ""BusinessChart@-3::DataPointDoubleClicked"(EVENT 2).point(Parameter 1000)".

}
