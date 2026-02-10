page 52187414 "FOSA Payment Voucher"
{

    Caption = 'FOSA Payment Voucher';
    DeleteAllowed = false;
    Editable = true;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budget Control,Refresh,Clear Lines,Category8_caption,Approvals,Category10_caption,EDMS';
    SourceTable = "Fosa Payments Header";
    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                Editable = PVLinesEditable;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Importance = Promoted;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("SMS Charge"; Rec."SMS Charge")
                {
                    ApplicationArea = Basic, Suite;
                }


                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = PayeeEditable;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment to';
                    Editable = PayeeEditable;
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ShowMandatory = true;
                    // trigger OnValidate()
                    // var
                    //     FOSAPV: Record "FOSA Payment Line";
                    // begin
                    //     rec.Reset();
                    //     rec.SetRange("No.", FOSAPV.No);
                    //     if Rec.FindFirst() then
                    //         FOSAPV.Reset();
                    //     FOSAPV.SetRange(No, rec."No.");
                    //     if FOSAPV.FindFirst() then
                    //         FOSAPV.Description := rec."Payment Narration";
                    //     FOSAPV.Modify(true);
                    // end;
                }
                field("Cheque Type"; Rec."Cheque Type")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = true;
                    Editable = StatusEditableapproved;

                    trigger OnValidate()
                    begin
                        if Rec."Cheque Type" = Rec."Cheque Type"::"Computer Check" then
                            "Cheque No.Editable" := false
                        else
                            "Cheque No.Editable" := true;
                    end;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cheque No.';
                    Editable = true;


                    trigger OnValidate()
                    begin
                        //check if the cheque has been inserted
                        // Rec.TestField("Paying Bank Account");
                        PVHead.Reset;
                        // PVHead.SetRange(PVHead.p, Rec."Paying Bank Account");
                        PVHead.SetRange(PVHead."Pay Mode", PVHead."Pay Mode"::Cheque);
                        if PVHead.FindFirst then begin
                            repeat
                                if PVHead."Cheque No." = Rec."Cheque No." then begin
                                    if PVHead."No." <> Rec."No." then begin
                                        Error('The Cheque Number has already been utilised');
                                    end;
                                end;
                            until PVHead.Next = 0;
                        end;
                    end;
                }

                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Importance = Additional;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Total Payment Amount"; Rec."Total Payment Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                }
                field("Total Payment Amount LCY"; Rec."Total Payment Amount LCY")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Total Net Amount LCY';
                    Editable = false;
                }
                field("Total Witholding Tax Amount"; Rec."Total Witholding Tax Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                }
                field("Total Net Amount"; Rec."Total Net Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Total Net Amount';
                    Editable = false;
                    Importance = Promoted;
                }


                field("Payment Release Date"; Rec."Payment Release Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = StatusEditableapproved;
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;

                    // trigger OnValidate()
                    // var
                    //     UserSetup: Record "User Setup";
                    //     SavAcc: Record "Savings Accounts";
                    //     FosaPVLines: Record "FOSA Payment Line";
                    // begin

                    //     UserSetup.Reset();
                    //     UserSetup.SetRange("Responsibility Centre", Rec."Responsibility Center");
                    //     if UserSetup.Find('-') then begin
                    //         repeat
                    //             if UserSetup."Member No." <> '' then begin
                    //                 SavAcc.Reset();
                    //                 SavAcc.SetRange("Member No.", UserSetup."Member No.");
                    //                 SavAcc.SetRange("Product Category", SavAcc."Product Category"::"FOSA Account");
                    //                 if SavAcc.Find('-') then begin
                    //                     FosaPVLines.Init();
                    //                     FosaPVLines.No := Rec."No.";
                    //                     FosaPVLines."Account No." := SavAcc."No.";
                    //                     FosaPVLines."Account Name" := SavAcc.Name;
                    //                     FosaPVLines."Global Dimension 1 Code" := SavAcc."Global Dimension 1 Code";
                    //                     FosaPVLines."Shortcut Dimension 2 Code" := SavAcc."Global Dimension 2 Code";
                    //                     FosaPVLines.Insert(true);
                    //                 end;
                    //             end;
                    //         until UserSetup.Next() = 0;
                    //     end;
                    // end;

                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(PVLines; "FOSA Payment Lines")
            {

                SubPageLink = No = FIELD("No.");
                ApplicationArea = Basic;
                Editable = PVLinesEditable;
            }
        }
        area(factboxes)
        {
            part(Control27; "Payment Line FactBox")
            {

                Provider = PVLines;
                SubPageLink = No = FIELD(No),
                              "Line No." = FIELD("Line No.");
                ApplicationArea = Basic, Suite;
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
                action("Post Payment")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post Payment';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    //Enabled = not PVLinesEditable;

                    trigger OnAction()
                    var
                        PeriodicActivities: Codeunit "Periodic Activities";
                    begin
                        rec.TestField(Posted, false);
                        rec.TestField("SMS Charge");
                        //Post PV Entries
                        if Rec.Status <> Rec.Status::Approved then
                            Error(ErrNotApproved);
                        if not AllFieldsEntered then
                            Error('Some of the Key Fields on the Lines: ACCOUNT NO.,AMOUNT Have not been Entered please RECHECK your entries');

                        BankLed.Reset();
                        BankLed.SetRange("Document No.", Rec."No.");
                        if BankLed.FindFirst() then begin
                            Rec.Status := rec.Status::Posted;
                            Rec.Posted := true;
                            Rec."Posted By" := UserId;
                            Rec."Date Posted" := Today;
                            Rec.Modify;
                        end else
                            PeriodicActivities.PostFOSAPV(Rec);
                    end;
                }
                separator(Action1102755026)
                {
                }
                action("Print preview")
                {
                    ApplicationArea = Basic;
                    RunObject = Report "Payment Voucher";
                }
                separator(Action1102755009)
                {
                }
                action("Cheque Print")
                {
                    ApplicationArea = Basic;
                    Image = PrintCheck;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    trigger OnAction()
                    begin
                        Message('Prints only after record has been Posted');
                        if Rec.Status = Rec.Status::Posted then begin
                            Rec.Reset;
                            Rec.SetFilter("No.", Rec."No.");
                            REPORT.Run(Report::"Agent Applications Report", true, true, Rec);
                            Rec.Reset;
                        end else
                            Error(Err00001);
                    end;
                }

                action("Import Fosa Lines")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Import Fosa Lines';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = XMLport "FOSA PV Lines";
                    trigger OnAction()
                    begin
                        rec.TestField(Posted, false);
                    end;
                }
                action("Clear Payment Lines")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Clear Payment Lines';
                    Image = ClearLog;
                    Promoted = true;
                    PromotedCategory = Category6;
                    trigger OnAction()
                    var
                        PayLine: Record "FOSA Payment Line";
                    begin
                        rec.TestField(Posted, false);
                        PayLine.Reset;
                        PayLine.SetRange(No, Rec."No.");
                        if PayLine.FindFirst then begin
                            repeat
                                if not PayLine.Committed then
                                    PayLine.Delete
                                else
                                    Error('Some of the Payment Lines have been committed to budget kindly cancel the commitment first');
                            until PayLine.Next = 0;
                            Message('Payment Lines Cleared Successfully. Budgeted lines have not been cleared. Please cancel budget commitments if necessary');
                        end;
                    end;
                }

                separator(Action31)
                {
                }
                // action("Check Budgetary Availability")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Check Budgetary Availability';
                //     Image = Balance;
                //     Promoted = true;
                //     PromotedCategory = Category5;
                //     PromotedIsBig = true;

                //     trigger OnAction()
                //     var
                //         BCSetup: Record "Budgetary Control Setup";
                //     begin
                //         if not (Rec.Status = Rec.Status::Open) then begin
                //             Error('Document must be Open');
                //         end;
                //         BCSetup.Get;
                //         if not BCSetup.Mandatory then
                //             if Confirm('Budgetary Control is not Mandatory, Do you want to continue to check budget?', false) = false then
                //                 exit;

                //         if not AllFieldsEntered then
                //             Error('Some of the Key Fields on the Lines: ACCOUNT NO.,AMOUNT Have not been Entered please RECHECK your entries');
                //         //First Check whether other lines are already committed.
                //         Commitments.Reset;
                //         // Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::"Fosa PV");
                //         Commitments.SetRange(Commitments."Document No.", Rec."No.");
                //         if Commitments.Find('-') then begin
                //             if Confirm('Lines in this Document appear to be committed do you want to re-commit?', false) = false then begin exit end;
                //             Commitments.Reset;
                //             //Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::"Fosa PV");
                //             Commitments.SetRange(Commitments."Document No.", Rec."No.");
                //             Commitments.DeleteAll;
                //         end;
                //         CheckBudgetAvail.CheckPayments1(Rec);
                //     end;
                // }
                // action("Cancel Budget Commitment")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Cancel Budget Commitment';
                //     Image = CancelAllLines;
                //     Promoted = true;
                //     PromotedCategory = Category5;
                //     PromotedIsBig = true;

                //     trigger OnAction()
                //     begin
                //         if (Rec.Posted) then begin
                //             Error('Document must not be Posted');
                //         end;

                //         if Confirm('Do you Wish to Cancel the Commitment entries for this document', false) = false then begin exit end;

                //         Commitments.Reset;
                //         Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::"Fosa PV");
                //         Commitments.SetRange(Commitments."Document No.", Rec."No.");
                //         Commitments.DeleteAll;

                //         PayLine.Reset;
                //         PayLine.SetRange(PayLine.No, Rec."No.");
                //         if PayLine.Find('-') then begin
                //             repeat
                //                 PayLine.Committed := false;
                //                 PayLine.Modify;
                //             until PayLine.Next = 0;
                //         end;
                //     end;
                // }
                separator(Action1102755033)
                {
                }
                action(Print)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Print/Preview';
                    Image = ConfirmAndPrint;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        PaymentHeader: Record "Payments Header";
                    begin
                        IF rec.Status <> rec.Status::Approved THEN
                            ERROR('You can only print a Payment Voucher after it is fully Approved');



                        //IF Status=Status::Pending THEN
                        //ERROR('You cannot Print until the document is released for approval');

                        Rec.Reset;
                        Rec.SetFilter("No.", Rec."No.");
                        REPORT.Run(Report::"Fosa Voucher Print", true, true, Rec);

                        Rec.Reset;

                        CurrPage.Update;
                        CurrPage.SaveRecord;

                    end;
                }
                // action("Vendor Payment Advise")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Vendor Payment Advise';
                //     Image = "Report";
                //     Promoted = true;
                //     PromotedCategory = "Report";

                //     trigger OnAction()
                //     begin
                //         if Rec.Status = Rec.Status::Pending then
                //             Error('You cannot Print until the document is released for approval');
                //         Rec.Reset;
                //         Rec.SetFilter("No.", Rec."No.");
                //         REPORT.Run(Report::"Vendor Payment Advice", true, true, Rec);
                //         Rec.Reset;
                //     end;
                // }
                action("Cheque Confirmation")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cheque Confirmation';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    var
                        FilterbyPayline: Record "Payment Line";
                    begin
                        /*
                        IF Status=Status::Pending THEN
                           ERROR('You cannot Print until the document is released for approval');
                        FilterbyPayline.RESET;
                        FilterbyPayline.SETFILTER(FilterbyPayline.No,"No.");
                        */

                        Bank.Reset;
                        Bank.SetFilter("No.", Rec."Paying Bank Account");
                        if Rec."Payment Release Date" <> 0D then
                            Bank.SetFilter("Date Filter", '%1', Rec."Payment Release Date");
                        REPORT.Run(Report::"Cheque Confirmation", true, true, Bank);

                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Funds Mgt Comment List";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "Document No." = FIELD("No.");
                }
                separator(Action1102756005)
                {
                }
                action("ReOpen Document")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'ReOpen Document';
                    Image = ReOpen;
                    Promoted = true;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if not Confirm('Are you sure you want to reopen this document?') then exit;
                        rec.TestField(Posted, false);
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                    end;
                }
                action("Cancel Document")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Document';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Text000: Label 'Are you sure you want to cancel this Document?';
                        Text001: Label 'You have selected not to Cancel the Document';
                    begin
                        if Rec.Posted then Error('Please reverse this document first');//TESTFIELD(Status,Status::Approved);
                        if Confirm(Text000, true) then begin
                            //Post Reversal Entries for Commitments
                            Doc_Type := Doc_Type::"Payment Voucher";
                            CheckBudgetAvail.ReverseEntries(Doc_Type, Rec."No.");
                            Rec.Status := Rec.Status::Cancelled;
                            Rec.Modify;
                        end else
                            Error(Text001);
                    end;
                }
            }
            group("Copy Documents")
            {
                Caption = 'Copy Documents';
                action("Copy Invoice")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Copy Invoice';
                }

                // action("Get External Clearance")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Image = GetEntries;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     PromotedIsBig = true;

                //     trigger OnAction()
                //     var
                //         Vendor: Record Vendor;
                //         EntryNo: Integer;
                //         ApplyVendEntries: Page "Apply Vendor Entries";
                //         VendLedgEntry: Record "Vendor Ledger Entry";
                //         Err0001: Label 'This member does not have an external loan that need to be cleared.';
                //         BankersChequesRegister: Record "Bankers Cheques Register";
                //     begin
                //         Message('Insert member external loans to the payment lines');
                //         Rec.TestField("Member No.");
                //         PayLine.Reset;
                //         PayLine.SetRange(No, Rec."No.");
                //         if PayLine.Find('-') then
                //             PayLine.DeleteAll;

                //         //........


                //         Vendor.Reset;
                //         Vendor.SetRange("Vendor Type", Vendor."Vendor Type"::"External Loans");
                //         if Vendor.Find('-') then begin

                //             Loans.Reset;
                //             Loans.SetRange("Member No.", Rec."Member No.");
                //             if Loans.Find('-') then begin
                //                 repeat

                //                     VendorLedgerEntry.Reset;
                //                     VendorLedgerEntry.SetRange(Open, true);
                //                     VendorLedgerEntry.SetRange("Vendor No.", Vendor."No.");
                //                     VendorLedgerEntry.SetRange("External Document No.", Loans."Loan No.");
                //                     if VendorLedgerEntry.Find('-') then begin
                //                         repeat
                //                             VendorLedgerEntry.CalcFields(Amount);

                //                             RecPayTypes.Reset;
                //                             RecPayTypes.SetRange("External Clearance", true);
                //                             if RecPayTypes.Find('-') then begin
                //                                 EntryNo += 1;

                //                                 PayLine.Init;
                //                                 PayLine.No := Rec."No.";
                //                                 PayLine.Type := RecPayTypes.Code;
                //                                 PayLine.Validate(Type);
                //                                 PayLine."Line No." := EntryNo;
                //                                 PayLine."Account No." := Vendor."No.";
                //                                 PayLine.Validate("Account No.");
                //                                 PayLine.Amount := VendorLedgerEntry.Amount * -1;
                //                                 //Get Leaf Limit
                //                                 BankersChequesRegister.Reset;
                //                                 BankersChequesRegister.SetRange("Cheque No.", Rec."Bankers Cheque No");
                //                                 if BankersChequesRegister.Find('-') then begin
                //                                     if VendorLedgerEntry.Amount * -1 >= BankersChequesRegister."Leaf Limit Amount" then begin
                //                                         Rec.TestField("Payment Narration");
                //                                         PayLine."Account Name" := Rec."Payment Narration"
                //                                     end;
                //                                 end else
                //                                     PayLine."Account Name" := VendorLedgerEntry.Description;
                //                                 PayLine.Validate(Amount);
                //                                 PayLine."Vend Ledger Entry No" := VendorLedgerEntry."Entry No.";
                //                                 PayLine.Insert;
                //                             end;
                //                         until VendorLedgerEntry.Next = 0;
                //                     end else
                //                         Error(Err0001);
                //                 until Loans.Next = 0;
                //             end;
                //         end;
                //     end;
                // }
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
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    begin
                        Rec.testfield("Payment Narration");
                        // Commitments.Reset;
                        // Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::"Fosa PV");
                        // Commitments.SetRange(Commitments."Document No.", Rec."No.");
                        // if not Commitments.Find('-') then begin
                        //     if CheckBudgetAvail.CheckIfFOSAPVIsBudgeted(Rec) then
                        //         Error('You cannot send for approval without checking the Budget availability');
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
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    begin
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Commentss)
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    Caption = 'Comment';
                    PromotedCategory = Category9;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("No.");
                    RunPageView = where(Types = CONST(comment));
                }
            }
            // group(Navigate)
            // {
            //     Caption = 'Navigate';
            //     action(Approvals)
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'Approvals';
            //         Image = Approvals;
            //         Promoted = true;
            //         PromotedCategory = Category9;

            //         trigger OnAction()
            //         var
            //         //    alEntries: Page "Approval Entries";
            //         //     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            //         begin
            //             /* //Approv
            //             DocumentType := DocumentType::"Payment Voucher";
            //             ApprovalEntries.SetRecordFilters(DATABASE::"Payments Header","Document Type","No.");
            //             ApprovalEntries.RUN;
            //             */
            //             // ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId)

            //         end;
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
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId)
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
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId)
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
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;


                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }
            action(Refresh)
            {
                ApplicationArea = Basic, Suite;
                Image = Refresh;
                Promoted = true;
                PromotedCategory = category6;
                trigger OnAction()
                begin
                    SetControlAppearance;
                    CurrPage.Update;
                    Message('Page Refreshed');
                end;
            }

            // group("EDMS Integration")
            // {
            //     action("Import")
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Import File';
            //         Promoted = true;
            //         PromotedCategory = Category11;
            //         Image = Import;

            //         trigger OnAction()
            //         var
            //             Base64Convert: Codeunit "Base64 Convert";
            //             TempBlob: Codeunit "Temp Blob";
            //             InStr: InStream;

            //             EDMSFunctions: Codeunit "EDMS Functions";
            //             FileName: Text;
            //             FileContentsB64: Text;

            //             IDNumber: Text;
            //             ApplicationType: Label 'MA'; // Member Application
            //             PFNumber: Text;
            //         begin
            //             if Rec."No." <> '' then begin
            //                 FileName := EDMSFunctions.PickEDMSFile(TempBlob);

            //                 TempBlob.CreateInStream(InStr);
            //                 FileContentsB64 := Base64Convert.ToBase64(InStr);

            //                 if FileContentsB64 <> '' then begin
            //                     // UploadToEDMS(Rec, FileName, FileContentsB64);
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
            //         PromotedCategory = Category11;

            //         RunObject = page "EDMS Files List";
            //         RunPageLink = "Application No." = field("No.");
            //         // RunPageMode = Create;
            //     }
            // }
        }
    }

    trigger OnAfterGetRecord()
    var
        UserSetup: Record "User Setup";
    begin
        if rec.Cashier = '' then rec.Cashier := UserId;
        if rec."Global Dimension 1 Code" = '' then rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        if rec."Shortcut Dimension 2 Code" = '' then rec."Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        if rec."Responsibility Center" = '' then rec."Responsibility Center" := UserSetup."Responsibility Centre";
        //Currpageupdate;
        //CurrPageUpdate;
        UpdatePageControls;
        SetControlAppearance;
    end;

    trigger OnInit()
    begin
        PVLinesEditable := true;
        DateEditable := true;
        PayeeEditable := true;

        ShortcutDimension2CodeEditable := true;
        ShortcutDimension3CodeEditable := true;
        ShortcutDimension4CodeEditable := true;
        "Payment NarrationEditable" := true;
        GlobalDimension1CodeEditable := true;
        "Currency CodeEditable" := true;
        "Invoice Currency CodeEditable" := true;
        "Cheque TypeEditable" := true;
        "Payment Release DateEditable" := true;
        "Cheque No.Editable" := true;
        UpdateControls;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Payment Type" := Rec."Payment Type"::Normal;
        if rec."No." <> '' then
            CurrPage.Update;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserSetup: Record "User Setup";
    begin
        rec.Cashier := UserId;
        rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        rec."Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        rec."Responsibility Center" := UserSetup."Responsibility Centre";

    end;

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls();
        UpdatePageControls

    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        UpdateControls;
        UpdatePageControls
    end;

    trigger OnOpenPage()

    begin
        if Rec.Posted then
            CurrPage.Editable := false;
        UpdateControls();
        UpdatePageControls();

    end;

    procedure AllFieldsEntered(): Boolean
    var
        PayLine: Record "FOSA Payment Line";
    begin
        PayLine.Reset;
        PayLine.SetRange(PayLine.No, Rec."No.");
        if PayLine.FindFirst then begin
            repeat
                if PayLine."Account No." = '' then
                    exit(false);
                if PayLine.Amount = 0 then
                    exit(false);
            until PayLine.Next = 0;
        end;
        exit(true);
    end;

    procedure UpdateControls()
    begin
        if Rec.Status = Rec.Status::Pending then
            StatusEditablePending := true
        else
            StatusEditablePending := false;

        if Rec.Status = Rec.Status::Approved then
            StatusEditableApproved := true
        else
            StatusEditableApproved := false;
        // IF Cashier<>'' THEN
        //  IF USERID<>Cashier THEN ERROR('You cannot edit a card that you did not create');
    end;

    procedure UpdatePageControls()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if Rec.Status <> Rec.Status::Approved then begin
            "Payment Release DateEditable" := false;
            //CurrForm."Paying Bank Account".EDITABLE:=FALSE;
            //CurrForm."Pay Mode".EDITABLE:=FALSE;
            //CurrForm."Currency Code".EDITABLE:=TRUE;
            "Cheque No.Editable" := false;
            "Cheque TypeEditable" := false;
            "Invoice Currency CodeEditable" := true;
        end else begin
            "Payment Release DateEditable" := true;
            //CurrForm."Paying Bank Account".EDITABLE:=TRUE;
            //CurrForm."Pay Mode".EDITABLE:=TRUE;
            if Rec."Pay Mode" = Rec."Pay Mode"::Cheque then
                "Cheque TypeEditable" := true;
            //CurrForm."Currency Code".EDITABLE:=FALSE;
            if Rec."Cheque Type" <> Rec."Cheque Type"::"Computer Check" then
                "Cheque No.Editable" := true;
            "Invoice Currency CodeEditable" := false;
            PaymodeEditable := true;
            BankEditabl := true;
            OnBehalfEditable := true;
            RespEditabl := true;

        end;
        if (Rec.Status = Rec.Status::Pending) or (Rec.Status = Rec.Status::Open) then begin
            "Currency CodeEditable" := true;
            GlobalDimension1CodeEditable := true;
            "Payment NarrationEditable" := true;
            ShortcutDimension2CodeEditable := true;
            PayeeEditable := true;
            ShortcutDimension3CodeEditable := true;
            ShortcutDimension4CodeEditable := true;
            DateEditable := true;
            PaymodeEditable := true;
            BankEditabl := true;
            OnBehalfEditable := true;
            RespEditabl := true;

            PVLinesEditable := true;
        end else begin
            "Currency CodeEditable" := false;
            GlobalDimension1CodeEditable := false;
            "Payment NarrationEditable" := false;
            ShortcutDimension2CodeEditable := false;
            PayeeEditable := true;
            ShortcutDimension3CodeEditable := false;
            ShortcutDimension4CodeEditable := false;
            DateEditable := false;
            //PVLinesEditable := false;
        end;

        if rec.Posted then begin
            PaymodeEditable := false;
            BankEditabl := false;
            OnBehalfEditable := false;
            RespEditabl := false;
            PVLinesEditable := false;
        end;

        if rec.Cashier = '' then rec.Cashier := UserId;
        if rec."Global Dimension 1 Code" = '' then rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        if rec."Shortcut Dimension 2 Code" = '' then rec."Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        if rec."Responsibility Center" = '' then rec."Responsibility Center" := UserSetup."Responsibility Centre";

    end;

    var
        PayLine: Record "FOSA Payment Line";
        PVUsers: Record "W/P Budget Buffer";
        strFilter: Text[250];
        IntC: Integer;
        IntCount: Integer;
        Payments: Record "FOSA Payments Header";
        RecPayTypes: Record "Receipts and Payment Types";
        TarriffCodes: Record "Tariff Code s";
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        CashierLinks: Record "Cash Office User Template";
        LineNo: Integer;
        Temp: Record "Cash Office User Template";
        JTemplate: Code[10];
        JBatch: Code[10];
        PCheck: Codeunit "Posting Check FP";
        Post: Boolean;
        strText: Text[100];
        PVHead: Record "Payments Header";
        BankAcc: Record "Bank Account";
        CheckBudgetAvail: Codeunit "Budgetary Control";
        Commitments: Record Committment;
        UserMgt: Codeunit "User Setup Management BR";
        JournlPosted: Codeunit "Journal Post Successful";
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,Loan,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation","Overdraft ",BLA,"Member Editable","MSacco Applications","MSacco PinChange","MSacco PhoneChange","MSacco TransChange",BulkSMS,"Payment Voucher","Petty Cash",Imp,Requisition,ImpSurr,Interbank,Receipt,"Staff Claim","Staff Adv",AdvSurr,OT;
        //  DocPrint: Codeunit "Document-Print";
        CheckLedger: Record "Check Ledger Entry";
        Text001: Label 'This Document no %1 has printed Cheque No %2 which will have to be voided first before reposting.';
        CheckManagement: Codeunit CheckManagement;
        Text000: Label 'Do you want to Void Check No %1';
        Text002: Label 'You have selected post and generate a computer cheque ensure that your cheque printer is ready do you want to continue?';
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        //AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";

        "Cheque No.Editable": Boolean;
        ErrNotApproved: Label 'This document has not been approved';

        "Payment Release DateEditable": Boolean;

        "Cheque TypeEditable": Boolean;

        "Invoice Currency CodeEditable": Boolean;

        "Currency CodeEditable": Boolean;

        GlobalDimension1CodeEditable: Boolean;

        "Payment NarrationEditable": Boolean;

        ShortcutDimension2CodeEditable: Boolean;

        PayeeEditable: Boolean;

        ShortcutDimension3CodeEditable: Boolean;

        ShortcutDimension4CodeEditable: Boolean;

        DateEditable: Boolean;

        PVLinesEditable: Boolean;
        StatusEditablePending: Boolean;
        PaymodeEditable: Boolean;
        BankEditabl: Boolean;
        OnBehalfEditable: Boolean;
        RespEditabl: Boolean;
        Bank: Record "Bank Account";
        DocNoVisible: Boolean;
        "NOT OpenApprovalEntriesExist": Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;

        StatusEditableApproved: Boolean;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        Loans: Record Loans;
        Err00001: Label 'This Document has  to be posted before you can print the Cheque.';
        BankLed: Record "G/L Entry";

    //[Scope('OnPrem')]


    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;
}

