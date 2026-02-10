page 52185812 "Cheque Receipt Lines"
{
    PageType = ListPart;
    SourceTable = "Cheque Issue Lines";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cheque Serial No"; Rec."Cheque Serial No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Un pay Code"; Rec."Un pay Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Interpretation; Rec.Interpretation)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Unpay Date"; Rec."Unpay Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Un Pay Charge Amount"; Rec."Un Pay Charge Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Family Account No."; Rec."Family Account No.")
                {
                    Caption = 'Family Account No';
                    Editable = false;
                }
                field("Date _Refference No."; Rec."Date _Refference No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

