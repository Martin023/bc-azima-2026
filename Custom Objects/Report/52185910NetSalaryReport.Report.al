#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185910 "Net Salary Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Net Salary Report.rdl';

    dataset
    {
        //dataitem(52185783;52185783)
        dataitem("Salary Header"; "Salary Header")
        {
            column(ReportForNavId_7; 7)
            {
            }
            column(Picture; CompanyInfo.Picture)
            {
            }
            //column(CurrReport_PAGENO; CurrReport.PageNo)
            //{
            //}
            column(us; UserId)
            {
            }
            column(date; Format(Today, 0, 4))
            {
            }
            column(CompName; COMPANYNAME)
            {
            }
            column(No; "Salary Header".No)
            {
            }
            column(DocNo; "Salary Header"."Document No")
            {
            }
            column(AmountHeader; "Salary Header".Amount)
            {
            }
            column(IncomeType; "Salary Header"."Income Type")
            {
            }
            column(EnteredBy; "Salary Header"."Entered By")
            {
            }
            column(EmployerCode; "Salary Header"."Employer Code")
            {
            }
            column(AccountName; "Salary Header"."Account Name")
            {
            }
            column(Remarks; "Salary Header".Remarks)
            {
            }
            column(Postingdate; "Salary Header"."Posting date")
            {
            }
            //dataitem(52185784;52185784)
            dataitem("Salary Lines"; "Salary Lines")
            {
                DataItemLink = "Salary Header No." = field(No);
                column(ReportForNavId_1; 1)
                {
                }
                column(Account; "Salary Lines"."Account No.")
                {
                }
                column(StaffNo; "Salary Lines"."Staff No.")
                {
                }
                column(Name; "Salary Lines".Name)
                {
                }
                column(ID; "Salary Lines"."ID No.")
                {
                }
                column(Amount; "Salary Lines".Amount)
                {
                }
                column(NetAmount; NetAmount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    NetAmount := 0;
                    SavingsLedgerEntry.Reset;
                    SavingsLedgerEntry.SetRange("Customer No.", "Salary Lines"."Account No.");
                    SavingsLedgerEntry.SetRange("Document No.", "Salary Lines"."Salary Header No.");
                    SavingsLedgerEntry.SetRange("Posting Date", "Salary Lines"."Posting Date");
                    SavingsLedgerEntry.SetRange(Reversed, false);
                    if SavingsLedgerEntry.FindFirst then begin
                        SavingsLedgerEntry.CalcSums("Amount (LCY)");
                        NetAmount := SavingsLedgerEntry."Amount (LCY)" * -1;
                    end;
                end;
            }

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(CompanyInfo.Picture);
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

    var
        CompanyInfo: Record "Company Information";
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        NetAmount: Decimal;
}
