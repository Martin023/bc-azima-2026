// page 52186988 "Salary Header P"
// {
//     DeleteAllowed = false;
//     Editable = true;
//     PageType = Card;
//     SourceTable = "Salary Header P";
//     PromotedActionCategories = 'New,Process,Report,Workflows, ,Request Approval,Adjustments';


//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 field(No; Rec.No)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Transaction Type"; Rec."Transaction Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = TransType;
//                 }
//                 field("Account Type"; Rec."Account Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = AccType;
//                 }
//                 field("Account No"; Rec."Account No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = AccNo;
//                 }
//                 field("Account Name"; Rec."Account Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Employer Code"; Rec."Employer Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = EmployerC;
//                 }
//                 field("Employer Name"; Rec."Employer Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Document No"; Rec."Document No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = DocNo;
//                 }
//                 // field(Month; Rec.Month)
//                 // {
//                 //     ApplicationArea = Basic, Suite;
//                 //     Editable = DocNo;
//                 // }
//                 // field(Year; Rec.Year)
//                 // {
//                 //     ApplicationArea = Basic, Suite;
//                 //     Editable = DocNo;

//                 //     trigger OnValidate()
//                 //     begin
//                 //         rec.Remarks := Format(Rec."Employer Code") + ' - ' + Format(rec.Month, 0, '<Month Text>') + ' - '
//                 //                       + Format(Date2DMY(rec."Posting Date", 3)) + Format(Rec."Income Type");
//                 //     end;
//                 // }

//                 field("Start Date"; Rec."Start Date")
//                 {

//                 }
//                 field("End Date"; Rec."End Date")
//                 {
//                     Editable = false;
//                 }
//                 field(Remarks; Rec.Remarks)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = true;
//                 }
//                 field(Amount; Rec.Amount)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = Amnt;
//                 }
//                 field("Scheduled Amount"; Rec."Scheduled Amount")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Total Count"; Rec."Total Count")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }

//                 field("Total Posted Count"; Rec."Total Posted Count")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }

//                 field("Last Loan Issue Date"; Rec."Last Loan Issue Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = LastloanDate;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Income Type"; Rec."Income Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = IncType;
//                 }
//                 field("Posting date"; Rec."Posting date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = Pdate;
//                 }
//                 field(Posted; Rec.Posted)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Posted By"; Rec."Posted By")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Donnot Recover"; Rec."Donnot Recover")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Visible = false;
//                 }
//                 field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
//                 {
//                     editable = false;
//                 }
//                 field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
//                 {
//                     editable = false;
//                 }
//                 field("Responsibility Centre"; Rec."Responsibility Centre")
//                 {
//                     editable = false;

//                 }
//             }
//             part(Control17; "Salary Lines P")
//             {
//                 SubPageLink = "Salary Header No." = FIELD(No);
//                 ApplicationArea = Basic;
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action("Import Salaries")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Import Salaries P';
//                 Image = Import;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 RunObject = XMLport "Import Salaries P";

//                 trigger OnAction()
//                 begin
//                     if rec.posted then Error('Salary batch has already been posted.');
//                     if rec.Status <> Rec.Status::Pending then Error('Salary has already started the approval process. Kindly reopen Document.')
//                 end;
//             }
//             group(Process)
//             {
//                 Caption = 'Process';
//                 // action(Print)
//                 // {
//                 //     ApplicationArea = Basic, Suite;
//                 //     Image = ConfirmAndPrint;
//                 //     Promoted = true;
//                 //     PromotedCategory = "Report";
//                 //     PromotedIsBig = true;

//                 //     trigger OnAction()
//                 //     begin
//                 //         Rec.Reset;
//                 //         Rec.SetFilter(No, Rec.No);
//                 //         REPORT.Run(52185686, true, true, Rec);
//                 //     end;
//                 // }
//                 // action("Net Salary")
//                 // {
//                 //     ApplicationArea = Basic, Suite;
//                 //     Image = ReverseRegister;
//                 //     Promoted = true;
//                 //     PromotedCategory = "Report";
//                 //     PromotedIsBig = true;

