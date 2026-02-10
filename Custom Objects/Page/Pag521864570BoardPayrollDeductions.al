page 52186470 "Board Payroll Deductions"
{
    ApplicationArea = All;
    Caption = 'Board Payroll Deductions';
    PageType = ListPart;
    SourceTable = "Board Payroll Deductions";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No"; Rec."Document No")
                {
                    ToolTip = 'Specifies the value of the Document No field.';
                    Editable = false;
                }
                field("Deduction Type"; Rec."Deduction Type")
                {
                    ToolTip = 'Specifies the value of the Deduction Type field.';
                }
                field("Member No"; Rec."Member No")
                {
                    ToolTip = 'Specifies the value of the Member No field.';
                }
                field("member Name"; Rec."member Name")
                {
                    ToolTip = 'Specifies the value of the member Name field.';
                }
            
                field("Related No."; Rec."Related No.")
                {
                    ToolTip = 'Specifies the value of the Related No. field.';
                    Caption = 'Related Account';
                }
                field("Amount LCY"; Rec."Amount LCY")
                {
                    ToolTip = 'Specifies the value of the Amount LCY field.';
                }
            }
        }
    }
    var
        BoardTransactions: record "PR Board Transactions";
}
