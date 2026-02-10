// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52186446 pageextension52186446 extends "Item Availability by Timeline" 
// {
//     layout
//     {
//         modify("<ItemNo>")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("<VariantFilter>")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("<LocationFilter>")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("<LastUpdateTime>")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("<ForecastName>")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("<IncludeBlanketOrders>")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Visualization)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(ActionMessage)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Description)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Original Due Date")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Due Date")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Original Quantity")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Quantity)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Reference No.")
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""<ItemNo>"(Control 30)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""<VariantFilter>"(Control 35)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""<LocationFilter>"(Control 4)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""<LastUpdateTime>"(Control 13)".


//         //Unsupported feature: Code Modification on ""<ForecastName>"(Control 9).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             ForecastName2 := ForecastName;
//             InitAndCreateTimelineEvents;
//             ForecastName := ForecastName2;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             ForecastName2 := ForecastName;
//             IF ForecastName <> '' THEN
//               IncludeBlanketOrders := TRUE;
//             InitAndCreateTimelineEvents;
//             ForecastName := ForecastName2;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""<ForecastName>"(Control 9)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""<IncludeBlanketOrders>"(Control 16)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "ActionMessage(Control 5)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 2)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Original Due Date"(Control 17)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 14)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Original Quantity"(Control 12)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 11)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Reference No."(Control 18)".

//     }
//     actions
//     {
//         modify(Delete)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("<Reload>")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("<TransferChanges>")
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "Delete(Action 21)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""<Reload>"(Action 6)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""<TransferChanges>"(Action 7)".

//     }


//     //Unsupported feature: Property Modification (Data type) on ""<VariantFilter>"(Control 35).OnValidate.VariantFilter2(Variable 1001)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //"<VariantFilter>" : Text;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //"<VariantFilter>" : Code;
//         //Variable type has not been exported.


//     //Unsupported feature: Property Modification (Data type) on ""<LocationFilter>"(Control 4).OnValidate.LocationFilter2(Variable 1001)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //"<LocationFilter>" : Text;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //"<LocationFilter>" : Code;
//         //Variable type has not been exported.


//     //Unsupported feature: Property Modification (Data type) on "LocationFilter(Variable 1009)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //LocationFilter : Text;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //LocationFilter : Code;
//         //Variable type has not been exported.


//     //Unsupported feature: Property Modification (Data type) on "VariantFilter(Variable 1008)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //VariantFilter : Text;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //VariantFilter : Code;
//         //Variable type has not been exported.


//     //Unsupported feature: Property Modification (TextConstString) on "Text004(Variable 1020)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //Text004 : ENU=Show Projected Available Balance;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //Text004 : ENU=Show Projected Inventory;
//         //Variable type has not been exported.

//     //Unsupported feature: Property Deletion (Attributes) on "SetItem(PROCEDURE 3)".


//     //Unsupported feature: Property Deletion (Attributes) on "SetForecastName(PROCEDURE 2)".


//     //Unsupported feature: Property Deletion (Attributes) on "SetWorksheet(PROCEDURE 8)".



//     //Unsupported feature: Code Modification on "CreateTimelineEvents(PROCEDURE 17)".

//     //procedure CreateTimelineEvents();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         RESET;
//         DELETEALL;
//         TempTimelineEvent.DELETEALL;
//         Item.SETRANGE("Drop Shipment Filter",FALSE);
//         CalcItemAvailTimeline.Initialize(Item,ForecastName,IncludeBlanketOrders,0D,TRUE);
//         CalcItemAvailTimeline.CreateTimelineEvents(TempTimelineEvent);
//         ExportDataToTimeline(TempTimelineEvent);
//         LastUpdateTime := CURRENTDATETIME;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         #1..3

//         #5..8
//         */
//     //end;

//     //Unsupported feature: Property Modification (ExternalDataType) on "ExportDataToTimeline(PROCEDURE 19).transactionTable(Variable 1002)".


//     //Unsupported feature: Property Modification (ExternalDataType) on "ExportDataToTimeline(PROCEDURE 19).visualizationScenarios(Variable 1000)".


//     //Unsupported feature: Property Modification (ExternalDataType) on "ImportChangesFromTimeline(PROCEDURE 18).changeTable(Variable 1003)".


//     //Unsupported feature: Property Modification (ExternalDataType) on "SetScenarioTitles(PROCEDURE 6).visualizationScenarios(Variable 1000)".


//     //Unsupported feature: Property Deletion (ApplicationArea).


//     //Unsupported feature: Property Deletion (UsageCategory).

// }