//                 //     trigger OnAction()
//                 //     begin
//                 //         Rec.TestField(Posted, true);
//                 //         Rec.Reset;
//                 //         Rec.SetFilter(No, Rec.No);
//                 //         REPORT.Run(Report::"Net Salary Report", true, true, Rec);
//                 //     end;
//                 // }
//                 action(Validate)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Image = Translation;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     var
//                         SalaryLines: Record "Salary Lines P";
//                         SavingsAccounts: Record "Savings Accounts";
//                         StrMenuTxt: Label '&Staff No.,&Account No.,&ID No';
//                         Selection: Integer;
//                     begin
//                         if Rec."Donnot Recover" = false then
//                             Rec.TestField("Employer Code");

//                         Selection := StrMenu(StrMenuTxt, 3);

//                         if Selection = 0 then
//                             exit;

//                         if Selection = 1 then begin
//                             SalaryLines.Reset;
//                             SalaryLines.SetRange(SalaryLines."Salary Header No.", Rec.No);
//                             if SalaryLines.Find('-') then begin
//                                 repeat
//                                     SavingsAccounts.Reset;
//                                     SavingsAccounts.SetCurrentKey("Product Type");
//                                     SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"FOSA Account");
//                                     SavingsAccounts.SetFilter(SavingsAccounts."Employer Code", Rec."Employer Code");
//                                     SavingsAccounts.SetRange(SavingsAccounts."Payroll/Staff No.", SalaryLines."Staff No.");
//                                     SavingsAccounts.setrange(SavingsAccounts."Product Type", '191');
//                                     if SavingsAccounts.Find('-') then begin

//                                         SalaryLines."Account Not Found" := false;
//                                         //SalaryLines.Posted := false;
//                                         SalaryLines.Modify;

//                                         if SavingsAccounts."Payroll/Staff No." <> '' then begin
//                                             SalaryLines."Account No." := SavingsAccounts."No.";
//                                             if SavingsAccounts.Blocked <> SavingsAccounts.Blocked::" " then
//                                                 SalaryLines."Blocked Accounts" := true
//                                             else
//                                                 SalaryLines."Blocked Accounts" := false;

//                                             SalaryLines."ID No." := SavingsAccounts."ID No.";
//                                             SalaryLines."Account No." := SavingsAccounts."No.";

//                                             SalaryLines.Status := SavingsAccounts.Status;
//                                             SalaryLines."Member No." := SavingsAccounts."Member No.";
//                                             SalaryLines.Name := SavingsAccounts.Name;
//                                             SalaryLines."Employer Code" := SavingsAccounts."Employer Code";
//                                             SalaryLines."Global Dimension 1 Code" := SavingsAccounts."Global Dimension 1 Code";
//                                             SalaryLines."Global Dimension 2 Code" := SavingsAccounts."Global Dimension 2 Code";
//                                         end else
//                                             SalaryLines."Account Not Found" := true;
//                                         //SalaryLines.Posted := false;
//                                         SalaryLines.Modify;
//                                         // SavingsAccounts."Salary Through FOSA" := true;
//                                         // SavingsAccounts.Modify;
//                                     end else
//                                         SalaryLines."Account Not Found" := true;
//                                     //SalaryLines.Posted := false;
//                                     SalaryLines.Modify;
//                                 until SalaryLines.Next = 0;
//                             end;
//                         end;

//                         if Selection = 2 then begin
//                             SalaryLines.Reset;
//                             SalaryLines.SetRange(SalaryLines."Salary Header No.", rec.No);
//                             if SalaryLines.Find('-') then begin

