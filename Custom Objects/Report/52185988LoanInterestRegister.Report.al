#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185988 "Loan Interest  Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Loan Interest  Register.rdl';
    Caption = 'Posted Loans Register';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = filter(True));
            RequestFilterFields = "Date Filter", "Disbursement Date";
            column(ReportForNavId_1; 1)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {

            }
            column(CompanyAddress; CompanyAddress)
            {

            }
            column(CompanyNam; CompanyNam)
            {

            }
            column(LoanNo_Loans; Loans."Loan No.")
            {
            }
            column(ApplicationDate_Loans; Loans."Application Date")
            {
            }
            column(LoanProductType_Loans; Loans."Loan Product Type")
            {
            }
            column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
            {
            }
            column(MemberNo_Loans; Loans."Member No.")
            {
            }
            column(MemberName_Loans; Loans."Member Name")
            {
            }
            column(Installemnt; Loans.Installments)
            {
            }
            column(RequestedAmount; Loans."Requested Amount")
            {
            }
            column(ApprovedAmount; Loans."Approved Amount")
            {
            }
            column(OutBal; Loans."Outstanding Balance")
            {
            }
            column(OutInt; Loans."Outstanding Interest")
            {
            }
            column(OutBill; Loans."Outstanding Bills")
            {
            }
            column(Picture; Company.Picture)
            {
            }
            column(EmployerLoanNo; Loans."Employer Loan No.")
            {
            }
            column(BatchNo_Loans; Loans."Batch No.")
            {
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        Company.Get;
        //Company.CALCFIELDS(Company.Picture);
        Company.CALCFIELDS(Company.Picture);
        CompanyNam := Company.Name;
        CompanyAddress := Company.Address + ' -Post Code: ' + Company."Post Code" + ' -City:' + Company.City + ' Region: ' + Company."Country/Region Code";
        CompanyTelephone := 'Tel: ' + Company."Phone No." + ' -Office Tel: ' + Company."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + Company."E-Mail" + '- Website: ' + Company."Home Page";
    end;

    var
        ProductType: Text;
        MemberBiodata: Text;
        Company: Record "Company Information";
        CompanyNam: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        CompanyAddress: Text;
}
