// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52187221 pageextension52187221 extends "User Plan Members" 
// {

//     //Unsupported feature: Property Modification (Name) on ""User Plan Members"(Page 9822)".

//     Caption = 'Permission Sets';

//     //Unsupported feature: Property Modification (SourceTable) on ""User Plan Members"(Page 9822)".


//     //Unsupported feature: Property Insertion (SourceTableView) on ""User Plan Members"(Page 9822)".

//     layout
//     {
//         modify(Group)
//         {
//             Caption = 'Permission Set';
//         }
//         modify("User Name")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on ""User Name"(Control 3)".


//             //Unsupported feature: Property Modification (Name) on ""User Name"(Control 3)".

//             Caption = 'Permission Set';
//             Editable = RoleIDEditable;
//         }
//         modify("User Full Name")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on ""User Full Name"(Control 4)".


//             //Unsupported feature: Property Modification (Name) on ""User Full Name"(Control 4)".

//             Caption = 'Name';
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""User Name"(Control 3)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""User Full Name"(Control 4)".

//         modify("Plan Name")
//         {
//             Visible = false;
//         }
//         addfirst(factboxes)
//         {
//             part(Control17;"Permissions FactBox")
//             {
//                 Caption = 'Permissions';
//                 SubPageLink = "Role ID"=field("Role ID");
//             }
//             part(Control19;"Tenant Permissions FactBox")
//             {
//                 Caption = 'Tenant Permissions';
//                 Editable = false;
//                 SubPageLink = "Role ID"=field("Role ID"),
//                               "App ID"=field("App ID");
//             }
//         }
//     }
//     actions
//     {

//         addfirst(navigation)
//         {
//             group(ShowPermissions)
//             {
//                 Caption = 'Permissions';
//                 Image = Permission;
//                 action(Permissions)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Permissions';
//                     Image = Permission;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     Scope = Repeater;
//                     ShortCutKey = 'Shift+Ctrl+p';
//                 }
//                 action("Permission Set by User")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Permission Set by User';
//                     Image = Permission;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     RunObject = Page "Permission Set by User";
//                 }
//                 action("Permission Set by User Group")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Permission Set by User Group';
//                     Image = Permission;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     RunObject = Page "Permission Set by User Group";
//                 }
//             }
//             group("User Groups")
//             {
//                 Caption = 'User Groups';
//                 action("User by User Group")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'User by User Group';
//                     Image = User;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     RunObject = Page "User by User Group";
//                 }
//                 action(UserGroups)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'User Groups';
//                     Image = Users;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     RunObject = Page "User Groups";
//                 }
//             }
//         }
//         addfirst(processing)
//         {
//             group("<Functions>")
//             {
//                 Caption = 'F&unctions';
//                 Image = "Action";
//                 action("<CopyPermissionSet>")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Copy Permission Set';
//                     Ellipsis = true;
//                     Enabled = PermissionEditable;
//                     Image = Copy;
//                 }
//             }
//         }
//     }

//     var
//         AlterAppPermSetErr: label 'You cannot modify application-level permission sets.';
//         PermissionEditable: Boolean;
//         RoleIDEditable: Boolean;


//     //Unsupported feature: Code Insertion on "OnAfterGetRecord".

//     //trigger OnAfterGetRecord()
//     //begin
//         /*
//         PermissionEditable := ISNULLGUID("App ID");
//         RoleIDEditable := FALSE;
//         */
//     //end;


//     //Unsupported feature: Code Insertion on "OnDeleteRecord".

//     //trigger OnDeleteRecord(): Boolean
//     //var
//         //PermissionSet: Record "Permission Set";
//     //begin
//         /*
//         IF NOT ISNULLGUID("App ID") THEN
//           ERROR(AlterAppPermSetErr);

//         PermissionSet.GET("Role ID");
//         PermissionSet.DELETE;
//         PermissionEditable := ISNULLGUID("App ID");
//         EXIT(FALSE); // Causes UI to stop processing the action - we handled it manually
//         */
//     //end;


//     //Unsupported feature: Code Insertion on "OnInsertRecord".

//     //trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     //var
//         //PermissionSet: Record "Permission Set";
//     //begin
//         /*
//         PermissionSet.INIT;
//         PermissionSet."Role ID" := "Role ID";
//         PermissionSet.Name := Name;
//         PermissionSet.INSERT;
//         PermissionEditable := ISNULLGUID("App ID");
//         RoleIDEditable := FALSE;
//         EXIT(FALSE); // Causes UI to stop processing the action - we handled it manually
//         */
//     //end;


//     //Unsupported feature: Code Insertion on "OnModifyRecord".

//     //trigger OnModifyRecord(): Boolean
//     //var
//         //PermissionSet: Record "Permission Set";
//     //begin
//         /*
//         IF NOT ISNULLGUID("App ID") THEN
//           ERROR(AlterAppPermSetErr);

//         PermissionSet.GET(xRec."Role ID");
//         IF xRec."Role ID" <> "Role ID" THEN BEGIN
//           PermissionSet.RENAME(xRec."Role ID","Role ID");
//           PermissionSet.GET("Role ID");
//         END;
//         PermissionSet.Name := Name;
//         PermissionSet.MODIFY;
//         PermissionEditable := ISNULLGUID("App ID");
//         EXIT(FALSE); // Causes UI to stop processing the action - we handled it manually
//         */
//     //end;


//     //Unsupported feature: Code Insertion on "OnNewRecord".

//     //trigger OnNewRecord(BelowxRec: Boolean)
//     //begin
//         /*
//         // Allow edits only on a new record - underlying tables do not allow renames.
//         RoleIDEditable := TRUE;
//         */
//     //end;

//     //Unsupported feature: Property Deletion (Editable).


//     //Unsupported feature: Property Deletion (LinksAllowed).

// }