//                                 repeat
//                                     SavingsAccounts.Reset;
//                                     // if Rec."Donnot Recover" = false then
//                                     // SavingsAccounts.SetFilter(SavingsAccounts."Employer Code", Rec."Employer Code");
//                                     SavingsAccounts.SetRange(SavingsAccounts."No.", SalaryLines."Account No.");
//                                     SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"FOSA Account");
//                                     SavingsAccounts.setrange(SavingsAccounts."Product Type", '191');
//                                     if SavingsAccounts.Find('-') then begin
//                                         SalaryLines."Account Not Found" := false;
//                                         //SalaryLines.Posted := false;
//                                         SalaryLines.Modify;
//                                         // SavingsAccounts."Salary Through FOSA" := true;
//                                         // SavingsAccounts.Modify;
//                                         if SavingsAccounts.Blocked <> SavingsAccounts.Blocked::" " then
//                                             SalaryLines."Blocked Accounts" := true
//                                         else
//                                             SalaryLines."Blocked Accounts" := false;
//                                         SalaryLines."ID No." := SavingsAccounts."ID No.";
//                                         SalaryLines."Account No." := SavingsAccounts."No.";
//                                         SalaryLines.Status := SavingsAccounts.Status;
//                                         SalaryLines."Member No." := SavingsAccounts."Member No.";
//                                         SalaryLines.Name := SavingsAccounts.Name;
//                                         SalaryLines."Employer Code" := SavingsAccounts."Employer Code";
//                                         SalaryLines."Global Dimension 1 Code" := SavingsAccounts."Global Dimension 1 Code";
//                                         SalaryLines."Global Dimension 2 Code" := SavingsAccounts."Global Dimension 2 Code";
//                                         //SalaryLines.Posted := false;
//                                         SalaryLines."Posting Date" := Today;
//                                         SalaryLines."Posting Time" := Time;

//                                     end else
//                                         SalaryLines."Account Not Found" := true;
//                                     //SalaryLines.Posted := false;
//                                     SalaryLines.Modify;
//                                 until SalaryLines.Next = 0;
//                             end;
//                         end;
//                         if Selection = 3 then begin
//                             SalaryLines.Reset;
//                             SalaryLines.SetRange(SalaryLines."Salary Header No.", Rec.No);
//                             if SalaryLines.Find('-') then begin
//                                 repeat
//                                     SavingsAccounts.Reset;
//                                     SavingsAccounts.SetRange(SavingsAccounts."ID No.", SalaryLines."ID No.");
//                                     SavingsAccounts.setrange(SavingsAccounts."Product Type", '191');
//                                     //SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"FOSA Account");
//                                     if SavingsAccounts.Find('-') then begin

//                                         SalaryLines."Account Not Found" := false;
//                                         //SalaryLines.Posted := false;
//                                         SalaryLines.Modify;

//                                         if SavingsAccounts."ID No." <> '' then begin
//                                             if SavingsAccounts.Blocked <> SavingsAccounts.Blocked::" " then
//                                                 SalaryLines."Blocked Accounts" := true
//                                             else
//                                                 SalaryLines."Blocked Accounts" := false;

//                                             SalaryLines."ID No." := SavingsAccounts."ID No.";
//                                             SalaryLines."Account No." := SavingsAccounts."No.";
//                                             SalaryLines.Status := SavingsAccounts.Status;
//                                             SalaryLines."Member No." := SavingsAccounts."Member No.";
//                                             SalaryLines.Name := SavingsAccounts.Name;
//                                             SalaryLines."Employer Code" := SavingsAccounts."Employer Code";
//                                             SalaryLines."Global Dimension 1 Code" := SavingsAccounts."Global Dimension 1 Code";
//                                             SalaryLines."Global Dimension 2 Code" := SavingsAccounts."Global Dimension 2 Code";
//                                             SalaryLines."Posting Date" := Today;
//                                             SalaryLines."Posting Time" := Time;
//                                         end else
//                                             SalaryLines."Account Not Found" := true;
//                                         //SalaryLines.Posted := false;
//                                         SalaryLines.Modify;

//                                         //   SavingsAccounts."Salary Through FOSA" := true;
//                                         //   SavingsAccounts.Modify;
//                                     end else
//                                         SalaryLines."Account Not Found" := true;
//                                     //SalaryLines.Posted := false;
//                                     SalaryLines.Modify;


//                                 until SalaryLines.Next = 0;
//                             end;
//                         end;

//                         Rec.Validated := true;
//                         Rec.Modify;
//                         Message('Salary Lines P Validated sucessfully');
//                     end;
//                 }
//                 action("Check for Mutiple Salaries")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Image = "Report";
//                     Promoted = true;
//                     PromotedCategory = "Report";

