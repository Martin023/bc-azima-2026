namespace BCAZIMA.BCAZIMA;

page 52185447 "Gaming Paybills Setup"
{
    Caption = 'Gaming Paybills Setup';
    PageType = List;
    SourceTable = "Gaming Paybills Setup";
    UsageCategory = None;

    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Paybill / Till No."; Rec."Paybill / Till No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Paybill / Till No. field.', Comment = '%';
                }
                field("Paybill / Till Name"; Rec."Paybill / Till Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Paybill / Till Name field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                    Caption = 'Created At';
                }
                field("Last Updated By"; Rec."Last Updated By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Updated By field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                    Caption = 'Modified At';
                }
            }
        }
    }
}
