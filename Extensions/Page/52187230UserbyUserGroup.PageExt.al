// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52187230 pageextension52187230 extends "User by User Group" 
// {
//     layout
//     {
//         modify(SelectedCompany)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("User Name")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Full Name")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(MemberOfAllGroups)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Column1)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Column2)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Column3)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Column4)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Column5)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Column6)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Column7)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Column8)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Column9)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Column10)
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "SelectedCompany(Control 23)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""User Name"(Control 3)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Full Name"(Control 4)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "MemberOfAllGroups(Control 22)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Column1(Control 11)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Column2(Control 12)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Column3(Control 13)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Column4(Control 14)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Column5(Control 5)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Column6(Control 17)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Column7(Control 18)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Column8(Control 19)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Column9(Control 20)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Column10(Control 21)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on "Control6(Control 6)".

//     }
//     actions
//     {
//         modify(AllColumnsLeft)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(ColumnLeft)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(ColumnRight)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(AllColumnsRight)
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "AllColumnsLeft(Action 7)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "ColumnLeft(Action 15)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "ColumnRight(Action 16)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "AllColumnsRight(Action 25)".

//     }

//     //Unsupported feature: Code Modification on "OnOpenPage".

//     //trigger OnOpenPage()
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         NoOfRecords := UserGroup.COUNT;
//         PermissionPagesMgt.Init(NoOfRecords,ARRAYLEN(UserGroupCodeArr));
//         SelectedCompany := COMPANYNAME;
//         HideExternalUsers;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         NoOfRecords := UserGroup.COUNT;
//         PermissionPagesMgt.Init(NoOfRecords,ARRAYLEN(UserGroupCodeArr));
//         */
//     //end;
// }
