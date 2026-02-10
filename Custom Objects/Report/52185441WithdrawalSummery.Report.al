#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185441 "Withdrawal Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Withdrawal Summary.rdl';

    dataset
    {
        dataitem("Membership Closure"; "Membership Closure")
        {
            RequestFilterFields = "Date Approved", "Date Posted", "Closing Date", "Closure Type", Posted, Status;
            DataItemTableView = where(Posted = const(true));
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
            column(ClosureType; ClosureType)
            {

            }
            column(Shares; Shares)
            {

            }
            column(Liabilities; Liabilities)
            {

            }
            column(Charges; Charges)
            {

            }
            column(NetDisbursed; NetDisbursed)
            {

            }
            column(StartDate; StartDate)
            {

            }
            column(EndDate; EndDate)
            {

            }
            trigger OnAfterGetRecord()
            begin
                Shares := 0;
                Liabilities := 0;
                Charges := 0;
                NetDisbursed := 0;

                Shares := "Membership Closure"."Member Savings";
                Liabilities := "Membership Closure"."Total Interest" + "Membership Closure"."Total Loan" + "Membership Closure"."TSC Clearance";
                Charges := "Membership Closure"."Closure Charges";
                NetDisbursed := Shares - (Liabilities + Charges);

                if "Membership Closure"."Closure Type" = "Membership Closure"."Closure Type"::"Withdrawal - Normal" then
                    ClosureType := 'NORMAL WITHDRAWAL';
                if ("Membership Closure"."Closure Type" = "Membership Closure"."Closure Type"::"Withdrawal - 1st Partial") or
                ("Membership Closure"."Closure Type" = "Membership Closure"."Closure Type"::"Withdrawal - 2nd Partial") then
                    ClosureType := 'PARTIAL WITHDRAWAL';
            end;

            trigger OnPreDataItem()
            begin
                if StartDate = 0D then
                    "Membership Closure".SetFilter("Closing Date", '<=%1', EndDate)
                else
                    "Membership Closure".SetFilter("Closing Date", '%1..%2', StartDate, EndDate);
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
                group(Period)
                {
                    field(StartDate; StartDate)
                    {
                        Caption = 'Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'End Date';
                    }
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
        CompanyName := CompanyInformation.Name;
        BuldingName := CompanyInformation."Building Name";
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := CompanyInformation."Phone No." + ',' + CompanyInformation."Phone No. 2";
        CompanyEmail := CompanyInformation."E-Mail";
        PrintingDate := GlobalFunctions.DMUDateFormatDate(Today);
        PrintingTime := Format(Time);
        PrintedBy := GlobalFunctions.FormatUserName(UserId);

        if EndDate = 0D then
            EndDate := Today;
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

        Shares: Decimal;
        Liabilities: Decimal;
        Charges: Decimal;
        NetDisbursed: Decimal;

        ClosureType: Text;

        //Other Variables
        CompanyInformation: Record "Company Information";
        GlobalFunctions: Codeunit "Global Functions";
        StartDate: Date;
        EndDate: Date;

}
