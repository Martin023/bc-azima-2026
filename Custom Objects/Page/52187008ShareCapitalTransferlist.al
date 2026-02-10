page 52187008 "Share Capital Transfer List"
{
    PageType = List;
    CardPageId = "Share Capital Transfer Card";
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Share Capital Transfer Buffer";
    // SourceTableView = where(status = filter(Open), "Sent Back to CRM" = CONST(false));
    Caption = 'Shares Transfer List';

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
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Source Account No"; Rec."Source Account No")
                {
                    ApplicationArea = All;
                    // Editable = false;

                }
                // field("CRM Application No."; Rec."CRM Application No.")
                // {
                //     ApplicationArea = All;
                //     Editable = false;

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
                field("Source Balance"; Rec."Source Balance")
                {
                    ApplicationArea = all;

                }
                field("Source ID No."; Rec."Source ID No.")
                {
                    ApplicationArea = all;
                }

                field("Destinaton Acc No"; Rec."Destinaton Acc No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;

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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Reference No"; Rec."Reference No")
                {

                }
                field("Receipt Amount"; Rec."Receipt Amount")
                {

                }
                field("Posting Date"; Rec."Posting Date")
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