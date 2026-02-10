page 52187102 "loan Tearms And Conditions"
{
    ApplicationArea = All;
    Caption = 'Loan Terms And Conditions';
    PageType = List;
    SourceTable = "Loan Terms And Conditions";
    UsageCategory = None;

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
                    Caption = 'Terms & Conditions';

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
