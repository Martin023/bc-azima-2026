page 52186017 "HR Disc Withdrawal list"
{
    CardPageID = "HR Disc Wthdrawal Card";
    PageType = List;
    SourceTable = "HRDisciplinary Case Withdrawal";
    ApplicationArea = Basic;
    UsageCategory = Lists;
    // Caption = 'HR Disc Withdrawal list';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
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
                field(Department; Rec.Department)
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

