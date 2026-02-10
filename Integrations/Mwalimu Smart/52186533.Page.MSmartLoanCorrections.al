page 52186533 "M-Smart Loan Corrections"
{
    DeleteAllowed = true;
    ApplicationArea = Basic, Suite;
    Caption = 'M-Smart Loan Corrections';
    PageType = List;
    SourceTable = "M-Smart Loan Corrections";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Application No."; Rec."Application No.")
                {
                    ToolTip = 'Specifies the value of the Application No. field.';
                    Enabled = false;
                }
                field("Correction Type"; Rec."Correction Type")
                {
                    ToolTip = 'Specifies the value of the Correction Type field.';

                    trigger OnValidate()
                    begin
                        RestrictEdit;
                    end;
                }
                field("Guarantor Member No."; Rec."Guarantor Member No.")
                {
                    ToolTip = 'Specifies the value of the Guarantor Member No. field.';

                    trigger OnValidate()
                    begin
                        RestrictEdit;
                    end;
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';

                    trigger OnValidate()
                    begin
                        RestrictEdit;
                    end;
                }
                field("Is Sent"; Rec."Is Sent")
                {
                    ToolTip = 'Specifies the value of the Is Sent field.';

                    trigger OnValidate()
                    begin
                        RestrictEdit;
                    end;
                }
                field("Created By"; Rec."Created By")
                {
                    Enabled = false;
                }
                field("Created At"; Rec."Created At")
                {
                    Enabled = false;
                }
                field("Modified By"; Rec."Modified By")
                {
                    Enabled = false;
                }
                field("Modified At"; Rec."Modified At")
                {
                    Enabled = false;
                }
            }
        }
    }

    local procedure RestrictEdit()
    begin
        if Rec."Is Sent" then begin
            Error('You cannot modify a correction that has already been sent to Mwalimu Smart');
        end;
    end;
}
