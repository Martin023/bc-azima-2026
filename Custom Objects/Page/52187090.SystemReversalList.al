page 52187090 "System Reversal List"
{
    ApplicationArea = All;
    Caption = 'Reversal List';
    PageType = List;
    SourceTable = "System Reversal";
    SourceTableView = where(Reversed = const(false));
    Editable = false;
    CardPageId = "System Reversal Card";
    UsageCategory = Administration;

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
                field("Entry No."; Rec."Entry No.")
                {
                }

                field("Document No"; Rec."Document No")
                {

                }
                field("Transaction Description"; Rec."Transaction Description")
                {

                }
                field("Member No"; Rec."Member No")
                { }

                field("Member Name"; Rec."Member Name") { }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Reversed; Rec.Reversed) { }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ToolTip = 'Specifies the value of the Transaction Date.';
                    Editable = false;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ToolTip = 'Specifies the value of the Creation Date';
                    Editable = false;
                }

                field("Created by User ID"; Rec."Created by User ID")
                {
                    ToolTip = 'Specifies the value of the Created by User ID field.';
                    Editable = false;
                }
                field("Approved by User ID"; Rec."Approved by User ID")
                {
                    ToolTip = 'Specifies the value of the Approved by User ID field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                { Editable = false; }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                { Editable = false; }
                field("Approved date"; Rec."Approved date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

            }
        }
    }
}
