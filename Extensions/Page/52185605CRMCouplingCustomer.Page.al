// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Page 52185605 "CRM Coupling Customer"
// {
//     Caption = 'Microsoft Dynamics CRM Account Coupling';
//     PageType = StandardDialog;
//     SourceTable = Customer;

//     layout
//     {
//         area(content)
//         {
//             group(Coupling)
//             {
//                 Caption = 'Coupling';
//                 //The GridLayout property is only supported on controls of type Grid
//                 //GridLayout = Rows;
//                 group("Dynamics NAV")
//                 {
//                     Caption = 'Dynamics NAV';
//                     field(Name;Rec.Name)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Customer';
//                         Editable = false;
//                     }
//                     field(SynchActionControl;SynchAction)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Synchronize After Coupling';
//                         Enabled = not CreateNewInCRM;
//                         OptionCaption = 'No,Yes - Use the Dynamics NAV data,Yes - Use the Dynamics CRM data';

//                         trigger OnValidate()
//                         begin
//                             SetPushActionCheckboxes;
//                         end;
//                     }
//                 }
//                 group("Dynamics CRM")
//                 {
//                     Caption = 'Dynamics CRM';
//                     field("CRM Account Name";CRMAccount.Name)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Account';
//                         Enabled = not CreateNewInCRM;

//                         trigger OnLookup(var Text: Text): Boolean
//                         var
//                             PreviouslySelectedCRMAccount: Record "CRM Account";
//                             CRMAccountList: Page "CRM Account List";
//                         begin
//                             CRMAccountList.SetRecord(CRMAccount);
//                             CRMAccountList.SetCurrentlyCoupledCRMAccount(OriginalCRMAccount);
//                             CRMAccountList.LookupMode(true);
//                             PreviouslySelectedCRMAccount := CRMAccount;

//                             if CRMAccountList.RunModal = Action::LookupOK then begin
//                               CRMAccountList.GetRecord(CRMAccount);
//                               if PreviouslySelectedCRMAccount.AccountId <> CRMAccount.AccountId then
//                                 HandleNewCRMAccount;
//                             end;
//                         end;

//                         trigger OnValidate()
//                         var
//                             ManualCRMAccount: Record "CRM Account";
//                             PreviouslySelectedCRMAccount: Record "CRM Account";
//                             CRMAccountFound: Boolean;
//                         begin
//                             PreviouslySelectedCRMAccount := CRMAccount;
//                             ManualCRMAccount.SetRange(Name,CRMAccount.Name);

//                             if ManualCRMAccount.FindFirst then
//                               CRMAccountFound := true
//                             else begin
//                               ManualCRMAccount.SetCurrentkey(Name);
//                               ManualCRMAccount.SetFilter(Name,'%1',CRMAccount.Name + '*');
//                               if ManualCRMAccount.FindFirst then
//                                 CRMAccountFound := true;
//                             end;

//                             if CRMAccountFound then begin
//                               CRMAccount := ManualCRMAccount;
//                               if PreviouslySelectedCRMAccount.AccountId <> CRMAccount.AccountId then
//                                 HandleNewCRMAccount;
//                             end else
//                               Error(StrSubstNo(NoSuchCRMRecordErr,CRMAccount.Name));
//                         end;
//                     }
//                     field(CreateNewControl;CreateNewInCRM)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Create New Account';

//                         trigger OnValidate()
//                         begin
//                             if CreateNewInCRM then begin
//                               SavedCRMAccount := CRMAccount;
//                               SavedSynchAction := SynchAction;
//                               SynchAction := Synchaction::PushToCRM;
//                               CRMAccount.Init;
//                             end else begin
//                               CRMAccount := SavedCRMAccount;
//                               SynchAction := SavedSynchAction;
//                             end;

