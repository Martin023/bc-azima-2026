// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52186580 pageextension52186580 extends "Item Statistics" 
// {
//     layout
//     {
//         modify(ShowAsLines)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(ColumnDimCode)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(DateFilter)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(ItemFilter)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(LocationFilter)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(VariantFilter)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(RoundingFactor)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(PerUnit)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(IncludeExpected)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(ViewBy)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(AmountType)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("MATRIX_CaptionRange")
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "ShowAsLines(Control 7)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "ColumnDimCode(Control 6)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "DateFilter(Control 20)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "ItemFilter(Control 25)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "LocationFilter(Control 14)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "VariantFilter(Control 13)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "RoundingFactor(Control 5)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "PerUnit(Control 3)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "IncludeExpected(Control 28)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "ViewBy(Control 1167)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "AmountType(Control 1168)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""MATRIX_CaptionRange"(Control 1169)".

//     }
//     actions
//     {
//         modify(ShowMatrix)
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Insertion (PromotedIsBig) on "ShowMatrix(Action 19)".

//         }
//         modify("Previous Set")
//         {
//             ToolTip = 'Previous Set';
//             ApplicationArea = Basic;
//         }
//         modify("Next Set")
//         {
//             ToolTip = 'Next Set';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Insertion (PromotedIsBig) on ""Next Set"(Action 2)".

//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "ShowMatrix(Action 19)".


//         //Unsupported feature: Property Deletion (PromotedOnly) on "ShowMatrix(Action 19)".


//         //Unsupported feature: Property Deletion (PromotedOnly) on ""Previous Set"(Action 1170)".


//         //Unsupported feature: Property Deletion (PromotedOnly) on ""Next Set"(Action 2)".

//     }

//     //Unsupported feature: Property Modification (Id) on "GLSetup(Variable 1003)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //GLSetup : 1003;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //GLSetup : 1002;
//         //Variable type has not been exported.


//     //Unsupported feature: Property Modification (Id) on "Item(Variable 1002)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //Item : 1002;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //Item : 1003;
//         //Variable type has not been exported.


//     //Unsupported feature: Property Modification (Id) on "ItemBuffer(Variable 1001)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //ItemBuffer : 1001;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //ItemBuffer : 1004;
//         //Variable type has not been exported.


//     //Unsupported feature: Property Modification (Id) on "IntegerLine(Variable 1000)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //IntegerLine : 1000;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //IntegerLine : 1005;
//         //Variable type has not been exported.


//     //Unsupported feature: Property Modification (Length) on ""MATRIX_CaptionSet"(Variable 1160)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //"MATRIX_CaptionSet" : 80;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //"MATRIX_CaptionSet" : 1024;
//         //Variable type has not been exported.


//     //Unsupported feature: Property Modification (Data type) on "ItemFilter(Variable 1013)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //ItemFilter : Text;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //ItemFilter : Code;
//         //Variable type has not been exported.


//     //Unsupported feature: Property Modification (Data type) on "VariantFilter(Variable 1014)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //VariantFilter : Text;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //VariantFilter : Code;
//         //Variable type has not been exported.


//     //Unsupported feature: Property Modification (Data type) on "LocationFilter(Variable 1015)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //LocationFilter : Text;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //LocationFilter : Code;
//         //Variable type has not been exported.

//     var
//         MATRIX_MatrixRecord: Record "Dimension Code Buffer";

//     var
//         FirstColumn: Text[1024];
//         LastColumn: Text[1024];

//     var
//         xMATRIX_CurrentNoOfColumns: Integer;

//     var
//         Qty: Decimal;

//     var
//         GLSetupRead: Boolean;

//     var
//         CurrentMatrixRecordOrdinal: Integer;


//     //Unsupported feature: Code Modification on "OnOpenPage".

//     //trigger OnOpenPage()
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         GLSetup.GET;

//         WITH Item DO BEGIN
//           IF "No." <> '' THEN
//         #5..18
//         FindPeriod('');
//         ItemName := STRSUBSTNO('%1  %2',Item."No.",Item.Description);
//         MATRIX_GenerateColumnCaptions(MATRIX_SetWanted::Initial);
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         GLSetup.GET;
//         xMATRIX_CurrentNoOfColumns := 32;
//         #2..21
//         */
//     //end;


//     //Unsupported feature: Code Modification on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1175)".

//     //procedure "MATRIX_GenerateColumnCaptions"();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         CLEAR(MATRIX_CaptionSet);
//         CLEAR(MATRIX_MatrixRecords);

