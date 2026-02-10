// page 52186690 "Virtual Registreation Page"
// {
//     DeleteAllowed = false;
//     PageType = Card;
//     SourceTable = "Sky Virtual Member";

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Editable = false;
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field(Telephone; Rec.Telephone)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = true;
//                 }
//                 field(Names; Rec.Names)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Name on IPRS"; Rec."Name on IPRS")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Date Of Birth"; Rec."Date Of Birth")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Gender; Rec.Gender)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Citizenship; Rec.Citizenship)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Address; Rec.Address)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Passport Number"; Rec."Passport Number")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Reffered By"; Rec."Reffered By")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Validated; Rec.Validated)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("ID Number"; Rec."ID Number")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Email; Rec.Email)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Referer Member No"; Rec."Referer Member No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Sent To Application"; Rec."Sent To Application")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Actioned By"; Rec."Actioned By")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Service Number"; Rec."Service Number")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic, Suite;

//                     trigger OnValidate()
//                     begin
//                         ControlActions;
//                     end;
//                 }
//                 field("Entry Date"; Rec."Entry Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Entry Time"; Rec."Entry Time")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Source Application"; Rec."Source Application")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Pushed by Member No"; Rec."Pushed by Member No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Pushed by Name"; Rec."Pushed by Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//             group("Employment Details")
//             {
//                 Editable = EmployerDetailsEdit;
//                 field("Employer Code"; Rec."Employer Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Employer; Rec.Employer)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Employer Name"; Rec."Employer Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Payroll Number"; Rec."Payroll Number")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(creation)
//         {
//             action(Validate)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = ValidateEmailLoggingSetup;
//                 Promoted = true;
//             }
//             action("Send To Application")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Enabled = SendToApplication;
//                 Image = SendConfirmation;
//                 Promoted = true;

//                 trigger OnAction()
//                 var
//                     FirstName: Text[50];
//                     SecondName: Text[50];
//                     LastName: Text[50];
//                     FirstSTRPOS: Integer;
//                     SeccondAndLastName: Text;
//                     SecondSTRPOS: Integer;
//                     msg: Text;
//                     RecruiterFound: Boolean;
//                     UserSetup: Record "User Setup";
//                     ResponsibilityCenter: Code[50];
//                     ActivityCode: Code[50];
//                     BranchCode: Code[50];
//                     FullName: Text;
//                 begin
//                     Rec.TestField(Status, Rec.Status::Approved);
//                     MemberApplication.Reset;
//                     if MemberApplication.FindFirst then Error('Another record with this ID Number already exists in the system');

//                     //TESTFIELD("Employer Code");
//                     RecruiterFound := false;
//                     SeriesSetup.Get;
//                     SeriesSetup.TestField(SeriesSetup."Virtual Member App. No");
//                     NoSeriesMgt.InitSeries(SeriesSetup."Virtual Member App. No", MemberApplication."No. Series", 0D, MemberApplication."No.", MemberApplication."No. Series");
//                     RecruiterFound := false;
//                     Members.Reset;
//                     Members.SetFilter("Phone No.", '=%1|=%2', '+' + Rec."Reffered By", Rec."Reffered By");
//                     if Members.FindFirst then begin
//                         RecruiterMemberNo := Members."No.";
//                         RecruiterName := Members.Name;
//                         RecruiterFound := true;
//                     end else begin
//                         Message('Recruiter Phone No %1 not found', Rec."Reffered By");
//                         RecruiterFound := false;
//                     end;

//                     MemberAppNo := MemberApplication."No.";
//                     FullName := Rec."Name on IPRS";
//                     if FullName = '' then FullName := Rec.Names;
//                     FirstName := CopyStr(FullName, 1, StrPos(FullName, ' ') - 1);
//                     FirstSTRPOS := StrPos(FullName, ' ');
//                     SeccondAndLastName := CopyStr(FullName, FirstSTRPOS + 1, 100);
//                     SecondSTRPOS := StrPos(SeccondAndLastName, ' ');
//                     if SecondSTRPOS = 0 then
//                         LastName := CopyStr(SeccondAndLastName, 1, 100)
//                     else
//                         SecondName := CopyStr(SeccondAndLastName, 1, SecondSTRPOS - 1);

//                     if SecondSTRPOS > 1 then
//                         LastName := CopyStr(SeccondAndLastName, SecondSTRPOS + 1, 100);

