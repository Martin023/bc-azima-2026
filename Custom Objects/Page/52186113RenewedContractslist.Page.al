page 52186113 "Renewed Contracts list"
{
    Caption = 'Renewed Contracts list';
    CardPageID = "Renewed Contracts Card";
    PageType = List;
    SourceTable = Contracts;
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Contract No"; Rec."Contract No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contractor Type"; Rec."Contractor Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contractor No"; Rec."Contractor No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contractor Name"; Rec."Contractor Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Tel No."; Rec."Tel No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contract Description"; Rec."Contract Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contract Amount"; Rec."Contract Sum")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payment Terms"; Rec."Payment Terms")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount Paid"; Rec."Amount Paid")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsible Employee Name"; Rec."Responsible Employee Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Review Interval"; Rec."Renewal Clause")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Type Of Service"; Rec."Type Of Service")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Advocate Name"; Rec."Advocate Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Nature Of Service"; Rec."Nature Of Service")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control40; Notes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control39; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control38; Links)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
    }
}

