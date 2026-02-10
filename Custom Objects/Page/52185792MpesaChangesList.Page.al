page 52185792 "Mpesa Changes List"
{
    CardPageID = "Mpesa Changes";
    Editable = false;
    PageType = List;
    SourceTable = "M-PESA Change Transactions";
    SourceTableView = WHERE("App Status" = FILTER(<> Changed));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("MPESA Receipt No"; Rec."MPESA Receipt No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("New Account No"; Rec."New Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Destination Type"; Rec."Destination Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Keyword; Rec.Keyword)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("App Status"; Rec."App Status")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approval Status';
                }
                field("Initiated By"; Rec."Initiated By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Approved By"; Rec."Approved By")
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
            group("Mpesa Changes")
            {
            }
            action(Approvals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approvals';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                begin
                    DocumentType := DocumentType::"MSacco TransChange";
                    ApprovalEntries.SetRecordFilters(DATABASE::"HR Appraisal Learning & Growth", DocumentType, Rec.No);
                    ApprovalEntries.Run;
                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    text001: Label 'This batch is already pending approval';
                // ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin
                    if Rec.Status <> Rec.Status::Open then
                        Error(text001);

                    Rec.TestField("MPESA Receipt No");
                    // TESTFIELD("New Account No");

                    //End allocate batch number
                    // IF ApprovalMgt.SendMsaccoTransApprovalRequest(Rec) THEN;
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel A&pproval Request';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    text001: Label 'This batch is already pending approval';
                // ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin
                    if Rec.Status <> Rec.Status::Pending then
                        Error(text002);


                    //End allocate batch number
                    // IF ApprovalMgt.CancelMsaccoTransApprovalRequest(Rec,TRUE,TRUE) THEN;
                end;
            }
            action("Finalise Change")
            {
                ApplicationArea = Basic, Suite;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Approved then
                        Error('Application must be approved');

                    if Rec.Changed = true then
                        Error('Change already effected');

                    /*StatusPermissions.RESET;
                    StatusPermissions.SETRANGE(StatusPermissions."User ID",USERID);
                    StatusPermissions.SETRANGE(StatusPermissions."Function",StatusPermissions."Function"::"Mpesa Change");
                    IF StatusPermissions.FIND('-') = FALSE THEN
                    ERROR('Please contact system Admin for this permission.');
                       */
                    /*
                    
                    ReversalMngt.RESET;
                    ReversalMngt.SETRANGE(ReversalMngt.UserId,USERID);
                    ReversalMngt.SETFILTER(ReversalMngt.Status,'Mpesa Change');
                    IF ReversalMngt.FIND('-') = FALSE THEN BEGIN
                    ERROR('Please contact system Admin for this permission')
                    END;
                    */
                    if Rec."Initiated By" = UpperCase(UserId) then
                        Error('You cannot initiate and finalise same change');

                    if Rec."Initiated By" = UserId then begin
                        Error('The user who initiated the transaction cannot be the same as the one who finalises it.');
                        exit;
                    end;

                    MPESATransactions.Reset;
                    MPESATransactions.SetRange(MPESATransactions."Document No.", Rec."MPESA Receipt No");
                    if MPESATransactions.Find('-') then begin

                        if MPESATransactions.Changed = false
                        then begin
                            MPESATransactions."Old Account No" := MPESATransactions."Account No.";
                        end;


                        MPESATransactions."Account No." := Rec."New Account No";



                        // Get Key Words

                        //    ~~~~~~~~~~~~~~~~ Loan Repayments

                        if Rec."Transaction Type" = Rec."Transaction Type"::"Loan Repayment" then begin
                            if Rec.Keyword <> '' then begin

                                MPESATransactions."Key Word" := Rec.Keyword;

                                /*
                                LoanPaybillKeywords.RESET;
                                LoanPaybillKeywords.SETRANGE(LoanPaybillKeywords."Destination Type","Transaction Type");
                                LoanPaybillKeywords.SETRANGE(LoanPaybillKeywords."Loan Code","Loan Product Type");

                                IF LoanPaybillKeywords.FIND('-') THEN BEGIN
                                 MPESATransactions."Key Word":=LoanPaybillKeywords.Keyword;
                                END;
                                */

                            end;
                        end;

                        if Rec."Transaction Type" = Rec."Transaction Type"::"Deposit Contribution" then begin
                            MPESATransactions."Key Word" := 'D';
                        end;

                        if Rec."Transaction Type" = Rec."Transaction Type"::"Share Capital" then begin
                            MPESATransactions."Key Word" := 'S';
                        end;

                        if Rec."Transaction Type" = Rec."Transaction Type"::"FOSA Deposit" then begin
                            MPESATransactions."Key Word" := 'BEN';
                        end;




                        //End getting Key words



                        MPESATransactions."Change Transaction No" := MPESAChanges.No;
                        MPESATransactions.Changed := true;
                        MPESATransactions."Date Changed" := Today;
                        MPESATransactions."Time Changed" := Time;
                        MPESATransactions."Changed By" := MPESAChanges."Initiated By";
                        MPESATransactions."Approved By" := UserId;
                        MPESATransactions.Modify;
                    end;

                    //////////
                    Rec."App Status" := MPESAChanges."App Status"::Changed;
                    Rec."Approved By" := UserId;
                    Rec."Date Approved" := Today;
                    Rec."Time Approved" := Time;
                    Rec.Changed := true;
                    Rec.Modify;


                    //SMS

                end;
            }
            action("Reject Change")
            {
                ApplicationArea = Basic, Suite;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin

                    if Confirm('Do you want to reject the transaction?') = true then begin
                        Rec.TestField("Reasons for rejection");
                        MPESAChanges.Reset;
                        MPESAChanges.SetRange(MPESAChanges.No, Rec.No);
                        if MPESAChanges.Find('-') then begin

                            if MPESAChanges."Initiated By" = UserId then begin
                                Error('The user who initiated the transaction cannot be the same as the one who rejects it.');
                                exit;
                            end;


                            MPESAChanges."App Status" := MPESAChanges."App Status"::Rejected;
                            MPESAChanges."Approved By" := UserId;
                            MPESAChanges."Date Approved" := Today;
                            MPESAChanges."Time Approved" := Time;
                            MPESAChanges.Modify;
                        end;
                    end;
                end;
            }
        }
    }

    var
        //ApprovalEntries: Page "Approval Entries";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,ImprestSurrender,"MSacco Applications","MSacco PinChange","MSacco PhoneChange","MSacco TransChange",BulkSMS;
        text001: Label 'Status must be Open';
        text002: Label 'Status must be Pending';
        MPESAChanges: Record "M-PESA Change Transactions";
        MPESATransactions: Record "M-PESA Transactions";
}

