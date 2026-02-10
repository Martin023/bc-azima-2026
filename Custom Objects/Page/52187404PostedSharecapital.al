page 52187404 "Posted Share Capital List"
{
    PageType = List;
    CardPageId = "Share Capital Transfer Card";
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Share Capital Transfer Buffer";
    //SourceTableView = where(Transfered = filter(true), Status = filter(Approved));
    Caption = 'Approved Share Capital';

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
                // field("Transaction Type"; Rec."Transaction Type")
                // {

                // }
                field("Source Member No"; Rec."Source Member No")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Source Member Name"; Rec."Source Member Name")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Destinaton Acc No"; Rec."Destinaton Acc No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;

                }
                field("Source Balance"; Rec."Source Balance")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Source ID No."; Rec."Source ID No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Destination Member No."; Rec."Destination Member No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;

                }
                field("Destination Member Name"; Rec."Destination Member Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;

                }
                field("Destination Balance"; Rec."Destination Balance")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = all;
                    Editable = false;
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