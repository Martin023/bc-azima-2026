#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185834 "Avocate Cost Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Avocate Cost Report.rdl';
    Caption = 'Advocate Cost Report';

    dataset
    {
        dataitem(Legal; Legal)
        {
            RequestFilterFields = "Date of Filing the suit", "Case Number", "Total Cost";

            column(DescriptionofComplaint_Legal; Legal."Description of Complaint")
            {
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            column(TypeofComplainant_Legal; Legal."Type of Complainant")
            {
            }
            column(CaseNumber_Legal; Legal."Case Number")
            {
            }
            column(TotalCost_Legal; Legal."Total Cost")
            {
            }
            dataitem(Advocate; Advocate)
            {
                DataItemLink = No = field("Case Number");
                RequestFilterFields = No, Name;
                column(ReportForNavId_5; 5)
                {
                }
                column(No_Advocate; Advocate.No)
                {
                }
                column(Name_Advocate; Advocate.Name)
                {
                }
                column(TypeofFirm_Advocate; Advocate."Type of Firm")
                {
                }
                column(FirmNo_Advocate; Advocate."Firm No")
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
    end;

    var
        CI: Record "Company Information";
}
