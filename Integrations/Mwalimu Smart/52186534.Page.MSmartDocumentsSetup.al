// page 52186534 "M-Smart Documents Setup"
// {
//     ApplicationArea = All;
//     Caption = 'Mwalimu Smart Documents Setup';
//     PageType = List;
//     SourceTable = "M-Smart Documents Setup";
//     UsageCategory = Administration;

//     layout
//     {
//         area(content)
//         {
//             repeater(General)
//             {
//                 field("Document Type"; Rec."Document Type")
//                 {
//                     ToolTip = 'Specifies the value of the Document Type field.';
//                 }
//                 field("Landing Department"; Rec."Landing Department")
//                 {
//                     ToolTip = 'Specifies the value of the Landing Department field.';
//                 }

//                 field("Created By"; Rec."Created By")
//                 {
//                     ToolTip = 'Specifies the value of the Created By field.';
//                 }
//                 field("Created At"; Rec."Created At")
//                 {
//                     ToolTip = 'Specifies the value of the Created At field.';
//                 }
//                 field("Modified By"; Rec."Modified By")
//                 {
//                     ToolTip = 'Specifies the value of the Modified By field.';
//                 }
//                 field("Modified At"; Rec."Modified At")
//                 {
//                     ToolTip = 'Specifies the value of the Modified At field.';
//                 }
//             }
//         }
//     }

//     trigger OnOpenPage()
//     begin
//         FnRestrictAccess();
//     end;

//     procedure FnRestrictAccess()
//     var
//         StatusPermission: Record "Status Change Permissions.";
//         ChangePermission: Record "Status Change Permissions.";
//         ErrorOnRestrictViewTxt: Label 'You do not have permission on View,Read,Modify on this Page. Contact system administrator for assistance. %1 - %2';
//     begin
//         StatusPermission.Reset;
//         StatusPermission.SetRange("User ID", DATABASE.UserId);
//         StatusPermission.SetRange("Edit Setup", true);
//         StatusPermission.SetRange("Function Extended", StatusPermission."Function Extended"::Administrator);

//         if not StatusPermission.Find('-') then begin
//             // CurrPage.Editable := false;
//             Error(ErrorOnRestrictViewTxt, UserId, Rec.TableCaption);
//         end
//         // else begin
//         //     CurrPage.Editable := true;
//         // end;
//     end;
// }
