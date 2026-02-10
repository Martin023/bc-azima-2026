page 52186710 "Allowed Allowances Part"
{
    PageType = ListPart;
    SourceTable = "Allowed Allowances";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Meeting Type Code"; Rec."Meeting Type Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Allowance Code"; Rec."Allowance Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {

                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("G/L Account"; Rec."G/L Account")
                {

                }
                field("Charge Code"; Rec."Charge Code")
                {

                }
            }
        }
    }

    actions
    {
    }
}

