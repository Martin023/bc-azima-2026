page 52187405 "pending ShareCapital List"
{
    PageType = List;
    CardPageId = "Share Capital Transfer Card";
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Share Capital Transfer Buffer";
    //SourceTableView = where(status = filter(Pending));
    Caption = 'Pending Share Capital List';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No"; Rec."Document No")
                {
                    ApplicationArea = All;

                }
                field("Source Account No"; Rec."Source Account No")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Source Member No"; Rec."Source Member No")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                // field("Transaction Type"; Rec."Transaction Type")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                field("Source Member Name"; Rec."Source Member Name")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Source Balance"; Rec."Source Balance")
                {
                    ApplicationArea = all;

                }
                field("Source ID No."; Rec."Source ID No.")
                {
                    ApplicationArea = all;

                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = all;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;

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