//                     trigger OnAction()
//                     var
//                         SalaryLines: Record "Salary Lines P";
//                     begin

//                         SalaryLines.Reset;
//                         SalaryLines.SetRange(SalaryLines."Salary Header No.", rec.No);
//                         if SalaryLines.Find('-') then
//                             REPORT.Run(Report::"Check Mutiple Salary P", true, false, SalaryLines);
//                     end;
//                 }
//                 // action("Unblock Accounts")
//                 // {
//                 //     ApplicationArea = Basic, Suite;
//                 // }
//             }
//             group(Action22)
//             {
//                 Caption = 'Post';
//                 action(Post)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Image = Post;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     var
//                         SaccoT: Codeunit "Sacco Transactions";
//                         GenSetup: record "General Set-Up";
//                     begin
//                         SalaryLines.Reset;
//                         SalaryLines.SetRange(SalaryLines."Salary Header No.", Rec.No);
//                         if SalaryLines.FindSet() then begin
//                             repeat
//                                 if SalaryLines."Multiple Salary" = true then begin
//                                     Error('Kinldy reconcile all the Multiple accounts for this employer before proceeding');
//                                 end;
//                             until
//                             SalaryLines.Next = 0;
//                         end;
//                         if Rec.Status <> Rec.Status::Approved then
//                             Error('The salary batch has not been approved');
//                         GenSetup.Get();
//                         if GenSetup."Disable Salary SMS" = true then begin
//                             if not Confirm('Salary SMS has been disabled, do you wish to proceed without notifications to members?') then exit;
//                         end;

//                         Codeunit.Run(Codeunit::"Salaries Job Queue Manager", Rec);

//                         // SaccoT.PostSalaryP(Rec);
//                         // if Codeunit.Run(Codeunit::"Salaries Job Queue Manager", Rec) then begin
//                         //     Message('Salary posting process initiated successfully. It will run in the background');
//                         // end else begin
//                         //     Error('Unable to initiate salary posting process at the moment!');
//                         // end;
//                         // HandleDialogProgress;
//                     end;
//                 }
//             }
//             group(Approval)
//             {
//                 Caption = 'Approval';
//                 action(Approve)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Approve';
//                     Image = Approve;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     // Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     begin

//                     end;
//                     // var
//                     //     // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     // begin
//                     //     ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
//                     // end;
//                 }
//                 action(Reject)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Reject';
//                     Image = Reject;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     // var
//                     //     // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     // begin
//                     //     // ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
//                     // end;
//                     begin

//                     end;
//                 }
//                 action(Delegate)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Delegate';
//                     Image = Delegate;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     // var
//                     //     // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     // begin
//                     //     ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
//                     // end;
//                     begin

//                     end;
//                 }
//                 action(Comment)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Comments';
//                     Image = ViewComments;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     RunObject = Page "Approval Comments";
//                     Visible = OpenApprovalEntriesExistForCurrUser;
//                 }
//             }
//             group("Request Approval")
//             {
//                 Caption = 'Request Approval';
//                 action(SendApprovalRequest)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Send A&pproval Request';
//                     Enabled = NOT OpenApprovalEntriesExist;
//                     Image = SendApprovalRequest;
//                     Promoted = true;
//                     PromotedCategory = Category4;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin

//                         if Rec.Status <> Rec.Status::Open then
//                             Error(DocMustbeOpen);

//                         Rec.TestField("Transaction Type");
//                         Rec.TestField("Document No");
//                         Rec.TestField(Remarks);
//                         Rec.TestField(Amount);
//                         if Rec."Donnot Recover" = false then begin
//                             Rec.TestField("Employer Code");
//                             Rec.TestField("Last Loan Issue Date");
//                         end;
//                         Rec.TestField("Posting date");
//                         Rec.TestField("Account No");
//                         //Rec.TestField("Account Name");

//                         Rec.CalcFields("Scheduled Amount");

//                         if Rec.Validated = false then
//                             Error('Kinldy validate the salary batch before proceeding');

