page 52186075 "Maintain Machne/Vehicles"
{
    Caption = 'Vehicles Repair';
    PageType = List;
    SourceTable = "Maintain Machne/Vehicles";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    CardPageId = "Vehicles Repair";
    

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
                field(Description; Rec."Description of Repair")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Asset; Rec."Asset No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Vehicle Registration Number"; Rec."Registration No.")
                {
                    ApplicationArea = Basic,Suite;
                }
            }
        }
    }

    actions
    {
    }
}

