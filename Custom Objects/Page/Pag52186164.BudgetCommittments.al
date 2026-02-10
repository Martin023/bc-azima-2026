page 52186164 "Budget Committments"
{
    ApplicationArea = All;
    Caption = 'Budget Committments';
    PageType = List;
    SourceTable = Committment;
    UsageCategory = Lists;
    Editable = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Document Line No."; Rec."Document Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Line No. field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the G/L Account No. field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("G/L Name"; Rec."G/L Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the G/L Name field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field(Budget; Rec.Budget)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Budget field.';
                }
                field("Month Budget"; Rec."Month Budget")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Month Budget field.';
                }
                field("Payment Code"; Rec."Payment Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Code field.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("Commitment Date"; Rec."Commitment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Commitment Date field.';
                }
                field("Commitment Line Description"; Rec."Commitment Line Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Commitment Line Description field.';
                }
                field("Committed By"; Rec."Committed By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Committed By field.';
                }
                field("Committed Date"; Rec."Committed Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Committed Date field.';
                }
                field("Committed Time"; Rec."Committed Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Committed Time field.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Month Actual"; Rec."Month Actual")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Month Actual field.';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
            }
        }
    }
}
