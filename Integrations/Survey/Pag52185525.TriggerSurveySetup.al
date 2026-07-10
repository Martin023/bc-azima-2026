page 52185525 "Trigger Survey Setup"
{
    Caption = 'Trigger Survey Setup';
    PageType = List;
    SourceTable = "Trigger Survey Setup";
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
                field(EntryNo; Rec.EntryNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Sky Survey Type"; Rec."Sky Survey Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sky Survey Type field.', Comment = '%';
                }
                field("Is Enabled?"; Rec."Is Enabled?")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sky Survey Type field.', Comment = '%';
                }
                field(ProductID; Rec.ProductID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product ID field.', Comment = '%';
                }
                field(PublishID; Rec.PublishID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Publish ID field.', Comment = '%';
                }
                field(ChannelCode; Rec.ChannelCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Channel Code field.', Comment = '%';
                }
                field(SurveyType; Rec.SurveyType)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Survey Type field.', Comment = '%';
                }
                field(SurveyAction; Rec.SurveyAction)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Survey Action field.', Comment = '%';
                }
                field(SurveyCommand; Rec.SurveyCommand)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Survey Command field.', Comment = '%';
                }
                field(SurveySensitivity; Rec.SurveySensitivity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Survey Sensitivity field.', Comment = '%';
                }
                field(TriggerMode; Rec.TriggerMode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Trigger Mode field.', Comment = '%';
                }
                field(TriggerType; Rec.TriggerType)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Trigger Type field.', Comment = '%';
                }
                field(TriggerName; Rec.TriggerName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Trigger Name field.', Comment = '%';
                }
                field(TriggerDescription; Rec.TriggerDescription)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Trigger Description field.', Comment = '%';
                }
                field(TriggerOtherDetails; Rec.TriggerOtherDetails)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Trigger Other Details field.', Comment = '%';
                }
                field(SurveyCategory; Rec.SurveyCategory)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Survey Category field.', Comment = '%';
                }
                field(SurveyPriority; Rec.SurveyPriority)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Survey Priority field.', Comment = '%';
                }
                field(SurveyOtherDetails; Rec.SurveyOtherDetails)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Survey Other Details field.', Comment = '%';
                }
                field(CreatedAt; Rec.CreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created At field.', Comment = '%';
                }
                field(CreatedBy; Rec.CreatedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
                field(ModifiedAt; Rec.ModifiedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Modified At field.', Comment = '%';
                }
                field(ModifiedBy; Rec.ModifiedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Modified By field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Test Survey")
            {
                ApplicationArea = All;
                Image = Action;

                trigger OnAction()
                var
                    SkySurvey: Codeunit "Sky Survey";
                begin
                    SkySurvey.Run;
                end;
            }
        }
    }
}

