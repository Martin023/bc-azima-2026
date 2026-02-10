page 52185910 "Cash Office Setup"
{
    PageType = Card;
    SourceTable = "Cash Office Setup";
    ApplicationArea = Basic, Suite;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Numbering)
            {
                Caption = 'Numbering';
                group("FOSA Management")
                {
                    Caption = 'FOSA Management';
                    field("InterBank Transfer No."; Rec."InterBank Transfer No.")
                    {
                        ApplicationArea = Basic, Suite;
                    }

                }
                field("Normal Payments No"; Rec."Normal Payments No")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Voucher';
                }
                field("FOSA Payments No"; Rec."FOSA Payments No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cheque Reject Period"; Rec."Cheque Reject Period")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Minimum Cheque Creation Amount"; Rec."Minimum Cheque Creation Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Petty Cash Payments No"; Rec."Petty Cash Payments No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Board PVs Nos."; Rec."Board PVs Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Board PVs No."; Rec."Board PVs No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Delegate  PVs Nos."; Rec."Delegate  PVs Nos.")
                {
                    Caption = 'Delegate PVs Nos.';
                    ApplicationArea = Basic, Suite;
                }
                field("Current Budget"; Rec."Current Budget")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Current Budget Start Date"; Rec."Current Budget Start Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Current Budget End Date"; Rec."Current Budget End Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bank Deposit No."; Rec."Bank Deposit No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Surrender Template"; Rec."Surrender Template")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Surrender  Batch"; Rec."Surrender  Batch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Receipts No"; Rec."Receipts No")
                {
                    Caption = 'Receipts No';
                    ApplicationArea = Basic, Suite;
                }
                field("Cash Receipt Nos"; Rec."Cash Receipt Nos")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cashier Transfer Nos"; Rec."Cashier Transfer Nos")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Default Bank Deposit Slip A/C"; Rec."Default Bank Deposit Slip A/C")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Imprest Req No"; Rec."Imprest Req No")
                {
                    Caption = 'Imprest Req No.';
                    ApplicationArea = Basic, Suite;
                }
                field("Imprest Surrender No"; Rec."Imprest Surrender No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Staff Claim No."; Rec."Staff Claim No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Other Staff Advance No."; Rec."Other Staff Advance No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Staff Advance Surrender No."; Rec."Staff Advance Surrender No.")
                {
                    Caption = 'Other Staff Adv. Surrender No';
                    ApplicationArea = Basic, Suite;
                }
                field("Use Central Payment System"; Rec."Use Central Payment System")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Case Number"; Rec."Case Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Damage Number"; Rec."Damage Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Surety No"; Rec."Surety No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Journal Voucher Nos"; Rec."Journal Voucher Nos")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Grant Surrender Nos"; Rec."Grant Surrender Nos")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cash Purchases"; Rec."Cash Purchases")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Overtime Claim Nos"; Rec."Overtime Claim Nos")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Benevolent Claim Nos"; Rec."Benevolent Claim Nos")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Insurance Receivable Claim"; Rec."Insurance Receivable Claim")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Insurance Claim Received"; Rec."Insurance Claim Received")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Permission Requisition Nos"; Rec."Permission Requisition Nos")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Computer Asset Requisition"; Rec."Computer Asset Requisition")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sundry Income for Account  Clo"; Rec."Sundry Income for Account  Clo")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Cash Limit")
            {
                Caption = 'Cash Limit';
                field("Apply Cash Expenditure Limit"; Rec."Apply Cash Expenditure Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Expenditure Limit Amount(LCY)"; Rec."Expenditure Limit Amount(LCY)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Prompt Cash Reimbursement"; Rec."Prompt Cash Reimbursement")
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
        UserSetup.GetDefaultSalesAmountApprovalLimit();
    end;

    var
        StatusPermissions: Record "Status Change Permissions.";
        Text000: Label 'You do not have permissions to view This page';
        UserSetup: Record "User Setup";
}

