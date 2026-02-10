page 52185470 "Sky Business Accounts"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Sky Business Accounts";
    SourceTableView = WHERE("Paid Initial Amount" = CONST(false));
    UsageCategory = Lists;
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Business Name"; Rec."Business Name")
                {
                    ApplicationArea = Basic;
                }
                field("Business Location"; Rec."Business Location")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Activated At"; Rec."Activated At")
                {
                    ApplicationArea = Basic;
                }
                field("Form Submitted"; Rec."Form Submitted")
                {
                    ApplicationArea = Basic;
                }
                field("Paid Initial Amount"; Rec."Paid Initial Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Session ID"; Rec."Session ID")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
        }
    }

    var
        SavingsAccounts: Record "Savings Accounts";
        Members: Record Members;
        SavAcc: Record "Savings Accounts";
        PhoneNumber: Text;
        msg: Text;
        //SkyMbanking: Codeunit "Sky Mbanking";
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
}

