// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52187202 pageextension52187202 extends "Permission Sets" 
// {

//     //Unsupported feature: Property Modification (Name) on ""Permission Sets"(Page 9802)".


//     //Unsupported feature: Property Modification (SourceTable) on ""Permission Sets"(Page 9802)".


//     //Unsupported feature: Property Insertion (SourceTableView) on ""Permission Sets"(Page 9802)".

//     layout
//     {
//         modify(PermissionSet)
//         {
//             ApplicationArea = Basic;
//             Editable = true;
//         }
//         // modify(Name)
//         // {

//             //Unsupported feature: Property Modification (Name) on "Name(Control 4)".

//         //     ApplicationArea = Basic;
//         //     Caption = 'Name';
//         // }
//         // modify(Control17)
//         // {
//         //     Caption = 'Permissions';
//         // }
//         // modify(PermissionSet)
//         // {
//         //     Visible = false;
//         // }

//         //Unsupported feature: Property Deletion (ToolTipML) on "PermissionSet(Control 3)".

//         // modify(Name)
//         // {
//         //     Visible = false;
//         // }

//         //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


//         //Unsupported feature: Property Deletion (Editable) on "Name(Control 4)".

//         modify(Type)
//         {
//             Visible = true;
//         }
//         modify("App Name")
//         {
//             Visible = true;
//         }

//         //Unsupported feature: Property Deletion (ApplicationArea) on "Control17(Control 17)".


//         //Unsupported feature: Property Deletion (Editable) on "Control17(Control 17)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on "Control19(Control 19)".

//     }
//     actions
//     {
//         modify(Permissions)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Permission Set by User")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Permission Set by User Group")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("User by User Group")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(UserGroups)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(CopyPermissionSet)
//         {

//             //Unsupported feature: Property Modification (Name) on "CopyPermissionSet(Action 8)".

//             ApplicationArea = Basic;
//             Enabled = true;
//         }

//         //Unsupported feature: Code Insertion (VariableCollection) on "Permissions(Action 6).OnAction".

//         //trigger (Variable: Permission)()
//         //Parameters and return type have not been exported.
//         //begin
//             /*
//             */
//         //end;


//         //Unsupported feature: Code Modification on "Permissions(Action 6).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             PermissionPagesMgt.ShowPermissions(Scope,"App ID","Role ID",FALSE);
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             Permission.SETRANGE("Role ID","Role ID");
//             Permissions.SETRECORD(Permission);
//             Permissions.SETTABLEVIEW(Permission);
//             Permissions.EDITABLE := PermissionEditable;
//             Permissions.RUN;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "Permissions(Action 6)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Permission Set by User"(Action 11)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Permission Set by User Group"(Action 12)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""User by User Group"(Action 14)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "UserGroups(Action 13)".



//         //Unsupported feature: Code Insertion (VariableCollection) on ""<CopyPermissionSet>"(Action 8).OnAction".

//         //trigger (Variable: PermissionSet)()
//         //Parameters and return type have not been exported.
//         //begin
//             /*
//             */
//         //end;


//         //Unsupported feature: Code Modification on "CopyPermissionSet(Action 8).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             AggregatePermissionSet.SETRANGE(Scope,Scope);
//             AggregatePermissionSet.SETRANGE("App ID","App ID");
//             AggregatePermissionSet.SETRANGE("Role ID","Role ID");

//             CopyPermissionSet.SETTABLEVIEW(AggregatePermissionSet);
//             CopyPermissionSet.RUNMODAL;

//             IF AggregatePermissionSet.GET(AggregatePermissionSet.Scope::Tenant,ZeroGuid,CopyPermissionSet.GetNewRoleID) THEN BEGIN
//               INIT;
//               TRANSFERFIELDS(AggregatePermissionSet);
//               SetType;
//               INSERT;
//               GET(Type,"Role ID");
//             END;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             PermissionSet.SETRANGE("Role ID","Role ID");
//             CopyPermissionSet.SETTABLEVIEW(PermissionSet);
//             CopyPermissionSet.RUNMODAL;

//             IF GET(Scope::System,NullGUID,CopyPermissionSet.GetRoleId) THEN;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "CopyPermissionSet(Action 8)".


//         //Unsupported feature: Property Deletion (Promoted) on "CopyPermissionSet(Action 8)".


//         //Unsupported feature: Property Deletion (PromotedCategory) on "CopyPermissionSet(Action 8)".


//         //Unsupported feature: Property Deletion (PromotedOnly) on "CopyPermissionSet(Action 8)".

//         modify(ImportPermissionSets)
//         {
//             Visible = true;
//         }
//         modify(ExportPermissionSets)
//         {
//             Visible = true;
//         }
//     }

//     var
//         Permission: Record Permission;
//         Permissions: Page Permissions;


