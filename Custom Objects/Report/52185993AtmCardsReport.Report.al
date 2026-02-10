#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185993 "Atm Cards Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Atm Cards Report.rdl';

    dataset
    {
        dataitem("Savings Accounts"; "Savings Accounts")
        {
            //DataItemTableView = where("Loan Disbursement Account" = filter(Yes));
            column(ReportForNavId_1; 1)
            {
            }
            column(No; "Savings Accounts"."No.")
            {
            }
            column(Name; "Savings Accounts".Name)
            {
            }
            column(ATMNo; "Savings Accounts"."ATM No.")
            {
            }
            column(CName; CompanyInformation.Name)
            {
            }
            column(CAdrress; CompanyInformation.Address)
            {
            }
            column(CPicture; CompanyInformation.Picture)
            {
            }
            column(TransactionNo; "Savings Accounts"."Transactional Mobile No")
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
        CompanyInformation.Get;
        CompanyInformation.CalcFields(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
}
