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

        ProcessGLAccounts();
        ProcessSavingsAccounts();
        ProcessLoanAccounts();
        ProcessBankAccounts();
    end;

    local procedure ProcessGLAccounts()
    var
        GLAcc: Record "G/L Account";
        GLEntry: Record "G/L Entry";
    begin
        if GLAcc.FindSet() then begin
            repeat
                GLEntry.Reset();
                GLEntry.SetRange("G/L Account No.", GLAcc."No.");
                GLEntry.SetRange("Posting Date", StartDate, EndDate);
                
                if (GLEntry.Count > 0) or AccountHasOpening(0, GLAcc."No.") then begin
                    TempControlBuffer.Init();
                    TempControlBuffer."Account Type" := TempControlBuffer."Account Type"::"G/L Account";
                    TempControlBuffer."Account No." := GLAcc."No.";
                    TempControlBuffer."Account Name" := GLAcc.Name;
                    TempControlBuffer."Short Code" := GLAcc."Search Name";
                    
                    // Opening
                    GLEntry.Reset();
                    GLEntry.SetRange("G/L Account No.", GLAcc."No.");
                    GLEntry.SetFilter("Posting Date", '<%1', StartDate);
                    GLEntry.CalcSums(Amount);
                    TempControlBuffer."Opening Balance" := GLEntry.Amount;

                    // Period
                    GLEntry.SetRange("Posting Date", StartDate, EndDate);
                    GLEntry.CalcSums("Debit Amount", "Credit Amount");
                    TempControlBuffer."Debit Amt" := GLEntry."Debit Amount";
                    TempControlBuffer."Credit Amt" := GLEntry."Credit Amount";
                    TempControlBuffer.Records := GLEntry.Count();

                    TempControlBuffer."Closing Balance" := TempControlBuffer."Opening Balance" + TempControlBuffer."Debit Amt" - TempControlBuffer."Credit Amt";
                    
                    if (TempControlBuffer."Opening Balance" <> 0) or (TempControlBuffer.Records > 0) then
                        TempControlBuffer.Insert();
                end;
            until GLAcc.Next() = 0;
        end;
    end;

    local procedure ProcessSavingsAccounts()
    var
        SavAcc: Record "Savings Accounts";
        SavEntry: Record "Savings Ledger Entry";
    begin
        if SavAcc.FindSet() then begin
            repeat
                SavEntry.Reset();
                SavEntry.SetRange("Customer No.", SavAcc."No.");
                SavEntry.SetRange("Posting Date", StartDate, EndDate);
                
                if (SavEntry.Count > 0) or AccountHasOpening(1, SavAcc."No.") then begin
                    TempControlBuffer.Init();
                    TempControlBuffer."Account Type" := TempControlBuffer."Account Type"::Savings;
                    TempControlBuffer."Account No." := SavAcc."No.";
                    TempControlBuffer."Account Name" := SavAcc.Name;
                    TempControlBuffer."Short Code" := SavAcc."Product Type"; // Mapping Acc column
                    
                    // Opening
                    SavEntry.Reset();
                    SavEntry.SetRange("Customer No.", SavAcc."No.");
                    SavEntry.SetFilter("Posting Date", '<%1', StartDate);
                    SavEntry.CalcSums(Amount);
                    TempControlBuffer."Opening Balance" := -SavEntry.Amount; // standard liability sign flip

                    // Period
                    SavEntry.SetRange("Posting Date", StartDate, EndDate);
                    SavEntry.CalcSums("Debit Amount", "Credit Amount"); // LCY fields if preferred, assuming base is fine
                    TempControlBuffer."Debit Amt" := SavEntry."Debit Amount";
                    TempControlBuffer."Credit Amt" := SavEntry."Credit Amount";
                    TempControlBuffer.Records := SavEntry.Count();

                    // Savings: Closing = Opening - Debits(Withdrawals) + Credits(Deposits)
                    TempControlBuffer."Closing Balance" := TempControlBuffer."Opening Balance" - TempControlBuffer."Debit Amt" + TempControlBuffer."Credit Amt";
                    
                    if (TempControlBuffer."Opening Balance" <> 0) or (TempControlBuffer.Records > 0) then
                        TempControlBuffer.Insert();
                end;
            until SavAcc.Next() = 0;
        end;
    end;

    local procedure ProcessLoanAccounts()
    var
        LoanAcc: Record Loans;
        CredEntry: Record "Credit Ledger Entry";
    begin
        if LoanAcc.FindSet() then begin
            repeat
                CredEntry.Reset();
                CredEntry.SetRange("Loan No", LoanAcc."Loan No.");
                CredEntry.SetRange("Posting Date", StartDate, EndDate);
                
                if (CredEntry.Count > 0) or AccountHasOpening(2, LoanAcc."Loan No.") then begin
                    TempControlBuffer.Init();
                    TempControlBuffer."Account Type" := TempControlBuffer."Account Type"::Loan;
                    TempControlBuffer."Account No." := LoanAcc."Loan No.";
                    TempControlBuffer."Account Name" := LoanAcc."Member Name";
                    TempControlBuffer."Short Code" := LoanAcc."Loan Product Type"; 
                    
                    // Opening
                    CredEntry.Reset();
                    CredEntry.SetRange("Loan No", LoanAcc."Loan No.");
                    CredEntry.SetFilter("Posting Date", '<%1', StartDate);
                    CredEntry.CalcSums(Amount);
                    TempControlBuffer."Opening Balance" := CredEntry.Amount; 

                    // Period
                    CredEntry.SetRange("Posting Date", StartDate, EndDate);
                    CredEntry.CalcSums("Debit Amount", "Credit Amount");
                    TempControlBuffer."Debit Amt" := CredEntry."Debit Amount";
                    TempControlBuffer."Credit Amt" := CredEntry."Credit Amount";
                    TempControlBuffer.Records := CredEntry.Count();

                    TempControlBuffer."Closing Balance" := TempControlBuffer."Opening Balance" + TempControlBuffer."Debit Amt" - TempControlBuffer."Credit Amt";
                    
                    if (TempControlBuffer."Opening Balance" <> 0) or (TempControlBuffer.Records > 0) then
                        TempControlBuffer.Insert();
                end;
            until LoanAcc.Next() = 0;
        end;
    end;

    local procedure ProcessBankAccounts()
    var
        BankAcc: Record "Bank Account";
        BankEntry: Record "Bank Account Ledger Entry";
    begin
        if BankAcc.FindSet() then begin
            repeat
                BankEntry.Reset();
                BankEntry.SetRange("Bank Account No.", BankAcc."No.");
                BankEntry.SetRange("Posting Date", StartDate, EndDate);
                
                if (BankEntry.Count > 0) or AccountHasOpening(3, BankAcc."No.") then begin
                    TempControlBuffer.Init();
                    TempControlBuffer."Account Type" := TempControlBuffer."Account Type"::"Bank Account";
                    TempControlBuffer."Account No." := BankAcc."No.";
                    TempControlBuffer."Account Name" := BankAcc.Name;
                    TempControlBuffer."Short Code" := BankAcc."Search Name";
                    
                    // Opening
                    BankEntry.Reset();
                    BankEntry.SetRange("Bank Account No.", BankAcc."No.");
                    BankEntry.SetFilter("Posting Date", '<%1', StartDate);
                    BankEntry.CalcSums("Amount (LCY)");
                    TempControlBuffer."Opening Balance" := BankEntry."Amount (LCY)";

                    // Period
                    BankEntry.SetRange("Posting Date", StartDate, EndDate);
                    BankEntry.CalcSums("Debit Amount (LCY)", "Credit Amount (LCY)");
                    TempControlBuffer."Debit Amt" := BankEntry."Debit Amount (LCY)";
                    TempControlBuffer."Credit Amt" := BankEntry."Credit Amount (LCY)";
                    TempControlBuffer.Records := BankEntry.Count();

                    TempControlBuffer."Closing Balance" := TempControlBuffer."Opening Balance" + TempControlBuffer."Debit Amt" - TempControlBuffer."Credit Amt";
                    
                    if (TempControlBuffer."Opening Balance" <> 0) or (TempControlBuffer.Records > 0) then
                        TempControlBuffer.Insert();
                end;
            until BankAcc.Next() = 0;
        end;
    end;

    local procedure AccountHasOpening(AccType: Integer; AccNo: Code[50]): Boolean
    var
        GLEntry: Record "G/L Entry";
        SavEntry: Record "Savings Ledger Entry";
        CredEntry: Record "Credit Ledger Entry";
        BankEntry: Record "Bank Account Ledger Entry";
    begin
        case AccType of
            0: 
            begin
                GLEntry.SetRange("G/L Account No.", AccNo);
                GLEntry.SetFilter("Posting Date", '<%1', StartDate);
                GLEntry.CalcSums(Amount);
                exit(GLEntry.Amount <> 0);
            end;
            1:
            begin
                SavEntry.SetRange("Customer No.", AccNo);
                SavEntry.SetFilter("Posting Date", '<%1', StartDate);
                SavEntry.CalcSums(Amount);
                exit(SavEntry.Amount <> 0);
            end;
            2:
            begin
                CredEntry.SetRange("Loan No", AccNo);
                CredEntry.SetFilter("Posting Date", '<%1', StartDate);
                CredEntry.CalcSums(Amount);
                exit(CredEntry.Amount <> 0);
            end;
            3:
            begin
                BankEntry.SetRange("Bank Account No.", AccNo);
                BankEntry.SetFilter("Posting Date", '<%1', StartDate);
                BankEntry.CalcSums("Amount (LCY)");
                exit(BankEntry."Amount (LCY)" <> 0);
            end;
        end;
        exit(false);
    end;
}