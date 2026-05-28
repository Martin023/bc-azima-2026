namespace AzimaBC.AzimaBC;

page 52187351 "Portfolio Manager Card"
{
    ApplicationArea = All;
    Caption = 'Portfolio Manager Card';
    PageType = Card;
    SourceTable = "Portfolio Manager";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Sales Representative"; Rec."Sales Representative")
                {
                    ToolTip = 'Specifies the value of the Sales Representative field.', Comment = '%';
                }
                field("Sales Rep Name"; Rec."Sales Rep Name")
                {
                    ToolTip = 'Specifies the value of the Sales Rep Name field.', Comment = '%';
                }
                field("No.of Members"; Rec."No.of Members")
                {
                    ToolTip = 'Specifies the value of the No.of Members field.', Comment = '%';
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field(Transfered; Rec.Transfered)
                {
                    ToolTip = 'Specifies the value of the Transfered field.', Comment = '%';
                }
            }
            part("PortfolioManagementLines"; "Portfolio Management Lines")
            {
                SubPageLink = "Header No" = field(No);
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
