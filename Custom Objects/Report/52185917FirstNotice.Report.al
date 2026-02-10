#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185917 "First Notice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/First Notice.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("SMS Alerts Lines"; "SMS Alerts Lines")
        {
            RequestFilterFields = "Loan No", "Notice Category", "Notice Type", "Header No";
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
            column(Loan_No; "Loan No")
            {

            }
            column(Days_In_Arreas; "Days In Arreas")
            {

            }
            column(Amount_In_Arreas; "Amount In Arreas")
            {

            }
            column(Notice; Notice)
            {

            }
            column(MemberNo; MemberNo)
            {

            }
            column(Name; Name)
            {

            }
            column(PayrollNo; PayrollNo)
            {

            }
            column(IDNo; IDNo)
            { }
            column(Box; Box)
            {

            }
            column(PhoneNumber; PhoneNumber)
            {

            }
            column(Phone_Number; "Phone Number")
            {

            }
            column(City; City)
            {

            }
            column(InstallmentsFalloff; InstallmentsFalloff)
            {

            }
            column(LoanTypeName; LoanTypeName)
            {

            }
            column(Repayment; Repayment)
            {

            }
            column(LastRepaymentDate; LastRepaymentDate)
            {

            }
            column(OutBal; OutBal)
            {

            }
            column(TotalBal; TotalBal)
            {

            }
            column(OutInt; OutInt)
            {

            }
            column(IssueDate; IssueDate)
            {

            }
            trigger OnAfterGetRecord()
            begin
                MemberNo := '';
                PayrollNo := '';
                IDNo := '';
                Name := '';

                if Members.Get("SMS Alerts Lines"."Member No") then begin
                    MemberNo := Members."No.";
                    PayrollNo := Members."Payroll/Staff No.";
                    IDNo := Members."Primary Identification";
                    Name := Members.Name;
                    Box := Members."Current Address";
                    if Box = '' then
                        Box := Members."Home Address";
                    City := Members.City;
                    PhoneNumber := Members."Phone No.";
                    if PhoneNumber = '' then PhoneNumber := Members."Transactional Mobile Number";
                end;

                if Loans.Get("SMS Alerts Lines"."Loan No") then begin
                    Loans.CalcFields("Installments FallOff");
                    InstallmentsFalloff := Loans."Installments FallOff";
                    LoanTypeName := Loans."Loan Product Type Name";
                    Repayment := Loans.Repayment;
                    IssueDate := GlobalFunctions.FormatDate(Loans."Disbursement Date");
                end;

                RecoveryHeader.GetLoanBalances("SMS Alerts Lines"."Loan No", OutInt, OutBal, TotalBal);

                CreditLedgerEntry.Reset();
                CreditLedgerEntry.SetRange("Loan No", "SMS Alerts Lines"."Loan No");
                CreditLedgerEntry.SetFilter("Credit Amount", '>0');
                CreditLedgerEntry.SetRange(Reversed, false);
                if CreditLedgerEntry.FindLast() then
                    LastRepaymentDate := GlobalFunctions.FormatDate(CreditLedgerEntry."Posting Date");
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
        //Columns
        CompanyName: Text;
        BuldingName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;
        PrintingDate: Text;
        PrintingTime: Text;
        PrintedBy: Code[50];
        Box: Text;
        City: Text;
        PhoneNumber: Text;

        //Your Ref (Defaulter Details)
        MemberNo: Code[50];
        Name: Text;
        PayrollNo: Code[50];
        IDNo: Code[50];


        //Defaulted Loan Details
        OutInt: Decimal;
        OutBal: Decimal;
        TotalBal: Decimal;
        InstallmentsFalloff: Integer;
        LoanTypeName: Text;
        Repayment: Decimal;
        LastRepaymentDate: Text;
        IssueDate: Text;

        //Other Variable
        Members: Record Members;
        CompanyInformation: Record "Company Information";
        GlobalFunctions: Codeunit "Global Functions";
        RecoveryHeader: Record "Loan Recovery Header";
        Loans: Record Loans;
        CreditLedgerEntry: Record "Credit Ledger Entry";

}
