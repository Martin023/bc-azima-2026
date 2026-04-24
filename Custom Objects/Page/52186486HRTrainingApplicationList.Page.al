page 52186486 "HR Training ApplicationList"
{
    CardPageID = "HR Training Application Header";
    DeleteAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Training App Header";
    ApplicationArea = Basic;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Course Title"; Rec."Course Title")
                {
                    ApplicationArea = Basic;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Participants"; Rec."No. of Participants")
                {
                    ApplicationArea = Basic;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control17; Outlook)
            {
                ApplicationArea = Basic;
            }
            systempart(Control18; Notes)
            {
                ApplicationArea = Basic;
            }
            systempart(Control19; Links)
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
    }
}

