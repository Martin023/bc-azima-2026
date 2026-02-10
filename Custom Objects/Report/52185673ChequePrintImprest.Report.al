#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185673 "Cheque Print Imprest"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Cheque Print Imprest.rdl';

    dataset
    {
        dataitem("Imprest Header"; "Imprest Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            column(ReportForNavId_6437; 6437)
            {
            }
            column(Date; "Imprest Header"."Payment Release Date")
            {
            }
            column(BankersCheque; "Imprest Header"."Bankers Cheque No")
            {
            }
            column(Payee; "Imprest Header".Payee)
            {
            }
            column(AccountNo; "Imprest Header"."Account No.")
            {
            }
            column(TotalAmount; "Imprest Header"."Total Net Amount")
            {
            }
            // column(NumberText_1_;NumberText[1])
            // {
            // }
            // column(NumberText_2_;NumberText[2])
            // {
            // }
            // column(No;"Imprest Header"."No.")
            // {
            // }
            dataitem("Imprest Lines"; "Imprest Lines")
            {
                column(ReportForNavId_6; 6)
                {
                }
                column(No_ImprestLin; "Imprest Lines".No)
                {
                }
            }

            // trigger OnAfterGetRecord()
            // begin
            //     CheckReport.InitTextVariable();
            //     "Imprest Header".CalcFields("Imprest Header"."Total Net Amount LCY");
            //     CheckReport.FormatNoText(NumberText,(ROUND("Total Net Amount LCY",0.01,'=')),'');
            // end;

            // trigger OnPreDataItem()
            // begin

            //     LastFieldNo := UnknownTable52185909.FieldNo("No.");
            // end;
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
        //                  NumberText: array [2] of Text[200];
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
}
