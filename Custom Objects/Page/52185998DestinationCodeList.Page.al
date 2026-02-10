page 52185998 "Destination Code List"
{
    CardPageID = "Destination Code Card";
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Travel Destination";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Destination Code"; Rec."Destination Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Destination Name"; Rec."Destination Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Destination Type"; Rec."Destination Type")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control7; Outlook)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control8; Notes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control9; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control10; Links)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Destination Rate")
            {
                Caption = 'Destination Rate';
                Image = Travel;
                ApplicationArea = Basic, Suite;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                RunObject = Page "Destination Rate List";
                RunPageLink = "Destination Code" = FIELD("Destination Code");
            }
        }
    }

    trigger OnOpenPage()
    begin
        UserSetup.GetDefaultSalesAmountApprovalLimit();
    end;

    var
        UserSetup: Record "User Setup";
}

