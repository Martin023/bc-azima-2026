page 52185518 "HR Job Requirement Lines"
{
    PageType = ListPart;
    SourceTable = "HR Job Requirements";
    UsageCategory = Lists;
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Qualification Type"; Rec."Qualification Type")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Qualification Description"; Rec."Qualification Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Minimum Score"; Rec."Minimum Score")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Score"; Rec."Maximum Score")
                {
                    ApplicationArea = Basic;
                }
               
            }
        }
    }

}

