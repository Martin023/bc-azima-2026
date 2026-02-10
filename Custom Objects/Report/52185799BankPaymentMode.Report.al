#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185799 "Bank Payment Mode"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Bank Payment Mode.rdl';
    Caption = 'Bank Acc. - Detail Trial Bal.';

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Bank Acc. Posting Group", "Date Filter";
            column(ReportForNavId_4558; 4558)
            {
            }
            column(FilterPeriod_BankAccLedg; StrSubstNo(Text000, DateFilter_BankAccount))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(ExcludeBalanceOnly; ExcludeBalanceOnly)
            {
            }
            column(BankAccFilter; BankAccFilter)
            {
            }
            column(StartBalanceLCY; StartBalanceLCY)
            {
            }
            column(StartBalance; StartBalance)
            {
            }
            column(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
            {
            }
            column(ReportFilter; StrSubstNo('%1: %2', "Bank Account".TableCaption, BankAccFilter))
            {
            }
            column(No_BankAccount; "Bank Account"."No.")
            {
            }
            column(Name_BankAccount; "Bank Account".Name)
            {
            }
            column(PhNo_BankAccount; "Bank Account"."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CurrencyCode_BankAccount; "Bank Account"."Currency Code")
            {
                IncludeCaption = true;
            }
            column(StartBalance2; StartBalance)
            {
                AutoFormatExpression = "Bank Account Ledger Entry"."Currency Code";
                AutoFormatType = 1;
            }
            column(BankAccDetailTrialBalCap; BankAccDetailTrialBalCapLbl)
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(RepInclBankAcchavingBal; RepInclBankAcchavingBalLbl)
            {
            }
            column(BankAccLedgPostingDateCaption; BankAccLedgPostingDateCaptionLbl)
            {
            }
            column(BankAccBalanceCaption; BankAccBalanceCaptionLbl)
            {
            }
            column(OpenFormatCaption; OpenFormatCaptionLbl)
            {
            }
            column(BankAccBalanceLCYCaption; BankAccBalanceLCYCaptionLbl)
            {
            }
            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = field("No."), "Posting Date" = field("Date Filter"), "Global Dimension 2 Code" = field("Global Dimension 2 Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter");
                DataItemTableView = sorting("Bank Account No.", "Posting Date");
                RequestFilterFields = Amount;
                column(ReportForNavId_4920; 4920)
                {
                }
                column(PostingDate_BankAccLedg; Format("Bank Account Ledger Entry"."Posting Date"))
                {
                }
                column(DocType_BankAccLedg; "Bank Account Ledger Entry"."Document Type")
                {
                    IncludeCaption = true;
                }
                column(DocNo_BankAccLedg; "Bank Account Ledger Entry"."Document No.")
                {
                    IncludeCaption = true;
                }
                column(Desc_BankAccLedg; "Bank Account Ledger Entry".Description)
                {
                    IncludeCaption = true;
                }
                column(BankAccBalance; BankAccBalance)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(RemaningAmt_BankAccLedg; "Bank Account Ledger Entry"."Remaining Amount")
                {
                    IncludeCaption = true;
                }
                column(EntryNo_BankAccLedg; "Bank Account Ledger Entry"."Entry No.")
                {
                    IncludeCaption = true;
                }
                // column(OpenFormat; Format("Bank Account Ledger Entry".Open))
                // {
                //     OptionCaption = 'Open';
                // }
                column(Amount_BankAccLedg; "Bank Account Ledger Entry".Amount)
                {
                    IncludeCaption = true;
                }
                column(EntryAmtLcy_BankAccLedg; "Bank Account Ledger Entry"."Amount (LCY)")
                {
                    IncludeCaption = true;
                }
                column(BankAccBalanceLCY; BankAccBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(ContinuedCaption; ContinuedCaptionLbl)
                {
                }
                column(PayMode; "Pay Mode")
                {
                }
                column(ExternalDocumentNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."External Document No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if not PrintReversedEntries and "Bank Account Ledger Entry".Reversed then
                        CurrReport.Skip;

                    if GetPaymentMode("Bank Account Ledger Entry"."Document No.") = true then begin
                        if "Pay Mode" <> "Payments Mode Filter" then
                            CurrReport.Skip
                    end
                    else
                        CurrReport.Skip;

                    BankAccLedgEntryExists := true;
                    BankAccBalance := BankAccBalance + "Bank Account Ledger Entry".Amount;
                    BankAccBalanceLCY := BankAccBalanceLCY + "Bank Account Ledger Entry"."Amount (LCY)"
                end;

                trigger OnPreDataItem()
                begin
                    BankAccLedgEntryExists := false;
                    CurrReport.CreateTotals("Bank Account Ledger Entry".Amount, "Bank Account Ledger Entry"."Amount (LCY)");
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(ReportForNavId_5444; 5444)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if not BankAccLedgEntryExists and ((StartBalance = 0) or ExcludeBalanceOnly) then begin
                        StartBalanceLCY := 0;
                        CurrReport.Skip;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                StartBalance := 0;
                if DateFilter_BankAccount <> '' then
                    if "Bank Account".GetRangeMin("Bank Account"."Date Filter") <> 0D then begin
                        "Bank Account".SetRange("Bank Account"."Date Filter", 0D, "Bank Account".GetRangeMin("Bank Account"."Date Filter") - 1);
                        "Bank Account".CalcFields("Bank Account"."Net Change", "Bank Account"."Net Change (LCY)");
                        StartBalance := "Bank Account"."Net Change";
                        StartBalanceLCY := "Bank Account"."Net Change (LCY)";
                        "Bank Account".SetFilter("Bank Account"."Date Filter", DateFilter_BankAccount);
                    end;
                //CurrReport.PrintonlyIfDetail := ExcludeBalanceOnly or (StartBalance = 0);
                BankAccBalance := StartBalance;
                BankAccBalanceLCY := StartBalanceLCY;

                if PrintOnlyOnePerPage then
                    PageGroupNo := PageGroupNo + 1;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.NewPagePerRecord := PrintOnlyOnePerPage;
                CurrReport.CreateTotals("Bank Account Ledger Entry"."Amount (LCY)", StartBalanceLCY);
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
                group(Options)
                {
                    Caption = 'Options';
                    field(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
                    {
                        ApplicationArea = Basic;
                        Caption = 'New Page per Bank Account';
                    }
                    field(ExcludeBalanceOnly; ExcludeBalanceOnly)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Exclude Bank Accs. That Have a Balance Only';
                        MultiLine = true;
                    }
                    field(PrintReversedEntries; PrintReversedEntries)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Include Reversed Entries';
                    }
                    field("Payments Mode Filter"; "Payments Mode Filter")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Payments Mode';
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

    trigger OnInitReport()
    begin
        PageGroupNo := 1;
    end;

    trigger OnPreReport()
    begin
        BankAccFilter := "Bank Account".GetFilters;
        DateFilter_BankAccount := "Bank Account".GetFilter("Date Filter");
    end;

    var
        Text000: label 'Period: %1';
        PrintOnlyOnePerPage: Boolean;
        ExcludeBalanceOnly: Boolean;
        BankAccFilter: Text[250];
        DateFilter_BankAccount: Text[30];
        BankAccBalance: Decimal;
        BankAccBalanceLCY: Decimal;
        StartBalance: Decimal;
        StartBalanceLCY: Decimal;
        BankAccLedgEntryExists: Boolean;
        PrintReversedEntries: Boolean;
        PageGroupNo: Integer;
        BankAccDetailTrialBalCapLbl: label 'Bank Acc. - Detail Trial Bal.';
        CurrReportPageNoCaptionLbl: label 'Page';
        RepInclBankAcchavingBalLbl: label 'This report also includes bank accounts that only have balances.';
        BankAccLedgPostingDateCaptionLbl: label 'Posting Date';
        BankAccBalanceCaptionLbl: label 'Balance';
        OpenFormatCaptionLbl: label 'Open';
        BankAccBalanceLCYCaptionLbl: label 'Balance (LCY)';
        ContinuedCaptionLbl: label 'Continued';
        "Payments Mode Filter": Option " ",Cash,Cheque,EFT,"Deposit Slip","Banker's Cheque",RTGS,Custom3;
        "Pay Mode": Option " ",Cash,Cheque,EFT,"Deposit Slip","Banker's Cheque",RTGS,Custom3;


    procedure InitializeRequest(NewPrintOnlyOnePerPage: Boolean; NewExcludeBalanceOnly: Boolean; NewPrintReversedEntries: Boolean)
    begin
        PrintOnlyOnePerPage := NewPrintOnlyOnePerPage;
        ExcludeBalanceOnly := NewExcludeBalanceOnly;
        PrintReversedEntries := NewPrintReversedEntries;
    end;


    procedure GetPaymentMode(DocumentNo: Code[20]): Boolean
    var
        PaymentsHeader: Record "Payments Header";
        ReceiptsLine: Record "Receipt Line";
        ImprestHeader: Record "Imprest Header";
        AdvanceHeader: Record "Staff Advance Header";
        SurrenderHeader: Record "Staff Advance Surrender Header";
    begin
        PaymentsHeader.Reset;
        PaymentsHeader.SetRange(PaymentsHeader."No.", DocumentNo);
        //PaymentsHeader.setrange(PaymentsHeader."Date Posted");
        if PaymentsHeader.FindSet then begin
            "Pay Mode" := PaymentsHeader."Pay Mode";
            exit(true);
        end;

        ReceiptsLine.Reset;
        ReceiptsLine.SetRange(ReceiptsLine.No, DocumentNo);
        //PaymentsHeader.setrange(PaymentsHeader."Date Posted");
        if ReceiptsLine.FindSet then begin
            "Pay Mode" := ReceiptsLine."Pay Mode";
            exit(true);
        end;

        ImprestHeader.Reset;
        ImprestHeader.SetRange(ImprestHeader."No.", DocumentNo);
        //PaymentsHeader.setrange(PaymentsHeader."Date Posted");
        if ImprestHeader.FindSet then begin
            "Pay Mode" := ImprestHeader."Pay Mode";
            exit(true);
        end;

        SurrenderHeader.Reset;
        SurrenderHeader.SetRange(SurrenderHeader.No, DocumentNo);
        //PaymentsHeader.setrange(PaymentsHeader."Date Posted");
        if SurrenderHeader.FindSet then begin
            "Pay Mode" := SurrenderHeader."Pay Mode";
            exit(true);
        end;

        AdvanceHeader.Reset;
        AdvanceHeader.SetRange(AdvanceHeader."No.", DocumentNo);
        //PaymentsHeader.setrange(PaymentsHeader."Date Posted");
        if AdvanceHeader.FindSet then begin
            "Pay Mode" := AdvanceHeader."Pay Mode";
            exit(true);
        end;

        exit(false);
    end;
}
