#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185916 "ATM Transactions Report."
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/ATM Transactions Report..rdl';

    dataset
    {
        dataitem("ATM Transactions"; "ATM Transactions")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(TraID; "ATM Transactions"."Trace ID")
            {
            }
            column(Post; "ATM Transactions"."Posting Date")
            {
            }
            column(Accno; "ATM Transactions"."Account No")
            {
            }
            // column(Desc; "ATM Transactions".Description)
            // {
            //     OptionCaption = ',Cash W/d - Visa Atm,Cash W/d - Coop Bank';
            //     OptionMembers = "Cash W/d - Visa Atm","Cash W/d - Coop Bank";
            // }
            column(Amnt; "ATM Transactions".Amount)
            {
            }
            column(Trnsty; "ATM Transactions"."Transaction Type")
            {
            }
            column(Trntime; "ATM Transactions"."Transaction Date")
            {
            }
            column(Ref; "ATM Transactions"."Reference No")
            {
            }
            column(Transaa; "ATM Transactions"."Transaction Description")
            {
            }
            column(Crd; "ATM Transactions"."ATM Card No")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //"Delegate Region Applicationss".Created:=FALSE;
                //"Delegate Region Applicationss".MODIFY;
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
}
