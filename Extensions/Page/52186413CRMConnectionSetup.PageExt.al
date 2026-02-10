// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52186413 pageextension52186413 extends "CRM Connection Setup" 
// {
//     Caption = 'Microsoft Dynamics CRM Connection Setup';
//     layout
//     {
//         modify(NAVToCRM)
//         {
//             Caption = 'Connection from Dynamics NAV to Dynamics CRM';
//         }
//         modify("Server Address")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("User Name")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Password)
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on "Password(Control 7)".

//         }
//         modify("Is Enabled")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(ScheduledSynchJobsActive)
//         {
//             ApplicationArea = Basic;
//             StyleExpr = ScheduledSynchJobsRunningMsgStyleExpr;
//         }
//         modify(CRMToNAV)
//         {
//             Caption = 'Connection from Dynamics CRM to Dynamics NAV';
//         }
//         modify(NAVURL)
//         {
//             Caption = 'Dynamics NAV Web Client URL';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on "NAVURL(Control 16)".

//             Enabled = CRMSolutionInstalled;
//         }
//         modify(ItemAvailabilityWebServEnabled)
//         {

//             //Unsupported feature: Property Modification (Name) on "ItemAvailabilityWebServEnabled(Control 28)".

//             ApplicationArea = Basic;
//         }
//         modify(CRMSettings)
//         {
//             Caption = 'Dynamics CRM Settings';
//         }
//         modify("CRM Version")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on ""CRM Version"(Control 25)".

//             StyleExpr = CRMSettingVersionStyleExpr;

//             //Unsupported feature: Property Modification (Name) on ""CRM Version"(Control 25)".

//         }
//         modify("Is CRM Solution Installed")
//         {
//             Caption = 'Dynamics NAV Integration Solution Imported';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on ""Is CRM Solution Installed"(Control 15)".


//             //Unsupported feature: Property Modification (Name) on ""Is CRM Solution Installed"(Control 15)".

//         }
//         modify("Is S.Order Integration Enabled")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on ""Is S.Order Integration Enabled"(Control 21)".


//             //Unsupported feature: Property Modification (Name) on ""Is S.Order Integration Enabled"(Control 21)".


//             //Unsupported feature: Property Insertion (DrillDown) on ""Is S.Order Integration Enabled"(Control 21)".

//             Editable = false;
//             StyleExpr = CRMSettingIsSOPEnabledStyleExpr;
//         }
//         modify("Is User Mapping Required")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Is User Mapped To CRM User")
//         {
//             Caption = 'Current Dynamics NAV User is Mapped to a Dynamics CRM User';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on ""Is User Mapped To CRM User"(Control 18)".

//             Editable = false;
//             StyleExpr = CurrentUserIsMappedToCRMUserStyleExpr;

//             //Unsupported feature: Property Modification (Name) on ""Is User Mapped To CRM User"(Control 18)".

//             Enabled = CurrentUserIsMappedToCRMUserIsVisible;
//         }
//         modify(Control30)
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Code Insertion (VariableCollection) on ""Server Address"(Control 2).OnValidate".

//         //trigger (Variable: CRMSetupDefaults)()
//         //Parameters and return type have not been exported.
//         //begin
//             /*
//             */
//         //end;


//         //Unsupported feature: Code Modification on ""Server Address"(Control 2).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             ConnectionString := GetConnectionString;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             IF ("Server Address" = '') OR ("Server Address" = '@@test@@') THEN
//               EXIT;

//             "Server Address" := DELCHR("Server Address",'<>');

//             IF NOT UriHelper.TryCreate("Server Address",UriKindHelper.Absolute,UriHelper2) THEN
//               IF NOT UriHelper.TryCreate('https://' + "Server Address",UriKindHelper.Absolute,UriHelper2) THEN
//                 ERROR(InvalidUriErr);

//             IF UriHelper2.Scheme <> 'https' THEN BEGIN
//               IF NOT CRMSetupDefaults.GetAllowNonSecureConnections THEN
//                 ERROR(MustUseHttpsErr);
//               IF UriHelper2.Scheme <> 'http' THEN
//                 ERROR(STRSUBSTNO(MustUseHttpOrHttpsErr,UriHelper2.Scheme))
//             END;

//             ProposedUri := UriHelper2.GetLeftPart(UriPartialHelper.Authority);

//             IF LOWERCASE("Server Address") <> LOWERCASE(ProposedUri) THEN BEGIN
//               IF CONFIRM(STRSUBSTNO(ReplaceServerAddressQst,"Server Address",ProposedUri)) THEN
//                 "Server Address" := ProposedUri;
//             END;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Server Address"(Control 2)".



//         //Unsupported feature: Code Modification on ""User Name"(Control 3).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             ConnectionString := GetConnectionString;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             "User Name" := DELCHR("User Name",'<>');
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""User Name"(Control 3)".



//         //Unsupported feature: Code Modification on "Password(Control 7).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             IF (CRMPassword <> '') AND (NOT ENCRYPTIONENABLED) THEN
//               IF CONFIRM(EncryptionIsNotActivatedQst) THEN
//                 PAGE.RUNMODAL(PAGE::"Data Encryption Management");
//             SetPassword(CRMPassword);
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             SetPassword(NewPassword);
//             COMMIT;
//             IF (NewPassword <> '') AND (NOT ENCRYPTIONENABLED) THEN
//               IF CONFIRM(EncryptionIsNotActivatedQst) THEN
//                 PAGE.RUN(PAGE::"Data Encryption Management")
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "Password(Control 7)".



//         //Unsupported feature: Code Insertion (VariableCollection) on ""Is Enabled"(Control 11).OnValidate".

//         //trigger (Variable: IntegrationTableMapping)()
//         //Parameters and return type have not been exported.
//         //begin
//             /*
//             */
//         //end;


//         //Unsupported feature: Code Modification on ""Is Enabled"(Control 11).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             CurrPage.UPDATE(TRUE);
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             IsEditable := NOT "Is Enabled";
//             IF ConnectionEnabled AND "Is Enabled" THEN
//               EXIT;

//             IF NOT UnregisterConnection THEN
//               CLEARLASTERROR;

//             IF "Is Enabled" THEN BEGIN
//               // set enabled to false and commit to save all changes before enabling.
//               "Is Enabled" := FALSE;
//               MODIFY(TRUE);
//               COMMIT;
//               "Is Enabled" := TRUE;

//               IF ("Server Address" = '') OR ("User Name" = '') OR (NOT HasPassword) THEN
//                 ERROR(DetailsMissingErr);

//               RegisterConnection;
//               IF NOT TestConnection THEN BEGIN
//                 UnregisterConnection;
//                 ERROR(ConnectionErr,GETLASTERRORTEXT);
//               END;

//               IF "Is User Mapping Required" THEN BEGIN
//                 UnregisterConnection;
//                 RegisterUserConnection;
//               END;

//               // Connection is valid and registered
//               MODIFY(TRUE);
//               COMMIT;

