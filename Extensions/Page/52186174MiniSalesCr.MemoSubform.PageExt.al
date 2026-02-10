// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52186174 pageextension52186174 extends ExcelTemplateCompanyInfo
// {

//     //Unsupported feature: Property Modification (Name) on "ExcelTemplateCompanyInfo(Page 1320)".

//     Caption = 'Lines';

//     //Unsupported feature: Property Modification (SourceTable) on "ExcelTemplateCompanyInfo(Page 1320)".


//     //Unsupported feature: Property Modification (PageType) on "ExcelTemplateCompanyInfo(Page 1320)".


//     //Unsupported feature: Property Insertion (MultipleNewLines) on "ExcelTemplateCompanyInfo(Page 1320)".


//     //Unsupported feature: Property Insertion (LinksAllowed) on "ExcelTemplateCompanyInfo(Page 1320)".


//     //Unsupported feature: Property Insertion (DelayedInsert) on "ExcelTemplateCompanyInfo(Page 1320)".


//     //Unsupported feature: Property Insertion (SourceTableView) on "ExcelTemplateCompanyInfo(Page 1320)".


//     //Unsupported feature: Property Insertion (AutoSplitKey) on "ExcelTemplateCompanyInfo(Page 1320)".

//     layout
//     {

//         //Unsupported feature: Property Modification (ControlType) on "Control1(Control 1)".


//         //Unsupported feature: Property Insertion (Level) on "Control1(Control 1)".


//         //Unsupported feature: Property Insertion (GroupType) on "Control1(Control 1)".

//         modify(CompanyDisplayName)
//         {

//             //Unsupported feature: Property Modification (Level) on "CompanyDisplayName(Control 5)".


//             //Unsupported feature: Property Modification (ControlType) on "CompanyDisplayName(Control 5)".


//             //Unsupported feature: Property Modification (Name) on "CompanyDisplayName(Control 5)".


//             //Unsupported feature: Property Insertion (SourceExpr) on "CompanyDisplayName(Control 5)".


//             //Unsupported feature: Property Insertion (TableRelation) on "CompanyDisplayName(Control 5)".

//             ApplicationArea = Basic;
//         }
//         modify(DisplayName)
//         {

//             //Unsupported feature: Property Modification (Level) on "DisplayName(Control 2)".


//             //Unsupported feature: Property Modification (Name) on "DisplayName(Control 2)".

//             Caption = 'Total VAT';
//             ToolTip = 'Specifies the sum of VAT amounts on all lines in the document. Note that amounts on document lines are shown with or without VAT depending on what you selected in the Prices Including VAT field on the customer or vendor card.';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on "DisplayName(Control 2)".


//             //Unsupported feature: Property Insertion (AutoFormatType) on "DisplayName(Control 2)".


//             //Unsupported feature: Property Insertion (AutoFormatExpr) on "DisplayName(Control 2)".

//             CaptionClass = MiniDocumentTotals.GetTotalVATCaption(TotalSalesHeader."Currency Code");
//             Editable = false;
//         }
//         modify(CurrencyCode)
//         {

//             //Unsupported feature: Property Modification (Level) on "CurrencyCode(Control 3)".


//             //Unsupported feature: Property Modification (ControlType) on "CurrencyCode(Control 3)".


//             //Unsupported feature: Property Modification (Name) on "CurrencyCode(Control 3)".

//             Caption = 'Total Amount Incl. VAT';
//             ToolTip = 'Specifies the sum of the value in the Line Amount Incl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field. Note that amounts on document lines are shown with or without VAT depending on what you selected in the Prices Including VAT field on the customer or vendor card.';

//             //Unsupported feature: Property Insertion (SourceExpr) on "CurrencyCode(Control 3)".


//             //Unsupported feature: Property Insertion (AutoFormatType) on "CurrencyCode(Control 3)".


//             //Unsupported feature: Property Insertion (AutoFormatExpr) on "CurrencyCode(Control 3)".

//             CaptionClass = MiniDocumentTotals.GetTotalInclVATCaption(TotalSalesHeader."Currency Code");
//             Editable = false;
//             Style = Strong;
//             StyleExpr = true;
//             ApplicationArea = Basic;
//         }
//         modify(Currency)
//         {

//             //Unsupported feature: Property Modification (Name) on "Currency(Control 4)".

//             Caption = 'Item No.';
//             ToolTip = 'Specifies the number of a general ledger account, an item, a resource, an additional cost or a fixed asset, depending on what you selected in the Type field.';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on "Currency(Control 4)".

