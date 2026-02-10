page 52186822 "Dividends Provision List Part"
{
    ApplicationArea = None;
    Caption = 'Dividends Provision List Part';
    PageType = ListPart;
    SourceTable = "Dividend Provision";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Dividends No."; Rec."Dividends No.")
                {
                    ToolTip = 'Specifies the value of the Dividends No. field.';
                }
                field("Account No"; Rec."Account No")
                {
                    ToolTip = 'Specifies the value of the Account No field.';
                }
                field("Member No"; Rec."Member No")
                {
                    ToolTip = 'Specifies the value of the Member No field.';
                }
                field("Product Type"; Rec."Product Type")
                {
                    ToolTip = 'Specifies the value of the Product Type field.';
                }
                field("Product Name"; Rec."Product Name")
                { }
                field(Month; Rec.Month)
                {
                    ToolTip = 'Specifies the value of the Month field.';
                }
                field("Interest Rate"; Rec."Interest Rate") { }
                field("Qualifying Shares"; Rec."Qualifying Shares")
                {
                    ToolTip = 'Specifies the value of the Qualifying Shares field.';
                }
                field("Gross Dividends"; Rec."Gross Dividends")
                {
                    ToolTip = 'Specifies the value of the Gross Dividends field.';
                }

            }
        }
    }
}
