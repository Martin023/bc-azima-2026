page 52185518 "HR Job Requirement Lines"
{
    PageType = List;
    SourceTable = "HR Job Requirements";
    UsageCategory = Lists;
    ApplicationArea = Basic;
    PromotedActionCategories = 'Home, Reports, Process, Navigate, List';

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
                field(Control4; Rec."Related Qualification")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Action3)
            {
                ApplicationArea = Basic;
                Caption = 'Related Qualification';
                Image = JobLines;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "HR Related Job Qualification";
                RunPageLink = "Qualification ID" = FIELD("Qualification Code"),
                              "Qualification Type" = FIELD("Qualification Type");
            }
        }
    }
}

