#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185855 "Checkoff Trans Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Checkoff Trans Report.rdl';

    dataset
    {
        dataitem("Checkoff  Receipt Transactions"; "Checkoff  Receipt Transactions")
        {
            //DataItemTableView = where(Posted=filter(Yes));
            RequestFilterFields = "Employer No", "Transaction Date";
            column(ReportForNavId_1; 1)
            {
            }
            // column(CompanyInformation_Name;CompanyInformation.Name)
            // {
            // }
            // column(CompanyInformation_Picture;CompanyInformation.Picture)
            // {
            // }
            // column(CompanyAddress;CompanyAddress)
            // {
            // }
            // column(CompanyTelephone;CompanyTelephone)
            // {
            // }
            // column(CommunicationOnline;CommunicationOnline)
            // {
            // }
            column(EmployerNo_CheckoffReceiptTransactions; "Checkoff  Receipt Transactions"."Employer No")
            {
            }
            column(No_CheckoffReceiptTransactions; "Checkoff  Receipt Transactions".No)
            {
            }
            column(TransactionDate_CheckoffReceiptTransactions; "Checkoff  Receipt Transactions"."Transaction Date")
            {
            }
            column(Employer_Name; "Checkoff  Receipt Transactions"."Employer  Account Name")
            {
            }
            column(Period; "Checkoff  Receipt Transactions"."Posting Period")
            {
            }
            column(Document_No; "Checkoff  Receipt Transactions"."Document No")
            {
            }
            dataitem("Checkoff  Receipt Trans Lines"; "Checkoff  Receipt Trans Lines")
            {
                DataItemLink = "Transaction No" = field(No);
                column(ReportForNavId_3; 3)
                {
                }
                column(TransactionType_CheckoffReceiptTransLines; "Checkoff  Receipt Trans Lines"."Transaction Type")
                {
                }
                column(Amount_CheckoffReceiptTransLines; "Checkoff  Receipt Trans Lines".Amount)
                {
                }
                column(AccountNo_CheckoffReceiptTransLines; "Checkoff  Receipt Trans Lines"."Account No")
                {
                }
                column(ReceiptDescription_CheckoffReceiptTransLines; "Checkoff  Receipt Trans Lines"."Receipt Description")
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
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := CompanyInformation."Phone No.";
        CommunicationOnline := CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
