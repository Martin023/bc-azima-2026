namespace MNS.MNS;

using Microsoft.Bank.Deposit;

pageextension 52185464 "Bank Deposit List" extends "Bank Deposit List"
{
    //Editable = true;
    //cardpageid = "Bank Deposit";

    PromotedActionCategories = 'New,Process,Report,New Bank Deposit,Open Bank Deposit,Bank Deposit,Approvals,Import,Clear Lines';
    actions
    {
        modify(BankDeposit)
        {
            Caption = 'New Bank Deposit';
            PromotedCategory = Category4;
            PromotedIsBig = true;
            Promoted = true;
        }
        addafter("Bank Deposit Test Report")
        {
            action(OpenBankDeposit)
            {
                Caption = 'Open Bank Deposit';
                PromotedCategory = Category5;
                PromotedIsBig = true;
                Promoted = true;
                runobject = page "Bank Deposit";

                trigger OnAction()
                var
                begin
                    Page.run(Page::"Bank Deposit", Rec);
                end;

            }

        }
    }
}
