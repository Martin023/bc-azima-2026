page 52187355 "Perfected Securities List"
{
    ApplicationArea = All;
    Caption = 'Perfected Securities List';
    PageType = List;
    SourceTable = "Security Perfection";
    UsageCategory = Lists;
    SourceTableView = WHERE (Perfected = CONST(TRUE));
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
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.';
                } 
                field("Security No.";Rec."Security No.")
                {
                    ToolTip = 'Specifies the value of the Security No. field.';
                }
                field("Collateral Types"; Rec."Collateral Types")
                {
                    ToolTip = 'Specifies the value of the Collateral Types field.';
                }
                field("Collateral Sums"; Rec."Collateral Value Sum")
                {
                    ToolTip = 'Specifies the value of the Collateral Sums field.';
                }
                field(Perfected;Rec.Perfected)
                {
                    ToolTip = 'Specifies the value of the Perfected field.';
                }
                field("Date Perfected";Rec."Date Perfected")
                {
                    ToolTip = 'Specifies the value of the Date Perfected field.';
                }
            }
        }
    }
}
