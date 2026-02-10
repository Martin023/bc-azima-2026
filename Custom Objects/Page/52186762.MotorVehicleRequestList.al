page 52186762 "Motor Vehicle Request List"
{
    ApplicationArea = All;
    Caption = 'Motor Vehicle Request List';
    PageType = List;
    SourceTable = "Motor Vehicle Request";
    UsageCategory = Lists;
    CardPageId = "Motor Vehicle Request Card";
    Editable = false;
    DeleteAllowed = false;

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
                field("Date of Request"; Rec."Date of Request")
                {
                }

                field("Type of Travel"; Rec."Type of Travel")
                {
                    ToolTip = 'Specifies the value of the Type of Travel field.';
                }
                field("Date of Travel"; Rec."Date of Travel")
                {
                    ToolTip = 'Specifies the value of the Date of Travel field.';
                }
                field("Vehicle Purpose"; Rec."Vehicle Purpose")
                {
                    ToolTip = 'Specifies the value of the Vehicle Purpose field.';
                    //Editable = RequestEditable;
                }    
                field("Driver Name"; Rec."Driver Name")
                {
                    ToolTip = 'Specifies the value of the Driver Name field.';
                }
                field("Registration No."; Rec."Registration No.")
                {
                    ToolTip = 'Specifies the value of the Registration No. field.';
                }
                field(Destination; Rec.Destination)
                {
                    ToolTip = 'Specifies the value of the Destination field.';
                }
                // field("Staff Name"; Rec."Staff Name")
                // {
                //     ToolTip = 'Specifies the value of the Staff Name field.';
                // }
                field("Date Created"; Rec."Created Date")
                {

                }
                
            }
        }
    }
}