//               IF IntegrationTableMapping.ISEMPTY THEN
//                 IF CONFIRM(CreateIntegrationTableMappingQst,FALSE) THEN
//                   CRMSetupDefaults.ResetConfiguration(TRUE);
//               IF IntegrationRecord.COUNT = 0 THEN
//                 IntegrationManagement.SetupIntegrationTables;
//               IntegrationManagement.SetConnectorIsEnabledForSession(TRUE);

//               // Additional Configuration has been done
//               COMMIT;
//             END ELSE
//               UnregisterConnection;

//             UpdateIsEnabledState;
//             RefreshData;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Is Enabled"(Control 11)".



//         //Unsupported feature: Code Modification on "ScheduledSynchJobsActive(Control 22).OnDrillDown".

//         //trigger OnDrillDown()
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             IF TotalJobs = 0 THEN
//               ScheduledSynchJobsRunningMsg := JobQueueIsNotRunningMsg
//             ELSE
//               IF ActiveJobs = TotalJobs THEN
//                 ScheduledSynchJobsRunningMsg := AllScheduledJobsAreRunningMsg
//               ELSE
//                 ScheduledSynchJobsRunningMsg := STRSUBSTNO(PartialScheduledJobsAreRunningMsg,ActiveJobs,TotalJobs);
//             MESSAGE(ScheduledSynchJobsRunningMsg);
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             MESSAGE(ScheduledSynchJobsRunningMsg);
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "ScheduledSynchJobsActive(Control 22)".

//         modify(SDKVersion)
//         {
//             Visible = false;
//         }


//         //Unsupported feature: Code Insertion on "NAVURL(Control 16)".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //var
//             //CRMIntegrationManagement: Codeunit "CRM Integration Management";
//         //begin
//             /*
//             CRMIntegrationManagement.SetCRMNAVConnectionUrl(NAVURL);
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "NAVURL(Control 16)".

//         modify(ItemAvailabilityWebServEnabled)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (CaptionML) on "ItemAvailabilityWebServEnabled(Control 28)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "ItemAvailabilityWebServEnabled(Control 28)".


//         //Unsupported feature: Property Deletion (SourceExpr) on "ItemAvailabilityWebServEnabled(Control 28)".


//         //Unsupported feature: Property Deletion (Editable) on "ItemAvailabilityWebServEnabled(Control 28)".


//         //Unsupported feature: Property Deletion (StyleExpr) on "ItemAvailabilityWebServEnabled(Control 28)".

//         modify(Control34)
//         {
//             Visible = false;
//         }
//         modify(NAVODataURL)
//         {
//             Visible = false;
//         }
//         modify(NAVODataUsername)
//         {
//             Visible = false;
//         }
//         modify(NAVODataAccesskey)
//         {
//             Visible = false;
//         }


//         //Unsupported feature: Code Modification on ""CRM Version"(Control 25).OnDrillDown".

//         //trigger OnDrillDown()
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             IF IsVersionValid THEN
//               MESSAGE(FavorableCRMVersionMsg,CRMProductName.SHORT)
//             ELSE
//               MESSAGE(UnfavorableCRMVersionMsg,PRODUCTNAME.SHORT,CRMProductName.SHORT);
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             IF CRMSettingVersionStyleExpr = FavorableStyleExprTxt THEN
//               MESSAGE(FavorableCRMVersionMsg)
//             ELSE
//               MESSAGE(UnfavorableCRMVersionMsg);
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""CRM Version"(Control 25)".



//         //Unsupported feature: Code Modification on ""Is CRM Solution Installed"(Control 15).OnDrillDown".

//         //trigger OnDrillDown()
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             IF "Is CRM Solution Installed" THEN
//               MESSAGE(FavorableCRMSolutionInstalledMsg,PRODUCTNAME.SHORT,CRMProductName.SHORT)
//             ELSE
//               MESSAGE(UnfavorableCRMSolutionInstalledMsg,PRODUCTNAME.SHORT);
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             IF CRMSolutionInstalled THEN
//               MESSAGE(FavorableCRMSolutionInstalledMsg)
//             ELSE
//               MESSAGE(UnfavorableCRMSolutionInstalledMsg);
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Is CRM Solution Installed"(Control 15)".



//         //Unsupported feature: Code Insertion on "CRMSettingIsSOPEnabled(Control 21)".

//         //trigger OnDrillDown()
//         //begin
//             /*
//             IF NOT CRMSettingIsSOPEnabled THEN
//               SetCRMSOPEnabled;

//             RefreshDataFromCRM;

//             IF CRMSettingIsSOPEnabled THEN
//               MESSAGE(SetCRMSOPEnableConfirmMsg);
//             */
//         //end;
//         modify("Is S.Order Integration Enabled")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Is S.Order Integration Enabled"(Control 21)".

//         modify("Auto Create Sales Orders")
//         {
//             Visible = false;
//         }
//         modify("Auto Process Sales Quotes")
//         {
//             Visible = false;
//         }


//         //Unsupported feature: Code Modification on ""Is User Mapping Required"(Control 27).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             UpdateIsEnabledState;
//             SetStyleExpr;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             COMMIT;
//             UpdateAllConnectionRegistrations;
//             UpdateIsEnabledState;
//             UpdateUserIsMappedState;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Is User Mapping Required"(Control 27)".



//         //Unsupported feature: Code Modification on ""Is User Mapped To CRM User"(Control 18).OnDrillDown".

//         //trigger OnDrillDown()
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             IF "Is User Mapped To CRM User" THEN
//               MESSAGE(CurrentuserIsMappedToCRMUserMsg,USERID,PRODUCTNAME.SHORT,CRMProductName.SHORT)
//             ELSE
//               MESSAGE(CurrentuserIsNotMappedToCRMUserMsg,USERID,PRODUCTNAME.SHORT,CRMProductName.SHORT);
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             IF CurrentUserIsMappedToCRMUser THEN
//               MESSAGE(CurrentuserIsMappedToCRMUserMsg,USERID)
//             ELSE
//               MESSAGE(CurrentuserIsNotMappedToCRMUserMsg,USERID)
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Is User Mapped To CRM User"(Control 18)".


//         //Unsupported feature: Property Deletion (Visible) on ""Is User Mapped To CRM User"(Control 18)".

//         modify("Use Newest UI")
//         {
//             Visible = false;
//         }
//         modify(AuthTypeDetails)
//         {
//             Visible = false;
//         }
//         modify("Authentication Type")
//         {
//             Visible = false;
//         }
//         modify(Domain)
//         {
//             Visible = false;
//         }
//         modify("Connection String")
//         {
//             Visible = false;
//         }
//         addafter(ItemAvailabilityWebServEnabled)
//         {
//             field(CRMSettingIsConnectionUserIntegrationUser;CRMSettingIsConnectionUserIntegrationUser)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Dynamics CRM Connection User is Integration User';
//                 Editable = false;
//                 StyleExpr = CRMSettingIsConnectionUserIntegrationUserStyleExpr;

