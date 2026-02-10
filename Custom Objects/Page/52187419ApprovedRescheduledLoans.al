page 52187419 "Approved Rescheduling List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Loan Rescheduling";
    SourceTableView = where(Status = filter(Approved | Pending), Rescheduled = filter(false));

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
                field("New Amortised"; Rec."New Amortised")
                {
                    ApplicationArea = all;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = all;
                }
                field("New Installments"; Rec."New Installments")
                {
                    ApplicationArea = all;
                }
                field("Rescheduled By"; Rec."Rescheduled By")
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