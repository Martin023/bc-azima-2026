#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185492 "HR Training Needs"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/HR Training Needs.rdl';

    dataset
    {
        dataitem("HR Training Needs"; "HR Training Needs")
        {
            RequestFilterFields = "Code", "Bondage Start Date", "Responsibility Center";
            column(ReportForNavId_1905; 1905)
            {
            }
            column(Location_HRTrainingNeeds; "HR Training Needs"."Re-Assessment Date")
            {
                IncludeCaption = true;
            }
            column(GlobalDimension2Code_HRTrainingNeeds; "HR Training Needs"."Responsibility Center")
            {
                IncludeCaption = true;
            }
            column(Closed_HRTrainingNeeds; "HR Training Needs"."Bondage Start Date")
            {
                IncludeCaption = true;
            }
            column(bondageduration; "HR Training Needs"."Bondage Duration")
            {
                IncludeCaption = true;
            }
            column(bondingreleasedate; "HR Training Needs"."Bondage Release Date")
            {
                IncludeCaption = true;
            }
            column(nonworkingdays; "HR Training Needs"."Inclusive of Non Working Days")
            {
                IncludeCaption = true;
            }
            column(ProviderName_HRTrainingNeeds; "HR Training Needs"."External Provider Name")
            {
                IncludeCaption = true;
            }
            column(Code_HRTrainingNeeds; "HR Training Needs".Code)
            {
                IncludeCaption = true;
            }
            column(StartDate_HRTrainingNeeds; "HR Training Needs"."Start Date")
            {
                IncludeCaption = true;
            }
            column(EndDate_HRTrainingNeeds; "HR Training Needs"."End Date")
            {
                IncludeCaption = true;
            }
            column(DurationUnits_HRTrainingNeeds; "HR Training Needs".Duration1)
            {
                IncludeCaption = true;
            }
            column(TotalCosts; "HR Training Needs"."Total Costs")
            {
                IncludeCaption = true;
            }

            column(Description_HRTrainingNeeds; "HR Training Needs".Description)
            {
                IncludeCaption = true;
            }
            column(location; "HR Training Needs".Location)
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
            trigger OnAfterGetRecord()
            begin
                // Ven.Get("HR Training Needs"."Qualification Code");
                // VN := Ven.Name;
            end;
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
        CI: Record "Company Information";
        VN: Text[50];
        Ven: Record Vendor;
        HR_Training_NeedsCaptionLbl: label 'HR Training Needs';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Training_NeedsCaptionLbl: label 'Training Needs';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        Name_of_Training_CourseCaptionLbl: label 'Name of Training Course';
        From__Date_CaptionLbl: label 'From (Date)';
        Duration_CaptionLbl: label 'Duration ';
        To__Date_CaptionLbl: label 'To (Date)';
        Cost_of_TrainingCaptionLbl: label 'Cost of Training';
        LocationCaptionLbl: label 'Location';
        ProviderCaptionLbl: label 'Provider';
        Brief_Description_of_Training_CourseCaptionLbl: label 'Brief Description of Training Course';
        Qualifications_to_be_attained_at_the_end_of_the_Training_CourseCaptionLbl: label 'Qualifications to be attained at the end of the Training Course';
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
