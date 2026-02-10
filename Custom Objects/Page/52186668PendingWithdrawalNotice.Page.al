page 52186668 "Pending Withdrawal Notice"
{
    CardPageID = "Member withdrawal Notice";
    Editable = false;
    PageType = List;
    SourceTable = "Member withdrawal Notice";
    SourceTableView = WHERE(Status = CONST(Pending));
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
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reason for withdrawal"; Rec."Reason for withdrawal")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Withdrawal Notice Date"; Rec."Withdrawal Notice Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Actioning Department"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Actioning Department';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Modified"; Rec."Date Modified")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Maturity Date"; Rec."Maturity Date")
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