//             LookupPageID = "Mini Item List";
//             ShowMandatory = true;
//         }

//         //Unsupported feature: Property Deletion (ContainerType) on "Control1(Control 1)".


//         //Unsupported feature: Property Deletion (CaptionML) on "CompanyDisplayName(Control 5)".


//         //Unsupported feature: Property Deletion (GroupType) on "CompanyDisplayName(Control 5)".


//         //Unsupported feature: Property Deletion (GroupType) on "CurrencyCode(Control 3)".


//         //Unsupported feature: Code Insertion on ""No."(Control 4)".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //begin
//         /*
//         NoOnAfterValidate;
//         UpdateEditableOnRow;
//         UpdatePage;
//         */
//         //end;
//         addfirst(content)
//         {
//         }
//         addfirst(Currency)
//         {
//             field("Cross-Reference No."; "Cross-Reference No.")
//             {
//                 ApplicationArea = Basic;
//                 ToolTip = 'Specifies an item cross-reference number.';
//                 Visible = false;

//                 trigger OnLookup(var Text: Text): Boolean
//                 begin
//                     CrossReferenceNoLookUp;
//                     InsertExtendedText(false);
//                 end;

//                 trigger OnValidate()
//                 begin
//                     CrossReferenceNoOnAfterValidat;
//                 end;
//             }
//             field(Description; Description)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Description/Comment';
//                 ToolTip = 'Contains a description of the entry. The description depends on what you chose in the Type field. If you did not choose Blank, the program will fill in the field when you enter something in the No. field.';

//                 trigger OnValidate()
//                 var
//                     MiniLinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
//                 begin
//                     MiniLinesInstructionMgt.ShowCreateLineInstruction("No.");
//                 end;
//             }
//             field(Quantity; Quantity)
//             {
//                 ApplicationArea = Basic;
//                 BlankZero = true;
//                 Editable = RowEditable;
//                 Enabled = RowEditable;
//                 ShowMandatory = true;
//                 ToolTip = 'Specifies how many units are being sold. This field affects the values in the Line Amount and Line Discount Amount fields and the Total fields at the bottom of the Lines FastTab.';
//                 Width = 8;

//                 trigger OnValidate()
//                 begin
//                     QuantityOnAfterValidate;
//                     UpdatePage;
//                 end;
//             }
//             field("Unit of Measure Code"; "Unit of Measure Code")
//             {
//                 ApplicationArea = Basic;
//                 Editable = RowEditable;
//                 Enabled = RowEditable;
//                 ToolTip = 'Specifies the unit of measure that is used to determine the value in the Unit Price field on the sales line. By default, the field is filled with the value in the Sales Unit of Measure field on the item card or the Base Unit of Measure field on the resource card.';
//                 Width = 8;

//                 trigger OnValidate()
//                 begin
//                     UnitofMeasureCodeOnAfterValida;
//                     UpdatePage;
//                 end;
//             }
//             field("Unit Price"; "Unit Price")
//             {
//                 ApplicationArea = Basic;
//                 BlankZero = true;
//                 Editable = RowEditable;
//                 Enabled = RowEditable;
//                 ShowMandatory = true;
//                 ToolTip = 'Specifies the price for one unit on the sales line. By default, the field is filled with the value in the Unit Price field on the item or resource card.';

//                 trigger OnValidate()
//                 begin
//                     UpdatePage;
//                 end;
//             }
//             field("Line Discount %"; "Line Discount %")
//             {
//                 ApplicationArea = Basic;
//                 BlankZero = true;
//                 Editable = RowEditable;
//                 Enabled = RowEditable;
//                 ToolTip = 'Contains the line discount percentage that is valid for the item quantity on the line.';
//                 Width = 8;

//                 trigger OnValidate()
//                 begin
//                     UpdatePage;
//                 end;
//             }
//             field("Line Discount Amount"; "Line Discount Amount")
//             {
//                 ApplicationArea = Basic;
//                 Editable = RowEditable;
//                 Enabled = RowEditable;
//                 ToolTip = 'Specifies the amount of the discount that will be given on the invoice line. The program uses the Line Discount %, Quantity and Unit Price tables to calculate the amount.';
//                 Visible = false;

//                 trigger OnValidate()
//                 begin
//                     UpdatePage;
//                 end;
//             }
//             field("Line Amount"; "Line Amount")
//             {
//                 ApplicationArea = Basic;
//                 BlankZero = true;
//                 Editable = RowEditable;
//                 Enabled = RowEditable;
//                 ToolTip = 'Specifies the amount of the sales line, calculated as the quantity times the unit price minus any percentage value in the Line Discount % field. If the Prices Including VAT check box on the customer card is selected, the amount includes VAT.';

