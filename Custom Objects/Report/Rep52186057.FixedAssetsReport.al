report 52186057 "Fixed Assets Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Fixed Assets Depreciation.rdl';

    dataset
    {

        dataitem(FALedgerEntry; "FA Ledger Entry")
        {
            RequestFilterFields = "FA Posting Type";
            column(Amount; Amount)
            {
            }
            column(FANo; "FA No.")
            {
            }
            column(FAPostingCategory; "FA Posting Category")
            {
            }
            column(FAPostingDate; "FA Posting Date")
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(DocumentType; "Document Type")
            {
            }
            column(Description; Description)
            {
            }
            column(FAPostingType; "FA Posting Type")
            {
            }
            column(DeprStartingDateCustom1; "Depr. Starting Date (Custom 1)")
            {
            }
            column(DepreciationBookCode; "Depreciation Book Code")
            {
            }
            column(DepreciationEndingDate; "Depreciation Ending Date")
            {
            }
            column(DepreciationMethod; "Depreciation Method")
            {
            }
            column(DisposalCalculationMethod; "Disposal Calculation Method")
            {
            }
            column(DisposalEntryNo; "Disposal Entry No.")
            {
            }
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
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