//                 trigger OnDrillDown()
//                 begin
//                     if not CRMSettingIsConnectionUserIntegrationUser then
//                       Rec.SetUserAsIntegrationUser;

//                     Rec.RefreshDataFromCRM;

//                     if CRMSettingIsConnectionUserIntegrationUser then
//                       Message(FavorableSetUserNameIsIntegrationMsg)
//                 end;
//             }
//         }
//         moveafter(CRMToNAV;"Is CRM Solution Installed")
//         moveafter(NAVURL;CRMSettings)
//     }
//     actions
//     {
//         modify("Test Connection")
//         {
//             ToolTip = 'Tests the connection to Microsoft Dynamics CRM using the specified settings.';
//             ApplicationArea = Basic;
//         }
//         modify(ResetConfiguration)
//         {
//             ToolTip = 'Resets the integration table mappings and synchronization jobs to the default values for a connection with Microsoft Dynamics CRM. All current mappings are deleted.';
//             ApplicationArea = Basic;
//         }
//         modify(StartInitialSynchAction)
//         {
//             ApplicationArea = Basic;
//             Enabled = IsConnectionEnabledForCurrentUser;
//         }
//         modify("Reset Web Client URL")
//         {
//             ApplicationArea = Basic;
//             Enabled = CRMSolutionInstalled and IsConnectionEnabledForCurrentUser;
//         }
//         modify(SynchronizeNow)
//         {
//             ApplicationArea = Basic;
//             Enabled = IsConnectionEnabledForCurrentUser;
//         }
//         modify("Generate Integration IDs")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Integration Table Mappings")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Synch. Job Queue Entries")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(EncryptionManagement)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Assisted Setup")
//         {
//             Visible = false;
//         }


//         //Unsupported feature: Code Modification on "ResetConfiguration(Action 13).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             IF CONFIRM(ResetIntegrationTableMappingConfirmQst,FALSE,CRMProductName.SHORT) THEN BEGIN
//               CRMSetupDefaults.ResetConfiguration(Rec);
//               MESSAGE(SetupSuccessfulMsg,CRMProductName.SHORT);
//             END;
//             RefreshDataFromCRM;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             IF CONFIRM(ResetIntegrationTableMappingConfirmQst,FALSE) THEN
//               CRMSetupDefaults.ResetConfiguration(TRUE);
//             RefreshDataFromCRM;
//             */
//         //end;
//         modify(CoupleUsers)
//         {
//             Visible = false;
//         }


//         //Unsupported feature: Code Modification on "StartInitialSynchAction(Action 10).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             PAGE.RUN(PAGE::"CRM Full Synch. Review");
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             PerformInitialSynch;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "StartInitialSynchAction(Action 10)".


//         //Unsupported feature: Property Deletion (Promoted) on "StartInitialSynchAction(Action 10)".


//         //Unsupported feature: Property Deletion (PromotedIsBig) on "StartInitialSynchAction(Action 10)".


//         //Unsupported feature: Property Deletion (PromotedCategory) on "StartInitialSynchAction(Action 10)".



//         //Unsupported feature: Code Modification on ""Reset Web Client URL"(Action 17).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             PerformWebClientUrlReset;
//             MESSAGE(WebClientUrlResetMsg,PRODUCTNAME.SHORT);
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             PerformWebClientUrlReset;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Reset Web Client URL"(Action 17)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "SynchronizeNow(Action 23)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Generate Integration IDs"(Action 9)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Integration Table Mappings"(Action 19)".



//         //Unsupported feature: Code Modification on ""Synch. Job Queue Entries"(Action 12).OnAction".

//         //trigger  Job Queue Entries"(Action 12)()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             JobQueueEntry.FILTERGROUP := 2;
//             JobQueueEntry.SETRANGE("Object Type to Run",JobQueueEntry."Object Type to Run"::Codeunit);
//             JobQueueEntry.SETFILTER("Object ID to Run",GetJobQueueEntriesObjectIDToRunFilter);
//             JobQueueEntry.FILTERGROUP := 0;

//             PAGE.RUN(PAGE::"Job Queue Entries",JobQueueEntry);
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             JobQueueEntry.FILTERGROUP := 2;
//             JobQueueEntry.SETRANGE("Object Type to Run",JobQueueEntry."Object Type to Run"::Codeunit);
//             JobQueueEntry.SETFILTER("Object ID to Run",'%1|%2',CODEUNIT::"Integration Synch. Job Runner",CODEUNIT::"CRM Statistics Job");
//             #4..6
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Synch. Job Queue Entries"(Action 12)".

//         modify(SkippedSynchRecords)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "EncryptionManagement(Action 6)".

//     }

//     var
//         CRMSetupDefaults: Codeunit "CRM Setup Defaults";
//         UriHelper: dotnet Uri;
//         UriHelper2: dotnet Uri;
//         UriKindHelper: dotnet UriKind;
//         UriPartialHelper: dotnet UriPartial;
//         ProposedUri: Text[250];

//     var
//         IntegrationTableMapping: Record "Integration Table Mapping";
//         IntegrationRecord: Record "Integration Record";
//         IntegrationManagement: Codeunit "Integration Management";
//         CRMSetupDefaults: Codeunit "CRM Setup Defaults";


//     //Unsupported feature: Property Modification (TextConstString) on "ResetIntegrationTableMappingConfirmQst(Variable 1003)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //ResetIntegrationTableMappingConfirmQst : @@@="%1 = CRM product name";ENU=This will delete all existing integration table mappings and %1 synchronization jobs and install the default integration table mappings and jobs for %1 synchronization.\\Are you sure that you want to continue?;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //ResetIntegrationTableMappingConfirmQst : ENU=This will delete all existing integration table mappings and Dynamics CRM synchronization jobs and install the default integration table mappings and jobs for Dynamics CRM synchronization.\\Are you sure that you want to continue?;
//         //Variable type has not been exported.


//     //Unsupported feature: Property Modification (TextConstString) on "WebClientUrlResetMsg(Variable 1014)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //WebClientUrlResetMsg : @@@=%1 - product name;ENU=The %1 Web Client URL has been reset to the default value.;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //WebClientUrlResetMsg : ENU=The NAV Web Client URL has been reset to its default value.;
//         //Variable type has not been exported.


//     //Unsupported feature: Property Modification (TextConstString) on "UnfavorableCRMVersionMsg(Variable 1033)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //UnfavorableCRMVersionMsg : @@@="%1 - product name, %2 = CRM product name";ENU=This version of %2 might not work correctly with %1. We recommend you upgrade to a supported version.;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //UnfavorableCRMVersionMsg : ENU=This version of Dynamics CRM might not work correctly with Dynamics NAV. We recommend you upgrade to a supported version.;
//         //Variable type has not been exported.


//     //Unsupported feature: Property Modification (TextConstString) on "FavorableCRMVersionMsg(Variable 1034)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //FavorableCRMVersionMsg : @@@="%1 = CRM product name";ENU=The version of %1 is valid.;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //FavorableCRMVersionMsg : ENU=The version of Dynamics CRM is valid.;
//         //Variable type has not been exported.


