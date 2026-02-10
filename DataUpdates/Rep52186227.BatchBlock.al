namespace KenpipeCBS.KenpipeCBS;

report 52186227 "Batch Block"
{
    ApplicationArea = All;
    Caption = 'Batch Block Accounts';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(SavingsAccounts; "Savings Accounts")
        {
            trigger OnafterGetRecord()
            begin
                // Custom logic to execute after getting each record
                if Block then
                    SavingsAccounts.Blocked := SavingsAccounts."Blocked"::All;
                if Unblock then
                    SavingsAccounts.Blocked := SavingsAccounts."Blocked"::" ";
                SavingsAccounts.Modify(true);
            end;

        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    Caption = 'Batch Block Accounts.';
                    field(Block; Block)
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Check this box to process the batch block operation.';
                    }
                    field(Unblock; Unblock)
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Check this box to process the batch block operation.';
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        Block: Boolean;
        Unblock: Boolean;
}
