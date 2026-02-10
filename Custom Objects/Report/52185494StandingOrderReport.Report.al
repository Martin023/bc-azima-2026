#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185494 "Standing Order Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Standing Order Report.rdl';

    dataset
    {
        dataitem("Standing Order Register"; "Standing Order Register")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "Date Processed", "Deduction Status", "Destination Account Type";
            column(ReportForNavId_1; 1)
            {
            }
            column(STO_No; "Standing Order Register"."No.")
            {
            }
            column(DateProcessed; "Standing Order Register"."Date Processed")
            {
            }
            column(DocumentNo; "Standing Order Register"."Document No.")
            {
            }
            column(SourceAccountNo; "Standing Order Register"."Source Account No.")
            {
            }
            column(SourceAccountName; "Standing Order Register"."Source Account Name")
            {
            }
            column(MemberNo; "Standing Order Register"."Member No")
            {
            }
            column(DeductionStatus; "Standing Order Register"."Deduction Status")
            {
            }
            column(Amount; "Standing Order Register".Amount)
            {
            }
            column(AmountDeducted; "Standing Order Register"."Amount Deducted")
            {
            }
            column(EffectiveStartDate; "Standing Order Register"."Effective/Start Date")
            {
            }
            column(Duration; "Standing Order Register".Duration)
            {
            }
            column(EndDate; "Standing Order Register"."End Date")
            {
            }
            dataitem("Standing Order Lines"; "Standing Order Lines")
            {
                column(ReportForNavId_14; 14)
                {
                }
                column(DestinationAccountType; "Standing Order Lines"."Destination Account Type")
                {
                }
                column(DestinationAccountNo; "Standing Order Lines"."Destination Account No.")
                {
                }
                column(DestinationAccountName; "Standing Order Lines"."Destination Account Name")
                {
                }
                column(LoanNo; "Standing Order Lines"."Loan No.")
                {
                }
                column(Amountstolines; "Standing Order Lines".Amount)
                {
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

    var
        StandingOrderHeader: Record "Standing Order Header";
        memberName: Code[50];
}
