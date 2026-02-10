#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185426 "One Month Installment"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/One Month Installment.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        //dataitem(52185700;52185700)
        dataitem("One Month Installment"; "One Month Installment")
        {
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



            column(Record_No_; "Record No.")
            {

            }
            column(Member_No_; "Member No.")
            {

            }
            column(Interest_Amount; "Interest Amount")
            {

            }
            column(Principal_Amount; "Principal Amount")
            {

            }
            column(Total; Total)
            {

            }
            column(Funds_Status; "Funds Status")
            {

            }
            column(EntryDate; EntryDate)
            {

            }
            column(EnteredBy; EnteredBy)
            {

            }
            column(ReleasedBy; ReleasedBy)
            {

            }
            column(TimeReleased; TimeReleased)
            {

            }
            column(Status; Status)
            {

            }
            column(Type; Type)
            {

            }
            column(Account_No_; "Account No.")
            {

            }
            column(ReleasedTo; ReleasedTo)
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
        //columns
        CompanyName: Text;
        BuldingName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;
        PrintingDate: Text;
        PrintingTime: Text;
        PrintedBy: Code[50];

        EntryDate: Text;
        EnteredBy: Text;
        ReleasedBy: Text;
        TimeReleased: Text;
        ReleasedTo: Text;

        //Other Variables
        CompanyInformation: Record "Company Information";
        GlobalFunctions: Codeunit "Global Functions";
}
