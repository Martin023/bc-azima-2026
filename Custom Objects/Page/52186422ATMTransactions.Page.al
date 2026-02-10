page 52186422 "ATM Transactions"
{
    Editable = false;
    PageType = List;
    SourceTable = "ATM Transactions";
    ApplicationArea = Basic, Suite;
    //UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Trace ID"; Rec."Trace ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posting S"; Rec."Posting S")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Unit ID"; Rec."Unit ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Trans Time"; Rec."Trans Time")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reversed Posted"; Rec."Reversed Posted")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reversal Trace ID"; Rec."Reversal Trace ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Withdrawal Location"; Rec."Withdrawal Location")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Type Charges"; Rec."Transaction Type Charges")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Card Acceptor Terminal ID"; Rec."Card Acceptor Terminal ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ATM Card No"; Rec."ATM Card No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Customer Names"; Rec."Customer Names")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Process Code"; Rec."Process Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Is Coop Bank"; Rec."Is Coop Bank")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("POS Vendor"; Rec."POS Vendor")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reference No"; Rec."Reference No")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Reverse Mobile Transaction")
            {
                ApplicationArea = Basic, Suite;

                trigger OnAction()
                begin

                    SkyPermissions.Reset;
                    SkyPermissions.SetRange("User ID", UserId);
                    SkyPermissions.SetRange("Reverse Sky Transactions", true);
                    if not SkyPermissions.FindFirst then begin
                        Error('You do not have the permission to Reverse Mpesa Transactions');
                    end;


                    if Confirm('Are you sure you want Reverse this transaction?') then begin
                        rec.TestField(Reversed, false);
                        rec.TestField(Posted, false);
                        rec.TestField(Source, rec.Source::"M-PESA");
                        // SkyMbanking.ReverseWithdrawalRequest(rec."Trace ID");
                    end;
                end;
            }
            action("Undo Reversal")
            {
                ApplicationArea = Basic, Suite;

                trigger OnAction()
                begin

                    SkyPermissions.Reset;
                    SkyPermissions.SetRange("User ID", UserId);
                    SkyPermissions.SetRange("Reverse Sky Transactions", true);
                    if not SkyPermissions.FindFirst then begin
                        Error('You do not have the permission to Reverse Mpesa Transactions');
                    end;


                    if Confirm('Are you sure you want Reverse this transaction?') then begin
                        rec.TestField(Reversed, true);
                        rec.TestField(Posted, true);
                        rec.TestField(Source, rec.Source::"M-PESA");
                        // SkyMbanking.UndoReversal(rec."Trace ID");
                    end;
                end;
            }
        }
    }

    var
        SkyPermissions: Record "Sky Permissions";
        // SkyMbanking: Codeunit "Sky Mbanking";
}

