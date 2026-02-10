namespace ALProject.ALProject;

page 52186152 "Disposal Requisition List"
{
    CardPageId="Disposal Requisition";
    ApplicationArea = All;
    Caption = 'Disposal Requisition List';
    PageType = List;
    SourceTable = "Stock Keeping";
    SourceTableView=where(Types=filter(Disposal));
    UsageCategory = Lists;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Id field.';
                }
                field(TotalItems; Rec.TotalItems)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Items field.';
                }
            }
        }
    }
}
