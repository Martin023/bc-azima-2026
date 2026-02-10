#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185430 "Create Journals"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Create Journals.rdl';
    //Permissions = TableData UnknownTableData52186213 = rimd;

    dataset
    {
        dataitem("Journal Two"; "Journal Two")
        {
            // DataItemTableView = where(Posted = const(No));
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Journal.Reset;
                Journal.SetRange("Journal Template Name", 'GENERAL');
                Journal.SetRange("Journal Batch Name", 'OPENING');
                Journal.DeleteAll;
                SavingsAccounts.Reset;
                SavingsAccounts.SetRange("No.", JournalTwo."Account No");
                SavingsAccounts.SetFilter(Blocked, '<>%1', SavingsAccounts.Blocked::" ");
                if SavingsAccounts.FindFirst then begin
                    if SavingsAccounts.Blocked <> SavingsAccounts.Blocked::" " then begin
                        SavingsAccounts.Blocked := SavingsAccounts.Blocked::" ";
                        SavingsAccounts.Modify;
                    end;
                end;


                if "Journal Two".Amount <> 0 then begin


                    Journal.Init;
                    Journal."Journal Template Name" := 'GENERAL';
                    Journal."Journal Batch Name" := 'OPENING';
                    Journal."Line No." := "Journal Two"."No.";
                    Journal."Account Type" := "Journal Two"."Accout Type";
                    Journal."Account No." := "Journal Two"."Account No";
                    Journal.Validate(Journal."Account No.");
                    Journal."Posting Date" := "Journal Two"."Posting Date";
                    if "Journal Two"."Document No" <> '' then
                        Journal."Document No." := "Journal Two"."Document No" else
                        Journal."Document No." := 'OPENING BAL';
                    Journal.Amount := "Journal Two".Amount;
                    Journal.Validate(Journal.Amount);
                    Journal.Description := ("Journal Two".Description);
                    //Journal."External Document No.":="Journal Two"."External Doc";
                    Journal."Transaction Type" := "Journal Two"."TransaCTION tYPE";
                    Journal."Loan No" := "Journal Two"."Loan No";
                    Journal."Shortcut Dimension 1 Code" := 'credit';
                    Journal."Shortcut Dimension 2 Code" := 'NBI';
                    Journal.Validate(Journal."Shortcut Dimension 1 Code");
                    Journal.Validate(Journal."Shortcut Dimension 2 Code");
                    Journal."Bal. Account Type" := Journal."bal. account type"::"G/L Account";
                    if "Journal Two"."TransaCTION tYPE" = "Journal Two"."transaction type"::Bills then
                        Journal."Bal. Account No." := '10833'
                    else
                        Journal."Bal. Account No." := "Journal Two"."bal Account No";
                    //Journal."yes/no":="Journal Two"."yes/no";
                    if Journal.Amount <> 0 then
                        Journal.Insert;
                    //Post
                    Journal.Reset;
                    Journal.SetRange("Journal Template Name", 'GENERAL');
                    Journal.SetRange("Journal Batch Name", 'OPENING');
                    if Journal.Find('-') then begin
                        // Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", Journal);
                        Posted := true;
                        Commit;
                        // UnknownTable52186213.Modify
                    end;
                end;




                if "Journal Two".Amount = 0 then
                    exit;


                JournalTwo.Reset;
                JournalTwo.SetRange(JournalTwo."No.", "Journal Two"."No.");
                JournalTwo.SetRange("Account No", "Journal Two"."Account No");
                JournalTwo.SetFilter(Blocked, '<>%1', JournalTwo.Blocked::" ");
                if JournalTwo.Find('-') then begin
                    SavingsAccounts.Blocked := JournalTwo.Blocked;
                    //SavingsAccounts.MODIFY;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Posted Successfully');
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
        Journal: Record "Gen. Journal Line";
        Mem: Record "Members";
        LOANSAPP: Record Loans;
        loantype: Record "Product Factory";
        JournalTwo: Record "Journal Two";
        SavingsAccounts: Record "Savings Accounts";
}
