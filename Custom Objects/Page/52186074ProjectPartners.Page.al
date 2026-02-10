page 52186074 "Project Partners"
{
    PageType = List;
    SourceTable = "Project Partners";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control8)
            {
                ShowCaption = false;
                field(PartnerID; Rec.PartnerID)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Partner Name"; Rec."Partner Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contractor Type"; Rec."Contractor Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Partner Budget"; Rec."Partner Budget")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Disbursed Amount (LCY)"; Rec."Disbursed Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Accounted Amount"; Rec."Accounted Amount")
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

