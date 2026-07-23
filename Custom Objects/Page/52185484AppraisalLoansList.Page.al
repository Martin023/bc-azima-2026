page 52185484 "Appraisal Loans List"
{
    CardPageID = "Loans card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = Loans;
    SourceTableView = WHERE(Posted = CONST(false),
                            "Picked Mobile Loan" = FILTER(false),
                            "Sent Online" = FILTER(false),
                            Status = FILTER(Pending));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("CRM Application No."; Rec."CRM Application No.")
                // {
                //     ApplicationArea = all;
                //     Caption = 'CRM NO.';
                // }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Interest; Rec.Interest)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsible Officer"; Rec."Responsible Officer")
                {
                    ApplicationArea = all;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Rejection Reason"; Rec."Loan Rejection Reason")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {

    }

    trigger OnOpenPage()
    begin
        // if (rec.Status = rec.Status::Open) and (rec."Application Date" <> 0D) then begin

        //     if CalcDate('60D', rec."Application Date") >= Today then
        //         rec.Status := rec.Status::Rejected;
        //     rec.Modify;
        // end;
        // rec.FilterGroup(2);
        // rec.SetFilter("Application Date", '%1..%2', CalcDate('-3M', Today), Today);
        // rec.FilterGroup(0);
    end;

    var
        LoansR: Record Loans;
        Posting: Codeunit "Loans Process";
        Batches: Record "Loan Disbursement Header";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        //  CustomApprovals: Codeunit "Custom Approvals Codeunit";
        GetScore: Codeunit "DCS Integration Base";
        EntryNo: Integer;
        Loans: Record Loans;
        DisbLines: Record "Loan Disbursement Lines";
        PartDisb: Record "Partial Disbursement Schedule";
        LoanApp: Record Loans;
        SubseqDisb: Boolean;
        ApprovedEdit: Boolean;
        UserSetup: Record "User Setup";
        LoansTopUp: Record "Loans Top up";
        DSLines: Record "Loan Disbursement Lines";
        LoanGuar: Record "Loan Guarantors and Security";
        Members: Record Members;
        SendSms: Codeunit SendSms;
        CompInfo: Record "Company Information";
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes";
        Loans2: Record Loans;
        ProductType: Text;
        AppAmount: Decimal;
        Message: Text;
        SavingsAccounts: Record "Savings Accounts";
}

