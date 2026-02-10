page 52186428 "Financilal Appraisal"
{
    PageType = List;
    SourceTable = "Financial Appraisal setup";
    ApplicationArea = Basic, Suite;
    usagecategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Classifiaction Code"; Rec."Classifiaction Code")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Financial Classifiaction"; Rec."Financial Classifiaction")
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