//                     UserSetup.Reset;
//                     UserSetup.SetRange("User ID", UserId);

//                     MemberApplication.Init;
//                     MemberApplication."First Name" := FirstName;
//                     MemberApplication."Middle Name" := SecondName;
//                     MemberApplication."Other Names" := LastName;
//                     MemberApplication."No." := MemberAppNo;
//                     MemberApplication."Phone No." := '+' + Rec.Telephone;
//                     MemberApplication."Phone No." := '+' + Rec.Telephone;
//                     MemberApplication.Name := FullName;
//                     MemberApplication."Date of Birth" := Rec."Date Of Birth";
//                     MemberApplication.Gender := Rec.Gender;
//                     if RecruiterFound then begin
//                         MemberApplication."Recruited By" := RecruiterMemberNo;
//                         MemberApplication."Recruited by Type" := MemberApplication."Recruited by Type"::Self;
//                         MemberApplication."Recruited By Name" := RecruiterName;
//                     end;
//                     //MemberApplication."Employer Code" := "Employer Code";
//                     MemberApplication."Employer Name" := Rec."Employer Name";
//                     MemberApplication."Payroll/Staff No." := Rec."Payroll Number";
//                     MemberApplication."Application Date" := Today;
//                     MemberApplication."Created By" := UserId;
//                     MemberApplication.Nationality := Rec.Citizenship;
//                     MemberApplication.Validate(MemberApplication."Date of Birth");
//                     MemberApplication.Insert;

//                     //Auto Accounts
//                     ProductFactory.SetFilter(ProductFactory.Status, '%1', ProductFactory.Status::Active);
//                     ProductFactory.SetFilter(ProductFactory."Auto Open Account", '%1', true);
//                     ProductFactory.SetFilter(ProductFactory."Product Category", '<>%1', ProductFactory."Product Category"::"Fixed Deposit");
//                     // if ProductFactory.Find('-') then begin
//                     //     repeat
//                     //         AutoOpenSavingAccs.Init;
//                     //         AutoOpenSavingAccs."No." := MemberAppNo;
//                     //         AutoOpenSavingAccs.Validate(AutoOpenSavingAccs."Product Type", ProductFactory."Product ID");
//                     //         AutoOpenSavingAccs."Monthly Contribution" := ProductFactory."Minimum Contribution";
//                     //         AutoOpenSavingAccs.Insert;
//                     //     until ProductFactory.Next = 0;
//                     // end;


//                     Rec.Validated := true;
//                     Rec."Sent To Application" := true;
//                     Rec."Actioned By" := UserId;
//                     Rec.Modify;



//                     msg := 'Dear ' + Rec.Names + ', your application has been received under ref no: ' + MemberAppNo +
//                     '. Please indicate this ref no. on the form and submit to the Sacco to allow for completion of the registration ' +
//                     'process. For help 0709943000.';
//                     // SkyMbanking.SendSms(Source::MBANKING, Telephone, msg, MemberAppNo, '', true, 205, false);

//                     if RecruiterFound then begin
//                         msg := 'Dear Member, thank you for introducing ' + Rec.Names + ' to Harambee Sacco. Application is being processed under ref no: ' + MemberAppNo +
//                         '. For help 0709943000.';
//                         // SkyMbanking.SendSms(Source::MBANKING, "Reffered By", msg, MemberAppNo, '', true, 205, false);
//                     end;

//                     Message('Application sent succsessfully');
//                 end;
//             }
//             action(Approve)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Approve';
//                 Enabled = Approve;
//                 Image = Approve;
//                 Promoted = true;
//                 PromotedCategory = Category4;
//                 PromotedIsBig = true;

//                 trigger OnAction()
//                 var
//                 // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                 begin
//                     Rec.TestField(Status, Rec.Status::Pending);

//                     //              ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
//                 end;
//             }
//             separator(Action38)
//             {
//             }
//             action(SendApprovalRequest)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Send A&pproval Request';
//                 Enabled = SendApproval;
//                 Image = SendApprovalRequest;
//                 Promoted = true;
//                 PromotedCategory = Category9;

