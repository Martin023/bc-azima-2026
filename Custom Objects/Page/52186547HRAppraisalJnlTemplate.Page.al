// page 52186547 "HR Appraisal Jnl. Template"
// {
//     Caption = 'Leave Jnl. Template List';
//     Editable = true;
//     PageType = List;
//     PromotedActionCategories = 'New,Process,Report,Template';
//     SourceTable = "HR Appraisal Journal Template";
//     ApplicationArea = Basic;
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field(Name; Rec.Name)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Description; Rec.Description)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Source Code"; Rec."Source Code")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Reason Code"; Rec."Reason Code")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = true;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group(Template)
//             {
//                 Caption = 'Template';
//                 action("&Batches")
//                 {
//                     Caption = '&Batches';
//                     Image = ChangeBatch;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     RunObject = Page "HR Leave Batches";
//                     RunPageLink = "Journal Template Name" = FIELD(Name);
//                 }
//             }
//         }
//     }
// }

