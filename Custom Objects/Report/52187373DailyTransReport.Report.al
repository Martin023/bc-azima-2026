#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52187373 "Daily Transaction Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Daily Transaction Report.rdl';

    dataset
    {
        dataitem("Cashier Transactions"; "Cashier Transactions")
        {
            RequestFilterFields = "Date Filter", "Transaction Type", "Date Posted";
            column(ReportForNavId_1; 1)
            {
            }
            column(us; UserId)
            {
            }
            column(date; Format(Today, 0, 4))
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(No; "Cashier Transactions".No)
            {
            }
            column(Acount; "Cashier Transactions"."Account No")
            {
            }
            column(Type; "Cashier Transactions".Type)
            {
            }
            column(TransType; "Cashier Transactions"."Transaction Type")
            {
            }
            column(TransDate; "Cashier Transactions"."Transaction Date")
            {
            }
            column(Amount; "Cashier Transactions".Amount)
            {
            }
            column(Cashier; "Cashier Transactions".Cashier)
            {
            }
            column(CheDate; DatePosted)
            {
            }
            column(CheqNo; CheNo)
            {
            }
            column(ExpectedMaturity; "Cashier Transactions"."Expected Maturity Date")
            {
            }
            column(BankerCheqNo; "Cashier Transactions"."Bankers Cheque No")
            {
            }
            column(Dim2; "Cashier Transactions"."Global Dimension 2 Code")
            {
            }
            column(Posti; "Cashier Transactions".Posted)
            {
            }
            column(PayeeName; PayeeName)
            {
            }
            column(Sno; Sno)
            {
            }
            column(branch; "Cashier Transactions"."Global Dimension 1 Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Sno += 1;
            end;

            trigger OnPreDataItem()
            begin
                // CompanyInfo.Get;
                // CompanyInfo.CalcFields(CompanyInfo.Picture);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            //     area(content)
            //     {
            //         group("Date Filter")
            //         {
            //             field("Date:"; Date)
            //             {
            //                 ApplicationArea = Basic;
            //             }
            //         }
            //     }
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
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var

        CheNo: Code[10];
        DatePosted: Date;
        PayeeName: Text;
        Date: Date;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        Sno: Integer;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
