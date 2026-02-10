// page 52186153 "Budget Workplan Names"
// {
//     Caption = 'G/L Budget Names';
//     PageType = List;
//     SourceTable = "Procurment Plan Name";

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field(Name; Rec.Name)
//                 {
//                 }
//                 field(Description; Rec.Description)
//                 {
//                 }
//                 field("Budget Dimension 1 Code"; Rec."Budget Dimension 1 Code")
//                 {
//                 }
//                 field("Budget Dimension 2 Code"; Rec."Budget Dimension 2 Code")
//                 {
//                 }
//                 field("Budget Dimension 3 Code"; Rec."Budget Dimension 3 Code")
//                 {
//                 }
//                 field("Budget Dimension 4 Code"; Rec."Budget Dimension 4 Code")
//                 {
//                 }
//                 field(Blocked; Rec.Blocked)
//                 {
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             systempart(Control1900383207; Links)
//             {
//                 Visible = false;
//             }
//             systempart(Control1905767507; Notes)
//             {
//                 Visible = false;
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(EditBudget)
//             {
//                 Caption = 'Edit Budget';
//                 Image = EditLines;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 ShortCutKey = 'Return';

//                 trigger OnAction()
//                 var
//                     //Budget: Page "Budget Workplan";
//                 begin
//                     Budget.SetBudgetName(Name);
//                     Budget.Run;
//                 end;
//             }
//         }
//     }

//     //[Scope('OnPrem')]
//     //procedure GetSelectionFilter(): Text
//     var
//         GLBudgetName: Record Workplan;
//         SelectionFilterManagement: Codeunit SelectionFilterManagement;
//     // begin
//     //     CurrPage.SetSelectionFilter(GLBudgetName);
//     //     exit(SelectionFilterManagement.GetSelectionFilterForWorkPlanName(GLBudgetName));
//     // end;
// }

