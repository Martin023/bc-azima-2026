page 52186195 "Charges List"
{
    CardPageID = "Charges Card";
    Editable = false;
    PageType = List;
    SourceTable = Charges;
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Uses Rates"; Rec."Uses Rates")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Vatable; Rec.Vatable)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("VAT Percentage(%)"; Rec."VAT Percentage(%)")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'VAT %';
                }
                field("IsService Charge"; Rec."IsService Charge")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("VAT Account"; Rec."VAT Account")
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

