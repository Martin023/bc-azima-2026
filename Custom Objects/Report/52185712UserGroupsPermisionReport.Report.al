#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185712 "User Groups Permision Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/User Groups Permision Report.rdl';

    dataset
    {
        dataitem(User; User)
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(UserID; User."User Name")
            {
            }
            column(Name; User."Full Name")
            {
            }
            column(CName; CompanyInformation.Name)
            {
            }
            column(CAddress; CompanyInformation.Address)
            {
            }
            column(CPicture; CompanyInformation.Picture)
            {
            }
            // dataitem("User Group Member"; "User Group Member")
            // {
            //     DataItemLink = "User Security ID" = field("User Security ID");
            //     column(ReportForNavId_4; 4)
            //     {
            //     }
            //     column(RoleID; "User Group Member"."User Group Code")
            //     {
            //     }
            //     column(GroupName; "User Group Member"."User Group Name")
            //     {
            //     }
            // }
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
        CompanyInformation.Get;
        CompanyInformation.CalcFields(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
}
