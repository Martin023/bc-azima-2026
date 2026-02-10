#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185903 "Account Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Account Statement.rdl';

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.";
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
            column(No_Members; Members."No.")
            {
            }
            column(Name_Members; Members.Name)
            {
            }
            column(IDNumber_Members; Members."Primary Identification")
            {
            }
            column(MobilePhoneNo_Members; Members."Phone No.")
            {
            }
            column(County_Members; Members.County)
            {
            }
            column(EMail_Members; Members."E-Mail")
            {
            }
            column(PayrollStaffNo_Members; Members."Payroll/Staff No.")
            {
            }
            column(TotShareCap; TotShareCap)
            {
            }
            column(TotDeposits; TotDeposits)
            {
            }
            column(TotOutloanbal; TotOutloanbal)
            {
            }
            dataitem(ShareCap; "Savings Accounts")
            {
                DataItemLink = "Member No." = field("No."), "Date Filter" = field("Date Filter");
                DataItemTableView = sorting("No.") where("Product Category" = filter("Share Capital"));
                column(ReportForNavId_46; 46)
                {
                }
                column(No_ShareCap; ShareCap."No.")
                {
                }
                column(Name_ShareCap; ShareCap.Name)
                {
                }
                column(MemberNo_ShareCap; ShareCap."Member No.")
                {
                }
                column(ProductName_ShareCap; ShareCap."Product Name")
                {
                }
                column(ShareCapBalanceBF; ShareCapBalanceBF)
                {
                }
                dataitem(ShareCapLedgerEntry; "Savings Ledger Entry")
                {
                    DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                    //DataItemTableView = sorting("Customer No.","Posting Date","Currency Code.") where(Reversed=const(No));
                    column(ReportForNavId_52; 52)
                    {
                    }
                    column(CustomerNo_ShareCapLedgerEntry; ShareCapLedgerEntry."Customer No.")
                    {
                    }
                    column(PostingDate_ShareCapLedgerEntry; ShareCapLedgerEntry."Posting Date")
                    {
                    }
                    column(DocumentType_ShareCapLedgerEntry; ShareCapLedgerEntry."Document Type")
                    {
                    }
                    column(DocumentNo_ShareCapLedgerEntry; ShareCapLedgerEntry."Document No.")
                    {
                    }
                    column(Description_ShareCapLedgerEntry; ShareCapLedgerEntry.Description)
                    {
                    }
                    column(AmountLCY_ShareCapLedgerEntry; ShareCapLedgerEntry."Amount (LCY)")
                    {
                    }
                    column(DebitAmount_ShareCapLedgerEntry; ShareCapLedgerEntry."Debit Amount")
                    {
                    }
                    column(CreditAmount_ShareCapLedgerEntry; ShareCapLedgerEntry."Credit Amount")
                    {
                    }
                    column(ShareCapAccountRunBal; ShareCapAccountRunBal)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        ShareCapAccountRunBal += -ShareCapLedgerEntry."Amount (LCY)";
                    end;

                    trigger OnPreDataItem()
                    begin
                        ShareCapAccountRunBal := 0;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    ShareCap.SetRange(ShareCap."Date Filter", 0D, CalcDate('-1D', StartDate));
                    ShareCap.CalcFields(ShareCap."Balance (LCY)");
                    ShareCapBalanceBF := ShareCap."Balance (LCY)";

                    ShareCap.SetRange(ShareCap."Date Filter", StartDate, EndDate);
                    SavingsAccountName := ShareCap."Product Type" + '-' + ShareCap."Product Name";
                end;

                trigger OnPreDataItem()
                begin
                    SavingsAccountName := '';
                    ShareCapBalanceBF := 0;
                end;
            }
            dataitem(SavingsAccounts; "Savings Accounts")
            {
                DataItemLink = "Member No." = field("No."), "Date Filter" = field("Date Filter");
                RequestFilterFields = "No.", "Member No.";
                column(ReportForNavId_2; 2)
                {
                }
                column(No_SavingsAccounts; SavingsAccounts."No.")
                {
                }
                column(Name_SavingsAccounts; SavingsAccounts.Name)
                {
                }
                column(MemberNo_SavingsAccounts; SavingsAccounts."Member No.")
                {
                }
                column(SavingsAccountName; SavingsAccountName)
                {
                }
                column(BalanceBF; BalanceBF)
                {
                }
                column(ProductName_SavingsAccounts; SavingsAccounts."Product Name")
                {
                }
                dataitem(SavingsLedgerEntry; "Savings Ledger Entry")
                {
                    DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                    //DataItemTableView = sorting("Customer No.","Posting Date","Currency Code.") where(Reversed=const(No));
                    column(ReportForNavId_3; 3)
                    {
                    }
                    column(MemberNo_SavingsLedgerEntry; SavingsLedgerEntry."Member No.")
                    {
                    }
                    column(CustomerNo_SavingsLedgerEntry; SavingsLedgerEntry."Customer No.")
                    {
                    }
                    column(PostingDate_SavingsLedgerEntry; SavingsLedgerEntry."Posting Date")
                    {
                    }
                    column(DocumentNo_SavingsLedgerEntry; SavingsLedgerEntry."Document No.")
                    {
                    }
                    column(Description_SavingsLedgerEntry; SavingsLedgerEntry.Description)
                    {
                    }
                    column(DebitAmountLCY_SavingsLedgerEntry; SavingsLedgerEntry."Debit Amount (LCY)")
                    {
                    }
                    column(CreditAmountLCY_SavingsLedgerEntry; SavingsLedgerEntry."Credit Amount (LCY)")
                    {
                    }
                    column(AmountLCY_SavingsLedgerEntry; SavingsLedgerEntry."Amount (LCY)")
                    {
                    }
                    column(SavingsAccountRunBal; SavingsAccountRunBal)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        SavingsAccountRunBal += -SavingsLedgerEntry."Amount (LCY)";
                    end;

                    trigger OnPreDataItem()
                    begin
                        SavingsAccountRunBal := 0;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    SavingsAccounts.SetRange(SavingsAccounts."Date Filter", 0D, CalcDate('-1D', StartDate));
                    SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)");
                    BalanceBF := SavingsAccounts."Balance (LCY)";

                    SavingsAccounts.SetRange(SavingsAccounts."Date Filter", StartDate, EndDate);
                    SavingsAccountName := SavingsAccounts."Product Type" + '-' + SavingsAccounts."Product Name";
                end;

                trigger OnPreDataItem()
                begin
                    SavingsAccountName := '';
                    BalanceBF := 0;
                end;
            }
            dataitem(CreditAccounts; "Credit Accounts")
            {
                DataItemLink = "Member No." = field("No."), "Date Filter" = field("Date Filter");
                DataItemTableView = sorting("No.") where("Balance (LCY)" = filter(> 0));
                column(ReportForNavId_37; 37)
                {
                }
                column(No_CreditAccounts; CreditAccounts."No.")
                {
                }
                column(Name_CreditAccounts; CreditAccounts.Name)
                {
                }
                column(MemberNo_CreditAccounts; CreditAccounts."Member No.")
                {
                }
                column(CreditAccountName; CreditAccountName)
                {
                }
                dataitem(CreditLedgerEntry; "Credit Ledger Entry")
                {
                    DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                    DataItemTableView = sorting("Customer No.", "Posting Date", "Currency Code") where("Transaction Type" = filter(<> Bills));
                    column(ReportForNavId_32; 32)
                    {
                    }
                    column(MemberNo_CreditLedgerEntry; CreditLedgerEntry."Member No.")
                    {
                    }
                    column(CustomerNo_CreditLedgerEntry; CreditLedgerEntry."Customer No.")
                    {
                    }
                    column(PostingDate_CreditLedgerEntry; CreditLedgerEntry."Posting Date")
                    {
                    }
                    column(DocumentNo_CreditLedgerEntry; CreditLedgerEntry."Document No.")
                    {
                    }
                    column(Description_CreditLedgerEntry; Descrip)
                    {
                    }
                    column(SASRAStatus; CreditLedgerEntry."SASRA Loan Status")
                    {
                    }
                    column(DebitAmountLCY_CreditLedgerEntry; CreditLedgerEntry."Debit Amount (LCY)")
                    {
                    }
                    column(CreditAmountLCY_CreditLedgerEntry; CreditLedgerEntry."Credit Amount (LCY)")
                    {
                    }
                    column(AmountLCY_CreditLedgerEntry; CreditLedgerEntry."Amount (LCY)")
                    {
                    }
                    column(CreditAccountRunBal; CreditAccountRunBal)
                    {
                    }
                    column(LoanNo_CreditLedgerEntry; CreditLedgerEntry."Loan No")
                    {
                    }
                    column(LoanType_CreditLedgerEntry; CreditLedgerEntry."Loan Type")
                    {
                    }
                    column(ProductDesc; ProductDesc)
                    {
                    }
                    column(AppAmount; AppAmount)
                    {
                    }
                    column(DisbursementDate; DisbursementDate)
                    {
                    }
                    column(CompletionDate; CompletionDate)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CreditAccountRunBal += CreditLedgerEntry."Amount (LCY)";
                        if ProductFac.Get("Loan Type") then
                            ProductDesc := ProductFac."Product ID" + ' :' + ' ' + ProductFac."Product Description";
                        Descrip := CopyStr(CreditLedgerEntry.Description, 1, 50);
                        if Descrip = '' then
                            Descrip := CreditLedgerEntry."Document No." else
                            Descrip := CreditLedgerEntry.Description;
                        CreditLedgerEntry."Document No." := CopyStr(CreditLedgerEntry."Document No.", 1, 50);
                        if PLoan.Get("Loan No") then begin
                            //PLoan.CalcFields("Outstanding Balance");
                            AppAmount := PLoan."Approved Amount";
                            DisbursementDate := PLoan."Disbursement Date";
                            CompletionDate := PLoan."Expected Date of Completion";
                        end;
                        if PLoan."Outstanding Balance" = 0 then
                            CurrReport.Skip;
                    end;

                    trigger OnPreDataItem()
                    begin
                        CreditAccountRunBal := 0;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CreditAccounts.SetRange(CreditAccounts."Date Filter", 0D, CalcDate('-1D', StartDate));
                    CreditAccounts.CalcFields(CreditAccounts."Balance (LCY)");
                    BalanceBF := CreditAccounts."Balance (LCY)";

                    CreditAccounts.SetRange(CreditAccounts."Date Filter", StartDate, EndDate);
                    CreditAccountName := CreditAccounts."Product Type" + '-' + CreditAccounts."Product Name";
                end;

                trigger OnPreDataItem()
                begin
                    CreditAccountName := '';
                    BalanceBF := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if StartDate = 0D then StartDate := 20900101D;
                if EndDate = 0D then EndDate := Today;

                TotDeposits := 0;
                TotOutloanbal := 0;
                TotShareCap := 0;

                // Accs.Reset;
                // Accs.SetRange("Member No.","No.");
                // Accs.SetRange("Product Category",Accs."Product Category"::"BOSA Deposits");
                // if Accs.Find('-') then
                // Accs.CalcFields("Balance (LCY)");
                // TotDeposits:=Accs."Balance (LCY)";


                // SharecapAcc.Reset;
                // SharecapAcc.SetRange("Member No.","No.");
                // SharecapAcc.SetRange("Product Category",SharecapAcc."product category"::"Share Capital");
                // if SharecapAcc.Find('-') then
                // SharecapAcc.CalcFields("Balance (LCY)");
                // TotShareCap:=SharecapAcc."Balance (LCY)";


                // LoanAppl.Reset;
                // LoanAppl.SetRange("Member No.","No.");
                // if LoanAppl.Find('-') then begin
                //   repeat
                //   LoanAppl.CalcFields("Outstanding Balance");
                //   TotOutloanbal:=TotOutloanbal+LoanAppl."Outstanding Balance";
                // until LoanAppl.Next=0;
                // end;
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
                group("Date Filter")
                {
                    field("Start Date:"; StartDate)
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
                    field("End Date:"; EndDate)
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
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

    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := CompanyInformation."Phone No.";
        CommunicationOnline := CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        BalanceBF: Decimal;
        SavingsAccountName: Text;
        SavingsAccountRunBal: Decimal;
        CreditAccountName: Text;
        CreditAccountRunBal: Decimal;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        StartDate: Date;
        EndDate: Date;
        ShareCapBalanceBF: Decimal;
        ShareCapAccountRunBal: Decimal;
        ProductFac: Record "Product Factory";
        ProductDesc: Text[150];
        PLoan: Record Loans;
        AppAmount: Decimal;
        DisbursementDate: Date;
        CompletionDate: Date;
        TotShareCap: Decimal;
        TotDeposits: Decimal;
        TotOutloanbal: Decimal;
        Accs: Record "Savings Accounts";
        LoanAppl: Record Loans;
        SharecapAcc: Record "Savings Accounts";
        Descrip: Text[150];
}
