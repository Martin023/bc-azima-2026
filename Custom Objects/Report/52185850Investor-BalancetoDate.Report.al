#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185850 "Investor - Balance to Date"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Investor - Balance to Date.rdl';
    Caption = 'Customer - Balance to Date';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", Blocked;
            column(ReportForNavId_6836; 6836)
            {
            }
            column(TodayFormatted; Format(Today, 0, 4))
            {
            }
            column(TxtCustGeTranmaxDtFilter; StrSubstNo(Text000, Format(Customer.GetRangemax(Customer."Date Filter"))))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(PrintOnePrPage; PrintOnePrPage)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(PrintAmountInLCY; PrintAmountInLCY)
            {
            }
            column(CustTableCaptCustFilter; Customer.TableCaption + ': ' + CustFilter)
            {
            }
            column(No_Customer; Customer."No.")
            {
            }
            column(Name_Customer; Customer.Name)
            {
            }
            column(PhoneNo_Customer; Customer."Phone No.")
            {
                IncludeCaption = true;
            }
            column(Address_Customer; Customer.Address)
            {
            }
            column(Address2_Customer; Customer."Address 2")
            {
            }
            column(PostCode_Customer; Customer."Post Code")
            {
            }
            column(CustBalancetoDateCaption; CustBalancetoDateCaptionLbl)
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(AllamtsareinLCYCaption; AllamtsareinLCYCaptionLbl)
            {
            }
            column(CustLedgEntryPostingDtCaption; CustLedgEntryPostingDtCaptionLbl)
            {
            }
            column(OriginalAmtCaption; OriginalAmtCaptionLbl)
            {
            }
            column(Name; CI.Name)
            {
            }
            column(Pic; CI.Picture)
            {
            }
            column(Email; CI."E-Mail")
            {
            }
            column(HomePage; CI."Home Page")
            {
            }
            column(FaxNo; CI."Fax No.")
            {
            }
            column(PhoneNo; CI."Phone No.")
            {
            }
            column(Address; CI.Address)
            {
            }
            column(Address2; CI."Address 2")
            {
            }
            column(City; CI.City)
            {
            }
            dataitem(CustLedgEntry3; "Cust. Ledger Entry")
            {
                DataItemTableView = sorting("Entry No.");
                column(ReportForNavId_5082; 5082)
                {
                }
                column(PostingDt_CustLedgEntry; Format(CustLedgEntry3."Posting Date"))
                {
                    IncludeCaption = false;
                }
                column(DocType_CustLedgEntry; CustLedgEntry3."Document Type")
                {
                    IncludeCaption = true;
                }
                column(DocNo_CustLedgEntry; CustLedgEntry3."Document No.")
                {
                    IncludeCaption = true;
                }
                column(Desc_CustLedgEntry; CustLedgEntry3.Description)
                {
                    IncludeCaption = true;
                }
                column(OriginalAmt; OriginalAmt)
                {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                }
                column(EntryNo_CustLedgEntry; CustLedgEntry3."Entry No.")
                {
                    IncludeCaption = true;
                }
                column(CurrencyCode; CurrencyCode)
                {
                }
                column(debitAmt; CustLedgEntry3."Debit Amount (LCY)")
                {
                }
                column(creditAmt; CustLedgEntry3."Credit Amount (LCY)")
                {
                }
                dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Cust. Ledger Entry No." = field("Entry No."), "Posting Date" = field("Date Filter");
                    DataItemTableView = sorting("Cust. Ledger Entry No.", "Posting Date") where("Entry Type" = filter(<> "Initial Entry"));
                    column(ReportForNavId_6942; 6942)
                    {
                    }
                    column(EntType_DtldCustLedgEnt; "Detailed Cust. Ledg. Entry"."Entry Type")
                    {
                    }
                    column(postDt_DtldCustLedgEntry; Format("Detailed Cust. Ledg. Entry"."Posting Date"))
                    {
                    }
                    column(DocType_DtldCustLedgEntry; "Detailed Cust. Ledg. Entry"."Document Type")
                    {
                    }
                    column(DocNo_DtldCustLedgEntry; "Detailed Cust. Ledg. Entry"."Document No.")
                    {
                    }
                    column(Amt; Amt)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(CurrencyCodeDtldCustLedgEntry; CurrencyCode)
                    {
                    }
                    column(EntNo_DtldCustLedgEntry; DtldCustLedgEntryNum)
                    {
                    }
                    column(RemainingAmt; RemainingAmt)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if not PrintUnappliedEntries then
                            if "Detailed Cust. Ledg. Entry".Unapplied then
                                CurrReport.Skip;

                        if PrintAmountInLCY then begin
                            Amt := "Detailed Cust. Ledg. Entry"."Amount (LCY)";
                            CurrencyCode := '';
                        end else begin
                            Amt := "Detailed Cust. Ledg. Entry".Amount;
                            CurrencyCode := "Detailed Cust. Ledg. Entry"."Currency Code";
                        end;
                        if Amt = 0 then
                            CurrReport.Skip;

                        DtldCustLedgEntryNum := DtldCustLedgEntryNum + 1;
                    end;

                    trigger OnPreDataItem()
                    begin
                        DtldCustLedgEntryNum := 0;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    if PrintAmountInLCY then begin
                        CustLedgEntry3.CalcFields(CustLedgEntry3."Original Amt. (LCY)", CustLedgEntry3."Remaining Amt. (LCY)");
                        OriginalAmt := CustLedgEntry3."Original Amt. (LCY)";
                        RemainingAmt := CustLedgEntry3."Remaining Amt. (LCY)";
                        CurrencyCode := '';
                    end else begin
                        CustLedgEntry3.CalcFields(CustLedgEntry3."Original Amount", CustLedgEntry3."Remaining Amount");
                        OriginalAmt := CustLedgEntry3."Original Amount";
                        RemainingAmt := CustLedgEntry3."Remaining Amount";
                        CurrencyCode := CustLedgEntry3."Currency Code";
                    end;

                    CurrencyTotalBuffer.UpdateTotal(
                      CurrencyCode,
                      RemainingAmt,
                      0,
                      Counter1);
                end;

                trigger OnPreDataItem()
                begin
                    CustLedgEntry3.Reset;
                    DtldCustLedgEntry.SetCurrentkey("Customer No.", "Posting Date", "Entry Type");
                    DtldCustLedgEntry.SetRange("Customer No.", Customer."No.");
                    DtldCustLedgEntry.SetRange("Posting Date", CalcDate('<+1D>', MaxDate), 99991231D);
                    DtldCustLedgEntry.SetRange("Entry Type", DtldCustLedgEntry."entry type"::Application);
                    if not PrintUnappliedEntries then
                        DtldCustLedgEntry.SetRange(Unapplied, false);

                    if DtldCustLedgEntry.Find('-') then
                        repeat
                            CustLedgEntry3."Entry No." := DtldCustLedgEntry."Cust. Ledger Entry No.";
                            CustLedgEntry3.Mark(true);
                        until DtldCustLedgEntry.Next = 0;

                    CustLedgEntry3.SetCurrentkey(CustLedgEntry3."Customer No.", CustLedgEntry3.Open);
                    CustLedgEntry3.SetRange(CustLedgEntry3."Customer No.", Customer."No.");
                    CustLedgEntry3.SetRange(CustLedgEntry3.Open, true);
                    CustLedgEntry3.SetRange(CustLedgEntry3."Posting Date", 0D, MaxDate);

                    if CustLedgEntry3.Find('-') then
                        repeat
                            CustLedgEntry3.Mark(true);
                        until CustLedgEntry3.Next = 0;

                    CustLedgEntry3.SetCurrentkey(CustLedgEntry3."Entry No.");
                    CustLedgEntry3.SetRange(CustLedgEntry3.Open);
                    CustLedgEntry3.MarkedOnly(true);
                    CustLedgEntry3.SetRange(CustLedgEntry3."Date Filter", 0D, MaxDate);
                end;
            }
            dataitem(Integer2; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = filter(1 ..));
                column(ReportForNavId_4152; 4152)
                {
                }
                column(CustName; Customer.Name)
                {
                }
                column(TtlAmtCurrencyTtlBuff; CurrencyTotalBuffer."Total Amount")
                {
                    AutoFormatExpression = CurrencyTotalBuffer."Currency Code";
                    AutoFormatType = 1;
                }
                column(CurryCode_CurrencyTtBuff; CurrencyTotalBuffer."Currency Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if Integer2.Number = 1 then
                        OK := CurrencyTotalBuffer.Find('-')
                    else
                        OK := CurrencyTotalBuffer.Next <> 0;
                    if not OK then
                        CurrReport.Break;

                    CurrencyTotalBuffer2.UpdateTotal(
                      CurrencyTotalBuffer."Currency Code",
                      CurrencyTotalBuffer."Total Amount",
                      0,
                      Counter1);
                end;

                trigger OnPostDataItem()
                begin
                    CurrencyTotalBuffer.DeleteAll;
                end;

                trigger OnPreDataItem()
                begin
                    CurrencyTotalBuffer.SetFilter("Total Amount", '<>0');
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if MaxDate = 0D then
                    Error(BlankMaxDateErr);

                Customer.SetRange(Customer."Date Filter", 0D, MaxDate);
                Customer.CalcFields(Customer."Net Change (LCY)", Customer."Net Change");

                if ((PrintAmountInLCY and (Customer."Net Change (LCY)" = 0)) or
                    ((not PrintAmountInLCY) and (Customer."Net Change" = 0)))
                then
                    CurrReport.Skip;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.NewPagePerRecord := PrintOnePrPage;
            end;
        }
        dataitem(Integer3; "Integer")
        {
            DataItemTableView = sorting(Number) where(Number = filter(1 ..));
            column(ReportForNavId_7913; 7913)
            {
            }
            column(CurryCode_CurrencyTtBuff2; CurrencyTotalBuffer2."Currency Code")
            {
            }
            column(TtlAmtCurrencyTtlBuff2; CurrencyTotalBuffer2."Total Amount")
            {
                AutoFormatExpression = CurrencyTotalBuffer2."Currency Code";
                AutoFormatType = 1;
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Integer3.Number = 1 then
                    OK := CurrencyTotalBuffer2.Find('-')
                else
                    OK := CurrencyTotalBuffer2.Next <> 0;
                if not OK then
                    CurrReport.Break;
            end;

            trigger OnPostDataItem()
            begin
                CurrencyTotalBuffer2.DeleteAll;
            end;

            trigger OnPreDataItem()
            begin
                CurrencyTotalBuffer2.SetFilter("Total Amount", '<>0');
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
                    field("Ending Date"; MaxDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Ending Date';
                    }
                    field(PrintAmountInLCY; PrintAmountInLCY)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show Amounts in LCY';
                    }
                    field(PrintOnePrPage; PrintOnePrPage)
                    {
                        ApplicationArea = Basic;
                        Caption = 'New Page per Customer';
                    }
                    field(PrintUnappliedEntries; PrintUnappliedEntries)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Include Unapplied Entries';
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

        CI.Reset;
        CI.Get;
        CI.CalcFields(CI.Picture);
    end;

    var
        Text000: label 'Balance on %1';
        CurrencyTotalBuffer: Record "Currency Total Buffer" temporary;
        CurrencyTotalBuffer2: Record "Currency Total Buffer" temporary;
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        PrintAmountInLCY: Boolean;
        PrintOnePrPage: Boolean;
        CustFilter: Text;
        CustDateFilter: Text[30];
        MaxDate: Date;
        OriginalAmt: Decimal;
        Amt: Decimal;
        RemainingAmt: Decimal;
        Counter1: Integer;
        DtldCustLedgEntryNum: Integer;
        OK: Boolean;
        CurrencyCode: Code[10];
        PrintUnappliedEntries: Boolean;
        CustBalancetoDateCaptionLbl: label 'Customer - Balance to Date';
        CurrReportPageNoCaptionLbl: label 'Page';
        AllamtsareinLCYCaptionLbl: label 'All amounts are in LCY.';
        CustLedgEntryPostingDtCaptionLbl: label 'Posting Date';
        OriginalAmtCaptionLbl: label 'Amount';
        TotalCaptionLbl: label 'Total';
        BlankMaxDateErr: label 'Ending Date must have a value.';
        CI: Record "Company Information";


    procedure InitializeRequest(NewPrintAmountInLCY: Boolean; NewPrintOnePrPage: Boolean; NewPrintUnappliedEntries: Boolean; NewEndingDate: Date)
    begin
        PrintAmountInLCY := NewPrintAmountInLCY;
        PrintOnePrPage := NewPrintOnePrPage;
        PrintUnappliedEntries := NewPrintUnappliedEntries;
        MaxDate := NewEndingDate;
    end;
}
