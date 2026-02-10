report 52186046 TrainingAttendees
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/HR Training Attendees Report.rdl';
    dataset
    {

        dataitem(HRTrainingAppHeader; "HR Training App Header")
        {
            RequestFilterFields = Duration;
            column(ApplicationNo; "Application No")
            {
            }
            column(ApplicationDate; "Application Date")
            {
            }
            column(ActualStartDate; "Actual Start Date")
            {
            }
            column(ActualEndDate; "Actual End Date")
            {
            }
            column(ActualDuration; "Actual Duration")
            {
            }
            column(BondedTraining; "Bonded Training?")
            {
            }
            column(CourseTitle; "Course Title")
            {
            }
            column(CourseDescription; "Course Description")
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(NoofParticipants; "No. of Participants")
            {
            }
            column(ResponsibilityCenter; "Responsibility Center")
            {
            }
            column(Courseapplying; "Course applying")
            {
            }
            column(TrainingCostCstimated; "Training Cost Cstimated")
            {
            }
            column(TrainingInstitution; "Training Institution")
            {
            }
            column(TrainingInstitutionName; "Training Institution Name")
            {
            }
            column(TrainingStatus; "Training Status")
            {
            }
            column(TrainingType; "Training Type")
            {
            }
            column(TrainingVenue; "Training Venue")
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
            column(Sponsored; Sponsored)
            {

            }

            dataitem("HR Training App Lines"; "HR Training App Lines")
            {

                DataItemLink = "Application No." = field("Application No");
                column(Line_No_; "Line No.")
                {

                }
                column(Employee_No_; "Employee No.")
                {

                }
                column(Name; Name)
                {

                }
                column(Job_ID; "Job ID")
                {

                }
                column(Participant_Email; "Participant Email")
                {

                }
                column(Notified; Notified)
                {

                }

            }
            dataitem("HR Training Needs"; "HR Training Needs")
            {
                DataItemLink = Code = field("Course Title");
                column(Provider; Provider)
                {

                }
                column(Provider_Name; "Provider Name")
                {

                }
                column(Bondage_Start_Date; "Bondage Start Date")
                {

                }
                column(Bondage_Duration; "Bondage Duration")
                {

                }
                column(Bondage_Release_Date; "Bondage Release Date")
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
