page 52186166 "Agent Registration Fact Box"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = CardPart;
    SourceTable = "Agent Biometric Data";

    layout
    {
        area(content)
        {
            group("Passport Photo")
            {
                field(PassportPhoto; Rec.PassportPhoto)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("ID Cards")
            {
                field(IDFront; Rec.IDFront)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(IDBack; Rec.IDBack)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Application Form")
            {
                field(ApplicationFormFront; Rec.ApplicationFormFront)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(ApplicationFormBack; Rec.ApplicationFormBack)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    var
        Members: Record Members;
}