//     //Unsupported feature: Property Modification (Id) on "CopyPermissionSet(Action 8).OnAction.CopyPermissionSet(Variable 1000)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //CopyPermissionSet : 1000;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //CopyPermissionSet : 1034;
//         //Variable type has not been exported.

//     var
//         PermissionSet: Record "Permission Set";

//     var
//         AlterAppPermSetErr: label 'You cannot modify application-level permission sets.';
//         PermissionEditable: Boolean;
//         RoleIDEditable: Boolean;


//     //Unsupported feature: Code Modification on "OnAfterGetRecord".

//     //trigger OnAfterGetRecord()
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         IsPermissionSetEditable := Type = Type::"User-Defined";
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         PermissionEditable := ISNULLGUID("App ID");
//         RoleIDEditable := FALSE;
//         */
//     //end;


//     //Unsupported feature: Code Insertion (VariableCollection) on "OnDeleteRecord".

//     //trigger (Variable: PermissionSet)()
//     //Parameters and return type have not been exported.
//     //begin
//         /*
//         */
//     //end;


//     //Unsupported feature: Code Modification on "OnDeleteRecord".

//     //trigger OnDeleteRecord(): Boolean
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         PermissionPagesMgt.DisallowEditingPermissionSetsForNonAdminUsers;

//         IF Type <> Type::"User-Defined" THEN
//           ERROR(CannotDeletePermissionSetErr);

//         PermissionSetLink.SETRANGE("Linked Permission Set ID","Role ID");
//         PermissionSetLink.DELETEALL;

//         UserGroupPermissionSet.SETRANGE("Role ID","Role ID");
//         UserGroupPermissionSet.DELETEALL;

//         TenantPermissionSet.GET("App ID","Role ID");
//         TenantPermissionSet.DELETE;

//         CurrPage.UPDATE;
//         EXIT(TRUE);
//         */
//     //end;
//     //>>>> MODIFIED CODE:
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


//     //Unsupported feature: Code Insertion (VariableCollection) on "OnInsertRecord".

//     //trigger (Variable: PermissionSet)()
//     //Parameters and return type have not been exported.
//     //begin
//         /*
//         */
//     //end;


//     //Unsupported feature: Code Modification on "OnInsertRecord".

//     //trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         PermissionPagesMgt.DisallowEditingPermissionSetsForNonAdminUsers;

//         TenantPermissionSet.INIT;
//         TenantPermissionSet."App ID" := ZeroGUID;
//         TenantPermissionSet."Role ID" := "Role ID";
//         TenantPermissionSet.Name := Name;
//         TenantPermissionSet.INSERT;

//         INSERT;
//         GET(Type::"User-Defined","Role ID");
//         EXIT(FALSE);
//         */
//     //end;
//     //>>>> MODIFIED CODE:
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


//     //Unsupported feature: Code Insertion (VariableCollection) on "OnModifyRecord".

//     //trigger (Variable: PermissionSet)()
//     //Parameters and return type have not been exported.
//     //begin
//         /*
//         */
//     //end;


//     //Unsupported feature: Code Modification on "OnModifyRecord".

//     //trigger OnModifyRecord(): Boolean
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         PermissionPagesMgt.DisallowEditingPermissionSetsForNonAdminUsers;

//         IF Type = Type::"User-Defined" THEN BEGIN
//           TenantPermissionSet.GET(xRec."App ID",xRec."Role ID");
//           IF xRec."Role ID" <> "Role ID" THEN BEGIN
//             TenantPermissionSet.RENAME(xRec."App ID","Role ID");
//             TenantPermissionSet.GET(xRec."App ID","Role ID");
//           END;
//           TenantPermissionSet.Name := Name;
//           TenantPermissionSet.MODIFY;
//           CurrPage.UPDATE(FALSE);
//           EXIT(TRUE);
//         END;
//         EXIT(FALSE); // Causes UI to stop processing the action - we handled it manually
//         */
//     //end;
//     //>>>> MODIFIED CODE:
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


//     //Unsupported feature: Code Modification on "OnNewRecord".

//     //trigger OnNewRecord(BelowxRec: Boolean)
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         Type := Type::"User-Defined";
//         IsPermissionSetEditable := TRUE;
//         Scope := Scope::Tenant;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         // Allow edits only on a new record - underlying tables do not allow renames.
//         RoleIDEditable := TRUE;
//         */
//     //end;

//     //Unsupported feature: Property Deletion (Permissions).


//     //Unsupported feature: Property Deletion (ApplicationArea).


//     //Unsupported feature: Property Deletion (DelayedInsert).


//     //Unsupported feature: Property Deletion (UsageCategory).


//     //Unsupported feature: Property Deletion (AdditionalSearchTermsML).


//     //Unsupported feature: Property Deletion (SourceTableTemporary).

// }
