page 52185547 "Rejected Appeals List"
{
    ApplicationArea = All;
    Caption = 'Rejected Appeals List';
    PageType = List;
    SourceTable = "Appeals Table";
    UsageCategory = Lists;
    //CardPageId = "Rejected Appeals Card";
    
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

