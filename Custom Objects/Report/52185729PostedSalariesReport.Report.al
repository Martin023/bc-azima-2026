#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185729 "Posted Salaries Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Posted Salaries Report.rdl';

    dataset
    {
        //dataitem(52185783;52185783)
        dataitem("Salary Header"; "Salary Header")
        {
            DataItemTableView = where(Posted = const(True));
            RequestFilterFields = "Employer Code", "Income Type", "Posting date";
            column(ReportForNavId_1; 1)
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
            column(SNo; "SNo.")
            {
            }
            column(AccountName; "Salary Header"."Account Name")
            {
            }
            column(EmployerCode; "Salary Header"."Employer Code")
            {
            }
            column(AccountType; "Salary Header"."Account Type")
            {
            }
            column(ScheduledAmount; "Salary Header"."Scheduled Amount")
            {
            }
            column(No; "Salary Header".No)
            {
            }
            column(EnteredBy; "Salary Header"."Entered By")
            {
            }
            //dataitem(52185784;52185784)
            dataitem("Salary Lines"; "Salary Lines")
            {
                DataItemLink = "Salary Header No." = field(No);
                column(ReportForNavId_4; 4)
                {
                }
                column(Posted; "Salary Lines".Posted)
                {
                }
                column(PostedBy; "Salary Lines"."Posted By")
                {
                }
                column(PostingDate; "Salary Lines"."Posting Date")
                {
                }
                column(PostingTime; "Salary Lines"."Posting Time")
                {
                }
                column(AccountNo; "Salary Lines"."Account No.")
                {
                }
                column(StaffNo; "Salary Lines"."Staff No.")
                {
                }
                column(Name; "Salary Lines".Name)
                {
                }
                column(Amount; "Salary Lines".Amount)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                "SNo." += 1;
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
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        "SNo.": Integer;
}
