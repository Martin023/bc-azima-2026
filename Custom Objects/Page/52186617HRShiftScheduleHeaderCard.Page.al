// page 52186617 "HR Shift Schedule Header Card"
// {
//     PageType = Document;
//     SourceTable = "HR Shift Schedule Header";
//     ApplicationArea = Basic;
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 field("Code"; Rec.Code)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Description; Rec.Description)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Shift Code"; Rec."Shift Code")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Assigned Employees"; Rec."Assigned Employees")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//             part(Control6; "HR Shift Schedule Lines")
//             {
//                 ApplicationArea = Basic;
//                 SubPageLink = Code = FIELD(Code);
//             }
//         }
//     }

//     actions
//     {
//     }
// }

