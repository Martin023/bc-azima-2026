page 52185539 "Approved Appeals"
{
    ApplicationArea = All;
    Caption = 'Approved Appeals';
    PageType = List;
    SourceTable = "Appeals Table";
    UsageCategory = Lists;
    CardPageId = "Approved Appeals Card";
    ModifyAllowed = false;;
    Editable = false;
    InsertAllowed = false;
    
    
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
                field("Case Type"; Rec."Case Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date of filing the Suit"; Rec."Date of Filing the suit")
                {
                    ApplicationArea = Basic, Suite;
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

