page 52186186 "Property List"
{
    CardPageID = "Property Details";
    Editable = false;
    PageType = List;
    SourceTable = "Property Details";
    // SourceTableView = WHERE("Agreement Status" = CONST(Pending),
    //                         "Property Type" = FILTER(<> 'LAND'));
    UsageCategory = Lists;
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("L.R. No."; Rec."L.R. No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Property Type"; Rec."Property Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Street; Rec.Street)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Agreement Status"; Rec."Agreement Status")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;
}

