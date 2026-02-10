page 52186176 "Posted Vote Transfer List"
{
    ApplicationArea = All;
    Caption = 'Posted Vote Transfer List';
    PageType = List;
    SourceTable = "Vote Transfer";
    SourceTableView = where(Posted = const(true));
    UsageCategory = Lists;
    Editable = false;
    ModifyAllowed = false;
    CardPageID = "Vote Transfer";

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
                field("Source Vote"; Rec."Source Vote")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Vote field.';
                }
                field("Destination Vote"; Rec."Destination Vote")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Destination Vote field.';
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved By field.';
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved Date field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Budget Name"; Rec."Budget Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Budget Name field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Destination Dimension 1"; Rec."Destination Dimension 1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Destination Dimension 1 field.';
                }
                field("Destination Dimension 2"; Rec."Destination Dimension 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Destination Dimension 2 field.';
                }
                field("Raised Date"; Rec."Raised Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Raised Date field.';
                }
                field("Raised By"; Rec."Raised By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Raised By field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
            }
        }
    }
}
