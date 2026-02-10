report 52186110 "Risk Claims Report"
{
    ApplicationArea = All;
    Caption = 'Risk Claims Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Risk Claim Report.rdl';
    dataset
    {
        dataitem(SinkFundReportInformation; "SinkFund Report Information")
        {
            DataItemTableView = where("Claim Type" = const("Risk Claim"));
            RequestFilterFields = Status, Posted, "Posted By", "Date Posted", "Account Closure Date";
            column(CompanyInfo__Address_2_; Company."Address 2")
            {
            }
            column(CompanyInfo_Address; Company.Address)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(MemberNo; "Member No")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(DateofDeath; "Date of Death")
            {
            }
            column(Date; "Date")
            {
            }
            column(DatePosted; "Date Posted")
            {
            }
            column(TotalLoans; "Total Loans")
            {
            }
            column(TotalSavings; "Total Savings")
            {
            }
            column(BBF_Claim_Amount; "BBF Claim Amount")
            {

            }
            column(BOSALoans_SinkFundReportInformation; "BOSA Loans")
            {
            }
            column(FOSALoans_SinkFundReportInformation; "FOSA Loans")
            {
            }
            column(AvailableBeneficiaryAmount_SinkFundReportInformation; "Available Beneficiary Amount")
            {
            }
            column(ExternalAmountAllocated_SinkFundReportInformation; "External Amount Allocated")
            {
            }
            column(TotalAmountAllocated_SinkFundReportInformation; "Total Amount Allocated")
            {
            }
            column(BurialPermitNumber_SinkFundReportInformation; "Burial Permit Number")
            {
            }
            column(BusinessLoans_SinkFundReportInformation; "Business Loans")
            {
            }
            column(HRLoans_SinkFundReportInformation; "HR Loans")
            {
            }
            column(ReceiptAmount_SinkFundReportInformation; "Receipt Amount")
            {
            }
            column(ReceiptDocumentNumber_SinkFundReportInformation; "Receipt Document Number")
            {
            }
            column(NextofKinPaidAmount_SinkFundReportInformation; "Next of Kin Paid Amount")
            {
            }
            column(Filters; Filters)
            {
            }
            column(PayrollNo; PayrollNo)
            {
            }

            trigger OnPreDataItem()
            begin
                if Company.Get() then
                    Company.CalcFields(Company.Picture);
                Filters := SinkFundReportInformation.GetFilters;
            end;

            trigger OnAfterGetRecord()
            begin
                if Member.Get("Member No") then
                    PayrollNo := Member."Payroll/Staff No.";
            end;
        }
    }

    var
        Company: Record "Company Information";
        Filters: Text;
        Member: Record Members;
        PayrollNo: Code[50];
}
