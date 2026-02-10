page 52186104 "Advocate Card"
{
    PageType = Card;
    SourceTable = Advocate;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Firm No"; Rec."Firm No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                // field(Address;Rec.Address)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                // }
                field("City"; Rec."City")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Address 2"; Rec."Address 2")
                {
                    Caption = 'Address';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                // field("Address 3";Rec."Address 3")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                // }
            }
        }
    }

    actions
    {
    }
}

