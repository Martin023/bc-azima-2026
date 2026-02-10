page 52185730 "Member Picture & Signature"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = CardPart;
    SourceTable = "Image Data";


    layout
    {
        area(content)
        {
            group(Pictures)
            {
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic, Suite;
                    Editable=true;
                }
            }
            group(Signatures)
            {
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = Basic, Suite;
                     Editable=true;
                }
            }
            group(IDCard)
            {
                field("ID Card Front"; Rec."ID Card Front")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ID Card Back"; Rec."ID Card Back")
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

