page 52185875 "Posted End Year Interest"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "End Year Transfer Header";
    SourceTableView = WHERE(Posted = FILTER(true));


    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Distributed Amount"; Rec."Distributed Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(Control18; "End Year Interest Buffer")
            {
                SubPageLink = No = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(SendSMS)
            {
                ApplicationArea = Basic, Suite;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                //Enabled = false;

                trigger OnAction()
                var
                    SaccoT: Codeunit "Sacco Transactions";
                    GenSetup: record "General Set-Up";
                    Account: Record "Savings Accounts";
                    MobileNo: code[50];
                    Memb: Record Members;
                    Text0006: label ' has been credited to your account ';
                    Text0007: label ' on ';
                    msg: text;
                    SendSMS: Codeunit SendSms;
                    Source: enum "SMS Source";
                    GlobalFunctions: Codeunit "Global Functions";
                    InterestLines: record "End Year Interest Buffer";
                begin
                    if Rec.Status <> Rec.Status::Approved then
                        Error('The Interest batch has not been approved');
                    if not rec.Posted then Error('This Interest Batch is not posted');
                    if Confirm('Are you sure you want to send Interest SMS?', false) = false then
                        exit;
                    InterestLines.Reset;
                    InterestLines.SetRange(InterestLines.No, rec."No.");
                    InterestLines.setrange(posted, true);
                    if InterestLines.FindSet() then begin
                        repeat
                            if Account.get(InterestLines."Account No") then begin
                                MobileNo := Account."Mobile Phone No";
                                if MobileNo = '' then begin
                                    if Memb.get(Account."Member No.") then
                                        MobileNo := Memb."Phone No.";
                                end;
                                msg := 'Dear member your ' + rec."Product Name" + ' interest of KES. ' + Format(InterestLines."Net Interest") + Text0006 + Text0007 + SaccoT.ddMMyyyy(Today) + ' ' + Format(Time) + '.';

                                SendSMS.SendSms(Source::SALARY_PROCESSING, MobileNo, msg, Format(InterestLines."Account No"), '', true, 0, false, 'CBS', InterestLines."Account No", 'CBS');
                            end;
                        until
                        InterestLines.Next = 0;
                    end;
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UpdateControls();
    end;

    trigger OnOpenPage()
    begin
        UpdateControls();
    end;

    var
        InterestBuffer: Record "End Year Interest Buffer";
        InterestBuffer2: Record "End Year Interest Buffer";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        PeriodicActivities: Codeunit "Periodic Activities";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        //  CustomApprovals: Codeunit "Custom Approvals Codeunit";
        ErrNotApproved: Label 'This document has not been approved';
        ErrNoEntries: Label 'This Document has no Lines to post';
        MSGEntriesGenerated: Label 'Entries Generated Successfully';
        MSGConfirmation: Label 'Confirm interest Generation for period starting %1 and Ending %2';
        SavingsAccounts: Record "Savings Accounts";
        FromDateS: Text[100];
        ToDateS: Text[100];
        DateFilter: Text[100];
        ProductFactory: Record "Product Factory";
        ProductFactoryCode: Code[20];
        InterestRate: Decimal;
        PayableAccount: Code[20];
        ExpenseAccount: Code[20];
        BankingUserTemplate: Record "Banking User Template";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        JTemp: Code[20];
        JBatch: Code[20];
        ErrPosted: Label 'This document has already been posted';
        PageEditable: Boolean;
        Members: Record Members;
        SavingsInterestBuffer: Record "Savings Interest Buffer";
        IntEarned: Decimal;

    //[Scope('OnPrem')]
    procedure UpdateControls()
    begin
        if Rec.Posted = true then begin
            PageEditable := false;
        end;
    end;
}

