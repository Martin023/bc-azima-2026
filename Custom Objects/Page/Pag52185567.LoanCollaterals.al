page 52185567 "Loan Collaterals"
{

    PageType = ListPart;
    SourceTable = "Loan Guarantors and Security";
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'General';
                field("Savings Account No./Member No."; Rec."Savings Account No./Member No.")
                {
                    ApplicationArea = All;
                }
                field("Loanee Name";Rec."Loanee Name")
                {
                    ApplicationArea = All;
                }
                field(Name;Rec.Name)
                {
                    Caption = 'Guarantor Name/Security Description';
                    ApplicationArea = All;
                }
                field("Loan No."; Rec."Loan No")
                {
                    ApplicationArea = All;
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = All;
                }
                field("Collateral Type"; Rec."Guarantor Type")
                {
                    Caption = 'Security Type';
                    ApplicationArea = All;
                }
                field(SecurityNo; Rec."Collateral Reg. No.")
                {
                    ApplicationArea = All;
                }
                field("Collateral Value"; Rec."Collateral Value")
                {
                    ApplicationArea = All;
                }
                field("Member Guaranteed";Rec."Member Guaranteed")
                {
                    ApplicationArea = All;
                }
                field("Amount Guaranteed";Rec."Amount Guaranteed")
                {
                    ApplicationArea = All;
                }
                field(Substituted;Rec.Substituted)
                {
                    ApplicationArea = All;
                }
                field("Substituted By";Rec."Substituted By")
                {
                    ApplicationArea = All;
                }
                field("Date Substituted";Rec."Date Substituted")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
