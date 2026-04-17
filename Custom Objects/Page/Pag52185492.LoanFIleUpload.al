namespace AzimaCBS.AzimaCBS;

page 52185492 "Loan FIle Upload"
{
    ApplicationArea = All;
    Caption = 'Loan FIle Upload';
    PageType = List;
    SourceTable = "Loan FIle Upload";
    UsageCategory = Lists;
    
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
                field("Loan File Name"; Rec."Loan File Name")
                {
                    ToolTip = 'Specifies the value of the Loan File Name field.', Comment = '%';
                }
                field("File"; Rec."File")
                {
                    ToolTip = 'Specifies the value of the File field.', Comment = '%';
                }
            }
        }
    }
}
