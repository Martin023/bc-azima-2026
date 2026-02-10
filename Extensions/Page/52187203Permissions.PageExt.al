// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52187203 pageextension52187203 extends Permissions 
// {

//     //Unsupported feature: Property Modification (PageType) on "Permissions(Page 9803)".


//     //Unsupported feature: Property Modification (ShowFilter) on "Permissions(Page 9803)".


//     //Unsupported feature: Property Insertion (DelayedInsert) on "Permissions(Page 9803)".

//     layout
//     {
//         modify(CurrentRoleID)
//         {
//             Caption = 'Role ID';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Insertion (TableRelation) on "CurrentRoleID(Control 39)".

//         }
//         modify("Object Type")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Object ID")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(ObjectName)
//         {

//             //Unsupported feature: Property Modification (Name) on "ObjectName(Control 9)".

//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on "ObjectName(Control 9)".

//         }
//         modify("Read Permission")
//         {
//             ApplicationArea = Basic;
//             Enabled = true;

//             //Unsupported feature: Property Modification (Name) on ""Read Permission"(Control 8)".

//         }
//         modify("Insert Permission")
//         {
//             ApplicationArea = Basic;
//             Enabled = true;

//             //Unsupported feature: Property Modification (Name) on ""Insert Permission"(Control 7)".

//         }
//         modify("Modify Permission")
//         {
//             ApplicationArea = Basic;
//             Enabled = true;

//             //Unsupported feature: Property Modification (Name) on ""Modify Permission"(Control 6)".

//         }
//         modify("Delete Permission")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Name) on ""Delete Permission"(Control 5)".

//             Editable = true;
//         }
//         modify("Execute Permission")
//         {
//             ApplicationArea = Basic;
//             Enabled = true;

//             //Unsupported feature: Property Modification (Name) on ""Execute Permission"(Control 4)".

//         }
//         modify("Security Filter")
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Code Insertion on "CurrentRoleID(Control 39)".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //begin
//             /*
//             FillTempPermissions;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "CurrentRoleID(Control 39)".


//         //Unsupported feature: Property Deletion (Editable) on "CurrentRoleID(Control 39)".



//         //Unsupported feature: Code Insertion on ""Object Type"(Control 11)".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //begin
//             /*
//             ActivateControls;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Object Type"(Control 11)".



//         //Unsupported feature: Code Insertion on ""Object ID"(Control 10)".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //begin
//             /*
//             IsValidatedObjectID := FALSE;
//             ActivateControls;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Object ID"(Control 10)".


//         //Unsupported feature: Property Deletion (LookupPageID) on ""Object ID"(Control 10)".


//         //Unsupported feature: Property Deletion (CaptionML) on "ObjectName(Control 9)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "ObjectName(Control 9)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Read Permission"(Control 8)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Insert Permission"(Control 7)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Modify Permission"(Control 6)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Delete Permission"(Control 5)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Execute Permission"(Control 4)".



//         //Unsupported feature: Code Insertion (VariableCollection) on ""Security Filter"(Control 3).OnAssistEdit".

//         //trigger (Variable: TableFilter)()
//         //Parameters and return type have not been exported.
//         //begin
//             /*
//             */
//         //end;


//         //Unsupported feature: Code Modification on ""Security Filter"(Control 3).OnAssistEdit".

//         //trigger OnAssistEdit()
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             // User cannot edit Security filter field for Systems.
//             // Since this field is empty for System type it can be used as a flag it.
//             IF FORMAT("Security Filter") = '' THEN
//               EXIT;

//             IF PermissionPagesMgt.ShowSecurityFilterForPermission(OutputSecurityFilter,Rec) THEN
//               EVALUATE("Security Filter",OutputSecurityFilter);
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             TableFilter.FILTERGROUP(2);
//             TableFilter.SETRANGE("Table Number","Object ID");
//             TableFilter.FILTERGROUP(0);
//             TableFilterPage.SETTABLEVIEW(TableFilter);
//             TableFilterPage.SetSourceTable(FORMAT("Security Filter"),"Object ID","Object Name");
//             IF ACTION::OK = TableFilterPage.RUNMODAL THEN
//               EVALUATE("Security Filter",TableFilterPage.CreateTextTableFilter(FALSE));
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Security Filter"(Control 3)".

//         addafter(CurrentRoleID)
//         {
//             field(Show;Show)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Show';
//                 OptionCaption = 'Only In Permission Set,All';

