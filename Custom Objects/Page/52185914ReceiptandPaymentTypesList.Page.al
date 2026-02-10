page 52185914 "Receipt and Payment Types List"
{
    PageType = List;
    SourceTable = "Receipts and Payment Types";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102758000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("VAT Chargeable"; Rec."VAT Chargeable")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Withholding Tax Chargeable"; Rec."Withholding Tax Chargeable")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Withholding Tax Code"; Rec."Withholding Tax Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("VAT Withholding Code"; Rec."VAT Withholding Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Default Grouping"; Rec."Default Grouping")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Pending Voucher"; Rec."Pending Voucher")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bank Account"; Rec."Bank Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transation Remarks"; Rec."Transation Remarks")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Direct Expense"; Rec."Direct Expense")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("External Clearance"; Rec."External Clearance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Exempt Amount"; Rec."Exempt Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;
}

