namespace AzimaBC.AzimaBC;

page 52185467 "Sales Leads Lines"
{
    ApplicationArea = All;
    Caption = 'Sales Leads Lines';
    PageType = ListPart;
    SourceTable = "Sales Leads Lines";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.', Comment = '%';
                }
                field("ID No"; Rec."ID No")
                {
                    ToolTip = 'Specifies the value of the ID No field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field.', Comment = '%';
                }
                field("Lead Status"; Rec."Lead Status")
                {
                    ToolTip = 'Specifies the value of the Lead Status field.', Comment = '%';
                }
            }
        }
    }
}
