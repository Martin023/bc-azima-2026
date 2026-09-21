#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52187388 "Fosa Voucher Print"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Payment Voucher Print.rdl';

    dataset
    {
        dataitem("Fosa Payments Header"; "Fosa Payments Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";

            column(DOCNAME; DOCNAME) { }
            column(Payments_Header__No__; "No.") { }
            column(UserName; UserName) { }
            column(CurrCode; CurrCode) { }
            column(StrCopyText; StrCopyText) { }
            column(Payments_Header__Cheque_No__; "Cheque No.") { }
            column(Payments_Header_Payee; Payee) { }
            column(Account_Type; "Account Type") { }
            column(Account_No_; "Account No.") { }
            column(Payment_Narration; "Payment Narration") { }
            column(Date_Posted; "Date Posted") { }
            column(Total_Payment_Amount; "Total Payment Amount") { }
            column(WithHoldingTax; "Total Witholding Tax Amount") { }
            column(NetAmountLCY; "Total Payment Amount LCY") { }
            column(Payments_Header__Payments_Header__Date; "Fosa Payments Header".Date) { }
            column(Payments_Header__Global_Dimension_1_Code_; "Global Dimension 1 Code") { }
            column(Payments_Header__Shortcut_Dimension_2_Code_; "Shortcut Dimension 2 Code") { }
            column(USERID; UserId) { }
            column(NumberText_1_; NumberText[1]) { }
            column(TTotal; TTotal) { }
            
            column(CompanyInfoName; CompanyInformation.Name) { }
            column(CompanyInfoAddress; CompanyAddress) { }
            column(CompanyTelephone; CompanyTelephone) { }
            column(CommunicationOnline; CommunicationOnline) { }
            column(CompanyInfoPic; CompanyInformation.Picture) { }
            
            column(PrintDateTime; Format(CurrentDateTime, 0, '<Day,2>/<Month,2>/<Year4> <Hours24,2>:<Minutes,2>')) { }

            column(Bank; "Fosa Payments Header"."Paying Bank Account") { }
            column(BankName; "Fosa Payments Header"."Bank Name") { }
            column(PayMode; "Fosa Payments Header"."Pay Mode") { }
            column(CreationDocNo_PaymentsHeader; "Fosa Payments Header"."Creation Doc No.") { }
            column(CreationDoc; CreationDoc) { }
            column(PreparedBy; "Fosa Payments Header".Cashier) { }
            column(ApprovedBy; "Fosa Payments Header"."Approved By") { }

            dataitem("FOSA Payment Line"; "FOSA Payment Line")
            {
                DataItemLink = No = field("No.");
                DataItemTableView = sorting("Line No.", No, Type) order(ascending);
                
                column(Payment_Line__Net_Amount__; "Net Amount") { }
                column(Payment_Line_Amount; Amount) { }
                column(AccountNo_PaymentLine; "FOSA Payment Line"."Account No.") { }
                column(AccountName_PaymentLine; "FOSA Payment Line"."Account Name") { }
                column(Payment_Line__Withholding_Tax_Amount_; "Withholding Tax Amount") { }
                column(Payment_Line__VAT_Amount_; "VAT Amount") { }
                column(Payment_Line__Global_Dimension_1_Code_; "Global Dimension 1 Code") { }
                column(Payment_Line__Shortcut_Dimension_2_Code_; "Shortcut Dimension 2 Code") { }
                column(Payment_Line_Line_No_; "Line No.") { }
                column(Payment_Line_No; No) { }
                column(Description; Description) { }
                column(Payment_Line_Type; Type) { }
                column(AppliestoDocNo_PaymentLine; "FOSA Payment Line"."Applies-to Doc. No.") { }
                column(AppliestoID_PaymentLine; "FOSA Payment Line"."Applies-to ID") { }
                column(CurrencyCode_PaymentLine; "FOSA Payment Line"."Currency Code") { }
                column(VATWithholdingAmount; "FOSA Payment Line"."VAT Withholding Amount") { }

                trigger OnAfterGetRecord()
                begin
                    DimVal.Reset;
                    DimVal.SetRange(DimVal."Dimension Code", 'DEPARTMENT');
                    DimVal.SetRange(DimVal.Code, "Shortcut Dimension 2 Code");
                    DimValName := '';
                    if DimVal.FindFirst then begin
                        DimValName := DimVal.Name;
                    end;
                    TTotal := TTotal + "Net Amount";
                end;
            }

            trigger OnAfterGetRecord()
            begin
                StrCopyText := '';
                ChequeNo := '';
                if "No. Printed" >= 1 then begin
                    StrCopyText := 'DUPLICATE';
                end;
                TTotal := 0;

                if "Fosa Payments Header"."Payment Type" <> "Fosa Payments Header"."payment type"::"Petty Cash" then
                    DOCNAME := 'PAYMENT VOUCHER'
                else
                    DOCNAME := 'PETTY CASH VOUCHER';
                if "Fosa Payments Header"."Cheque No." <> '' then
                    ChequeNo := "Fosa Payments Header"."Cheque No."
                else
                    ChequeNo := "Fosa Payments Header"."Bankers Cheque No";
                
                GLSetup.Get();
                if "Fosa Payments Header"."Currency Code" = '' then begin
                    CurrCode := GLSetup."LCY Code";
                end else
                    CurrCode := "Fosa Payments Header"."Currency Code";

                if "Fosa Payments Header"."Invoice Currency Code" = '' then begin
                    InvoiceCurrCode := GLSetup."LCY Code";
                end else
                    InvoiceCurrCode := "Fosa Payments Header"."Invoice Currency Code";

                "Fosa Payments Header".CalcFields("Total Payment Amount", "Total Witholding Tax Amount");
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, ("Total Payment Amount" - "Total Witholding Tax Amount"), '');

                if "Fosa Payments Header"."Creation Doc No." = '' then
                    CreationDoc := false
                else
                    CreationDoc := true;
                    
                UserSetup.Reset;
                UserSetup.SetRange("User ID", "Fosa Payments Header".Cashier);
                if UserSetup.Find('-') then
                    UserName := UserSetup."Full Name";
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout { }
        actions { }
    }

    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(Picture);
            
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        StrCopyText: Text[30];
        DimVal: Record "Dimension Value";
        DimValName: Text[30];
        TTotal: Decimal;
        CheckReport: Report Check;
        NumberText: array[2] of Text[80];
        InvoiceCurrCode: Code[10];
        CurrCode: Code[10];
        GLSetup: Record "General Ledger Setup";
        DOCNAME: Text[30];
        CreationDoc: Boolean;
        ChequeNo: Code[50];
        UserSetup: Record "User Setup";
        UserName: Text;
}