//         CASE ColumnDimCode OF
//           Text002:
//         #6..22
//                 MATRIX_MatrixRecords[i].Code := MATRIX_CaptionSet[i];
//             END;
//         END;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         CLEAR(MATRIX_CaptionSet);
//         CurrentMatrixRecordOrdinal := 1;
//         CLEAR(MATRIX_MatrixRecords);
//         FirstColumn := '';
//         LastColumn := '';
//         #3..25

//         IF MATRIX_CurrentNoOfColumns > 0 THEN BEGIN
//           FirstColumn := FORMAT(MATRIX_PeriodRecords[1]."Period Start");
//           LastColumn := FORMAT(MATRIX_PeriodRecords[MATRIX_CurrentNoOfColumns]."Period End");
//         END;
//         */
//     //end;

//     //Unsupported feature: Property Deletion (Attributes) on "SetItem(PROCEDURE 11)".


//     local procedure SetCommonFilters(var TheItemBuffer: Record "Item Statistics Buffer")
//     begin
//         begin
//           // TheItemBuffer.Reset;
//           // if ItemFilter <> '' then
//           //   TheItemBuffer.SetFilter(TheItemBuffer."Item Filter",ItemFilter);
//           // if DateFilter <> '' then
//           //   TheItemBuffer.SetFilter(TheItemBuffer."Date Filter",DateFilter);
//           // if LocationFilter <> '' then
//           //   TheItemBuffer.SetFilter(TheItemBuffer."Location Filter",LocationFilter);
//           // if VariantFilter <> '' then
//           //   TheItemBuffer.SetFilter(TheItemBuffer."Variant Filter",VariantFilter);
//         end;
//     end;

//     local procedure SetFilters(var ItemBuffer: Record "Item Statistics Buffer";LineOrColumn: Option Line,Column)
//     var
//         DimOption: Option "Profit Calculation","Cost Specification","Purch. Item Charge Spec.","Sales Item Charge Spec.",Period,Location;
//         DimCodeBuf: Record "Dimension Code Buffer";
//     begin
//         if LineOrColumn = Lineorcolumn::Line then begin
//           DimCodeBuf := Rec;
//           DimOption := ItemBuffer."Line Option";
//         end else begin
//           DimCodeBuf := MATRIX_MatrixRecord;
//           DimOption := ItemBuffer."Column Option";
//         end;

