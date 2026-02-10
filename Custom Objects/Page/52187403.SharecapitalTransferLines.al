page 52187403 "Share capital Transfer Lines"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Share Capital Transfer Lines";
    layout
    {
        area(Content)
        {
            repeater("Transfer Lines")
            {
                field("Destination Member No"; Rec."Destination Member No")
                {
                    ApplicationArea = All;

                }
                field("Destination Member Name"; Rec."Destination Member Name")
                {
                    ApplicationArea = all;
                }
                field("Allocation Amount"; Rec."Allocation Amount")
                {
                    ApplicationArea = all;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = all;

                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = all;
                }
            }
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