//     //Unsupported feature: Property Modification (TextConstString) on "UnfavorableCRMSolutionInstalledMsg(Variable 1036)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //UnfavorableCRMSolutionInstalledMsg : @@@=%1 - product name;ENU=The %1 Integration Solution was not detected.;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //UnfavorableCRMSolutionInstalledMsg : ENU=The Dynamics NAV Integration Solution was not detected.;
//         //Variable type has not been exported.


//     //Unsupported feature: Property Modification (TextConstString) on "FavorableCRMSolutionInstalledMsg(Variable 1037)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //FavorableCRMSolutionInstalledMsg : @@@="%1 - product name, %2 = CRM product name";ENU=The %1 Integration Solution is installed in %2.;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //FavorableCRMSolutionInstalledMsg : ENU=The Dynamics NAV Integration Solution is installed in Dynamics CRM.;
//         //Variable type has not been exported.


//     //Unsupported feature: Property Modification (TextConstString) on "SynchronizeModifiedQst(Variable 1038)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //SynchronizeModifiedQst : ENU=This will synchronize all modified records in all Integration Table Mappings.\\Do you want to continue?;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //SynchronizeModifiedQst : ENU=This will syncrhronize all modified records in all Integration Table Mappings.\\Do you want to continue?;
//         //Variable type has not been exported.


//     //Unsupported feature: Property Modification (Id) on "ScheduledSynchJobsRunning(Variable 1002)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //ScheduledSynchJobsRunning : 1002;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //ScheduledSynchJobsRunning : 1051;
//         //Variable type has not been exported.


//     //Unsupported feature: Property Modification (TextConstString) on "CurrentuserIsMappedToCRMUserMsg(Variable 1053)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //CurrentuserIsMappedToCRMUserMsg : @@@="%1 = Current User ID, %2 - product name, %3 = CRM product name";ENU=%2 user (%1) is mapped to a %3 user.;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //CurrentuserIsMappedToCRMUserMsg : @@@="%1 = Current User ID";ENU=Dynamics NAV user (%1) is mapped to a Dynamics CRM user.;
//         //Variable type has not been exported.


//     //Unsupported feature: Property Modification (TextConstString) on "CurrentuserIsNotMappedToCRMUserMsg(Variable 1054)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //CurrentuserIsNotMappedToCRMUserMsg : @@@="%1 = Current User ID, %2 - product name, %3 = CRM product name";ENU=Because the %2 Users Must Map to %3 Users field is set, %3 integration is not enabled for %1.\\To enable %3 integration for %2 user %1, the authentication email must match the primary email of a %3 user.;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //CurrentuserIsNotMappedToCRMUserMsg : @@@="%1 = Current User ID";ENU=Because the Dynamics NAV Users Must Map to Dynamics CRM Users field is set, Dynamics CRM integration is not enabled for %1.\\To enable Dynamics CRM integration for Dynamics NAV user %1, the authentication e-mail must match the primary e-mail of a Dynamics CRM user.;
//         //Variable type has not been exported.


//     //Unsupported feature: Property Modification (TextConstString) on "PartialScheduledJobsAreRunningMsg(Variable 1046)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //PartialScheduledJobsAreRunningMsg : @@@="%1 = Count of scheduled job queue entries in ready or in process state, %2 count of all scheduled jobs";ENU=An active job queue is available but only %1 of the %2 scheduled synchronization jobs are ready or in process.;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //PartialScheduledJobsAreRunningMsg : @@@="%1 = Count of scheduled job queue entries in ready or in process state, %2 count of all scheduled jobs";ENU=An ative job queue is available but only %1 of the %2 scheduled synchronization jobs are ready or in process.;
//         //Variable type has not been exported.


//     //Unsupported feature: Property Modification (Id) on "CRMSolutionInstalledStyleExpr(Variable 1012)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //CRMSolutionInstalledStyleExpr : 1012;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //CRMSolutionInstalledStyleExpr : 1035;
//         //Variable type has not been exported.


//     //Unsupported feature: Property Modification (Id) on "IsEditable(Variable 1008)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //IsEditable : 1008;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //IsEditable : 1009;
//         //Variable type has not been exported.

//     var
//         NAVURL: Text[250];
//         NewPassword: Text;
//         ConnectionSuccessMsg: label 'The connection test was successful. The settings are valid.';
//         ConnectionSuccessNotEnabledForCurrentUserMsg: label 'The connection test was successful. The settings are valid.\\However, because the Dynamics NAV Users Must Map to Dynamics CRM Users field is set, Dynamics CRM integration is not enabled for %1.', Comment='%1 = Current User ID';
//         ConnectionErr: label 'The connection setup cannot be validated. Verify the settings and try again.\Detailed error description: %1.', Comment='%1 Error message from the provider (.NET exception message)';
//         DetailsMissingErr: label 'A Dynamics CRM URL, user name and password are required to enable a connection.';

//     var
//         CreateIntegrationTableMappingQst: label 'Synchronization between Microsoft Dynamics CRM and Microsoft Dynamics NAV is currently not set up. Synchronization ensures that common data in Dynamics CRM and Dynamics NAV is the same. Do you want to use the default synchronization setup?';

//     var
//         ConnectionEnabled: Boolean;

//     var
//         InvalidUriErr: label 'The value entered is not a valid URL.';
//         MustUseHttpsErr: label 'The application is set up to support secure connections (HTTPS) to Dynamics CRM only. You cannot use HTTP.';
//         MustUseHttpOrHttpsErr: label '%1 is not a valid URI scheme for Dynamics CRM connections. You can only use HTTPS or HTTP as the scheme in the URL.', Comment='%1 is a URI scheme, such as FTP, HTTP, chrome or file';
//         ReplaceServerAddressQst: label 'The URL you entered cannot be used as is. Do you want to replace it by the suggested version below?\\Entered URL: "%1".\Suggested URL: "%2".', Comment='%1 and %2 are URLs';

//     var
//         CurrentUserIsMappedToCRMUser: Boolean;
//         CurrentUserIsMappedToCRMUserIsVisible: Boolean;
//         CRMSolutionInstalled: Boolean;

