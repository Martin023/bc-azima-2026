#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185904 "Loan Issued Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Loan Issued Summary.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = order(ascending) where(Posted = const(true), "Loan Product Type" = filter(<> 129 & <> 141 & <> 133));
            RequestFilterFields = "Disbursement Date";
            column(ReportForNavId_1; 1)
            {
            }
            column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
            {
            }
            column(LoanNo_Loans; Loans."Loan No.")
            {
            }
            column(ApplicationDate_Loans; Loans."Application Date")
            {
            }
            column(LoanProductType_Loans; Loans."Loan Product Type")
            {
            }
            column(MemberNo_Loans; Loans."Member No.")
            {
            }
            column(RequestedAmount_Loans; Loans."Requested Amount")
            {
            }
            column(ApprovedAmount_Loans; Loans."Approved Amount")
            {
            }
            column(KampInfoName; KampInfo.Name)
            {
            }
            column(KampInfoAddress; KampInfo.Address)
            {
            }
            column(KampInfoPicture; KampInfo.Picture)
            {
            }
            column(DisbursementDate_Loans; PeriodText)
            {
            }
            column(OutstandingBalance; Loans."Outstanding Balance")
            {
            }
            column(OutstandingInterest; Loans."Outstanding Interest")
            {
            }
            column(BridgedAmt; BridgedAmt)
            {
            }
            column(TotalTopUp; Loans."Total TopUp")
            {
            }
            column(DepositBoosted; Loans."Loans - Deposit Purchase")
            {
            }
            column(ShareBoosted; Loans."Share Boosted Amount")
            {
            }
            column(NetTakeHome; Loans."Net Amount")
            {
            }
            column(OldRepayment; OldRepayment)
            {
            }
            column(NewRepayment; NewRepayment)
            {
            }

            trigger OnAfterGetRecord()
            begin
                NewRepayment := 0;
                OldRepayment := 0;
                Loans.CalcFields("Total TopUp");
                if Loans."Total TopUp" > 0 then begin
                    BridgedL.Reset;
                    BridgedL.SetRange("Loan No.", Loans."Loan No.");
                    BridgedL.SetRange("Loan Type", Loans."Loan Product Type");
                    BridgedL.SetRange("Client Code", Loans."Member No.");
                    if BridgedL.FindSet() then begin
                        BridgedL.CalcSums("Total Top Up", "Principle Top Up");
                        BridgedAmt := ROUND(BridgedL."Total Top Up", 1, '=');
                        repeat
                            if OldLoan.Get(BridgedL."Loan Top Up") then
                                OldRepayment += OldLoan.Repayment;
                        until BridgedL.Next = 0;
                    end;
                end;
                NewRepayment := Loans.Repayment;
            end;

            trigger OnPreDataItem()
            begin
                KampInfo.Get();
                KampInfo.CalcFields(Picture);
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
        GLFilter := Loans.GetFilters;
        PeriodText := Loans.GetFilter("Disbursement Date");
    end;

    var
        KampInfo: Record "Company Information";
        DisbursemntDate: Date;
        LoanR: Record Loans;
        GLFilter: Text;
        PeriodText: Text[30];
        BridgedAmt: Decimal;
        BridgedL: Record "Loans Top up";
        OldRepayment: Decimal;
        NewRepayment: Decimal;
        OldLoan: Record Loans;
}