//                 trigger OnValidate()
//                 begin
//                     FillTempPermissions;
//                 end;
//             }
//             field(AddRelatedTables;AddRelatedTables)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Add Read Permission to Related Tables';
//             }
//         }
//         addfirst(Group)
//         {
//             field(PermissionSet;Rec."Role ID")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Permission Set';
//                 Enabled = false;
//                 Visible = false;
//             }
//         }
//     }
//     actions
//     {
//         addfirst(Processing)
//         {
//             group("Read Permission")
//             {
//                 Caption = 'Read Permission';
//                 Image = Ledger;
//                 group("Allow Read")
//                 {
//                     Caption = 'Allow Read';
//                     Image = Confirm;
//                     action(AllowReadYes)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Yes';
//                         Image = Approve;

//                         trigger OnAction()
//                         begin
//                             UpdateSelected('R',Rec."read permission"::Yes);
//                         end;
//                     }
//                     action(AllowReadNo)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'No';
//                         Image = Reject;

//                         trigger OnAction()
//                         begin
//                             UpdateSelected('R',Rec."read permission"::" ");
//                         end;
//                     }
//                     action(AllowReadIndirect)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Indirect';
//                         Image = Indent;

//                         trigger OnAction()
//                         begin
//                             UpdateSelected('R',Rec."read permission"::Indirect);
//                         end;
//                     }
//                 }
//             }
//             group("Insert Permission")
//             {
//                 Caption = 'Insert Permission';
//                 Image = FiledPosted;
//                 group("Allow Insertion")
//                 {
//                     Caption = 'Allow Insertion';
//                     Image = Confirm;
//                     action(AllowInsertYes)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Yes';
//                         Image = Approve;

//                         trigger OnAction()
//                         begin
//                             UpdateSelected('I',Rec."insert permission"::Yes);
//                         end;
//                     }
//                     action(AllowInsertNo)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'No';
//                         Image = Reject;

//                         trigger OnAction()
//                         begin
//                             UpdateSelected('I',Rec."insert permission"::" ");
//                         end;
//                     }
//                     action(AllowInsertIndirect)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Indirect';
//                         Image = Indent;

//                         trigger OnAction()
//                         begin
//                             UpdateSelected('I',Rec."insert permission"::Indirect);
//                         end;
//                     }
//                 }
//             }
//             group("Modify Permission")
//             {
//                 Caption = 'Modify Permission';
//                 Image = Statistics;
//                 group("Allow Modification")
//                 {
//                     Caption = 'Allow Modification';
//                     Image = Confirm;
//                     action(AllowModifyYes)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Yes';
//                         Image = Approve;

//                         trigger OnAction()
//                         begin
//                             UpdateSelected('M',Rec."modify permission"::Yes);
//                         end;
//                     }
//                     action(AllowModifyNo)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'No';
//                         Image = Reject;

//                         trigger OnAction()
//                         begin
//                             UpdateSelected('M',Rec."modify permission"::" ");
//                         end;
//                     }
//                     action(AllowModifyIndirect)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Indirect';
//                         Image = Indent;

//                         trigger OnAction()
//                         begin
//                             UpdateSelected('M',Rec."modify permission"::Indirect);
//                         end;
//                     }
//                 }
//             }
//             group("Delete Permission")
//             {
//                 Caption = 'Delete Permission';
//                 Image = Transactions;
//                 group("Allow Deletion")
//                 {
//                     Caption = 'Allow Deletion';
//                     Image = Confirm;
//                     action(AllowDeleteYes)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Yes';
//                         Image = Approve;

//                         trigger OnAction()
//                         begin
//                             UpdateSelected('D',Rec."delete permission"::Yes);
//                         end;
//                     }
//                     action(AllowDeleteNo)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'No';
//                         Image = Reject;

//                         trigger OnAction()
//                         begin
//                             UpdateSelected('D',Rec."delete permission"::" ");
//                         end;
//                     }
//                     action(AllowDeleteIndirect)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Indirect';
//                         Image = Indent;

//                         trigger OnAction()
//                         begin
//                             UpdateSelected('D',Rec."delete permission"::Indirect);
//                         end;
//                     }
//                 }
//             }
//             group("Execute Permission")
//             {
//                 Caption = 'Execute Permission';
//                 Image = Transactions;
//                 group("Allow Execution")
//                 {
//                     Caption = 'Allow Execution';
//                     Image = Confirm;
//                     action(AllowExecuteYes)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Yes';
//                         Image = Approve;

