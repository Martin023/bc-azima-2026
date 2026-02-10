page 52187313 "CF Station Actions List"
{
    Editable = true;
    PageType = List;
    SourceTable = "CF Station Actions";

    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Department;Rec.Department)
                {

                }
                field("Allowed Action";Rec."Allowed Action")
                {

                }
                
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        
    end;

    trigger OnAfterGetRecord()
    begin
    end;

    

}