//                 trigger OnValidate()
//                 begin
//                     UpdatePage;
//                 end;
//             }
//         }
//         addafter(CompanyDisplayName)
//         {
//             group(Control103)
//             {
//                 group(Control106)
//                 {
//                     field("Invoice Discount Amount"; TotalSalesHeader."Invoice Discount Amount")
//                     {
//                         ApplicationArea = Basic;
//                         AutoFormatExpression = TotalSalesHeader."Currency Code";
//                         AutoFormatType = 1;
//                         Caption = 'Invoice Discount Amount';
//                         Editable = InvDiscAmountEditable;
//                         ToolTip = 'Specifies the sum of the value in the Line Amount Excl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field. Note that amounts on document lines are shown with or without VAT depending on what you selected in the Prices Including VAT field on the customer or vendor card.';

//                         trigger OnValidate()
//                         var
//                             SalesHeader: Record "Sales Header";
//                         begin
//                             SalesHeader.Get("Document Type", "Document No.");
//                             MiniSalesCalcDiscByType.ApplyInvDiscBasedOnAmt(TotalSalesHeader."Invoice Discount Amount", SalesHeader);
//                             CurrPage.Update;
//                         end;
//                     }
//                     field("Cust. Invoice Disc. Pct."; MiniSalesCalcDiscByType.GetCustInvoiceDiscountPct(Rec))
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Customer Invoice Discount %';
//                         DecimalPlaces = 0 : 1;
//                         Editable = false;
//                         ToolTip = 'Specifies a discount percentage that is granted if the criteria are met that you have set up for invoice discounts. The calculated discount amount is inserted in the Invoice Discount Amount field, but you can change it manually.';
//                         Visible = true;
//                     }
//                 }
//                 group(Control131)
//                 {
//                     field("Total Amount Excl. VAT"; TotalSalesHeader.Amount)
//                     {
//                         ApplicationArea = Basic;
//                         AutoFormatExpression = TotalSalesHeader."Currency Code";
//                         AutoFormatType = 1;
//                         CaptionClass = MiniDocumentTotals.GetTotalExclVATCaption(TotalSalesHeader."Currency Code");
//                         Caption = 'Total Amount Excl. VAT';
//                         DrillDown = false;
//                         Editable = false;
//                         ToolTip = 'Specifies the sum of the value in the Line Amount Excl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field. Note that amounts on document lines are shown with or without VAT depending on what you selected in the Prices Including VAT field on the customer or vendor card.';
//                     }
//                 }
//             }
//         }
//         moveafter(Control1; Currency)
//     }
//     actions
//     {
//         addfirst(processing)
//         {
//             action(InsertExtTextsAction)
//             {
//                 AccessByPermission = TableData "Extended Text Header" = R;
//                 ApplicationArea = Basic;
//                 Caption = 'Insert &Ext. Texts';
//                 Image = Text;
//                 Scope = Repeater;
//                 ToolTip = 'Insert the extended item description that is set up for the item.';

//                 trigger OnAction()
//                 begin
//                     InsertExtendedText(true);
//                 end;
//             }
//             action(Dimensions)
//             {
//                 AccessByPermission = TableData Dimension = R;
//                 ApplicationArea = Basic;
//                 Caption = 'Dimensions';
//                 Image = Dimensions;
//                 Scope = Repeater;
//                 ShortCutKey = 'Shift+Ctrl+D';
//                 ToolTip = 'View or edit the dimension sets that are set up for the combination of customer and item on the invoice line.';

//                 trigger OnAction()
//                 begin
//                     ShowDimensions;
//                 end;
//             }
//             action(DeferralSchedule)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Deferral Schedule';
//                 Enabled = "Deferral Code" <> '';
//                 Image = PaymentPeriod;

//                 trigger OnAction()
//                 begin
//                     TotalSalesHeader.Get("Document Type", "Document No.");
//                     ShowDeferrals(TotalSalesHeader."Posting Date", TotalSalesHeader."Currency Code");
//                 end;
//             }
//         }
//     }

//     var
//         TotalSalesHeader: Record "Sales Header";
//         TransferExtendedText: Codeunit "Transfer Extended Text";
//         MiniSalesCalcDiscByType: Codeunit 1300;
//         MiniDocumentTotals: Codeunit 1301;
//         VATAmount: Decimal;
//         RowEditable: Boolean;
//         InvDiscAmountEditable: Boolean;


