page 52187338 "Appealed Lines"
{
    ApplicationArea = All;
    Caption = 'Appealed Lines';
    PageType = ListPart;
    SourceTable = "Appeal Lines Table";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Appeal No"; Rec."Appeal No")
                {
                    ToolTip = 'Specifies the value of the Appeal No field.';
                }
                field(Court; Rec.Court)
                {
                    ToolTip = 'Specifies the value of the Court field.';
                }
                field(Decision; Rec.Discussion)
                {
                    ToolTip = 'Specifies the value of the Discussion field.';
                }
                field("Date of Decision"; Rec."Date of Discussion")
                {
                    ToolTip = 'Specifies the value of the Date of Discussion field.';
                }
                field("Captured By"; Rec."Captured By")
                {
                    ToolTip = 'Specifies the value of the Captured By field.';
                }

                field("Date Captured"; Rec."Date Captured")
                {
                    ToolTip = 'Specifies the value of the Date Captured field.';
                }



            }
        }
    }
}
