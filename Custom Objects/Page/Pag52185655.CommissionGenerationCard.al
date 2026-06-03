namespace AzimaBC.AzimaBC;

page 52185655 "Commission Generation Card"
{
    ApplicationArea = All;
    Caption = 'Commission Generation Card';
    PageType = Card;
    SourceTable = Commission;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the ID field.', Comment = '%';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ToolTip = 'Specifies the value of the Date Created field.', Comment = '%';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Cutoff date"; Rec."Cutoff date")
                {
                    ToolTip = 'Specifies the value of the Cutoff date field.', Comment = '%';
                }
                field("Loans Count"; Rec."Loans Count")
                {
                    ToolTip = 'Specifies the value of the Loans Count field.', Comment = '%';
                }
                field("Member Count"; Rec."Member Count")
                {
                    ToolTip = 'Specifies the value of the Member Count field.', Comment = '%';
                }
            }
        }
    }
}
