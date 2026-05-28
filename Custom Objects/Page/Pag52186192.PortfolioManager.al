namespace AzimaBC.AzimaBC;

page 52186192 "Portfolio Manager List"
{
    ApplicationArea = All;
    Caption = 'Portfolio Manager List';
    PageType = List;
    SourceTable = "Portfolio Manager";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
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
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field.', Comment = '%';
                }
                field(Transfered; Rec.Transfered)
                {
                    ToolTip = 'Specifies the value of the Transfered field.', Comment = '%';
                }
            }
          
        }
    }
}