//                         if Rec."Mutiple Salaries Checked" = false then
//                             Error('Kindly check for multiple salaries before proceeding');

//                         if Rec."Scheduled Amount" <> Rec.Amount then
//                             Error('Scheduled amount and Amount must be the same');


//                         SalaryLines.Reset;
//                         SalaryLines.SetRange(SalaryLines."Salary Header No.", Rec.No);
//                         if SalaryLines.Find('-') then begin
//                             repeat
//                                 if SalaryLines."Account Not Found" = true then begin
//                                     Error('Kinldy reconcile all the unfound accounts for this employer before proceeding');
//                                 end;
//                             until
//                             SalaryLines.Next = 0;
//                         end;



//                         SalaryLines.Reset;
//                         SalaryLines.SetRange(SalaryLines."Salary Header No.", Rec.No);
//                         if SalaryLines.Find('-') then begin
//                             repeat
//                                 if SalaryLines."Multiple Salary" = true then begin
//                                     Error('Kinldy reconcile all the Multiple accounts for this employer before proceeding');
//                                 end;
//                             until
//                             SalaryLines.Next = 0;
//                         end;


//                         VarVariant := Rec;
//                         if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
//                             CustomApprovals.OnSendDocForApproval(VarVariant);
//                     end;
//                 }
//                 action("Re-Open ")
//                 {
//                     Image = ReOpen;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     ApplicationArea = Basic, Suite;

//                     trigger OnAction()
//                     begin
//                         if rec.Posted = false then begin
//                             rec.Status := rec.Status::Open;
//                             rec.Modify;
//                             Message('Document open successfuly');
//                         end;
//                     end;
//                 }
//                 action(CancelApprovalRequest)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Cancel Approval Re&quest';
//                     Enabled = OpenApprovalEntriesExist;
//                     Image = Cancel;
//                     Promoted = true;
//                     PromotedCategory = Category4;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin

//                         if Rec.Status <> Rec.Status::Pending then
//                             Error(DocMustbePending);

//                         VarVariant := Rec;
//                         CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
//                     end;
//                 }
//                 action(Approvals)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Approvals';
//                     Image = Approvals;
//                     Visible = true;

//                     trigger OnAction()
//                     var
//                         ApprovalEntries: Page "Approval Entries";
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);

//                     end;

//                 }
//             }
//         }
//     }

//     trigger OnAfterGetCurrRecord()
//     begin

//         if Rec.Status <> Rec.Status::Open then
//             CurrPage.Editable := false;

//         HandleDialogProgress;
//     end;

//     trigger OnAfterGetRecord()
//     begin
//         //SetControlAppearance;
//         UpdateControl;

//         if Rec.Status <> Rec.Status::Open then
//             CurrPage.Editable := false;
//     end;

//     trigger OnInit()
//     begin
//         UpdateControl;
//     end;

//     trigger OnNextRecord(Steps: Integer): Integer
//     begin

//         if Rec.Status <> Rec.Status::Open then
//             CurrPage.Editable := false;
//     end;

//     trigger OnOpenPage()
//     begin
//         if Rec.Status <> Rec.Status::Open then
//             CurrPage.Editable := false;

//         HandleDialogProgress;
//     end;

//     local procedure HandleDialogProgress()
//     var
//         JobQueueEntry: Record "Job Queue Entry";
//     begin
//         if Rec.Status = Rec.Status::Approved then begin
//             JobQueueEntry.Reset;

//             JobQueueEntry.SetFilter("Object ID to Run", '=%1|%2', Codeunit::"Salary Job", Codeunit::"Salaries Job Queue Manager");
//             JobQueueEntry.SetFilter(Status, '=%1|%2', JobQueueEntry.Status::"In Process", JobQueueEntry.Status::Ready);

//             if JobQueueEntry.FindSet then begin
//                 repeat begin
//                     if JobQueueEntry.Status = JobQueueEntry.Status::Ready then begin
//                         JobQueueEntry."Earliest Start Date/Time" := CurrentDateTime;
//                         JobQueueEntry."Starting Time" := Time;

