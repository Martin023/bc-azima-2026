page 52186278 "Sectoral Classification"
{
    DataCaptionFields = "Sector Description";
    PageType = List;
    SourceTable = "Sectoral Classification";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sector Code";Rec."Sector Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sector Description";Rec."Sector Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Parent Sector";Rec."Parent Sector")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sector Level";Rec."Sector Level")
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

