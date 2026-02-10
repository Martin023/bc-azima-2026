page 52185751 "RTGS Transfer Lines"
{
    PageType = ListPart;
    SourceTable = "RTGS Transfer Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Source Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                    ValuesAllowed = Savings;
                }
                field("Source Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Source Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Charge Amount"; Rec."Charge Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Don't Charge"; Rec."Don't Charge")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount Text"; Rec."Amount Text")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("External Account No."; Rec."External Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Destination Account No.';
                }
                field("External Account Name"; Rec."External Account Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Destination Account Name';
                }
                field("Over Drawn"; Rec."Over Drawn")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Standing Order No"; Rec."Standing Order No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Standing Order Register No"; Rec."Standing Order Register No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Multiple Accounts"; Rec."Multiple Accounts")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Excise Duty"; Rec."Excise Duty")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Account Type" := Rec."Account Type"::Savings;
    end;
}

