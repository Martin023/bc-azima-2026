namespace ALProject.ALProject;
using Microsoft.Foundation.Company;

report 52186085 "Training Evaluation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Training Evaluation Report.rdl';
    dataset
    {
        dataitem(HRTrainingFeedbackForm; "HR Training Feedback Form")
        {
            column(DocumentNo; "Document No")
            {
            }
            column(CourseTitle; "Course Title")
            {
            }
            column(Description; Description)
            {
            }
            column(FromDate; "From Date")
            {
            }
            column(ToDate; "To Date")
            {
            }
            column(TrainingApplicationNo; "Training Application No")
            {
            }
            column(Location; Location)
            {
            }
            column(ProviderName; "Provider Name")
            {
            }
            column(PurposeofTraining; "Purpose of Training")
            {
            }
            column(Provider; Provider)
            {
            }
            column(EmployeeNo; "Employee No.")
            {
            }
            column(EmployeeName; "Employee Name")
            {
            }
            column(Department; Department)
            {
            }
            column(Text1; "Text 1")
            {
            }
            column(Text10; "Text 10")
            {
            }
            column(Text2; "Text 2")
            {
            }
            column(Text3; "Text 3")
            {
            }
            column(Text4; "Text 4")
            {
            }
            column(Text5; "Text 5")
            {
            }
            column(Text6; "Text 6")
            {
            }
            column(Text9; "Text 9")
            {
            }
            column(Status; Status)
            {
            }
            column(UserID; "User ID")
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

        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
