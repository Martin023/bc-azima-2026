namespace MNS.MNS;

page 52186499 "Contract Template Lines"
{
    Caption = 'Contract Template Lines';
    PageType = ListPart;
    SourceTable = "Contract Templates Lines";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Template No."; Rec."Template No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Template No. field.', Comment = '%';
                    Visible = false;
                }
                field(Clause;Rec.Clause)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Clause field.', Comment = '%';
                }
                field(Body; Rec.Body)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Body field.', Comment = '%';
                    MultiLine = true;
                }
            }
        }
    }
}
