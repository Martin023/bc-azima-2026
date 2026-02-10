#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185961 pageextension52185961 extends "Aged Acc. Payable Chart" 
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
            MESSAGE(AgedAccPayable.Description(TRUE));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MESSAGE(AgedAccPayable.Description(PerVendor));
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ChartInformation(Action 11)".

    }

    var
        PerVendor: Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "No." <> xRec."No." THEN BEGIN
          VendorNo := "No.";
          UpdateChart;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF PerVendor AND ("No." <> xRec."No.") THEN BEGIN
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
        BusChartUserSetup.SaveSetupPage(BusChartUserSetup,PAGE::"Aged Acc. Payable Chart");
        */
    //end;


    //Unsupported feature: Code Modification on ""BusinessChart@-3::DataPointClicked"(EVENT 1)".

    //trigger "BusinessChart@-3::DataPointClicked"(EVENT 1)()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        BusinessChartBuffer.SetDrillDownIndexes(point);
        AgedAccPayable.DrillDown(BusinessChartBuffer,VendorNo,TempEntryNoAmountBuf);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        BusinessChartBuffer.SetDrillDownIndexes(point);
        IF PerVendor THEN
          AgedAccPayable.DrillDown(BusinessChartBuffer,VendorNo,TempEntryNoAmountBuf)
        ELSE
          AgedAccPayable.DrillDownByGroup(BusinessChartBuffer,TempEntryNoAmountBuf);
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

        IF VendorNo = '' THEN
          EXIT;

        IF UpdatedVendorNo = VendorNo THEN
          EXIT;

        BusinessChartBuffer."Period Filter Start Date" := WORKDATE;
        AgedAccPayable.UpdateDataPerVendor(BusinessChartBuffer,VendorNo,TempEntryNoAmountBuf);
        BusinessChartBuffer.Update(CurrPage.BusinessChart);
        UpdatedVendorNo := VendorNo;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        IF PerVendor AND (VendorNo = '') THEN
        #8..10
        IF PerVendor THEN
          AgedAccPayable.UpdateDataPerVendor(BusinessChartBuffer,VendorNo,TempEntryNoAmountBuf)
        ELSE
          AgedAccPayable.UpdateData(BusinessChartBuffer,TempEntryNoAmountBuf);
        BusinessChartBuffer.Update(CurrPage.BusinessChart);
        */
    //end;

    procedure SetPerVendor()
    begin
        PerVendor := true;
    end;

    //Unsupported feature: Property Modification (ExternalDataType) on ""BusinessChart@-3::DataPointClicked"(EVENT 1).point(Parameter 1000)".


    //Unsupported feature: Property Modification (ExternalDataType) on ""BusinessChart@-3::DataPointDoubleClicked"(EVENT 2).point(Parameter 1000)".

}
