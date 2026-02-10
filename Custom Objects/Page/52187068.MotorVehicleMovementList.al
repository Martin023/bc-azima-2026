page 52187068 "Motor Vehicle Movement List"
{
    ApplicationArea = All;
    Caption = 'Motor Vehicle Movement List';
    PageType = List;
    SourceTable = "Vehicle Movement";
    UsageCategory = Lists;
    CardPageId = "Motor Vehicle Movement";
    // SourceTableView = SORTING("No.")
    //                   ORDER(Ascending)
    //                   WHERE(Status = CONST(Open)); 
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'Movement No.';
                    ToolTip = 'Specifies the value of the Movement No. field.';
                    Editable = false;
                }
                field("Date of Travel"; Rec."Date of Travel")
                {
                    ToolTip = 'Specifies the value of the Date of Travel field.';
                }
                field("Driver Staff No.";Rec."Driver Staff No.")
                {
                    Caption = 'Driver PF No.';
                    ToolTip = 'Specifies the value of the Driver Staff No. field.';
                }
                field("Name of Driver"; Rec."Name of Driver")
                {
                    ToolTip = 'Specifies the value of the Name of Driver field.';
                }
                
                field("Purpose of Travel"; Rec."Purpose of Travel")
                {
                    ToolTip = 'Specifies the value of the Purpose of Travel field.';
                }
                field("Vehicle"; Rec."Allocated Vehicle")
                {
                }
                field("Registration No."; Rec."Registration No.")
                {
                    ToolTip = 'Specifies the value of the Registration No. field.';
                }
                field(From; Rec."From")
                {
                    ToolTip = 'Specifies the value of the From field.';
                }
                field(Destination;Rec.Destination)
                {
                    ToolTip = 'Specifies the value of the Destination field.';
                }
                field("Total Distance"; Rec."Total Distance")
                {
                    ToolTip = 'Specifies the value of the Total Distance field.';
                }
                // field("Created By"; Rec."Created By")
                // {
                //     ToolTip = 'Specifies the value of the Created By field.';
                //}
                field("Status"; Rec."Status")
                {
                }
            }
        }
    }
}
