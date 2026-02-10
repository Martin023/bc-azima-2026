page 52187012 "Posted Shares Transfer List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Share Capital Transfer Buffer";
    InsertAllowed = false;
    DeleteAllowed = false;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Source Account No"; Rec."Source Account No")
                {
                    ApplicationArea = all;
                }
                field("Source Member Name"; Rec."Source Member Name")
                {
                    ApplicationArea = all;
                }
                field("Destinaton Acc No"; Rec."Destinaton Acc No")
                {
                    ApplicationArea = all;
                }
                field("Destination Member Name"; Rec."Destination Member Name")
                {
                    ApplicationArea = all;

                }
                field("Destination Balance"; Rec."Destination Balance")
                {
                    ApplicationArea = all;
                }
                field(Transfered; Rec.Transfered)
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