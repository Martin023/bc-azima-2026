page 52186632 "prBoard Employees Card"
{
    PageType = Card;
    SourceTable = "Board members";
    Caption = 'Board Member Payroll';
    PromotedActionCategories = 'New,Process,Reports,Payment Process,Workflows,Check Budgetary Availability';

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
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Mail; Rec.Mail)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Status"; Rec."Member Status")
                {
                    ApplicationArea = all;
                }
                field("Board Member"; Rec."Board Member")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field("Bank Account Number"; Rec."Bank Account Number")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Fosa Account No.';
                    Visible = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("National ID"; Rec."National ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("P.I.N"; Rec."P.I.N")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = all;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Total earnings"; Rec."Total earnings")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("Board Retainer"; Rec."Board Retainer")
                {
                    ApplicationArea = all;
                }
                field("Withholding Tax Amount"; Rec."Withholding Tax Amount")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
            }
            part(Control18; "Board Payroll Deductions")
            {
                SubPageLink = "Document No" = FIELD("No.");
            }
        }
    }


    actions
    {
        area(Processing)
        {

            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = SendAppEdi;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        BoardLine: Record "Board Payroll Deductions";
                        AmountToDe: Decimal;
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if Rec.Status <> Rec.Status::Open then
                            Error(DocMustbeOpen);
                        Rec.TestField(Rec.Description);
                        BoardLine.Reset();
                        BoardLine.SetRange("Document No", Rec."No.");
                        if BoardLine.FindFirst() then begin
                            BoardLine.CalcSums("Amount LCY");
                            AmountToDe := BoardLine."Amount LCY";
                        end;
                        if Rec."Total earnings" + Rec."Board Retainer" < AmountToDe then
                            Error('Total Earnings cannot offset the deductions');
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CancelApp;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
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
                    Enabled = CancelApp;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action("Re-Open Document")
                {
                    ApplicationArea = all;
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        rec.TestField(Status, Rec.Status::Approved);
                        if Confirm('Do you want to Re-open the document?') = true then begin
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify();
                        end;
                    end;
                }
            }

            action("Assign Earnings")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Board Allowance';
                Image = List;
                Promoted = true;
                PromotedCategory = Category4;
                Enabled = SendAppEdi;
                PromotedIsBig = true;
                RunObject = page "prBoard Payment";
                RunPageLink = "No." = FIELD("No.");
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Rec.CalcFields("Total earnings");
                end;
            }

            action("Process Payroll")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Process Payroll';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Enabled = ProcessMo;
                trigger OnAction()
                begin
                    Rec.TestField("Member No.");

                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then;
                    SelectedPeriod := objPeriod."Date Opened";

                    SalCard.Get(Rec."No.");
                    BoardTrans.Reset();

                    //Use CODEUNIT

                    HrEmployee.Reset;
                    HrEmployee.SetRange(HrEmployee."Board Member", true);
                    HrEmployee.SetRange(HrEmployee."No.", Rec."No.");
                    if HrEmployee.Find('-') then begin
                        //Progress Window
                        ProgressWindow.Open('Processing Salary for Board Member No. #1#######');
                        repeat
                            //Progress Window
                            Sleep(100);
                            //Progress Window
                            //Suspended
                            //IF NOT SalCard. THEN BEGIN
                            // ProgressWindow.Update(1, HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' + HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name");
                            //END;
                            payrollprocessingCasual.fnProcesspayroll(SelectedPeriod, HrEmployee."No.", HrEmployee."Pays SSF?");

                        until HrEmployee.Next = 0;
                        ////Progress Window
                        ProgressWindow.Close;
                    end;
                    //CODEUNIT

                    Commit;

                    //payrollprocessing.pa
                    LoanProcess.PostPayRoll(Rec."No.");
                    Rec.Posted := true;
                    Rec.Modify(true);


                end;

            }
            action(Print)
            {
                PromotedCategory = Category4;
                ProMOTED = true;
                Image = Print;
                trigger OnAction()
                begin
                    BoardTransactions.Reset;
                    BoardTransactions.SetRange(BoardTransactions."No.", Rec."No.");
                    BoardTransactions.SetRange(BoardTransactions.Date, SelectedPeriod);
                    REPORT.Run(REPORT::"prBoard Payslip", true, false, BoardTransactions);
                    //
                    /*
                    // employees.RESET;
                    // employees.SETRANGE(employees."No.", "No.");
                    // //REPORT.Run(REPORT::"prBoard Payslip 2", TRUE, FALSE, employees);
                    // */
                end;

            }
            action("Check Budgetary Availability")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Check Budgetary Availability';
                Image = Balance;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    BCSetup: Record "Budgetary Control Setup";
                begin
                    if (Rec.Status = Rec.Status::Approved) then begin
                        Error('Document must not be Approved');
                    end;
                    BCSetup.Get;
                    if not BCSetup.Mandatory then
                        if Confirm('Check Budget Availability is not mandatory. Do you wish to continue with the check?', false) = false then begin exit end;

                    // if not AllFieldsEntered then
                    //     Error('Some of the Key Fields have not been Entered please RECHECK your entries');
                    //First Check whether other lines are already committed.
                    Commitments.Reset;
                    Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::"Board Retainer");
                    Commitments.SetRange(Commitments."Document No.", Rec."No.");
                    if Commitments.Find('-') then begin
                        if Confirm('Lines in this Document appear to be committed do you want to re-commit?', false) = false then begin exit end;
                        Commitments.Reset;
                        Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::"Board Retainer");
                        Commitments.SetRange(Commitments."Document No.", Rec."No.");
                        Commitments.DeleteAll;
                    end;
                    Commitments.Reset;
                    Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::"Board Earnings");
                    Commitments.SetRange(Commitments."Document No.", Rec."No.");
                    if Commitments.Find('-') then begin
                        if Confirm('Lines in this Document appear to be committed do you want to re-commit?', false) = false then begin exit end;
                        Commitments.Reset;
                        Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::"Board Earnings");
                        Commitments.SetRange(Commitments."Document No.", Rec."No.");
                        Commitments.DeleteAll;
                    end;
                    CheckBudgetAvail.CheckBoardPayments(Rec);
                end;
            }
            action("Cancel Budget Commitment")
            {
                ApplicationArea = Basic;
                Image = CancelAllLines;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    if not Confirm('Are you sure you want to Cancel All Commitments Done for this document', true, Rec."No.") then
                        Error('Budget Availability Check and Commitment Aborted');

                    Commitments.Reset;
                    //Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::"Board Retainer");
                    Commitments.SetRange(Commitments."Document No.", Rec."No.");
                    Commitments.DeleteAll;
                    //Tag all the Purchase Line entries as Uncommitted
                    employees.Reset;
                    employees.SetRange(employees."No.", Rec."No.");
                    if employees.Find('-') then begin
                        repeat
                            employees.Committed := false;
                            employees.Modify;
                        until employees.Next = 0;
                    end;
                    BoardPayLines.Reset;
                    BoardPayLines.SetRange(BoardPayLines."No.", employees."No.");
                    if BoardPayLines.Find('-') then begin
                        repeat
                            BoardPayLines.Committed := false;
                            BoardPayLines.Modify;
                        until BoardPayLines.Next = 0;
                        Message('Commitments Cancelled Successfully for Doc. No %1', Rec."No.");
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        Rec.CalcFields("Total earnings");

        case Rec.Status of
            rec.Status::Open:
                begin
                    CurrPage.Editable := true;
                    ProcessMo := false;
                    SendAppEdi := true;
                    CancelApp := false;
                    RejectM := false;
                end;
            rec.Status::Approved:
                begin
                    CurrPage.Editable := false;
                    ProcessMo := true;
                    SendAppEdi := false;
                    CancelApp := false;
                    RejectM := true;
                end;
            rec.Status::Pending:
                begin
                    CurrPage.Editable := false;
                    ProcessMo := false;
                    SendAppEdi := false;
                    CancelApp := true;
                    RejectM := true;
                end;
        end;
        if Rec.Posted = true then begin
            CurrPage.Editable := false;
            ProcessMo := false;
            SendAppEdi := false;
            CancelApp := false;
            RejectM := false;
        end;
        if (Rec.Status = Rec.Status::Pending) or (Rec.Status = Rec.Status::Approved) then
            CurrPage.Editable := false;
        if Rec.Posted = true then
            CurrPage.Editable := false;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Total earnings");
        case Rec.Status of
            rec.Status::Open:
                begin
                    CurrPage.Editable := true;
                    ProcessMo := false;
                    SendAppEdi := true;
                    CancelApp := false;
                    RejectM := false;
                end;
            rec.Status::Approved:
                begin
                    CurrPage.Editable := false;
                    ProcessMo := true;
                    SendAppEdi := false;
                    CancelApp := false;
                    RejectM := true;
                end;
            rec.Status::Pending:
                begin
                    CurrPage.Editable := false;
                    ProcessMo := false;
                    SendAppEdi := false;
                    CancelApp := true;
                    RejectM := true;
                end;
        end;
        if Rec.Posted = true then begin
            CurrPage.Editable := false;
            ProcessMo := false;
            SendAppEdi := false;
            CancelApp := false;
            RejectM := false;
        end;
        if (Rec.Status = Rec.Status::Pending) or (Rec.Status = Rec.Status::Approved) then
            CurrPage.Editable := false;
        if Rec.Posted = true then
            CurrPage.Editable := false;
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec.CalcFields("Total earnings");
        if (Rec.Status = Rec.Status::Pending) or (Rec.Status = Rec.Status::Approved) then
            CurrPage.Editable := false;
        if Rec.Posted = true then
            CurrPage.Editable := false;

    end;

    // procedure AllFieldsEntered(): Boolean
    // var
    //     PayLines: Record "Payment Line";
    // begin
    //     AllKeyFieldsEntered := true;
    //     PayLines.Reset;
    //     PayLines.SetRange(PayLines.No, Rec."No.");
    //     if PayLines.Find('-') then begin
    //         repeat
    //             if (PayLines."Account No." = '') or (PayLines.Amount = 0) then
    //                 AllKeyFieldsEntered := false;
    //         until PayLines.Next = 0;
    //         exit(AllKeyFieldsEntered);
    //     end;
    // end;

    var
        BoardTransactions: Record "PR Board Transactions";
        employees: Record "Board members";
        payrollprocessingCasual: Codeunit "PrPayroll Processing Casual";
        objEmp: Record "HR Employees";
        SalCard: Record "Board members";
        objPeriod: Record "PR Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodMonth: Integer;
        PeriodYear: Integer;
        LoanProcess: Codeunit "Loans Process";
        BoardTrans: Record "Board Payroll Deductions";
        HrEmployee: Record "Board members";
        Employee: Record "Board members";
        ProgressWindow: Dialog;
        prPeriodTransactions: Record "PR Board Transactions";
        Txt0000: Label 'Status must be approved before rescheduling';
        PeriodicActivities: Codeunit "Periodic Activities";
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        DocMustbeOpen: Label 'This application request must be open';
        DocMustbePending: Label 'This application request must be Pending';
        LoanSch: Record Loans;
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book",Birthday,"Defaulter - Notice 1","Defaulter - Notice 2","Defaulter - Notice 3",Statement,"Loan Cleared I","Loan Cleared II","Loan Reschedule","Loan Reschedule Guar";
        Cust: Record Members;
        SendSMS: Codeunit SendSms;
        LoanGua: Record "Loan Guarantors and Security";
        InterestParams: Boolean;
        RescheduleParams: Boolean;
        ProcessMo: Boolean;
        SendAppEdi: Boolean;
        CancelApp: Boolean;
        RejectM: Boolean;
        LoansProcess: Codeunit "Loans Process";
        Commitments: RECORD Committment;
        CheckBudgetAvail: Codeunit "Budgetary Control";
        AllKeyFieldsEntered: Boolean;
        BoardPayLines: Record "PR Board Transactions";

}