//     var
//         IsConnectionEnabledForCurrentUser: Boolean;
//         CRMSettingIsSOPEnabled: Boolean;
//         CRMSettingIsConnectionUserIntegrationUser: Boolean;
//         CurrentUserIsMappedToCRMUserStyleExpr: Text;
//         CRMSettingVersion: Text;
//         SetCRMSOPEnableQst: label 'Enabling Sales Order Integration will allow you to create Dynamics NAV Sales Orders from Dynamics CRM.\\To enable this setting, you must provide Dynamics CRM administrator credentials (user name and password).\\Do you want to continue?';
//         SetCRMSOPEnableConfirmMsg: label 'Dynamics CRM Sales Order Integration is enabled.';
//         SetUserNameIsIntegrationUserQst: label 'If you set the Dynamics CRM Connection User to be an Integration User it will affect how the account can be used.\\To enable this setting, you must provide Dynamics CRM administrator credentials (user name and password).\\Do you want to continue?';
//         FavorableSetUserNameIsIntegrationMsg: label 'The Dynamics CRM Connection User has been set as an Integration User.';
//         StartInitialSynchQst: label 'This will synchronize records in all Integration Table Mappings including uncoupled records.\\Before running full synchronization, you should couple all Dynamics NAV Salespeople to Dynamics CRM Users.\\To prevent data duplication, it is also recommended to couple and synchronize other existing records in advance.\\Do you want to continue?';
//         CRMSettingVersionStyleExpr: Text;
//         CRMSettingIsSOPEnabledStyleExpr: Text;
//         CRMSettingIsConnectionUserIntegrationUserStyleExpr: Text;
//         AllowNewUncoupledItemsToBeSynchronizedQst: label 'Full Synchronization completed.\See the %1 window for details.\\Do you want to allow all scheduled synchronization jobs to create new records?', Comment='%1 = Page 5338 Caption';

//     var
//         FavorableStyleExprTxt: label 'Favorable', Comment='{Locked} Style Expression';
//         UnFavorableStyleExprTxt: label 'Unfavorable', Comment='{Locked} Style Expression';
//         AmbiguousStyleExprTxt: label 'Ambiguous', Comment='{Locked} Style Expression';
//         ProcessDialogMapTitleMsg: label 'Synchronizing @1', Comment='@1 Progress dialog map no.';

//     var
//         ScheduledSynchJobsRunningMsg: Text;

//     var
//         ScheduledSynchJobsRunningMsgStyleExpr: Text;


//     //Unsupported feature: Code Insertion on "OnAfterGetCurrRecord".

//     //trigger OnAfterGetCurrRecord()
//     //begin
//         /*
//         IsEditable := NOT "Is Enabled";
//         */
//     //end;


//     //Unsupported feature: Code Modification on "OnAfterGetRecord".

//     //trigger OnAfterGetRecord()
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         IF HasPassword THEN
//           CRMPassword := '*';
//         RefreshData;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         IF HasPassword THEN
//           NewPassword := 'Password Dots';
//         */
//     //end;


//     //Unsupported feature: Code Insertion on "OnClosePage".

//     //trigger OnClosePage()
//     //var
//         //CRMIntegrationManagement: Codeunit "CRM Integration Management";
//     //begin
//         /*
//         CRMIntegrationManagement.Clear;
//         */
//     //end;


//     //Unsupported feature: Code Modification on "OnOpenPage".

//     //trigger OnOpenPage()
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         IF NOT GET THEN BEGIN
//           INIT;
//           InitializeDefaultProxyVersion;
//           INSERT;
//         END ELSE BEGIN
//           ConnectionString := GetConnectionString;
//           UnregisterConnection;
//           IF "Proxy Version" = 0 THEN BEGIN
//             InitializeDefaultProxyVersion;
//             MODIFY;
//           END;
//           IF "Is Enabled" THEN
//             RegisterUserConnection
//           ELSE
//             IF "Disable Reason" <> '' THEN
//               CRMIntegrationManagement.SendConnectionDisabledNotification("Disable Reason");
//         END;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         IF NOT GET THEN BEGIN
//           INIT;
//           INSERT;
//         END;

//         UpdateIsEnabledState;
//         IF NOT ConnectionEnabled THEN
//           EXIT;

//         RefreshData;
//         */
//     //end;


//     //Unsupported feature: Code Modification on "RefreshData(PROCEDURE 19)".

//     //procedure RefreshData();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         UpdateIsEnabledState;
//         SetIsConnectionStringEditable;
//         RefreshDataFromCRM;
//         SetAutoCreateSalesOrdersEditable;
//         RefreshSynchJobsData;
//         UpdateEnableFlags;
//         IF NOT WebServiceEnabled THEN
//           CLEAR("Dynamics NAV OData URL");
//         SetStyleExpr;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         RefreshDataFromCRM;
//         RefreshDataFromNAV;
//         */
//     //end;

//     //Unsupported feature: Variable Insertion (Variable: JobQueue) (VariableCollection) on "RefreshDataFromNAV(PROCEDURE 20)".


//     //Unsupported feature: Variable Insertion (Variable: JobQueueEntry) (VariableCollection) on "RefreshDataFromNAV(PROCEDURE 20)".


//     //Unsupported feature: Variable Insertion (Variable: TotalJobEntryCount) (VariableCollection) on "RefreshDataFromNAV(PROCEDURE 20)".


//     //Unsupported feature: Property Modification (Name) on "RefreshSynchJobsData(PROCEDURE 20)".



//     //Unsupported feature: Code Modification on "RefreshSynchJobsData(PROCEDURE 20)".

//     //procedure RefreshSynchJobsData();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         CountCRMJobQueueEntries(ActiveJobs,TotalJobs);
//         ScheduledSynchJobsRunning := STRSUBSTNO(ReadyScheduledSynchJobsTok,ActiveJobs,TotalJobs);
//         ScheduledSynchJobsRunningStyleExpr := GetRunningJobsStyleExpr;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         IF NOT "Is Enabled" THEN BEGIN
//           ScheduledSynchJobsRunning := STRSUBSTNO(ReadyScheduledSynchJobsTok,0,0);
//           ScheduledSynchJobsRunningMsg := JobQueueIsNotRunningMsg;
//           ScheduledSynchJobsRunningMsgStyleExpr := UnFavorableStyleExprTxt;
//           EXIT;
//         END;

//         CurrentUserIsMappedToCRMUserIsVisible := "Is User Mapping Required";

//         IF CRMSolutionInstalled THEN
//           JobQueueEntry.SETFILTER("Object ID to Run",'%1|%2',CODEUNIT::"Integration Synch. Job Runner",CODEUNIT::"CRM Statistics Job")
//         ELSE
//           JobQueueEntry.SETRANGE("Object ID to Run",CODEUNIT::"Integration Synch. Job Runner");
//         TotalJobEntryCount := JobQueueEntry.COUNT;
//         JobQueueEntry.SETFILTER(Status,'%1|%2',JobQueueEntry.Status::Ready,JobQueueEntry.Status::"In Process");

//         JobQueue.SETRANGE(Started,TRUE);

//         IF JobQueue.COUNT = 0 THEN BEGIN
//           ScheduledSynchJobsRunning := STRSUBSTNO(ReadyScheduledSynchJobsTok,0,TotalJobEntryCount);
//           ScheduledSynchJobsRunningMsg := JobQueueIsNotRunningMsg;
//           ScheduledSynchJobsRunningMsgStyleExpr := UnFavorableStyleExprTxt;
//         END ELSE BEGIN
//           ScheduledSynchJobsRunning := STRSUBSTNO(ReadyScheduledSynchJobsTok,JobQueueEntry.COUNT,TotalJobEntryCount);
//           IF (JobQueueEntry.COUNT = 0) OR (JobQueueEntry.COUNT < TotalJobEntryCount) THEN BEGIN
//             ScheduledSynchJobsRunningMsg := STRSUBSTNO(PartialScheduledJobsAreRunningMsg,JobQueueEntry.COUNT,TotalJobEntryCount);
//             ScheduledSynchJobsRunningMsgStyleExpr := AmbiguousStyleExprTxt;
//           END ELSE BEGIN
//             ScheduledSynchJobsRunningMsg := AllScheduledJobsAreRunningMsg;
//             ScheduledSynchJobsRunningMsgStyleExpr := FavorableStyleExprTxt;
//           END;
//         END;
//         */
//     //end;

