namespace MNS.MNS;

using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Foundation.Company;

report 52186184 "Reccurring FA Journals Report"
{
    ApplicationArea = All;
    Caption = 'Reccurring FA Report';
    UsageCategory = History;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Reccurring FA Journals Report.rdl';
    dataset
    {
        dataitem(GenJournalLine; "Gen. Journal Line")
        {
            RequestFilterFields = "FA Posting Date", "FA Posting Type", "Account Type", "Recurring Method";
            DataitemTableView = where("FA Posting Type" = filter(Depreciation), "Recurring Method" = Const("F  Fixed"));
            column(LineNo; GenJournalLine."Line No.") { }
            column(JournalTemplate; GenJournalLine."Journal Template Name") { }
            column(JournalBatch; GenJournalLine."Journal Batch Name") { }
            column(RecurringMethod; GenJournalLine."Recurring Method") { }
            column(RecurringFrequency; GenJournalLine."Recurring Frequency") { }
            column(PostingDate; GenJournalLine."Posting Date") { }
            column(DocumentNo; GenJournalLine."Document No.") { }
            column(AccountType; GenJournalLine."Account Type") { }
            column(AccountNo; GenJournalLine."Account No.") { }
            column(FAPostingType; GenJournalLine."FA Posting Type") { }
            column(Description; GenJournalLine.Description) { }
            column(GenPostingType; GenJournalLine."Gen. Posting Type") { }
            column(GenProdPostingType; GenJournalLine."Gen. Prod. Posting Group") { }
            column(Amount; GenJournalLine.Amount) { }
            column(BranchCode; GenJournalLine."Shortcut Dimension 1 Code") { }
            column(ActivityCode; GenJournalLine."Shortcut Dimension 2 Code") { }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
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
    trigger OnPreReport()
    begin

        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
