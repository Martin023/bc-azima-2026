Report 52185727 "Loan Guarators Reports"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Loan Guarators Reports.rdl';
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Loan Guarantors Report';
    dataset
    {
        dataitem("Credit Accounts"; "Credit Accounts")
        {
            RequestFilterFields = "No.", "Member No.";
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(No_Members; "Credit Accounts"."No.")
            {
            }
            column(Name_SACCOAccount; "Credit Accounts".Name)
            {
            }
            column(MemberNo_SACCOAccount; "Credit Accounts"."Member No.")
            {
            }
            column(CompName; CompanyNam)
            {

            }
            column(CommunicationOnline; CommunicationOnline)
            {

            }
            column(CompAddress; CompanyAddress)
            {
            }
            column(CompPic; Company.Picture)
            {
            }
            dataitem(Loans; Loans)
            {
                DataItemLink = "Member No." = field("Member No.");
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
                    DataItemTableView = where("Outstanding Balance" = filter(> 0), Substituted = const(false));

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
                    column(TLoan; TotalLoan)
                    {
                    }
                    column(MmberDeceased; MmberDeceased)
                    {


                    }
                    column(GurantorEmpcode; GurantorEmpcode)
                    {

                    }
                    column(PercentageGur; PercentageGur)
                    {

                    }
                    column(Proportion_Guaranteed; "Amount Guaranteed")
                    {

                    }

                    trigger OnAfterGetRecord()
                    var
                        MemB: Record Members;
                        Cust: Record Customer;
                        LoanGua: Record "Loan Guarantors and Security";
                        CountNo: Integer;
                    begin
                        TotalLoan := 0;
                        MmberDeceased := false;
                        TotalLoan := "Loan Guarantors and Security"."Outstanding Balance" + Loans."Outstanding Interest";
                        MemB.Reset();
                        MemB.SetRange("No.", "Loan Guarantors and Security"."Member No");
                        MemB.SetRange(Status, MemB.Status::Deceased);
                        if MemB.FindFirst() then
                            MmberDeceased := true
                        else
                            MmberDeceased := false;
                        if MemB.Get("Loan Guarantors and Security"."Member No") then begin
                            if Cust.get(MemB."Employer Code") then begin
                                GurantorEmpcode := Cust."No.";

                            end;
                        end;
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

