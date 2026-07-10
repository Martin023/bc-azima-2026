namespace AZIMA.AZIMA;

page 52185605 "Member Form Lines"
{
    ApplicationArea = All;
    Caption = 'Member Form Lines';
    PageType = ListPart;
    SourceTable = "Member Form List";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
                field("Member Form Types"; Rec."Member Form Types")
                {
                    ToolTip = 'Specifies the value of the Form Type field.', Comment = '%';
                }
                field("Reference No"; Rec."Reference No")
                {
                    ToolTip = 'Specifies the value of the Loan No. field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Received Date"; Rec."Received Date")
                {
                    ToolTip = 'Specifies the value of the Received Date field.', Comment = '%';
                }
                field(filed; Rec.filed)
                {
                    ToolTip = 'Specifies the value of the Filed/Received field.', Comment = '%';
                }
                field("Filed Date"; Rec."Filed Date")
                {
                    ToolTip = 'Specifies the value of the Filed Date field.', Comment = '%';
                }
                field("Filed By"; Rec."Filed By")
                {
                    ToolTip = 'Specifies the value of the Filed By. field.', Comment = '%';
                }
            }
        }
    }
}