//                         trigger OnAction()
//                         begin
//                             UpdateSelected('X',Rec."execute permission"::Yes);
//                         end;
//                     }
//                     action(AllowExecuteNo)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'No';
//                         Image = Reject;

//                         trigger OnAction()
//                         begin
//                             UpdateSelected('X',Rec."execute permission"::" ");
//                         end;
//                     }
//                     action(AllowExecuteIndirect)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Indirect';
//                         Image = Indent;

//                         trigger OnAction()
//                         begin
//                             UpdateSelected('X',Rec."execute permission"::Indirect);
//                         end;
//                     }
//                 }
//             }
//             group("All Permissions")
//             {
//                 Caption = 'All Permissions';
//                 Image = Transactions;
//                 group("Allow All")
//                 {
//                     Caption = 'Allow All';
//                     Image = Confirm;
//                     action(AllowAllYes)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Yes';
//                         Image = Approve;

//                         trigger OnAction()
//                         begin
//                             UpdateSelected('*',Rec."read permission"::Yes);
//                         end;
//                     }
//                     action(AllowAllNo)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'No';
//                         Image = Reject;

//                         trigger OnAction()
//                         begin
//                             UpdateSelected('*',Rec."read permission"::" ");
//                         end;
//                     }
//                     action(AllowAllIndirect)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Indirect';
//                         Image = Indent;

//                         trigger OnAction()
//                         begin
//                             UpdateSelected('*',Rec."read permission"::Indirect);
//                         end;
//                     }
//                 }
//             }
//             group("Manage Permission Sets")
//             {
//                 Caption = 'Manage Permission Sets';
//                 action(AddRelatedTablesAction)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Add Read Permission to Related Tables';
//                     Image = Relationship;

//                     trigger OnAction()
//                     begin
//                         AddRelatedTablesToSelected;
//                     end;
//                 }
//                 action(IncludeExclude)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Include/Exclude Permission Set';
//                     Image = Edit;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     var
//                         AddSubtractPermissionSet: Report "Add/Subtract Permission Set";
//                     begin
//                         AddSubtractPermissionSet.SetDestination(CurrentRoleID);
//                         AddSubtractPermissionSet.RunModal;
//                         FillTempPermissions;
//                     end;
//                 }
//             }
//             group("Code Coverage Actions")
//             {
//                 Caption = 'Record Permissions';
//                 action(Start)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Start';
//                     Enabled = not CodeCoverageRunning;
//                     Image = Start;

//                     trigger OnAction()
//                     begin
//                         if not Confirm(StartRecordingQst) then
//                           exit;
//                         LogTablePermissions.Init;
//                         BindSubscription(LogTablePermissions);
//                         CodeCoverageMgt.Start(false);
//                         CodeCoverageRunning := true;
//                     end;
//                 }
//                 action(Stop)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Stop';
//                     Enabled = CodeCoverageRunning;
//                     Image = Stop;

//                     trigger OnAction()
//                     begin
//                         UnbindSubscription(LogTablePermissions);
//                         CodeCoverageMgt.Stop;
//                         CodeCoverageRunning := false;
//                         if not Confirm(AddPermissionsQst) then
//                           exit;
//                         AddCodeCoveragePermissions;
//                         AddLoggedPermissions;
//                     end;
//                 }
//             }
//         }
//     }

//     var
//         TableFilter: Record "Table Filter";
//         TableFilterPage: Page "Table Filter";

//     var
//         CodeCoverageMgt: Codeunit "Code Coverage Mgt.";
//         LogTablePermissions: Codeunit "Log Table Permissions";

//     var
//         AddRelatedTables: Boolean;

//     var
//         IsValidatedObjectID: Boolean;

//     var
//         CodeCoverageRunning: Boolean;
//         AddPermissionsQst: label 'Do you want to add the recorded permissions?';
//         StartRecordingQst: label 'The recording partly depends on setup data that is being cached. To clear the cache and thus to record all table updates, you can reopen the company before starting the recorder.\\Do you want to start the recording now?';


//     //Unsupported feature: Code Modification on "OnAfterGetRecord".

