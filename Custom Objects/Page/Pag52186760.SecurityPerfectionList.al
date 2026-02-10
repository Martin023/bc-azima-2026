page 52186760 "Security Perfection List"
{
    ApplicationArea = All;
    Caption = 'Security Perfection List';
    PageType = List;
    SourceTable = "Security Perfection";
    UsageCategory = Lists;
    CardPageId = "Security Perfection Card";
    //Editable = false;

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
                field("Loan No."; Rec."Loan No.")
                {
                    ToolTip = 'Specifies the value of the Loan No field.';
                }
                field("Loan Name"; Rec."Loan Name")
                {
                    Caption = 'Type of Loan';
                    ToolTip = 'Specifies the value of the Loan Name field.';
                }
                field("Amount"; Rec."Amount")
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                // field("Collateral Types"; Rec."Collateral Types")
                // {
                //     ToolTip = 'Specifies the value of the Collateral Types field.';
                // }
                // field("Amount to Charge"; Rec."Amount to Charge")
                // {
                //     ToolTip = 'Specifies the value of the Amount to Charge field.';
                // }
                // field("Collateral Type"; Rec."Collateral Types")
                // {
                //     ToolTip = 'Specifies the value of the Collateral Type field.';
                // }
                // field("Market Value"; Rec."Market Value")
                // {
                //     ToolTip = 'Specifies the value of the Market Value field.';
                // }
                // field("Force Sale Value"; Rec."Force Sale Value")
                // {
                //     ToolTip = 'Specifies the value of the Force Sale Value field.';
                // }
                field("Lending Unit"; Rec."Lending Unit")
                {
                    ToolTip = 'Specifies the value of the Lending Unit field.';
                }
                field("Date of Issuance Instructions"; Rec."Date of Issuance Instructions")
                {
                    ToolTip = 'Specifies the value of the Date of Issuance of Instructions field.';
                }
                field("Law firm Handling the Matter"; Rec."Law Firm Hanlding the Matter")
                {
                    Caption = 'Law Firm Handling the Matter';
                    ToolTip = 'Specifies the value of the Law firm Hanfling the Matter field.';
                }
                field("Perfection Stage"; Rec."Perfection Stage")
                {
                    ToolTip = 'Specifies the value of the Perfection Stage field.';
                }
                field("Captured On"; Rec."Created at")
                {
                    ToolTip = 'Specifies the value of the Captured On field.';
                }
                field(Perfected; Rec.Perfected)
                {
                    ToolTip = 'Specifies the value of the Perfected field.';
                }
                field("Date of Registration"; Rec."Date Perfected")
                {
                    ToolTip = 'Specifies the value of the Date of Registration field.';
                }
            }
        }
    }
}
