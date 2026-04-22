page 52185832 "Savings Statistics FactBox"
{
    Caption = 'Savings Statistics';
    PageType = CardPart;
    SourceTable = "Savings Accounts";

    layout
    {
        area(content)
        {
            group("Balance Details")
            {

                Caption = 'Balance Details';
            }
            field("No."; Rec."No.")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Account No.';

                trigger OnDrillDown()
                begin
                    ShowDetails;
                end;
            }
            field(Balance; Rec.Balance)
            {
                ApplicationArea = Basic, Suite;
            }
            field("Balance (LCY)"; Rec."Balance (LCY)")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;

                trigger OnDrillDown()
                var
                    DtldCustLedgEntry: Record "Savings Ledger Entry";
                    CustLedgEntry: Record "Savings Ledger Entry";
                begin
                    /*DtldCustLedgEntry.SETRANGE("Customer No.","No.");
                    //COPYFILTER("Global Dimension 1 Filter",DtldCustLedgEntry."Initial Entry Global Dim. 1");
                    //COPYFILTER("Global Dimension 2 Filter",DtldCustLedgEntry."Initial Entry Global Dim. 2");
                    //COPYFILTER("Currency Filter",DtldCustLedgEntry."Currency Code");
                    CustLedgEntry.DrillDownOnEntries(DtldCustLedgEntry);
                    */
                    AccountAccessLogging;

                end;
            }
            group(OD)
            {

                Caption = 'Overdraft';
                field("Authorised Over Draft"; Rec."Authorised Over Draft")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(UE)
            {

                Caption = 'Uncleared Effects';
                field("ATM Transactions"; Rec."ATM Transactions")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field(Yed; Rec.yed)
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("ATM Cards"; Rec."ATM Cards")
                {

                    ApplicationArea = Basic, Suite;

                    trigger OnDrillDown()
                    var
                        ATMCardStorage: Record "ATM Card Storage";
                    begin
                        ATMCardStorage.Reset();
                        ATMCardStorage.SetRange(ATMCardStorage."Account No.", rec."No.");
                        Page.Run(Page::"Atm Card", ATMCardStorage);
                    end;
                }
                field("Uncleared Cheques"; Rec."Uncleared Cheques")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Lien Placed"; Rec."Lien Placed")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Coop Transactions"; Rec."Coop Transactions")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Other Uncleared Effects"; Rec."One Month Installment")
                {
                    Caption = 'Witheld Funds';
                    ApplicationArea = Basic, Suite;
                }
            }
            group(AB)
            {

                Caption = 'Available Balance';
                //here
                // field(MinBalance; Rec.MinBalance)q
                // {
                //     Caption = 'Minumum Balance';
                // }
                // field("Available Balance"; (Rec."Balance (LCY)" + Rec."Authorised Over Draft") - (Rec."Uncleared Cheques" + Rec."ATM Transactions" + MinBalance + Rec."Lien Placed" + Rec.yed + Rec."Coop Transactions" + Rec."One Month Installment"))
                field("Available Balance"; (Rec."Balance" + Rec."Authorised Over Draft") - (Rec."Uncleared Cheques" + Rec."ATM Transactions" + MinBalance + Rec."Lien Placed" + Rec.yed + Rec."Coop Transactions" + Rec."One Month Installment"))
                {
                    Caption = 'Available Balance';
                }
                field("Savings Interest Earned"; Rec."Savings Interest Earned")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        MinBalance := 0;
        if ProdType.Get(Rec."Product Type") then begin
            MinBalance := ProdType."Minimum Balance";
        end;
    end;

    var
        Text000: Label 'Overdue Amounts (LCY) as of %1';
        ProdType: Record "Product Factory";
        MinBalance: Decimal;
        ActiveSession: Record "Active Session";
        PCNAME: Text;

    local procedure ShowDetails()
    begin
        PAGE.Run(PAGE::"Savings Account Card", Rec);
    end;

    //[Scope('OnPrem')]
    procedure AccountAccessLogging()
    var
        AccountAccessLog: Record "Account Access Log";
    begin


        AccountAccessLog.Init;
        AccountAccessLog.Source := AccountAccessLog.Source::Account;
        AccountAccessLog."Account No." := Rec."No.";
        AccountAccessLog.Date := Today;
        AccountAccessLog."Info Source" := AccountAccessLog."Info Source"::"Member Card";
        AccountAccessLog.Time := Time;
        AccountAccessLog."User Id" := UserId;
        AccountAccessLog.Insert(true);
    end;
}

