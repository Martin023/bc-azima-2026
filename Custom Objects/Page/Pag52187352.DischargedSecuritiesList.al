page 52187352 "Discharged Securities List"
{
    ApplicationArea = All;
    Caption = 'Discharged Securities List';
    PageType = List;
    SourceTable = "Security Perfection";
    UsageCategory = Lists;
    SourceTableView = where ("Collateral Status" = const(Discharged));
    ModifyAllowed = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    
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
                // field("Perfection No."; Rec."Perfection No.")
                // {
                //     ToolTip = 'Specifies the value of the Perfection No. field.';
                // }
                field("Security No."; Rec."Security No.")
                {
                    ToolTip = 'Specifies the value of the Security No. field.';
                }
                field("Discharged On"; Rec."Discharged On")
                {
                    ToolTip = 'Specifies the value of the Discharged On field.';
                }
                field("Discharged By"; Rec."Discharged By")
                {
                    ToolTip = 'Specifies the value of the Discharged By field.';
                }
                field("Collateral Types"; Rec."Collateral Types")
                {
                    ToolTip = 'Specifies the value of the Collateral Types field.';
                }
                field("Collateral Status"; Rec."Collateral Status")
                {
                    ToolTip = 'Specifies the value of the Collateral Status field.';
                }
                field("Collateral Value Sum"; Rec."Collateral Value Sum")
                {
                    ToolTip = 'Specifies the value of the Collateral Value Sum field.';
                }
                field("Law Firm Hanlding the Matter"; Rec."Law Firm Hanlding the Matter")
                {
                    ToolTip = 'Specifies the value of the Law Firm Hanlding the Matter field.';
                }
                field("Date of Issuance Instructions"; Rec."Date of Issuance Instructions")
                {
                    ToolTip = 'Specifies the value of the Date of Issuance of Instructions field.';
                }
            }
        }
    }
}
