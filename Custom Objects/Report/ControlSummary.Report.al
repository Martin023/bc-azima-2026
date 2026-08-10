Report 52185548 "Control Summary Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/ControlSummaryReport.rdl';
    Caption = 'Control Summary Report';

    dataset
    {
        dataitem(ControlBufferLoop; Integer)
        {
            DataItemTableView = sorting(Number);

            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Address; CompanyAddress) { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(CompanyTelephone; CompanyTelephone) { }
            column(CompanyEmail; CompanyEmail) { }
            column(PrintingDate; PrintingDate) { }
            column(PrintingTime; PrintingTime) { }
            column(PrintedBy; PrintedBy) { }
            column(DateFilterTxt; DateFilterTxt) { }

            column(Account_Type; Format(TempControlBuffer."Account Type")) { }
            column(Short_Code; TempControlBuffer."Short Code") { }
            column(Records; TempControlBuffer.Records) { }
            column(Account_Name; TempControlBuffer."Account Name") { }
            column(Account_No; TempControlBuffer."Account No.") { }
            column(Opening_Balance; TempControlBuffer."Opening Balance") { }
            column(Debit_Amt; TempControlBuffer."Debit Amt") { }
            column(Credit_Amt; TempControlBuffer."Credit Amt") { }
            column(Closing_Balance; TempControlBuffer."Closing Balance") { }

            trigger OnPreDataItem()
            begin
                SetRange(Number, 1, TempControlBuffer.Count);
            end;

            trigger OnAfterGetRecord()
            begin
                if Number = 1 then
                    TempControlBuffer.FindFirst()
                else
                    TempControlBuffer.Next();
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(Filters)
                {
                    Caption = 'Date Filters';
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'End Date';
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        CompanyAddress := CompanyInfo.Address + ' -Post Code: ' + CompanyInfo."Post Code" + ' -City:' + CompanyInfo.City + ' Region: ' + CompanyInfo."Country/Region Code";
        CompanyTelephone := CompanyInfo."Phone No." + ',' + CompanyInfo."Phone No. 2";
        CompanyEmail := CompanyInfo."E-Mail";

        PrintingDate := Format(Today, 0, '<Day,2>/<Month,2>/<Year4>');
        PrintingTime := Format(Time);
        PrintedBy := UserId;

        if (StartDate = 0D) then StartDate := Today;
        if (EndDate = 0D) then EndDate := Today;
        DateFilterTxt := '(' + Format(StartDate, 0, '<Day,2>/<Month,2>/<Year4>') + ') To (' + Format(EndDate, 0, '<Day,2>/<Month,2>/<Year4>') + ')';

        PopulateBuffer();
    end;

    var
        TempControlBuffer: Record "Control Summary Buffer" temporary;
        CompanyInfo: Record "Company Information";
        CompanyAddress: Text;
        DateFilterTxt: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;
        PrintingDate: Text;
        PrintingTime: Text;
        PrintedBy: Text;
        StartDate: Date;
        EndDate: Date;

    local procedure PopulateBuffer()
    begin
        TempControlBuffer.Reset();
        TempControlBuffer.DeleteAll();

        // These run incredibly fast now because they only scan transactions within the Date Filter
        ProcessGLAccounts();
        ProcessSavingsAccounts();
        ProcessLoanAccounts();
        ProcessBankAccounts();
    end;

    local procedure ProcessGLAccounts()
    var
        GLAcc: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        GLOpenEntry: Record "G/L Entry";
    begin
        GLEntry.Reset();
        GLEntry.SetRange("Posting Date", StartDate, EndDate);
        if GLEntry.FindSet() then begin
            repeat
                if not TempControlBuffer.Get(TempControlBuffer."Account Type"::"G/L Account", GLEntry."G/L Account No.") then begin
                    TempControlBuffer.Init();
                    TempControlBuffer."Account Type" := TempControlBuffer."Account Type"::"G/L Account";
                    TempControlBuffer."Account No." := GLEntry."G/L Account No.";
                    
                    if GLAcc.Get(GLEntry."G/L Account No.") then begin
                        TempControlBuffer."Account Name" := GLAcc.Name;
                        TempControlBuffer."Short Code" := GLAcc."Search Name";
                    end;
                    
                    // Fetch opening balance ONLY for this active account
                    GLOpenEntry.Reset();
                    GLOpenEntry.SetRange("G/L Account No.", GLEntry."G/L Account No.");
                    GLOpenEntry.SetFilter("Posting Date", '<%1', StartDate);
                    GLOpenEntry.CalcSums(Amount);
                    TempControlBuffer."Opening Balance" := GLOpenEntry.Amount;

                    TempControlBuffer.Records := 0;
                    TempControlBuffer."Debit Amt" := 0;
                    TempControlBuffer."Credit Amt" := 0;
                    TempControlBuffer.Insert();
                end;

                // Update totals dynamically
                TempControlBuffer.Records += 1;
                TempControlBuffer."Debit Amt" += GLEntry."Debit Amount";
                TempControlBuffer."Credit Amt" += GLEntry."Credit Amount";
                TempControlBuffer."Closing Balance" := TempControlBuffer."Opening Balance" + TempControlBuffer."Debit Amt" - TempControlBuffer."Credit Amt";
                TempControlBuffer.Modify();
                
            until GLEntry.Next() = 0;
        end;
    end;

    local procedure ProcessSavingsAccounts()
    var
        SavAcc: Record "Savings Accounts";
        SavEntry: Record "Savings Ledger Entry";
    begin
        SavEntry.Reset();
        SavEntry.SetRange("Posting Date", StartDate, EndDate);
        if SavEntry.FindSet() then begin
            repeat
                if not TempControlBuffer.Get(TempControlBuffer."Account Type"::Savings, SavEntry."Customer No.") then begin
                    TempControlBuffer.Init();
                    TempControlBuffer."Account Type" := TempControlBuffer."Account Type"::Savings;
                    TempControlBuffer."Account No." := SavEntry."Customer No.";
                    
                    if SavAcc.Get(SavEntry."Customer No.") then begin
                        TempControlBuffer."Account Name" := SavAcc.Name;
                        TempControlBuffer."Short Code" := SavAcc."Product Type";
                        
                        // Utilize BC's fast FlowFields to get Opening Balance
                        SavAcc.SetFilter("Date Filter", '<%1', StartDate);
                        SavAcc.CalcFields(Balance);
                        TempControlBuffer."Opening Balance" := SavAcc.Balance; 
                    end;
                    
                    TempControlBuffer.Records := 0;
                    TempControlBuffer."Debit Amt" := 0;
                    TempControlBuffer."Credit Amt" := 0;
                    TempControlBuffer.Insert();
                end;

                TempControlBuffer.Records += 1;
                TempControlBuffer."Debit Amt" += SavEntry."Debit Amount";
                TempControlBuffer."Credit Amt" += SavEntry."Credit Amount";
                // Savings (Liability): Closing = Opening - Withdrawals(Debit) + Deposits(Credit)
                TempControlBuffer."Closing Balance" := TempControlBuffer."Opening Balance" - TempControlBuffer."Debit Amt" + TempControlBuffer."Credit Amt";
                TempControlBuffer.Modify();
                
            until SavEntry.Next() = 0;
        end;
    end;

    local procedure ProcessLoanAccounts()
    var
        LoanAcc: Record Loans;
        CredEntry: Record "Credit Ledger Entry";
        CredOpenEntry: Record "Credit Ledger Entry";
    begin
        CredEntry.Reset();
        CredEntry.SetRange("Posting Date", StartDate, EndDate);
        if CredEntry.FindSet() then begin
            repeat
                if not TempControlBuffer.Get(TempControlBuffer."Account Type"::Loan, CredEntry."Loan No") then begin
                    TempControlBuffer.Init();
                    TempControlBuffer."Account Type" := TempControlBuffer."Account Type"::Loan;
                    TempControlBuffer."Account No." := CredEntry."Loan No";
                    
                    if LoanAcc.Get(CredEntry."Loan No") then begin
                        TempControlBuffer."Account Name" := LoanAcc."Member Name";
                        TempControlBuffer."Short Code" := LoanAcc."Loan Product Type"; 
                    end;
                    
                    // Fetch opening balance ONLY for this active loan
                    CredOpenEntry.Reset();
                    CredOpenEntry.SetRange("Loan No", CredEntry."Loan No");
                    CredOpenEntry.SetFilter("Posting Date", '<%1', StartDate);
                    CredOpenEntry.CalcSums(Amount);
                    TempControlBuffer."Opening Balance" := CredOpenEntry.Amount; 

                    TempControlBuffer.Records := 0;
                    TempControlBuffer."Debit Amt" := 0;
                    TempControlBuffer."Credit Amt" := 0;
                    TempControlBuffer.Insert();
                end;

                TempControlBuffer.Records += 1;
                TempControlBuffer."Debit Amt" += CredEntry."Debit Amount";
                TempControlBuffer."Credit Amt" += CredEntry."Credit Amount";
                // Loan (Asset): Closing = Opening + Disbursements/Interest(Debit) - Repayments(Credit)
                TempControlBuffer."Closing Balance" := TempControlBuffer."Opening Balance" + TempControlBuffer."Debit Amt" - TempControlBuffer."Credit Amt";
                TempControlBuffer.Modify();
                
            until CredEntry.Next() = 0;
        end;
    end;

    local procedure ProcessBankAccounts()
    var
        BankAcc: Record "Bank Account";
        BankEntry: Record "Bank Account Ledger Entry";
        BankOpenEntry: Record "Bank Account Ledger Entry";
    begin
        BankEntry.Reset();
        BankEntry.SetRange("Posting Date", StartDate, EndDate);
        if BankEntry.FindSet() then begin
            repeat
                if not TempControlBuffer.Get(TempControlBuffer."Account Type"::"Bank Account", BankEntry."Bank Account No.") then begin
                    TempControlBuffer.Init();
                    TempControlBuffer."Account Type" := TempControlBuffer."Account Type"::"Bank Account";
                    TempControlBuffer."Account No." := BankEntry."Bank Account No.";
                    
                    if BankAcc.Get(BankEntry."Bank Account No.") then begin
                        TempControlBuffer."Account Name" := BankAcc.Name;
                        TempControlBuffer."Short Code" := BankAcc."Search Name";
                    end;
                    
                    BankOpenEntry.Reset();
                    BankOpenEntry.SetRange("Bank Account No.", BankEntry."Bank Account No.");
                    BankOpenEntry.SetFilter("Posting Date", '<%1', StartDate);
                    BankOpenEntry.CalcSums("Amount (LCY)");
                    TempControlBuffer."Opening Balance" := BankOpenEntry."Amount (LCY)";

                    TempControlBuffer.Records := 0;
                    TempControlBuffer."Debit Amt" := 0;
                    TempControlBuffer."Credit Amt" := 0;
                    TempControlBuffer.Insert();
                end;

                TempControlBuffer.Records += 1;
                TempControlBuffer."Debit Amt" += BankEntry."Debit Amount (LCY)";
                TempControlBuffer."Credit Amt" += BankEntry."Credit Amount (LCY)";
                // Bank (Asset): Closing = Opening + Deposits(Debit) - Payments(Credit)
                TempControlBuffer."Closing Balance" := TempControlBuffer."Opening Balance" + TempControlBuffer."Debit Amt" - TempControlBuffer."Credit Amt";
                TempControlBuffer.Modify();
                
            until BankEntry.Next() = 0;
        end;
    end;
}