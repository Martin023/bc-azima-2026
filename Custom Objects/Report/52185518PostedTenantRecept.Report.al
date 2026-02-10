#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185518 "Posted Tenant Receipt"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Posted Tenant Receipt.rdl';

    dataset
    {
        dataitem(LeasesBilled; "Leases Billed")
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(No_LeasesBilled; LeasesBilled."No.")
            {
            }
            column(PropertyNo_LeasesBilled; LeasesBilled."Property No.")
            {
            }
            column(BatchNo_LeasesBilled; LeasesBilled."Batch No")
            {
            }
            column(LeasedAmount_LeasesBilled; LeasesBilled."Leased Amount")
            {
            }
            column(LeasedVATAmount_LeasesBilled; LeasesBilled."Leased VAT Amount")
            {
            }
            column(TotalInclVAT_LeasesBilled; LeasesBilled."Total Incl. VAT")
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(LastBillDate; LeasesBilled."Last Bill Date")
            {
            }
            column(NextBillDate; LeasesBilled."Next Bill Date")
            {
            }
            column(BatchNo; LeasesBilled."Batch No")
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        StrCopyText: Text[30];
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        DimVal: Record "Dimension Value";
        DimValName: Text[30];
        TTotal: Decimal;
        // CheckReport: Report Check;
        // NumberText: array [2] of Text[80];
        //                  STotal: Decimal;
        //                  InvoiceCurrCode: Code[10];
        //                  CurrCode: Code[10];
        //                  GLSetup: Record "General Ledger Setup";
        //                  DOCNAME: Text[30];
        //                  VATCaptionLbl: label 'VAT';
        PAYMENT_DETAILSCaptionLbl: label 'PAYMENT DETAILS';
        AMOUNTCaptionLbl: label 'AMOUNT';
        NET_AMOUNTCaptionLbl: label 'AMOUNT';
        W_TAXCaptionLbl: label 'W/TAX';
        Document_No___CaptionLbl: label 'Document No. :';
        Currency_CaptionLbl: label 'Currency:';
        Payment_To_CaptionLbl: label 'Payment To:';
        Document_Date_CaptionLbl: label 'Document Date:';
        Cheque_No__CaptionLbl: label 'Cheque No.:';
        R_CENTERCaptionLbl: label 'R.CENTER CODE';
        PROJECTCaptionLbl: label 'PROJECT CODE';
        TotalCaptionLbl: label 'Total';
        Printed_By_CaptionLbl: label 'Printed By:';
        Amount_in_wordsCaptionLbl: label 'Amount in words';
        EmptyStringCaptionLbl: label '================================================================================================================================================================================================';
        EmptyStringCaption_Control1102755013Lbl: label '================================================================================================================================================================================================';
        Amount_in_wordsCaption_Control1102755021Lbl: label 'Amount in words';
        Printed_By_Caption_Control1102755026Lbl: label 'Printed By:';
        TotalCaption_Control1102755033Lbl: label 'Total';
        Signature_CaptionLbl: label 'Signature:';
        Date_CaptionLbl: label 'Date:';
        Name_CaptionLbl: label 'Name:';
        RecipientCaptionLbl: label 'Recipient';
        CompanyInfo: Record "Company Information";
        BudgetLbl: label 'Budget';
        CreationDoc: Boolean;
        ChequeNo: Code[10];
        UserSetup: Record "User Setup";
        UserName: Text;
}
