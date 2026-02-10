#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185932 "Deligates Registration"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Deligates Registration.rdl';

    dataset
    {
        //dataitem(52186063;52186063)
        dataitem("Delegate Members"; "Delegate Members")
        {
            DataItemTableView = where(Code = filter(0290));
            RequestFilterFields = "Attended AGM";
            column(ReportForNavId_1; 1)
            {
            }
            column(D_Mem_No; "Delegate Members"."Delegate MNO.")
            {
            }
            column(D_Name; "Delegate Members"."Delegate Name")
            {
            }
            column(D_Position; "Delegate Members".Position)
            {
            }
            column(D_Code; "Delegate Members"."Delegate Code")
            {
            }
            column(D_type; "Delegate Members".Type)
            {
            }
            column(Comp_name; company.Name)
            {
            }
            column(comp__pic; company.Picture)
            {
            }
            column(Code_name; codename)
            {
            }

            trigger OnAfterGetRecord()
            begin
                DelegateRegion.Reset;
                DelegateRegion.SetRange(Code, "Delegate Members"."Delegate Code");
                if DelegateRegion.FindFirst then
                    codename := DelegateRegion."Delegate Region Description";
            end;

            trigger OnPreDataItem()
            begin
                company.Get;
                company.CalcFields(Picture);
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

    var
        company: Record "Company Information";
        DelegateRegion: Record "Delegate Region";
        codename: Text;
}
