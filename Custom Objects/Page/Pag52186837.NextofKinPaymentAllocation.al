page 52186837 "NextofKin Payment Allocation"
{
    ApplicationArea = All;
    Caption = 'NextofKin Payment Allocation';
    PageType = ListPart;
    SourceTable = "NextofKin Payment Allocation";
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Identification Type"; Rec."Identification Type")
                {
                    ToolTip = 'Specifies the value of the Identification Type field.';
                }
                field(Identification; Rec.Identification)
                {
                    ToolTip = 'Specifies the value of the Identification field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Relationship; Rec.Relationship)
                {
                    ToolTip = 'Specifies the value of the Relationship field.';
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ToolTip = 'Specifies the value of the Date of Birth field.';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field("Principal Member No."; Rec."Principal Member No.")
                {
                    ToolTip = 'Specifies the value of the Principal Member No. field.';
                }
                field(Allocation; Rec.Allocation)
                {
                    ToolTip = 'Specifies the value of the Allocation field.';
                }
                field("Beneficiary Member No."; Rec."Beneficiary Member No.")
                {
                    ToolTip = 'Specifies the value of the Beneficiary Member No. field.';
                }
                field("Disbursement Account"; Rec."Disbursement Account")
                {
                    ToolTip = 'Specifies the value of the Disbursement Account field.';
                }
                field("Beneficiary Amount"; Rec."Beneficiary Amount")
                {
                    ToolTip = 'Specifies the value of the Beneficiary Amount field.';
                }
                field("Pay Next of Kin Account"; Rec."Pay Next of Kin Account")
                {
                    ToolTip = 'Specifies the value of the Pay Next of Kin Account field.';
                }
                field("Next of Kin Account Paid"; Rec."Next of Kin Account Paid")
                {
                    ToolTip = 'Specifies the value of the Next of Kin Account Paid field.';
                }
                field("DateTime Paid"; Rec."DateTime Paid")
                {

                }
            }
        }
    }
}