//     //trigger OnAfterGetRecord()
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         SetObjectZeroName(Rec);
//         ZeroObjStyleExpr := "Object ID" = 0;
//         IsNewRecord := FALSE;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         SetObjectZeroName(Rec);
//         ZeroObjStyleExpr := "Object ID" = 0;
//         IsValidatedObjectID := FALSE;
//         IsNewRecord := FALSE;
//         */
//     //end;


//     //Unsupported feature: Code Insertion on "OnClosePage".

//     //trigger OnClosePage()
//     //begin
//         /*
//         IF NOT CodeCoverageRunning THEN
//           EXIT;
//         UNBINDSUBSCRIPTION(LogTablePermissions);
//         CodeCoverageMgt.Stop;
//         */
//     //end;


//     //Unsupported feature: Code Insertion on "OnDeleteRecord".

//     //trigger OnDeleteRecord(): Boolean
//     //var
//         //Permission: Record Permission;
//     //begin
//         /*
//         IF (Show = Show::All) AND ("Object ID" <> 0) THEN
//           EXIT(FALSE);
//         Permission := Rec;
//         Permission.FIND;
//         EXIT(Permission.DELETE);
//         */
//     //end;


//     //Unsupported feature: Code Insertion on "OnInsertRecord".

//     //trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     //var
//         //Permission: Record Permission;
//     //begin
//         /*
//         IF ("Object ID" = 0) AND ((Show = Show::All) OR IsValidatedObjectID) THEN
//           EXIT(FALSE);
//         IF ("Execute Permission" = "Execute Permission"::" ") AND
//            ("Read Permission" = "Read Permission"::" ") AND
//            ("Insert Permission" = "Insert Permission"::" ") AND
//            ("Modify Permission" = "Modify Permission"::" ") AND
//            ("Delete Permission" = "Delete Permission"::" ")
//         THEN
//           EXIT(FALSE);

//         IF "Object Type" = "Object Type"::"Table Data" THEN
//           "Execute Permission" := "Execute Permission"::" "
//         ELSE BEGIN
//           "Read Permission" := "Read Permission"::" ";
//           "Insert Permission" := "Insert Permission"::" ";
//           "Modify Permission" := "Modify Permission"::" ";
//           "Delete Permission" := "Delete Permission"::" ";
//         END;
//         Permission := Rec;
//         Permission.INSERT;
//         IF AddRelatedTables THEN
//           DoAddRelatedTables(Rec);
//         Rec := Permission;
//         SetObjectZeroName(Rec);
//         PermissionRecExists := TRUE;
//         IsNewRecord := FALSE;
//         ZeroObjStyleExpr := "Object ID" = 0;
//         EXIT(TRUE);
//         */
//     //end;


//     //Unsupported feature: Code Insertion on "OnModifyRecord".

//     //trigger OnModifyRecord(): Boolean
//     //begin
//         /*
//         ModifyRecord(Rec);
//         PermissionRecExists := TRUE;
//         IsNewRecord := FALSE;
//         EXIT(MODIFY);
//         */
//     //end;


//     //Unsupported feature: Code Insertion on "OnNewRecord".

//     //trigger OnNewRecord(BelowxRec: Boolean)
//     //begin
//         /*
//         ActivateControls;
//         PermissionRecExists := FALSE;
//         IsNewRecord := TRUE;
//         IsValidatedObjectID := FALSE;
//         */
//     //end;


//     //Unsupported feature: Code Modification on "OnOpenPage".

//     //trigger OnOpenPage()
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         PermissionPagesMgt.RaiseNotificationThatSecurityFilterNotEditableForSystemAndExtension;

//         IF CurrentRoleID = '' THEN
//           IF GETFILTER("Role ID") <> '' THEN
//             CurrentRoleID := GETRANGEMIN("Role ID")
//           ELSE
//             IF PermissionSet.FINDFIRST THEN
//               CurrentRoleID := PermissionSet."Role ID";
//         RESET;
//         FillTempPermissions;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         #3..10
//         */
//     //end;


//     //Unsupported feature: Code Modification on "FillTempPermissions(PROCEDURE 1003)".

//     //procedure FillTempPermissions();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         TempPermission.COPY(Rec,TRUE);
//         TempPermission.RESET;
//         TempPermission.DELETEALL;
//         #4..15
//           FillTempPermissionsForAllObjects(TempPermission);
//         IsNewRecord := FALSE;
//         IF FIND('=<>') THEN;
//         CurrPage.UPDATE(FALSE);
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         #1..18
//         */
//     //end;


