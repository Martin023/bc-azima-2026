page 52186288 "Approved ATM Linking Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "ATM Linking Applications";
    SourceTableView = WHERE(Status = FILTER(Approved));

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = PageEditable;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ATM Application No."; Rec."ATM Application No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Form No"; Rec."Form No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Request Type"; Rec."Request Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Card Type"; Rec."Card Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Customer ID"; Rec."Customer ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sales Agent"; Rec."Sales Agent")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Capture Date"; Rec."Capture Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Communication)
            {
                Editable = false;
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("ATM Parameters")
            {
                Editable = PageEditable;
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Card No"; GetMaskedCardNo()) //  "Card No"
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Caption = 'Card No';
                }
                field(Limit; Rec.Limit)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Terms Read and Understood"; Rec."Terms Read and Understood")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Card Expiry Date"; Rec."Card Expiry Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
            }
            group("ATM Linking")
            {
                Editable = false;
                field("Card Issued"; Rec."Card Issued")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Linked Date"; Rec."Linked Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ATM Linked"; Rec."ATM Linked")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Card Status"; Rec."Card Status")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Activated"; Rec."Date Activated")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Frozen"; Rec."Date Frozen")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Replacement For Card No"; GetMaskedReplacementCardNo())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Replacement For Card No';
                }
                field("Delivery Mode"; Rec."Delivery Mode")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Collected; Rec.Collected)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Card Issued By"; Rec."Card Issued By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Collected"; Rec."Date Collected")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Delinked By"; Rec."Delinked By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ATM Delinked"; Rec."ATM Delinked")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ATM Delinked Date"; Rec."ATM Delinked Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ATM Linking Statistics"; Rec."ATM Linking Statistics")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("PIN Details")
            {
                Editable = false;
                field("PIN Issued"; Rec."PIN Issued")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("PIN Issued Date"; Rec."PIN Issued Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("PIN Issued By"; Rec."PIN Issued By")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Comment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;
                    // RunObject = Page "Approval Comments";
                }
            }
            group(Action62)
            {
                Caption = 'ATM Parameters';

                action("Re-Open ")
                {
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    begin
                        rec.TestField(Status, Rec.Status::Approved);
                        rec.TestField(Collected, false);
                        if rec."ATM Linked" = false then begin
                            rec.Status := rec.Status::Open;
                            rec.Modify;
                            Message('Document open successfuly');
                        end;
                    end;
                }
                action("Collect ATM")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Confirm Card Collection';
                    Image = PersonInCharge;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        theMember: Record Members;
                        msg: Text[250];
                        SendSMS: Codeunit SendSms;
                        SMSSource: enum "SMS Source";

                    begin
                        Rec.TestField("ATM Charges Applied", true);
                        Rec.TestField(Collected, false);
                        SaccoTransactions.CollectATM(Rec);
                        theMember.Reset();
                        theMember.SetRange("Primary Identification", rec."Customer ID");
                        if theMember.FindFirst() then begin
                            if theMember."Phone No." <> '' then begin

                                msg := 'Dear ' + theMember."First Name" + ', your' +
                                       ' ATM card has been collected/dispatched. Query? 0205134900';

                                SendSMS.SendSms(
                                    SMSSource::ATM_APPLICATION,
                                    theMember."Phone No.",
                                    msg,
                                    Format(rec."No."),
                                    '',
                                    true,
                                    220,
                                    false,
                                    'CBS',
                                    rec."No.",
                                    'CBS'
                                );
                            end;
                        end;
                    end;
                }
                action("Issue Pin")
                {
                    ApplicationArea = Basic, Suite;
                    Image = IssueFinanceCharge;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        rec.TestField("PIN Issued", false);
                        rec.TestField("Card Issued", true);
                        rec.TestField("Card No");
                        rec.TestField("Card Expiry Date");
                        if Confirm('Are you sure you want to issue this pin?') then begin

                            if rec."Card Issued By" = UserId then
                                Error('You cannot Issue Pin since you Issued Card') else begin
                                rec."PIN Issued" := true;
                                rec."PIN Issued By" := UserId;
                                rec."PIN Issued Date" := Today;
                                rec.Modify;
                                Message('PIN issued successfully.');
                            end;
                        end;
                    end;
                }
                action("Charge Card Fee")
                {
                    ApplicationArea = Basic, Suite;
                    Image = AdjustEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        TrCharges: Record "Transaction Charges";
                        TrType: Record "Transaction Types";
                        Trch: Decimal;
                        AvAl: Decimal;
                        PeriodicActivities: Codeunit "Periodic Activities";
                    begin
                        PeriodicActivities.PostATMApplicationCharges(Rec);
                        Rec."ATM Charges Applied" := true;
                        Rec."ATM Charged Date" := Today;
                        Rec.Modify;
                    end;
                }

                action("Link ATM")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Link ATM Card';
                    Image = CreditCard;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ATMCardStorage: Record "ATM Card Storage";
                    begin
                        // ATMInventory.Reset();
                        // ATMInventory.SetRange("Card Number", rec."Card No");
                        // ATMInventory.SetRange("Account No.", rec."Account No");
                        // if ATMInventory.FindFirst() then
                        //     ATMInventory.Status := ATMInventory.Status::Linked;
                        // ATMInventory.Modify();
                        Rec.TestField(Collected, true);
                        Rec.TestField("ATM Charges Applied", true);
                        Rec.TestField("ATM Linked", false);
                        SaccoTransactions.LinkATM(Rec);
                    end;
                }
                action("Reopen Delinked Card")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reopen Delinked Card';
                    Image = ReopenCancelled;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                    // [RunOnClient]
                    // Window: DotNet Interaction;
                    begin
                        rec.TestField(Status, rec.Status::Approved);
                        rec.TestField("ATM Delinked", true);
                        rec.Status := rec.Status::Open;
                        rec."ATM Delinked" := false;
                        rec."ATM Delinked Date" := 0D;
                        rec."Card Status" := rec."Card Status"::Pending;
                        rec."Card Issued" := false;

                        rec.Collected := false;
                        rec."PIN Issued" := false;
                        rec."Delinked By" := '';
                        rec.Modify;
                    end;
                }
                action("Delink ATM")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'DeLink ATM Card';
                    Image = RemoveContacts;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ATMCardStorage: Record "ATM Card Storage";

                    begin
                        // ATMInventory.Reset();
                        // ATMInventory.SetRange("Card Number", rec."Card No");
                        // ATMInventory.SetRange("Account No.", rec."Account No");
                        // if ATMInventory.FindFirst() then
                        //     ATMInventory.Status := ATMInventory.Status::Delinked;
                        // ATMInventory.Modify();

                        SaccoTransactions.DeLinkATM(Rec);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                    //// //ApprovalEntries: Page "Approval Entries";
                    // approvalsMgmt: Codeunit 1535;
                    begin

                        // // ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
            }
            group("Requests for approval")
            {
                Caption = 'Requests for approval';
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        PageEditable := true;
        if rec.Status <> rec.Status::Open then
            PageEditable := false;
    end;

    trigger OnOpenPage()
    begin
        PageEditable := true;
        if rec.Status <> rec.Status::Open then
            PageEditable := false;
    end;

    procedure GetMaskedCardNo(): Text
    var
        CardNo: Text;
    begin
        CardNo := Rec."Card No";
        if CardNo = '' then
            exit('');

        exit(MaskCardNumber(CardNo));
    end;

    procedure GetMaskedReplacementCardNo(): Text
    var
        CardNo: Text;
    begin
        CardNo := Rec."Replacement For Card No";
        if CardNo = '' then
            exit('');

        exit(MaskCardNumber(CardNo));
    end;

    procedure MaskCardNumber(CardNo: Text): Text
    var
        MaskedCardNo: Text;
        i: Integer;
    begin
        MaskedCardNo := CardNo;

        // Mask characters 9-12 (positions 9, 10, 11, 12)
        if StrLen(CardNo) >= 12 then begin
            for i := 9 to 12 do begin
                if i <= StrLen(CardNo) then
                    MaskedCardNo := InsStr(DelStr(MaskedCardNo, i, 1), '*', i);
            end;
        end;

        exit(MaskedCardNo);
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        // CustomApprovals: Codeunit "Custom Approvals Codeunit";
        SavingsAccounts: Record "Savings Accounts";
        PeriodicActivities: Codeunit "Periodic Activities";
        BankingUserTemplate: Record "Banking User Template";
        JTemp: Code[20];
        JBatch: Code[20];
        SaccoTransactions: Codeunit "Sacco Transactions";
        PageEditable: Boolean;
}

