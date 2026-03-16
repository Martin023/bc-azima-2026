// page 52186023 "Approved Contract List"
// {
//     Caption = 'Grant List';
//     CardPageID = "Contracts Details Card";
//     Editable = false;
//     PageType = List;
//     SourceTable = Contracts;
//     SourceTableView = WHERE(Status = CONST(Approved));
//     ApplicationArea = Basic, Suite;
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Contract No"; Rec."Contract No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Contractor Type"; Rec."Contractor Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Contractor No"; Rec."Contractor No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Contractor Name"; Rec."Contractor Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Start Date"; Rec."Start Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("End Date"; Rec."End Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Contract Amount"; Rec."Contract Sum")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Responsible Employee"; Rec."Responsible Employee")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("W&IP")
//             {
//                 Caption = 'W&IP';
//                 Visible = false;
//                 action("Calculate WIP")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Calculate WIP';
//                     Ellipsis = true;
//                     Image = CalculateWIP;

//                     trigger OnAction()
//                     var
//                         Job: Record Jobs;
//                     begin
//                     end;
//                 }
//                 action("Post WIP to G/L")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Post WIP to G/L';
//                     Ellipsis = true;
//                     Image = Post;

//                     trigger OnAction()
//                     var
//                         Job: Record Jobs;
//                     begin
//                     end;
//                 }
//                 action("<Page Grant WIP Entries>")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'WIP Entries';
//                     // RunObject = Page Page39005846;
//                     // RunPageLink = Field2 = FIELD("No. Series");
//                     // RunPageView = SORTING(Field2, Field7, Field5);
//                 }
//                 action("<Page Grant WIP G/L Entries>")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     // Caption = 'WIP G/L Entries';
//                     // RunObject = Page Page39005847;
//                     // RunPageLink = Field2 = FIELD("No. Series");
//                     // RunPageView = SORTING(Field2);
//                 }
//             }
//             // group("&Prices")
//             // {
//             //     Caption = '&Prices';
//             //     Visible = false;
//             //     action("<Page Grant Resource Prices>")
//             //     {
//             //         Caption = 'Resource';
//             //         RunObject = Page Page39005848;
//             //         RunPageLink = Field1 = FIELD("No. Series");
//             //     }
//             //     action("<Page Grant Item Prices>")
//             //     {
//             //         Caption = 'Item';
//             //         RunObject = Page Page39005849;
//             //         RunPageLink = Field1 = FIELD("No. Series");
//             //     }
//             //     action("<Page Grant G/L Account Prices>")
//             //     {
//             //         Caption = 'G/L Account';
//             //         RunObject = Page Page39005850;
//             //         RunPageLink = Field1 = FIELD("No. Series");
//             //     }
//             // }
//             group("Plan&ning")
//             {
//                 Caption = 'Plan&ning';
//                 Visible = false;
//                 action("Resource &Allocated per Job")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Resource &Allocated per Job';
//                     RunObject = Page "Resource Allocated per Job";
//                 }
//                 separator(Action26)
//                 {

//                 }
//                 action("Res. Group All&ocated per Job")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Res. Group All&ocated per Job';
//                     RunObject = Page "Res. Gr. Allocated per Job";
//                 }
//             }
//             group("&Grant")
//             {
//                 // Caption = '&Grant';
//                 // action("<Page Approved Proposals Card>")
//                 // {
//                 //     Caption = 'Card';
//                 //     Image = EditLines;
//                 //     RunObject = Page Page39005857;
//                 //     RunPageLink = Field1 = FIELD("No. Series");
//                 //     ShortCutKey = 'Shift+F7';
//                 // }
//                 action("Co&mments")
//                 {
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     RunObject = Page "Comment Sheet";
//                     RunPageLink = "Table Name" = CONST(Job),
//                                   "No." = FIELD("No. Series");
//                     ApplicationArea = Basic, Suite;
//                 }
//                 group(Dimensions)
//                 {
//                     Caption = 'Dimensions';
//                     action("<Page Grant Task Dimensions>")
//                     {
//                         Caption = 'Dimensions-Single';
//                         ShortCutKey = 'Shift+Ctrl+D';
//                         ApplicationArea = Basic, Suite;
//                     }
//                     action("Dimensions-&Multiple")
//                     {
//                         Caption = 'Dimensions-&Multiple';
//                         ApplicationArea = Basic, Suite;

//                         trigger OnAction()
//                         var
//                             Job: Record Jobs;
//                             DefaultDimMultiple: Page "Default Dimensions-Multiple";
//                         begin
//                             // CurrPage.SETSELECTIONFILTER(Job);
//                             // DefaultDimMultiple.SetMultiJob(Job);
//                             // DefaultDimMultiple.RUNMODAL;
//                         end;
//                     }
//                 }
//                 // action("<Page Grant Ledger Entries>")
//                 // {
//                 //     Caption = 'Ledger E&ntries';
//                 //     RunObject = Page Page39005819;
//                 //     RunPageLink = Field2 = FIELD("No. Series");
//                 //     RunPageView = SORTING(Field2, Field1000, Field64, Field3);
//                 //     ShortCutKey = 'Ctrl+F7';
//                 // }
//                 action("Grant Task Lines")
//                 {
//                     Caption = 'Grant Task Lines';
//                     ApplicationArea = Basic, Suite;

//                     trigger OnAction()
//                     begin
//                         /*JTLines.SetJobNo("No.");
//                         JTLines.RUN;*/

//                     end;
//                 }
//                 action("<Page Grant Statistics>")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Statistics';
//                     Image = Statistics;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     // RunObject = Page Page39005880;
//                     // RunPageLink = Field1 = FIELD("No. Series");
//                     ShortCutKey = 'F7';
//                 }
//             }
//         }
//     }
// }