//     //Unsupported feature: Code Modification on "SetObjectZeroName(PROCEDURE 9)".

//     //procedure SetObjectZeroName();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         IF Permission."Object ID" <> 0 THEN BEGIN
//           Permission.CALCFIELDS("Object Name");
//           ObjectName := Permission."Object Name";
//         END ELSE
//           ObjectName := COPYSTR(STRSUBSTNO(AllObjTxt,Permission."Object Type"),1,MAXSTRLEN(Permission."Object Name"));
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         IF Permission."Object ID" <> 0 THEN
//           EXIT;
//         Permission."Object Name" := COPYSTR(STRSUBSTNO(AllObjTxt,Permission."Object Type"),1,MAXSTRLEN(Permission."Object Name"));
//         */
//     //end;

//     local procedure ModifyRecord(var ModifiedPermission: Record Permission)
//     var
//         Permission: Record Permission;
//         IsNewPermission: Boolean;
//     begin
//         /*
//         Permission.LOCKTABLE;
//         IsNewPermission :=
//           NOT Permission.GET(ModifiedPermission."Role ID",ModifiedPermission."Object Type",ModifiedPermission."Object ID");
//         IF IsNewPermission THEN BEGIN
//           Permission.TRANSFERFIELDS(ModifiedPermission,TRUE);
//           Permission.INSERT;
//         END ELSE BEGIN
//           Permission.TRANSFERFIELDS(ModifiedPermission,FALSE);
//           Permission.MODIFY;
//         END;
        
//         IF (Permission."Read Permission" = 0) AND
//            (Permission."Insert Permission" = 0) AND
//            (Permission."Modify Permission" = 0) AND
//            (Permission."Delete Permission" = 0) AND
//            (Permission."Execute Permission" = 0)
//         THEN BEGIN
//           Permission.DELETE;
//           IF Show = Show::"Only In Permission Set" THEN
//             ModifiedPermission.DELETE;
//           IsNewPermission := FALSE;
//         END;
//         IF IsNewPermission AND AddRelatedTables THEN
//           DoAddRelatedTables(ModifiedPermission);
//           */

//     end;

//     local procedure UpdateSelected(RIMDX: Text[1];PermissionOption: Option)
//     var
//         TempPermission: Record Permission temporary;
//         OrgPermission: Record Permission;
//     begin
//         OrgPermission := Rec;
//         TempPermission.Copy(Rec,true);
//         CurrPage.SetSelectionFilter(TempPermission);

//         if TempPermission.FindSet then
//           repeat
//             case RIMDX of
//               'R':
//                 if TempPermission."Object Type" = Rec."object type"::"Table Data" then
//                   TempPermission."Read Permission" := PermissionOption;
//               'I':
//                 if TempPermission."Object Type" = Rec."object type"::"Table Data" then
//                   TempPermission."Insert Permission" := PermissionOption;
//               'M':
//                 if TempPermission."Object Type" = Rec."object type"::"Table Data" then
//                   TempPermission."Modify Permission" := PermissionOption;
//               'D':
//                 if TempPermission."Object Type" = Rec."object type"::"Table Data" then
//                   TempPermission."Delete Permission" := PermissionOption;
//               'X':
//                 if TempPermission."Object Type" <> Rec."object type"::"Table Data" then
//                   TempPermission."Execute Permission" := PermissionOption;
//               '*':
//                 begin
//                   if TempPermission."Object Type" = Rec."object type"::"Table Data" then begin
//                     TempPermission."Read Permission" := PermissionOption;
//                     TempPermission."Insert Permission" := PermissionOption;
//                     TempPermission."Modify Permission" := PermissionOption;
//                     TempPermission."Delete Permission" := PermissionOption;
//                   end else
//                     TempPermission."Execute Permission" := PermissionOption;
//                 end;
//             end;
//             ModifyRecord(TempPermission);
//             if Rec.Get(TempPermission."Role ID",TempPermission."Object Type",TempPermission."Object ID") then begin
//               Rec := TempPermission;
//               Rec.Modify;
//             end;
//           until TempPermission.Next = 0;

//         Rec := OrgPermission;
//         if Rec.Find then;
//     end;