//         begin
//           case DimOption of
//             Dimoption::Location:
//               ItemBuffer.SetRange(ItemBuffer."Location Filter",DimCodeBuf.Code);
//             Dimoption::Period:
//               // if AmountType = Amounttype::"Net Change" then
//               //   ItemBuffer.SetRange(ItemBuffer."Date Filter",DimCodeBuf."Period Start",DimCodeBuf."Period End")
//               // else
//                 ItemBuffer.SetRange(ItemBuffer."Date Filter",0D,DimCodeBuf."Period End");
//             Dimoption::"Profit Calculation",
//             Dimoption::"Cost Specification":
//               case Name of
//                 ItemBuffer.FieldCaption(ItemBuffer."Sales (LCY)"),
//                 ItemBuffer.FieldCaption(ItemBuffer."COGS (LCY)"),
//                 ItemBuffer.FieldCaption(ItemBuffer."Profit (LCY)"),
//                 ItemBuffer.FieldCaption(ItemBuffer."Profit %"):
//                   begin
//                     ItemBuffer.SetRange(ItemBuffer."Item Ledger Entry Type Filter",ItemBuffer."item ledger entry type filter"::Sale);
//                     if DimOption = Dimoption::"Profit Calculation" then
//                       ItemBuffer.SetFilter(ItemBuffer."Entry Type Filter",'<>%1',ItemBuffer."entry type filter"::Revaluation);
//                     ItemBuffer.SetRange(ItemBuffer."Variance Type Filter",ItemBuffer."variance type filter"::" ");
//                   end;
//                 ItemBuffer.FieldCaption(ItemBuffer."Direct Cost (LCY)"),
//                 ItemBuffer.FieldCaption(ItemBuffer."Revaluation (LCY)"),
//                 ItemBuffer.FieldCaption(ItemBuffer."Rounding (LCY)"),
//                 ItemBuffer.FieldCaption(ItemBuffer."Indirect Cost (LCY)"),
//                 ItemBuffer.FieldCaption(ItemBuffer."Variance (LCY)"),
//                 ItemBuffer.FieldCaption(ItemBuffer."Inventoriable Costs, Total"):
//                   begin
//                     ItemBuffer.SetFilter(
//                       ItemBuffer."Item Ledger Entry Type Filter",'<>%1&<>%2',
//                       ItemBuffer."item ledger entry type filter"::Sale,
//                       ItemBuffer."item ledger entry type filter"::" ");
//                     ItemBuffer.SetRange(ItemBuffer."Variance Type Filter",ItemBuffer."variance type filter"::" ");
//                     case Name of
//                       ItemBuffer.FieldCaption(ItemBuffer."Direct Cost (LCY)"):
//                         ItemBuffer.SetRange(ItemBuffer."Entry Type Filter",ItemBuffer."entry type filter"::"Direct Cost");
//                       ItemBuffer.FieldCaption(ItemBuffer."Revaluation (LCY)"):
//                         ItemBuffer.SetRange(ItemBuffer."Entry Type Filter",ItemBuffer."entry type filter"::Revaluation);
//                       ItemBuffer.FieldCaption(ItemBuffer."Rounding (LCY)"):
//                         ItemBuffer.SetRange(ItemBuffer."Entry Type Filter",ItemBuffer."entry type filter"::Rounding);
//                       ItemBuffer.FieldCaption(ItemBuffer."Indirect Cost (LCY)"):
//                         ItemBuffer.SetRange(ItemBuffer."Entry Type Filter",ItemBuffer."entry type filter"::"Indirect Cost");
//                       ItemBuffer.FieldCaption(ItemBuffer."Variance (LCY)"):
//                         begin
//                           ItemBuffer.SetRange(ItemBuffer."Entry Type Filter",ItemBuffer."entry type filter"::Variance);
//                           ItemBuffer.SetFilter(ItemBuffer."Variance Type Filter",'<>%1',ItemBuffer."variance type filter"::" ");
//                         end;
//                       ItemBuffer.FieldCaption(ItemBuffer."Inventoriable Costs, Total"):
//                         ItemBuffer.SetRange(ItemBuffer."Variance Type Filter");
//                     end;
//                   end;
//                 else
//                   ItemBuffer.SetRange(ItemBuffer."Item Ledger Entry Type Filter");
//                   ItemBuffer.SetRange(ItemBuffer."Variance Type Filter");
//               end;
//             Dimoption::"Purch. Item Charge Spec.":
//               begin
//                 ItemBuffer.SetRange(ItemBuffer."Variance Type Filter",ItemBuffer."variance type filter"::" ");
//                 ItemBuffer.SetRange(ItemBuffer."Item Ledger Entry Type Filter",ItemBuffer."item ledger entry type filter"::Purchase);
//                 ItemBuffer.SetRange(ItemBuffer."Item Charge No. Filter",DimCodeBuf.Code);
//               end;
//             Dimoption::"Sales Item Charge Spec.":
//               begin
//                 ItemBuffer.SetRange(ItemBuffer."Variance Type Filter",ItemBuffer."variance type filter"::" ");
//                 ItemBuffer.SetRange(ItemBuffer."Item Ledger Entry Type Filter",ItemBuffer."item ledger entry type filter"::Sale);
//                 ItemBuffer.SetRange(ItemBuffer."Item Charge No. Filter",DimCodeBuf.Code);
//               end;
//           end;
//           if ItemBuffer.GetFilter(ItemBuffer."Item Ledger Entry Type Filter") = '' then
//             ItemBuffer.SetFilter(
//               ItemBuffer."Item Ledger Entry Type Filter",'<>%1',
//               ItemBuffer."item ledger entry type filter"::" ")
//         end;
//     end;

//     local procedure Calculate(SetColumnFilter: Boolean) Amount: Decimal
//     begin
//         GetGLSetup;

//        // with ItemBuffer do begin
//           // case "Line Option" of
//           //   "line option"::"Profit Calculation",
//           //   "line option"::"Cost Specification":
//           //     case Rec.Name of
//           //       Rec.FieldCaption("Sales (LCY)"):
//           //         Rec.Amount := CalcSalesAmount(SetColumnFilter);
//           //       Rec.FieldCaption("COGS (LCY)"):
//           //         Rec.Amount := CalcCostAmount(SetColumnFilter);
//           //       Rec.FieldCaption("Non-Invtbl. Costs (LCY)"):
//           //         Rec.Amount := CalcCostAmountNonInvnt(SetColumnFilter);
//           //       Rec.FieldCaption("Profit (LCY)"):
//           //         Rec.Amount :=
//           //           CalcSalesAmount(SetColumnFilter) +
//           //           CalcCostAmount(SetColumnFilter) +
//           //           CalcCostAmountNonInvnt(SetColumnFilter);
//                 Rec.FieldCaption("Profit %"):
//                   if CalcSalesAmount(SetColumnFilter) <> 0 then
//                     Rec.Amount :=
//                       ROUND(
//                         100 * (CalcSalesAmount(SetColumnFilter) +
//                                CalcCostAmount(SetColumnFilter) +
//                                CalcCostAmountNonInvnt(SetColumnFilter))
//                         / CalcSalesAmount(SetColumnFilter))
//                   else
//                     Rec.Amount := 0;
//                 Rec.FieldCaption("Direct Cost (LCY)"),Rec.FieldCaption("Revaluation (LCY)"),
//                 Rec.FieldCaption("Rounding (LCY)"),Rec.FieldCaption("Indirect Cost (LCY)"),
//                 Rec.FieldCaption("Variance (LCY)"),Rec.FieldCaption("Inventory (LCY)"),
//                 Rec.FieldCaption("Inventoriable Costs, Total"):
//                   Rec.Amount := CalcCostAmount(SetColumnFilter);
//                 else
//                   Rec.Amount := 0;
//               end;
//             "line option"::"Sales Item Charge Spec.":
//               Rec.Amount := CalcSalesAmount(SetColumnFilter);
//             "line option"::"Purch. Item Charge Spec.":
//               Rec.Amount := CalcCostAmount(SetColumnFilter);
//           end;

