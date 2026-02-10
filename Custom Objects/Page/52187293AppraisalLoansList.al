page 52187293 "Appraisal Loans List_BL"
{
    CardPageID = "Loan Application Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    Caption = 'Appraisal Loans List(Business Loans)';
    SourceTable = Loans;
    SourceTableView = WHERE(Posted = CONST(false), "Source Unit" = filter("BUSINESS LOANS"),
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
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic, Suite;
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
        area(processing)
        {
            action(Post)
            {
                ApplicationArea = Basic, Suite;
                Image = Post;
                Visible = false;
                trigger OnAction()
                begin
                    rec.TestField(Posted, false);
                    rec.TestField(Status, rec.Status::Approved);

                    //Posting.PostLoanNormal();

                    Posting.PostLoanNormal(rec."Loan No.");
                    //Send SMS when Topup

                    LoansTopUp.Reset;
                    LoansTopUp.SetRange(LoansTopUp."Loan No.", rec."Loan No.");
                    if LoansTopUp.FindFirst then begin
                        repeat
                            LoanGuar.Reset;
                            LoanGuar.SetRange("Loan No", LoansTopUp."Loan Top Up");
                            LoanGuar.SetRange("Self Guarantee", false);
                            if LoanGuar.FindFirst then begin
                                if Loans2.Get(LoanGuar."Loan No") then begin
                                    ProductType := Loans2."Loan Product Type Name";
                                    AppAmount := Loans2."Approved Amount";
                                end;
                                repeat
                                    if Members.Get(LoanGuar."Member No") then
                                        CompInfo.Get;
                                // SendSms.SendSms(SourceType::"Loan Guarantors", Members."Phone No.",
                                // 'Dear ' + LoanGuar.Name + ', The ' + ProductType + ' of Ksh. ' + Format(AppAmount) + ', you had guaranteed ' + LoanGuar."Loanee Name" + ' is now fully repaid.',
                                // Loans2."Loan No.", Loans2."Disbursement Account No", false);

                                until LoanGuar.Next = 0;
                            end;
                        until LoansTopUp.Next = 0;
                    end;



                    //Set FOSA Savings Account to Frozen

                    LoanGuar.Reset;
                    LoanGuar.SetRange(LoanGuar."Loan No", rec."Loan No.");
                    LoanGuar.SetFilter("Guarantor Type", '%1', LoanGuar."Guarantor Type"::Collateral);
                    if LoanGuar.FindFirst then
                        SavingsAccounts.Reset;
                    SavingsAccounts.SetRange("Member No.", LoanGuar."Savings Account No./Member No.");
                    SavingsAccounts.SetRange("Loan Disbursement Account", true);
                    if SavingsAccounts.FindFirst then begin
                        SavingsAccounts.Status := SavingsAccounts.Status::Frozen;
                        SavingsAccounts."Status Change Reason" := 'FROZEN: Refer to Investment Manager';
                        SavingsAccounts.Modify;
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if (rec.Status = rec.Status::Open) and (rec."Application Date" <> 0D) then begin

            if CalcDate('60D', rec."Application Date") >= Today then
                rec.Status := rec.Status::Rejected;
            rec.Modify;
        end;
        rec.FilterGroup(2);
        rec.SetFilter("Application Date", '%1..%2', CalcDate('-3M', Today), Today);
        rec.FilterGroup(0);
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

