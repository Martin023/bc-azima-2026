page 52187362 "Approved Security Perf. List"
{
    ApplicationArea = All;
    Caption = 'Approved Security Perf. List';
    PageType = List;
    SourceTable = "Security Perfection";
    UsageCategory = Lists;
    CardPageId = "Approved Security Perf. Card";
    SourceTableView = WHERE ("Status" = CONST(Approved));
    Editable = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    
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
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.';
                }
                field("Loan Name"; Rec."Loan Name")
                {
                    ToolTip = 'Specifies the value of the Loan Name field.';
                }
                field("Date of Issuance Instructions"; Rec."Date of Issuance Instructions")
                {
                    ToolTip = 'Specifies the value of the Date of Issuance of Instructions field.';
                }
                field("Collateral Types"; Rec."Collateral Types")
                {
                    ToolTip = 'Specifies the value of the Collateral Types field.';
                }
            }
        }
    }
}
