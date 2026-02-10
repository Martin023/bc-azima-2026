page 52187082 "System Edits Filters"
{
    ApplicationArea = All;
    Caption = 'System Edits Fields';
    PageType = List;
    SourceTable = "System Edits Filters";
    DeleteAllowed = false;
    
    layout
    {
        area(content)
        {
           repeater(GroupName)
           {
                field("Record ID";Rec."Record ID")
                {
                    Editable = false;
                }
                field("Field ID";Rec."Field ID")
                {
                    Editable = false;
                }
                field("Field Name";Rec."Field Name")
                {
                    Editable = false;
                }
                field(Filter;Rec.Filter)
                {
                }
           }  
        }
    } 
    trigger OnModifyRecord(): Boolean
    var
    SystemEdits: Record "System Edits";
    begin
        if SystemEdits.Get(Rec."Record ID") then begin
            if SystemEdits.Status <> SystemEdits.Status::Open then Error('You can only put filters when this record is open');
        end;
    end; 
}
