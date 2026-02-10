page 52185851 "Membership Closure"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Membership closure";
    PromotedActionCategories = 'Home,Process,Report,Approval,Function,Case Forwarding,EDMS,Information';
    insertAllowed = false;
    layout
    {
        area(content)
        {
            // group("Case Forwarding")
            // {
            //     Editable = Rec.Status = Rec.Status::Open;
            //     //Visible = false;
            //     field("Send/Forward to"; Rec."Send/Forward to")
            //     {

            //     }
            //     field("Originating Department"; Rec."Originating Department")
            //     {
            //         Editable = false;
            //     }
            //     field("Current Department"; Rec."Current Department")
            //     {
            //         Editable = false;
            //     }
            //     field(SLA; Rec.SLA)
            //     {
            //     }
            //     field("Previous Department"; Rec."Previous Department")
            //     {
            //         Editable = false;
            //     }
            //     field("Checked By"; Rec."Checked By")
            //     {
            //         Editable = false;
            //     }

            // }
            group(Group)
            {
                Editable = Rec.Status = Rec.Status::Open;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Notice Number"; Rec."Notice Number")
                {
                    ApplicationArea = Basic, Suite;
                    LookupPageId = "Approved Withdrawal Notice";

                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Closure Type"; Rec."Closure Type")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        SetControlAppearance;
                    end;
                }
                field("SMS Charge";rec."SMS Charge")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Closing Date"; Rec."Closing Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Activity Code';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Branch Code';
                }
                // field("Responsible Officer"; Rec."Responsible Officer")
                // {
                //     ApplicationArea = all;
                //     Editable = false;

                // }
                // field("Supervisor ID"; Rec."Supervisor ID")
                // {
                //     Editable = false;
                // }
                field("Close Account"; Rec."Close Account")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Loans Option"; Rec."Loans Option")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Bosa Loans"; Rec."Bosa Loans")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bosa Loans field.';
                }
                field("Fosa Loans"; Rec."Fosa Loans")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fosa Loans field.';
                }
                field("Business Loans"; Rec."Business Loans")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Business Loans field.';
                    Visible = false;
                }
                field("HR Loans"; Rec."HR Loans")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HR Loans field.';
                }
                field("Total Loan"; Rec."Total Loan")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Total Interest"; Rec."Total Interest")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Member Savings"; Rec."Member Savings")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Premature Charges"; Rec."Premature Charges")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Closure Charges"; Rec."Closure Charges")
                {
                    ApplicationArea = Basic, Suite;

                }

                field("Deposit Refundable"; Rec."Deposit Refundable")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                group(Partial)
                {
                    ShowCaption = false;
                    Visible = VisiblePArt;
                    field("% of Refunds"; Rec."% of Refunds")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("Partial Deposit Refundable"; Rec."Partial Deposit Refundable")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    
                }
                group("Liability Clearance Group")
                {
                    ShowCaption = false;
                    // or (Rec."Closure Type" = Rec."Closure Type"::"Withdrawal - 2nd Partial");
                    //Visible = (Rec."Closure Type" = Rec."Closure Type"::"Withdrawal - Normal");
                    field("TSC Clearance"; Rec."TSC Clearance")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the TSC Clearance field.';
                    }
                    field("TSC Clearance Account"; Rec."TSC Clearance Account")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the TSC Clearance Account field.';
                    }
                }

                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }


                field("Maturity Date"; Rec."Maturity Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = false;
                }
                field("Benevolent Fund"; Rec."Benevolent Fund")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = false;
                }
                field("Early Withdrawal"; Rec."Early Withdrawal")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    //Visible = false;
                }
                field(Updated; rec.Updated)
                {
                    ApplicationArea = Basic, Suite;
                }


            }

            part(Control18; "Account Closure Line")
            {
                Editable = (Rec."Close Account" = Rec."Close Account"::Specific) and (Rec.Status = Rec.Status::Open);
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No.");
            }
            part("Loan Closure Line"; "Loan Closure Line")
            {
                // Editable = (Rec."Close Account" = Rec."Close Account"::Specific) and (Rec.Status = Rec.Status::Open);
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No.");
            }

        }
        area(FactBoxes)
        {
            part("Approved Images"; "Member Picture & Signature")
            {
                ApplicationArea = Basic;

                Caption = 'Approved Images';
                SubPageLink = "Member No" = FIELD("Member No.");
            }
            part("Closure Verification Specimen"; "Closure Verification Specimen")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Update)
            {
                ApplicationArea = Basic, Suite;
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField(Posted, false);
                    //Rec.test
                    if Rec."Member No." = '' then Error('Kindly fill the member number');
                    rec.Validate("Notice Number");
                    rec.Updated := true;
                    Rec.Modify;
                    CurrPage.Update;
                    Message('Record updated successfully');
                end;
            }
            action("Resignation Slip")
            {
                ApplicationArea = Basic, Suite;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                Caption = 'Closure Slip';
                //RunObject = Report "Resignation Slip";
                Visible = Rec."Closure Type" = Rec."Closure Type"::"Withdrawal - Normal";

                trigger OnAction()
                begin
                    Membershipclosure.Reset;
                    Membershipclosure.SetRange(Membershipclosure."Member No.", Rec."Member No.");
                    Membershipclosure.SetRange("No.", Rec."No.");
                    if Membershipclosure.Find('-') then
                        if Membershipclosure."Closure Type" = Membershipclosure."Closure Type"::"Withdrawal - Normal" then
                            REPORT.Run(Report::"Resignation Slip", true, false, Membershipclosure);
                end;
            }
            action("Partial Resignation Slip")
            {
                ApplicationArea = Basic, Suite;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                //Visible = false;
                Visible = Rec."Closure Type" <> Rec."Closure Type"::"Withdrawal - Normal";

                trigger OnAction()
                begin
                    Membershipclosure.Reset;
                    Membershipclosure.SetRange(Membershipclosure."Member No.", Rec."Member No.");
                    Membershipclosure.SetRange("No.", Rec."No.");
                    if Membershipclosure.Find('-') then
                        if Membershipclosure."Closure Type" <> Membershipclosure."Closure Type"::"Withdrawal - Normal" then
                            REPORT.Run(Report::"Partial Closure Slip", true, false, Membershipclosure);
                end;
            }

            action("Member Statistics")
            {
                ApplicationArea = Basic, Suite;
                Image = StatisticsGroup;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Member Statistics";
                RunPageLink = "No." = FIELD("Member No.");
                trigger OnAction()
                var
                    Memb: Record Members;
                begin
                    Memb.Get(Rec."Member No.");
                    if Memb.Hide = true then begin
                        if UserSetup.Get(UserId) then begin
                            if UserSetup."Show Hidden" = false then
                                Error('You do not have permissions to view this account information.');
                        end;
                    end;
                end;
            }

            action(Post)
            {
                ApplicationArea = Basic, Suite;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    MCAcc: Record Vendor;
                    Text0005: Label 'Dear member, Your shares refund of KES ';
                    Text0006: Label ' has been credited to your FOSA account. Access via mobile banking or ATM.';
                    TotaLoan: Decimal;
                    EarlyWithrawalFee: Decimal;
                    Text000010: Label 'Early Wtihdrawal Fee';
                    CnfPosting: Label 'Sure to post the closure?';
                    ClosureMgmt: Codeunit "Membership Closure Mgmt";
                begin
                    if rec."Approved By" = UserId then
                        Message('You cannot post a document you approved');
                    Rec.TestField(Posted, false);

                    if not Confirm(CnfPosting, false) then exit;
                    Rec.TestField(Updated);
                    Rec.TestField(Status, Rec.Status::Approved);
                    Rec."Closing Date" := Today;
                    Rec.Modify;
                    ClosureMgmt.PostMemberShipClosure(Rec);
                    CurrPage.Close();
                end;
            }
            // action(CheckDocument)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = Installments;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     trigger OnAction()
            //     begin
            //         if confirm('Do you wish to check the document at your department: %1', false, Rec."Current Department")
            //         then begin
            //             rec."Checked By" := UserId;
            //             Rec."Date Time Checked" := CurrentDateTime;
            //             rec.Modify;
            //         end
            //     end;
            // }
            action("Run Generated Advice")
            {
                ApplicationArea = Basic, Suite;
                Image = Installments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    LoansProcess: Codeunit "Loans Process";
                begin
                    LoansProcess.RunSpecificConsolidatedCheckOffAdviceReport(Rec."Member No.", Rec."Date Posted", Rec."No.");
                end;
            }
            action("Reset Transaction Date")
            {
                ApplicationArea = Basic, Suite;
                Image = ChangeStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = false;

                trigger OnAction()
                begin

                    Trans.Reset;
                    Trans.SetRange(Trans.Posted, false);
                    Trans.SetRange(Trans."No.", Rec."No.");
                    if Trans.Find('-') then begin

                        Rec."Closing Date" := Today;
                        Rec.Modify;

                        Message('Transaction date updated');

                    end else
                        Error('Transaction already posted');
                end;
            }
            // action("Document Comments")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = ViewComments;
            //     Promoted = true;
            //     PromotedCategory = Category6;
            //     PromotedIsBig = true;

            //     RunObject = page "Comments List";
            //     RunPageLink = "Header No." = field("No.");
            //     RunPageView = where(Types = CONST(comment));
            //     //Visible = not rec.Posted;
            // }
            // action("Posted Doc Comments")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = ViewComments;
            //     Promoted = true;
            //     PromotedCategory = Category6;
            //     PromotedIsBig = true;

            //     RunObject = page "Comments For Posted Documents";
            //     RunPageLink = "Header No." = field("No.");
            //     RunPageView = where(Types = CONST(comment));
            //     //Visible = Rec.Posted;
            //     Visible = false;
            // }
            // action("Send Case")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = SendTo;
            //     Promoted = true;
            //     PromotedCategory = Category6;
            //     PromotedIsBig = true;
            //     // Visible = SendCaseVisible;

            //     trigger OnAction()
            //     var
            //         GFunc: Codeunit "Global Functions";
            //         DepartMent: Enum "Responsibility Center Enum";
            //         StartsWithFOSA: Boolean;
            //     begin
            //         Rec.TestField("Send/Forward to");
            //         Rec.Validate("Send/Forward to");
            //         if Rec."Send/Forward to" = Rec."Current Department" then Error('You cannot send this document to %1 while its already in %1', Rec."Send/Forward to");
            //         //Rec.TestField("Send/Forward to");
            //         ConfirmDocChecked();
            //         Comments.Reset();
            //         Comments.SetRange("Header No.", Rec."No.");
            //         if Comments.FindLast() then begin
            //             if Comments."Commented By" <> UserId then Error('Kindly leave a comment');
            //             if Comments.Comment = '' then Error('Kindly leave a comment');
            //         end else
            //             Error('Kindly add a comment');
            //         if not Confirm('Are you sure you want to send this case?') then exit;
            //         // Rec."Originator Status" := Rec."Originator Status"::Sent;
            //         // Rec."Recepient Status" := Rec."Recepient Status"::New;
            //         Rec."Previous Department" := rec."Current Department";
            //         Rec."Current Department" := Rec."Send/Forward to";

            //         // if (CurrentUsersDept <> Rec."Originating Department") and (Rec."Send/Forward to" = Rec."Originating Department") then begin
            //         //     Rec."Originator Status" := Rec."Originator Status"::Returned;
            //         //     Rec."Recepient Status" := Rec."Recepient Status"::Returned;
            //         // end;

            //         //CFPage.InsertTracker(Rec."No.", Rec."Send/Forward to", true, UserId, CurrentDateTime);
            //         InsertTranckerII(Rec."No.", Rec."Send/Forward to", true, UserId, CurrentDateTime, Rec."Previous Department", rec."Checked By");
            //         Rec.Modify();
            //         Message('Case sent successfully');
            //         Currpage.close();

            //         // Department assignment
            //         case Rec."Send/Forward to" of
            //             'BOSA':
            //                 GFunc.AssignUserTasks(DepartMent::BOSA, "Sub Module"::"Member Closure", Rec."Notice Number");
            //             'FOSA':
            //                 GFunc.AssignUserTasks(DepartMent::FOSA, "Sub Module"::"Member Closure", Rec."Notice Number");
            //             'BLOANS':
            //                 GFunc.AssignUserTasks(DepartMent::BLOANS, "Sub Module"::"Member Closure", Rec."Notice Number");
            //             'FINANCE':
            //                 GFunc.AssignDigitCustodianTask(Rec."Notice Number", Rec."Member No.", "Sub Module"::"Member Closure");
            //             else begin
            //                 StartsWithFOSA := COPYSTR(Rec."Send/Forward to", 1, 4) = 'FOSA';
            //                 if StartsWithFOSA then
            //                     GFunc.AssignUserTasks(DepartMent::FOSA, "Sub Module"::"Member Closure", Rec."Notice Number");
            //             end;
            //         end;
            //     end;
            // }

            // action("Return Case")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = SendTo;
            //     Promoted = true;
            //     PromotedCategory = Category6;
            //     PromotedIsBig = true;
            //     // Visible = SendCaseVisible;

            //     trigger OnAction()
            //     var
            //         GFunc: Codeunit "Global Functions";
            //         DepartMent: Enum "Responsibility Center Enum";
            //         StartsWithFOSA: Boolean;
            //     begin
            //         Rec."Send/Forward to" := CFPage.GetPreviousResponsibilityCenter(Rec."No.");

            //         if Rec."Send/Forward to" = Rec."Current Department" then Error('You cannot send this document to %1 while its already in %1', Rec."Send/Forward to");
            //         Comments.Reset();
            //         Comments.SetRange("Header No.", Rec."No.");
            //         if Comments.FindLast() then begin
            //             if Comments."Commented By" <> UserId then Error('Kindly leave a comment');
            //             if Comments.Comment = '' then Error('Kindly leave a comment');
            //         end else
            //             Error('Kindly add a comment');

            //         if not Confirm('Are you sure you want to return this case?') then exit;

            //         Rec."Current Department" := CFPage.GetPreviousResponsibilityCenter(Rec."No.");

            //         CFPage.InsertTracker(Rec."No.", Rec."Current Department", true, UserId, CurrentDateTime);
            //         Rec.Modify();
            //         Message('Case sent successfully');

            //         // Department assignment
            //         case Rec."Send/Forward to" of
            //             'BOSA':
            //                 GFunc.AssignUserTasks(DepartMent::BOSA, "Sub Module"::"Member Closure", Rec."Notice Number");
            //             'FOSA':
            //                 GFunc.AssignUserTasks(DepartMent::FOSA, "Sub Module"::"Member Closure", Rec."Notice Number");
            //             'BLOANS':
            //                 GFunc.AssignUserTasks(DepartMent::BLOANS, "Sub Module"::"Member Closure", Rec."Notice Number");
            //             'FINANCE':
            //                 GFunc.AssignDigitCustodianTask(Rec."Notice Number", Rec."Member No.", "Sub Module"::"Member Closure");
            //             else begin
            //                 StartsWithFOSA := COPYSTR(Rec."Send/Forward to", 1, 4) = 'FOSA';
            //                 if StartsWithFOSA then
            //                     GFunc.AssignUserTasks(DepartMent::FOSA, "Sub Module"::"Member Closure", Rec."Notice Number");
            //             end;
            //         end;
            //     end;
            // }
            // action("Case Tracker")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = History;
            //     Promoted = true;
            //     PromotedCategory = Category6;
            //     PromotedIsBig = true;

            //     RunObject = page "CF Tracker List";
            //     RunPageLink = "Header No." = field("No.");
            // }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = Job;

                // action("Assign Digit Custodian")
                // {
                //     ApplicationArea = all;
                //     Image = OrderTracking;
                //     Promoted = true;
                //     PromotedCategory = Category4;
                //     trigger OnAction()
                //     var
                //         GlobalFunctions: Codeunit "Global Functions";
                //     begin
                //         if Rec."Member No." = '' then Error('Kindly fill the member number');
                //         GlobalFunctions.AssignDigitCustodianTask(Rec."No.", Rec."Member No.", "Sub Module"::"Member Closure");
                //         CurrPage.Update();
                //         Message('Digit custodian asigned successfully!');
                //     end;
                // }
                action(AssinedUser)
                {
                    ApplicationArea = all;
                    Image = Task;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "User Tasks";
                    RunPageLink = "Record ID" = FIELD("No.");
                    Caption = 'User Assigned';
                    Visible = false;
                }
                action(Approval_)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        //ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        CustomApprovals: Codeunit "Custom Approvals Codeunit";
                        CFTracker: Record "CF Tracker";
                    begin
                        if Rec."Deposit Refundable" < 0 then
                            Error('Deposits refundable is less than zero %', Rec."Deposit Refundable");
                        // CFTracker.Reset;
                        // CFTracker.SetRange("Header No.", Rec."No.");
                        // if CFTracker.Find('-') then
                        //     Message('Document has gone through %1 deparments', CFTracker.Count)
                        // else
                        //     error('The document must go through a department before sending for approval');

                        //if rec."Current Department" <> 'FINANCE' then error('This document must be in FINANCE to be sent for approval');


                        SavingsAccounts.Reset;
                        SavingsAccounts.SetRange("Member No.", Rec."Member No.");
                        SavingsAccounts.SetRange("Loan Disbursement Account", true);
                        if not SavingsAccounts.Find('-') then
                            Error('Member does not have a Fosa/Disbursement account, Kindly create before proceeding');

                        if Rec."TSC Clearance" > 0 then
                            REc.TestField("TSC Clearance Account");

                        if Rec."Closure Type" in [Rec."Closure Type"::"Withdrawal - Normal", Rec."Closure Type"::"Withdrawal - 1st Partial"] then
                            if (Rec."Total Interest" + Rec."Total Loan") > Rec."Member Savings" then
                                Error(Txt0002);


                        Rec.TestField(Remarks);
                        Rec.TestField("Closure Type");

                        //TODO -Add to setup
                        // if Rec."Current Department" <> 'SFO' then
                        //     error('You must case via case forwarding to SFO before sending for approval');


                        if Rec.Status <> Rec.Status::Open then
                            Error(DocMustbeOpen);
                        VarVariant := Rec;


                        if Confirm('Are you sure you want to send this document for approval?') then begin
                            if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                                CustomApprovals.OnSendDocForApproval(VarVariant);
                        end else
                            Message('Process aborted!');

                        if Rec."Deposit Refundable" = 0 then Error('Deposits refundable must have a value');
                        Currpage.close;
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        if Rec.Status <> Rec.Status::Pending then
                            Error(DocMustbePending);

                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action("Re-Open Document")
                {
                    ApplicationArea = Basic, Suite;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if Rec.Posted then Error('Document Already Posted');
                        if (Rec.Status = Rec.Status::Rejected) or (Rec.Status = Rec.Status::Approved) or (Rec.Status = Rec.Status::Pending) then begin
                            if Confirm('Are you sure you want to re-open the document?', false) = true then begin
                                Rec.Status := Rec.Status::Open;
                                Rec.Modify;
                                CurrPage.Update(true);
                            end;
                        end;
                    end;
                }

            }

            group("EDMS Integration")
            {
                action("Import")
                {
                    ApplicationArea = All;
                    Caption = 'Import File';
                    Promoted = true;
                    PromotedCategory = Category7;
                    Image = Import;
                    visible = false;

                    trigger OnAction()
                    var
                        Base64Convert: Codeunit "Base64 Convert";
                        TempBlob: Codeunit "Temp Blob";
                        InStr: InStream;

                        EDMSFunctions: Codeunit "EDMS Functions";
                        FileName: Text;
                        FileContentsB64: Text;

                        IDNumber: Text;
                        ApplicationType: Label 'MW'; // Member Withdrawal
                        PFNumber: Text;
                    begin
                        if Rec."Notice Number" <> '' then begin
                            FileName := EDMSFunctions.PickEDMSFile(TempBlob);

                            TempBlob.CreateInStream(InStr);
                            FileContentsB64 := Base64Convert.ToBase64(InStr);

                            if FileContentsB64 <> '' then begin
                                UploadToEDMS(Rec, FileName, FileContentsB64);
                            end;
                        end else begin
                            Error('Application No. is required for EDMS document upload');
                        end;
                    end;
                }
                action("EDMS File List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = Category7;
                    Visible = false;

                    RunObject = page "EDMS Files List";
                    RunPageLink = "Application No." = field("Notice Number");
                    // RunPageMode = Create;
                }
                action("Loans Guaranteed")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = Category8;

                    RunObject = page "Loan Guarantors and Security";
                    RunPageLink = "Member No" = field("Member No.");
                    RunPageView = where("Outstanding Balance" = filter(> 0));
                    // RunPageMode = Create;
                }

                action("View Signatory Specimen")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Category8;
                    trigger OnAction()
                    var
                        FilePath: Text;
                        InstReam: InStream;
                        Cust: Record Customer;

                    begin
                        if Members.Get(Rec."Member No.") then begin
                            Cust.SetRange("No.", Members."Employer Code");
                            Page.Run(52186649, Cust);
                        end;
                    end;
                }
                action("MemberStatistics")
                {
                    ApplicationArea = Basic, Suite;
                    Image = StatisticsDocument;
                    Promoted = true;
                    PromotedCategory = Category8;
                    RunObject = Page "Member Statistics";
                    RunPageLink = "No." = FIELD("Member No.");
                    //Enabled = not HideAccount;


                    trigger OnAction()
                    begin
                        // if Rec.Hide = true then begin
                        //     if UserSetup.Get(UserId) then begin
                        //         if UserSetup."Show Hidden" = false then
                        //             Error('You do not have permissions to view this account information.');
                        //     end;
                    end;
                    // end;

                }
            }
        }
        area(Navigation)
        {
            action(Comments)
            {
                ApplicationArea = Basic, Suite;
                Image = ViewComments;
                Promoted = true;
                Caption = 'Comment';
                PromotedCategory = Category4;
                RunObject = page "Comments List";
                RunPageLink = "Header No." = field("No.");
                RunPageView = where(Types = CONST(comment));
            }
            action(ArchiveDocument)
            {
                ApplicationArea = Basic, Suite;
                Image = Archive;
                Promoted = true;
                Caption = 'Cancel/Archive';
                PromotedCategory = Category4;
                trigger OnAction()
                var
                    Withdnotice: page "Member withdrawal Notice";
                begin
                    if Confirm('Are you sure you want to archive this document?') then begin
                        rec.TestField(posted, false);
                        rec.validate(Status, Rec.Status::Cancelled);
                        Rec.Modify;
                        CurrPage.Update(true);
                        Withdnotice.RevertPreviousSubflag(rec."Member No.");
                        CurrPage.close;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec.Posted = true then
            CurrPage.Editable := false;
        SetControlAppearance;
        //DigitCustodianControl();
    end;

    trigger OnOpenPage()
    begin
        if (Rec.Status = Rec.Status::Approved) or (Rec.Status = Rec.Status::Pending) then
            CurrPage.Editable := false;
        SetControlAppearance;
        DefinedSLA."Origination Type" := DefinedSLA."Origination Type"::"Membership Withdrawal";
        Rec.SLA := DefinedSLA.SLA;

        //DigitCustodianControl();

        // if Rec."Member No." <> '' then begin
        //     rec.Validate("Member No.");
        //     Rec.Modify;
        // end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        //DigitCustodianControl();
        MinSharePopup;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        MinSharePopup;
    end;


    procedure UploadToEDMS(Rec: Record "Membership Closure"; FileName: Text; FileContentsB64: Text)
    var
        EDMSFunctions: Codeunit "EDMS Functions";

        ApplicantMember: Record Members;

        IDNumber: Text;
        ApplicationType: Label 'MW'; // Member Withdrawal
        PFNumber: Text;
    begin
        ApplicantMember.Reset;

        ApplicantMember.SetRange("No.", Rec."Member No.");

        if ApplicantMember.FindFirst then begin
            if ApplicantMember."Primary Identification Type" = ApplicantMember."Primary Identification Type"::"ID Number" then begin
                IDNumber := ApplicantMember."Primary Identification";
            end else
                if ApplicantMember."Secondary Identification Type" = ApplicantMember."Secondary Identification Type"::"ID Number" then begin
                    IDNumber := ApplicantMember."Secondary Identification";
                end else begin
                    IDNumber := ApplicantMember."Primary Identification";
                end;

            if ApplicantMember."Payroll/Staff No." <> '' then begin
                PFNumber := ApplicantMember."Payroll/Staff No.";
            end else begin
                PFNumber := ApplicantMember."No.";
            end;

            EDMSFunctions.EDMSMemberFileUpload(
                IDNumber,
                ApplicantMember.Name,
                ApplicationType,
                PfNumber,
                ApplicantMember."No.",
                Rec."Notice Number",
                FileName,
                FileContentsB64
            );
        end;
    end;

    procedure InsertTranckerII(HeaderNo: Code[30]; AtDept: Code[30]; IsCurrDept: Boolean; ForwardedBy: Code[100]; TimeForwarded: DateTime; PrevDept: code[30]; CheckedBy: code[50])
    begin
        CaseTracker.Reset();
        CaseTracker.SetRange("Header No.", HeaderNo);
        if CaseTracker.FindLast() then begin
            CaseTracker."Current Department" := false;
            CaseTracker.Modify();
        end;

        Clear(CaseTracker);

        CaseTracker.Init();
        CaseTracker."Header No." := HeaderNo;
        CaseTracker."At Department" := AtDept;
        CaseTracker."Current Department" := IsCurrDept;
        CaseTracker."Forwarded By" := ForwardedBy;
        CaseTracker."Time Forwarded" := TimeForwarded;
        CaseTracker."Previous Departmant" := PrevDept;
        CaseTracker."Checked By" := CheckedBy;
        CaseTracker.Insert(true);
    end;

    var
        DefinedSLA: record "Defined SLA";
        CaseTracker: Record "CF Tracker";
        CFPage: Page "DMU CF Page";
        CFStations: Record "CF Station Actions";
        Comments: Record Comments;

        ErrTxt0000: Label 'Account already Posted';
        ErrTxt0001: Label 'Account cannot be closed, insufficient funds';
        ErrTxt0002: Label 'The request must be approved';
        Trans: Record "Membership closure";
        Members: Record Members;
        ConfmTxt0003: Label 'Are you sure you want to recover the loans from the members shares?';
        GeneralSetUp: Record "General Set-Up";
        BankingUserTemplate: Record "Banking User Template";
        Jtemplate: Code[20];
        JBatch: Code[20];
        Totalrecovered: Decimal;
        TotalSaving: Decimal;
        AvailableSharesd: Decimal;
        Funeral: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        ClosureAccounts: Record "Account Closure Line";
        ClosureAccountsII: Record "Account Closure Line";
        AvailableShares: Decimal;
        JournalPosting: Codeunit "Journal Posting";
        ProdutFactory: Record "Product Factory";
        AcctType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Types";
        AccNo: Code[10];
        BalAccNo: Code[10];
        Amt: Decimal;
        LineNo: Integer;
        Txt0004: Label 'Member closure';
        SavingsAccounts: Record "Savings Accounts";
        Loans: Record Loans;
        RecoverLoan: Boolean;
        Interest: Decimal;
        LRepayment: Decimal;
        Txt0005: Label 'Interest Recovery from deposits';
        Txt0006: Label 'Principle Recovery from deposits';
        Txt0007: Label 'Member Withdrawal Account No';
        Txt0008: Label 'Funeral Expenses';
        // CustomApprovals: Codeunit "Custom Approvals Codeunit";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        DocMustbeOpen: Label 'This application request must be open';
        DocMustbePending: Label 'This application request must be Pending';
        Txt0000: Label 'Checkoff has been posted';
        MemberwithdrawalNotice: Record "Member withdrawal Notice";
        TCharges: Decimal;
        ChargeAmount: Decimal;
        TransactionTypes: Record "Transaction Types";
        Txt0001: Label 'Excise Duty';
        Membershipclosure: Record "Membership closure";
        Txt0002: Label 'Member cannot close the account before clearing the loans';
        UserSetup: Record "User Setup";
        Dim1: Code[10];
        Dim2: Code[10];
        Txt0009: Label 'Withdrawal Fee';
        AccountClosureFee: Decimal;
        Txt0010: Label 'Account Closure Fee';
        "-": Integer;
        TransactionCharges: Record "Transaction Charges";
        TariffDetails: Record "Tiered Charges Lines";
        Amount: array[2] of Decimal;
        SavingsAccounts2: Record "Savings Accounts";
        ShareCapAmount: Decimal;
        Txt0011: Label 'Share Capital Reovery';
        RegistrationFee: Decimal;
        Txt0012: Label 'Registration Fee Recovery';
        PeriodicAcc: Codeunit "Periodic Activities";
        LoansProcess: Codeunit "Loans Process";
        SinkFund: Decimal;
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        Txt0013: Label 'Closure Line does not belong to this member';
        EOFAccountClosure: Boolean;
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book",Internetbanking,CRM,"Member Withdrawal";
        SendSms: Codeunit SendSms;
        NetAmount: Decimal;
        ClearBills: Decimal;
        Txt0014: Label 'Bills Cleared on Accounts Closure';
        AccLine: Record "Account Closure Line";
        GenSetup: Record "General Set-Up";
        ProductFactory: Record "Product Factory";
        LoanTotal: Decimal;
        IntTotal: Decimal;
        BBF: Decimal;
        Loans2: Record Loans;
        LoanGuar: Record "Loan Guarantors and Security";
        ProductType: Text;
        AppAmount: Decimal;
        CompInfo: Record "Company Information";
        VisiblePArt: Boolean;
        Source: Enum "SMS Source";
        msg: Text;


    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);

        if Rec."Closure Type" in [Rec."Closure Type"::"Withdrawal - 1st Partial",
        Rec."Closure Type"::"Withdrawal - 2nd Partial"] then
            VisiblePArt := true
        else
            VisiblePArt := false;

        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false;
    end;

    procedure DigitCustodianControl()
    var
        DigitCustodian: Record "Digit Custodian Setup";
    begin
        //Only run this script when its at finance
        DigitCustodian.Reset();
        DigitCustodian.SetRange("Responsible Officer Code", UserId);
        if DigitCustodian.FindFirst() then begin

            Rec.CalcFields("Responsible Officer");
            if UserId <> Rec."Responsible Officer" then
                CurrPage.Editable := false
            else
                CurrPage.Editable := true;
        end;

    end;

    procedure ConfirmDocChecked()
    var
        UsetUp: record "User Setup";
    begin
        if rec."Checked By" <> '' then begin
            UsetUp.get(Rec."Checked By");
            if not (Rec."Current Department" = UsetUp."Responsibility Centre") then
                error('The document must be checked by a member of the current department before forwarding');
        end
        else
            Error('This document must be checked in the current department before forwarding');
    end;


    local procedure GetPrematureCharge() TCharges: Decimal
    var
        TransactionTypes: Record "Transaction Types";
        TransactionCharges: Record "Transaction Charges";
        TariffDetails: Record "Tiered Charges Lines";
        ChargeAmount: Decimal;
        GeneralSetUp: Record "General Set-Up";
    begin
        //*********************Premature Withdrawal
        GeneralSetUp.Get;
        TCharges := 0;
        SavingsAccounts.Reset;
        SavingsAccounts.SetRange("Member No.", Rec."Member No.");
        SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
        if SavingsAccounts.Find('-') then begin
            SavingsAccounts.CalcFields("Balance (LCY)");
        end;
        MemberwithdrawalNotice.Reset;
        MemberwithdrawalNotice.SetRange(MemberwithdrawalNotice."Member No.", Rec."Member No.");
        MemberwithdrawalNotice.SetRange(MemberwithdrawalNotice.Status, MemberwithdrawalNotice.Status::Approved);
        if MemberwithdrawalNotice.Find('+') then begin
            if MemberwithdrawalNotice."Maturity Date" > Rec."Closing Date" then begin
                TransactionTypes.Reset;
                TransactionTypes.SetRange(TransactionTypes.Type, TransactionTypes.Type::"Member Withdrawal");
                TransactionTypes.SetRange(Code, GeneralSetUp."Withdrawal Notice Penalty");
                if TransactionTypes.Find('-') then begin

                    //Charges
                    //TCharges:=0;
                    //MESSAGE('%1',TransactionTypes.Code);
                    TransactionCharges.Reset;
                    TransactionCharges.SetRange(TransactionCharges."Transaction Type", TransactionTypes.Code);
                    if TransactionCharges.Find('-') then begin
                        repeat
                            //MESSAGE('i');
                            ChargeAmount := 0;
                            if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::"% of Amount" = true then
                                ChargeAmount := (SavingsAccounts."Balance (LCY)" * TransactionCharges."Percentage of Amount") * 0.01
                            else
                                ChargeAmount := TransactionCharges."Charge Amount";

                            if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::Staggered then begin

                                TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                                TariffDetails.Reset;
                                TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                if TariffDetails.Find('-') then begin
                                    repeat
                                        if (SavingsAccounts."Balance (LCY)" >= TariffDetails."Lower Limit") and (SavingsAccounts."Balance (LCY)" <= TariffDetails."Upper Limit") then begin
                                            if TariffDetails."Use Percentage" = true then begin
                                                ChargeAmount := SavingsAccounts."Balance (LCY)" * TariffDetails.Percentage * 0.01;
                                            end else begin
                                                ChargeAmount := TariffDetails."Charge Amount"
                                            end;
                                        end;
                                    until TariffDetails.Next = 0;
                                end;
                            end;
                            /*
                            LineNo:=LineNo+10000;
                            AcctType:=AcctType::Savings;
                            TransType:=TransType::" ";

                            JournalPosting.PostJournal(Jtemplate,JBatch,LineNo,AcctType,"No.",
                            TransactionCharges.Description+ClosureAccounts."No.",ChargeAmount,SavingsAccounts."No.","Closing Date",BalAccType,
                            TransactionCharges."G/L Account",'',Dim1,Dim2,TransType,'','','',0,'',0);
                            */

                            //IF NOT TransactionCharges."Transaction Charge Category" THEN  BEGIN

                            if TransactionCharges."Transaction Charge Category" <> TransactionCharges."Transaction Charge Category"::"Stamp Duty" then begin
                                //Excise Duty

                                /*LineNo:=LineNo+10000;
                                AcctType:=AcctType::Savings;
                                TransType:=TransType::" ";

                                JournalPosting.PostJournal(Jtemplate,JBatch,LineNo,AcctType,"No.",
                                Txt0001+ClosureAccounts."No.",(ChargeAmount*GeneralSetUp."Excise Duty (%)")*0.01,SavingsAccounts."No.","Closing Date",BalAccType,
                                GeneralSetUp."Excise Duty G/L",'',Dim1,Dim2,TransType,'','','',0,'',0);*/

                                TCharges := (ChargeAmount * GeneralSetUp."Excise Duty (%)" * 0.01) + ChargeAmount + TCharges;

                            end;

                        until TransactionCharges.Next = 0;
                    end;
                end;

            end;
        end else begin
            //Charges

            TransactionTypes.Reset;
            TransactionTypes.SetRange(TransactionTypes.Type, TransactionTypes.Type::"Member Withdrawal");
            TransactionTypes.SetRange(Code, GeneralSetUp."Withdrawal Notice Penalty");
            if TransactionTypes.Find('-') then begin

            end;
            TCharges := 0;
            TransactionCharges.Reset;
            TransactionCharges.SetRange(TransactionCharges."Transaction Type", TransactionTypes.Code);

            if TransactionCharges.Find('-') then begin
                repeat

                    ChargeAmount := 0;
                    if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::"% of Amount" = true then
                        ChargeAmount := (SavingsAccounts."Balance (LCY)" * TransactionCharges."Percentage of Amount") * 0.01
                    else
                        ChargeAmount := TransactionCharges."Charge Amount";

                    if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::Staggered then begin

                        TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                        TariffDetails.Reset;
                        TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                        if TariffDetails.Find('-') then begin
                            repeat
                                if (SavingsAccounts."Balance (LCY)" >= TariffDetails."Lower Limit") and (SavingsAccounts."Balance (LCY)" <= TariffDetails."Upper Limit") then begin
                                    if TariffDetails."Use Percentage" = true then begin
                                        ChargeAmount := SavingsAccounts."Balance (LCY)" * TariffDetails.Percentage * 0.01;
                                    end else begin
                                        ChargeAmount := TariffDetails."Charge Amount"
                                    end;
                                end;
                            until TariffDetails.Next = 0;
                        end;
                    end;

                    /*LineNo:=LineNo+10000;
                    AcctType:=AcctType::Savings;
                    TransType:=TransType::" ";

                    JournalPosting.PostJournal(Jtemplate,JBatch,LineNo,AcctType,"No.",
                    TransactionCharges.Description+ClosureAccounts."No.",ChargeAmount,SavingsAccounts."No.","Closing Date",BalAccType,
                    TransactionCharges."G/L Account",'',Dim1,Dim2,TransType,'','','',0,'',0);*/


                    //IF NOT TransactionCharges."Transaction Charge Category" THEN  BEGIN

                    if TransactionCharges."Transaction Charge Category" <> TransactionCharges."Transaction Charge Category"::"Stamp Duty" then begin
                        //Excise Duty

                        /*LineNo:=LineNo+10000;
                        AcctType:=AcctType::Savings;
                        TransType:=TransType::" ";

                        JournalPosting.PostJournal(Jtemplate,JBatch,LineNo,AcctType,"No.",
                        Txt0001+ClosureAccounts."No.",(ChargeAmount*GeneralSetUp."Excise Duty (%)")*0.01,SavingsAccounts."No.","Closing Date",BalAccType,
                        GeneralSetUp."Excise Duty G/L",'',Dim1,Dim2,TransType,'','','',0,'',0);*/

                        TCharges := TCharges + ChargeAmount + (ChargeAmount * GeneralSetUp."Excise Duty (%)" * 0.01);
                    end;
                until TransactionCharges.Next = 0;
            end;
        end;
        //^^
    end;

    procedure MinSharePopup(): text
    var
        SavAcc: Record "Savings Accounts";
        MemCategory: record "Member Classes";
        RegnProcess: codeunit "Registration Process";
        MonthDiff: Integer;
        PeriodRange: DateFormula;
    begin
        if Members.get(Rec."Member No.") then begin
            SavAcc.reset;
            SavAcc.SetRange("Member No.", Rec."Member No.");
            SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Share Capital");
            if SavAcc.FindFirst() then begin
                SavAcc.CalcFields("Balance (LCY)");
                MemCategory.Get(Members."Member Class");
                if SavAcc."Balance (LCY)" < MemCategory."Share Capital" then
                    Message('The member has not met the minimum share capital requirement of %1. Current Balance is :%2', MemCategory."Share Capital", SavAcc."Balance (LCY)");
            end;

            MonthDiff := DATE2DMY(Today, 2) - DATE2DMY((CalcDate('-CY', Today)), 2);
            if MonthDiff <= 0 then MonthDiff := 1;
            Evaluate(PeriodRange, ('<' + Format(MonthDiff) + 'M>'));

            if RegnProcess.CalculateSavingArrears(Rec."Member No.", '5', PeriodRange, Today) > 0 then
                Message('The member has Risk arrears of %1', RegnProcess.CalculateSavingArrears(Rec."Member No.", '5', PeriodRange, Today));
            if RegnProcess.CalculateSavingArrears(Rec."Member No.", '4', PeriodRange, Today) > 0 then
                Message('The member has BBF arrears of %1', RegnProcess.CalculateSavingArrears(Rec."Member No.", '4', PeriodRange, Today));
        end;

    end;

}