//     //Unsupported feature: Code Insertion on "OnAfterGetCurrRecord".

//     //trigger OnAfterGetCurrRecord()
//     //var
//     //SalesLine: Record "Sales Line";
//     //begin
//     /*
//     MiniDocumentTotals.CalculateSalesHeaderTotals(TotalSalesHeader,VATAmount,Rec);
//     UpdateEditableOnRow;

//     SalesLine.SETRANGE("Document Type","Document Type");
//     SalesLine.SETRANGE("Document No.","Document No.");
//     InvDiscAmountEditable := SalesLine.FINDFIRST AND CurrPage.EDITABLE;
//     */
//     //end;


//     //Unsupported feature: Code Insertion on "OnDeleteRecord".

//     //trigger OnDeleteRecord(): Boolean
//     //begin
//     /*
//     DELETE;
//     MiniDocumentTotals.CalculateSalesHeaderTotals(TotalSalesHeader,VATAmount,Rec);
//     UpdatePage;
//     */
//     //end;


//     //Unsupported feature: Code Insertion on "OnInsertRecord".

//     //trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     //begin
//     /*
//     Type := Type::Item;
//     */
//     //end;


//     //Unsupported feature: Code Insertion on "OnNewRecord".

//     //trigger OnNewRecord(BelowxRec: Boolean)
//     //begin
//     /*
//     Type := Type::Item;
//     */
//     //end;

//     //Unsupported feature: Property Modification (Name) on "GetCompanyInformation(PROCEDURE 1)".



//     //Unsupported feature: Code Modification on "GetCompanyInformation(PROCEDURE 1)".

//     //procedure GetCompanyInformation();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//     /*
//     IF Company.GET(COMPANYNAME) THEN
//       DisplayName := Company."Display Name";

//     IF GeneralLedgerSetup.GET THEN
//       CurrencyCode := GeneralLedgerSetup."LCY Code";
//     */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//     /*
//     CODEUNIT.RUN(CODEUNIT::"Sales-Disc. (Yes/No)",Rec);
//     */
//     //end;

//     local procedure CalcInvDisc()
//     begin
//         Codeunit.Run(Codeunit::"Sales-Calc. Discount", Rec);
//     end;

//     local procedure InsertExtendedText(Unconditionally: Boolean)
//     begin
//         if TransferExtendedText.SalesCheckIfAnyExtText(Rec, Unconditionally) then begin
//             CurrPage.SaveRecord;
//             Commit;
//             TransferExtendedText.InsertSalesExtText(Rec);
//         end;
//         if TransferExtendedText.MakeUpdate then
//             UpdatePage;
//     end;

//     local procedure UpdatePage()
//     var
//         SalesHeader: Record "Sales Header";
//     begin
//         CurrPage.Update;
//         SalesHeader.Get("Document Type", "Document No.");
//         MiniSalesCalcDiscByType.ApplyDefaultInvoiceDiscount(TotalSalesHeader."Invoice Discount Amount", SalesHeader);
//     end;

//     local procedure NoOnAfterValidate()
//     begin
//         InsertExtendedText(false);
//         Rec.TestField(Type, Type::Item);
//     end;

//     local procedure CrossReferenceNoOnAfterValidat()
//     begin
//         InsertExtendedText(false);
//     end;

//     local procedure QuantityOnAfterValidate()
//     begin
//         if Reserve = Reserve::Always then begin
//             CurrPage.SaveRecord;
//             AutoReserve;
//         end;
//     end;

//     local procedure UnitofMeasureCodeOnAfterValida()
//     begin
//         if Reserve = Reserve::Always then begin
//             CurrPage.SaveRecord;
//             AutoReserve;
//         end;
//     end;

//     local procedure UpdateEditableOnRow()
//     begin
//         RowEditable := "No." <> '';
//     end;

//     //Unsupported feature: Deletion (VariableCollection) on "GetCompanyInformation(PROCEDURE 1).Company(Variable 1002)".


//     //Unsupported feature: Deletion (VariableCollection) on "GetCompanyInformation(PROCEDURE 1).GeneralLedgerSetup(Variable 1001)".


//     //Unsupported feature: Property Deletion (InsertAllowed).


//     //Unsupported feature: Property Deletion (DeleteAllowed).


//     //Unsupported feature: Property Deletion (ModifyAllowed).

// }
