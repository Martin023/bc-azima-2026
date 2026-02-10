report 52187390 "Instruction Template Ltg"
{
    ApplicationArea = All;
    Caption = 'Instruction Template Litigation';
    //UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = './bc-azima-2026/Layout/Instruction Template Ltg.docx';

    dataset
    {
        dataitem(Legal; Legal)
        {
            RequestFilterFields = "No.";
            column(No; "No.")
            {
            }
            column(CaseDescription; "Case Description")
            {
            }
            column(Name_of_Case; "Name of Case")
            {
            }
            column(CaseNumber; "Case Number")
            {
            }
            column(CaseType; "Matter Code")
            {
            }
            column(Legal_Fees; "Legal Fees")
            {
            }
            column(Date_of_Complaint; "Date of Filing the suit")
            {
            }
            column(Law_Firm; "Law Firm")
            {
            }
            column(AdvocateEmail; "Advocate E-mail")
            {
            }
            column(Case_Summary; "Case Summary")
            {
            }
            column(Lawyer; Lawyer)
            {
            }
            column(Address; Address)
            {
            }
            column(City; City)
            {
            }
            column(LegalOfficer; CompanyInformation."Legal Officer Name")
            {
            }
            column(LegalOfficerTitle; CompanyInformation."Legal Officer Title")
            {
            }
            column(LegalOfficerSignature; CompanyInformation."Legal Officer Signature")
            {
            }

        }
    }
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyInformation.CalcFields(CompanyInformation."Legal Officer Signature");
        // CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        // CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        // CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
        LegalOfficer := CompanyInformation."Legal Officer Name";
        LegalOfficerTitle := CompanyInformation."Legal Officer Title";
    end;

    // requestpage
    // {
    //     layout
    //     {
    //         area(content)
    //         {
    //             group(GroupName)
    //             {
    //             }
    //         }
    //     }
    //     actions
    //     {
    //         area(processing)
    //         {
    //         }
    //     }
    // }
    var
        CompanyInformation: Record "Company Information";
        LegalOfficer: Text;
        LegalOfficerTitle: Text;
        Addrrss: Text;
        City: Text;
}
