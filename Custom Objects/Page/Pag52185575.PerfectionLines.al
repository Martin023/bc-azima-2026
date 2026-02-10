page 52185575 "Perfection Lines"
{
    Caption = 'Perfection Lines';
    PageType = ListPart;
    SourceTable = "Perfection Lines";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Header No. field.';
                }
                field("Security No."; Rec."Security No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Security No. field.';
                }
                field("Property No."; Rec."Property No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Property No. field.';
                }
                field("Collateral Value Sum"; Rec."Collateral Value Sum")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Collateral Value Sum field.';
                    Caption = 'Collateral Value';
                }
                field("Force Sale Value"; Rec."Forced Sale Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Force Sale Value field.';
                }
                field("Market Value"; Rec."Market Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Market Value field.';
                }
                field("Spousal Consent"; Rec."Spousal Consent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Spousal Consent field.';
                }
                field("Land Control Board Consent"; Rec."Land Control Board Consent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Land Control Board Consent field.';
                }
                field("Fees Payable to the Firm"; Rec."Fees Payable to the firm")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fees Payable to the Firm field.';
                }
                field("Status of the fees"; Rec."Status of the fees")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status of the fees field.';
                }
                field("Charge Type"; Rec."Charge Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Charge Type field.';
                }
                field("Amount to Charge"; Rec."Amount to Charge")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount to Charge field.';
                }
                // field("Market Value"; Rec."Market Value")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Market Value field.';
                // }
                // field("Forced Sale Value"; Rec."Forced Sale Value")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Forced Sale Value field.';
                // }
                field("Collateral Types"; Rec."Collateral Types")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Collateral Types field.';
                }
                field(Perfected;Rec.Perfected)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Perfected field.';
                }
                field(Discharged;Rec.Discharged)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Discharged field.';
                }
            }
        }
    }
}
