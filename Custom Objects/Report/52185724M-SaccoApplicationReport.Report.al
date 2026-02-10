#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185724 "M-Sacco Application Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/M-Sacco Application Report.rdl';

    dataset
    {
        //dataitem(52185757;52185757)
        dataitem("M-SACCO Applications"; "M-SACCO Applications")
        {
            RequestFilterFields = "Entered By", "Customer ID No", Status, "Changed By";
            column(ReportForNavId_1; 1)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            // column(CompanyAddress; "M-SACCO Applications".CompanyAddress)
            // {
            // }
            // column(CompanyTelephone; "M-SACCO Applications".CompanyTelephone)
            // {
            // }
            // column(CommunicationOnline; "M-SACCO Applications".CommunicationOnline)
            // {
            // }
            // column(SNo; "M-SACCO Applications"."SNo.")
            // {
            // }
            column(DateEntered; "M-SACCO Applications"."Document Date")
            {
            }
            column(EnteredBy; "M-SACCO Applications"."Entered By")
            {
            }
            column(ApplicationNo; "M-SACCO Applications"."Application No")
            {
            }
            column(No; "M-SACCO Applications".No)
            {
            }
            column(MembershipNo; "M-SACCO Applications"."Membership No")
            {
            }
            column(AccountNo; "M-SACCO Applications"."Account No")
            {
            }
            column(ChangedBy; "M-SACCO Applications"."Changed By")
            {
            }
            column(Changed; "M-SACCO Applications".Changed)
            {
            }
            column(DateChanged; "M-SACCO Applications"."Date Changed")
            {
            }
            column(ApplicationType; "M-SACCO Applications"."Application Type")
            {
            }
            column(Status; "M-SACCO Applications".Status)
            {
            }
            column(CustomerIDNo; "M-SACCO Applications"."Customer ID No")
            {
            }
            column(CustomerName; "M-SACCO Applications"."Customer Name")
            {
            }
            column(MPESAMobileNo; "M-SACCO Applications"."MPESA Mobile No")
            {
            }
            ///dataitem(52185758;52185758)
            dataitem("M-SACCO Application Details"; "M-SACCO Application Details")
            {
                DataItemLink = "Application No" = field(No);
                column(ReportForNavId_15; 15)
                {
                }
                column(AccountTypeils; "M-SACCO Application Details"."Account Type")
                {
                }
                column(AccountNo1; "M-SACCO Application Details"."Account No.")
                {
                }
                column(Description; "M-SACCO Application Details".Description)
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
