#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185888 "Delegate Meeting Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Delegate Meeting Report.rdl';

    dataset
    {
        //dataitem(52186078;52186078)
        dataitem("ADM Registration"; "ADM Registration")
        {
            RequestFilterFields = "Delegate Region Description";
            column(ReportForNavId_11; 11)
            {
            }
            column(RegNo; "ADM Registration"."Reg No")
            {
            }
            column("Code"; "ADM Registration".Code)
            {
            }
            column(DelegateRegionDescription; "ADM Registration"."Delegate Region Description")
            {
            }
            column(ElectoralZone1; "ADM Registration"."Electoral Zone")
            {
            }
            column(ElectoralZoneName; "ADM Registration"."Electoral Zone Name")
            {
            }
            column(Status_ADMRegistration; "ADM Registration".Status)
            {
            }
            column(RegionCode_ADMRegistration; "ADM Registration"."Region Code")
            {
            }
            column(RegionName_ADMRegistration; "ADM Registration"."Region Name")
            {
            }
            column(Type_ADMRegistration; "ADM Registration".Type)
            {
            }
            column(AGMMemberNo; "ADM Registration"."AGM Member No")
            {
            }
            column(MemberIDNo; "ADM Registration"."Member ID No")
            {
            }
            column(MemberName; "ADM Registration"."Member Name")
            {
            }
            column(AGMYear; "ADM Registration"."AGM Year")
            {
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
            }
        }

        actions
        {
        }
    }

    labels
    {
    }
}
