page 52185911 "Cash Office User Template"
{
    DataCaptionFields = UserID;
    PageType = List;
    SourceTable = "Cash Office User Template";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102758000)
            {
                ShowCaption = false;
                field(UserID; Rec.UserID)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Receipt Journal Template"; Rec."Receipt Journal Template")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Receipt Journal Batch"; Rec."Receipt Journal Batch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Imprest Template"; Rec."Imprest Template")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Imprest  Batch"; Rec."Imprest  Batch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Default Receipts Bank"; Rec."Default Receipts Bank")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Default Petty Cash Bank"; Rec."Default Petty Cash Bank")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Default Payment Bank"; Rec."Default Payment Bank")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payment Journal Template"; Rec."Payment Journal Template")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payment Journal Batch"; Rec."Payment Journal Batch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Petty Cash Template"; Rec."Petty Cash Template")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Petty Cash Batch"; Rec."Petty Cash Batch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Inter Bank Template Name"; Rec."Inter Bank Template Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Inter Bank Batch Name"; Rec."Inter Bank Batch Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bank Pay In Journal Template"; Rec."Bank Pay In Journal Template")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bank Pay In Journal Batch"; Rec."Bank Pay In Journal Batch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Claim Template"; Rec."Claim Template")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Claim  Batch"; Rec."Claim  Batch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Advance Template"; Rec."Advance Template")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Advance  Batch"; Rec."Advance  Batch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Advance Surr Template"; Rec."Advance Surr Template")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Advance Surr Batch"; Rec."Advance Surr Batch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Dim Change Journal Template"; Rec."Dim Change Journal Template")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Dim Change Journal Batch"; Rec."Dim Change Journal Batch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Journal Voucher Template"; Rec."Journal Voucher Template")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Journal Voucher Batch"; Rec."Journal Voucher Batch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Default Cash Sale Customer"; Rec."Default Cash Sale Customer")
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

