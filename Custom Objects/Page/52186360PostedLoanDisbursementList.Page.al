page 52186360 "Posted Loan Disbursement List"
{
    CardPageID = "Loan Disbursement Header";
    Editable = false;
    PageType = List;
    SourceTable = "Loan Disbursement Header";
    SourceTableView = WHERE(Posted = FILTER(true));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

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
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Prepared By"; Rec."Prepared By")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Created By';
                }
            }
        }
    }

    actions
    {
    }
}