//     local procedure AddRelatedTablesToSelected()
//     var
//         TempPermission: Record Permission temporary;
//     begin
//         TempPermission.Copy(Rec,true);
//         CurrPage.SetSelectionFilter(TempPermission);
//         if TempPermission.FindSet then
//           repeat
//             DoAddRelatedTables(TempPermission);
//           until TempPermission.Next = 0;
//         if Rec.Find then;
//     end;

//     local procedure AddCodeCoveragePermissions()
//     var
//         CodeCoverage: Record "Code Coverage";
//     begin
//         CodeCoverage.SetRange("Object Type",CodeCoverage."object type"::Table);
//         CodeCoverage.SetRange("Line Type",CodeCoverage."line type"::Object);
//         if CodeCoverage.FindSet then
//           repeat
//             AddTableDataPermission(CurrentRoleID,Rec."object type"::"Table Data",CodeCoverage."Object ID",false,false,false);
//           until CodeCoverage.Next = 0;
//         CodeCoverage.Reset;
//         CodeCoverage.DeleteAll;
//     end;

//     local procedure AddLoggedPermissions()
//     var
//         TablePermissionBuffer: Record "Table Permission Buffer";
//     begin
//         TablePermissionBuffer.SetRange("Session ID",SessionId);
//         if TablePermissionBuffer.FindSet then
//           repeat
//             AddTableDataPermission(
//               CurrentRoleID,Rec."object type"::"Table Data",TablePermissionBuffer."Table ID",
//               TablePermissionBuffer."Insert Permission",
//               TablePermissionBuffer."Modify Permission",
//               TablePermissionBuffer."Delete Permission");
//           until TablePermissionBuffer.Next = 0;
//         TablePermissionBuffer.DeleteAll;
//     end;

//     local procedure DoAddRelatedTables(var Permission: Record Permission)
//     var
//         TableRelationsMetadata: Record "Table Relations Metadata";
//     begin
//         if Permission."Object Type" <> Permission."object type"::"Table Data" then
//           exit;
//         if Permission."Object ID" = 0 then
//           exit;

//         TableRelationsMetadata.SetRange("Table ID",Permission."Object ID");
//         TableRelationsMetadata.SetFilter("Related Table ID",'>0&<>%1',Permission."Object ID");
//         if TableRelationsMetadata.FindSet then
//           repeat
//             AddTableDataPermission(
//               CurrentRoleID,Rec."object type"::"Table Data",TableRelationsMetadata."Related Table ID",false,false,false);
//           until TableRelationsMetadata.Next = 0;
//     end;

//     local procedure AddTableDataPermission(RoleID: Code[20];ObjectType: Option;ObjectID: Integer;AddInsert: Boolean;AddModify: Boolean;AddDelete: Boolean): Boolean
//     var
//         Permission: Record Permission;
//     begin
//         if not Rec.Get(RoleID,ObjectType,ObjectID) then begin
//           Rec.Init;
//           Rec."Role ID" := RoleID;
//           Rec."Object Type" := ObjectType;
//           Rec."Object ID" := ObjectID;
//           Rec."Insert Permission" := Rec."insert permission"::" ";
//           Rec."Modify Permission" := Rec."modify permission"::" ";
//           Rec."Delete Permission" := Rec."delete permission"::" ";
//           Rec."Execute Permission" := Rec."execute permission"::" ";
//           Rec.Insert;
//           Permission.TransferFields(Rec,true);
//           Permission.Insert;
//         end;
//         Rec."Read Permission" := Rec."read permission"::Yes;
//         if AddInsert then
//           Rec."Insert Permission" := Rec."insert permission"::Yes;
//         if AddModify then
//           Rec."Modify Permission" := Rec."modify permission"::Yes;
//         if AddDelete then
//           Rec."Delete Permission" := Rec."delete permission"::Yes;
//         SetObjectZeroName(Rec);
//         Rec.Modify;
//         Permission.LockTable;
//         if not Permission.Get(RoleID,ObjectType,ObjectID) then begin
//           Permission.TransferFields(Rec,true);
//           Permission.Insert;
//         end else begin
//           Permission.TransferFields(Rec,false);
//           Permission.Modify;
//         end;
//         exit(true);
//     end;

//     //Unsupported feature: Property Deletion (Editable).


//     //Unsupported feature: Property Deletion (InsertAllowed).


//     //Unsupported feature: Property Deletion (DeleteAllowed).


//     //Unsupported feature: Property Deletion (ModifyAllowed).

// }
