// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52186149 pageextension52186149 extends "OCR Service Setup" 
// {

//     //Unsupported feature: Property Modification (PromotedActionCategoriesML) on ""OCR Service Setup"(Page 1270)".

//     layout
//     {
//         modify("User Name")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Password)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(AuthorizationKey)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Default OCR Doc. Template")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Enabled)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Sign-up URL")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on ""Sign-up URL"(Control 4)".


//             //Unsupported feature: Property Modification (Name) on ""Sign-up URL"(Control 4)".

//             Enabled = EditableByNotEnabled;
//         }
//         modify("Service URL")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Sign-in URL")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on ""Sign-in URL"(Control 6)".


//             //Unsupported feature: Property Modification (Name) on ""Sign-in URL"(Control 6)".

//         }
//         modify("Customer Name")
//         {
//             ApplicationArea = Basic;
//             Editable = EditableByNotEnabled;
//         }
//         modify("Customer ID")
//         {
//             ApplicationArea = Basic;
//             Editable = EditableByNotEnabled;
//         }
//         modify("Customer Status")
//         {
//             ApplicationArea = Basic;
//             Editable = EditableByNotEnabled;
//         }
//         modify("User Name")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""User Name"(Control 3)".


//         //Unsupported feature: Code Modification on "Password(Control 9).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             SavePassword("Password Key",Password);
//             IF Password <> '' THEN
//               CheckEncryption;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             SavePassword("Password Key",Password);
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "Password(Control 9)".



//         //Unsupported feature: Code Modification on "AuthorizationKey(Control 7).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             SavePassword("Authorization Key",AuthorizationKey);
//             IF AuthorizationKey <> '' THEN
//               CheckEncryption;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             SavePassword("Authorization Key",AuthorizationKey);
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "AuthorizationKey(Control 7)".

//         modify("Default OCR Doc. Template")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Default OCR Doc. Template"(Control 16)".

//         modify("Master Data Sync Enabled")
//         {
//             Visible = false;
//         }
//         modify("Master Data Last Sync")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "Enabled(Control 22)".

//         modify(ShowEnableWarning)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Sign-up URL"(Control 4)".


//         //Unsupported feature: Property Deletion (Editable) on ""Sign-up URL"(Control 4)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Service URL"(Control 5)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Sign-in URL"(Control 6)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Customer Name"(Control 18)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Customer ID"(Control 19)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Customer Status"(Control 20)".

//         addfirst(Control25)
//         {
//             field(ShowEnableWarning;ShowEnableWarning)
//             {
//                 ApplicationArea = Basic;
//                 AssistEdit = false;
//                 Editable = false;

//                 trigger OnDrillDown()
//                 begin
//                     DrilldownCode;
//                 end;
//             }
//         }
//     }
//     actions
//     {
//         modify(SetURLsToDefault)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(TestConnection)
//         {

//             //Unsupported feature: Property Modification (Name) on "TestConnection(Action 15)".

//             ApplicationArea = Basic;

//             //Unsupported feature: Property Insertion (RunObject) on "TestConnection(Action 15)".

//         }
//         modify(UpdateOCRDocTemplateList)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(JobQueueEntry)
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (PromotedCategory) on "JobQueueEntry(Action 13)".

//         }
//         modify(EncryptionManagement)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(ActivityLog)
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "SetURLsToDefault(Action 11)".

//         modify(TestConnection)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "TestConnection(Action 15)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "UpdateOCRDocTemplateList(Action 21)".

//         modify(ResyncMasterData)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "JobQueueEntry(Action 13)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "EncryptionManagement(Action 8)".



//         //Unsupported feature: Code Insertion (VariableCollection) on "ActivityLog(Action 26).OnAction".

//         //trigger (Variable: OCRServiceSetup)()
//         //Parameters and return type have not been exported.
//         //begin
//             /*
//             */
//         //end;


//         //Unsupported feature: Code Modification on "ActivityLog(Action 26).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             ActivityLog.ShowEntries(Rec);
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             OCRServiceSetup.GET;
//             ActivityLog.ShowEntries(OCRServiceSetup.RECORDID);
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "ActivityLog(Action 26)".


//         //Unsupported feature: Property Deletion (Promoted) on "ActivityLog(Action 26)".


//         //Unsupported feature: Property Deletion (PromotedCategory) on "ActivityLog(Action 26)".

//     }

//     var
//         OCRServiceSetup: Record "OCR Service Setup";


//     //Unsupported feature: Property Modification (TextConstString) on "DisableEnableQst(Variable 1004)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //DisableEnableQst : ENU=Do you want to disable the OCR service?;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //DisableEnableQst : ENU=Do you want to disable OCR service?;
//         //Variable type has not been exported.


//     //Unsupported feature: Code Modification on "OnOpenPage".

//     //trigger OnOpenPage()
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         RESET;
//         IF NOT GET THEN BEGIN
//           INIT;
//           INSERT(TRUE);
//           SetURLsToDefault;
//         END;
//         UpdateBasedOnEnable;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         #1..6
//         Password := '*************';
//         AuthorizationKey := '*************';
//         UpdateBasedOnEnable;
//         */
//     //end;


//     //Unsupported feature: Code Modification on "UpdateBasedOnEnable(PROCEDURE 2)".

//     //procedure UpdateBasedOnEnable();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         EditableByNotEnabled := (NOT Enabled) AND CurrPage.EDITABLE;
//         ShowEnableWarning := '';
//         IF CurrPage.EDITABLE AND Enabled THEN
//           ShowEnableWarning := EnabledWarningTok;
//         UpdateBasedOnSyncEnable;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         EditableByNotEnabled := NOT Enabled;
//         #2..4
//         */
//     //end;

//     //Unsupported feature: Property Deletion (ApplicationArea).


//     //Unsupported feature: Property Deletion (UsageCategory).


//     //Unsupported feature: Property Deletion (AdditionalSearchTermsML).

// }
