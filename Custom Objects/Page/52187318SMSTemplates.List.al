page 52187318 "SMS Templates"
{
    
    PageType = List;
    Editable = false;
    SourceTable = "DMU SMS Templates";
    CardPageId = "DMU SMS Templates";

    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code;Rec.Code)
                {

                }
                field(Description;Rec.Description)
                {

                }
                field("Text SMS";Rec."Text SMS")
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

