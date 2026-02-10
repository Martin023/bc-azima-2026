page 52187231 "52187231Loan Appr. Comments"
{
    ApplicationArea = All;
    Caption = 'Appraisal Comments';
    PageType = List;
    SourceTable = "Loan Appraisal Comments";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.';
                    Editable = true;

                }
                field(Appraiser; Rec.Appraiser)
                {
                    ToolTip = 'Specifies the value of the Appraiser field.';
                    Editable = false;
                }
                field("Entry Date"; Rec."Entry Date")
                {
                    ToolTip = 'Specifies the value of the Entry Date field.';
                    Editable = false;
                }
                field("Entry Time"; Rec."Entry Time")
                {
                    ToolTip = 'Specifies the value of the Entry Time field.';
                    Editable = false;
                }

                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
            }
        }
    }
}
