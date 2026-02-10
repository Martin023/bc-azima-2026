#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186098 "Customer Statement1"
{
    DefaultLayout = RDLC;
    ApplicationArea = Basic, suite;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-kenpipe-2024/Layout/Customer Statement1.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {

            column(KRA_PIN; "KRA PIN")
            {

            }
            column(No_; "No.")
            {

            }
            column(Name; Name)
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


            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                RequestFilterFields = "Customer No.", "Posting Date";
                DataItemLink = "Customer No." = field("No.");
                DataItemTableView = sorting("Posting Date") order(descending);
                column(Posting_Date; "Posting Date")
                {
                }
                column(Customer_No_; "Customer No.")
                {
                }
                column(Customer_Name; "Customer Name")
                {

                }
                column(Document_No_; "Document No.")
                {
                }
                column(Document_Type; "Document Type")
                {
                }
                column(Description; Description)
                {
                }
                column(Global_Dimension_1_Code; "Global Dimension 1 Code")
                {
                }
                column(Global_Dimension_2_Code; "Global Dimension 2 Code")
                {
                }
                column(Amount; Amount)
                {
                }
                column(Debit_Amount; "Debit Amount")
                {
                }
                column(Credit_Amount; "Credit Amount")
                {
                }
                column(RunningBalance; GetCustBalance("Cust. Ledger Entry"))
                {
                }
                column(User_ID; "User ID")
                {
                }
                column(Document_Date; "Document Date")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    // Building := '';
                    // Floor := '';
                    // Unit := '';
                    // KRAPin := '';

                    // Lease.Reset();
                    // Lease.SetRange("Tenant No.", "Customer No.");
                    // if Lease.FindFirst() then begin
                    //     Building := Lease."Property Name";
                    //     Floor := Lease."Floor Name";
                    //     Unit := Lease."Unit Code";
                    // end;

                    // Customer.Reset();
                    // Customer.SetRange("No.", "Customer No.");
                    // if Customer.FindFirst() then begin
                    //     KRAPin := Customer."KRA PIN";
                    // end;


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
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;

    procedure GetCustBalance(var CustLedgerEntry: Record "Cust. Ledger Entry"): Decimal
    var
        RunningBalance: Decimal;
        RunningBalanceLCY: Decimal;
    begin
        CalcCustBalance(CustLedgerEntry, RunningBalance, RunningBalanceLCY);
        exit(RunningBalance);
    end;



    local procedure CalcCustBalance(var CustLedgerEntry: Record "Cust. Ledger Entry"; var RunningBalance: Decimal; var RunningBalanceLCY: Decimal)
    var
        DateTotal: Decimal;
        DateTotalLCY: Decimal;
        CustLedgerEntry2: Record "Detailed Cust. Ledg. Entry";
        DayTotals: Dictionary of [Date, Decimal];
        DayTotalsLCY: Dictionary of [Date, Decimal];
        PrevTableID: Integer;
        PrevAccNo: Code[20];
        EntryValues: Dictionary of [Integer, Decimal];
        EntryValuesLCY: Dictionary of [Integer, Decimal];
        PrevHighestEntryNo: Integer;
    begin
        if (PrevTableID <> 0) and (PrevTableID <> Database::"Cust. Ledger Entry") or
           (PrevAccNo <> '') and (PrevAccNo <> CustLedgerEntry."Customer No.")
        then begin
            Clear(DayTotals);
            Clear(DayTotalsLCY);
            Clear(EntryValues);
            Clear(EntryValuesLCY);
            Clear(PrevHighestEntryNo);
        end;
        PrevTableID := Database::"Cust. Ledger Entry";
        PrevAccNo := CustLedgerEntry."Customer No.";

        if EntryValues.Get(CustLedgerEntry."Entry No.", RunningBalance) and EntryValuesLCY.Get(CustLedgerEntry."Entry No.", RunningBalanceLCY) then
            exit;

        CustLedgerEntry2.Reset();
        CustLedgerEntry2.SetLoadFields("Entry No.", "Customer No.", "Posting Date", Amount, "Amount (LCY)");
        CustLedgerEntry2.SetRange("Customer No.", CustLedgerEntry."Customer No.");
        if not (DayTotals.Get(CustLedgerEntry."Posting Date", DateTotal) and DayTotalsLCY.Get(CustLedgerEntry."Posting Date", DateTotalLCY)) then begin
            CustLedgerEntry2.SetFilter("Posting Date", '<=%1', CustLedgerEntry."Posting Date");
            CustLedgerEntry2.CalcSums(Amount, "Amount (LCY)");
            DateTotal := CustLedgerEntry2.Amount;
            DateTotalLCY := CustLedgerEntry2."Amount (LCY)";
            DayTotals.Add(CustLedgerEntry."Posting Date", DateTotal);
            DayTotalsLCY.Add(CustLedgerEntry."Posting Date", DateTotalLCY);
        end;
        CustLedgerEntry2.SetRange("Posting Date", CustLedgerEntry."Posting Date");
        CustLedgerEntry2.SetFilter("Entry No.", '>%1', CustLedgerEntry."Entry No.");
        CustLedgerEntry2.CalcSums(Amount, "Amount (LCY)");
        RunningBalance := DateTotal - CustLedgerEntry2.Amount;
        RunningBalanceLCY := DateTotalLCY - CustLedgerEntry2."Amount (LCY)";
        EntryValues.Add(CustLedgerEntry."Entry No.", RunningBalance);
        EntryValuesLCY.Add(CustLedgerEntry."Entry No.", RunningBalanceLCY);
        if PrevHighestEntryNo < CustLedgerEntry."Entry No." then
            PrevHighestEntryNo := CustLedgerEntry."Entry No.";
    end;
}
