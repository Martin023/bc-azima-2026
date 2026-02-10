page 52185806 "Banking User Setup"
{
    SourceTable = "Banking User Template";
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(UserID; Rec.UserID)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cashier Journal Template"; Rec."Cashier Journal Template")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cashier Journal Batch"; Rec."Cashier Journal Batch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Salary Journal Template"; Rec."Salary Journal Template")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Salary Journal Batch"; Rec."Salary Journal Batch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Default  Bank"; Rec."Default  Bank")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bankers Cheque Account"; Rec."Bankers Cheque Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cheque Clearance Account"; Rec."Cheque Clearance Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("No of Open Transactions"; Rec."No of Open Transactions")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loans Template"; Rec."Loans Template")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loans Batch"; Rec."Loans Batch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Investment Interest Template"; Rec."Investment Interest Template")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Investment Interest Batch"; Rec."Investment Interest Batch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Fixed/Call Journal Template"; Rec."Fixed/Call Journal Template")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Fixed/Call Journal Batch"; Rec."Fixed/Call Journal Batch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Check Off Template"; Rec."Check Off Template")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Check Off Batch"; Rec."Check Off Batch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Max. Deposit Limit"; Rec."Max. Deposit Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Max. Withdrawal Limit"; Rec."Max. Withdrawal Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Max. Cashier Withholding"; Rec."Maximum Withholding")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Max. Bankers Chequel Limit"; Rec."Max. Bankers Chequel Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Min. Balance"; Rec."Minimum Balance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Excess Account"; Rec."Excess Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shortage Account"; Rec."Shortage Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("MPESA Disbursement A/c"; Rec."MPESA Disbursement A/c")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cheque Disbursement A/c"; Rec."Cheque Disbursement A/c")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bills Template"; Rec."Bills Template")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bills Batch"; Rec."Bills Batch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Account Template"; Rec."Interest Account Template")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Account Batch"; Rec."Interest Account Batch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Over Draft Template"; Rec."Over Draft Template")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Over Draft Batch"; Rec."Over Draft Batch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transfer Journal Template"; Rec."Transfer Journal Template")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transfer Journal Batch"; Rec."Transfer Journal Batch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ATM Charges Journal Template"; Rec."ATM Charges Journal Template")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ATM Charges Journal Batch"; Rec."ATM Charges Journal Batch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cheque Discounting Template"; Rec."Cheque Discounting Template")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cheque Discounting Batch"; Rec."Cheque Discounting Batch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Delegates Pay.Journal Template"; Rec."Delegates Pay.Journal Template")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Delegates Pay. Journal Batch"; Rec."Delegates Pay. Journal Batch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Accrual. Fee.Journal Template"; Rec."Accrual. Fee.Journal Template")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Accrual. Fee. Journal Batch"; Rec."Accrual. Fee. Journal Batch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Supervisor Mobile No"; Rec."Supervisor Mobile No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Supervisor E-Mail"; Rec."Supervisor E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Recovery Batch"; Rec."Loan Recovery Batch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Recovery Template"; Rec."Loan Recovery Template")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Staff Welfare Batch"; Rec."Staff Welfare Batch")
                {

                }
                field("Staff Welfare Template"; Rec."Staff Welfare Template")
                {

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code") { }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code") { }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        FnRestrictAccess
    end;

    var
        StatusPermission: Record "Status Change Permissions.";

    //[Scope('OnPrem')]
    procedure FnRestrictAccess()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestrictViewTxt: Label 'You do Not have Permission on View,Read,Modify on this Page. Contact system administrator for assistance. %1-%2';
    begin
        StatusPermission.Reset;
        StatusPermission.SetRange("User ID", DATABASE.UserId);
        StatusPermission.SetRange("Edit Setup", true);
        if not StatusPermission.Find('-') then begin
            CurrPage.Editable := false;
        end else begin
            CurrPage.Editable := true;
        end;
    end;
}

