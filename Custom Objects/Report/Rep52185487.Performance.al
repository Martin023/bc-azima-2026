report 52185487 "Performance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Performance.rdl';
    dataset
    {
        dataitem(hrappraisalheader; "hr appraisal header")
        {
            RequestFilterFields = "Appraisal Stage", Status;
            column(AppraisalNo; "Appraisal No")
            {
            }
            column(AppraisalDate; "Appraisal Date")
            {
            }
            column(EmployeeNo; "Employee No")
            {
            }
            column(EmployeeName; "Employee Name")
            {
            }
            column(Department; Department)
            {
            }
            column(AppraisalStage; "Appraisal Stage")
            {
            }
            column(SupervisorEmployeeNo; "Supervisor Employee No")
            {
            }
            dataitem("HR Appraisal Lines"; "HR Appraisal Lines")
            {
                RequestFilterFields = "Categorize As";
                DataItemLink = "Appraisal No" = FIELD("Appraisal No");
                column(Self_Rating; "Self Rating")
                {

                }
                column(Supervisor_Rating; "Supervisor Rating")
                {

                }
                column(Categorize_As; "Categorize As")
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
