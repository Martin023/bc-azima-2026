#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186000 "Anti-Money Laundering Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Anti-Money Laundering Report.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Cashier Transactions"; "Cashier Transactions")
        {
            DataItemTableView = where("Account Type" = const(Account), Amount = filter(>= 1000000), Posted = const(true));
            // "Transaction Type" = filter('BANKERS CHEQUE' | 'CASH DEPOSITS' | 'CASH WITHDRWAL' | 'CHEQUE DEPOSIT' | 'CREDIT CHEQUE DEPOSI' | 'CREDIT RECEIPT' | 'RTGS'));
            RequestFilterFields = "Account No", "Member No.", "Date Posted", "Transaction Date";
            column(ReportForNavId_21; 21)
            {
            }


            dataitem("Savings Ledger Entry"; "Savings Ledger Entry")
            {
                DataItemLink = "Customer No." = field("Account No"), "Document No." = field(No);
                DataItemTableView = where(Amount = filter(<= -1000000 | >= 1000000));
                column(ReportForNavId_1; 1)
                {
                }
                column(CompanyInformation_Name; CompanyInformation.Name)
                {
                }
                column(CompanyInformation_Picture; CompanyInformation.Picture)
                {
                }
                column(CompanyAddress; CompanyAddress)
                {
                }
                column(CompanyTelephone; CompanyTelephone)
                {
                }
                column(CommunicationOnline; CommunicationOnline)
                {
                }
                column(PostingDate; "Cashier Transactions"."Date Posted")
                {
                }
                column(MemberName; "Cashier Transactions"."Account Name")
                {
                }
                column(MemberNumber; "Cashier Transactions"."Member No.")
                {
                }
                column(AccountNo; "Cashier Transactions"."Account No")
                {
                }
                column(IDNumber; "Cashier Transactions"."ID No")
                {
                }
                column(DocNo; "Cashier Transactions".No)
                {
                }
                column(DoB; DoB)
                {

                }
                column(TotalTransactions; TotalTransactions)
                {
                }
                column(Description_SavingsLedgerEntry; "Savings Ledger Entry".Description)
                {
                }
                column(Amount_SavingsLedgerEntry; "Cashier Transactions".Amount)
                {
                }
                column(EntryNo_SavingsLedgerEntry; "Savings Ledger Entry"."Entry No.")
                {
                }
                column(GLAcc; GLAccount."No.")
                {
                }

                column(BranchCode; "Cashier Transactions"."Global Dimension 1 Code")
                {
                }
                column(ActivityCode; "Cashier Transactions"."Global Dimension 2 Code")
                {
                }
                column(PostedBy; "Cashier Transactions".Cashier)
                {
                }
                column(PrintedBy; "Cashier Transactions".Cashier)
                {
                }
                column(PrintedAt; "Cashier Transactions"."Transaction Time")
                {
                }

                column(DatePosted; "Cashier Transactions"."Date Posted")
                {

                }
                column(Type; "Cashier Transactions".Type)
                {

                }
                column(Remarks; "Cashier Transactions".Remarks)
                {

                }
                column(Source; "Cashier Transactions".Source)
                {
                }
                column(Purpose; "Cashier Transactions".Purpose)
                {
                }


                trigger OnAfterGetRecord()
                begin
                    if TransType.Type = TransType.Type::"Cash Deposit" then begin
                        SavAcc.Reset();
                        SavAcc.SetRange("Member No.", "Cashier Transactions"."Member No.");
                        if SavAcc.FindFirst() then begin
                            DoB := SavAcc."Date of Birth";
                            repeat
                                "Savings Ledger Entry".Reset();
                                "Savings Ledger Entry".SetRange("Customer No.", SavAcc."No.");
                                "Savings Ledger Entry".SetRange("Posting Date", Today);
                                if "Savings Ledger Entry".FindFirst() then begin
                                    repeat
                                        TotalTransactions += "Savings Ledger Entry".Amount
                                    until "Savings Ledger Entry".Next() = 0;
                                end;
                            until SavAcc.Next() = 0;
                            TotalTransactions -= "Cashier Transactions".Amount;
                            if TotalTransactions <= -1000000 then begin
                                TotalTransactions *= -1;
                                // Message('This member will have transacted over a million today %1', TotalTransactions);
                            end;
                        end;

                    end;

                end;

                trigger OnPreDataItem()
                begin
                    // "Savings Ledger Entry".SETCURRENTKEY("Posting Date");
                    // "Savings Ledger Entry".FINDFIRST;
                    // FirstDate := SkyHarambeePortal.FormatDate("Savings Ledger Entry"."Posting Date");
                    //
                    // "Savings Ledger Entry".FINDLAST;
                    // LastDate := SkyHarambeePortal.FormatDate("Savings Ledger Entry"."Posting Date");
                end;
            }
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
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        PrintedBy: Code[50];
        TransType: Record "Transaction Types";
        SavAcc: Record "Savings Accounts";
        TotalTransactions: Decimal;
        DatePosted: Date;
        DoB: Date;
        PrintedAt: Text;
        Members: Record "Members";
        PostingDate: Date;
        Source: Text[200];
        Purpose: Text[100];
        RegistrationDate: Text;
        SavingsAccounts: Record "Savings Accounts";
        Employer: Text;
        PostedBy: Text;
        MemberName: Text;
        MemberNumber: Text;
        IDNumber: Text;
        BranchCode: Code[10];
        GLAcc: Code[10];
        GLName: Text;
        ProductFactory: Record "Product Factory";
        CustomerPostingGroup: Record "Customer Posting Group";
        GLAccount: Record "G/L Account";
        FirstDate: Text;
        LastDate: Text;
        CashierTrans: Record "Cashier Transactions";
}
