page 52187045 "Business Types"
{
    Editable = true;
    PageType = List;
    SourceTable = "Business Types";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field(Code; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;

                }
                // field(Description; Rec.Description)
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Industry"; Rec.Industry)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    // trigger OnInit()
    // begin
    //     CurrPage.LookupMode := true;
    // end;
}

