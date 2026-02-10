// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52185654 pageextension52185654 extends Objects 
// {
//     layout
//     {
//         modify("Object Type")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Object ID")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Object Caption")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Object Name")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(ExtensionName)
//         {

//             //Unsupported feature: Property Modification (Name) on "ExtensionName(Control 3)".

//             Caption = 'Application Name';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on "ExtensionName(Control 3)".

//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Object Type"(Control 11)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Object ID"(Control 2)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Object Caption"(Control 4)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Object Name"(Control 12)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "ExtensionName(Control 3)".

//         addfirst(factboxes)
//         {
//             systempart(Control1900383207;Links)
//             {
//                 Visible = false;
//             }
//             systempart(Control1905767507;Notes)
//             {
//                 Visible = false;
//             }
//         }
//     }

//     var
//         ApplicationName: Text;


//     //Unsupported feature: Code Modification on "OnAfterGetRecord".

//     //trigger OnAfterGetRecord()
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         ExtensionName := '';
//         IF ISNULLGUID("App Package ID") THEN
//           EXIT;
//         IF NAVApp.GET("App Package ID") THEN
//           ExtensionName := NAVApp.Name;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         ApplicationName := '';
//         #2..4
//           ApplicationName := NAVApp.Name;
//         */
//     //end;
// }
