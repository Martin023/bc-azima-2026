namespace MNSProjectMwanga.MNSProjectMwanga;

page 52186621 "Detailed Member Balances"
{
    ApplicationArea = All;
    Caption = 'Detailed Member Balances';
    PageType = List;
    SourceTable = "Member FactBox";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.';
                }
                field("BOSA Deposit"; Rec."BOSA Deposit")
                {
                    ToolTip = 'Specifies the value of the BOSA Deposit field.';
                }
                field(BBF; Rec.BBF)
                {
                    ToolTip = 'Specifies the value of the BBF field.';
                }
                field("BBF Contribution"; Rec."BBF Contribution")
                {
                    ToolTip = 'Specifies the value of the BBF Contribution field.', Comment = '%';
                }
                field("BOSA Loans"; Rec."BOSA Loans")
                {
                    ToolTip = 'Specifies the value of the BOSA Loans Issued field.';
                }
                field("BUSINESS Loans"; Rec."BUSINESS Loans")
                {
                    ToolTip = 'Specifies the value of the BUSINESS Loans Issued field.';
                    Visible = false;
                }
                field("Bosa Monthly Contribution"; Rec."Bosa Monthly Contribution")
                {
                    ToolTip = 'Specifies the value of the Bosa Monthly Contribution field.', Comment = '%';
                }
                field("Business Deposits"; Rec."Business Deposits")
                {
                    ToolTip = 'Specifies the value of the Business Deposits field.', Comment = '%';
                }
                field("Entrance Fee"; Rec."Entrance Fee")
                {
                    ToolTip = 'Specifies the value of the Entrance Fee field.', Comment = '%';
                }
                field("FOSA Loans"; Rec."FOSA Loans")
                {
                    ToolTip = 'Specifies the value of the FOSA Loans Issued field.';
                }
                field("FOSA Savings"; Rec."FOSA Savings")
                {
                    ToolTip = 'Specifies the value of the FOSA Savings.';
                }
                field("HR Loans"; Rec."HR Loans")
                {
                    ToolTip = 'Specifies the value of the HR Loans Issued field.';
                }
                field(Risk; Rec.Risk)
                {
                    ToolTip = 'Specifies the value of the Risk field.';
                }
                field("Risk Contribution"; Rec."Risk Contribution")
                {
                    ToolTip = 'Specifies the value of the Risk Contribution field.', Comment = '%';
                }
                field("Share Capital"; Rec."Share Capital")
                {
                    ToolTip = 'Specifies the value of the Share Capital field.';
                }
                field("Total Loans"; Rec."Total Loans")
                {
                    ToolTip = 'Specifies the value of the Total Loans field.', Comment = '%';
                }
                field("Transferred Share Capital"; Rec."Transferred Share Capital")
                {
                    ToolTip = 'Specifies the value of the Transferred Share Capital field.';
                }
                field("Unallocated Funds"; Rec."Unallocated Funds")
                {
                    ToolTip = 'Specifies the value of the Unallocated Funds field.', Comment = '%';
                }
            }
        }
    }
}