//                         JobQueueEntry.ScheduleTask();
//                     end;
//                 end until JobQueueEntry.Next = 0;

//                 Rec.CalcFields("Total Count", "Total Posted Count");

//                 if Rec."Total Count" <> Rec."Total Posted Count" then begin
//                     if IsDialogOpen then begin
//                         DialogProgress.Update();
//                     end else begin
//                         DialogProgress.Open('Posting salaries: #1 out of #2', Rec."Total Posted Count", Rec."Total Count");
//                         IsDialogOpen := true;
//                     end;
//                     Sleep(2000);
//                     HandleDialogProgress;
//                 end else begin
//                     Message('Salaries have been posted successfully');
//                     if not Rec.Posted then begin
//                         Rec.Posted := true;
//                         Rec.Modify;
//                     end;
//                     if IsDialogOpen then begin
//                         DialogProgress.Close();
//                         IsDialogOpen := false;
//                     end;
//                 end;
//             end else begin
//                 Rec.CalcFields("Total Count", "Total Posted Count");

//                 if Rec."Total Count" <> Rec."Total Posted Count" then begin
//                     Message('Only %1 out of %2 salaries have been posted successfully. Click ''Post'' to process the remaining salary lines', Rec."Total Posted Count", Rec."Total Count");
//                 end else begin
//                     Message('Salaries have been posted successfully');
//                     if not Rec.Posted then begin
//                         Rec.Posted := true;
//                         Rec.Modify;
//                     end;
//                     if IsDialogOpen then begin
//                         DialogProgress.Close();
//                         IsDialogOpen := false;
//                     end;
//                 end;
//             end;
//         end;
//     end;

//     var
//         OpenApprovalEntriesExistForCurrUser: Boolean;
//         OpenApprovalEntriesExist: Boolean;
//         VarVariant: Variant;
//         CustomApprovals: Codeunit "Custom Approvals Codeunit";
//         DocMustbeOpen: Label 'This application request must be open';
//         DocMustbePending: Label 'This application request must be Pending';
//         TransType: Boolean;
//         AccType: Boolean;
//         AccNo: Boolean;
//         DocNo: Boolean;
//         Rmarks: Boolean;
//         Amnt: Boolean;
//         EmployerC: Boolean;
//         IncType: Boolean;
//         Pdate: Boolean;
//         SalaryLines: Record "Salary Lines P";
//         LastloanDate: Boolean;
//         DialogProgress: Dialog;
//         IsDialogOpen: Boolean;

//     local procedure SetControlAppearance()
//     begin
//         message('approvals here');
//     end;

//     // var
//     //     // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//     // begin

//     // //    OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
//     //     OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
//     // end;

//     //[Scope('OnPrem')]
//     procedure UpdateControl()
//     begin




//         if Rec.Status = Rec.Status::Open then begin
//             AccNo := true;
//             TransType := true;
//             AccType := true;
//             DocNo := true;
//             Rmarks := true;
//             Amnt := true;
//             EmployerC := true;
//             Pdate := true;
//             IncType := true;
//             LastloanDate := true;

//         end;


//         if Rec.Status = Rec.Status::Pending then begin
//             AccNo := false;
//             TransType := false;
//             AccType := false;
//             DocNo := false;
//             Rmarks := false;
//             Amnt := false;
//             EmployerC := false;
//             Pdate := false;
//             IncType := false;
//             LastloanDate := false;

//         end;


//         if Rec.Status = Rec.Status::Rejected then begin
//             AccNo := false;
//             TransType := false;
//             AccType := false;
//             DocNo := false;
//             Rmarks := false;
//             Amnt := false;
//             EmployerC := false;
//             Pdate := false;
//             IncType := false;
//             LastloanDate := false;
//         end;

//         if Rec.Status = Rec.Status::Approved then begin
//             AccNo := false;
//             TransType := false;
//             AccType := false;
//             DocNo := false;
//             Rmarks := false;
//             Amnt := false;
//             EmployerC := false;
//             Pdate := false;
//             IncType := false;
//             LastloanDate := false;

//         end;
//     end;
// }

