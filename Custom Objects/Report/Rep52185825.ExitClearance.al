namespace ALProject.ALProject;
using Microsoft.Foundation.Company;

report 52185825 "Exit Clearance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/HR Employee Separation.rdl';
    ApplicationArea = All;
    Caption = 'Exit Clearance';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(hremployeeexitInterviews; "hr employee exit Interviews")
        {
            column(EmployeeNo; "Employee No.")
            {
            }
            column(EmployeeName; "Employee Name")
            {
            }
            column(Department; Department)
            {
            }
            column(DateOfInterview; "Date Of Interview")
            {
            }
            column(DateOfLeaving; "Date Of Leaving")
            {
            }
            column(EmploymentDate; "Employment Date")
            {
            }
            column(JobTitle; "Job Title")
            {
            }
            column(ReasonForLeaving; "Reason For Leaving")
            {
            }
            column(ReasonForLeavingOther; "Reason For Leaving (Other)")
            {
            }
            column(Status; Status)
            {
            }
            column(SupportReceived; "Support Received")
            {
            }
            column(WorkExperience; "Work Experience")
            {
            }
            column(roleplayed; "role played")
            {
            }
            column(TrainingReceived; "Training Received")
            {
            }
            column(InterviewerName; "Interviewer Name")
            {
            }
            column(InterviewDoneBy; "Interview Done By")
            {
            }
            column(DuesAmount; "Dues Amount")
            {
            }
            column(Comments; Comments)
            {
            }
            column(Comment; Comment)
            {
            }
            column(ExitInterviewNo; "Exit Interview No")
            {
            }
            column(Closed; Closed)
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
            column(Age; Age)
            {

            }
            column(Gender; Gender)
            {

            }
            column(Grade; Grade)
            {

            }
            trigger OnAfterGetRecord()
            begin
                Age := 0;
                Grade := '';
                Hremp.Reset();
                Hremp.SetRange("No.", hremployeeexitInterviews."Employee No.");
                if HrEmp.find('-') then begin
                    Age := Hremp.Age;
                    Gender := Hremp.Gender;
                    Grade := HrEmp."Salary Grade";

                end;
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
        HrEmp: record "HR Employees";
        Gender: option Male,Female;
        Age: Integer;
        Grade: code[40];

}
