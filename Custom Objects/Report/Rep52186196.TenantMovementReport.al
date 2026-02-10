namespace MNS.MNS;

using Microsoft.Sales.Customer;
using Microsoft.Foundation.Company;
using Microsoft.Sales.Receivables;
using Microsoft.Bank.Ledger;

report 52186198 "Tenant Movement Report"
{
    ApplicationArea = All;
    Caption = 'Tenant Movement Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-azima-2026/Layout/Tenant Movement.rdl';
    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where("Account Type" = filter(Tenant));
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
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Employer_Code; "Employer Code")
            {
            }
            column(Account_Type; "Account Type")
            {
            }
            column(OpeningBal; OpeningBal)
            {
            }
            column(TotalCredits; TotalCredits)
            {
            }
            column(TotalDebits; TotalDebits)
            {
            }
            column(ClosingBal; ClosingBal)
            {
            }
            column(DateFrom; DateFrom)
            {
            }
            column(ToDate; ToDate)
            {
            }
            column(TotalWHT; TotalWHT)
            {

            }
            trigger OnAfterGetRecord()
            begin
                TotalCredits := 0;
                TotalDebits := 0;

                OpeningBal := GetOpeningBal(Customer."No.", DateFrom);
                ClosingBal := GetClosigBa(Customer."No.", ToDate);

                TotalWHT := 0;

                ReceiptHeader.Reset();
                ReceiptHeader.SetRange(Tenant, Customer."No.");
                ReceiptHeader.SetFilter("Date Posted", '%1', ToDate);
                if ReceiptHeader.Find() then begin
                    ReceiptLine.SetRange(No, ReceiptHeader."No.");
                    ReceiptLine.SetRange("Account No.", ReceiptHeader.Tenant);
                    // ReceiptLine.SetFilter("WHT Amount", '<>0');
                    if ReceiptLine.FindSet() then begin
                        repeat
                            TotalWHT += ReceiptLine."Withholding Tax Amount";
                        until ReceiptLine.Next() = 0;
                    end;
                end;


                CustomerLedgerEntry.reset;
                CustomerLedgerEntry.SetRange("Customer No.", Customer."No.");
                CustomerLedgerEntry.SetRange("Posting Date", DateFrom, ToDate);
                if customerLedgerEntry.FindFirst() then begin
                    repeat
                        CustomerLedgerEntry.CalcFields("Credit Amount (LCY)", "Debit Amount (LCY)");
                        TotalCredits += CustomerLedgerEntry."Credit Amount (LCY)";
                        TotalDebits += CustomerLedgerEntry."Debit Amount (LCY)";
                    until CustomerLedgerEntry.Next = 0;
                end
                else begin
                    TotalCredits := 0;
                    TotalDebits := 0;
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Datefilter)
                {
                    field("From Date"; DateFrom)
                    {
                    }
                    field("To Date"; ToDate)
                    {
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
        DateFrom: Date;
        ToDate: Date;

    trigger OnPreReport()
    begin
        if (DateFrom = 0D) or (ToDate = 0D) then
            Error('Please select the date range');

        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    Var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        CustomerLedgerEntry: record "Cust. Ledger Entry";
        ReceiptLine: Record "Receipt Line";
        TotalWHT: Decimal;
        TotalCredits: Decimal;
        TotalDebits: Decimal;
        OpeningBal: decimal;
        ClosingBal: Decimal;
        TenantReceipt: record "Receipt Line";
        ReceiptHeader: Record "Receipts Header";
        WTax: Decimal;
        CalcRunningAccBalance: Codeunit "Customer Running balalnce";


    procedure GetOpeningBal(CustNo: code[60]; PostingDate: Date): Decimal
    var
        TotalOpen: Decimal;
    begin
        TotalOpen := 0;
        CustomerLedgerEntry.Reset();
        CustomerLedgerEntry.SetRange("Customer No.", CustNo);
        CustomerLedgerEntry.Setfilter("Posting Date", '<%1', PostingDate);
        if CustomerLedgerEntry.FindFirst() then begin
            repeat
                CustomerLedgerEntry.CalcFields("Amount (LCY)");
                TotalOpen += CustomerLedgerEntry."Amount (LCY)";
            until CustomerLedgerEntry.next = 0;
        end;

        exit(TotalOpen);
    end;

    procedure GetClosigBa(CustNo: code[60]; PostingDate: Date): Decimal
    var
        TotalClosing: Decimal;
    begin
        TotalClosing := 0;
        CustomerLedgerEntry.Reset();
        CustomerLedgerEntry.SetRange("Customer No.", CustNo);
        CustomerLedgerEntry.Setfilter("Posting Date", '<=%1', PostingDate);
        if CustomerLedgerEntry.FindLast() then begin
            // repeat
            //     CustomerLedgerEntry.CalcFields("Amount (LCY)");
            //     TotalClosing += CustomerLedgerEntry."Amount (LCY)";
            // until CustomerLedgerEntry.next = 0;
            TotalClosing := CalcRunningAccBalance.GetCustAccBalance(CustomerLedgerEntry);
        end;

        exit(TotalClosing);

    end;

    procedure GetWTaxAtSource(CustNo: code[60]; PostingDate: Date): Decimal
    begin

    end;

}
