#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185713 "Permissions Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Permissions Report.rdl';

    dataset
    {
        dataitem(Permission; Permission)
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(RoleID; Permission."Role ID")
            {
            }
            column(ObjectType; Permission."Object Type")
            {
            }
            column(ObjectID; Permission."Object ID")
            {
            }
            column(RPermission; Permission."Read Permission")
            {
            }
            column(Ipermission; Permission."Insert Permission")
            {
            }
            column(Mpermission; Permission."Modify Permission")
            {
            }
            column(DPermission; Permission."Delete Permission")
            {
            }
            column(EPermission; Permission."Execute Permission")
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
}
