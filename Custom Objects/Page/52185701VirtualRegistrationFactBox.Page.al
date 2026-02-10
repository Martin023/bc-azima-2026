page 52185701 "Virtual Registration Fact Box"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = CardPart;
    SourceTable = "Virtual Registrations";

    layout
    {
        area(content)
        {
            field("Full Names"; Rec."Full Names")
            {
                ApplicationArea = Basic, Suite;
            }
            field(MyPicture; Rec.MyPicture)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
    }

    var
        Members: Record Members;
}

