// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185800 "Capex Requisition"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-kenpipe-2024/Layout/Capex Requisition.rdl';

//     dataset
//     {
//         dataitem("Purchase Header"; "Purchase Header")
//         {
//             column(ReportForNavId_1; 1)
//             {
//             }
//             column(CompanyName; CompanyInfo.Name)
//             {
//             }
//             column(CompanyPicture; CompanyInfo.Picture)
//             {
//             }
//             column(No_PurchaseHeader; "Purchase Header"."No.")
//             {
//             }
//             column(ShiptoAddress_PurchaseHeader; "Purchase Header"."Ship-to Address")
//             {
//             }
//             column(PostingDate_PurchaseHeader; "Purchase Header"."Posting Date")
//             {
//             }
//             column(LocationCode_PurchaseHeader; "Purchase Header"."Location Code")
//             {
//             }
//             column(PaytoName_PurchaseHeader; "Purchase Header"."Pay-to Name")
//             {
//             }
//             column(NumberText_1_; NumberText[1])
//             {
//             }
//             column(CurrentBudget; BudgetaryControl."Current Budget Code")
//             {
//             }
//             column(PostingDescription_PurchaseHeader; "Purchase Header"."Posting Description")
//             {
//             }
//             dataitem("Purchase Line"; "Purchase Line")
//             {
//                 DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
//                 column(ReportForNavId_2; 2)
//                 {
//                 }
//                 column(No_PurchaseLine; "Purchase Line"."No.")
//                 {
//                 }
//                 column(Description_PurchaseLine; "Purchase Line".Description)
//                 {
//                 }
//                 column(Description2_PurchaseLine; "Purchase Line"."Description 2")
//                 {
//                 }
//                 column(Amount_PurchaseLine; "Purchase Line".Amount)
//                 {
//                 }
//                 column(AmountIncludingVAT_PurchaseLine; "Purchase Line"."Amount Including VAT")
//                 {
//                 }
//                 column(DirectUnitCost_PurchaseLine; "Purchase Line"."Direct Unit Cost")
//                 {
//                 }
//                 column(UnitofMeasure_PurchaseLine; "Purchase Line"."Unit of Measure")
//                 {
//                 }
//                 column(Quantity_PurchaseLine; "Purchase Line".Quantity)
//                 {
//                 }
//                 column(BudgetGL; BudgetGL)
//                 {
//                 }
//                 column(BudgetAmount; BudgetAmount)
//                 {
//                 }
//                 column(CommitmentsAmount; CommitmentsAmount)
//                 {
//                 }
//                 column(ActualsAmount; ActualsAmount)
//                 {
//                 }
//                 column(AssetAmount; AssetAmount)
//                 {
//                 }
//                 column(AssetBudget; AssetBudget)
//                 {
//                 }
//                 column(SerialNo; SerialNo)
//                 {
//                 }
//                 column(GLAccountName; GLAccount.Name)
//                 {
//                 }

//                 trigger OnAfterGetRecord()
//                 begin
//                     if FixedAsset.Get("No.") then begin
//                         if FAPosting.Get(FixedAsset."FA Posting Group") then
//                             if "Purchase Line"."FA Posting Type" = "Purchase Line"."fa posting type"::"Acquisition Cost" then
//                                 BudgetGL := FAPosting."Acquisition Cost Account"
//                             else
//                                 if "Purchase Line"."FA Posting Type" = "Purchase Line"."fa posting type"::"Acquisition Cost" then
//                                     BudgetGL := FAPosting."Maintenance Expense Account";
//                     end;

//                     if BudgetGL <> '' then
//                         GLAccount.Get(BudgetGL);

//                     BudgetAmount := CalcBudget.CheckBudget("Purchase Line", 1);
//                     CommitmentsAmount := CalcBudget.CheckBudget("Purchase Line", 2);
//                     ActualsAmount := CalcBudget.CheckBudget("Purchase Line", 3);
//                     AssetAmount := "Purchase Line"."Direct Unit Cost";
//                     FABudget.SetRange(FABudget."FA No.", "Purchase Line"."No.");
//                     FABudget.CalcSums("Cost Amount");
//                     AssetBudget := FABudget."Cost Amount";

//                     SerialNo += 1;
//                 end;
//             }
//             dataitem("Approval Entry"; "Approval Entry")
//             {
//                 DataItemLink = "Document No." = field("No.");
//                 column(ReportForNavId_29; 29)
//                 {
//                 }
//                 column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
//                 {
//                 }
//                 column(LastDateTimeModified_ApprovalEntry; "Approval Entry"."Last Date-Time Modified")
//                 {
//                 }
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 //Amount into words
//                 // CheckReport.InitTextVariable;
//                 // CheckReport.FormatNoText(NumberText, Amount, '');
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     trigger OnPreReport()
//     begin
//         SerialNo := 0;
//         //if BudgetaryControl.Get then
//     end;

//     var
//         CompanyInfo: Record "Company Information";
//         BudgetGL: Code[20];
//         FixedAsset: Record "Fixed Asset";
//         FAPosting: Record "FA Posting Group";
//         BudgetAmount: Decimal;
//         CommitmentsAmount: Decimal;
//         ActualsAmount: Decimal;
//         AssetAmount: Decimal;
//         AssetBudget: Decimal;
//         //CalcBudget: Codeunit UnknownCodeunit52185474;
//         FABudget: Record "FA Budget Entry";
//         SerialNo: Integer;
//         NumberText: array[2] of Text[120];
//         //CheckReport: Report Check;
//         BudgetaryControl: Record "Budgetary Control Setup";
//         GLAccount: Record "G/L Account";
// }

