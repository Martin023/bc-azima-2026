report 52187380 "Promise To Pay Report"
{
    ApplicationArea = All;
    Caption = 'Finance Member Listing';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Promise To Pay.rdl';


    dataset
    {
        dataitem("Promise Topay Header"; "Promise Topay Header")
        {
            RequestFilterFields = "No.", "Member No.", "Created At", "Created By", "Closed At", "Closed By", "Responsible Officer", "Promise Status";

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
            column(No; "No.")
            {
            }
            column(Member_No_; "Member No.")
            {
            }
            column(Member_Name; "Member Name")
            {

            }
            column(Promise_Status; "Promise Status")
            {

            }
            column(Created_By; GlobalFunctions.FormatUserName("Created By"))
            {

            }
            column(Created_At; GlobalFunctions.FormatDate(DT2Date("Created At")))
            {

            }
            column(Closed_At; GlobalFunctions.FormatDate(DT2Date("Closed At")))
            {

            }
            column(Closed_By; GlobalFunctions.FormatUserName("Closed By"))
            {

            }
            column(Responsible_Officer; "Responsible Officer")
            {

            }
            column(Supervisor_ID; "Supervisor ID")
            {

            }
            dataitem("Promise Topay Lines"; "Promise Topay Lines")
            {


                DataItemLink = "Header No." = Field("No.");

                column(Loan_No_; "Loan No.")
                {

                }
                column(Amount_to_Pay; "Amount to Pay")
                {

                }
                column(Topay_Date; GlobalFunctions.FormatDate("Topay Date"))
                {

                }
                column(Outstanding_Balance; "Outstanding Balance")
                {

                }
                column(Entered_By; GlobalFunctions.FormatUserName("Entered By"))
                {

                }
                column(Entered_At; GlobalFunctions.FormatDate(DT2Date("Entered At")))
                {

                }
                column(Comment; Comment)
                {

                }
                column(Amount_Paid; "Amount Paid")
                {

                }
                column(Promise_Closed; "Close Promise")
                {

                }

            }

            dataitem("PromiseTopay SMS Log"; "PromiseTopay SMS Log")
            {
                DataItemLink = "Header No." = Field("No.");

                column(SMS; SMS)
                {

                }
                column(SMS_Created_By; GlobalFunctions.FormatUserName("Created By"))
                {

                }
                column(Date_Created; GlobalFunctions.FormatDate(DT2Date("Date Created")))
                {

                }

            }

            trigger OnAfterGetRecord()
            begin

            end;

            trigger OnPreDataItem()
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
        //Other Variables
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        GlobalFunctions: Codeunit "Global Functions";


}

