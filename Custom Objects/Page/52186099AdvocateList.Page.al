page 52186099 "Advocate List"
{
    CardPageID = "Advocate Card";
    PageType = List;
    SourceTable = Advocate;
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("Firm No"; Rec."Firm No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Address;Rec.Address)
                {
                    Editable = false;

                }
                field(City;Rec.City)
                {
                    Editable = false;

                }
                field("Type of Firm"; Rec."Type of Firm")
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

