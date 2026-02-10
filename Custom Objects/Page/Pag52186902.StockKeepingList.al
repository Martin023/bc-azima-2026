namespace ALProject.ALProject;

page 52186902 "StockKeeping List"
{
    CardPageId= "Stock Keeping Header";
    ApplicationArea = All;
    Caption = 'StockKeeping List';
    PageType = List;
    SourceTableView=where(Types = filter(Stock));
    SourceTable = "Stock keeping";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(TotalItems; Rec.TotalItems)
                {
                    ToolTip = 'Specifies the value of the Total Items field.';
                }
                field("User Id"; Rec."User Id")
                {
                    ToolTip = 'Specifies the value of the User Id field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
}
