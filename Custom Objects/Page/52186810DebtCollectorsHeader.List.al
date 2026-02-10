page 52186810 "Debt Collectors Header List"
{
    ApplicationArea = All;
    PageType = List;
    Editable = false;
    CardPageId = "Debt Collecrtors header";
    SourceTable = "Debt Collectors Header";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No.";Rec."No.")
                { 
                    Editable = false;
                }
                field("Debt Collector No.";Rec."Debt Collector No.")
                { 
                    Editable = false;
                }
                field("Debt Collector Name";Rec."Debt Collector Name")
                { 
                    Editable = false;
                }
                field("Entered By";Rec."Entered By")
                { 
                    Editable = false;
                }
                field("Entry Time";Rec."Entry Time")
                { 
                    Editable = false;
                }
                field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
                { 
                    Editable = false;
                }
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                { 
                    Editable = false;
                }
                field("Responsibility Center";Rec."Responsibility Center")
                { 
                    Editable = false;
                }
                field(Closed;Rec.Closed)
                { 
                    Editable = false;
                }
            }
        }
    }

    actions
    {}
        

}