#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186148 "FOSA Account Activation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/FOSA Account Activation.rdl';

    dataset
    {
        dataitem("Account Activation"; "Account Activation")
        {
            DataItemTableView = where(Activated = filter(true));
            RequestFilterFields = "Member No";
            column(No; No)
            {

            }
            column(Date_Activated; "Date Activated")
            {

            }
            column(Transaction_Type; "Transaction Type")
            {

            }
            column(Member_No; "Member No")
            {

            }
            column(Member_Name; "Member Name")
            {

            }
            column(Account_No; "Account No")
            {

            }
            column(Account_Name; "Account Name")
            {

            }
            column(Account_Balance; "Account Balance")
            {

            }
            column(User_Id; "User Id")
            {

            }
            column(Global_Dimension_2_Code; "Global Dimension 2 Code")
            {

            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {

            }
            column(Status; Status)
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


            trigger OnAfterGetRecord()
            begin

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
        CompanyNam: Text;
        CommunicationOnline: Text;
        Company: Record "Company Information";

}
