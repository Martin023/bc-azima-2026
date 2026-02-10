page 52187415 "Guarantors List"
{
    ApplicationArea = All;
    Caption = 'GuarantorsList';
    PageType = List;
    SourceTable = "Loan Guarantors and Security";
    UsageCategory = Lists;
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Loan No"; Rec."Loan No")
                {
                    ToolTip = 'Specifies the value of the Loan No field.';
                }
                field("Guarantor Type"; Rec."Guarantor Type")
                {
                    ToolTip = 'Specifies the value of the Guarantor Type field.';
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ToolTip = 'Specifies the value of the Loan Type field.';
                }
                field("Loanee Name"; Rec."Loanee Name")
                {
                    ToolTip = 'Specifies the value of the Loanee Name field.';
                }
                field("Account No."; Rec."Account No.")
                {
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
                field("Amount Guaranteed"; Rec."Amount Guaranteed")
                {
                    ToolTip = 'Specifies the value of the Amount Guaranteed field.';
                }

                field("Collateral Reg. No."; Rec."Collateral Reg. No.")
                {
                    ToolTip = 'Specifies the value of the Collateral Reg. No. field.';
                }
                field("Collateral Value"; Rec."Collateral Value")
                {
                    ToolTip = 'Specifies the value of the Collateral Value field.';
                }
                field("ID No."; Rec."ID No.")
                {
                    ToolTip = 'Specifies the value of the ID No. field.';
                }


                field("Member Guaranteed"; Rec."Member Guaranteed")
                {
                    ToolTip = 'Specifies the value of the Member Guaranteed field.';
                }


                field("Self Guarantee"; Rec."Self Guarantee")
                {
                    ToolTip = 'Specifies the value of the Self Guarantee field.';
                }

            }
        }
    }
}
