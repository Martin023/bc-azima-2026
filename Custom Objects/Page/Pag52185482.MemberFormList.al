namespace AZIMA.AZIMA;

page 52185482 "Member Form List"
{
    ApplicationArea = All;
    Caption = 'Member Form List';
    PageType = List;
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
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.', Comment = '%';
                }
                field(filed; Rec.filed)
                {

                }
                field("Filed By"; Rec."Filed By")
                {

                }
            }
        }
    }
}
