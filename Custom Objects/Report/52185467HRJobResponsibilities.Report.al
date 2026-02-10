#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185467 "HR Job Responsibilities"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/HR Job Responsibilities.rdl';

    dataset
    {
        dataitem("HR Jobs"; "HR Jobs")
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Job ID";
            column(ReportForNavId_9002; 9002)
            {
            }
            column(JobDescription_HRJobs; "HR Jobs"."Job Description")
            {
                IncludeCaption = true;
            }
            column(Position_Reporting_Name; "Position Reporting Name")
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
            dataitem("HR Job Responsiblities"; "HR Job Responsiblities")
            {
                DataItemLink = "Job ID" = field("Job ID");
                DataItemTableView = sorting("Job ID", "Responsibility Code");
                PrintOnlyIfDetail = false;
                column(ReportForNavId_3841; 3841)
                {
                }
                column(JobID_HRJobResponsiblities; "HR Job Responsiblities"."Job ID")
                {
                }
                column(ResponsibilityDescription_HRJobResponsiblities; "HR Job Responsiblities"."Responsibility Description")
                {
                }
                column(Remarks_HRJobResponsiblities; "HR Job Responsiblities".Remarks)
                {
                }
                column(ResponsibilityCode_HRJobResponsiblities; "HR Job Responsiblities"."Responsibility Code")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    No := No + 1;
                end;

                trigger OnPreDataItem()
                begin

                    No := 0;
                end;
            }
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
        No := 1;
    end;

    var
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        No: Integer;
}
