page 52186067 "Account Signatory Image Fatbox"
{
    PageType = CardPart;
    SourceTable = "Account Signatories";

    layout
    {
        area(content)
        {
            field(Picture; Rec.Picture)
            {
                ApplicationArea = Basic, Suite;
            }
            field(Signature; Rec.Signature)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
    }
}

