#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185981 "Atm Card Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Atm Card Report.rdl';

    dataset
    {
        dataitem("ATM Applications"; "ATM Applications")
        {
            RequestFilterFields = "Account No";
            column(ReportForNavId_1; 1)
            {
            }
            column(CName; Company.Name)
            {
            }
            column(CAddress; Company.Address)
            {
            }
            column(CPicture; Company.Picture)
            {
            }
            column(AccNo; "ATM Applications"."Account No")
            {
            }
            column(ProductType; "ATM Applications"."Account Type")
            {
            }
            column(AtmNo; "ATM Applications"."Card No")
            {
            }
            column(AccountName; "ATM Applications"."Account Name")
            {
            }
            column(CardIssuedBy; "ATM Applications"."Card Issued By")
            {
            }
            column(ApprovedBy; ApprovedBy)
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

    trigger OnPreReport()
    begin
        Company.Get;
        Company.CalcFields(Company.Picture);
    end;

    var
        ApprovedBy: Text;
        Company: Record "Company Information";
}
