page 52186378 "Salary Agreement Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Salary Agreement";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        SalaryAgreement.Reset;
                        SalaryAgreement.SetRange(SalaryAgreement."Member No", Rec."Member No");
                        SalaryAgreement.SetFilter(Status, '%1|%2', SalaryAgreement.Status::Open, SalaryAgreement.Status::"Pending Approval");
                        if SalaryAgreement.Find('-') then begin
                            if SalaryAgreement.Count > 1 then Error(Text001);

                        end;
                        SalaryAgreement.Reset;
                        SalaryAgreement.SetRange(SalaryAgreement.User, UserId);
                        SalaryAgreement.SetRange(Status, SalaryAgreement.Status::Open);
                        SalaryAgreement.SetFilter(No, '<>%1', Rec.No);
                        SalaryAgreement.SetRange("Member No", Rec."Member No");
                        if SalaryAgreement.FindFirst then
                            Error('You Already Have an Unused Open Card %1 for the Same Member %2', SalaryAgreement.No, Rec."Member No");
                    end;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Payroll No"; Rec."Payroll No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Ministry; Rec.Ministry)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Fosa Account No"; Rec."Fosa Account No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Region; Rec.Region)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("With Effect From"; Rec."With Effect From")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        if Rec.Category = Rec.Category::Variation then
                            ShowAmount := true else
                            ShowAmount := false;
                    end;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ShowAmount;
                }
                field("Date Captured"; Rec."Date Captured")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Status"; Rec."Member Status")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Rejection Reason"; Rec."Rejection Reason")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Other Information")
            {
                Caption = 'Other Information';
                field("Activity Code"; Rec."Activity Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Recruited by Type"; Rec."Recruited by Type")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        if Rec."Recruited by Type" = Rec."Recruited by Type"::Self then
                            ViewReby := false else
                            ViewReby := true;
                    end;
                }
                field("Recruited By"; Rec."Recruited By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ViewReby;
                }
                field("Recruited By Name"; Rec."Recruited By Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(User; Rec.User)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
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
                    //// ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    NextofKinError: Label 'You must specify next of Kin for this application.';
                begin
                    Rec.TestField(Status, Rec.Status::Open);

                    VarVariant := Rec;
                    // if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                    //     CustomApprovals.OnSendDocForApproval(VarVariant);
                    Month := Date2DMY(Rec."With Effect From", 2);
                    Year := Date2DMY(Rec."With Effect From", 3);
                    Members.Get(Rec."Member No");
                    //SendSms.SendSms(SourceType::"Salary Agreement", Members."Phone No.", 'Dear ' + Members."First Name" + ', we are in receipt of your request to change salary pay point to Harambee FOSA. The same shall be effected in the month of' + Format(Month) + '/'
                    // +
                    // Format(Month) + '. Thank you for patronizing our services. For Help Call 0709943000'
                    //             , "Fosa Account No", "Fosa Account No", false);
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category9;

                trigger OnAction()
                var
                //// ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    Rec.TestField(Status, Rec.Status::"Pending Approval");
                    VarVariant := Rec;
                    // if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                    //     CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            action("Approvals.")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category9;

                trigger OnAction()
                // var
                begin
                    message('This feature is not yet available');
                end;

                //     // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                // begin
                //     // ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                // end;
            }
            action(Reject)
            {
                ApplicationArea = Basic, Suite;
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::"Pending Approval");
                    Rec.TestField("Rejection Reason");
                    if Rec.Status = Rec.Status::"Pending Approval" then begin
                        if Confirm('Are you sure you want to reject', false) = true then begin
                            Rec.Status := Rec.Status::Rejected;
                            Rec.Modify;
                        end;
                    end;
                end;
            }
            action(Reopen)
            {
                ApplicationArea = Basic, Suite;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if (Rec.Status = Rec.Status::Rejected) or (Rec.Status = Rec.Status::Rejected) then begin
                        if Confirm('Are You sure you want to Reopen this document', false) = true then begin
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;
                        end;
                    end;
                end;
            }
            action("Download Payslip")
            {
                ApplicationArea = Basic, Suite;
                Image = Note;
                Promoted = true;

                trigger OnAction()
                var
                    EDMS: Record EDMS;
                    FromFile: Text;
                    Name: Text;
                    url: Text;
                begin
                    EDMS.Reset;
                    EDMS.SetRange(Key, EDMS.Key::"Appraisal File");
                    if EDMS.FindFirst then begin
                        url := EDMS."url path";
                        FromFile := url + 'Payslip - ' + Rec."Member No" + '.pdf';
                        Name := 'Payslip - ' + Rec."Member No";
                        //here
                        // if Exists(FromFile) then
                        //     Download(FromFile, 'Payslip', '', 'Text file(*.pdf)|*.pdf', Name)
                        // else
                        //     Message('The file you are looking for is not available');
                    end;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SalaryAgreement.Reset;
        SalaryAgreement.SetRange(SalaryAgreement.User, UserId);
        SalaryAgreement.SetRange(Status, SalaryAgreement.Status::Open);
        SalaryAgreement.SetRange("Member No", '');
        if SalaryAgreement.FindFirst then
            Error('You Already Have an Unused Open Card %1', SalaryAgreement.No);
    end;

    trigger OnOpenPage()
    begin

        if Rec.Category = Rec.Category::Variation then
            ShowAmount := true else
            ShowAmount := false;
        if Rec."Recruited by Type" = Rec."Recruited by Type"::Self then
            ViewReby := false else
            ViewReby := true;
    end;

    var
        ShowAmount: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        // CustomApprovals: Codeunit "Custom Approvals Codeunit";
        // SendSms: Codeunit SendSms;
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book",Internetbanking,CRM,"Member Withdrawal",Delegate,"Salary Agreement";
        Members: Record Members;
        Month: Integer;
        Year: Integer;
        SalaryAgreement: Record "Salary Agreement";
        Text001: Label 'Utilize the Existing Forms';
        ViewReby: Boolean;
        RecordOpen: Code[30];
        GeneralSetUp: Record "General Set-Up";
}

