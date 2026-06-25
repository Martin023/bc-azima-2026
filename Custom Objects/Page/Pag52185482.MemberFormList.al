namespace AZIMA.AZIMA;

page 52185482 "Member Form List"
{
    ApplicationArea = All;
    Caption = 'Member Form List';
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
