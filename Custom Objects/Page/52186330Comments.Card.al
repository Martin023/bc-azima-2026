page 52186330 "Comments Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = Comments;

    layout
    {
        area(content)
        {
            group(General)
            {

                field("Entry No."; Rec."Entry No.")
                {
                    Editable = false;
                }
                field(Comment; Rec.Comment)
                {
                    MultiLine = true;
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {

                }

            }

        }
    }

}

