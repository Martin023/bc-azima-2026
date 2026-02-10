namespace MNS.MNS;

using Microsoft.Finance.GeneralLedger.Journal;

xmlport 52185574 "Bank Deposits Import"
{
    Caption = 'Bank Deposits Import';
    Format = VariableText;

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(GenJournalLine; "Gen. Journal Line")
            {
                fieldelement(JournalTemplateName; GenJournalLine."Journal Template Name")
                {
                }
                fieldelement(JournalBatchName; GenJournalLine."Journal Batch Name")
                {
                }
                // fieldelement(ExternalDocumentNo; GenJournalLine."External Document No.")
                // {
                // }
                fieldelement(AccountType; GenJournalLine."Account Type")
                {
                }
                fieldelement(AccountNo; GenJournalLine."Account No.")
                {
                }
                fieldelement(Description; GenJournalLine.Description)
                {
                }
                fieldelement(Document_Date; GenJournalLine."Document Date")
                {

                }
                fieldelement(DocumentNo; GenJournalLine."Document No.")
                {
                }
                fieldelement(CreditAmount; GenJournalLine."Credit Amount")
                {
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
