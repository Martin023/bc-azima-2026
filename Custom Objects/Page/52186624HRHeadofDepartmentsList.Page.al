page 52186624 "HR Head of Departments List"
{
    CardPageID = "HR Head of Departments Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Heads of Departments";
    UsageCategory = Lists;
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Responsibility center"; Rec."Responsibility center")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control11; Outlook)
            {
                ApplicationArea = Basic;
            }
            systempart(Control12; Notes)
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
    }
}

