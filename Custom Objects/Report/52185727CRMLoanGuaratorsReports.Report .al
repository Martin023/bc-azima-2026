Report 52185890 "CRM Loan Guarators Reports"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/CRM Loan Guarators Reports.rdl';
    UsageCategory = ReportsAndAnalysis;
    Caption = 'CRM Loan Guarators Reports';
    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.";

            column(ReportForNavId_1102755001; 1102755001)
            {
            }
            column(LoanNo_Loans; Loans."Loan No.")
            {
            }
            column(Loan_Product_Type; "Loan Product Type")
            {

            }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
            {

            }
            column(ApplicationDate_Loans; Loans."Application Date")
            {
            }
            column(LoanProductType_Loans; Loans."Loan Product Type")
            {
            }
            column(RequestedAmount_Loans; Loans."Requested Amount")
            {
            }
            column(LoanProductTypeNam; Loans."Loan Product Type Name")
            {
            }
            column(ApprovedAmount_Loans; Loans."Approved Amount")
            {
            }
            column(OutStanding_Interest; Loans."Outstanding Interest")
            {
            }
            column(Loan_Account; "Loan Account")
            {

            }
            dataitem("Loan Guarantors and Security"; "Loan Guarantors and Security")
            {
                DataItemLink = "Loan No" = field("Loan No.");
                column(ReportForNavId_1102755002; 1102755002)
                {
                }
                column(MemberNo_LoanGuarantors; "Loan Guarantors and Security"."Member No")
                {
                }
                column(Name_LoanGuarantors; "Loan Guarantors and Security".Name)
                {
                }
                column(LoanBalance_LoanGuarantors; "Loan Guarantors and Security"."Loan Balance")
                {
                }
                column(Shares_LoanGuarantors; "Loan Guarantors and Security"."Deposits/Shares")
                {
                }
                column(NoOfLoansGuaranteed_LoanGuarantors; "Loan Guarantors and Security"."No Of Loans Guaranteed")
                {
                }
                column(Substituted_LoanGuarantors; "Loan Guarantors and Security".Substituted)
                {
                }
                column(Date_LoanGuarantors; "Loan Guarantors and Security".Date)
                {
                }
                column(SharesRecovery_LoanGuarantors; "Loan Guarantors and Security"."Shares Recovery")
                {
                }
                column(NewUpload_LoanGuarantors; "Loan Guarantors and Security"."New Upload")
                {
                }
                column(AmontGuaranteed_LoanGuarantors; "Loan Guarantors and Security"."Amount Guaranteed")
                {
                }
                column(StaffPayrollNo_LoanGuarantors; "Loan Guarantors and Security"."Staff/Payroll No.")
                {
                }
                column(AccountNo_LoanGuarantors; "Loan Guarantors and Security"."Account No.")
                {
                }
                column(SelfGuarantee_LoanGuarantors; "Loan Guarantors and Security"."Self Guarantee")
                {
                }
                column(IDNo_LoanGuarantors; "Loan Guarantors and Security"."ID No.")
                {
                }
                column(OutstandingBalance_LoanGuarantors; "Loan Guarantors and Security"."Outstanding Balance")
                {
                }
                column(MemberGuaranteed_LoanGuarantors; "Loan Guarantors and Security"."Member Guaranteed")
                {
                }
                column(PercentageGur; PercentageGur)
                {

                }
                column(Proportion_Guaranteed; "Proportion Guaranteed")
                {

                }

                trigger OnAfterGetRecord()
                var
                    MemB: Record Members;
                    Cust: Record Customer;
                    LoanGua: Record "Loan Guarantors and Security";
                    CountNo: Integer;
                    TotaAmtGUR: Decimal;
                begin
                    MemB.Reset();
                    MemB.SetRange("No.", "Loan Guarantors and Security"."Member No");
                    MemB.SetRange(Status, MemB.Status::Deceased);
                    if MemB.FindFirst() then
                        LoanGua.Reset;
                    LoanGua.SetRange("Loan No", "Loan No");
                    LoanGua.SetRange("Guarantor Type", LoanGua."guarantor type"::Guarantor);
                    if LoanGua.Find('-') then begin
                        CountNo := LoanGua.Count;
                        LoanGua.CalcSums("Amount Guaranteed");
                        TotaAmtGUR := LoanGua."Amount Guaranteed";
                    end;
                    if TotaAmtGUR <> 0 then begin
                        PercentageGur := Round(((("Loan Guarantors and Security"."Amount Guaranteed" / TotaAmtGUR) * 100)), 0.01, '=');
                    end;

                end;
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
        Company.GET();
        Company.CALCFIELDS(Company.Picture);
        CompanyNam := Company.Name;
        CompanyAddress := Company.Address + ' -Post Code: ' + Company."Post Code" + ' -City:' + Company.City + ' Region: ' + Company."Country/Region Code";
        CompanyTelephone := 'Tel: ' + Company."Phone No." + ' -Office Tel: ' + Company."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + Company."E-Mail" + '- Website: ' + Company."Home Page";
    end;

    var
        Company: Record "Company Information";
        TotalLoan: Decimal;
        PercentageGur: Decimal;
        CompanyNam: Text;
        CompanyTelephone: Text;
        CompanyAddress: Text;
        MmberDeceased: Boolean;
        CommunicationOnline: Text;
        TotaAmtGUR: Decimal;
        GurantorEmpcode: Code[30];
}

