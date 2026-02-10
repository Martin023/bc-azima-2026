#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185432 "Release Guarantor"
{
    DefaultLayout = RDLC;
    //RDLCLayout = './bc-kenpipe-2024/Layout/Release Guarantor.rdl';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Loan Guarantors and Security"; "Loan Guarantors and Security")
        {
            RequestFilterFields = "Loan No", "Savings Account No./Member No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "Loan Guarantors and Security".Substituted := true;
                "Loan Guarantors and Security"."Substituted By" := UserId;
                "Loan Guarantors and Security"."Date Substituted" := Today;
                "Loan Guarantors and Security".Modify;
                Message('Guarantor Released Successfully');
            end;

            trigger OnPreDataItem()
            begin
                if "Loan Guarantors and Security".GetFilter("Loan Guarantors and Security"."Loan No") = '' then
                    Error('Select Loan No');
                if "Loan Guarantors and Security".GetFilter("Loan Guarantors and Security"."Savings Account No./Member No.") = '' then
                    Error('Select Account No');
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

    trigger OnPreReport()
    begin
        UserSetup.Reset;
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.Find('-') then begin
            if UserSetup."Guarantor Release" = false then Error(Txt001);
        end;
    end;

    var
        "savings accounts": Record "Savings Accounts";
        UserSetup: Record "User Setup";
        Txt001: label 'You do not have permissions in user setup to run this report kindly contact your system adminstrator';
}
