page 52187091 "Reversed System Reversal List"
{
    ApplicationArea = All;
    Caption = 'System Reversal List';
    PageType = List;
    SourceTable = "System Reversal";
    SourceTableView = where(Reversed = const(true));
    Editable = false;
    CardPageId = "System Reversal Card";

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
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = all;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = ALL;

                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = all;
                }
                field("G/L Register No"; Rec."G/L Register No")
                {
                    ToolTip = 'Specifies the value of the Table ID field.';
                }

                field("From Entry No"; Rec."From Entry No")
                {
                    ToolTip = 'Specifies the value of the From Entry No field.';
                }
                field("To Entry No"; Rec."To Entry No")
                {
                    ToolTip = 'Specifies the value of the To Entry No field.';
                }

                field("Created by"; Rec."Created by")
                {
                    ToolTip = 'Specifies the value of the Created by User ID field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Reversed; Rec.Reversed)
                {
                    ToolTip = 'Specifies the value of the Reversed field.';
                }
                field("Created by User ID"; Rec."Created by User ID")
                {
                    ApplicationArea = ALL;
                    Caption = 'Created By';
                }

                field("Approved by User ID"; Rec."Approved by User ID")
                {
                    ToolTip = 'Specifies the value of the Approved by User ID field.';
                    Caption = 'Approved By';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                { }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                { }
            }
        }
    }
}
