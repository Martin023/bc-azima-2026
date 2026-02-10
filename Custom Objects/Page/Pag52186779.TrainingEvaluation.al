page 52186779 "Training Evaluation"
{
    CardPageId= "HR Training Feedback";
    ApplicationArea = All;
    Caption = 'Training Evaluation';
    PageType = List;
    SourceTable = "HR Training Feedback Form";
    UsageCategory = Lists;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                 field("Training Application No"; Rec."Training Application No")
                {
                    ToolTip = 'Specifies the value of the Training Application No field.';
                }
                field("Course Title"; Rec."Course Title")
                {
                    ToolTip = 'Specifies the value of the Course Title field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Purpose of Training"; Rec."Purpose of Training")
                {
                    ToolTip = 'Specifies the value of the Purpose of Training field.';
                }
                field("Training Status"; Rec."Training Status")
                {
                    ToolTip = 'Specifies the value of the Training Status field.';
                }
               
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Provider; Rec.Provider)
                {
                    ToolTip = 'Specifies the value of the Provider field.';
                }
            }
        }
    }
}
