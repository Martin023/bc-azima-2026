#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186015 "Categorised Complaints"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Categorised Complaints.rdl';

    dataset
    {
        dataitem("Complain and Remarks"; "Complain and Remarks")
        {
            DataItemTableView = where(Type = const("Complains and Remarks"));
            column(ReportForNavId_1; 1)
            {
            }
            column(ComplaintCatagory_ComplainandRemarks; "Complain and Remarks"."Complaint Catagory")
            {
            }
            column(PrintedBy; PrintedBy)
            {
            }
            column(PrintedAt; PrintedAt)
            {
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

    trigger OnInitReport()
    begin
        PrintedBy := CopyStr(UserId, StrPos(UserId, '\') + 1, StrLen(UserId));
        //PrintedAt := SkyHarambeePortal.FormatDateTimeReverse(CurrentDatetime);
    end;

    var
        PrintedBy: Code[50];
        PrintedAt: Text;
    //SkyHarambeePortal: Codeunit "Sky Harambee Portal";
}
