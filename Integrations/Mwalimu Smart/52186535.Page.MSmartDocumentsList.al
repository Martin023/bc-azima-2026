// page 52186535 "M-Smart Documents List"
// {
//     ApplicationArea = All;
//     Caption = 'Mwalimu Smart Documents List';
//     PageType = List;
//     SourceTable = "M-Smart Documents";
//     UsageCategory = Lists;

//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;

//     DataCaptionFields = "No.", "Member No.", "Member Name", "Document Type", "Landing Department", Status;

//     CardPageId = "M-Smart Document";

//     layout
//     {
//         area(content)
//         {
//             repeater(General)
//             {
//                 field("No."; Rec."No.")
//                 {
//                     ToolTip = 'Specifies the value of the No. field.';
//                 }
//                 field("Member No."; Rec."Member No.")
//                 {
//                     ToolTip = 'Specifies the value of the Member No. field.';
//                 }
//                 field("Member Name"; Rec."Member Name")
//                 {
//                     ToolTip = 'Specifies the value of the Member Name field.';
//                 }
//                 field("Document Type"; Rec."Document Type")
//                 {
//                     ToolTip = 'Specifies the value of the Document Type field.';
//                 }
//                 field("Landing Department"; Rec."Landing Department")
//                 {
//                     ToolTip = 'Specifies the value of the Landing Department field.';
//                 }
//                 field("Responsible Officer"; Rec."Responsible Officer")
//                 {
//                     ToolTip = 'Specifies the value of the Responsible Officer field.';
//                 }

//                 field("Supervisor ID"; Rec."Supervisor ID")
//                 {
//                     ToolTip = 'Specifies the value of the Supervisor ID field.';
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ToolTip = 'Specifies the value of the Status field.';
//                 }
//                 field("Last Updated By"; Rec."Last Updated By")
//                 {
//                     ToolTip = 'Specifies the value of the Last Updated By field.';
//                 }
//                 field("Created At"; Rec.SystemCreatedAt)
//                 {
//                     ToolTip = 'Specifies the value of the Created At field.';
//                 }
//                 field("Modified At"; Rec.SystemModifiedAt)
//                 {
//                     ToolTip = 'Specifies the value of the Modified At field.';
//                 }
//             }
//         }
//     }

//     trigger OnOpenPage()
//     var
//         myInt: Integer;
//     begin
//         // exit;

//         Rec.CalcFields("Responsible Officer", "Supervisor ID");

//         // Rec.FilterGroup := -1;
//         Rec.SetFilter("Responsible Officer", UserId);
//         // Rec.SetFilter("Supervisor ID", UserId);

//         // Rec.CalcFields("Responsible Officer", "Supervisor ID");
//         // if Rec.FindSet() then
//         //     repeat
//         //         if (Rec."Responsible Officer" = UserId) or (Rec."Supervisor ID" = UserId) then begin
//         //             if Rec."Supervisor ID" = UserId then begin
//         //                 Rec.SetFilter("Supervisor ID", UserId);
//         //                 exit;
//         //             end;

//         //             if Rec."Responsible Officer" = UserId then begin
//         //                 Rec.SetFilter("Responsible Officer", UserId);
//         //                 exit;
//         //             end;
//         //         end // else
//         //             // Rec.SetFilter("No.", '1');
//         //     until Rec.Next() = 0;

//     end;
// }
