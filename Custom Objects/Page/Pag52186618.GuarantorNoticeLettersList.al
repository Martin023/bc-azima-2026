namespace AZIMA.AZIMA;

page 52186618 "Guarantor Notice Letters List"
{
    ApplicationArea = All;
    Caption = 'Guarantor Notice Letters List';
    PageType = List;
    SourceTable = "Guarantor Notice Letters";
    UsageCategory = Lists;
    cardpageid = "Defaulter Notice Letters Card";

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
                field("Recipient Member No"; Rec."Recipient Member No")
                {
                    ToolTip = 'Specifies the value of the Member No field.', Comment = '%';
                }
                field(Recepient; Rec.Recepient)
                {
                    ToolTip = 'Specifies the value of the Recepient field.', Comment = '%';
                }
                field(Letter; Rec.Letter)
                {
                    ToolTip = 'Specifies the value of the Letter field.', Comment = '%';
                }
                field("Header No"; Rec."Header No")
                {
                    ToolTip = 'Specifies the value of the Header No field.', Comment = '%';
                }
            }
        }
    }
}
