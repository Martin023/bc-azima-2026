#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185877 "BOSA Account Activation Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/BOSA Account Activation.rdl';

    dataset
    {
        dataitem("BOSA Account Activation"; "BOSA Account Activation")
        {
            RequestFilterFields = Status, Action, Posted, "Date Posted", "User Id";
            column(User_Id; "User Id")
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
            column(Product_Name; "Product Name")
            {

            }
            column(Transaction_Time; "Transaction Time")
            {
            }
            column(Member_Name; "Member Name")
            {
            }
            column(Member_No; "Member No")
            {
            }
            column(Date; Date)
            {
            }
            column(Date_Posted; "Date Posted")
            {
            }
            column(Time_Posted; "Time Posted")
            {
            }
            column(Responsibility_Center; "Responsibility Center")
            {
            }
            column(Posted_By; "Posted By")
            {
            }
            column(Account_No; "Account No")
            {
            }
            column(Account_Name; "Account Name")
            {
            }
            column(Action; Action)
            {
            }
            column(Status; Status)
            {
            }
            column(Payroll_Staff_No_; "Payroll/Staff No.")
            {
            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
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
}
