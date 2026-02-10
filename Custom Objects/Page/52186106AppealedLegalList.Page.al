page 52186106 "Appealed Legal List"
{
    CardPageID = "Appealed Legal Card";
    PageType = List;
    SourceTable = "Appeals Table";
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
              field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Case Number"; Rec."Case Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Old No."; Rec."Old No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Old Case Number";Rec."Old Case Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Case Category"; Rec."Case Category")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Matter Code"; Rec."Case Type")
                {
                    Caption = 'Matter Code';
                    ApplicationArea = Basic, Suite;
                }
                field("Date of filing the Suit"; Rec."Date of Filing the suit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Lawyer"; Rec."Lawyer")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Advisory; Rec."ADR")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Advisory';
                }
                field("Case Status"; Rec."Case Status")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
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

