// page 52186518 "HR Appraisal Eval Areas - ES1"
// {
//     Caption = 'HR Appraisal Evaluation Areas - Employee''s Subordinates';
//     PageType = List;
//     SourceTable = "HR Appraisal Eval Areas";
//     SourceTableView = WHERE("Categorize As" = CONST("Employee's Subordinates"));
//     ApplicationArea = Basic;
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1102760000)
//             {
//                 Editable = true;
//                 ShowCaption = false;
//                 field("Code"; Rec.Code)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Description; Rec.Description)
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         Rec.TestField(Code);
//                     end;
//                 }
//                 field("Unit of Measure"; Rec."Unit of Measure")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Categorize As"; Rec."Categorize As")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Sub Category"; Rec."Sub Category")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Include in Evaluation Form"; Rec."Include in Evaluation Form")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Appraisal Period"; Rec."Appraisal Period")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         Rec."Categorize As" := Rec."Categorize As"::"Employee's Subordinates";
//         Rec."Include in Evaluation Form" := true;
//     end;
// }

