namespace AZIMA.AZIMA;

page 52185784 "Loan appraisal forms"
{
    ApplicationArea = All;
    Caption = 'Loan appraisal forms';
    PageType = List;
    SourceTable = "Loan Appraisal History";
    UsageCategory = Lists;
    CardPageId = "Loan Appraisal Form";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Loan No"; Rec."Loan No")
                {
                    ToolTip = 'Specifies the value of the Loan No field.', Comment = '%';
                }
                field("Appraisal form"; Rec."Appraisal form")
                {
                    ToolTip = 'Specifies the value of the Appraisal form field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
            }
        }
    }
}
