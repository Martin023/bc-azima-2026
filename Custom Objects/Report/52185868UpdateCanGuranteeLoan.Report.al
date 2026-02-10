#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185868 "Update Can Gurantee Loan"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Update Can Gurantee Loan.rdl';

    dataset
    {
        dataitem("Savings Accounts"; "Savings Accounts")
        {
            //DataItemTableView = where("Product Type" = const(02));
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Members.Reset;
                Members.SetRange("No.", "Savings Accounts"."Member No.");
                Members.SetFilter(Status, '%1|%2', Members.Status::Active, Members.Status::New);
                if Members.Find('-') then begin
                    "Savings Accounts"."Can Guarantee Loan" := true;
                    "Savings Accounts".Modify;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Done');
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
        Members: Record "Members";
}
