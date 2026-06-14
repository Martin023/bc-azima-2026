namespace AZIMA.AZIMA;

page 52185783 "Loans Factbox"
{
    ApplicationArea = All;
    Caption = 'Loans Factbox';
    PageType = ListPart;
    SourceTableView = where(posted = const(true), "Total Balance" = filter(> 0));
    SourceTable = Loans;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Loan No."; Rec."Loan No.")
                {
                    ToolTip = 'Specifies the value of the Loan No. field.', Comment = '%';
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ToolTip = 'Specifies the value of the Loan Product Type field.', Comment = '%';
                }
                field(Repayment; Rec.Repayment)
                {
                    ToolTip = 'Specifies the value of the Repayment field.', Comment = '%';
                }
                field("Loan Principle Repayment"; Rec."Loan Principle Repayment")
                {
                    ToolTip = 'Specifies the value of the Loan Principle Repayment field.', Comment = '%';
                }
                field("Loan Interest Repayment"; Rec."Loan Interest Repayment")
                {
                    ToolTip = 'Specifies the value of the Loan Interest Repayment field.', Comment = '%';
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ToolTip = 'Specifies the value of the Outstanding Balance field.', Comment = '%';
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ToolTip = 'Specifies the value of the Outstanding Interest field.', Comment = '%';
                }
                field("Total Balance"; Rec."Total Balance")
                {
                    ToolTip = 'Specifies the value of the Total Balance field.', Comment = '%';
                }
            }
        }
    }
}
