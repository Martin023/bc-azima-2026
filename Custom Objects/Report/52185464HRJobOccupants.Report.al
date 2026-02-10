#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185464 "HR Job Occupants"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/HR Job Occupants.rdl';
    Caption = 'HR Job Occupants Report';

    dataset
    {
        dataitem(HRJobApplications; "HR Job Applications")
        {


            column(ReportForNavId_1000000000; 1000000000)
            {
            }
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
            column(JobID_HRJobs; HRJobApplications."Job Application No.")
            {
                IncludeCaption = true;
            }
            column(JobDescription_HRJobs; HRJobApplications."Job Applied For")
            {
                IncludeCaption = true;
            }
            column(FullName; HRJobApplications.FullName)
            {

            }

            dataitem(Qualification; "HR Applicant Qualifications")
            {
                DataItemLink = "Application No" = field("Job Application No.");
                column(Qualification_Code; "Qualification Code")
                {

                }
                column(Qualification_Description; "Qualification Description")
                {

                }
                column(From_Date; "From Date")
                {

                }
                column(To_Date; "To Date")
                {

                }
                column(Type; Type)
                {

                }
                column(Institution_Company; "Institution/Company")
                {

                }
            }
            // trigger OnAfterGetRecord()
            // begin
            //     HRJob.Reset;
            //     HRJob.SetRange(HRJob."Job ID", "Job Title");
            //     if HRJob.Find('-') then
            //         CurrReport.SHOWOUTPUT := true;
            // end;
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
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;


    var

        HR_Job_OccupationsCaptionLbl: label 'HR Job Occupations';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Job_OccupantsCaptionLbl: label 'HR Job Occupants';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        NoCaptionLbl: label 'No';
        NameCaptionLbl: label 'Name';
        Company_E_MailCaptionLbl: label 'Company E-Mail';
        Postal_AddressCaptionLbl: label 'Postal Address';
        CityCaptionLbl: label 'City';
        HRJob: Record "HR Jobs";
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