//     //Unsupported feature: Variable Insertion (Variable: TempCRMConnectionSetup) (VariableCollection) on "PerformTestConnection(PROCEDURE 9)".


//     //Unsupported feature: Variable Insertion (Variable: CRMIntegrationManagement) (VariableCollection) on "PerformTestConnection(PROCEDURE 9)".


//     //Unsupported feature: Variable Insertion (Variable: ErrorObject) (VariableCollection) on "PerformTestConnection(PROCEDURE 9)".


//     //Unsupported feature: Variable Insertion (Variable: ConnectionName) (VariableCollection) on "PerformTestConnection(PROCEDURE 9)".


//     //Unsupported feature: Property Modification (Name) on "SetStyleExpr(PROCEDURE 9)".



//     //Unsupported feature: Code Modification on "SetStyleExpr(PROCEDURE 9)".

//     //procedure SetStyleExpr();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         CRMSolutionInstalledStyleExpr := GetStyleExpr("Is CRM Solution Installed");
//         CRMVersionStyleExpr := GetStyleExpr(IsVersionValid);
//         UserMappedToCRMUserStyleExpr := GetStyleExpr("Is User Mapped To CRM User");
//         WebServiceEnabledStyleExpr := GetStyleExpr(WebServiceEnabled);
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         IF ("User Name" = '') OR (NewPassword = '') OR ("Server Address" = '') THEN
//           ERROR(DetailsMissingErr);

//         CreateTempNoDelegateConnection(TempCRMConnectionSetup);
//         ConnectionName := FORMAT(CREATEGUID);
//         TempCRMConnectionSetup.RegisterConnectionWithName(ConnectionName);
//         SETDEFAULTTABLECONNECTION(TABLECONNECTIONTYPE::CRM,ConnectionName,TRUE);
//         CRMIntegrationManagement.Clear;

//         IF NOT TestConnection THEN BEGIN
//           TempCRMConnectionSetup.UnregisterConnection;
//           ErrorObject := GETLASTERROROBJECT;
//           IF STRPOS(ErrorObject.GetType.Name,'NavCrmException') > 0 THEN
//             IF NOT ISNULL(ErrorObject.InnerException) THEN
//               ERROR(ConnectionErr,ErrorObject.InnerException.Message);
//           ERROR(ConnectionErr,GETLASTERRORTEXT);
//         END;

//         IF "Is User Mapping Required" THEN
//           IF NOT IsCurrentUserMappedToCrmSystemUser THEN BEGIN
//             MESSAGE(ConnectionSuccessNotEnabledForCurrentUserMsg,USERID);
//             EXIT;
//           END;

//         TempCRMConnectionSetup.UnregisterConnectionWithName(ConnectionName);
//         MESSAGE(ConnectionSuccessMsg);
//         */
//     //end;

//     //Unsupported feature: Variable Insertion (Variable: CRMOrganization) (VariableCollection) on "SetCRMSOPEnabled(PROCEDURE 4)".


//     //Unsupported feature: Variable Insertion (Variable: TempCRMConnectionSetup) (VariableCollection) on "SetCRMSOPEnabled(PROCEDURE 4)".


//     //Unsupported feature: Variable Insertion (Variable: ConnectionName) (VariableCollection) on "SetCRMSOPEnabled(PROCEDURE 4)".


//     //Unsupported feature: Property Modification (Name) on "SetIsConnectionStringEditable(PROCEDURE 4)".



//     //Unsupported feature: Code Modification on "SetIsConnectionStringEditable(PROCEDURE 4)".

//     //procedure SetIsConnectionStringEditable();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         IsConnectionStringEditable :=
//           NOT "Is Enabled";
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         IF NOT CONFIRM(SetCRMSOPEnableQst) THEN
//           EXIT;

//         CreateTempAdminConnection(TempCRMConnectionSetup);
//         ConnectionName := FORMAT(CREATEGUID);
//         TempCRMConnectionSetup.RegisterConnectionWithName(ConnectionName);
//         SETDEFAULTTABLECONNECTION(TABLECONNECTIONTYPE::CRM,ConnectionName,TRUE);

//         CRMOrganization.FINDFIRST;
//         IF NOT CRMOrganization.IsSOPIntegrationEnabled THEN BEGIN
//           CRMOrganization.IsSOPIntegrationEnabled := TRUE;
//           CRMOrganization.MODIFY(TRUE);
//         END;

//         TempCRMConnectionSetup.UnregisterConnectionWithName(ConnectionName);
//         */
//     //end;

//     //Unsupported feature: Variable Insertion (Variable: CRMSystemuser) (VariableCollection) on "SetUserAsIntegrationUser(PROCEDURE 2)".


//     //Unsupported feature: Variable Insertion (Variable: TempCRMConnectionSetup) (VariableCollection) on "SetUserAsIntegrationUser(PROCEDURE 2)".


//     //Unsupported feature: Variable Insertion (Variable: ConnectionName) (VariableCollection) on "SetUserAsIntegrationUser(PROCEDURE 2)".


//     //Unsupported feature: Property Modification (Name) on "SetAutoCreateSalesOrdersEditable(PROCEDURE 2)".



//     //Unsupported feature: Code Modification on "SetAutoCreateSalesOrdersEditable(PROCEDURE 2)".

//     //procedure SetAutoCreateSalesOrdersEditable();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         IsAutoCreateSalesOrdersEditable := "Is S.Order Integration Enabled";
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         IF NOT CONFIRM(SetUserNameIsIntegrationUserQst) THEN
//           EXIT;

//         CreateTempAdminConnection(TempCRMConnectionSetup);
//         ConnectionName := FORMAT(CREATEGUID);
//         TempCRMConnectionSetup.RegisterConnectionWithName(ConnectionName);
//         SETDEFAULTTABLECONNECTION(TABLECONNECTIONTYPE::CRM,ConnectionName,TRUE);

//         CRMSystemuser.SETRANGE(InternalEMailAddress,"User Name");
//         CRMSystemuser.FINDFIRST;

//         IF (CRMSystemuser.InviteStatusCode <> CRMSystemuser.InviteStatusCode::InvitationAccepted) OR
//            (NOT CRMSystemuser.IsIntegrationUser)
//         THEN BEGIN
//           CRMSystemuser.InviteStatusCode := CRMSystemuser.InviteStatusCode::InvitationAccepted;
//           CRMSystemuser.IsIntegrationUser := TRUE;
//           CRMSystemuser.MODIFY(TRUE);
//         END;

