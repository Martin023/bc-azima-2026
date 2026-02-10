page 52185787 "MBanking Loans"
{
    DeleteAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "M-SACCO Loans";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry no"; Rec."Entry no")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(DocumentNo; Rec.DocumentNo)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("STO Amount"; Rec."STO Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total loans"; Rec."Total loans")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Latest Salary Amount"; Rec."Latest Salary Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Qualified Amount';
                }
                field("Loan Code"; Rec."Loan Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Ghris Password"; Rec."Ghris Password")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }
}

