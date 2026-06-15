page 52185763 "Member List"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Members;
    UsageCategory = Lists;
    CardPageId = "Member Single";
    ApplicationArea = Basic, Suite;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payroll/Staff No."; Rec."Payroll/Staff No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("FOSA Account"; Rec."FOSA Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("FOSA Savings"; Rec."FOSA Savings")
                {
                    ToolTip = 'Specifies the value of the Ordinary Savings Account No.';
                    ApplicationArea = Basic, Suite;
                }

                field("Transactional Mobile Number"; Rec."Transactional Mobile Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Recruited By"; Rec."Recruited By")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Subflag; Rec.Subflag)
                {
                    Caption = 'Sub Status';
                    Editable = false;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Branch Name"; Rec."Branch Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("P.I.N Number"; Rec."P.I.N Number")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("FOSA Loan Balance"; FosaLoanBalance)
                {
                    ToolTip = 'Specifies the value of the FOSA Loan Balance field.';
                    ApplicationArea = Basic, Suite;
                }
                field("Bosa Loan Balance"; BosaLoanBalance)
                {
                    ToolTip = 'Specifies the value of the BOSA Loan Balance field.';
                    ApplicationArea = Basic, Suite;
                }
                field("Total Loan Balances"; Rec."Loan Balances")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("BOSA Savings"; Rec."BOSA Deposit")
                {
                    ToolTip = 'Specifies the value of the BOSA Savings.';
                    ApplicationArea = Basic, Suite;
                }

                field("Share Capital"; Rec."Share Capital")
                {
                    ToolTip = 'Specifies the value of the Share Capital.';
                    ApplicationArea = Basic, Suite;
                }
                field("Total Savings"; Rec."Total Savings")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Primary Identification"; Rec."Primary Identification")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Secondary Identification"; Rec."Secondary Identification")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(WithdrawalDate; WithdrawalDate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Withdrawal Date';
                }
                field(Closure; ClosureDate)
                {
                    Caption = 'Closure Date';
                    ToolTip = 'Specifies the date when the member was closed.';
                    ApplicationArea = Basic, Suite;
                }
                field("Has NOK"; Rec."Has NOK")
                {
                    Caption = 'Has Next of KIN';
                }
                field("Old Account Name"; Rec."Old Account Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field(DigitCustodian; GetDigitCustodian(rec."No."))
                // {
                //     Caption = 'Digit Custodian';
                //     Editable = false;
                // }
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action(ExportMemberListing)
            {
                Caption = 'Export Member Listing';
                ApplicationArea = Suite;
                runobject = query "Members Listing";
            }
        }

    }

    var
        FosaLoanBalance: Decimal;

        BosaLoanBalance: Decimal;
        LoansProcess: Codeunit "Loans Process";
        WithdrawalDate: Date;
        ClosureDate: Date;
        Withdrawal: Record "Member withdrawal Notice";
        Closure: Record "Membership Closure";

    trigger OnAfterGetRecord()
    begin
        FosaLoanBalance := LoansProcess.GetTotalMemberLoanBalancePerUnit(Rec."No.", 1, Today);
        BosaLoanBalance := LoansProcess.GetTotalMemberLoanBalancePerUnit(Rec."No.", 2, Today);

        Withdrawal.Reset();
        withdrawal.SetRange("Member No.", Rec."No.");
        if Withdrawal.FindFirst() then begin
            WithdrawalDate := Withdrawal."Date Entered";
        end;

        Closure.Reset();
        Closure.SetRange("Member No.", Rec."No.");
        if Closure.FindFirst() then begin
            ClosureDate := Closure."Date Posted";
        end;

    end;

    // procedure GetDigitCustodian(MemNo: code[50]): code[1]
    // begin
    //     if MemNo = '' then
    //         exit('')
    //     else
    //         exit(CopyStr(MemNo, StrLen(MemNo), 1));
    // end;



}

