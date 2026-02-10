#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185789 "IOU - Detail Trial Bal."
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/IOU - Detail Trial Bal..rdl';
    Caption = 'IOU - Detail Trial Bal.';

    dataset
    {
        dataitem(Customer; Customer)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Date Filter";

            column(TodayFormatted; Format(Today))
            {
            }
            column(PeriodCustDatetFilter; StrSubstNo(Text000, CustDateFilter))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(PrintAmountsInLCY; PrintAmountsInLCY)
            {
            }
            column(ExcludeBalanceOnly; ExcludeBalanceOnly)
            {
            }
            column(CustFilterCaption; Customer.TableCaption + ': ' + CustFilter)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(AmountCaption; AmountCaption)
            {
            }
            column(RemainingAmtCaption; RemainingAmtCaption)
            {
            }
            column(No_Cust; Customer."No.")
            {
            }
            column(Name_Cust; Customer.Name)
            {
            }
            column(PhoneNo_Cust; Customer."Phone No.")
            {
                IncludeCaption = true;
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(StartBalanceLCY; StartBalanceLCY)
            {
                AutoFormatType = 1;
            }
            column(StartBalAdjLCY; StartBalAdjLCY)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceLCY; CustBalanceLCY)
            {
                AutoFormatType = 1;
            }
            column(CustLedgerEntryAmtLCY; "Cust. Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding)
            {
                AutoFormatType = 1;
            }
            column(StartBalanceLCYAdjLCY; StartBalanceLCY + StartBalAdjLCY)
            {
                AutoFormatType = 1;
            }
            column(StrtBalLCYCustLedgEntryAmt; StartBalanceLCY + "Cust. Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding)
            {
                AutoFormatType = 1;
            }
            column(CustDetailTrialBalCaption; CustDetailTrialBalCaptionLbl)
            {
            }
            column(PageNoCaption; PageNoCaptionLbl)
            {
            }
            column(AllAmtsLCYCaption; AllAmtsLCYCaptionLbl)
            {
            }
            column(RepInclCustsBalCptn; RepInclCustsBalCptnLbl)
            {
            }
            column(PostingDateCaption; PostingDateCaptionLbl)
            {
            }
            column(DueDateCaption; DueDateCaptionLbl)
            {
            }
            column(BalanceLCYCaption; BalanceLCYCaptionLbl)
            {
            }
            column(AdjOpeningBalCaption; AdjOpeningBalCaptionLbl)
            {
            }
            column(BeforePeriodCaption; BeforePeriodCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(OpeningBalCaption; OpeningBalCaptionLbl)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter"), "Global Dimension 2 Code" = field("Global Dimension 2 Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Date Filter" = field("Date Filter");
                DataItemTableView = sorting("Customer No.", "Posting Date") where(Reversed = const(false));
                column(ReportForNavId_8503; 8503)
                {
                }
                column(PostDate_CustLedgEntry; Format("Cust. Ledger Entry"."Posting Date"))
                {
                }
                column(DocType_CustLedgEntry; "Cust. Ledger Entry"."Document Type")
                {
                    IncludeCaption = true;
                }
                column(DocNo_CustLedgEntry; "Cust. Ledger Entry"."Document No.")
                {
                    IncludeCaption = true;
                }
                column(Desc_CustLedgEntry; "Cust. Ledger Entry".Description)
                {
                    IncludeCaption = true;
                }
                column(CustAmount; CustAmount)
                {
                    AutoFormatExpression = CustCurrencyCode;
                    AutoFormatType = 1;
                }
                column(CustRemainAmount; CustRemainAmount)
                {
                    AutoFormatExpression = CustCurrencyCode;
                    AutoFormatType = 1;
                }
                column(CustEntryDueDate; Format(CustEntryDueDate))
                {
                }
                column(EntryNo_CustLedgEntry; "Cust. Ledger Entry"."Entry No.")
                {
                    IncludeCaption = true;
                }
                column(CustCurrencyCode; CustCurrencyCode)
                {
                }
                column(CustBalanceLCY1; CustBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(ClosedByDocNo; ClosedByDocNo)
                {
                }
                column(CreationDocNo; CreationDocNo)
                {
                }
                dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Cust. Ledger Entry No." = field("Entry No.");
                    DataItemTableView = sorting("Cust. Ledger Entry No.", "Entry Type", "Posting Date") where("Entry Type" = filter("Appln. Rounding" | "Correction of Remaining Amount"));
                    column(ReportForNavId_6942; 6942)
                    {
                    }
                    column(EntryType_DtldCustLedgEntry; Format("Detailed Cust. Ledg. Entry"."Entry Type"))
                    {
                    }
                    column(Correction; Correction)
                    {
                        AutoFormatType = 1;
                    }
                    column(CustBalanceLCY2; CustBalanceLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(ApplicationRounding; ApplicationRounding)
                    {
                        AutoFormatType = 1;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        case "Detailed Cust. Ledg. Entry"."Entry Type" of
                            "Detailed Cust. Ledg. Entry"."entry type"::"Appln. Rounding":
                                ApplicationRounding := ApplicationRounding + "Detailed Cust. Ledg. Entry"."Amount (LCY)";
                            "Detailed Cust. Ledg. Entry"."entry type"::"Correction of Remaining Amount":
                                Correction := Correction + "Detailed Cust. Ledg. Entry"."Amount (LCY)";
                        end;
                        CustBalanceLCY := CustBalanceLCY + "Detailed Cust. Ledg. Entry"."Amount (LCY)";
                    end;

                    trigger OnPreDataItem()
                    begin
                        "Detailed Cust. Ledg. Entry".SetFilter("Detailed Cust. Ledg. Entry"."Posting Date", CustDateFilter);
                        Correction := 0;
                        ApplicationRounding := 0;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    "Cust. Ledger Entry".CalcFields("Cust. Ledger Entry".Amount, "Cust. Ledger Entry"."Remaining Amount", "Cust. Ledger Entry"."Amount (LCY)", "Cust. Ledger Entry"."Remaining Amt. (LCY)");

                    CustLedgEntryExists := true;
                    if PrintAmountsInLCY then begin
                        CustAmount := "Cust. Ledger Entry"."Amount (LCY)";
                        CustRemainAmount := "Cust. Ledger Entry"."Remaining Amt. (LCY)";
                        CustCurrencyCode := '';
                    end else begin
                        CustAmount := "Cust. Ledger Entry".Amount;
                        CustRemainAmount := "Cust. Ledger Entry"."Remaining Amount";
                        CustCurrencyCode := "Cust. Ledger Entry"."Currency Code";
                    end;
                    CustBalanceLCY := CustBalanceLCY + "Cust. Ledger Entry"."Amount (LCY)";
                    if ("Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."document type"::Payment) or ("Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."document type"::Refund) then
                        CustEntryDueDate := 0D
                    else
                        CustEntryDueDate := "Cust. Ledger Entry"."Due Date";

                    ClosedByDocNo := '';
                    //get the document no for the applying document
                    CustLedgEntry1.Reset;
                    CustLedgEntry1.SetRange(CustLedgEntry1."Entry No.", "Cust. Ledger Entry"."Closed by Entry No.");
                    if CustLedgEntry1.FindFirst then
                        ClosedByDocNo := CustLedgEntry1."Document No.";

                    //get the Creation Doc No
                    if PVHeader.Get("Cust. Ledger Entry"."Document No.") then
                        CreationDocNo := PVHeader."Creation Doc No.";
                end;

                trigger OnPreDataItem()
                begin
                    CustLedgEntryExists := false;
                    CurrReport.CreateTotals(CustAmount, "Cust. Ledger Entry"."Amount (LCY)");
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(ReportForNavId_5444; 5444)
                {
                }
                column(Name1_Cust; Customer.Name)
                {
                }
                column(CustBalanceLCY4; CustBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(StartBalanceLCY2; StartBalanceLCY)
                {
                }
                column(StartBalAdjLCY2; StartBalAdjLCY)
                {
                }
                column(CustBalStBalStBalAdjLCY; CustBalanceLCY - StartBalanceLCY - StartBalAdjLCY)
                {
                    AutoFormatType = 1;
                }

                trigger OnAfterGetRecord()
                begin
                    if not CustLedgEntryExists and ((StartBalanceLCY = 0) or ExcludeBalanceOnly) then begin
                        StartBalanceLCY := 0;
                        CurrReport.Skip;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if PrintOnlyOnePerPage then
                    PageGroupNo := PageGroupNo + 1;

                StartBalanceLCY := 0;
                StartBalAdjLCY := 0;
                if CustDateFilter <> '' then begin
                    if Customer.GetRangeMin(Customer."Date Filter") <> 0D then begin
                        Customer.SetRange(Customer."Date Filter", 0D, Customer.GetRangeMin(Customer."Date Filter") - 1);
                        Customer.CalcFields(Customer."Net Change (LCY)");
                        StartBalanceLCY := Customer."Net Change (LCY)";
                    end;
                    Customer.SetFilter(Customer."Date Filter", CustDateFilter);
                    Customer.CalcFields(Customer."Net Change (LCY)");
                    StartBalAdjLCY := Customer."Net Change (LCY)";
                    CustLedgEntry.SetCurrentkey("Customer No.", "Posting Date");
                    CustLedgEntry.SetRange("Customer No.", Customer."No.");
                    CustLedgEntry.SetFilter("Posting Date", CustDateFilter);
                    if CustLedgEntry.Find('-') then
                        repeat
                            CustLedgEntry.SetFilter("Date Filter", CustDateFilter);
                            CustLedgEntry.CalcFields("Amount (LCY)");
                            StartBalAdjLCY := StartBalAdjLCY - CustLedgEntry."Amount (LCY)";
                            "Detailed Cust. Ledg. Entry".SetCurrentkey("Cust. Ledger Entry No.", "Entry Type", "Posting Date");
                            "Detailed Cust. Ledg. Entry".SetRange("Cust. Ledger Entry No.", CustLedgEntry."Entry No.");
                            "Detailed Cust. Ledg. Entry".SetFilter("Entry Type", '%1|%2',
                              "Detailed Cust. Ledg. Entry"."entry type"::"Correction of Remaining Amount",
                              "Detailed Cust. Ledg. Entry"."entry type"::"Appln. Rounding");
                            "Detailed Cust. Ledg. Entry".SetFilter("Posting Date", CustDateFilter);
                            if "Detailed Cust. Ledg. Entry".Find('-') then
                                repeat
                                    StartBalAdjLCY := StartBalAdjLCY - "Detailed Cust. Ledg. Entry"."Amount (LCY)";
                                until "Detailed Cust. Ledg. Entry".Next = 0;
                            "Detailed Cust. Ledg. Entry".Reset;
                        until CustLedgEntry.Next = 0;
                end;
                // CurrReport.PrintonlyIfDetail := ExcludeBalanceOnly or (StartBalanceLCY = 0);
                // CustBalanceLCY := StartBalanceLCY + StartBalAdjLCY
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;
                CurrReport.NewPagePerRecord := PrintOnlyOnePerPage;
                CurrReport.CreateTotals("Cust. Ledger Entry"."Amount (LCY)", StartBalanceLCY, StartBalAdjLCY, Correction, ApplicationRounding);
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
                    field(ShowAmountsInLCY; PrintAmountsInLCY)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show Amounts in LCY';
                    }
                    field(NewPageperCustomer; PrintOnlyOnePerPage)
                    {
                        ApplicationArea = Basic;
                        Caption = 'New Page per Customer';
                    }
                    field(ExcludeCustHaveaBalanceOnly; ExcludeBalanceOnly)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Exclude Customers That Have a Balance Only';
                        MultiLine = true;
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
        CustFilter := Customer.GetFilters;
        CustDateFilter := Customer.GetFilter("Date Filter");
        if PrintAmountsInLCY then begin
            AmountCaption := "Cust. Ledger Entry".FieldCaption("Cust. Ledger Entry"."Amount (LCY)");
            RemainingAmtCaption := "Cust. Ledger Entry".FieldCaption("Cust. Ledger Entry"."Remaining Amt. (LCY)");
        end else begin
            AmountCaption := "Cust. Ledger Entry".FieldCaption("Cust. Ledger Entry".Amount);
            RemainingAmtCaption := "Cust. Ledger Entry".FieldCaption("Cust. Ledger Entry"."Remaining Amount");
        end;
    end;

    var
        Text000: label 'Period: %1';
        CustLedgEntry: Record "Cust. Ledger Entry";
        PrintAmountsInLCY: Boolean;
        PrintOnlyOnePerPage: Boolean;
        ExcludeBalanceOnly: Boolean;
        CustFilter: Text[250];
        CustDateFilter: Text[30];
        AmountCaption: Text[80];
        RemainingAmtCaption: Text[30];
        CustAmount: Decimal;
        CustRemainAmount: Decimal;
        CustBalanceLCY: Decimal;
        CustCurrencyCode: Code[10];
        CustEntryDueDate: Date;
        StartBalanceLCY: Decimal;
        StartBalAdjLCY: Decimal;
        Correction: Decimal;
        ApplicationRounding: Decimal;
        CustLedgEntryExists: Boolean;
        PageGroupNo: Integer;
        CustDetailTrialBalCaptionLbl: label 'IOU - Detail Trial Bal.';
        PageNoCaptionLbl: label 'Page';
        AllAmtsLCYCaptionLbl: label 'All amounts are in LCY';
        RepInclCustsBalCptnLbl: label 'This report also includes staff that only have balances.';
        PostingDateCaptionLbl: label 'Posting Date';
        DueDateCaptionLbl: label 'Due Date';
        BalanceLCYCaptionLbl: label 'Balance (LCY)';
        AdjOpeningBalCaptionLbl: label 'Adj. of Opening Balance';
        BeforePeriodCaptionLbl: label 'Total (LCY) Before Period';
        TotalCaptionLbl: label 'Total (LCY)';
        OpeningBalCaptionLbl: label 'Total Adj. of Opening Balance';
        CustLedgEntry1: Record "Cust. Ledger Entry";
        ClosedByDocNo: Code[20];
        PVHeader: Record "Payments Header";
        CreationDocNo: Code[20];


    procedure InitializeRequest(ShowAmountInLCY: Boolean; SetPrintOnlyOnePerPage: Boolean; SetExcludeBalanceOnly: Boolean)
    begin
        PrintOnlyOnePerPage := SetPrintOnlyOnePerPage;
        PrintAmountsInLCY := ShowAmountInLCY;
        ExcludeBalanceOnly := SetExcludeBalanceOnly;
    end;
}
