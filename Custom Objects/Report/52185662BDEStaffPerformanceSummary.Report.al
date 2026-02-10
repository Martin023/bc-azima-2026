#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185662 "BDE Staff Performance Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/BDE Staff Performance Summary.rdl';

    dataset
    {
        dataitem("BDE Management Header"; "BDE Management Header")
        {
            column(ReportForNavId_1; 1)
            {
            }
            // column(CName;Company.Name)
            // {
            // }
            // column(CAddress;Company.Address)
            // {
            // }
            // column(CPicture;Company.Picture)
            // {
            // }
            column(EmployeeNo; "BDE Management Header"."Employee No")
            {
            }
            column(EmployeeName; "BDE Management Header"."Employee Name")
            {
            }
            dataitem("BDE Management Lines"; "BDE Management Lines")
            {
                DataItemLink = "Header No" = field("No.");
                column(ReportForNavId_2; 2)
                {
                }
                column(ProductType; "BDE Management Lines"."Product Type")
                {
                }
                column(Type; "BDE Management Lines".Type)
                {
                }
                column(GroupTarget; "BDE Management Lines"."Group Target")
                {
                }
                column(IndividualTarget; "BDE Management Lines"."Individual Target")
                {
                }
                column(NoSold; "BDE Management Lines"."No. Sold")
                {
                }
                column(Disbursed; "BDE Management Lines".Disbursed)
                {
                }
                column(PendingSact; "BDE Management Lines"."Pending Sact")
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
        Company.Reset;
        Company.CalcFields(Picture);
    end;

    var
        Company: Record "Company Information";
}
