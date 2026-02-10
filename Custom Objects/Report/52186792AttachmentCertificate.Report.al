#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
//If arrears are less than the deposits dont list
Report 52186793 "Attachment Certtificate"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Attachment Certificate.rdl';

    dataset
    {
        dataitem("Loan Recovery Lines"; "Loan Recovery Lines")
        {
            RequestFilterFields = "Member No.", "Header No.";
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
            {

            }
            column(DefaulterMemberNo; DefaulterMemberNo)
            {

            }
            column(DefaulterName; DefaulterName)
            {

            }
            column(DefaulterPayrollNo; DefaulterPayrollNo)
            {

            }
            column(DefaultedAmount; DefaultedAmount)
            {

            }
            column(DividendAmount; DividendAmount)
            {

            }
            column(DividendRepayment; DividendRepayment)
            {

            }
            column(DividendStartDate; DividendStartDate)
            {

            }

            trigger OnAfterGetRecord()
            begin
                if GuaranterMember.Get("Loan Recovery Lines"."Member No.") then begin
                    MemberNo := GuaranterMember."No.";
                    Name := GuaranterMember.Name;
                    PayrollNo := GuaranterMember."Payroll/Staff No.";
                    IDNo := GuaranterMember."Primary Identification";
                end;
                RecoveryHeader.Reset();
                RecoveryHeader.SetRange("No.", "Loan Recovery Lines"."Header No.");
                if RecoveryHeader.FindFirst() then begin
                    if DefaulterMember.Get(RecoveryHeader."Member No.") then begin
                        DefaulterMemberNo := DefaulterMember."No.";
                        DefaulterName := DefaulterMember.Name;
                        DefaulterPayrollNo := DefaulterMember."Payroll/Staff No.";
                        DefaultedAmount := RecoveryHeader."Total Balance";

                    end;
                end;
                DividendAmount := "Loan Recovery Lines"."Recovery Amount";
                if Loans.Get("Loan Recovery Lines"."Loan No.") then begin
                    DividendRepayment := Loans.Repayment;
                    DividendStartDate := GlobalFunctions.FormatDate(CalcDate('CM', loans."Disbursement Date"));
                end;
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

        //Your Ref (Guarantor Details)
        MemberNo: Code[50];
        Name: Text;
        PayrollNo: Code[50];
        IDNo: Code[50];

        //Defaulter
        DefaulterMemberNo: Code[50];
        DefaulterName: Text;
        DefaulterPayrollNo: Code[50];
        DefaultedAmount: Decimal;

        //Guarantor Loan
        DividendAmount: Decimal;
        DividendRepayment: Decimal;
        DividendStartDate: Text;

        //Other Variables
        CompanyInformation: Record "Company Information";
        DefaulterMember: Record Members;
        GuaranterMember: Record Members;
        RecoveryHeader: Record "Loan Recovery Header";
        GlobalFunctions: Codeunit "Global Functions";
        Loans: Record Loans;
        LoanNo: Code[30];
        OutInt: Decimal;
        OutBal: Decimal;
        TotalBal: Decimal;
        ProductFactory: Record "Product Factory";
        RecoveryLines: Record "Loan Recovery Lines";
        RepaymentSchedule: Record "Ideal Repayment Schedule";
}
