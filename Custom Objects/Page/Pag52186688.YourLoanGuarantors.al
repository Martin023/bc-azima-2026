namespace KenpipeCBS.KenpipeCBS;

page 52186688 "Your Loan Guarantors"
{
    ApplicationArea = All;
    Caption = 'Your Loan Guarantors';
    PageType = List;
    SourceTable = "Loan Guarantors and Security";

    UsageCategory = Lists;
    editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No field.', Comment = '%';
                }
                field("Savings Account No./Member No."; Rec."Savings Account No./Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Savings Account No./Member No. field.', Comment = '%';
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Amount Guaranteed"; Rec."Amount Guaranteed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Percentage Guaranteed field.', Comment = '%';
                }

                field("Percentage Guaranteed"; Rec.PercentageGur)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Percentage Guaranteed field.', Comment = '%';
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan No field.';
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Type field.';
                }
                field("Loan Product Name"; Rec."Loan Product Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Product Name field.', Comment = '%';
                }
                field("Total Loan Balance"; Rec."Total Loan Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Loan Balance field.', Comment = '%';
                }
            }
        }
    }
}
