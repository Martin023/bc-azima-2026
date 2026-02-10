// page 52186657 "Object-Renumbering"
// {
//     // http://www.dynamics.is/wp-admin/post.php?post=2064

//     Caption = 'Object Renumbering';
//     PageType = List;
//     SaveValues = true;
//     SourceTable = "Object-Renumber";

//     layout
//     {
//         area(content)
//         {
//             group("Using Renumbering Lines")
//             {
//                 Caption = 'Using Renumbering Lines';
//                 repeater(Group)
//                 {
//                     field("Source Type"; Rec."Source Type")
//                     {
//                     }
//                     field("Source ID"; Rec."Source ID")
//                     {
//                     }
//                     field("Destination ID"; Rec."Destination ID")
//                     {
//                     }
//                 }
//             }
//             group(Controls)
//             {
//                 Caption = 'Using Control IDs';
//                 field(ControlStartRange; Rec.ControlStartRange)
//                 {
//                     Caption = 'Control Start Range';
//                 }
//                 field(ControlEndRange; Rec.ControlEndRange)
//                 {
//                     Caption = 'Control End Range';
//                 }
//                 field(ControlNewStartRange; Rec.ControlNewStartRange)
//                 {
//                     Caption = 'Control New Start Range';
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action("Read Object Lines")
//             {
//                 Caption = 'Read Object Lines';
//                 Image = Import;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 ToolTip = 'Creates renumbering lines base on the objects in the selected object file';

//                 trigger OnAction()
//                 begin
//                     LoadObjectDataIntoSetup;
//                 end;
//             }
//             action("Suggest IDs")
//             {
//                 Caption = 'Suggest IDs';
//                 Image = Suggest;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 ToolTip = 'Suggest new object numbers in the range from 50.000 based on the available objects in the current license';

//                 trigger OnAction()
//                 begin
//                     SuggestIDsFromPermissionRange;
//                 end;
//             }
//             action("Read from Excel")
//             {
//                 Caption = 'Read from Excel';
//                 Image = Excel;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 ToolTip = 'Reads object renumbering lines from Excel Sheet created with the Write to Excel process';

//                 trigger OnAction()
//                 begin
//                     ImportSetupFromExcel;
//                 end;
//             }
//             action("Write to Excel")
//             {
//                 Caption = 'Write to Excel';
//                 Image = Excel;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 ToolTip = 'Writes current renumbering lines to a new Excel Sheet to me managed within Excel and reread into the renumbering lines';

//                 trigger OnAction()
//                 begin
//                     ExportSetupToExcel;
//                 end;
//             }
//             action("Renumber Using Lines")
//             {
//                 Caption = 'Renumber Using Lines';
//                 Image = ReOpen;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 ToolTip = 'Prompts for a file to read and for a new file to save with renumbered objects based on the rules in the renumbering lines';

//                 trigger OnAction()
//                 var
//                     TempRenumberingSetup: Record "Object-Renumber" temporary;
//                     RenumberingSetup: Record "Object-Renumber";
//                 begin
//                     CopyToTemp(RenumberingSetup, TempRenumberingSetup);
//                     ReplaceObjectDataContentByRenumberingLines(TempRenumberingSetup);
//                 end;
//             }
//             action("Renumber Using Controls")
//             {
//                 Caption = 'Renumber Using Controls';
//                 Image = ReOpen;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 ToolTip = 'Prompts for a file to read and for a new file to save with renumbered objects based on the rules in the control IDs setup';

//                 trigger OnAction()
//                 begin
//                     ReplaceObjectDataContentByControlIDs(ControlStartRange, ControlEndRange, ControlNewStartRange);
//                 end;
//             }
//         }
//     }

//     var
//         ControlStartRange: Integer;
//         ControlEndRange: Integer;
//         ControlNewStartRange: Integer;
// }

