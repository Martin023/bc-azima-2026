report 52187419 "Deposit Listing Report"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    // RDLCLayout = './bc-kenpipe-2024/Layout/Deposit Listing Report.rdl';
    RDLCLayout = './bc-kenpipe-2024/Layout/Deposit Listing Test.rdl';

    dataset
    {
        dataitem("Savings Accounts"; "Savings Accounts")
        {
            RequestFilterFields = "Member No.", "Product Category", Status, "Employer Code", "Date Filter";
            CalcFields = "Balance (LCY)";
            // DataItemTableView = where("Product Category" = filter("Entrance Fee" | "Share Capital" | "BOSA Deposits" | "Benevolent (BBF)" | "Risk" | "FOSA Account" | "Share Capital" |
            // "Fixed Deposit" | "Unallocated Fund" | "Transfered Share Capital" | "Biashara Account" | "Business Deposits" | "Chama Investment Account" | "Junior Account" | "SAYE" | "General Account"));
            column(AccNo; "No.") { }

            trigger OnPreDataItem()
            var
                DepositListing: Record "Deposit Listing";
                BulkErrors: Record "Bulk Processing Errors";
            begin
                DepositListing.Reset();
                DepositListing.DeleteAll();

                BulkErrors.Reset();
                BulkErrors.SetRange(Process, BulkErrors.Process::"Deposit Listing");
                BulkErrors.DeleteAll();

                if AsAt = 0D then
                    AsAt := Today;

                BatchNo := Format(CurrentDateTime);
            end;

            trigger OnAfterGetRecord()
            begin
                BulkProcessing.GenerateDepositListing("Savings Accounts", AsAt, BatchNo);
            END;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group("Options")
                {
                    field(AsAt; AsAt)
                    {
                        ApplicationArea = All;
                        Caption = 'As At';
                    }
                }
            }
        }
    }
    var
        AsAt: Date;




        BulkProcessing: Codeunit "Bulk Processing";
        BatchNo: Code[100];



}
