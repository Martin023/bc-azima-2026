#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185751 "Loan Bills"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Loan Bills.rdl';

    dataset
    {
        //dataitem(52185860;52185860)
        dataitem("Interest Header"; "Interest Header")
        {
            RequestFilterFields = "Interest Due Date", "Posting Date";
            column(ReportForNavId_10; 10)
            {
            }

            column(No_InterestHeader; "Interest Header"."No.")
            {
            }
            column(PostingDate_InterestHeader; "Interest Header"."Posting Date")
            {
            }
            column(DocumentNo_InterestHeader; "Interest Header"."Document No.")
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            //column(CurrReport_PAGENO; CurrReport.PageNo)
            //{
            //}
            column(USERID; UserId)
            {
            }

            dataitem("Loans Interest"; "Loans Interest")
            {
                DataItemLink = No = field("No.");
                column(ReportForNavId_1; 1)
                {
                }

                column(AccountNo_LoansInterest; "Loans Interest"."Account No")
                {
                }
                column(InterestDate_LoansInterest; "Loans Interest"."Interest Date")
                {
                }
                column(InterestAmount_LoansInterest; "Loans Interest"."Interest Amount")
                {
                }
                column(Posted_LoansInterest; "Loans Interest".Posted)
                {
                }
                column(LoanNo_LoansInterest; "Loans Interest"."Loan No.")
                {
                }
                column(LoanProducttype_LoansInterest; "Loans Interest"."Loan Product type")
                {
                }
                column(RepaymentBill_LoansInterest; "Loans Interest"."Repayment Bill")
                {
                }
                column(InterestBill_LoansInterest; "Loans Interest"."Interest Bill")
                {
                }
                column(TotalBills; "Loans Interest"."Repayment Bill" + "Loans Interest"."Interest Bill")
                {
                }





                trigger OnAfterGetRecord()
                begin
                    Sno += 1;
                end;

                trigger OnPreDataItem()
                begin
                    if Company.Get() then
                        Company.CalcFields(Company.Picture);
                    GenSetUp.Get();
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

    var
        Company: Record "Company Information";
        GenSetUp: Record "General Set-Up";
        Sno: Integer;
}
