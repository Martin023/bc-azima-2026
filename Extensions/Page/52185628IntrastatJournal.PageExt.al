// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52185628 pageextension52185628 extends "Intrastat Journal"
// {
//     Caption = 'Intrastat Journal';
//     layout
//     {
//         modify(CurrentJnlBatchName)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Type)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Date)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Document No.")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Item No.")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Name)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Tariff No.")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Item Description")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Country/Region Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Transaction Type")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Transaction Specification")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Transport Method")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Entry/Exit Point")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Area")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Supplementary Units")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Quantity)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Net Weight")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Total Weight")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Amount)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Statistical Value")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Source Type")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Source Entry No.")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Cost Regulation %")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Indirect Cost")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Internal Ref. No.")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(StatisticalValue)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("TotalStatisticalValue + ""Statistical Value"" - xRec.""Statistical Value""")
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "CurrentJnlBatchName(Control 55)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 2)".


//         //Unsupported feature: Property Deletion (StyleExpr) on "Type(Control 2)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Date(Control 4)".


//         //Unsupported feature: Property Deletion (StyleExpr) on "Date(Control 4)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 6)".


//         //Unsupported feature: Property Deletion (StyleExpr) on ""Document No."(Control 6)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 8)".


//         //Unsupported feature: Property Deletion (StyleExpr) on ""Item No."(Control 8)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 10)".


//         //Unsupported feature: Property Deletion (StyleExpr) on "Name(Control 10)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Tariff No."(Control 12)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Item Description"(Control 14)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Country/Region Code"(Control 16)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Transaction Type"(Control 18)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Transaction Specification"(Control 61)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Transport Method"(Control 20)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Entry/Exit Point"(Control 63)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Area(Control 65)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Supplementary Units"(Control 22)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 24)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Net Weight"(Control 26)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Total Weight"(Control 28)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 30)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Statistical Value"(Control 32)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Source Type"(Control 34)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Source Entry No."(Control 36)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Regulation %"(Control 59)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Indirect Cost"(Control 57)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Internal Ref. No."(Control 38)".

//         modify("Shpt. Method Code")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "StatisticalValue(Control 41)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""TotalStatisticalValue + ""Statistical Value"" - xRec.""Statistical Value"""(Control 43)".

//         modify(ErrorMessagesPart)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

//     }
//     actions
//     {
//         modify(Item)
//         {
//             Caption = 'Card';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Image) on "Item(Action 48)".


//             //Unsupported feature: Property Modification (Name) on "Item(Action 48)".

//         }
//         modify(GetEntries)
//         {
//             Caption = '&Get Entries';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Image) on "GetEntries(Action 53)".

//         }
//         modify(ChecklistReport)
//         {

//             //Unsupported feature: Property Modification (Level) on "ChecklistReport(Action 50)".

//             ApplicationArea = Basic;

//             //Unsupported feature: Property Insertion (Ellipsis) on "ChecklistReport(Action 50)".

//         }
//         modify(CreateFile)
//         {

//             //Unsupported feature: Property Modification (Level) on "CreateFile(Action 52)".


//             //Unsupported feature: Property Modification (Name) on "CreateFile(Action 52)".

//             Caption = 'Make Diskette';
//             ApplicationArea = Basic;
//         }
//         modify(Form)
//         {

//             //Unsupported feature: Property Modification (Level) on "Form(Action 51)".

//             Caption = 'Form';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (PromotedCategory) on "Form(Action 51)".

//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "Item(Action 48)".


//         //Unsupported feature: Property Deletion (Promoted) on "Item(Action 48)".


//         //Unsupported feature: Property Deletion (PromotedIsBig) on "Item(Action 48)".


//         //Unsupported feature: Property Deletion (PromotedCategory) on "Item(Action 48)".


//         //Unsupported feature: Property Deletion (PromotedOnly) on "Item(Action 48)".


//         //Unsupported feature: Code Modification on "GetEntries(Action 53).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//         /*
//         VATReportsConfiguration.SETRANGE("VAT Report Type",VATReportsConfiguration."VAT Report Type"::"Intrastat Report");
//         IF VATReportsConfiguration.FINDFIRST AND (VATReportsConfiguration."Suggest Lines Codeunit ID" <> 0) THEN BEGIN
//           CODEUNIT.RUN(VATReportsConfiguration."Suggest Lines Codeunit ID",Rec);
//           EXIT;
//         END;

//         GetItemEntries.SetIntrastatJnlLine(Rec);
//         GetItemEntries.RUNMODAL;
//         CLEAR(GetItemEntries);
//         */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//         /*
//         #7..9
//         */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "GetEntries(Action 53)".


//         //Unsupported feature: Property Deletion (PromotedOnly) on "GetEntries(Action 53)".



//         //Unsupported feature: Code Modification on "ChecklistReport(Action 50).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//         /*
//         VATReportsConfiguration.SETRANGE("VAT Report Type",VATReportsConfiguration."VAT Report Type"::"Intrastat Report");
//         IF VATReportsConfiguration.FINDFIRST AND (VATReportsConfiguration."Validate Codeunit ID" <> 0) THEN BEGIN
//           CODEUNIT.RUN(VATReportsConfiguration."Validate Codeunit ID",Rec);
//           EXIT;
//         END;

