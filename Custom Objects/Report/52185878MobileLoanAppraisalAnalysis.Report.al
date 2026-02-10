#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185878 "Mobile Loan Appraisal Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Mobile Loan Appraisal Analysis.rdl';

    dataset
    {
        dataitem("Sky Mobile Loan Appraisal"; "Sky Mobile Loan Appraisal")
        {
            RequestFilterFields = "Member No.", MBoosta, "ID No.", "Phone No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(AccountNo_SkyMobileLoanAppraisal; "Sky Mobile Loan Appraisal"."Account No.")
            {
            }
            column(Name_SkyMobileLoanAppraisal; "Sky Mobile Loan Appraisal".Name)
            {
            }
            column(MemberNo_SkyMobileLoanAppraisal; "Sky Mobile Loan Appraisal"."Member No.")
            {
            }
            column(PhoneNo_SkyMobileLoanAppraisal; "Sky Mobile Loan Appraisal"."Phone No.")
            {
            }
            column(IDNo_SkyMobileLoanAppraisal; "Sky Mobile Loan Appraisal"."ID No.")
            {
            }
            column(MBoosta_SkyMobileLoanAppraisal; "Sky Mobile Loan Appraisal".MBoosta)
            {
            }
            column(SaccoName; SaccoName)
            {
            }
            column(SaccoAddress; SaccoAddress)
            {
            }
            column(Slogan; Slogan)
            {
            }
            column(SaccoPhone; SaccoPhone)
            {
            }
            column(DateIssued; DateIssued)
            {
            }
            column(Email; Email)
            {
            }
            column(Website; Website)
            {
            }
            column(PrintedBy; PrintedBy)
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
        CompanyInformation.Get;
        SaccoName := CompanyInformation.Name;
        SaccoAddress := CompanyInformation.Address;
        SaccoPhone := CompanyInformation."Phone No.";
        Slogan := 'Your Future Our Concern';
        CompanyInformation.CalcFields(Picture);
        Email := CompanyInformation."E-Mail";
        Website := CompanyInformation."Home Page";

        //DateIssued := MemPort.FormatDate(Today);

        PrintedBy := CopyStr(UserId, StrPos(UserId, '\') + 1, 50);
    end;

    var
        SaccoName: Text;
        SaccoAddress: Text;
        Slogan: Text;
        SaccoPhone: Text;
        DateIssued: Text;
        CompanyInformation: Record "Company Information";
        // MemPort: Codeunit "Sky Members Portal";
        Email: Text;
        Website: Text;
        PrintedBy: Text;
}
