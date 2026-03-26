namespace AzimaCBS.AzimaCBS;

page 52185454 "Loan Topup ListPart"
{
    ApplicationArea = All;
    Caption = 'Loan Topup ListPart';
    PageType = ListPart;
    SourceTable = "Loans Top up";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Loan Top Up"; Rec."Loan Top Up")
                {
                    ToolTip = 'Specifies the value of the Loan Top Up field.', Comment = '%';
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ToolTip = 'Specifies the value of the Loan Type field.', Comment = '%';
                }
                field("Interest Paid"; Rec."Interest Paid")
                {
                    ToolTip = 'Specifies the value of the Interest Paid field.', Comment = '%';
                }
                field("Principle Top Up"; Rec."Principle Top Up")
                {
                    ToolTip = 'Specifies the value of the Principle Top Up field.', Comment = '%';
                }
                field("Total Top Up"; Rec."Total Top Up")
                {
                    ToolTip = 'Specifies the value of the Total Top Up field.', Comment = '%';
                }
                field("Interest Top Up"; Rec."Interest Top Up")
                {
                    ToolTip = 'Specifies the value of the Interest Top Up field.', Comment = '%';
                }
            }
        }
    }
}
