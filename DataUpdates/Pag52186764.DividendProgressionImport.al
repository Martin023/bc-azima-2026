namespace KenpipeCBS.KenpipeCBS;

page 52186764 "Dividend Progression Import"
{
    ApplicationArea = All;
    Caption = 'Dividend Progression Import';
    PageType = List;
    SourceTable = "Dividend Progression Import";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Gross Div."; Rec."Gross Div.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gross Div. field.', Comment = '%';
                }
                field(WTax; Rec.WTax)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the WTax field.', Comment = '%';
                }
                field("Net Div."; Rec."Net Div.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Net Div. field.', Comment = '%';
                }
                field("Qualifying Shares"; Rec."Qualifying Shares")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qualifying Shares field.', Comment = '%';
                }
                field(Shares; Rec.Shares)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shares field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(import)
            {
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import the data from the file.';
                RunObject = xmlport "Import Old Div";
            }
            action(GenProgression)
            {
                Caption = 'Generate progression';
                Image = Import;
                ToolTip = 'Import the data from the file.';
                RunObject = report "Generate Actual progression";
            }
        }
    }
}
