page 52186635 "HR Related Job Qualification"
{
    PageType = List;
    SourceTable = "HR Job Related Requirements";
    ApplicationArea = Basic;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Qualification ID"; Rec."Qualification ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Qualification Type"; Rec."Qualification Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ApplicationArea = Basic;
                }
                field("Qualification Description"; Rec."Qualification Description")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Score"; Rec."Minimum Score")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Score"; Rec."Maximum Score")
                {
                    ApplicationArea = Basic;
                }
                field(Relevant; Rec.Relevant)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

