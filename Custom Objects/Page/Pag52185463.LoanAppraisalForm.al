namespace AZIMA.AZIMA;

page 52185463 "Loan Appraisal Form"
{
    ApplicationArea = All;
    Caption = 'Loan Appraisal Form';
    PageType = Card;
    SourceTable = "Loan Appraisal History";
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Loan No"; Rec."Loan No")
                {
                    ToolTip = 'Specifies the value of the Loan No field.', Comment = '%';
                }
                field("Appraisal form"; Rec."Appraisal form")
                {
                    ToolTip = 'Specifies the value of the Appraisal form field.', Comment = '%';
                }
            }
        }
    }
}
