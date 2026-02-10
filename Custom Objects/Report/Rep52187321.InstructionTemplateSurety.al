report 52187332 "Instruction Template - Surety"
{
    ApplicationArea = All;
    Caption = 'Instruction Template - Surety CEO';
    //UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = './bc-kenpipe-2024/Layout/Instruction Template Surety.docx';
    dataset
    {
        dataitem(SuretyManagement; "Surety Management")
        {
            RequestFilterFields = "Surety No";
            column(MemberNo; "Account No")
            {
            }
            column(MemberNos; "Member Nos")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(MemberAccountNo; "Member Account No")
            {
            }
            column(Date; "Date")
            {
            }
            column(Court; "Court Name")
            {
            }
            column(RefferenceNo; "Refference No")
            {
            }
            column(Amount; Amount)
            {
            }
            column(OutstandingBalance; "Outstanding Balance")
            {
            }
            column(SuretyNo; "Surety No")
            {
            }
            column(SuretyAmount; "Surety Amount")
            {
            }
            column(CaseNo; "Case No")
            {
            }
            column(AccountName; "Account Name")
            {
            }
            column(AccountNo; "Account No")
            {
            }
            column(Accused; Accused)
            {
            }
            column(Summary; Summary)
            {
            }
            column(Description; "Name of Case")
            {
            }
            column(LegalOfficer; CompanyInformation."Legal Officer Name")
            {
            }
            column(LegalOfficerTitle; CompanyInformation."Legal Officer Title")
            {
            }
            column(CEO; CompanyInformation.CEO)
            {
            }
            column(CourtAddress; "Court Address")
            {
            }
            column(CourtPhysicalAddress; "Court Physical Address")
            {
            }
            column(LegalOfficerSignature; CompanyInformation."Legal Officer Signature")
            {
            }
            column(CEOSignature; CompanyInformation."CEO Signature")
            {
            }
            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
                CompanyInformation.CalcFields("Legal Officer Signature");
                CompanyInformation.CalcFields("CEO Signature");
            end;
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
            // CompanyInformation.CalcFields(CompanyInformation.Picture);
            // CompanyInformation.CalcFields(CompanyInformation."Legal Officer Signature");
        CompanyInformation.CalcFields(CompanyInformation."CEO Signature");
        // CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        // CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        // CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
        LegalOfficer := CompanyInformation."Legal Officer Name";
        LegalOfficerTitle := CompanyInformation."Legal Officer Title";
        //LegalOfficerSignature := CompanyInformation."Legal Officer Signature";
        //CEO := CompanyInformation.CEO;
    end;

    Var
        LegalOfficer: Text;
        LegalOfficerTitle: Text;
        CEO: Text;
        CompanyInformation: Record "Company Information";
}