//           if PerUnit then begin
//             if ("Line Option" = "line option"::"Profit Calculation") and
//                (Rec.Name = Rec.FieldCaption("Profit %"))
//             then
//               Qty := 1
//             else
//               Qty := CalcQty(SetColumnFilter);

//             if Qty <> 0 then
//               Rec.Amount :=
//                 ROUND(Rec.Amount / Abs(Qty),GLSetup."Unit-Amount Rounding Precision")
//             else
//               Rec.Amount := 0;
//           end;
//         end;
//     end;

//     local procedure CalcSalesAmount(SetColumnFilter: Boolean): Decimal
//     begin
//         SetCommonFilters(ItemBuffer);
//         SetFilters(ItemBuffer,0);
//         if SetColumnFilter then
//           SetFilters(ItemBuffer,1);

//         if IncludeExpected then begin
//           ItemBuffer.CalcFields("Sales Amount (Actual)","Sales Amount (Expected)");
//           exit(ItemBuffer."Sales Amount (Actual)" + ItemBuffer."Sales Amount (Expected)");
//         end;
//         ItemBuffer.CalcFields("Sales Amount (Actual)");
//         exit(ItemBuffer."Sales Amount (Actual)");
//     end;

//     local procedure CalcCostAmount(SetColumnFilter: Boolean): Decimal
//     begin
//         SetCommonFilters(ItemBuffer);
//         SetFilters(ItemBuffer,0);
//         if SetColumnFilter then
//           SetFilters(ItemBuffer,1);

//         if IncludeExpected then begin
//           ItemBuffer.CalcFields("Cost Amount (Actual)","Cost Amount (Expected)");
//           exit(ItemBuffer."Cost Amount (Actual)" + ItemBuffer."Cost Amount (Expected)");
//         end;
//         ItemBuffer.CalcFields("Cost Amount (Actual)");
//         exit(ItemBuffer."Cost Amount (Actual)");
//     end;

//     local procedure CalcCostAmountNonInvnt(SetColumnFilter: Boolean): Decimal
//     begin
//         SetCommonFilters(ItemBuffer);
//         SetFilters(ItemBuffer,0);
//         if SetColumnFilter then
//           SetFilters(ItemBuffer,1);

//         ItemBuffer.SetRange("Item Ledger Entry Type Filter");
//         ItemBuffer.CalcFields("Cost Amount (Non-Invtbl.)");
//         exit(ItemBuffer."Cost Amount (Non-Invtbl.)");
//     end;

//     local procedure CalcQty(SetColumnFilter: Boolean): Decimal
//     begin
//         SetCommonFilters(ItemBuffer);
//         SetFilters(ItemBuffer,0);
//         if SetColumnFilter then
//           SetFilters(ItemBuffer,1);

//         ItemBuffer.SetRange("Entry Type Filter");
//         ItemBuffer.SetRange("Item Charge No. Filter");

//         if IncludeExpected then begin
//           ItemBuffer.CalcFields(Rec.Quantity);
//           exit(ItemBuffer.Quantity);
//         end;
//         ItemBuffer.CalcFields("Invoiced Quantity");
//         exit(ItemBuffer."Invoiced Quantity");
//     end;

//     local procedure GetGLSetup()
//     begin
//         if not GLSetupRead then
//           GLSetup.Get;
//         GLSetupRead := true;
//     end;

//     //Unsupported feature: Property Modification (Id) on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1175)."MATRIX_PeriodRecords"(Variable 1004)".


//     //Unsupported feature: Property Modification (Id) on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1175).Location(Variable 1003)".


//     //Unsupported feature: Move on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1175).RecRef(Variable 1001)".


//     //Unsupported feature: Move on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1175).MatrixMgt(Variable 1002)".

// }
