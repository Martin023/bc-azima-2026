#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185449 "Incomplete Application Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Incomplete Application Report.rdl';

    dataset
    {
        //dataitem(52185700;52185700)
        dataitem("Member Application"; "Member Application")
        {
            DataItemTableView = where(Created = const(false));
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyName; CompanyName)
            {

            }
            column(BuldingName; BuldingName)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CompanyEmail; CompanyEmail)
            {
            }
            column(PrintingDate; PrintingDate)
            {

            }
            column(PrintingTime; PrintingTime)
            {

            }
            column(PrintedBy; PrintedBy)
            {

            }
            column(CRM_Application_No_; "CRM Application No.")
            {
            }
            column(No_; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(CRM_Notes; "CRM Notes")
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
                if "Member Application"."Sent Back At" <> 0DT then
                    SentAt := GlobalFunctions.DMUDateFormatDateTime("Member Application"."Sent Back At");

                if "Member Application"."Sent Back By" <> '' then
                    SentBy := GlobalFunctions.FormatUserName("Member Application"."Sent Back By");
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
        CompanyName := CompanyInformation.Name;
        BuldingName := CompanyInformation."Building Name";
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := CompanyInformation."Phone No." + ',' + CompanyInformation."Phone No. 2";
        CompanyEmail := CompanyInformation."E-Mail";
        PrintingDate := GlobalFunctions.DMUDateFormatDate(Today);
        PrintingTime := Format(Time);
        PrintedBy := GlobalFunctions.FormatUserName(UserId);
    end;

    var
        //Columss
        CompanyName: Text;
        BuldingName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;
        PrintingDate: Text;
        PrintingTime: Text;
        PrintedBy: Code[50];


        SentAt: Text;
        SentBy: Text;

        //Other Variables
        CompanyInformation: Record "Company Information";
        GlobalFunctions: Codeunit "Global Functions";
}