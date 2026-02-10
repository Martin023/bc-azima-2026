#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185847 "Billing and Collection"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Billing and Collection.rdl';

    dataset
    {
        dataitem("Property Details"; "Property Details")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(No_PropertyDetails; "Property Details"."No.")
            {
            }
            column(Description_PropertyDetails; "Property Details".Description)
            {
            }
            dataitem(Lease; Lease)
            {
                DataItemLink = "Property No." = field("No.");
                column(ReportForNavId_4; 4)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    /*


                    IF (FromDate=0D) AND (Tdate=0D) THEN
                    ERROR('Date Filters MUST be specified.');
                   //INIT FOR RECEIPTS

                   RENT:=0;
                   DEPOSITS:=0;
                   SCHARGE:=0;
                   VAT:=0;
                   PARKING:=0;
                   LEGAL:=0;
                   WATER:=0;
                   RENTVAT:=0;
                   SIGNAGE:=0;
                   ELCT:=0;
                   EXCESSCHARGE:=0;
                   SERVICE:=0;
                   AMOUNTPAID:=0;

                   PaidReceipts.RESET;
                   PaidReceipts.SETRANGE(PaidReceipts."Lease No",Lease."No.");
                   IF PaidReceipts.FIND('-') THEN BEGIN

                   REPEAT
                   ReceiptHeader.RESET;
                   ReceiptHeader.SETRANGE(ReceiptHeader."No.",PaidReceipts.No);
                   //ReceiptHeader.SETRANGE(ReceiptHeader.Date,DateFilter);
                   IF ReceiptHeader.FIND('-')THEN BEGIN
                   IF (ReceiptHeader.Date>=FromDate) AND (ReceiptHeader.Date<=Tdate) THEN BEGIN
                   RecptLine.RESET;
                   RecptLine.SETRANGE(RecptLine.No,ReceiptHeader."No.");
                   RecptLine.SETFILTER(RecptLine.Posted,FORMAT(TRUE));
                   IF RecptLine.FIND('-')THEN BEGIN
                   //RENT AND RENT VATABLE
                   IF (PaidReceipts."Transaction Code"= '100') OR (PaidReceipts."Transaction Code"= '102') THEN
                   RENT:=RENT+ABS(PaidReceipts."Amount Paid Excl. VAT");
                   //WATER
                   IF (PaidReceipts."Transaction Code"='107') THEN
                   WATER:=WATER+ABS(PaidReceipts."Amount Paid Excl. VAT");

                   //DEPOSITS AMOUNT(rent deposit)
                   IF (PaidReceipts."Transaction Code"='106') OR (PaidReceipts."Transaction Code"='112') OR
                   (PaidReceipts."Transaction Code"='108')OR (PaidReceipts."Transaction Code"='113') THEN
                   DEPOSITS:=DEPOSITS+ABS(PaidReceipts."Amount Paid Excl. VAT");

                   //SERVICE CHARGE AND SERVICE CHARGE VATABLE
                   IF (PaidReceipts."Transaction Code"='101')OR (PaidReceipts."Transaction Code"='103') THEN
                   SCHARGE:=SCHARGE+ABS(PaidReceipts."Amount Paid Excl. VAT");

                   //PARKING AND PARKING EXEMPT
                   IF (PaidReceipts."Transaction Code"='104') OR (PaidReceipts."Transaction Code"='114') THEN
                   PARKING:=PARKING+ABS(PaidReceipts."Amount Paid Excl. VAT");

                   //SIGNAGE
                   IF PaidReceipts."Transaction Code"='109' THEN
                   SIGNAGE:=SIGNAGE+ABS(PaidReceipts."Amount Paid Excl. VAT");

                   //LEGAL
                   IF PaidReceipts."Transaction Code"='111' THEN
                   LEGAL:=LEGAL+ABS(PaidReceipts."Amount Paid Excl. VAT");

                   //ELECTRICITY
                   IF PaidReceipts."Transaction Code"='108' THEN
                   ELCT:=ELCT+ABS(PaidReceipts."Amount Paid Excl. VAT");

                   //EXCESSS SERVICE CHARGE
                   IF PaidReceipts."Transaction Code"='110' THEN
                   EXCESSCHARGE:=EXCESSCHARGE+ABS(PaidReceipts."Amount Paid Excl. VAT");
                   //VAT
                   IF (PaidReceipts."Transaction Code"='100') OR (PaidReceipts."Transaction Code"='101')
                   OR(PaidReceipts."Transaction Code"='104') THEN
                   VAT:=VAT+ABS(PaidReceipts."VAT Amount Paid");
                   END;
                   END;
                   END;
                   UNTIL PaidReceipts.NEXT=0;
                   END;

                   AMOUNTPAID:=RENTVAT+VAT+SERVICE+EXCESSCHARGE+ELCT+SIGNAGE+PARKING+SCHARGE+DEPOSITS+RENT+WATER+LEGAL;

                   //INIT FOR INVOICES
                   RENTINV:=0;
                   VATINV:=0;
                   WATERINV:=0;
                   RENTVATINV:=0;
                   DEPOSITSINV:=0;
                   LEGALINV:=0;
                   SCHARGEINV:=0;
                   PARKINGINV:=0;
                   SIGNAGEINV:=0;
                   ELCTINV:=0;
                   EXCESSCHARGEINV:=0;
                   SERVICEINV:=0;
                   BF:=0;
                   TOTALINVOICE:=0;

                   Cust.RESET;
                   Cust.SETRANGE(Cust."No.",Lease."Tenant No.");
                   IF Cust.FIND('-')THEN BEGIN
                   BF:=0;
                   CustLedg.RESET;
                   CustLedg.SETRANGE(CustLedg."Customer No.",Cust."No.");
                   CustLedg.SETRANGE(CustLedg."Lease No",Lease."No.");
                   //CustLedg.SETRANGE(CustLedg."Posting Date",0D,CALCDATE('-1D',FromDate));
                   IF CustLedg.FIND('-')THEN BEGIN
                   REPEAT
                   IF CustLedg."Posting Date"<FromDate THEN BEGIN
                   BF:=BF+CustLedg.Amount;//Cust."Balance (LCY)";
                   END;
                   UNTIL CustLedg.NEXT =0

                   END;
                   END;

                   PropertyLedgEntry.RESET;
                   PropertyLedgEntry.SETRANGE(PropertyLedgEntry."Customer No.","Tenant No.");
                   PropertyLedgEntry.SETRANGE(PropertyLedgEntry."Lease No",Lease."No.");

                   IF PropertyLedgEntry.FIND('-')THEN BEGIN
                   REPEAT
                   //RENT AND RENT VATABLE
                   PropertyLedgEntry.CALCFIELDS(PropertyLedgEntry.Amount);
                   IF (PropertyLedgEntry."Posting Date">=FromDate) AND (PropertyLedgEntry."Posting Date"<=Tdate) THEN BEGIN
                   IF (PropertyLedgEntry."Transaction Code"='100')OR(PropertyLedgEntry."Transaction Code"='102') THEN
                   RENTINV:=RENTINV+(PropertyLedgEntry.Amount-PropertyLedgEntry."VAT Invoiced");

                   END;

                   //DEPOSITS AMOUNT(Rent Deposit)
                   IF (PropertyLedgEntry."Posting Date">=FromDate) AND (PropertyLedgEntry."Posting Date"<=Tdate) THEN BEGIN
                   IF (PropertyLedgEntry."Transaction Code"='106') OR (PropertyLedgEntry."Transaction Code"='113')THEN
                   DEPOSITSINV:=DEPOSITSINV+(PropertyLedgEntry.Amount);
                   END;
                   //SERVICE CHARGE S/C VATABLE
                   IF (PropertyLedgEntry."Posting Date">=FromDate) AND (PropertyLedgEntry."Posting Date"<=Tdate) THEN BEGIN
                   IF (PropertyLedgEntry."Transaction Code"='101') OR (PropertyLedgEntry."Transaction Code"='103') THEN

                   SCHARGEINV:=SCHARGEINV+(PropertyLedgEntry.Amount-PropertyLedgEntry."VAT Invoiced");
                   END;
                   //PARKING AND PARKING EXEMPT
                   IF (PropertyLedgEntry."Posting Date">=FromDate) AND (PropertyLedgEntry."Posting Date"<=Tdate) THEN BEGIN
                   IF (PropertyLedgEntry."Transaction Code"='104') OR (PropertyLedgEntry."Transaction Code"='114') THEN
                   PARKINGINV:=PARKINGINV+(PropertyLedgEntry.Amount);
                   END;

                   //SIGNAGE
                   IF (PropertyLedgEntry."Posting Date">=FromDate) AND (PropertyLedgEntry."Posting Date"<=Tdate) THEN BEGIN
                   IF PropertyLedgEntry."Transaction Code"='109' THEN
                   SIGNAGEINV:=SIGNAGEINV+(PropertyLedgEntry.Amount);
                   END;

                   //LEGALINV
                   IF (PropertyLedgEntry."Posting Date">=FromDate) AND (PropertyLedgEntry."Posting Date"<=Tdate) THEN BEGIN
                   IF PropertyLedgEntry."Transaction Code"='111' THEN
                   LEGALINV:=LEGALINV+(PropertyLedgEntry.Amount);
                   END;

                   //WATER INVOICE
                   IF (PropertyLedgEntry."Posting Date">=FromDate) AND (PropertyLedgEntry."Posting Date"<=Tdate) THEN BEGIN
                   IF PropertyLedgEntry."Transaction Code"='107' THEN

                   WATERINV:=WATERINV+(PropertyLedgEntry.Amount);
                   END;

                   //EXCESSS SERVICE CHARGE
                   IF (PropertyLedgEntry."Posting Date">=FromDate) AND (PropertyLedgEntry."Posting Date"<=Tdate) THEN BEGIN
                   IF PropertyLedgEntry."Transaction Code"='110' THEN
                   EXCESSCHARGEINV:=EXCESSCHARGEINV+(PropertyLedgEntry.Amount);
                   END;

                   //VAT
                   IF (PropertyLedgEntry."Posting Date">=FromDate) AND (PropertyLedgEntry."Posting Date"<=Tdate) THEN BEGIN
                   IF (PropertyLedgEntry."Transaction Code"='101') OR (PropertyLedgEntry."Transaction Code"='100') OR
                   (PropertyLedgEntry."Transaction Code"='104') THEN
                   VATINV:=VATINV+(PropertyLedgEntry."VAT Invoiced");
                   END;

                   UNTIL PropertyLedgEntry.NEXT=0;
                    END;

                    TOTALINVOICE:=BF+RENTVATINV+VATINV+SERVICEINV+EXCESSCHARGEINV+ELCTINV+SIGNAGEINV+PARKINGINV+SCHARGEINV+DEPOSITSINV+RENTINV+
                    WATERINV+LEGALINV;
                     CurrReport.CREATETOTALS(RENTVATINV,VATINV,SERVICEINV,EXCESSCHARGEINV,ELCTINV);
                     CurrReport.CREATETOTALS(BF,SIGNAGEINV,PARKINGINV,SCHARGEINV,WATERINV,LEGALINV,DEPOSITSINV,RENTINV,TOTALINVOICE);
                     //RECEIPT
                     CurrReport.CREATETOTALS(RENTVAT,VAT,SERVICE,EXCESSCHARGE,ELCT);
                     CurrReport.CREATETOTALS(SIGNAGE,PARKING,SCHARGE,WATER,LEGAL,DEPOSITS,RENT,BALANCE,AMOUNTPAID);
                    BALANCE:=TOTALINVOICE-AMOUNTPAID;
                    *///mki to be opened

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

    var
        Cust: Record Customer;
        "G/LEntry": Record "G/L Entry";
        RENT: Decimal;
        SCHARGE: Decimal;
        PARKING: Decimal;
        SIGNAGE: Decimal;
        ELCT: Decimal;
        SERVICE: Decimal;
        DEPOSITS: Decimal;
        VAT: Decimal;
        EXCESSCHARGE: Decimal;
        RENTINV: Decimal;
        SCHARGEINV: Decimal;
        PARKINGINV: Decimal;
        SIGNAGEINV: Decimal;
        ELCTINV: Decimal;
        SERVICEINV: Decimal;
        DEPOSITSINV: Decimal;
        VATINV: Decimal;
        EXCESSCHARGEINV: Decimal;
        FromDate: Date;
        Tdate: Date;
        CompInfo: Record "Company Information";
        PropertyLedgEntry: Record "Cust. Ledger Entry";
        PaidReceipts: Record "Receipt Line";
        RENTVAT: Decimal;
        RENTVATINV: Decimal;
        BF: Decimal;
        ReceiptHeader: Record "Receipts Header";
        AMOUNTPAID: Decimal;
        TOTALINVOICE: Decimal;
        BALANCE: Decimal;
        CustLedg: Record "Detailed Cust. Ledg. Entry";
        "DetCust.Ledg": Record "Detailed Cust. Ledg. Entry";
        RecptLine: Record "Receipt Line";
        DateFilter: Text[30];
        WATER: Decimal;
        WATERINV: Decimal;
        LEGAL: Decimal;
        LEGALINV: Decimal;
        LBN: Record "Leases Billed";
}
