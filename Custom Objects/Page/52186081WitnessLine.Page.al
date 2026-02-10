page 52186081 "Witness Line"
{
    CardPageID = "Witness Card";
    PageType = List;
    SourceTable = Witnesses;
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    DeleteAllowed = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Case No"; Rec."Case No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Witness Type"; Rec."Witness Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Witness No"; Rec."Witness No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Captured On"; Rec. "Captured On")
                {
                    Editable = false;

                }
                field("Captured By"; Rec. "Captured By")
                {
                    Editable = false;

                }
            }
        }
    }

    actions
    {
    }
}

