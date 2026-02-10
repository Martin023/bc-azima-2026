// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52187104 pageextension52187104 extends "Demand Forecast Matrix" 
// {

//     //Unsupported feature: Property Modification (Name) on ""Demand Forecast Matrix"(Page 9245)".

//     Caption = 'Production Forecast Matrix';
//     layout
//     {
//         modify("No.")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Description)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field1)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field2)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field3)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field4)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field5)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field6)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field7)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field8)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field9)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field10)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field11)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field12)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field13)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field14)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field15)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field16)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field17)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field18)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field19)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field20)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field21)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field22)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field23)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field24)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field25)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field26)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field27)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field28)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field29)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field30)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field31)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Field32)
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 12)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 18)".

//     }

//     //Unsupported feature: Property Modification (Id) on "MatrixRecords(Variable 1004)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //MatrixRecords : 1004;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //MatrixRecords : 1092;
//         //Variable type has not been exported.


//     //Unsupported feature: Property Modification (Length) on ""MATRIX_CaptionSet"(Variable 1096)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //"MATRIX_CaptionSet" : 80;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //"MATRIX_CaptionSet" : 1024;
//         //Variable type has not been exported.

//     //Unsupported feature: Property Deletion (Attributes) on "Load(PROCEDURE 1098)".


//     //Unsupported feature: Property Deletion (Attributes) on "SetVisible(PROCEDURE 1)".


//     //Unsupported feature: Variable Insertion (Variable: LocationCode) (VariableCollection) on ""ProdForecastQtyBase_OnValidate"(PROCEDURE 4)".



//     //Unsupported feature: Code Modification on ""ProdForecastQtyBase_OnValidate"(PROCEDURE 4)".

//     //procedure "ProdForecastQtyBase_OnValidate"();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         IF ForecastType = ForecastType::Both THEN
//           ERROR(Text000);
//         ProdForecastEntry.SETCURRENTKEY("Production Forecast Name","Item No.","Location Code","Forecast Date","Component Forecast");
//         #4..24
//           "Production Forecast Name","Item No.","Location Code","Forecast Date","Component Forecast");
//         IF GETFILTER("Location Filter") = '' THEN BEGIN
//           ProdForecastEntry2.COPYFILTERS(ProdForecastEntry);
//           ProdForecastEntry2.SETFILTER("Location Code",'>%1','');
//           IF ProdForecastEntry2.FINDSET THEN
//             REPEAT
//               IF ProdForecastByLocationQtyBase(ProdForecastEntry2) <> 0 THEN
//                 ERROR(Text003);
//               ProdForecastEntry2.SETFILTER("Location Code",'>%1',ProdForecastEntry2."Location Code");
//             UNTIL ProdForecastEntry2.NEXT = 0;
//         END;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         #1..27
//           ProdForecastEntry2.SETRANGE("Location Code");
//           IF ProdForecastEntry2.FINDFIRST THEN BEGIN
//             LocationCode := ProdForecastEntry2."Location Code";
//             ProdForecastEntry2.FINDLAST;
//             IF ProdForecastEntry2."Location Code" <> LocationCode THEN
//               ERROR(Text003);
//           END;
//         END;
//         */
//     //end;
// }
