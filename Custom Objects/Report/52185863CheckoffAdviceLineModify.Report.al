#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185863 "Checkoff Advice Line Modify"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Checkoff Advice Line Modify.rdl';

    dataset
    {
        dataitem("Checkoff Advice Line"; "Checkoff Advice Line")
        {
            //DataItemTableView = where("Advice Type" = filter(Adjustment), Type = filter(Credit), "Balance On" = filter(0), "Loan No." = filter(<> ""), "Advice Date" = filter(>= "07/01/21"), "Captured  By" = filter("HARAMBEESACCO\SKYWORLDLTD"));
            RequestFilterFields = "Loan No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Loans.Reset;
                Loans.SetRange("Loan No.", "Checkoff Advice Line"."Loan No.");
                if Loans.Find('-') then begin
                    Installments := Loans.Installments;
                end;
                "Checkoff Advice Line"."Amount Off" := 0;
                "Checkoff Advice Line"."Advice Type" := "Checkoff Advice Line"."advice type"::"New Loan";
                "Checkoff Advice Line"."Balance On" := "Checkoff Advice Line"."Amount On" * Installments;
                "Checkoff Advice Line".Modify;
            end;

            trigger OnPostDataItem()
            begin
                Message('Checkoff Advice Line  Modified Successfully');
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
        Loans: Record Loans;
        Installments: Integer;
}
