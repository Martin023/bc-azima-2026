#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185942 "Update Lien"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Cashier Transactions"; "Cashier Transactions")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if ("Cashier Transactions"."Employer Code" = '') and
                   ("Cashier Transactions".Type = "Cashier Transactions".Type::Lien) and
                   ("Cashier Transactions"."Transaction Description" <> '') and
                   ("Cashier Transactions".Payee = '')

                   then begin
                    Loans.Reset;
                    Loans.SetRange("Loan No.", "Cashier Transactions"."Transaction Description");
                    if Loans.FindFirst then
                        if Loans."Employer Code" <> '' then begin
                            "Cashier Transactions"."Employer Code" := Loans."Employer Code";
                            "Cashier Transactions".Modify;
                        end
                        else
                            if Loans."Employer Code" = '' then
                                CurrReport.Skip;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('DONE!!!');
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
}
