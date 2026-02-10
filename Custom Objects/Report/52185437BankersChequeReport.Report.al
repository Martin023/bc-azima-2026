#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185437 "Bankers Cheque Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Bankers Cheque Report.rdl';

    dataset
    {
        dataitem("Bankers Cheque Application"; "Bankers Cheque Application")
        {
            // DataItemTableView = where(Status = const(Active), "Product Class Type" = filter(Savings));

            column(ReportForNavId_1; 1)
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
            column(SCount; SNo)
            {
            }
            column(No_; "No.")
            {
            }
            column(Application_Date; "Application Date")
            {
            }
            column(Begining_Cheque_No_; "Begining Cheque No.")
            {
            }
            column(No_of_Leaves; "No of Leaves")
            {
            }
            column(Cheque_Register_Generated; "Cheque Register Generated")
            {
            }
            column(Leaf_Limit_Amount; "Leaf Limit Amount")
            {
            }
            column(Status; Status)
            {
            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {
            }
            column(Bank_Account; "Bank Account")
            {
            }
            column(ShowTotoDetail; ShowTotoDetail)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //SavingsAccounts.SETCURRENTKEY(SavingsAccounts."Member No.");
                SNo += 1;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(ShowTotoDetail; ShowTotoDetail)
                {
                    ApplicationArea = Basic;
                    Caption = 'ShowTotoDetail';
                }
            }
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
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        SNo: Integer;
        ShowTotoDetail: Boolean;
}