//         ReportPrint.PrintIntrastatJnlLine(Rec);
//         */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//         /*
//         ReportPrint.PrintIntrastatJnlLine(Rec);
//         */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "ChecklistReport(Action 50)".


//         //Unsupported feature: Property Deletion (PromotedOnly) on "ChecklistReport(Action 50)".

//         modify("Toggle Error Filter")
//         {
//             Visible = false;
//         }


//         //Unsupported feature: Code Modification on "CreateFile(Action 52).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//         /*
//         VATReportsConfiguration.SETRANGE("VAT Report Type",VATReportsConfiguration."VAT Report Type"::"Intrastat Report");
//         IF VATReportsConfiguration.FINDFIRST AND (VATReportsConfiguration."Validate Codeunit ID" <> 0) AND
//            (VATReportsConfiguration."Content Codeunit ID" <> 0)
//         THEN BEGIN
//           CODEUNIT.RUN(VATReportsConfiguration."Validate Codeunit ID",Rec);
//           IF ErrorsExistOnCurrentBatch(TRUE) THEN
//             ERROR('');
//           COMMIT;

//           CODEUNIT.RUN(VATReportsConfiguration."Content Codeunit ID",Rec);
//           EXIT;
//         END;

//         ReportPrint.PrintIntrastatJnlLine(Rec);
//         IF ErrorsExistOnCurrentBatch(TRUE) THEN
//           ERROR('');
//         COMMIT;

//         IntrastatJnlLine.COPYFILTERS(Rec);
//         IntrastatJnlLine.SETRANGE("Journal Template Name","Journal Template Name");
//         IntrastatJnlLine.SETRANGE("Journal Batch Name","Journal Batch Name");
//         REPORT.RUN(REPORT::"Intrastat - Make Disk Tax Auth",TRUE,FALSE,IntrastatJnlLine);
//         */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//         /*
//         #19..21
//         REPORT.RUN(593,TRUE,FALSE,IntrastatJnlLine);
//         */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "CreateFile(Action 52)".


//         //Unsupported feature: Property Deletion (PromotedOnly) on "CreateFile(Action 52)".



//         //Unsupported feature: Code Modification on "Form(Action 51).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//         /*
//         IntrastatJnlLine.COPYFILTERS(Rec);
//         IntrastatJnlLine.SETRANGE("Journal Template Name","Journal Template Name");
//         IntrastatJnlLine.SETRANGE("Journal Batch Name","Journal Batch Name");
//         REPORT.RUN(REPORT::"Intrastat - Form",TRUE,FALSE,IntrastatJnlLine);
//         */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//         /*
//         #1..3
//         REPORT.RUN(501,TRUE,FALSE,IntrastatJnlLine);
//         */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "Form(Action 51)".


//         //Unsupported feature: Property Deletion (PromotedOnly) on "Form(Action 51)".

//         modify("Page")
//         {
//             Visible = false;
//         }
//         modify(EditInExcel)
//         {
//             Visible = false;
//         }
//         addfirst(Processing)
//         {
//             group("&Print")
//             {
//                 Caption = '&Print';
//                 Image = Print;
//             }
//         }
//         //moveafter(ActionContainer1900000004;ChecklistReport)
//         moveafter(ChecklistReport; Form)
//         moveafter(Form; CreateFile)
//     }


//     //Unsupported feature: Property Modification (Id) on "StatisticalValueVisible(Variable 1069)".

//     //var
//     //>>>> ORIGINAL VALUE:
//     //StatisticalValueVisible : 1069;
//     //Variable type has not been exported.
//     //>>>> MODIFIED VALUE:
//     //StatisticalValueVisible : 19056356;
//     //Variable type has not been exported.


//     //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

//     //trigger OnAfterGetCurrRecord()
//     //>>>> ORIGINAL CODE:
//     //begin
//     /*
//     IF ClientTypeManagement.GetCurrentClientType <> CLIENTTYPE::ODataV4 THEN
//       UpdateStatisticalValue;
//     UpdateErrors;
//     */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//     /*
//     UpdateStatisticalValue;
//     */
//     //end;


//     //Unsupported feature: Code Modification on "OnOpenPage".

//     //trigger OnOpenPage()
//     //>>>> ORIGINAL CODE:
//     //begin
//     /*
//     IsSaasExcelAddinEnabled := ServerConfigSettingHandler.GetIsSaasExcelAddinEnabled;
//     IF ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::ODataV4 THEN
//       EXIT;

//     IF IsOpenedFromBatch THEN BEGIN
//       CurrentJnlBatchName := "Journal Batch Name";
//       IntraJnlManagement.OpenJnl(CurrentJnlBatchName,Rec);
//     #8..10
//     IF NOT JnlSelected THEN
//       ERROR('');
//     IntraJnlManagement.OpenJnl(CurrentJnlBatchName,Rec);

//     LineStyleExpression := 'Standard';
//     */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//     /*
//     #5..13
//     */
//     //end;

//     local procedure CurrentJnlBatchNameOnAfterVali()
//     begin
//         CurrPage.SaveRecord;
//         //IntraJnlManagement.SetName(CurrentJnlBatchName,Rec);
//         CurrPage.Update(false);
//     end;

//     //Unsupported feature: Property Deletion (ApplicationArea).


//     //Unsupported feature: Property Deletion (UsageCategory).


//     //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

// }
