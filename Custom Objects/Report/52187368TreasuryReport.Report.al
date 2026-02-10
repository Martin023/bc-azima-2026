#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52187368 "Treasury Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Treasury Report.rdl';

    dataset
    {
        dataitem("Treasury Cashier Transactions"; "Treasury Cashier Transactions")
        {
            RequestFilterFields = No, "Transaction Type", "Transaction Date", Amount, Type;
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
            column(No; No)
            {
            }
            column(Transaction_Type; "Transaction Type")
            {
            }
            column(From_Account; "From Account")
            {
            }
            column(To_Account; "To Account")
            {
            }
            column(Amount; Amount)
            {
            }
            column(External_Document_No_; "External Document No.")
            {
            }
            column(CheDate; DatePosted)
            {
            }
            column(Issued_By; "Issued By")
            {
            }
            column(Issue_Received; "Issue Received")
            {
            }
            column(Date_Issued; "Date Issued")
            {
            }
            column(Received_By; "Received By")
            {
            }
            column(Posted; Posted)
            {
            }
            column(Date_Posted; "Date Posted")
            {
            }
            column(Type; Type)
            {
            }
            column(PayeeName; PayeeName)
            {
            }


            trigger OnAfterGetRecord()
            begin
                CheNo := '';
                DatePosted := 0D;
                PayeeName := '';
                if "Treasury Cashier Transactions"."External Document No." = '' then begin
                    CheNo := "Treasury Cashier Transactions"."External Document No.";
                    DatePosted := "Treasury Cashier Transactions"."Date Posted";
                end else begin
                    CheNo := "Treasury Cashier Transactions"."External Document No.";
                    DatePosted := "Treasury Cashier Transactions"."Date Posted";
                end;

                PayeeName := "Treasury Cashier Transactions"."From Account";
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

        CheNo: Code[20];
        DatePosted: Date;
        PayeeName: Text;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
