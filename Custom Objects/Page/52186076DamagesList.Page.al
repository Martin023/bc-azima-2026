page 52186076 "Damages List"
{
    Caption = 'Contingent Liabilities List';
    PageType = List;
    SourceTable = Damages;
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                // field("Case No."; Rec."Case No")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                // }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Estimated Cost"; Rec."Estimated Cost")
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

