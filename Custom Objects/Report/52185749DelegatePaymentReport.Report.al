#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185749 "Delegate Payment Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Delegate Payment Report.rdl';

    dataset
    {
        //(52186063;52186063)
        dataitem("Delegate Members"; "Delegate Members")
        {
            RequestFilterFields = "Code";
            column(ReportForNavId_1; 1)
            {
            }
            column(MemberNo; "Delegate Members"."Delegate MNO.")
            {
            }
            column(MemberName; "Delegate Members"."Delegate Name")
            {
            }
            column(Postions; "Delegate Members".Position)
            {
            }
            column(Tilte; "Delegate Members"."Job Tittle")
            {
            }
            column(ElectoralZone; "Delegate Members"."Electoral Zone")
            {
            }
            column(RegionName; RegionName)
            {
            }
            column(AmountPaid; AmountPaid)
            {
            }
            column(DocNo; DocNo)
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

            trigger OnAfterGetRecord()
            begin
                RegionName := '';
                DocNo := '';
                AmountPaid := 0;
                if DelegateRegion.Get("Delegate Members"."Delegate Code") then
                    RegionName := DelegateRegion."Delegate Region Description";


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
        CompanyInformation.Get;
        CompanyInformation.CalcFields(Picture);
    end;

    var
        DelegateRegion: Record "Delegate Region";
        RegionName: Text;
        DelegatePaymentLine: Record "Delegate Payment Line";
        AmountPaid: Decimal;
        DocNo: Code[20];
        CompanyInformation: Record "Company Information";
}
