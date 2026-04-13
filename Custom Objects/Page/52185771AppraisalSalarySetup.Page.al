page 52185771 "Appraisal Salary Set-up"
{
    PageType = List;
    SourceTable = "Appraisal Salary Set-up";
    UsageCategory = Administration;
    Caption = 'Appraisal Salary Set-up';

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Type; Rec.Type)
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

