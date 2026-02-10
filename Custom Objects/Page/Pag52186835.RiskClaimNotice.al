page 52186835 "Risk Claim Notice"
{
    Caption = 'Deceased Member Notice';
    DeleteAllowed = false;
    //InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approvals,Information,Case Forwarding,CRM Actions,EDMS';
    SourceTable = "SinkFund Report Information";
    //SourceTableView = where("Claim Type" = filter(" " | "Risk Claim"));

    layout
    {
        area(content)
        {
            // group("Case Forwarding")
            // {
            //     field("Send/Forward to"; Rec."Send/Forward to")
            //     {

            //     }
            //     field("Originating Department"; Rec."Originating Department")
            //     {
            //         Editable = false;
            //     }
            //     field("Current Departmrnt"; Rec."Current Department")
            //     {
            //         Editable = false;
            //     }

            // }
            // group(CRM)
            // {
            //     Caption = 'CRM Information';
            //     field("CRM Application No."; Rec."CRM Application No.")
            //     {
            //         Editable = false;
            //     }
            //     field("CRM Created By"; Rec."CRM Created By")
            //     {
            //         Editable = false;
            //     }
            //     field("CRM Originating Branch"; Rec."CRM Originating Branch")
            //     {
            //         Editable = false;
            //     }
            //     field("CRM Notes"; Rec."CRM Notes")
            //     {
            //         Editable = false;
            //         MultiLine = true;
            //     }
            // }

            group(General)
            {
                Editable = Rec.Status = Rec.Status::Open;
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Claim Type"; Rec."Claim Type")
                // {
                //     ValuesAllowed = " ", "Risk Claim";
                //     trigger OnValidate()
                //     begin
                //         SetControlAppearance();
                //     end;
                // }
                field("Notice Type"; Rec."Notice Type")
                {
                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }
                field("Date of Death"; Rec."Date of Death")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = DateEditable;
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibily Center"; Rec."Responsibily Center")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("BBF Claim Amount"; Rec."BBF Claim Amount")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("Document Stage"; Rec."Document Stage")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Document Stage field.';
                // }

                field(Posted; Rec.Posted)
                {
                    Editable = false;
                }

                field("Account Closure Date"; Rec."Account Closure Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account Closure Date field.';
                }

            }
            group("Reported By")
            {
                Editable = Rec.Status = Rec.Status::Open;
                Visible = ReportedByVisible;

                field("Reported By ID No"; Rec."Reported By ID No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reported By Name"; Rec."Reported By Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reported By Relationship"; Rec."Reported By Relationship")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reported By Phone No"; Rec."Reported By Phone No")
                {
                    ApplicationArea = Basic, Suite;
                }
            }

            group("Balances & Liabilites")
            {
                Visible = BalancesVisible;
                Editable = Rec.Status = Rec.Status::Open;

                field("BOSA Savings"; Rec."BOSA Savings")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BOSA Savings field.';
                    Visible = false;
                }
                field("FOSA Savings"; Rec."FOSA Savings")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FOSA Savings field.';
                    Visible = false;
                }
                field("Total Assets"; Rec."Total Savings")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("BOSA Loans"; Rec."BOSA Loans")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BOSA Loans field.';
                }
                field("FOSA Loans"; Rec."FOSA Loans")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FOSA Loans field.';
                }
                // field("Business Loans"; Rec."Business Loans")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Business Loans field.';
                // }
                field("HR Loans"; Rec."HR Loans")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HR Loans field.';
                }
                field("Total Liablities"; Rec."Total Loans")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Net Effects"; Rec."Net Effects")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                // field("Receipt Document Number"; Rec."Receipt Document Number")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Receipt Document Number field.';
                //     LookupPageId = "Posted Receipt List";
                // }
                // field("Receipt Amount"; Rec."Receipt Amount")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Receipt Amount field.';
                // }
                // field("Total Amount Allocated"; Rec."Total Amount Allocated")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Total Amount Allocated field.';
                // }
                // field("Account Closure Fee"; Rec."Account Closure Fee")
                // {
                // }
                field("Available Beneficiary Amount"; Rec."Available Beneficiary Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Available Beneficiary Amount field.';
                }
                field("Burial Permit Number"; Rec."Burial Permit Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Burial Permit Number field.';
                }
            }
            part("BBF Claims Lines"; "BBF Claims Lines")
            {
                //Editable = Rec.Status = Rec.Status::Open;
                Editable = false;
                ApplicationArea = Basic, Suite;
                Visible = LinesPageVisible;
                SubPageLink = "Header No." = FIELD(No);
            }
            group("External Payment")
            {
                Visible = LinesPageVisible and CanProcessRiskClaims and NomineeRequestFormDispatched;
                Enabled = LinesPageVisible and CanProcessRiskClaims and NomineeRequestFormDispatched;
                Editable = (Rec."Document Stage" = Rec."Document Stage"::"Account Closed") and
                (Rec.Status = Rec.Status::Approved);

                field("Pay Externally"; Rec."Pay Externally")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pay Externally field.';
                }
                field("External Amount Allocated"; Rec."External Amount Allocated")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the External Amount Allocated field.';
                }
                /* field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account Type field.';
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account No. field.';
                } */
            }
            part("Risk External Payment"; "Risk External Payment")
            {
                Visible = LinesPageVisible and CanProcessRiskClaims and NomineeRequestFormDispatched;
                Enabled = LinesPageVisible and CanProcessRiskClaims and NomineeRequestFormDispatched;
                Editable = (Rec."Document Stage" = Rec."Document Stage"::"Account Closed") and
                (Rec.Status = Rec.Status::Approved);
                SubPageLink = "Risk Claim No." = FIELD(No);
            }
            group("Risk Next of Kin Payment Summary")
            {
                Visible = LinesPageVisible and CanProcessRiskClaims and NomineeRequestFormDispatched;
                Enabled = LinesPageVisible and CanProcessRiskClaims and NomineeRequestFormDispatched;

                field("No Next of Kin Accounts"; Rec."No. Next of Kin Accounts")
                {
                    ApplicationArea = All;
                    Caption = 'No of Next of Kin Nominee Accounts';
                    ToolTip = 'Specifies the value of the No Next of Kin Accounts field.';
                }
                field("No Next of Kin Payments"; Rec."No. Next of Kin Payments")
                {
                    ApplicationArea = All;
                    Caption = 'No of Next of Kin Nominee Accounts to be Paid';

                    ToolTip = 'Specifies the value of the No Next of Kin Payments field.';
                }
                field("No Next of Kin Paid Accounts"; Rec."No. Next of Kin Paid Accounts")
                {
                    ApplicationArea = All;
                    Caption = 'No of Next of Kin Nominee Accounts Paid';
                    ToolTip = 'Specifies the value of the No Next of Kin Paid Accounts field.';
                }
                field("Partially Posted"; Rec."Partially Posted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Partially Posted field.';
                }
            }
            part("NextofKin Payment Allocation"; "NextofKin Payment Allocation")
            {
                Editable = (Rec."Document Stage" = Rec."Document Stage"::"Account Closed") or (Rec."Partially Posted");
                ApplicationArea = Basic, Suite;
                Visible = LinesPageVisible and CanProcessRiskClaims and NomineeRequestFormDispatched;
                Enabled = LinesPageVisible and CanProcessRiskClaims and NomineeRequestFormDispatched;
                SubPageLink = "Header No." = FIELD(No);
            }
            group("Deceased Information")
            {
                // Visible = false;
                Visible = DeceasedInformationVisible;
                Editable = Rec.Status = Rec.Status::Open;
                field("Next of KIN"; Rec."Next of KIN")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("NOK Name"; Rec."NOK Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Relationship; Rec.Relationship)
                {
                    ApplicationArea = Basic, Suite;
                }
            }

        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ErrorNextOfKin: Label 'Kindly select at least one next of kin beneficiary for payment!';
                        Selected: Integer;
                        Text000: Label 'Select,Close Account,Post Payment';
                        ErrSelect: Label 'Select an option to proceed';
                        ErrAccClosed: Label 'The account has already been closed!';
                        Text001: Label 'Choose an option to proceed';
                        RiskExternalPmt: Record "Risk External Payment";
                        SuccessfullyPosted: Boolean;
                        loanguar: Record "Loan Guarantors and Security";
                    begin

                        // Selected := Dialog.StrMenu(Text000, 1, Text001);
                        // if Selected = 1 then Error(ErrSelect);

                        // if Selected = 2 then begin
                        //     if Rec."Document Stage" = Rec."Document Stage"::"Account Closed" then
                        //         Error(ErrAccClosed);
                        //     if Rec."Document Stage" <> Rec."Document Stage"::" " then
                        //         Error('The document has already been posted');
                        // end;

                        // if Selected = 3 then
                        //     Rec.TestField(Rec."Document Stage", Rec."Document Stage"::"Account Closed");

                        Rec.TestField(Posted, false);
                        Rec.TestField(Rec.Status, Rec.Status::Approved);

                        // if (Rec."Claim Type" = Rec."Claim Type"::"Risk Claim") and (not Rec."Pay Externally") and (Selected = 3) then begin
                        //     Rec.CalcFields("No. Next of Kin Accounts", "No. Next of Kin Paid Accounts", "No. Next of Kin Payments");
                        //     if Rec."No. Next of Kin Paid Accounts" > 0 then
                        //         if Rec."No. Next of Kin Payments" <= Rec."No. Next of Kin Paid Accounts" then
                        //             Error(ErrorNextOfKin);
                        // end;

                        // if Rec."Pay Externally" then begin
                        //     RiskExternalPmt.Reset();
                        //     RiskExternalPmt.SetRange("Risk Claim No.", Rec.No);
                        //     if riskExternalPmt.FindSet() then
                        //         repeat
                        //             //     RiskExternalPmt.TestField("Account Type");
                        //             RiskExternalPmt.TestField("Account No.");
                        //             RiskExternalPmt.TestField(Amount);
                        //             RiskExternalPmt.TestField(Description);

                        //             if RiskExternalPmt."Pay Mode" = RiskExternalPmt."Pay Mode"::"Cheque" then
                        //                 RiskExternalPmt.TestField("Cheque No.");

                        //         until RiskExternalPmt.Next = 0;

                        //     Rec.CalcFields("External Amount Allocated");
                        //     if Rec."External Amount Allocated" < Rec."Available Beneficiary Amount" then
                        //         Error('External payment amount is less than the available beneficiary amount');
                        // end;

                        // SuccessfullyPosted := Rec.PostClaim();

                        // if SuccessfullyPosted then begin
                        if Rec."Notice Type" = Rec."Notice Type"::"Next of Kin" then begin
                            NextofKIN.Reset();
                            NextofKIN.SetRange("Record ID", Rec."Member No");
                            NextofKIN.SetRange(Identification, Rec."Next of KIN");
                            if NextofKIN.FindFirst() then begin
                                NextofKIN.Deceased := true;
                                NextofKIN.Modify();
                            end;
                        end;

                        Members.Get(Rec."Member No");
                        if (Rec."Notice Type" = Rec."Notice Type"::"Principal Member") then begin
                            Members.Subflag := Members.Subflag::"Pending Insurance Claim";
                            //Members.Validate(Status, Members.Status::Deceased);
                            Members.Status := Members.Status::Deceased;
                            Members.Validate(Status);
                            Members.Modify();

                            SavingsAccount.Reset();
                            SavingsAccount.SetRange("Member No.", Rec."Member No");
                            if SavingsAccount.FindSet() then
                                repeat
                                    SavingsAccount.Status := SavingsAccount.Status::Deceased;
                                    SavingsAccount.Modify();
                                until SavingsAccount.Next = 0;

                            // loanguar.Reset();
                            // loanguar.SetRange("Member No.", Rec."Member No");
                            // if loanguar.FindSet() then
                            //     repeat
                            //         loanguar.Status := loanguar.Status::Deceased;
                            //         loanguar.Modify();
                            //     until loanguar.Next = 0;

                        end;
                        Rec.Posted := true;
                        Rec."Document Stage" := Rec."Document Stage"::Posted;
                        Rec."Date Posted" := Today;
                        rec."Time Posted" := Time;
                        // if Selected = 3 then
                        //     if Rec."Claim Type" = Rec."Claim Type"::"Risk Claim" then begin
                        //         if not Rec."Pay Externally" then begin
                        //             Rec.CalcFields("No. Next of Kin Accounts", "No. Next of Kin Paid Accounts", "No. Next of Kin Payments");
                        //             if Rec."No. Next of Kin Payments" <> Rec."No. Next of Kin Accounts" then begin
                        //                 Rec.Posted := false;
                        //                 Rec."Partially Posted" := true;
                        //                 Rec."Document Stage" := Rec."Document Stage"::"Partially Posted";
                        //             end else begin
                        //                 Members.Subflag := Members.Subflag::"Pending Share Capital Transfer";
                        //                 Members.Status := Members.Status::Deceased;
                        //                 Members.Modify();
                        //             end;
                        //         end else begin
                        //             Rec."Document Stage" := Rec."Document Stage"::"Externally Paid";
                        //         end;
                        //     end;

                        // if Selected = 2 then begin
                        //     Rec.Posted := false;
                        //     Rec."Document Stage" := Rec."Document Stage"::"Account Closed";
                        // Rec."Account Closure Date" := Today;
                        // Members.Subflag := Members.Subflag::"Pending Share Capital Transfer";
                        // Members.Status := Members.Status::Deceased;
                        // Members.Modify();
                        // end;

                        Rec.Modify();
                        Message('Member notice has been posted successfully');

                        // if Rec."Claim Type" = Rec."Claim Type"::"Risk Claim" then
                        //     Message('Risk Claim has been posted successfully')
                        // else
                        //     Message('BBF Claim posted successfully');
                        // end;
                    end;

                }

            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        CustomApprovals: Codeunit "Custom Approvals Codeunit";
                        NextofKinPmtAlloc: Record "NextofKin Payment Allocation";
                        RiskExternalPmt: Record "Risk External Payment";
                        BBFClaimLines: Record "BBF Claim Lines";
                        ErrorNoAccountMarked: Label 'Kindly mark at least one payment line for next of kin payment!';
                        Member: Record Members;
                    begin
                        // Rec.TestField("Claim Type");
                        Rec.TestField("Member No");
                        // Rec.OnFillClaimType();
                        Member.Get(Rec."Member No");
                        // Member.TestField(Subflag, Member.Subflag::"Pending Risk Claim");
                        // Member.TestField(Status, Member.Status::Deceased);
                        //Rec.TestField("Reported By ID No");
                        Rec.TestField(Posted, false);
                        // Rec.TestField("Sent Back to CRM", false);
                        Rec.TestField(Rec.Status, Rec.Status::Open);

                        // BBFClaimLines.Reset();
                        // BBFClaimLines.SetRange("Header No.", Rec.No);
                        // BBFClaimLines.SetRange("Product Class Type", BBFClaimLines."Product Class Type"::Loan);
                        // if BBFClaimLines.FindSet() then
                        //     repeat
                        //         BBFClaimLines.TestField("Amount Allocated");
                        //     until BBFClaimLines.Next() = 0;

                        // if Rec."Document Stage" = Rec."Document Stage"::"Account Closed" then begin
                        //     if not Rec."Pay Externally" then begin
                        //         NextofKinPmtAlloc.Reset();
                        //         NextofKinPmtAlloc.SetRange("Header No.", Rec.No);
                        //         NextofKinPmtAlloc.SetFilter("Beneficiary Amount", '>0');
                        //         NextofKinPmtAlloc.SetFilter("Disbursement Account", '<>%1', '');
                        //         if NextofKinPmtAlloc.FindSet() then
                        //             repeat
                        //                 NextofKinPmtAlloc.TestField("Beneficiary Amount");
                        //             until NextofKinPmtAlloc.Next = 0;

                        //         if Rec."Claim Type" = Rec."Claim Type"::"Risk Claim" then begin
                        //             Rec.TestField("Burial Permit Number");
                        //             Rec.CalcFields("No. Next of Kin Accounts");
                        //             Rec.CalcFields("No. Next of Kin Payments");
                        //             if Rec."No. Next of Kin Payments" = 0 then
                        //                 Error(ErrorNoAccountMarked)
                        //         end;
                        //     end else begin
                        //         RiskExternalPmt.Reset();
                        //         RiskExternalPmt.SetRange("Risk Claim No.", Rec.No);
                        //         if riskExternalPmt.FindSet() then
                        //             repeat
                        //                 RiskExternalPmt.TestField("Account Type");
                        //                 RiskExternalPmt.TestField("Account No.");
                        //                 RiskExternalPmt.TestField(Amount);
                        //                 RiskExternalPmt.TestField(Description);
                        //             until RiskExternalPmt.Next = 0;
                        //     end;
                        // end;
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);

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

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    begin
                        Rec.TestField(Posted, false);
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
            }
            group(Navigate)
            {
                Caption = 'Navigate';
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
            }

            // group("Case Forwarding A")
            // {
            //     Caption = 'Case Forwarding';
            //     action("Document Comments")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Image = ViewComments;
            //         Promoted = true;
            //         PromotedCategory = Category6;
            //         PromotedIsBig = true;

            //         RunObject = page "Comments List";
            //         RunPageLink = "Header No." = field(No);
            //         RunPageView = where(Types = CONST(comment));
            //     }
            //     action("Send Case")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Image = SendTo;
            //         Promoted = true;
            //         PromotedCategory = Category6;
            //         PromotedIsBig = true;
            //         // Visible = SendCaseVisible;

            //         trigger OnAction()
            //         var
            //         begin
            //             if Rec."Send/Forward to" = Rec."Current Department" then Error('You cannot send this document to %1 while its already in %1', Rec."Send/Forward to");
            //             Comments.Reset();
            //             Comments.SetRange("Header No.", Rec.No);
            //             if Comments.FindLast() then begin
            //                 if Comments."Commented By" <> UserId then Error('Kindly leave a comment');
            //                 if Comments.Comment = '' then Error('Kindly leave a comment');
            //             end else
            //                 Error('Kindly add a comment');
            //             if not Confirm('Are you sure you want to send this case?') then exit;
            //             // Rec."Originator Status" := Rec."Originator Status"::Sent;
            //             // Rec."Recepient Status" := Rec."Recepient Status"::New;
            //             Rec."Current Department" := Rec."Send/Forward to";

            //             // if (CurrentUsersDept <> Rec."Originating Department") and (Rec."Send/Forward to" = Rec."Originating Department") then begin
            //             //     Rec."Originator Status" := Rec."Originator Status"::Returned;
            //             //     Rec."Recepient Status" := Rec."Recepient Status"::Returned;
            //             // end;
            //             CFPage.InsertTracker(Rec.No, Rec."Send/Forward to", true, UserId, CurrentDateTime);
            //             Rec.Modify(true);
            //             Message('Case sent successfully');
            //         end;
            //     }
            //     action("Case Tracker")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Image = History;
            //         Promoted = true;
            //         PromotedCategory = Category6;
            //         PromotedIsBig = true;

            //         RunObject = page "CF Tracker List";
            //         RunPageLink = "Header No." = field(No);
            //     }
            // }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                    end;
                }
                // action(Comment)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Comments';
                //     Image = ViewComments;
                //     Promoted = true;
                //     PromotedCategory = New;
                //     RunObject = Page "Approval Comments";
                //     RunPageLink = "Table ID" = CONST(52185888),
                //     "Document No." = FIELD("No. Series");
                //     Visible = OpenApprovalEntriesExistForCurrUser;
                // }
                action("Re-Open Document")
                {
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        //Rec.TestField(Status, Rec.Status::Approved);
                        Rec.TestField(Posted, false);
                        Rec.TestField(Rec."Document Stage", Rec."Document Stage"::" ");
                        Rec.TestField("Partially Posted", false);
                        if Rec.Status = Rec.Status::Approved then begin
                            if Confirm('Are you sure you want to re-open this document?', false) = true then begin
                                Rec.Status := Rec.Status::Open;
                                Rec.Modify;
                            end;
                        end;
                    end;
                }
                action(ApprovalComments)
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field(No);
                    RunPageView = where(Types = CONST(comment));
                }

                action("Cancel/Archive Document")
                {
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        Rec.TestField(Posted, false);
                        Rec.TestField("Partially Posted", false);
                        // if rec.Status = rec.Status::Open then Error('You cannot cancel an already open document');
                        if Confirm('Are you sure you want to cancel this document?', false) = true then begin
                            Rec.Status := Rec.Status::Cancelled;
                            Rec.Modify;
                        end;
                    end;
                }
                action("Member Card")
                {
                    ApplicationArea = Basic, Suite;
                    Image = CreditCard;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Single";
                    RunPageLink = "No." = FIELD("Member No");
                }
                action("Loans Guaranteed")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Loan Guarantors and Security";
                    RunPageLink = "Member No" = field("Member No");
                    RunPageView = where("Outstanding Balance" = filter(> 0));
                    // RunPageMode = Create;
                }
                action("Update Line")
                {
                    ApplicationArea = Basic, Suite;
                    Image = UpdateUnitCost;
                    Promoted = true;
                    Visible = Rec."Claim Type" = Rec."Claim Type"::"Risk Claim";
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        ConfirmUpdate: Label 'By clicking on update line, all the lines will be recreated, do you want to proceed?';
                        LinesUpdatedMsg: Label 'Lines have been updated successfully';
                    begin
                        if not Confirm(ConfirmUpdate, false) then exit;
                        Rec.TestField(Status, Rec.Status::Open);
                        Rec.OnFillClaimType();
                        CurrPage.Update();
                        Message(LinesUpdatedMsg);
                    end;
                }
                action(Refresh)
                {
                    ApplicationArea = Basic, Suite;
                    Image = Refresh;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        //Rec.UpdateBBFLines();
                        CurrPage.Update();
                        Message('Lines have been refreshed successfully');
                    end;
                }
                action("Print Claim")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        SinkFundRptInfo: Record "SinkFund Report Information";
                    begin
                        SinkFundRptInfo.Reset();
                        SinkFundRptInfo.SetRange(No, Rec.No);
                        if SinkFundRptInfo.FindFirst() then
                            REPORT.Run(Report::"Benevolent Claim Slip", true, true, SinkFundRptInfo);
                    end;
                }
            }
            action("Next of KINs")
            {
                ApplicationArea = Basic, Suite;
                Image = Relationship;
                Promoted = true;
                Visible = false;
                Enabled = false;
                PromotedCategory = Category5;
                RunObject = Page "Next of KIN";
                RunPageLink = "Record ID" = FIELD("Member No");
            }


            // group("CRM Integration")
            // {
            //     action("CRM Comment")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Image = Comment;
            //         Promoted = true;
            //         PromotedCategory = Category7;

            //         RunObject = page "Comments List";
            //         RunPageLink = "Header No." = field("No");
            //         RunPageView = where(Types = CONST(comment));
            //         // RunPageMode = Create;

            //         Visible = IsNotSentBackToCRM;
            //     }
            //     action("Send Back to CRM")
            //     {
            //         ApplicationArea = all;
            //         Image = Return;
            //         Promoted = true;
            //         PromotedCategory = Category7;

            //         Visible = IsNotSentBackToCRM;

            //         trigger OnAction()
            //         var
            //             Comments: Record Comments;
            //         begin
            //             Rec.TestField(Status, Rec.Status::Open);
            //             Comments.Reset;
            //             Comments.SetRange("Header No.", Rec."No");
            //             Comments.SetAscending("Entry No.", true);

            //             if Comments.FindLast then begin
            //                 if (Comments."Commented By" <> UserId) then begin
            //                     Error('Comment is required before sending the application back to CRM');
            //                 end else begin
            //                     if Confirm('This application will be sent back to CRM for editing. Are you sure you want to proceed?') then begin
            //                         Rec."Sent Back to CRM" := true;
            //                         Rec.Modify;

            //                         Message('Comment has been sent back to CRM');

            //                         CurrPage.Close();
            //                     end;
            //                 end;
            //             end else begin
            //                 Error('Comment is required before sending the application back to CRM');
            //             end;
            //             ;
            //         end;
            //     }
            // }
            // group("EDMS Integration")
            // {
            //     action("Import")
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Import File';
            //         Promoted = true;
            //         PromotedCategory = Category8;
            //         Image = Import;

            //         trigger OnAction()
            //         var
            //             Base64Convert: Codeunit "Base64 Convert";
            //             TempBlob: Codeunit "Temp Blob";
            //             InStr: InStream;
            //             ApplicantMember: Record Members;

            //             EDMSFunctions: Codeunit "EDMS Functions";
            //             FileName: Text;
            //             FileContentsB64: Text;
            //         begin
            //             if Rec.No <> '' then begin
            //                 FileName := EDMSFunctions.PickEDMSFile(TempBlob);

            //                 TempBlob.CreateInStream(InStr);
            //                 FileContentsB64 := Base64Convert.ToBase64(InStr);

            //                 if FileContentsB64 <> '' then begin
            //                     UploadToEDMS(Rec, FileName, FileContentsB64);
            //                 end;
            //             end else begin
            //                 Error('Application No. is required for EDMS document upload');
            //             end;
            //         end;
            //     }
            //     action("EDMS File List")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Image = Documents;
            //         Promoted = true;
            //         PromotedCategory = Category8;

            //         RunObject = page "EDMS Files List";
            //         RunPageLink = "Application No." = field("No");
            //         // RunPageMode = Create;
            //     }
            // }
        }
    }


    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //if Rec.Status <> Rec.Status::Open then
        //   Error('Status must be Open');

        SetControlAppearance();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Rec."Claim Type" := Rec."Claim Type"::"Risk Claim";
    end;

    trigger OnOpenPage()
    var
        StatusChgPermissions: Record "Status Change Permissions.";
    begin
        /* IF Rec.Status <> Rec.Status::Open THEN
            CurrPage.EDITABLE := FALSE; */
        SetControlAppearance;

        if Rec."Sent Back to CRM" then begin
            IsNotSentBackToCRM := false;
        end else begin
            IsNotSentBackToCRM := true;
        end;

        StatusChgPermissions.Reset();
        StatusChgPermissions.SetRange("User ID", UserId);
        StatusChgPermissions.SetRange("Process Risk Claims", true);
        CanProcessRiskClaims := StatusChgPermissions.FindFirst();

        NomineeFormRqst.Reset();
        NomineeFormRqst.SetRange("Member No.", Rec."Member No");
        NomineeFormRqst.SetRange(Dispatched, true);
        NomineeRequestFormDispatched := NomineeFormRqst.FindFirst();
    end;

    procedure UploadToEDMS(Rec: Record "SinkFund Report Information"; FileName: Text; FileContentsB64: Text)
    var
        EDMSFunctions: Codeunit "EDMS Functions";
        ApplicantMember: Record Members;

        IDNumber: Text;
        ApplicationType: Label 'BBF'; // BBF
        PFNumber: Text;
    begin
        ApplicantMember.Reset;

        ApplicantMember.SetRange("No.", Rec."Member No");

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
                PFNumber := IDNumber;
            end;

            EDMSFunctions.EDMSMemberFileUpload(
                IDNumber,
                ApplicantMember.Name,
                ApplicationType,
                PfNumber,
                ApplicantMember."No.",
                Rec."No",
                FileName,
                FileContentsB64
            );
        end;
    end;

    procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);

        /* if Rec.Status = Rec.Status::Open then
            CurrPage.Editable := true
        else
            CurrPage.Editable := false; */


        case Rec.Status of
            Rec.Status::Open:
                begin
                    ApplicationDetailsEdit := true;
                    ApprovedEdit := true;
                end;

            Rec.Status::Approved:
                begin
                    ApprovedEdit := false;
                    ApplicationDetailsEdit := false;
                end;
            Rec.Status::Pending:
                begin
                    ApprovedEdit := false;
                    ApplicationDetailsEdit := false;
                end;
            Rec.Status::Rejected:
                begin
                    ApprovedEdit := false;
                    ApplicationDetailsEdit := false;
                end;
        end;

        if Rec."Notice Type" = Rec."Notice Type"::"Next of Kin" then begin
            DeceasedInformationVisible := true;
            ReportedByVisible := false;
            DateEditable := true;
            BalancesVisible := false;
            LinesPageVisible := false;
        end;
        if Rec."Notice Type" = Rec."Notice Type"::"Principal Member" then begin
            DeceasedInformationVisible := false;
            ReportedByVisible := true;
            DateEditable := true;
            BalancesVisible := true;
            LinesPageVisible := false;
        end;
        //if Rec."Claim Type" = Rec."Claim Type"::"Risk Claim" then begin
        // DeceasedInformationVisible := true;
        // ReportedByVisible := true;
        // LinesPageVisible := true;
        // DateEditable := true;
        // BalancesVisible := true;
        //end;
    end;

    var
        IsNotSentBackToCRM: Boolean;
        CaseTracker: Record "CF Tracker";
        CFPage: Page "DMU CF Page";
        CFStations: Record "CF Station Actions";
        Comments: Record Comments;


        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        "NOT OpenApprovalEntriesExist": Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        ReqDocs: Record "Loan Required Documents";
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        BBFRequisationHeader: Record "BBF Requisation Header";
        BBFRequisationLines: Record "BBF Requisation Lines";
        JournlPosted: Codeunit "Journal Post Successful";
        CashOfficeSetup: Record "Cash Office Setup";
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        CashierLinks: Record "Cash Office User Template";
        LineNo: Integer;
        Temp: Record "Cash Office User Template";
        JTemplate: Code[10];
        JBatch: Code[10];
        //PCheck: Codeunit "Posting Check FP";
        Post: Boolean;
        strText: Text[100];
        SendSms: Codeunit SendSms;
        PayLine: Record "SinkFund Report Information";
        NextofKIN: Record "Next of KIN";
        Err0001: Label 'Member does not have next of kin details';
        ImageData: Record "Image Data";
        BBFEntitlement: Record "BBF Entitlement";
        ApplicationDetailsEdit: Boolean;
        ApprovedEdit: Boolean;
        // SendSMSS: Codeunit SendSms;
        SourceTypes: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Rec.Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes";
        CompanyInformation: Record "Company Information";
        Members: Record Members;
        SavingsAccount: Record "Savings Accounts";
        MyComment: Text;
        Source: Enum "SMS Source";
        DeceasedInformationVisible: Boolean;
        ReportedByVisible: Boolean;
        LinesPageVisible: Boolean;
        DateEditable: boolean;
        BalancesVisible: Boolean;
        CanProcessRiskClaims: Boolean;
        NomineeFormRqst: Record "Nominee Form Request";
        NomineeRequestFormDispatched: Boolean;
}


