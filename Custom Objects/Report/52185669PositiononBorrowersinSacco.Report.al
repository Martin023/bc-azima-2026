#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185669 "Position on Borrowers in Sacco"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Position on Borrowers in Sacco.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Member No.", "Loan No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(CName; CompanyInformation.Name)
            {
            }
            column(CAddress; CompanyInformation.Address)
            {
            }
            column(CPicture; CompanyInformation.Picture)
            {
            }
            column(LoanNo; Loans."Loan No.")
            {
            }
            column(LoanProduct; Loans."Loan Product Type Name")
            {
            }
            column(RequestedAmount; Loans."Requested Amount")
            {
            }
            column(ApprovedAmount; Loans."Approved Amount")
            {
            }
            column(DisbursmentDate; Loans."Disbursement Date")
            {
            }
            column(RepaymentStartDate; CalcDate('1M+CM', Loans."Disbursement Date"))
            {
            }
            column(RepaymentPeriod; Loans.Installments)
            {
            }
            column(RepaymentAmount; Loans.Repayment)
            {
            }
            column(Deposits; Deposits)
            {
            }
            column(SecurityType; SecurityType)
            {
            }
            column(Staff; Loans."Staff No")
            {
            }
            column(MemberName; Loans."Member Name")
            {
            }
            column(MemberNo; Loans."Member No.")
            {
            }
            column(LoanNor; LoanNo)
            {
            }
            column(FOSAacc; FOSAacc)
            {
            }
            dataitem(loan; Loans)
            {
                DataItemLink = "Member No." = field("Member No.");
                DataItemTableView = where("Outstanding Balance" = filter(> 0));
                column(ReportForNavId_8; 8)
                {
                }
                column(LoanNoL; loan."Loan No.")
                {
                }
                column(LoanProductL; loan."Loan Product Type Name")
                {
                }
                column(ApprovedAmountL; loan."Approved Amount")
                {
                }
                column(DisbursmentDateL; loan."Disbursement Date")
                {
                }
                column(RepaymentDateL; CalcDate('1M+CM', loan."Disbursement Date"))
                {
                }
                column(InstallmentL; loan.Installments)
                {
                }
                column(OutstandingBalanceL; loan."Outstanding Balance")
                {
                }
                column(OutstandingInterestL; loan."Outstanding Interest")
                {
                }
                column(TotalLoanBalanceL; loan."Total Loan Balance")
                {
                }
                column(RepaymentL; loan.Repayment)
                {
                }
                column(DepositsCont; DepositsCont)
                {
                }
                column(SecurityTypel; SecurityType)
                {
                }
                column(LoansCategory; loan."Loans Category-SASRA")
                {
                }

                // trigger OnAfterGetRecord()
                // begin
                //     if loan."Loan No." = Loans."Loan No." then
                //         CurrReport.Skip;
                //     DepositsCont := 0;
                //     SecurityType := Securitytype::" ";
                //     LoanGuarantorsandSecurity.Reset;
                //     LoanGuarantorsandSecurity.SetRange("Member No", loan."Member No.");
                //     if LoanGuarantorsandSecurity.Find('-') then begin
                //         case LoanGuarantorsandSecurity."Guarantor Type" of
                //             LoanGuarantorsandSecurity."guarantor type"::Guarantor:
                //                 begin
                //                     SecurityType := Securitytype::Guarantor
                //                 end;
                //             LoanGuarantorsandSecurity."guarantor type"::Collateral:
                //                 begin
                //                     SecurityType := Securitytype::Collateral;
                //                 end;
                //             LoanGuarantorsandSecurity."guarantor type"::Collateral, LoanGuarantorsandSecurity."guarantor type"::Guarantor:
                //                 begin
                //                     SecurityType := Securitytype::Both;
                //                 end;
                //         end;
                //     end;
                //     SavingsAccounts.Reset;
                //     SavingsAccounts.SetRange("Member No.", loan."Member No.");
                //     SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                //     if SavingsAccounts.Find('-') then begin
                //         SavingsAccounts.CalcFields("Balance (LCY)");
                //         DepositsCont := SavingsAccounts."Balance (LCY)";
                //     end;
                // end;
            }

            trigger OnAfterGetRecord()
            begin
                LoanNo := 1;
                SecurityType := Securitytype::" ";
                LoanGuarantorsandSecurity.Reset;
                LoanGuarantorsandSecurity.SetRange("Member No", Loans."Member No.");
                if LoanGuarantorsandSecurity.Find('-') then begin
                    case LoanGuarantorsandSecurity."Guarantor Type" of
                        LoanGuarantorsandSecurity."Guarantor Type"::Guarantor:
                            begin
                                SecurityType := Securitytype::Guarantor
                            end;
                        LoanGuarantorsandSecurity."Guarantor Type"::Collateral:
                            begin
                                SecurityType := Securitytype::Collateral;
                            end;
                    // (LoanGuarantorsandSecurity."Guarantor Type"::Collateral) AND (LoanGuarantorsandSecurity."Guarantor Type"::Guarantor:)
                    //     begin
                    //         SecurityType := Securitytype::Both;
                    //     end;
                    end;
                end;
                //Deposits:=0;
                SavingsAccounts.Reset;
                SavingsAccounts.SetRange("Member No.", Loans."Member No.");
                SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                if SavingsAccounts.Find('-') then begin
                    SavingsAccounts.CalcFields("Balance (LCY)");
                    Deposits := SavingsAccounts."Balance (LCY)";
                end;

                SavingsAccounts.Reset;
                SavingsAccounts.SetRange("Member No.", Loans."Member No.");
                SavingsAccounts.SetRange("Loan Disbursement Account", true);
                if SavingsAccounts.Find('-') then
                    FOSAacc := SavingsAccounts."No."
                else
                    FOSAacc := '';
            end;

            // trigger OnPreDataItem()
            // begin
            //     Loans.SetFilter("Member No.", Loans.GetFilter("Member No."));
            //     Loans.SetFilter("Loan No.", Loans.GetFilter("Loan No."));
            //     if Loans.FindLast then
            // end;
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
        CompanyInformation.Get;
        CompanyInformation.CalcFields(Picture);
    end;

    var
        SavingsAccounts: Record "Savings Accounts";
        Deposits: Decimal;
        DepositsCont: Decimal;
        LoanGuarantorsandSecurity: Record "Loan Guarantors and Security";
        SecurityType: Option " ",Collateral,Guarantor,Both;
        CompanyInformation: Record "Company Information";
        LoanNo: Integer;
        FOSAacc: Code[20];
}

