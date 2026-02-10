// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52186185 pageextension52186185 extends "Generic Chart" 
// {

//     //Unsupported feature: Property Modification (Name) on ""Generic Chart"(Page 1390)".

//     layout
//     {
//         modify("Status Text")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(BusinessChart)
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Status Text"(Control 2)".

//     }
//     actions
//     {

//         //Unsupported feature: Property Modification (Name) on "ActionContainer6000(Action 6000)".

//         modify("Select Chart")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Previous Chart")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Next Chart")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Day)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Week)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Month)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Quarter)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Year)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(PreviousPeriod)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(NextPeriod)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(ChartInformation)
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Code Modification on ""Select Chart"(Action 6001).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             ChartManagement.SelectChart(Rec,SelectedChartDefinition);
//             InitializeSelectedChart;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             MiniChartManagement.SelectChart(Rec,SelectedMiniChartDefinition);
//             InitializeSelectedChart;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Select Chart"(Action 6001)".



//         //Unsupported feature: Code Modification on ""Previous Chart"(Action 7002).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             SelectedChartDefinition.SETRANGE(Enabled,TRUE);
//             IF SelectedChartDefinition.NEXT(-1) = 0 THEN
//               IF NOT SelectedChartDefinition.FINDLAST THEN
//                 EXIT;
//             InitializeSelectedChart;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             SelectedMiniChartDefinition.SETRANGE(Enabled,TRUE);
//             IF SelectedMiniChartDefinition.NEXT(-1) = 0 THEN
//               SelectedMiniChartDefinition.FINDLAST;
//             InitializeSelectedChart;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Previous Chart"(Action 7002)".



//         //Unsupported feature: Code Modification on ""Next Chart"(Action 7000).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             SelectedChartDefinition.SETRANGE(Enabled,TRUE);
//             IF SelectedChartDefinition.NEXT = 0 THEN
//               IF NOT SelectedChartDefinition.FINDFIRST THEN
//                 EXIT;
//             InitializeSelectedChart;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             SelectedMiniChartDefinition.SETRANGE(Enabled,TRUE);
//             IF SelectedMiniChartDefinition.NEXT = 0 THEN
//               SelectedMiniChartDefinition.FINDFIRST;
//             InitializeSelectedChart;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Next Chart"(Action 7000)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Day(Action 7006)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Week(Action 7005)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Month(Action 7004)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Quarter(Action 7003)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Year(Action 7001)".



//         //Unsupported feature: Code Modification on "PreviousPeriod(Action 6003).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             ChartManagement.UpdateChart(SelectedChartDefinition,Rec,Period::Previous);
//             Update(CurrPage.BusinessChart);
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             MiniChartManagement.UpdateChart(SelectedMiniChartDefinition,Rec,Period::Previous);
//             Update(CurrPage.BusinessChart);
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "PreviousPeriod(Action 6003)".



//         //Unsupported feature: Code Modification on "NextPeriod(Action 6002).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             ChartManagement.UpdateChart(SelectedChartDefinition,Rec,Period::Next);
//             Update(CurrPage.BusinessChart);
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             MiniChartManagement.UpdateChart(SelectedMiniChartDefinition,Rec,Period::Next);
//             Update(CurrPage.BusinessChart);
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "NextPeriod(Action 6002)".



//         //Unsupported feature: Code Modification on "ChartInformation(Action 4).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             IF StatusText = '' THEN
//               EXIT;
//             Description := ChartManagement.ChartDescription(SelectedChartDefinition);
//             IF Description = '' THEN
//               MESSAGE(NoDescriptionMsg)
//             ELSE
//               MESSAGE(Description);
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             IF StatusText = '' THEN
//               EXIT;
//             Description := MiniChartManagement.ChartDescription(SelectedMiniChartDefinition);
//             #4..7
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "ChartInformation(Action 4)".

//     }

//     var
//         SelectedMiniChartDefinition: Record "Chart Definition";
//         MiniChartManagement: Codeunit "Chart Management";


//     //Unsupported feature: Code Modification on ""BusinessChart@-5::DataPointClicked"(EVENT 12)".

//     //trigger "BusinessChart@-5::DataPointClicked"(EVENT 12)()
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         SetDrillDownIndexes(point);
//         ChartManagement.DataPointClicked(Rec,SelectedChartDefinition);
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         SetDrillDownIndexes(point);
//         MiniChartManagement.DataPointClicked(Rec,SelectedMiniChartDefinition);
//         */
//     //end;


//     //Unsupported feature: Code Modification on ""BusinessChart@-3::AddInReady"(EVENT 14)".

//     //trigger "BusinessChart@-3::AddInReady"(EVENT 14)()
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         IsChartAddInReady := TRUE;
//         ChartManagement.AddinReady(SelectedChartDefinition,Rec);
//         InitializeSelectedChart;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         IsChartAddInReady := TRUE;
//         MiniChartManagement.AddinReady(SelectedMiniChartDefinition,Rec);
//         InitializeSelectedChart;
//         */
//     //end;


//     //Unsupported feature: Code Modification on "InitializeSelectedChart(PROCEDURE 7000)".

//     //procedure InitializeSelectedChart();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         ChartManagement.SetDefaultPeriodLength(SelectedChartDefinition,Rec);
//         ChartManagement.UpdateChart(SelectedChartDefinition,Rec,Period::" ");
//         PreviousNextActionEnabled := ChartManagement.UpdateNextPrevious(SelectedChartDefinition);
//         ChartManagement.UpdateStatusText(SelectedChartDefinition,Rec,StatusText);
//         UpdateChart;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         MiniChartManagement.SetDefaultPeriodLength(SelectedMiniChartDefinition,Rec);
//         MiniChartManagement.UpdateChart(SelectedMiniChartDefinition,Rec,Period::" ");
//         PreviousNextActionEnabled := MiniChartManagement.UpdateNextPrevious(SelectedMiniChartDefinition);
//         MiniChartManagement.UpdateStatusText(SelectedMiniChartDefinition,Rec,StatusText);
//         UpdateChart;
//         */
//     //end;


//     //Unsupported feature: Code Modification on "SetPeriodAndUpdateChart(PROCEDURE 1)".

//     //procedure SetPeriodAndUpdateChart();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         ChartManagement.SetPeriodLength(SelectedChartDefinition,Rec,PeriodLength,FALSE);
//         ChartManagement.UpdateChart(SelectedChartDefinition,Rec,Period::" ");
//         ChartManagement.UpdateStatusText(SelectedChartDefinition,Rec,StatusText);
//         UpdateChart;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         MiniChartManagement.SetPeriodLength(SelectedMiniChartDefinition,Rec,PeriodLength,FALSE);
//         MiniChartManagement.UpdateChart(SelectedMiniChartDefinition,Rec,Period::" ");
//         MiniChartManagement.UpdateStatusText(SelectedMiniChartDefinition,Rec,StatusText);
//         UpdateChart;
//         */
//     //end;

//     //Unsupported feature: Property Modification (ExternalDataType) on ""BusinessChart@-5::DataPointClicked"(EVENT 12).point(Parameter 1000)".


//     //Unsupported feature: Property Modification (ExternalDataType) on ""BusinessChart@-5::DataPointDoubleClicked"(EVENT 13).point(Parameter 1000)".

// }