//                             SetPushActionCheckboxes;
//                         end;
//                     }
//                 }
//             }
//             group("Coupled Records")
//             {
//                 Caption = 'Coupled Records';
//                 Editable = false;
//                 fixed(Control10)
//                 {
//                     group("Dynamics NAV Customer")
//                     {
//                         Caption = 'Dynamics NAV Customer';
//                         //The GridLayout property is only supported on controls of type Grid
//                         //GridLayout = Columns;
//                         field(Name2;Rec.Name)
//                         {
//                             ApplicationArea = Basic;
//                             Caption = 'Name';
//                         }
//                         field(Contact;Rec.Contact)
//                         {
//                             ApplicationArea = Basic;
//                         }
//                         field(Address;Rec.Address)
//                         {
//                             ApplicationArea = Basic;
//                         }
//                         field("Address 2";Rec."Address 2")
//                         {
//                             ApplicationArea = Basic;
//                         }
//                         field("Post Code";Rec."Post Code")
//                         {
//                             ApplicationArea = Basic;
//                         }
//                         field(City;Rec.City)
//                         {
//                             ApplicationArea = Basic;
//                         }
//                         field("Country/Region Code";Rec."Country/Region Code")
//                         {
//                             ApplicationArea = Basic;
//                         }
//                         field(PushToCRMControl;PushToCRM)
//                         {
//                             ApplicationArea = Basic;
//                             Caption = 'Use for Synchronization';
//                         }
//                     }
//                     group("Dynamics CRM Account")
//                     {
//                         Caption = 'Dynamics CRM Account';
//                         field("CRMAccount.Name";CRMAccount.Name)
//                         {
//                             ApplicationArea = Basic;
//                         }
//                         field("CRMAccount.Address1_PrimaryContactName";CRMAccount.Address1_PrimaryContactName)
//                         {
//                             ApplicationArea = Basic;
//                         }
//                         field("CRMAccount.Address1_Line1";CRMAccount.Address1_Line1)
//                         {
//                             ApplicationArea = Basic;
//                         }
//                         field("CRMAccount.Address1_Line2";CRMAccount.Address1_Line2)
//                         {
//                             ApplicationArea = Basic;
//                         }
//                         field("CRMAccount.Address1_PostalCode";CRMAccount.Address1_PostalCode)
//                         {
//                             ApplicationArea = Basic;
//                         }
//                         field("CRMAccount.Address1_City";CRMAccount.Address1_City)
//                         {
//                             ApplicationArea = Basic;
//                         }
//                         field("CRMAccount.Address1_Country";CRMAccount.Address1_Country)
//                         {
//                             ApplicationArea = Basic;
//                         }
//                         field(PushToNAVControl;PushToNAV)
//                         {
//                             ApplicationArea = Basic;
//                         }
//                     }
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnAfterGetRecord()
//     var
//         CRMIntegrationRecord: Record "CRM Integration Record";
//         CRMID: Guid;
//     begin
//         if CRMIntegrationRecord.FindIDFromRecordID(Rec.RecordId,CRMID) then begin
//           CRMAccount.Get(CRMID);
//           OriginalCRMAccount := CRMAccount;
//           SynchAction := Synchaction::DoNotSynch;
//           SetPushActionCheckboxes;
//         end;
//     end;

//     trigger OnInit()
//     begin
//         SynchAction := Synchaction::PushToCRM;
//         SetPushActionCheckboxes;
//     end;

//     var
//         CRMAccount: Record "CRM Account";
//         OriginalCRMAccount: Record "CRM Account";
//         IntegrationTableMapping: Record "Integration Table Mapping";
//         SavedCRMAccount: Record "CRM Account";
//         CreateNewInCRM: Boolean;
//         PushToCRM: Boolean;
//         PushToNAV: Boolean;
//         InitialSynchDisabledErr: label 'No initial synchronization direction was specified because initial synchronization was disabled.';
//         NoSuchCRMRecordErr: label 'Account with name %1 does not exist in Microsoft Dynamics CRM.', Comment='%1 = The Account name entered by the user';
//         SynchAction: Option DoNotSynch,PushToCRM,PushToNAV;
//         SavedSynchAction: Integer;

//     local procedure SetPushActionCheckboxes()
//     begin
//         if SynchAction = Synchaction::DoNotSynch then begin
//           PushToCRM := false;
//           PushToNAV := false;
//         end else begin
//           PushToCRM := SynchAction = Synchaction::PushToCRM;
//           PushToNAV := not PushToCRM;
//         end
//     end;

//     local procedure HandleNewCRMAccount()
//     var
//         CRMIntegrationRecord: Record "CRM Integration Record";
//     begin
//         if OriginalCRMAccount.AccountId <> CRMAccount.AccountId then
//           CRMIntegrationRecord.AssertRecordIDCanBeCoupled(Rec.RecordId,CRMAccount.AccountId);
//     end;


//     procedure GetCRMID(): Guid
//     begin
//         exit(CRMAccount.AccountId);
//     end;


//     procedure GetCreateNewInCRM(): Boolean
//     begin
//         exit(CreateNewInCRM);
//     end;


//     procedure GetPerformInitialSynchronization(): Boolean
//     begin
//         exit(SynchAction <> Synchaction::DoNotSynch);
//     end;


//     procedure GetInitialSynchronizationDirection(): Integer
//     begin
//         if SynchAction = Synchaction::DoNotSynch then
//           Error(InitialSynchDisabledErr);

//         if SynchAction = Synchaction::PushToCRM then
//           exit(IntegrationTableMapping.Direction::ToIntegrationTable);

//         exit(IntegrationTableMapping.Direction::FromIntegrationTable);
//     end;
// }