//         TempCRMConnectionSetup.UnregisterConnectionWithName(ConnectionName);
//         */
//     //end;

//     //Unsupported feature: Variable Insertion (Variable: CRMNAVConnection) (VariableCollection) on "RefreshFromCRMConnectionInformation(PROCEDURE 1)".


//     //Unsupported feature: Variable Insertion (Variable: CRMIntegrationManagement) (VariableCollection) on "RefreshFromCRMConnectionInformation(PROCEDURE 1)".


//     //Unsupported feature: Property Modification (Name) on "GetRunningJobsStyleExpr(PROCEDURE 1)".



//     //Unsupported feature: Code Modification on "GetRunningJobsStyleExpr(PROCEDURE 1)".

//     //procedure GetRunningJobsStyleExpr();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         IF ActiveJobs < TotalJobs THEN
//           StyleExpr := 'Ambiguous'
//         ELSE
//           StyleExpr := GetStyleExpr((ActiveJobs = TotalJobs) AND (TotalJobs <> 0))
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         CRMSolutionInstalled := CRMIntegrationManagement.IsCRMSolutionInstalled;

//         IF CRMSolutionInstalled THEN BEGIN
//           CRMSolutionInstalledStyleExpr := FavorableStyleExprTxt;
//           IF CRMNAVConnection.FINDFIRST THEN
//             NAVURL := CRMNAVConnection."Dynamics NAV URL";
//         END ELSE
//           CRMSolutionInstalledStyleExpr := UnFavorableStyleExprTxt;
//         */
//     //end;

//     //Unsupported feature: Property Modification (Name) on "GetStyleExpr(PROCEDURE 6)".



//     //Unsupported feature: Code Modification on "GetStyleExpr(PROCEDURE 6)".

//     //procedure GetStyleExpr();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         IF Favorable THEN
//           StyleExpr := 'Favorable'
//         ELSE
//           StyleExpr := 'Unfavorable'
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         CurrentUserIsMappedToCRMUserIsVisible := "Is User Mapping Required";

//         CurrentUserIsMappedToCRMUser := IsCurrentUserMappedToCrmSystemUser;
//         IF CurrentUserIsMappedToCRMUser THEN
//           CurrentUserIsMappedToCRMUserStyleExpr := FavorableStyleExprTxt
//         ELSE
//           CurrentUserIsMappedToCRMUserStyleExpr := UnFavorableStyleExprTxt;
//         */
//     //end;

//     //Unsupported feature: Property Modification (Name) on "UpdateEnableFlags(PROCEDURE 3)".



//     //Unsupported feature: Code Modification on "UpdateEnableFlags(PROCEDURE 3)".

//     //procedure UpdateEnableFlags();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         IsEditable := NOT "Is Enabled";
//         IsWebCliResetEnabled := "Is CRM Solution Installed" AND "Is Enabled For User";
//         WebServiceEnabled := CRMIntegrationManagement.IsItemAvailabilityWebServiceEnabled;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         ConnectionEnabled := "Is Enabled";
//         IF NOT ConnectionEnabled THEN
//           IsConnectionEnabledForCurrentUser := FALSE
//         ELSE
//           IsConnectionEnabledForCurrentUser :=
//             ConnectionEnabled AND
//             ((NOT "Is User Mapping Required") OR ("Is User Mapping Required" AND IsCurrentUserMappedToCrmSystemUser));

//         UpdateUserIsMappedState;
//         */
//     //end;

//     //Unsupported feature: Parameter Insertion (Parameter: CRMConnectionSetup) (ParameterCollection) on "CreateTempAdminConnection(PROCEDURE 5)".


//     //Unsupported feature: Property Modification (Name) on "InitializeDefaultProxyVersion(PROCEDURE 5)".



//     //Unsupported feature: Code Modification on "InitializeDefaultProxyVersion(PROCEDURE 5)".

//     //procedure InitializeDefaultProxyVersion();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         VALIDATE("Proxy Version",CRMIntegrationManagement.GetLastProxyVersionItem);
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         CreateTempNoDelegateConnection(CRMConnectionSetup);
//         CRMConnectionSetup."Primary Key" := COPYSTR('TEMP' + "Primary Key",1,MAXSTRLEN(CRMConnectionSetup."Primary Key"));
//         CRMConnectionSetup."User Name" := '';
//         CLEAR(CRMConnectionSetup."User Password Key");
//         */
//     //end;

//     local procedure RefreshDataFromCRM()
//     var
//         TempCRMConnectionSetup: Record "CRM Connection Setup" temporary;
//         ConnectionName: Text;
//     begin
//         if not Rec."Is Enabled" then begin
//           CRMSettingVersion := '';
//           CRMSettingVersionStyleExpr := UnFavorableStyleExprTxt;

//           CRMSettingIsConnectionUserIntegrationUser := false;
//           CRMSettingIsConnectionUserIntegrationUserStyleExpr := UnFavorableStyleExprTxt;

//           CRMSettingIsSOPEnabled := false;
//           CRMSettingVersionStyleExpr := UnFavorableStyleExprTxt;

//           CRMSolutionInstalled := false;
//           CRMSolutionInstalledStyleExpr := UnFavorableStyleExprTxt;

//           CurrentUserIsMappedToCRMUser := false;
//           CurrentUserIsMappedToCRMUserStyleExpr := UnFavorableStyleExprTxt;

//           exit;
//         end;

//         if Rec."Is User Mapping Required" then begin
//           ConnectionName := Format(CreateGuid);
//           CreateTempNoDelegateConnection(TempCRMConnectionSetup);
//           TempCRMConnectionSetup.RegisterConnectionWithName(ConnectionName);
//           SetDefaultTableConnection(Tableconnectiontype::CRM,ConnectionName,true);

//           UpdateUserIsMappedState
//         end;

//         RefreshFromCRMConnectionInformation;
//         if TryRefreshCRMSettings then;

//         if ConnectionName <> '' then
//           TempCRMConnectionSetup.UnregisterConnectionWithName(ConnectionName);
//     end;

//     [TryFunction]
//     local procedure TryRefreshCRMSettings()
//     var
//         CRMSystemuser: Record "CRM Systemuser";
//         CRMOrganization: Record "CRM Organization";
//         Version: dotnet Version;
//     begin
//         GetCrmVersion(CRMSettingVersion);
//         CRMSettingVersionStyleExpr := UnFavorableStyleExprTxt;
//         if CRMSettingVersion <> '' then begin
//           if Version.TryParse(CRMSettingVersion,Version) then
//             if (Version.Major > 6) and not ((Version.Major = 7) and (Version.Minor = 1)) then
//               CRMSettingVersionStyleExpr := FavorableStyleExprTxt;
//         end;
//         CRMSystemuser.SetRange(InternalEMailAddress,Rec."User Name");
//         if CRMSystemuser.FindFirst then
//           CRMSettingIsConnectionUserIntegrationUser := CRMSystemuser.IsIntegrationUser
//         else
//           CRMSettingIsConnectionUserIntegrationUser := false;

