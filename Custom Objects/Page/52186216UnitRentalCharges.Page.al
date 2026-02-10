page 52186216 "Unit Rental Charges"
{
    PageType = List;
    SourceTable = "Unit Setup Charges";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Charge Code"; Rec."Charge Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Property Code"; Rec."Property Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Floor No"; Rec."Floor No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Minimum Area Sq.ft"; Rec."Minimum Area Sq.ft")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Rental Rate"; Rec."Rental Rate")
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

