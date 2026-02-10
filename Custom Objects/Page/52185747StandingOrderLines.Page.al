page 52185747 "Standing Order Lines"
{
    PageType = ListPart;
    SourceTable = "Standing Order Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Destination Account Type"; Rec."Destination Account Type")
                {
                    ApplicationArea = Basic;
                    ValuesAllowed = Savings, Credit;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }

                field("Destination Account No."; Rec."Destination Account No.")
                {
                    ApplicationArea = Basic;
                }

                field("Destination Account Name"; Rec."Destination Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                // field("Amount Deducted"; Rec."Amount Deducted")
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                // }
                field("Destination Account Balance"; Rec."Destination Account Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                // field("Bank Code"; Rec."Bank Code")
                // {
                //     ApplicationArea = Basic;
                //     Editable = true;
                // }
                // field("Bank Name"; Rec."Bank Name")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Branch Code"; Rec."Branch Code")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Bank Account No."; Rec."Bank Account No.")
                // {
                //     ApplicationArea = Basic;
                // }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        DestinationTypeControl;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Destination Account Type" := Rec."Destination Account Type"::"G/L Account";
    end;

    var
        BankEdit: Boolean;
        BranchEdit: Boolean;
        BankAccountNo: Boolean;

    //[Scope('OnPrem')]
    procedure DestinationTypeControl()
    begin
        case Rec."Destination Account Type" of
            Rec."Destination Account Type"::"G/L Account":
                begin
                    BankEdit := true;
                    BranchEdit := true;
                    BankAccountNo := true;
                end;

            Rec."Destination Account Type"::Savings, Rec."Destination Account Type"::Credit:
                begin
                    BankEdit := false;
                    BranchEdit := false;
                    BankAccountNo := false;
                end;
        end;
    end;
}

