page 52185523 "Survey Logs"
{
    ApplicationArea = All;
    Caption = 'Survey Logs';
    PageType = List;
    SourceTable = "Survey Logs";
    UsageCategory = Administration;

    InsertAllowed = false;
    ModifyAllowed = false;
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
                field(OriginatorID; Rec.OriginatorID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Originator ID field.', Comment = '%';
                }
                field(StatusCode; Rec.StatusCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status Code field.', Comment = '%';
                }
                field(StatusName; Rec.StatusName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status Name field.', Comment = '%';
                }
                field(StatusDate; Rec.StatusDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status Date field.', Comment = '%';
                }
                field(StatusDescription; Rec.StatusDescription)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status Description field.', Comment = '%';
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
                field(SystemUserIdentifier; Rec.SystemUserIdentifier)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the System User Identifier field.', Comment = '%';
                }
                field(SystemUserName; Rec.SystemUserName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the System User Name field.', Comment = '%';
                }
                field(SystemUserDepartment; Rec.SystemUserDepartment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the System User Department field.', Comment = '%';
                }
                field(SystemUserOtherDetails; Rec.SystemUserOtherDetails)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the System User Other Details field.', Comment = '%';
                }
                field(SurveyParticipantIdentifierType; Rec.SurveyParticipantIdentifierType)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Survey Participant Identifier Type field.', Comment = '%';
                }
                field(SurveyParticipantIdentifier; Rec.SurveyParticipantIdentifier)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Survey Participant Identifier field.', Comment = '%';
                }
                field(SurveyParticipantFullName; Rec.SurveyParticipantFullName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Survey Participant Full Name field.', Comment = '%';
                }
                field(SurveyParticipantOtherDetails; Rec.SurveyParticipantOtherDetails)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Survey Participant Other Details field.', Comment = '%';
                }
                field(SurveyBatchReference; Rec.SurveyBatchReference)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Survey Batch Reference field.', Comment = '%';
                }
                field(SurveySourceReference; Rec.SurveySourceReference)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Survey Source Reference field.', Comment = '%';
                }
                field(SurveySourceApplication; Rec.SurveySourceApplication)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Survey Source Application field.', Comment = '%';
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
                field(SurveyDateCreated; Rec.SurveyDateCreated)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Survey Date Created field.', Comment = '%';
                }
                field(SurveyScheduled; Rec.SurveyScheduled)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Survey Scheduled field.', Comment = '%';
                }
                field(SurveyDateScheduled; Rec.SurveyDateScheduled)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Survey Date Scheduled field.', Comment = '%';
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
            }
        }
    }
}

