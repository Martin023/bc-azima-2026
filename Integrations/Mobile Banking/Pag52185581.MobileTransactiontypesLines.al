page 52185581 "Mobile Transaction types Lines"
{
    Caption = 'Mobile Transaction types Lines';
    PageType = ListPart;
    SourceTable = "Mobile Transaction types Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = true;
                }
                field("Charge Code"; Rec."Charge Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Charge Type"; Rec."Charge Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Charge Amount"; Rec."Charge Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Percentage of Amount"; Rec."Percentage of Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Minimum Amount"; Rec."Minimum Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Maximum Amount"; Rec."Maximum Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Staggered Charge Code"; Rec."Staggered Charge Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Charge Category"; Rec."Transaction Charge Category")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Recover Excise Duty"; Rec."Recover Excise Duty")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Withholding Tax"; Rec."Withholding Tax")
                {
                }
                field("Sky Revenue Share"; Rec."Sky Revenue Share")
                {
                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        SkyRevenueShareEnabled := Rec."Sky Revenue Share";
                    end;
                }
                field("Sky Revenue Share %"; Rec."Sky Revenue Share %")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = SkyRevenueShareEnabled;
                }
                field("Sky Revenue Share Account No."; Rec."Sky Revenue Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = SkyRevenueShareEnabled;
                }
            }
        }
    }

    actions
    {
    }

    // Variables
    var
        SkyRevenueShareEnabled: Boolean;
}


