page 52186087 "Posted Reversal List"
{
    ApplicationArea = All;
    Caption = 'Posted Reversal List';
    PageType = List;
    SourceTable = "System Reversal";
    SourceTableView = where(Reversed = const(true));
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
                field("Created By"; Rec."Created By")
                {

                }
                field("Reversed by"; Rec."Reversed by")
                { }

                field("Approved by User ID"; Rec."Approved by User ID")
                {
                    ToolTip = 'Specifies the value of the Approved by User ID field.';
                }

                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Reversed; Rec.Reversed)
                {
                    ToolTip = 'Specifies the value of the Reversed field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                { }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {

                }
            }
        }
    }
}
