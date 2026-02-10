page 52187250 "Channel Application Documents"
{
    ApplicationArea = All;
    Caption = 'Channel Application Documents';
    PageType = List;
    SourceTable = "Channel Application Documents";
    UsageCategory = None;

    CardPageId = "Channel Application Document";

    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    // PromotedActionCategories = 'New,Process,Reports,Creation,Refresh';
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Application No."; Rec."Application No.")
                {
                    ToolTip = 'Specifies the value of the Application No. field.', Comment = '%';
                }
                field("Document Name"; Rec."Document Name")
                {
                    ToolTip = 'Specifies the value of the Document Name field.', Comment = '%';
                }
                field("Document Extension"; Rec."Document Extension")
                {
                    ToolTip = 'Specifies the value of the Document Extension field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
            }
        }
    }
}
