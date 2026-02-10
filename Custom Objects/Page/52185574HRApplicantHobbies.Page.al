page 52185574 "HR Applicant Hobbies"
{
    PageType = List;
    SourceTable = "HR Applicant Hobbies";
    ApplicationArea = Basic;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Hobby; Rec.Hobby)
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

