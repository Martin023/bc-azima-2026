page 52185810 "Cheque Application"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Workflows, ,Request Approval,Adjustments';
    SourceTable = "Cheque Book Application";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = TransType;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = accNo;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Cheque Book Type"; Rec."Cheque Book Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = chbktype;
                }
                field("Begining Cheque No."; Rec."Begining Cheque No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = beginCh;
                }
                field("End Cheque No."; Rec."End Cheque No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = endCh;
                }
                field("Responsibility Centre"; Rec."Responsibility Centre")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Last check"; Rec."Last check")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Cheque Account No."; Rec."Cheque Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Translation Code"; Rec."Translation Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Cheque Register Generated"; Rec."Cheque Register Generated")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Cheque Book charges Posted"; Rec."Cheque Book charges Posted")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Application Exported"; Rec."Application Exported")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Issue/Generate Cheque Register")
            {
                ApplicationArea = Basic, Suite;
                Image = Interaction;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    if Rec.Status <> Rec.Status::Approved then
                        Error('The document must be fully approved');

                    // if Rec."Application Exported" <> true then
                    //     Error('You cannot generate the cheque book before the application is exported');

                    if Rec."Cheque Register Generated" then
                        Error('Cheque generation already done');
                    Rec.TestField("Begining Cheque No.");
                    Rec.TestField("End Cheque No.");
                    IncrNo := Rec."Begining Cheque No.";

                    if Rec."End Cheque No." < Rec."Begining Cheque No." then
                        Error('Beginning number is more than ending number');


                    while IncrNo <= Rec."End Cheque No." do begin
                        CheqReg.Init;
                        CheqReg."Account No." := Rec."Cheque Account No.";
                        CheqReg."Cheque No." := IncrNo;
                        CheqReg."Application No." := Rec."No.";
                        CheqReg.Insert;

                        IncrNo := IncStr(IncrNo);
                    end;
                    Rec."Cheque Register Generated" := true;
                    Rec.Modify;

                    if Vend.Get(rec."Account No.") then begin
                        MobNo := Vend."Transactional Mobile No";
                    end;

                    msg := Text0001 + Format(Today) + ' ' + Format(Time)+ ' ' + CompanyName;
                    SendSMS.SendSms(Source::MBANKING, MobNo, msg, Format(rec."No."), '', true, 0, false, 'CBS', rec."No.", 'CBS');

                    Message('Register generated successfully');
                end;
            }
            action("Cheque Register")
            {
                ApplicationArea = Basic, Suite;
                Image = GetLines;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = Page "Cheque Register List";
                RunPageLink = "Application No." = FIELD("No.");
            }
            action("Post Cheque Book Charges")
            {
                ApplicationArea = Basic, Suite;
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Do you want post the charges', false) = true then begin


                        if Rec.Status = Rec.Status::"Pending Approval" then
                            Error('The transaction must be fully approved before proceeding');

                        SaccoT.PostBankChequeCharges(Rec);

                    end;
                end;
            }

            action("Export Cheque Book")
            {
                ApplicationArea = Basic, Suite;
                Image = Export;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin


                    // rec.Reset;
                    // rec.SetRange(rec."Chq Receipt No", Rec."No.");
                    XMLPORT.Run(XmlPort::"Export Cheque Book Application", true, false, rec);
                end;
            }
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
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                        rec.Status := rec.Status::Approved;
                        rec.Modify;
                        Message('Cheque Book Approved');

                        Message('next step is to export the application to an excel sheet \n finally generate the cheque register');
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
                    // ApprovalsMgmt: Codeunit 1535;
                    begin
                        // // ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                        rec.Status := rec.Status::Rejected;
                        rec.Modify;
                        Message('Cheque Book Rejected');
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
                    // ApprovalsMgmt: Codeunit 1535;
                    begin
                        // ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
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
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        if Rec.Status <> Rec.Status::Open then
                            Error(DocMustbeOpen);


                        Rec.TestField("Account No.");
                        Rec.TestField("Cheque Book Type");
                        Rec.TestField("Transaction Type");


                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                        // Message('next step is to export the application to an excel sheet \n finally generate the cheque register');

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
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        if Rec.Status <> Rec.Status::"Pending Approval" then
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

                    trigger OnAction()
                    var
                    //// //ApprovalEntries: Page "Approval Entries";
                    // approvalsMgmt: Codeunit 1535;
                    begin

                        // // ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                        Message('Opens all approval entries sent for this application');
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
        UpdateControl;
    end;

    trigger OnInit()
    begin
        UpdateControl;
    end;

    var
        CheqReg: Record "Cheques Register";
        IncrNo: Code[10];
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        Vend: Record "Savings Accounts";
        AccountTypeS: Record "Product Factory";
        AvailableBal: Decimal;
        Charges: Record "Transaction Charges";
        GenSetup: Record "General Set-Up";
        ChequeSetUp: Record "Cheque Set Up";
        "TOTAL CHARGES": Decimal;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        DocMustbeOpen: Label 'This application request must be open';
        DocMustbePending: Label 'This application request must be Pending';
        chbktype: Boolean;
        beginCh: Boolean;
        endCh: Boolean;
        accNo: Boolean;
        SaccoT: Codeunit "Sacco Transactions";
        TransType: Boolean;
        MobNo: Code[10];
        SendSMS: Codeunit SendSms;

        Source: Enum "SMS Source";
        Text0001: Label 'Your cheque book is ready for collection ';
        msg: Text;

    local procedure SetControlAppearance()
    var
    // ApprovalsMgmt: Codeunit 1535;
    begin

        // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;

    //[Scope('OnPrem')]
    procedure UpdateControl()
    begin

        if Rec.Status = Rec.Status::Open then begin
            accNo := true;
            endCh := false;
            beginCh := false;
            chbktype := true;
            TransType := true;
        end;



        if Rec.Status = Rec.Status::"Pending Approval" then begin
            accNo := false;
            endCh := false;
            beginCh := false;
            chbktype := false;
            TransType := false;
        end;


        if Rec.Status = Rec.Status::Rejected then begin
            accNo := false;
            endCh := false;
            beginCh := false;
            chbktype := false;
            TransType := false;

        end;

        if Rec.Status = Rec.Status::Approved then begin
            accNo := false;
            endCh := true;
            beginCh := true;
            chbktype := false;
            TransType := false;

        end;


        if Rec."Cheque Register Generated" = true then begin
            accNo := false;
            endCh := false;
            beginCh := false;
            chbktype := false;
            TransType := false;

        end;
    end;
}

