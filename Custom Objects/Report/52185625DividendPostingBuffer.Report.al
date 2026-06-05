Report 52185625 "Dividend Posting Buffer"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DividendHeader; "Dividend Header")
        {
            RequestFilterFields = "No.", "Start Date", "End Date", Year;

            dataitem(Members; "Members")
            {
                // 
                RequestFilterFields = "No.", "Employer Code";

                trigger OnAfterGetRecord()
                begin
                    // DividendSetUp.get();
                    // Year := Date2dmy(DividendHeader."Start Date", 3);
                    // PreviousYear := Year;
                    DividendPostingBuffer.Reset();
                    DividendPostingBuffer.SetRange("Header No.", DividendHeader."No.");
                    DividendPostingBuffer.SetRange(Posted, false);
                    DividendPostingBuffer.SetRange("Member No.", Members."No.");
                    if DividendPostingBuffer.FindSet() then
                        DividendPostingBuffer.DeleteAll(true);


                    DividendProcess.GenerateDividendPostingEntries(Members."No.", PostingOptions,DividendHeader);

                end;

                // trigger OnPostDataItem()
                // begin
                //     Message(Text001);
                // end;

                trigger OnPreDataItem()
                begin
                    // Year := Date2dmy(Today, 3);
                    // PreviousYear := Year - 1;
                end;
            }
        }

    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field("Posting Options:"; PostingOptions)
                {
                    ApplicationArea = Basic;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        Message(Text001);
    end;

    trigger OnPreReport()
    var
        DividendProcess: Codeunit "Dividend Process";
        Members: Record "Members";
    begin
        //DividendProcess.GenerateDividendPostingEntries(Members."No.");
    end;

    var
        Text001: label 'Successfully Processed.';
        DividendProcess: Codeunit "Dividend Process";
        DividendPostingBuffer: Record "Dividend Posting Buffer";
        PostingOptions: Option All,"BOSA Deposits","Share Capital";
}
