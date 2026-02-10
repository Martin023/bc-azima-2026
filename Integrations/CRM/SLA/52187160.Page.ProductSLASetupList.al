page 52187160 "Product SLA Setup List"
{
    ApplicationArea = All;
    Caption = 'Product SLA Setup List';
    PageType = List;
    SourceTable = "Product SLA Setup";
    UsageCategory = Lists;

    DataCaptionFields = "SLA Code", Description, "SLA Timeline";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("SLA Code"; Rec."SLA Code")
                {
                    ToolTip = 'Specifies the value of the SLA Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("SLA Timeline"; Rec."SLA Timeline")
                {
                    ToolTip = 'Specifies the value of the SLA Timeline field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
                field("Created At"; Rec."Created At")
                {
                    ToolTip = 'Specifies the value of the Created At field.', Comment = '%';
                }
                field("Updated By"; Rec."Updated By")
                {
                    ToolTip = 'Specifies the value of the Updated By field.', Comment = '%';
                }
                field("Updated At"; Rec."Updated At")
                {
                    ToolTip = 'Specifies the value of the Updated At field.', Comment = '%';
                }
            }
        }
    }
}
