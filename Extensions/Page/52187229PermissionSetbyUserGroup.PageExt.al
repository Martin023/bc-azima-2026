// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52187229 pageextension52187229 extends "Permission Set by User Group" 
// {
//     layout
//     {
//         modify("Role ID")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Name)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("App ID")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("App Name")
//         {
//             Caption = 'Nav App Name';
//             ApplicationArea = Basic;
//         }
//         modify(AllUsersHavePermission)
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

//         //Unsupported feature: Property Deletion (CaptionML) on ""Role ID"(Control 3)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Role ID"(Control 3)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


//         //Unsupported feature: Property Deletion (CaptionML) on ""App ID"(Control 27)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""App ID"(Control 27)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""App Name"(Control 8)".


//         //Unsupported feature: Code Modification on "AllUsersHavePermission(Control 22).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             IF AllGroupsHavePermission THEN
//               IF NOT CONFIRM(AllUserGrpGetsPermissionQst) THEN
//                 ERROR('');

//             SetColumnPermission(0,AllGroupsHavePermission);
//             CurrPage.UPDATE(FALSE);
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             SetColumnPermission(0,AllGroupsHavePermission);
//             CurrPage.UPDATE(FALSE);
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "AllUsersHavePermission(Control 22)".


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


//         //Unsupported feature: Property Deletion (ApplicationArea) on "Control23(Control 23)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on "Control26(Control 26)".

//     }
//     actions
//     {
//         // modify(Permissions)
//         // {
//         //     ApplicationArea = Basic;

//             //Unsupported feature: Property Insertion (RunObject) on "Permissions(Action 6)".


//             //Unsupported feature: Property Insertion (RunPageLink) on "Permissions(Action 6)".

//         //     Enabled = PermissionEditable;
//         // }
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
//         // modify(Permissions)
//         // {
//         //     Visible = false;
//         // }

//         //Unsupported feature: Property Deletion (ToolTipML) on "Permissions(Action 6)".

//         modify(CopyPermissionSet)
//         {
//             Visible = true;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "AllColumnsLeft(Action 7)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "ColumnLeft(Action 15)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "ColumnRight(Action 16)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "AllColumnsRight(Action 25)".

//     }

//     var
//         PermissionEditable: Boolean;


//     //Unsupported feature: Code Modification on "OnAfterGetRecord".

//     //trigger OnAfterGetRecord()
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         FindUserGroups;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         FindUserGroups;
//         PermissionEditable := ISNULLGUID("App ID");
//         */
//     //end;


//     //Unsupported feature: Code Modification on "UserGroupHasPermission(PROCEDURE 14)".

//     //procedure UserGroupHasPermission();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         UserGroupPermissionSet.SETRANGE("User Group Code",UserGroup.Code);
//         UserGroupPermissionSet.SETRANGE("Role ID",AggregatePermissionSet."Role ID");
//         UserGroupPermissionSet.SETRANGE("App ID",AggregatePermissionSet."App ID");
//         EXIT(NOT UserGroupPermissionSet.ISEMPTY);
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         UserGroupPermissionSet.SETRANGE("User Group Code",UserGroup.Code);
//         UserGroupPermissionSet.SETRANGE("Role ID",AggregatePermissionSet."Role ID");
//         EXIT(NOT UserGroupPermissionSet.ISEMPTY);
//         */
//     //end;
// }
