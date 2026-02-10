#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185451 "Closure Listing"
{

    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Closure Listing.rdl';

    dataset
    {
        dataitem("Membership Closure"; "Membership Closure")
        {
            RequestFilterFields = "Date Approved", "Date Posted", "Closing Date", "Closure Type";
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

            column(No; No)
            {

            }
            column(MemberID; MemberID)
            {

            }
            column(PayrollNumber; PayrollNumber)
            {

            }
            column(Member_Name; "Member Name")
            {

            }
            column(AgeInYears; AgeInYears)
            {

            }
            column(WithdrawalDate; WithdrawalDate)
            {

            }
            column(Closure_Type; "Closure Type")
            {

            }
            column(Reason_for_withdrawal; "Reason for withdrawal")
            {

            }
            column(Member_Savings; "Member Savings")
            {

            }
            column(CreditedToFOSA; CreditedToFOSA)
            {

            }
            column(TotalLoans; TotalLoans)
            {

            }
            column(TSCLibilities; TSCLibilities)
            {

            }
            column(WithDrawal_Charge; "Closure Charges")
            {

            }
            column(NetAmount; NetAmount)
            {

            }
            column(Member_No_; "Member No.") { }

            trigger OnAfterGetRecord()
            begin
                No += 1;
                if Members.Get("Membership Closure"."Member No.") then begin
                    MemberID := Members."Primary Identification";
                    PayrollNumber := Members."Payroll/Staff No.";
                    if Members."Date of Birth" <> 0D then
                        AgeInYears := Round((Today - Members."Date of Birth") / (30 * 12), 1, '<');

                    if "Closing Date" <> 0D then
                        WithdrawalDate := GlobalFunctions.FormatDate("Closing Date");

                    CreditedToFOSA := 0;
                    TotalLoans := "Total Loan" + "Total Interest";
                    TSCLibilities := "TSC Clearance";
                    if "Partial Deposit Refundable" <> 0 then
                        NetAmount := "Partial Deposit Refundable"
                    else
                        NetAmount := "Deposit Refundable";

                end;
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

        No: Integer;
        MemberID: Text;
        PayrollNumber: Text;
        AgeInYears: Integer;
        WithdrawalDate: Text;
        CreditedToFOSA: Decimal;
        TotalLoans: Decimal;
        TSCLibilities: Decimal;
        NetAmount: Decimal;

        //Other Variables
        CompanyInformation: Record "Company Information";
        GlobalFunctions: Codeunit "Global Functions";
        Members: Record Members;

}
