#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185465 "HR Jobs (Vacant)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/HR Jobs (Vacant).rdl';
    Caption = 'HR Jobs (Vacant)';

    dataset
    {
        dataitem("HR Jobs"; "HR Jobs")
        {


            RequestFilterFields = "Job ID";
            column(ReportForNavId_9002; 9002)
            {
            }
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
            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_City; CI.City)
            {
            }
            column(CI__Address_2______CI__Post_Code_; CI."Address 2")
            {
            }
            column(CI_Address; CI.Address)
            {
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
            }
            column(HR_Jobs__Job_ID_; "Job ID")
            {
            }
            column(Status; Status)
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
            column(Position_Reporting_Name; "Position Reporting Name")
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
            column(Jobs_with_Vacant_PositionsCaption; Jobs_with_Vacant_PositionsCaptionLbl)
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
            dataitem("HR Job Requirements"; "HR Job Requirements")
            {
                DataItemLink = "Job ID" = FIELD("Job ID");
                column(Qualification_Type; "Qualification Type")
                {

                }
                column(Qualification_Code; "Qualification Code")
                {

                }
                column(Qualification_Description; "Qualification Description")
                {

                }
            }
            dataitem("HR Job Responsiblities"; "HR Job Responsiblities")
            {
                DataItemLink = "Job ID" = FIELD("Job ID");
                column(Responsibility_Code; "Responsibility Code")
                {

                }
                column(Responsibility_Description; "Responsibility Description")
                {

                }
                column(Remarks; Remarks)
                {

                }
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
        //ERROR('');

        CI.Reset;
        CI.Get();
        CI.CalcFields(CI.Picture);
    end;

    var
        CI: Record "Company Information";
        HR_JobsCaptionLbl: label 'HR Jobs';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Jobs_with_Vacant_PositionsCaptionLbl: label 'Jobs with Vacant Positions';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        Userid: label 'USERID';
        HRJobs: Record "HR Jobs";
        JobIDDesc: Text;
}
