page 52185801 Coinage
{
    Editable = true;
    PageType = ListPart;
    SourceTable = Coinage;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Enabled = false;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    Enabled = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Enabled = true;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field(Value; Rec.Value)
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
            }
        }
    }

    actions
    {
    }
}

