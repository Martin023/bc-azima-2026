#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
//If arrears are less than the deposits dont list
Report 52186792 "Notices Report"
{
    DefaultLayout = RDLC;
    ApplicationArea = Basic, suite;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-kenpipe-2024/Layout/Notices.rdl';

    dataset
    {
        dataitem("SMS Alerts Header"; "SMS Alerts Header")
        {
            DataItemTableView = where(Posted = const(true));
            RequestFilterFields = "No.", "Notice Type", "Employer Code", Period;
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
            column(PostingDate; PostingDate)
            {

            }


            dataitem("SMS Alerts Lines"; "SMS Alerts Lines")
            {
                DataItemLink = "Header No" = field("No.");
                DataItemTableView = where(Notice = filter(<> ''));
                RequestFilterFields = "Member No", "Notice Category";
                column(Loan_No; "Loan No")
                {

                }
                column(Notice; Notice)
                {

                }
                column(Phone_Number; "Phone Number")
                {

                }
                column(Member_No; "Member No")
                {

                }
                column(Days_In_Arreas; "Days In Arreas")
                {

                }
                column(Amount_In_Arreas; "Amount In Arreas")
                {

                }
                column(Notice_Category; "Notice Category")
                {

                }
                column(MemberName; MemberName)
                {

                }
                column(SentAt; SentAt)
                {

                }
                column(SentBy; SentBy)
                {

                }

                trigger OnAfterGetRecord()
                begin
                    if Members.Get("Member No") then begin
                        MemberName := Members.Name;
                    end;

                    SentBy := GlobalFunctions.FormatUserName("SMS Alerts Lines"."Sent By");
                    SentAt := GlobalFunctions.FormatISODateTime("SMS Alerts Lines"."Time Sent");
                end;

            }
            trigger OnAfterGetRecord()
            begin
                PostingDate := GlobalFunctions.DMUDateFormatDateTime("Posted At");
            end;

            trigger OnPostDataItem()
            begin
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
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


        //Other Variables
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Members: Record Members;
        GlobalFunctions: Codeunit "Global Functions";

        //Columns
        MemberName: Text;
        PostingDate: Text;
        SentBy: Text;
        SentAt: Text;


}
