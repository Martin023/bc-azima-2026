#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186406 tableextension52186406 extends "Sales Header"
{
    fields
    {
        field(825; "Authorization Required"; Boolean)
        {
            Caption = 'Authorization Required';
            DataClassification = ToBeClassified;
        }
        field(827; "Credit Card No."; Code[20])
        {
            Caption = 'Credit Card No.';
            DataClassification = ToBeClassified;
            TableRelation = "DO Payment Credit Card" where("Customer No." = field("Bill-to Customer No."));

            trigger OnValidate()
            var
                DOPaymentTransLogEntry: Record "DO Payment Trans. Log Entry";
            begin


                if Rec."Credit Card No." = '' then
                    exit;

                // DOPaymentMgt.CheckCreditCardData(Rec."Credit Card No.");

                // if not DOPaymentMgt.IsValidPaymentMethod(Rec."Payment Method Code") then
                //   Rec.FieldError(Rec."Payment Method Code");
            end;
        }
        field(39005544; Cancelled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39005545; "Cancelled By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39005546; "Cancelled Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(39005547; "Created By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39005548; "Created Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(39005549; "Lease No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39005550; "Refund Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Normal Refund,Waiver Refund,Finance Policy,Vacate Refund,Invoicing Error';
            OptionMembers = " ","Normal Refund","Waiver Refund","Finance Policy","Vacate Refund","Invoicing Error";
        }
        field(39005551; "Waiver Start Date"; Date)
        {

        }
        field(39005552; "Waiver End Date"; Date)
        {

        }
        field(39005553; "Invoice End Date"; Date)
        {
            //Editable = false;
        }
        field(39005554; "Invoice Start Date"; Date)
        {
            trigger OnValidate()
            begin
                if rec.Leases <> '' then
                    SkipAlert(rec.Leases);
                rec.Validate("Frequency Period");
            end;
        }
        field(39005555; "Period Type"; Option)
        {
            OptionCaption = ' ,Days,Weeks,Months,Quaters,Years';
            OptionMembers = " ",Days,Weeks,Months,Quaters,Years;
        }
        field(39005556; Tenor; DateFormula)
        {

            trigger OnValidate()
            begin
                "Invoice End Date" := CalcDate(Tenor, "Invoice Start Date") - 1;
                "Waiver End Date" := CalcDate(Tenor, "Invoice Start Date") - 1;

                CompInfo.Get;
                if NonWorkingDay = true then
                    Message('Expected Date is falling on a non working day');
            end;
        }
        field(39005557; "Frequency Period"; Integer)
        {

            trigger OnValidate()
            var
                Datefom: DateFormula;
            begin

                if "Period Type" = "Period Type"::Days then
                    Evaluate(Datefom, Format("Frequency Period") + 'D');
                if "Period Type" = "Period Type"::Weeks then
                    Evaluate(Datefom, Format("Frequency Period") + 'W');
                if "Period Type" = "Period Type"::Months then
                    Evaluate(Datefom, Format("Frequency Period") + 'M');
                if "Period Type" = "Period Type"::Quaters then
                    Evaluate(Datefom, Format("Frequency Period") + 'Q');
                if "Period Type" = "Period Type"::Years then
                    Evaluate(Datefom, Format("Frequency Period") + 'Y');

                Tenor := Datefom;
                Validate(Tenor);
            end;
        }
        field(39005558; Waived; Boolean)
        {

        }
        field(39005559; Invoiced; Boolean)
        {

        }
        field(39005560; Leases; code[20])
        {
            TableRelation = Lease."No." where("Tenant No." = field("Sell-to Customer No."));
            trigger OnValidate()
            var
                Lease: record Lease;
                Tenor: DateFormula;
            begin
                if Lease.get(Leases) then begin
                    case
                         Lease."Billing Frequency"
                         of
                        Lease."Billing Frequency"::Monthly:
                            begin
                                Evaluate(Tenor, '1M');
                                Rec.Tenor := Tenor;
                                rec."Frequency Period" := 1;
                                Rec."Period Type" := rec."Period Type"::Months
                            end;
                        Lease."Billing Frequency"::Annually:
                            begin
                                Evaluate(Tenor, '1Y');
                                Rec.Tenor := Tenor;
                                rec."Frequency Period" := 1;
                                Rec."Period Type" := rec."Period Type"::Years
                            end;
                        Lease."Billing Frequency"::Quarterly:
                            begin
                                Evaluate(Tenor, '1Q');
                                Rec.Tenor := Tenor;
                                rec."Frequency Period" := 1;
                                Rec."Period Type" := rec."Period Type"::Quaters
                            end;
                        Lease."Billing Frequency"::"Semi Annually":
                            begin
                                Evaluate(Tenor, '6M');
                                Rec.Tenor := Tenor;
                                rec."Frequency Period" := 1;
                                Rec."Period Type" := rec."Period Type"::Months;
                            end;
                    end;
                end;
            end;
        }
        field(39005561; "KRA PIN"; Text[100])
        {
        }
    }

    var
        // DOPaymentTransLogMgt: Codeunit 829;
        DOPaymentMgt: Codeunit "Sales Post Invoice Events";
        NonWorkingDay: Boolean;
        CompInfo: Record "Company Information";

    procedure SkipAlert(LeaseNo: Code[20])
    var
        Lease: Record Lease;
        PostedSalesInv: record "Sales Invoice Header";
        StartDate: Date;
        EndDate: Date;
        LeaseStartDate: Date;
    begin
        EndDate := 0D;
        if Lease.Get(LeaseNo) then begin
            PostedSalesInv.Reset();
            PostedSalesInv.SetFilter("Posting Date", '<>%1', 0D);
            PostedSalesInv.SetRange("Sell-to Customer No.", Lease."Tenant No.");
            // PostedSalesInv.SetRange(Invoiced, true);
            if PostedSalesInv.Find('-') then begin
                case
                     Lease."Billing Frequency"
                     of
                    Lease."Billing Frequency"::Monthly:
                        begin
                            StartDate := Rec."Invoice Start Date";
                            if not (Date2DMY(StartDate, 2) = Date2DMY(Lease."Lease Commence Date", 2)) or not (Date2DMY(StartDate, 3) = Date2DMY(Lease."Lease Commence Date", 3)) then begin
                                EndDate := calcdate('cm-1M', StartDate);
                                StartDate := CalcDate('-cm-1M', StartDate);
                                PostedSalesInv.SetRange("Invoice Start Date", StartDate);
                                //PostedSalesInv.SetRange("Invoice End Date", EndDate);
                                if not PostedSalesInv.FindFirst() then
                                    Dialog.message('There was no invoice for the month of %1 ', EndDate);
                            end;
                        end;

                    Lease."Billing Frequency"::Quarterly:
                        begin
                            StartDate := Rec."Invoice Start Date";
                            if not (Date2DMY(StartDate, 2) = Date2DMY(Lease."Lease Commence Date", 2)) or not (Date2DMY(StartDate, 3) = Date2DMY(Lease."Lease Commence Date", 3)) then begin
                                EndDate := calcdate('cm-1Q', StartDate);
                                StartDate := CalcDate('-cm-1Q', StartDate);
                                PostedSalesInv.SetRange("Invoice Start Date", StartDate);
                                //PostedSalesInv.SetRange("Invoice End Date", EndDate);
                                if not PostedSalesInv.FindFirst() then
                                    Dialog.message('There was no invoice for the Quarter of %1 ', EndDate);
                            end;
                        end;

                    Lease."Billing Frequency"::Annually:
                        begin
                            StartDate := Rec."Invoice Start Date";
                            if not (Date2DMY(StartDate, 2) = Date2DMY(Lease."Lease Commence Date", 2)) or not (Date2DMY(StartDate, 3) = Date2DMY(Lease."Lease Commence Date", 3)) then begin

                                EndDate := calcdate('cm-1Y', StartDate);
                                StartDate := CalcDate('-cm-1Y', StartDate);
                                PostedSalesInv.SetRange("Invoice Start Date", StartDate);
                                //PostedSalesInv.SetRange("Invoice End Date", EndDate);
                                if not PostedSalesInv.FindFirst() then
                                    Dialog.message('There was no invoice for the month of %1 ', EndDate);
                            end;
                        end;

                    Lease."Billing Frequency"::"Semi Annually":
                        begin
                            StartDate := Rec."Invoice Start Date";
                            if not (Date2DMY(StartDate, 2) = Date2DMY(Lease."Lease Commence Date", 2)) or not (Date2DMY(StartDate, 3) = Date2DMY(Lease."Lease Commence Date", 3)) then begin
                                EndDate := calcdate('cm-6M', StartDate);
                                StartDate := CalcDate('-cm-6M', StartDate);
                                PostedSalesInv.SetRange("Invoice Start Date", StartDate);
                                //PostedSalesInv.SetRange("Invoice End Date", EndDate);
                                if not PostedSalesInv.FindFirst() then
                                    Dialog.message('There was no invoice for the month of %1 ', EndDate);
                            end;
                        end;

                end;
            end
            else begin
                case
          Lease."Billing Frequency" of
                    Lease."Billing Frequency"::Monthly:
                        begin
                            StartDate := Rec."Invoice Start Date";
                            EndDate := calcdate('cm-1m', StartDate);
                            if not (Date2DMY(StartDate, 2) = Date2DMY(Lease."Lease Commence Date", 2)) or not (Date2DMY(StartDate, 3) = Date2DMY(Lease."Lease Commence Date", 3)) then
                                Dialog.message('There was no invoice for the month of %1 ', EndDate);
                        end;

                    Lease."Billing Frequency"::Quarterly:
                        begin
                            StartDate := Rec."Invoice Start Date";
                            EndDate := calcdate('cm-1Q', StartDate);
                            if not (Date2DMY(StartDate, 2) = Date2DMY(Lease."Lease Commence Date", 2)) or not (Date2DMY(StartDate, 3) = Date2DMY(Lease."Lease Commence Date", 3)) then
                                Dialog.message('There was no invoice for the last quarter taht ends on %1 ', EndDate);
                        end;

                    Lease."Billing Frequency"::Annually:
                        begin
                            StartDate := Rec."Invoice Start Date";
                            EndDate := calcdate('cm-1Y', StartDate);
                            if not (Date2DMY(StartDate, 2) = Date2DMY(Lease."Lease Commence Date", 2)) or not (Date2DMY(StartDate, 3) = Date2DMY(Lease."Lease Commence Date", 3)) then
                                Dialog.message('There was no invoice for the year that ends on %1 ', EndDate);
                        end;

                    Lease."Billing Frequency"::"Semi Annually":
                        begin
                            StartDate := Rec."Invoice Start Date";
                            EndDate := calcdate('cm-6M', StartDate);
                            if not (Date2DMY(StartDate, 2) = Date2DMY(Lease."Lease Commence Date", 2)) or not (Date2DMY(StartDate, 3) = Date2DMY(Lease."Lease Commence Date", 3)) then
                                Dialog.message('There was no invoice for the period that ends on %1 ', EndDate);
                        end;
                end;
            end;
        end;

    end;

    procedure SetTrackInfoForCancellation()
    var
        CancelledDocument: Record "Cancelled Document";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCreditMemoHeader: Record "Sales Cr.Memo Header";
        CorrectPostedSalesInvoice: Codeunit "Correct Posted Sales Invoice";
        IsHandled: Boolean;
    begin
        if (Rec."Applies-to Doc. Type" = Rec."Applies-to Doc. Type"::" ") and (Rec."Applies-to Doc. No." = '')
            and (Rec."Applies-to ID" <> '') and (Rec."Document Type" = Rec."Document Type"::"Credit Memo") then
            if SetTrackInfoForCancellDocumentsWithAppliesToID() then
                exit;
        if Rec."Applies-to Doc. Type" <> Rec."Applies-to Doc. Type"::Invoice then
            exit;
        SalesInvoiceHeader.SetLoadFields("No.");
        if not SalesInvoiceHeader.Get(Rec."Applies-to Doc. No.") then
            exit;
        SalesCreditMemoHeader.SetLoadFields("Pre-Assigned No.", "Cust. Ledger Entry No.");
        SalesCreditMemoHeader.SetRange("Pre-Assigned No.", Rec."No.");
        if not SalesCreditMemoHeader.FindFirst() then
            exit;
        if IsNotFullyCancelled(SalesCreditMemoHeader) then
            exit;
        IsHandled := false;
        OnSetTrackInfoForCancellationOnBeforeInsertCancelledDocument(SalesCreditMemoHeader, IsHandled);
        if not IsHandled then begin
            CancelledDocument.InsertSalesInvToCrMemoCancelledDocument(SalesInvoiceHeader."No.", SalesCreditMemoHeader."No.");
            // CorrectPostedSalesInvoice.UpdateSalesOrderLineIfExist(SalesCreditMemoHeader."No.");
        end;
    end;

    procedure SetTrackInfoForCancellDocumentsWithAppliesToID() Connected: Boolean
    var
        CancelledDocument: Record "Cancelled Document";
        CustLedgerEntry, ClosedCustLedgerEntry : Record "Cust. Ledger Entry";
        SalesCreditMemoHeader: Record "Sales Cr.Memo Header";
    begin
        Connected := false;
        SalesCreditMemoHeader.SetLoadFields("Pre-Assigned No.");
        SalesCreditMemoHeader.SetRange("Pre-Assigned No.", Rec."No.");
        if SalesCreditMemoHeader.FindFirst() then begin
            CustLedgerEntry.SetLoadFields("Entry No.", "Document No.");
            CustLedgerEntry.Setrange("Document Type", CustLedgerEntry."Document Type"::"Credit Memo");
            CustLedgerEntry.Setrange("Document No.", SalesCreditMemoHeader."No.");
            if CustLedgerEntry.FindFirst() then begin
                ClosedCustLedgerEntry.SetLoadFields("Document No.");
                ClosedCustLedgerEntry.SetRange("Document Type", ClosedCustLedgerEntry."Document Type"::"Invoice");
                ClosedCustLedgerEntry.SetRange("Closed by Entry No.", CustLedgerEntry."Entry No.");
                ClosedCustLedgerEntry.SetAutoCalcFields("Remaining Amt. (LCY)", "Remaining Amount");
                if ClosedCustLedgerEntry.FindFirst() then
                    if (ClosedCustLedgerEntry."Remaining Amt. (LCY)" = 0) and (ClosedCustLedgerEntry."Remaining Amount" = 0) then begin
                        CancelledDocument.InsertSalesInvToCrMemoCancelledDocument(ClosedCustLedgerEntry."Document No.", CustLedgerEntry."Document No.");
                        Connected := true;
                    end;
            end;
        end;
        exit(Connected);
    end;

    procedure IsNotFullyCancelled(var SalesCreditMemoHeader: Record "Sales Cr.Memo Header"): Boolean
    var
        CustLedgerEntry, ClosedCustLedgerEntry : Record "Cust. Ledger Entry";
    begin
        if SalesCreditMemoHeader."Cust. Ledger Entry No." = 0 then
            exit(true);

        CustLedgerEntry.SetLoadFields("Closed by Entry No.");
        if CustLedgerEntry.Get(SalesCreditMemoHeader."Cust. Ledger Entry No.") then begin
            if CustLedgerEntry."Closed by Entry No." = 0 then
                exit(false);
            ClosedCustLedgerEntry.SetLoadFields("Remaining Amt. (LCY)", "Remaining Amount");
            ClosedCustLedgerEntry.SetAutoCalcFields("Remaining Amt. (LCY)", "Remaining Amount");
            if ClosedCustLedgerEntry.Get(CustLedgerEntry."Closed by Entry No.") then
                exit((ClosedCustLedgerEntry."Remaining Amt. (LCY)" <> 0) and (ClosedCustLedgerEntry."Remaining Amount" <> 0));
        end;
    end;

    local procedure OnSetTrackInfoForCancellationOnBeforeInsertCancelledDocument(SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var IsHandled: boolean)
    begin
    end;

    // procedure UpdateSalesOrderLineIfExist(SalesCreditMemoNo: Code[20])
    // var
    //     SalesCrMemoLine: Record "Sales Cr.Memo Line";
    //     SalesInvoiceLine: Record "Sales Invoice Line";
    // begin
    //     SalesCrMemoLine.SetLoadFields("Document No.", Type, "No.", "Appl.-from Item Entry", Quantity, "Variant Code");
    //     SalesCrMemoLine.SetRange("Document No.", SalesCreditMemoNo);
    //     SalesCrMemoLine.SetRange(Type, SalesCrMemoLine.Type::Item);
    //     SalesCrMemoLine.SetFilter("No.", '<>%1', '');
    //     if SalesCrMemoLine.FindSet() then
    //         repeat
    //             SalesCrMemoLine.GetSalesInvoiceLine(SalesInvoiceLine);
    //             if SalesInvoiceLine."Line No." <> 0 then
    //                 UpdateSalesOrderLinesFromCreditMemo(SalesInvoiceLine);
    //         until SalesCrMemoLine.Next() = 0;
    // end;
}