//                 trigger OnAction()
//                 var
//                     // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     MemberClass: Record "Member Classes";
//                     SegmentCountyDividendSignat: Record "Segment/County/Dividend/Signat";
//                 begin
//                     VarVariant := Rec;
//                     // if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
//                     //     CustomApprovals.OnSendDocForApproval(VarVariant);
//                 end;
//             }
//             action(CancelApprovalRequest)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Cancel Approval Re&quest';
//                 Enabled = CancelApproval;
//                 Image = Cancel;
//                 Promoted = true;
//                 PromotedCategory = Category9;

//                 trigger OnAction()
//                 var
//                 // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                 begin
//                     VarVariant := Rec;
//                     // CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
//                 end;
//             }
//             action("Re-Open Deferred  Loan")
//             {
//                 ApplicationArea = Basic, Suite;

//                 trigger OnAction()
//                 begin

//                     Rec.Status := Rec.Status::Open;
//                     Rec.Modify;

//                 end;
//             }
//             action(Approvals)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Approvals';
//                 Image = Approvals;

//                 trigger OnAction()
//                 var
//                 // //ApprovalEntries: Page "Approval Entries";
//                 // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                 begin

//                     // ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
//                 end;
//             }
//             action("Member Report")
//             {
//                 ApplicationArea = Basic, Suite;

//                 trigger OnAction()
//                 begin
//                     SkyVirtualMember.Reset;
//                     SkyVirtualMember.SetRange("No.", Rec."No.");
//                     if SkyVirtualMember.FindFirst then begin
//                         SkyVirtualMember.Reset;
//                         SkyVirtualMember.SetRange("No.", Rec."No.");
//                         if SkyVirtualMember.FindFirst then begin
//                             //REPORT.Run(52186019, true, false, SkyVirtualMember);
//                         end else begin
//                             GeneralSetUp.Get();
//                             FromFile := GeneralSetUp."PDF B64 Folder" + '\' + 'member - ' + Rec."No." + '.pdf';
//                             Name := 'meeting - ' + Rec."No.";
//                             // if Exists(FromFile) then
//                             //     Download(FromFile, 'Member', '', 'Text file(*.pdf)|*.pdf', Name)
//                             // else
//                             //     Message('The file you are looking for is not available');
//                         end;
//                     end;
//                 end;
//             }
//         }
//     }

//     trigger OnModifyRecord(): Boolean
//     begin
//         ControlActions
//     end;

//     trigger OnNextRecord(Steps: Integer): Integer
//     begin
//         ControlActions
//     end;

//     trigger OnOpenPage()
//     begin
//         ControlActions
//     end;

//     var
//         SeriesSetup: Record "Credit Nos. Series";
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         MemberAppNo: Code[50];
//         Members: Record Members;
//         RecruiterMemberNo: Code[30];
//         RecruiterName: Text[50];
//         Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
//         // SkyMbanking: Codeunit "Sky Mbanking";
//         ProductFactory: Record "Product Factory";
//         // AutoOpenSavingAccs: Record "Savings Account Registration";
//         // CustomApprovals: Codeunit "Custom Approvals Codeunit";
//         VarVariant: Variant;
//         MemberApplication: Record "Member Application";
//         SendApproval: Boolean;
//         Approve: Boolean;
//         CancelApproval: Boolean;
//         SendToApplication: Boolean;
//         EmployerDetailsEdit: Boolean;
//         SkyVirtualMember: Record "Sky Virtual Member";
//         GeneralSetUp: Record "General Set-Up";
//         Name: Text;
//         FromFile: Text;

//     local procedure ControlActions()
//     begin
//         if Rec.Status = Rec.Status::Open then begin
//             SendApproval := true;
//             SendToApplication := false;
//             Approve := false;
//             CancelApproval := false;
//             EmployerDetailsEdit := true;
//         end;

//         if Rec.Status = Rec.Status::Pending then begin
//             SendApproval := false;
//             SendToApplication := false;
//             Approve := true;
//             CancelApproval := true;
//             EmployerDetailsEdit := false;
//         end;

//         if Rec.Status = Rec.Status::Rejected then begin
//             SendApproval := false;
//             SendToApplication := false;
//             Approve := false;
//             CancelApproval := false;
//             EmployerDetailsEdit := false;
//         end;

//         if Rec.Status = Rec.Status::Approved then begin
//             SendApproval := false;
//             SendToApplication := true;
//             Approve := false;
//             CancelApproval := false;
//             EmployerDetailsEdit := false;
//         end;
//     end;
// }

