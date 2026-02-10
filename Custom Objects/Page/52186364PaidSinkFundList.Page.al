page 52186364 "Paid SinkFund List"
{
    CardPageID = "SinkFund Notice";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "SinkFund Report Information";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    SourceTableView = where(Posted = const(true), "Claim Type" = filter(" " | "BBF - Dependant Claim" | "BBF - Principle Claim"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Claim Type"; Rec."Claim Type")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Date of Death"; Rec."Date of Death")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Deceased Person"; Rec."Deceased Person")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                { ApplicationArea = Basic, Suite; }

                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("BBF Claim Amout"; Rec."BBF Claim Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Captured By"; Rec."Captured By")
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

