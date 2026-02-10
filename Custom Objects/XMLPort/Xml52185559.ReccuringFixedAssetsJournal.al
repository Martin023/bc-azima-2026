namespace MNS.MNS;

using Microsoft.Finance.GeneralLedger.Journal;

xmlport 52185559 "Reccuring Fixed Assets Journal"
{
    Caption = 'Reccuring Fixed Assets Journal';
    FORMAT = Variabletext;

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(GenJournalLine; "Gen. Journal Line")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';
                fieldelement(JournalTemplate; GenJournalLine."Journal Template Name") { }
                fieldelement(JournalBatch; GenJournalLine."Journal Batch Name") { }
                fieldelement(RecurringMethod; GenJournalLine."Recurring Method")
                {
                    FieldValidate = No;
                }
                fieldelement(RecurringFrequency; GenJournalLine."Recurring Frequency") { }
                fieldelement(PostingDate; GenJournalLine."Posting Date") { }
                fieldelement(LineNo; GenJournalLine."Line No.") { }
                fieldelement(DocumentNo; GenJournalLine."Document No.") { }
                fieldelement(AccountType; GenJournalLine."Account Type") { }
                fieldelement(AccountNo; GenJournalLine."Account No.") { }
                fieldelement(FAPostingType; GenJournalLine."FA Posting Type") { }
                fieldelement(Description; GenJournalLine.Description) { }
                fieldelement(GenPostingType; GenJournalLine."Gen. Posting Type") { }
                fieldelement(GenProdPostingType; GenJournalLine."Gen. Prod. Posting Group") { }
                fieldelement(Amount; GenJournalLine.Amount) { }
                // fieldelement(DebitAmount; GenJournalLine."Debit Amount") { }
                // fieldelement(CreditAmount; GenJournalLine."Debit Amount") { }
                fieldelement(BranchCode; GenJournalLine."Shortcut Dimension 1 Code") { }
                fieldelement(ActivityCode; GenJournalLine."Shortcut Dimension 2 Code") { }

            }
        }
    }
    trigger OnPostXmlPort()
    var
        myInt: Integer;
    begin
        Message('Completed successfully.');
    end;
}
