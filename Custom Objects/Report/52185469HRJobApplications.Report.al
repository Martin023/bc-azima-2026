#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185469 "HR Job Applications"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/HR Job Applications.rdl';

    dataset
    {
        dataitem("HR Job Applications"; "HR Job Applications")
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Job Application No.", "Job Applied For", "Date Applied", Status;
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(SectionA; SectionA)
            {
            }
            column(ApplicationNo_HRJobApplications; "HR Job Applications"."Job Application No.")
            {
                IncludeCaption = true;
            }
            column(FirstName_HRJobApplications; "HR Job Applications"."First Name")
            {
                IncludeCaption = true;
            }
            column(MiddleName_HRJobApplications; "HR Job Applications"."Middle Name")
            {
                IncludeCaption = true;
            }
            column(LastName_HRJobApplications; "HR Job Applications"."Last Name")
            {
                IncludeCaption = true;
            }
            column(FullName_HRJobApplications; "HR Job Applications"."Full Name")
            {
                IncludeCaption = true;
            }
            column(JobAppliedFor_HRJobApplications; "HR Job Applications"."Job Applied For")
            {
                IncludeCaption = true;
            }
            column(JobAppliedForDescription_HRJobApplications; "HR Job Applications"."Job Applied for Description")
            {
                IncludeCaption = true;
            }
            column(DateApplied_HRJobApplications; "HR Job Applications"."Date Applied")
            {
                IncludeCaption = true;
            }
            column(Status_HRJobApplications; "HR Job Applications".Status)
            {
                IncludeCaption = true;
            }
            column(City_HRJobApplications; "HR Job Applications".City)
            {
                IncludeCaption = true;
            }
            column(PostCode_HRJobApplications; "HR Job Applications"."Post Code")
            {
                IncludeCaption = true;
            }
            column(IDNumber_HRJobApplications; "HR Job Applications"."ID Number")
            {
                IncludeCaption = true;
            }
            column(Gender_HRJobApplications; "HR Job Applications".Gender)
            {
                IncludeCaption = true;
            }
            column(CountryCode_HRJobApplications; "HR Job Applications"."Country Code")
            {
                IncludeCaption = true;
            }
            column(SectionB; SectionB)
            {
            }
            column(HomePhoneNumber_HRJobApplications; "HR Job Applications"."Home Phone Number")
            {
                IncludeCaption = true;
            }
            column(CellPhoneNumber_HRJobApplications; "HR Job Applications"."Cell Phone Number")
            {
                IncludeCaption = true;
            }
            column(WorkPhoneNumber_HRJobApplications; "HR Job Applications"."Work Phone Number")
            {
                IncludeCaption = true;
            }
            column(EMail_HRJobApplications; "HR Job Applications"."E-Mail")
            {
                IncludeCaption = true;
            }
            column(PostalAddress_HRJobApplications; "HR Job Applications"."Postal Address")
            {
                IncludeCaption = true;
            }
            //ADDED COLUMNS FOR LIST VIEW
            column(QualificationsSummary; QualificationsSummary)
            {
            }
            column(ShowDetailedView; ShowDetailedView)
            {
            }
            column(ShowQualificationsSummary; ShowQualificationsSummary)
            {
            }
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_Address2; CI."Address 2")
            {
                IncludeCaption = true;
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            column(CI_EMail; CI."E-Mail")
            {
                IncludeCaption = true;
            }
            column(CI_HomePage; CI."Home Page")
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            
            trigger OnAfterGetRecord()
            begin
                //BUILD QUALIFICATIONS SUMMARY FOR LIST VIEW
                QualificationsSummary := '';
                if ShowQualificationsSummary then begin
                    HRApplicantQual.Reset();
                    HRApplicantQual.SetRange("Application No", "Job Application No.");
                    if HRApplicantQual.FindSet() then begin
                        repeat
                            if QualificationsSummary <> '' then
                                QualificationsSummary += '; ';
                            QualificationsSummary += HRApplicantQual."Qualification Description";
                        until HRApplicantQual.Next() = 0;
                    end;
                end;
            end;
            dataitem("HR Applicant Qualifications"; "HR Applicant Qualifications")
            {
                DataItemLink = "Application No" = field("Job Application No.");
                DataItemTableView = sorting("Application No", "Qualification Type", "Qualification Code") order(ascending);
                PrintOnlyIfDetail = false;
                column(ReportForNavId_1102755001; 1102755001)
                {
                }
                column(SectionC; SectionC)
                {
                }
                column(QualificationType_HRApplicantQualifications; "HR Applicant Qualifications"."Qualification Type")
                {
                    IncludeCaption = true;
                }
                column(QualificationCode_HRApplicantQualifications; "HR Applicant Qualifications"."Qualification Code")
                {
                    IncludeCaption = true;
                }
                column(QualificationDescription_HRApplicantQualifications; "HR Applicant Qualifications"."Qualification Description")
                {
                    IncludeCaption = true;
                }
                column(InstitutionCompany_HRApplicantQualifications; "HR Applicant Qualifications"."Institution/Company")
                {
                    IncludeCaption = true;
                }
                column(FromDate_HRApplicantQualifications; "HR Applicant Qualifications"."From Date")
                {
                    IncludeCaption = true;
                }
                column(ToDate_HRApplicantQualifications; "HR Applicant Qualifications"."To Date")
                {
                    IncludeCaption = true;
                }
            }
            dataitem("HR Applicant Referees"; "HR Applicant Referees")
            {
                DataItemLink = "Job Application No" = field("Job Application No.");
                DataItemTableView = sorting("Job Application No", Names) order(ascending);
                PrintOnlyIfDetail = false;
                column(ReportForNavId_1102755002; 1102755002)
                {
                }
                column(SectionD; SectionD)
                {
                }
                column(Names_HRApplicantReferees; "HR Applicant Referees".Names)
                {
                    IncludeCaption = true;
                }
                column(Designation_HRApplicantReferees; "HR Applicant Referees".Designation)
                {
                    IncludeCaption = true;
                }
                column(Institution_HRApplicantReferees; "HR Applicant Referees".Institution)
                {
                    IncludeCaption = true;
                }
                column(Address_HRApplicantReferees; "HR Applicant Referees".Address)
                {
                    IncludeCaption = true;
                }
                column(TelephoneNo_HRApplicantReferees; "HR Applicant Referees"."Telephone No")
                {
                    IncludeCaption = true;
                }
                column(EMail_HRApplicantReferees; "HR Applicant Referees"."E-Mail")
                {
                    IncludeCaption = true;
                }
            }
            dataitem("HR Applicant Hobbies"; "HR Applicant Hobbies")
            {
                DataItemLink = "Job Application No" = field("Job Application No.");
                DataItemTableView = sorting("Job Application No", Hobby) order(ascending);
                PrintOnlyIfDetail = false;
                column(ReportForNavId_1102755003; 1102755003)
                {
                }
                column(Hobby_HRApplicantHobbies; "HR Applicant Hobbies".Hobby)
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
                group(Options)
                {
                    Caption = 'Options';
                    field(ShowDetailedView; ShowDetailedView)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Detailed View';
                        ToolTip = 'Show detailed information including qualifications, referees, and hobbies for each applicant';
                    }
                    field(ShowQualificationsSummary; ShowQualificationsSummary)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Qualifications Summary';
                        ToolTip = 'Show summary of qualifications for each applicant in list view';
                    }
                }
            }
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
        CI.Get();
        CI.CalcFields(CI.Picture);

        //GET FILTER - NO LONGER REQUIRED FOR LIST VIEW
        JobApplicationNo := "HR Job Applications".GetFilter("HR Job Applications"."Job Application No.");
        //REMOVED MANDATORY FILTER CHECK TO ALLOW LIST OF ALL APPLICANTS
    end;

    var
        CI: Record "Company Information";
        SectionA: label 'Section A :: Personal Details';
        SectionB: label 'Section B :: Contact Details';
        SectionC: label 'Section C :: Academic and Qualification Information';
        SectionD: label 'Section D :: Applicant''s Refferees';
        JobApplicationNo: Text;
        ShowDetailedView: Boolean;
        ShowQualificationsSummary: Boolean;
        HRApplicantQual: Record "HR Applicant Qualifications";
        QualificationsSummary: Text[1000];
}
}
