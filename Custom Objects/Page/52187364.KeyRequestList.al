page 52187364 "Key Request List"
{
    ApplicationArea = All;
    Caption = 'Key Request List';
    PageType = List;
    SourceTable = "Key Request Table";
    UsageCategory = Lists;
    CardPageID = "Key Request Card";
    DeleteAllowed = False;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Staff Number"; Rec."Staff Number")
                {
                    ToolTip = 'Specifies the value of the Staff Number field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Purpose of Request"; Rec."Purpose of Request")
                {
                    ToolTip = 'Specifies the value of the Purpose of Request field.';
                }
                
                field("Date Requested"; Rec."Date of Request")
                {
                    ToolTip = 'Specifies the value of the Date Requested field.';
                }
                field("Captured Date"; Rec."Created at")
                {
                    ToolTip = 'Specifies the value of the Captured Date field.';
                }
                field("Key Status"; Rec."Key Status")
                {
                    ToolTip = 'Specifies the value of the Key Status field.';
                }
                field(Status;Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }

            }
        }
    }
}