//         if CRMSettingIsConnectionUserIntegrationUser then
//           CRMSettingIsConnectionUserIntegrationUserStyleExpr := FavorableStyleExprTxt
//         else
//           CRMSettingIsConnectionUserIntegrationUserStyleExpr := UnFavorableStyleExprTxt;

//         if CRMOrganization.FindFirst then
//           CRMSettingIsSOPEnabled := CRMOrganization.IsSOPIntegrationEnabled
//         else
//           CRMSettingIsSOPEnabled := false;

//         if CRMSettingIsSOPEnabled then
//           CRMSettingIsSOPEnabledStyleExpr := FavorableStyleExprTxt
//         else
//           CRMSettingIsSOPEnabledStyleExpr := UnFavorableStyleExprTxt;
//     end;

//     local procedure PerformInitialSynch()
//     var
//         JobQueueEntry: Record "Job Queue Entry";
//         IntegrationTableMapping: Record "Integration Table Mapping";
//         TempActiveQueuesNameValueBuffer: Record "Name/Value Buffer" temporary;
//         TempCoupledOnlyMappingsNameValueBuffer: Record "Name/Value Buffer" temporary;
//         IntegrationSynchJobList: Page "Integration Synch. Job List";
//     begin
//         if not Confirm(StartInitialSynchQst) then
//           exit;

//         JobQueueEntry.SetRange("Object ID to Run",Codeunit::"Integration Synch. Job Runner");
//         JobQueueEntry.SetRange(Status,JobQueueEntry.Status::Ready);
//         if JobQueueEntry.FindSet then
//           repeat
//             TempActiveQueuesNameValueBuffer.AddNewEntry(JobQueueEntry.ID,'');
//           until JobQueueEntry.Next = 0;
//         JobQueueEntry.ModifyAll(Status,JobQueueEntry.Status::"On Hold",true);

//         IntegrationTableMapping.SetRange("Parent Name",'''''');
//         IntegrationTableMapping.SetRange("Synch. Only Coupled Records",true);
//         if IntegrationTableMapping.FindSet then
//           repeat
//             TempCoupledOnlyMappingsNameValueBuffer.AddNewEntry(IntegrationTableMapping.Name,'');
//           until IntegrationTableMapping.Next = 0;
//         IntegrationTableMapping.ModifyAll("Synch. Only Coupled Records",false,true);

//         Rec.SynchronizeNow(true);

//         if not Confirm(StrSubstNo(AllowNewUncoupledItemsToBeSynchronizedQst,IntegrationSynchJobList.Caption)) then
//           if TempCoupledOnlyMappingsNameValueBuffer.FindSet then
//             repeat
//               IntegrationTableMapping.Get(TempCoupledOnlyMappingsNameValueBuffer.Name);
//               IntegrationTableMapping."Synch. Only Coupled Records" := true;
//               IntegrationTableMapping.Modify(true);
//             until TempCoupledOnlyMappingsNameValueBuffer.Next = 0;

//         if TempActiveQueuesNameValueBuffer.FindSet then
//           repeat
//             JobQueueEntry.Get(TempActiveQueuesNameValueBuffer.Name);
//             JobQueueEntry.SetStatus(JobQueueEntry.Status::Ready);
//           until TempActiveQueuesNameValueBuffer.Next = 0;
//     end;

//     local procedure SynchronizeNow(DoFullSynch: Boolean)
//     var
//         IntegrationTableMapping: Record "Integration Table Mapping";
//         TempNameValueBuffer: Record "Name/Value Buffer" temporary;
//         CRMSetupDefaults: Codeunit "CRM Setup Defaults";
//         ProgressWindow: Dialog;
//         MappingCount: Integer;
//         CurrentMappingIndex: Integer;
//     begin
//         CRMSetupDefaults.GetPrioritizedMappingList(TempNameValueBuffer);
//         TempNameValueBuffer.Ascending(true);
//         TempNameValueBuffer.FindSet;

//         CurrentMappingIndex := 0;
//         MappingCount := TempNameValueBuffer.Count;
//         ProgressWindow.Open(ProcessDialogMapTitleMsg,CurrentMappingIndex);
//         repeat
//           CurrentMappingIndex := CurrentMappingIndex + 1;
//           ProgressWindow.Update(1,ROUND(CurrentMappingIndex / MappingCount * 10000,1));
//           if IntegrationTableMapping.Get(TempNameValueBuffer.Value) then
//             IntegrationTableMapping.SynchronizeNow(DoFullSynch);
//         until TempNameValueBuffer.Next = 0;
//     end;

//     local procedure PerformWebClientUrlReset()
//     var
//         TempCRMConnectionSetup: Record "CRM Connection Setup" temporary;
//         CRMSetupDefaults: Codeunit "CRM Setup Defaults";
//         ConnectionName: Text;
//     begin
//         CreateTempNoDelegateConnection(TempCRMConnectionSetup);
//         ConnectionName := Format(CreateGuid);
//         TempCRMConnectionSetup.RegisterConnectionWithName(ConnectionName);
//         SetDefaultTableConnection(Tableconnectiontype::CRM,ConnectionName,true);

//         CRMSetupDefaults.ResetCRMNAVConnectionUrl;

//         TempCRMConnectionSetup.UnregisterConnectionWithName(ConnectionName);

//         Rec.RefreshDataFromCRM;
//         Message(WebClientUrlResetMsg);
//     end;

//     local procedure CreateTempNoDelegateConnection(var CRMConnectionSetup: Record "CRM Connection Setup")
//     begin
//         CRMConnectionSetup.Init;
//         CRMConnectionSetup.TransferFields(Rec);
//         CRMConnectionSetup."Primary Key" := CopyStr('TEMP' + Rec."Primary Key",1,MaxStrLen(CRMConnectionSetup."Primary Key"));
//         CRMConnectionSetup."Is Enabled" := true;
//         CRMConnectionSetup."Is User Mapping Required" := false;
//     end;

//     //Unsupported feature: Deletion (ReturnValueCollection) on "GetRunningJobsStyleExpr(PROCEDURE 1).StyleExpr(ReturnValue)".


//     //Unsupported feature: Deletion (ParameterCollection) on "GetStyleExpr(PROCEDURE 6).Favorable(Parameter 1000)".


//     //Unsupported feature: Deletion (ReturnValueCollection) on "GetStyleExpr(PROCEDURE 6).StyleExpr(ReturnValue)".


//     //Unsupported feature: Deletion (VariableCollection) on "UpdateEnableFlags(PROCEDURE 3).CRMIntegrationManagement(Variable 1000)".


//     //Unsupported feature: Deletion (VariableCollection) on "InitializeDefaultProxyVersion(PROCEDURE 5).CRMIntegrationManagement(Variable 1000)".


//     //Unsupported feature: Property Deletion (AccessByPermission).


//     //Unsupported feature: Property Deletion (ApplicationArea).


//     //Unsupported feature: Property Deletion (UsageCategory).

// }
