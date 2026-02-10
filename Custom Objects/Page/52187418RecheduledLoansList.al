page 52187418 "Resheduled Loans Lists"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Loan Rescheduling";
    SourceTableView = where(Rescheduled = const(true));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;

                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = all;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = all;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = all;
                }
                field("Rescheduled By"; Rec."Rescheduled By")
                {
                    ApplicationArea = all;
                }
                field("Date Rescheduled"; Rec."Date Rescheduled")
                {
                    ApplicationArea = all;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field(Rescheduled; Rec.Rescheduled)
                {
                    ApplicationArea = all;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}