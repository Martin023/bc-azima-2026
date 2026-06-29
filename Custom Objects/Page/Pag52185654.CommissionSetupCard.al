namespace AZIMA.AZIMA;

page 52185654 "Commission Setup Card"
{
    ApplicationArea = All;
    Caption = 'Commission Setup Card';
    PageType = Card;
    SourceTable = "Transaction Types";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field("Commission Type"; Rec."Commission Type")
                {
                    ToolTip = 'Specifies the value of the Commission Type field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }

            }
            part(Control1; "Transaction Charges")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Transaction Type" = FIELD(Code);
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.Type := Rec.Type::Commission;
    end;
}
