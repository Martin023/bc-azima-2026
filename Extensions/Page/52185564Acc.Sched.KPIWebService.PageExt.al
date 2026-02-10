#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185564 pageextension52185564 extends "Acc. Sched. KPI Web Service"
{

    //Unsupported feature: Property Modification (SourceTable) on ""Acc. Sched. KPI Web Service"(Page 197)".

    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""No."(Control 3)".


            //Unsupported feature: Property Modification (Name) on ""No."(Control 3)".

        }
        modify(Date)
        {
            ApplicationArea = Basic;
        }
        modify("Closed Period")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Closed Period"(Control 16)".

        }
        modify("Account Schedule Name")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Account Schedule Name"(Control 13)".

        }
        modify("KPI Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""KPI Code"(Control 18)".

        }
        modify("KPI Name")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""KPI Name"(Control 4)".

        }
        modify("Net Change Actual")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Net Change Actual"(Control 5)".

        }
        modify("Balance at Date Actual")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Balance at Date Actual"(Control 6)".

        }
        modify("Net Change Budget")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Net Change Budget"(Control 7)".

        }
        modify("Balance at Date Budget")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Balance at Date Budget"(Control 8)".

        }
        modify("Net Change Actual Last Year")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Net Change Actual Last Year"(Control 9)".

        }
        modify("Balance at Date Actual Last Year")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Balance at Date Actual Last Year"(Control 10)".

        }
        modify("Net Change Budget Last Year")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Net Change Budget Last Year"(Control 11)".

        }
        modify("Balance at Date Budget Last Year")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Balance at Date Budget Last Year"(Control 12)".

        }
        modify("Net Change Forecast")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Net Change Forecast"(Control 15)".

        }
        modify("Balance at Date Forecast")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Balance at Date Forecast"(Control 14)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Date(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Closed Period"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Account Schedule Name"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""KPI Code"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""KPI Name"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Net Change Actual"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Balance at Date Actual"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Net Change Budget"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Balance at Date Budget"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Net Change Actual Last Year"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Balance at Date Actual Last Year"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Net Change Budget Last Year"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Balance at Date Budget Last Year"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Net Change Forecast"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Balance at Date Forecast"(Control 14)".

    }
    var
        AccSchedKPIWebSrvSetup: Record "Acc. Sched. KPI Web Srv. Setup";
        TempAccScheduleLine: Record "Acc. Schedule Line" temporary;
        TempColumnLayout: Record "Column Layout" temporary;
        AccSchedManagement: Codeunit AccSchedManagement;
        NoOfActiveAccSchedLines: Integer;
        NoOfLines: Integer;
        StartDate: Date;
        EndDate: Date;
        LastClosedDate: Date;
        AccScheduleName: Code[10];
        KPICode: Code[10];
        KPIName: Text;
        ColumnValue: array[10] of Decimal;
        Date: Date;
        ClosedPeriod: Boolean;


    //Unsupported feature: Code Insertion on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //begin
    /*
    CalcValues;
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CODEUNIT.RUN(CODEUNIT::"Update Acc. Sched. KPI Data");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    InitSetupData;
    FILTERGROUP(2);
    SETRANGE(Number,0,NoOfLines - 1);
    FILTERGROUP(0);
    */
    //end;

    local procedure InitSetupData()
    var
        AccSchedKPIWebSrvLine: Record "Acc. Sched. KPI Web Srv. Line";
        AccScheduleLine: Record "Acc. Schedule Line";
        ColumnLayout: Record "Column Layout";
    begin
        AccSchedKPIWebSrvSetup.Get;
        // AccSchedKPIWebSrvSetup.TestValues;
        AccSchedKPIWebSrvLine.FindSet;
        AccScheduleLine.SetRange(Show, AccScheduleLine.Show::Yes);
        AccScheduleLine.SetFilter(Totaling, '<>%1', '');
        repeat
            AccScheduleLine.SetRange("Schedule Name", AccSchedKPIWebSrvLine."Acc. Schedule Name");
            AccScheduleLine.FindSet;
            repeat
                NoOfActiveAccSchedLines += 1;
                TempAccScheduleLine := AccScheduleLine;
                TempAccScheduleLine."Line No." := NoOfActiveAccSchedLines;
                TempAccScheduleLine.Insert;
            until AccScheduleLine.Next = 0;
        until AccSchedKPIWebSrvLine.Next = 0;

        begin
            // Net Change Actual
            // InsertTempColumn("Column Layout Type"::"Net Change","Column Layout Type"::Entries,false);
            // Balance at Date Actual
            // InsertTempColumn("Column Layout Type"::"Balance at Date","Column Layout Type"::Entries,false);
            // // Net Change Budget
            // InsertTempColumn("Column Layout Type"::"Net Change","Column Layout Type"::"Budget Entries",false);
            // // Balance at Date Budget
            // InsertTempColumn("Column Layout Type"::"Balance at Date","Column Layout Type"::"Budget Entries",false);
            // // Net Change Actual Last Year
            // InsertTempColumn("Column Layout Type"::"Net Change","Column Layout Type"::Entries,true);
            // // Balance at Date Actual Last Year
            // InsertTempColumn("Column Layout Type"::"Balance at Date","Column Layout Type"::Entries,true);
            // // Net Change Budget Last Year
            // InsertTempColumn("Column Layout Type"::"Net Change","Column Layout Type"::"Budget Entries",true);
            // // Balance at Date Budget Last Year
            // InsertTempColumn("Column Layout Type"::"Balance at Date","Column Layout Type"::"Budget Entries",true);
        end;

        AccSchedKPIWebSrvSetup.GetPeriodLength(NoOfLines, StartDate, EndDate);
        NoOfLines *= NoOfActiveAccSchedLines;
        LastClosedDate := AccSchedKPIWebSrvSetup.GetLastClosedAccDate;
    end;

    local procedure InsertTempColumn(ColumnType: Enum "Column Layout Type"; EntryType: Enum "Column Layout Type"; LastYear: Boolean)
    begin
        begin
            if TempColumnLayout.FindLast then;
            TempColumnLayout.Init;
            TempColumnLayout."Line No." += 10000;
            //   Temp"Column Layout Type" := ColumnType;
            //   Temp"Column Layout Type" := EntryType;
            if LastYear then
                Evaluate(TempColumnLayout."Comparison Date Formula", '<-1Y>');
            TempColumnLayout.Insert;
        end;
    end;

    local procedure CalcValues()
    var
        ToDate: Date;
        ColNo: Integer;
    begin
        // Rec.Date := AccSchedKPIWebSrvSetup.CalcNextStartDate(StartDate,Rec.Number DIV NoOfActiveAccSchedLines);
        // ToDate := AccSchedKPIWebSrvSetup.CalcNextStartDate(Rec.Date,1) - 1;
        // TempAccScheduleLine.FindSet;
        // if Rec.Number MOD NoOfActiveAccSchedLines > 0 then
        //   TempAccScheduleLine.Next(Number MOD NoOfActiveAccSchedLines);
        AccScheduleName := TempAccScheduleLine."Schedule Name";
        TempAccScheduleLine.SetRange("Date Filter", Rec.Date, ToDate);
        TempAccScheduleLine.SetRange("G/L Budget Filter", AccSchedKPIWebSrvSetup."G/L Budget Name");

        KPICode := TempAccScheduleLine."Row No.";
        KPIName := TempAccScheduleLine.Description;

        ColNo := 0;
        TempColumnLayout.FindSet;
        repeat
            ColNo += 1;
            ColumnValue[ColNo] := AccSchedManagement.CalcCell(TempAccScheduleLine, TempColumnLayout, false);
        until TempColumnLayout.Next = 0;

        ClosedPeriod := Rec.Date <= LastClosedDate;
        // Forecasted values
        if ((AccSchedKPIWebSrvSetup."Forecasted Values Start" = AccSchedKPIWebSrvSetup."forecasted values start"::"After Latest Closed Period") and not ClosedPeriod) or
   ((AccSchedKPIWebSrvSetup."Forecasted Values Start" = AccSchedKPIWebSrvSetup."forecasted values start"::"After Current Date") and (Date > WorkDate))
then begin
            ColumnValue[9] := ColumnValue[3]; // Net Change Budget
            ColumnValue[10] := ColumnValue[4]; // Balance at Date Budget
        end else begin
            ColumnValue[9] := ColumnValue[1]; // Net Change Actual
            ColumnValue[10] := ColumnValue[2]; // Balance at Date Actual
        end;
    end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).

}
