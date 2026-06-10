#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185463 "HR Jobs"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/HR Jobs.rdl';

    dataset
    {
        dataitem("HR Jobs"; "HR Jobs")
        {
            RequestFilterFields = "Job ID";

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            //column(CurrReport_PAGENO; CurrReport.PageNo)
            //{
            //}
            column(HR_Jobs_UserID; UserID)
            {
            }


            column(HR_Jobs__Job_ID_; "Job ID")
            {
            }
            column(HR_Jobs__Job_Description_; "Job Description")
            {
            }
            column(HR_Jobs__No_of_Posts_; "No of Posts")
            {
            }
            column(HR_Jobs__Position_Reporting_to_; "Position Reporting to")
            {
            }
            column(HR_Jobs__Occupied_Positions_; "Occupied Positions")
            {
            }
            column(HR_Jobs__Vacant_Positions_; "Vacant Positions")
            {
            }
            column(HR_JobsCaption; HR_JobsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Job_StatisticsCaption; Job_StatisticsCaptionLbl)
            {
            }
            column(P_O__BoxCaption; P_O__BoxCaptionLbl)
            {
            }
            column(HR_Jobs__Job_ID_Caption; "HR Jobs".FieldCaption("Job ID"))
            {
            }
            column(HR_Jobs__Job_Description_Caption; "HR Jobs".FieldCaption("Job Description"))
            {
            }
            column(HR_Jobs__No_of_Posts_Caption; "HR Jobs".FieldCaption("No of Posts"))
            {
            }
            column(HR_Jobs__Position_Reporting_to_Caption; "HR Jobs".FieldCaption("Position Reporting to"))
            {
            }
            column(HR_Jobs__Occupied_Positions_Caption; "HR Jobs".FieldCaption("Occupied Positions"))
            {
            }
            column(HR_Jobs__Vacant_Positions_Caption; "HR Jobs".FieldCaption("Vacant Positions"))
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
            column(Grade_HRJobs; Grade)
            {
            }
            column(ResponsibilityCenter_HRJobs; "Responsibility Center")
            {
            }
            column(GlobalDimension1Code_HRJobs; "Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_HRJobs; "Global Dimension 2 Code")
            {
            }
            column(Status_HRJobs; Status)
            {
            }
            column(DateCreated_HRJobs; "Date Created")
            {
            }
            column(ShowJobID; ShowJobID)
            {
            }
            column(ShowJobDescription; ShowJobDescription)
            {
            }
            column(ShowNoOfPosts; ShowNoOfPosts)
            {
            }
            column(ShowPositionReportingTo; ShowPositionReportingTo)
            {
            }
            column(ShowOccupiedPositions; ShowOccupiedPositions)
            {
            }
            column(ShowVacantPositions; ShowVacantPositions)
            {
            }
            column(ShowGrade; ShowGrade)
            {
            }
            column(ShowResponsibilityCenter; ShowResponsibilityCenter)
            {
            }
            column(ShowDimension1; ShowDimension1)
            {
            }
            column(ShowDimension2; ShowDimension2)
            {
            }
            column(ShowStatus; ShowStatus)
            {
            }
            column(ShowDateCreated; ShowDateCreated)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "HR Jobs".Validate("Vacant Positions");
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
                group(Options)
                {
                    Caption = 'Field Selection';
                    field(ShowJobID; ShowJobID)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Job ID';
                    }
                    field(ShowJobDescription; ShowJobDescription)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Job Description';
                    }
                    field(ShowNoOfPosts; ShowNoOfPosts)
                    {
                        ApplicationArea = All;
                        Caption = 'Show No. of Posts';
                    }
                    field(ShowPositionReportingTo; ShowPositionReportingTo)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Position Reporting To';
                    }
                    field(ShowOccupiedPositions; ShowOccupiedPositions)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Occupied Positions';
                    }
                    field(ShowVacantPositions; ShowVacantPositions)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Vacant Positions';
                    }
                    field(ShowGrade; ShowGrade)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Grade';
                    }
                    field(ShowResponsibilityCenter; ShowResponsibilityCenter)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Responsibility Center';
                    }
                    field(ShowDimension1; ShowDimension1)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Global Dimension 1';
                    }
                    field(ShowDimension2; ShowDimension2)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Global Dimension 2';
                    }
                    field(ShowStatus; ShowStatus)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Status';
                    }
                    field(ShowDateCreated; ShowDateCreated)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Date Created';
                    }
                }
            }
        }

        actions
        {
        }
        
        trigger OnOpenPage()
        begin
            //SET DEFAULT VALUES TO SHOW ALL FIELDS
            if not RequestOptionsInitialized then begin
                ShowJobID := true;
                ShowJobDescription := true;
                ShowNoOfPosts := true;
                ShowPositionReportingTo := true;
                ShowOccupiedPositions := true;
                ShowVacantPositions := true;
                ShowGrade := true;
                ShowResponsibilityCenter := true;
                ShowDimension1 := true;
                ShowDimension2 := true;
                ShowStatus := true;
                ShowDateCreated := true;
                RequestOptionsInitialized := true;
            end;
        end;
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

        HR_JobsCaptionLbl: label 'HR Jobs';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Job_StatisticsCaptionLbl: label 'HR Job Statistics';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        MyUserID: Text;
        UserSetup: Record "User Setup";
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        ShowJobID: Boolean;
        ShowJobDescription: Boolean;
        ShowNoOfPosts: Boolean;
        ShowPositionReportingTo: Boolean;
        ShowOccupiedPositions: Boolean;
        ShowVacantPositions: Boolean;
        ShowGrade: Boolean;
        ShowResponsibilityCenter: Boolean;
        ShowDimension1: Boolean;
        ShowDimension2: Boolean;
        ShowStatus: Boolean;
        ShowDateCreated: Boolean;
        RequestOptionsInitialized: Boolean;
}
