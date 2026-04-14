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
                field("Base Hours"; Rec."Base Hours")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Base Rate"; Rec."Base Rate")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Source Unit"; Rec."Source Unit")
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

