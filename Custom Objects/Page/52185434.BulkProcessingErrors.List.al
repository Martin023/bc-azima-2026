page 52185434 "Bulk Processing Errors List"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Bulk Processing Errors";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    Caption = 'Bulk Processing Errors';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = All;
                }
                field("Record ID"; Rec."Record ID")
                {
                    ApplicationArea = All;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                }
                field(Error; Rec.Error)
                {
                    ApplicationArea = All;
                }
                field(Process; Rec.Process)
                {
                    ApplicationArea = All;
                }
                field(Severity; Rec.Severity)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        // Define actions if needed
    }

   
}
