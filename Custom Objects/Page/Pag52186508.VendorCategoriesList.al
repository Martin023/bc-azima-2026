namespace mns.mns;

page 52186508 "Vendor Categories List"
{
    
    Caption = 'Vendor Categories List';
    PageType = List;
    SourceTable = "Vendor Categories";
    InsertAllowed=True;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Vendor Category"; Rec."Vendor Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor Category field.', Comment = '%';
                }
            }
        }
    }
}
