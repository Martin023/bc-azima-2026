namespace BCAZIMA.BCAZIMA;

page 52185435 "Bulk Atm List"
{
    ApplicationArea = All;
    //CardPageId = "Bulk ATM Card";
    Caption = 'Bulk Atm List';
    PageType = List;
    SourceTable = "Bulk ATM Application";
    UsageCategory = Tasks;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.', Comment = '%';
                }
                field("Date Captured"; Rec."Date Captured")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Captured field.', Comment = '%';
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Comments field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Posted "; Rec."Posted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.', Comment = '%';
                }
            }
        }
    }
}

