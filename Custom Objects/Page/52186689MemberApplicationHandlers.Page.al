page 52186689 "Member Application Handlers"
{
    PageType = List;
    SourceTable = "Portal Member App Handlers";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Payroll Number"; Rec."Payroll Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Number"; Rec."Member Number")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Job Tittle"; Rec.Department)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
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

