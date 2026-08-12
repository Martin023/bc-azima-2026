#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006
Report 52185480 "HR Leave Application"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/HR Leave Application.rdl';

    dataset
    {
        dataitem("HR Leave Application"; "HR Leave Application")
        {
            RequestFilterFields = "Application Code";

            column(ReportForNavId_1000000000; 1000000000) { }
            column(CompanyInformation_Name; CompanyInfo.Name) { }
            column(CompanyInformation_Picture; CompanyInfo.Picture) { }
            column(CompanyAddress; CompanyAddress) { }
            column(CompanyTelephone; CompanyTelephone) { }
            column(CommunicationOnline; CommunicationOnline) { }

            column(ApplicationCode_HRLeaveApplication; "Application Code") { }
            column(EmployeeNo_HRLeaveApplication; "Applicant Staff No.") { }
            column(Names_HRLeaveApplication; Names) { } 
            column(JobTittle_HRLeaveApplication; "Job Tittle") { }
            column(ApplicationDate_HRLeaveApplication; "Application Date") { }
            column(LeaveType_HRLeaveApplication; "Leave Type") { }
            column(DaysApplied_HRLeaveApplication; "Days Applied") { }
            column(StartDate_HRLeaveApplication; "Start Date") { }
            column(ReturnDate_HRLeaveApplication; "Return Date") { }
            column(Reliever_HRLeaveApplication; Reliever) { }
            column(RelieverName_HRLeaveApplication; "Reliever Name") { }
            column(Status; Status) { }
            column(RequestLeaveAllowance_HRLeaveApplication; "Request Leave Allowance") { }
            column(LeaveAllowanceAmount_HRLeaveApplication; "Leave Allowance Amount") { }
            column(NumberofPreviousAttempts_HRLeaveApplication; "Number of Previous Attempts") { }
            column(DetailsofExamination_HRLeaveApplication; "Details of Examination") { }
            column(DateofExam_HRLeavseApplication; "Date of Exam") { }
            column(EmailAddress_HRLeaveApplication; "E-mail Address") { }
            column(CellPhoneNumber_HRLeaveApplication; "Cell Phone Number") { }
            column(Approveddays_HRLeaveApplication; "Approved days") { }
        }
    }

    requestpage
    {
        layout { }
        actions { }
    }

    trigger OnPreReport()
    begin
        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(Picture);
        
        CompanyAddress := CompanyInfo.Address + ' - ' + CompanyInfo."Post Code" + ' ' + CompanyInfo.City;
        CompanyTelephone := 'Tel: ' + CompanyInfo."Phone No." + ' / ' + CompanyInfo."Phone No. 2";
        CommunicationOnline := 'Email: ' + CompanyInfo."E-Mail" + ' - Web: ' + CompanyInfo."Home Page";
    end;

    var
        CompanyInfo: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}