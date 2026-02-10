#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186827 "Investment Receipt"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Investment Receipt.rdl';

    dataset
    {
        dataitem("Receipt Header"; "Receipts Header")
        {
            RequestFilterFields = "No.";
            DataItemTableView = where("Customer Type" = filter(Investment));
            column(ReportForNavId_3632; 3632)
            {
            }
            column(No_ReceiptHeader; "Receipt Header"."No.")
            {
            }
            column(Date_ReceiptHeader; "Receipt Header".Date)
            {
            }
            column(CashierName; Cashier)
            {
            }
            column(Cashier_ReceiptHeader; "Receipt Header".Cashier)
            {
            }
            column(DatePosted_ReceiptHeader; "Receipt Header"."Date Posted")
            {
            }
            column(TimePosted_ReceiptHeader; "Receipt Header"."Time Posted")
            {
            }
            column(Posted_ReceiptHeader; "Receipt Header".Posted)
            {
            }
            column(NoSeries_ReceiptHeader; "Receipt Header"."No. Series")
            {
            }
            column(BankCode_ReceiptHeader; "Receipt Header"."Bank Code")
            {
            }
            column(ReceivedFrom_ReceiptHeader; "Receipt Header"."Received From")
            {
            }
            column(OnBehalfOf_ReceiptHeader; "Receipt Header"."On Behalf Of")
            {
            }
            column(AmountRecieved_ReceiptHeader; "Receipt Header"."Amount Recieved")
            {
            }
            column(GlobalDimension1Code_ReceiptHeader; "Receipt Header"."Global Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_ReceiptHeader; "Receipt Header"."Shortcut Dimension 2 Code")
            {
            }
            column(Institution; Institution)
            {
            }
            column(Institution_Name; "Institution Name")
            {
            }
            column(Invested_Amount; "Invested Amount")
            {
            }
            column(PostedBy_ReceiptHeader; "Receipt Header"."Posted By")
            {
            }
            column(PrintNo_ReceiptHeader; "Receipt Header"."Print No.")
            {
            }
            column(Status_ReceiptHeader; "Receipt Header".Status)
            {
            }
            column(ChequeNo_ReceiptHeader; "Receipt Header"."Cheque No.")
            {
            }
            column(NoPrinted_ReceiptHeader; "Receipt Header"."No. Printed")
            {
            }
            column(CreatedBy_ReceiptHeader; "Receipt Header"."Created By")
            {
            }
            column(CreatedDateTime_ReceiptHeader; "Receipt Header"."Created Date Time")
            {
            }
            column(RegisterNo_ReceiptHeader; "Receipt Header"."Register No.")
            {
            }
            column(FromEntryNo_ReceiptHeader; "Receipt Header"."From Entry No.")
            {
            }
            column(ToEntryNo_ReceiptHeader; "Receipt Header"."To Entry No.")
            {
            }
            column(DocumentDate_ReceiptHeader; "Receipt Header"."Document Date")
            {
            }
            column(ResponsibilityCenter_ReceiptHeader; "Receipt Header"."Responsibility Center")
            {
            }
            column(ShortcutDimension3Code_ReceiptHeader; "Receipt Header"."Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code_ReceiptHeader; "Receipt Header"."Shortcut Dimension 4 Code")
            {
            }
            column(Dim3_ReceiptHeader; "Receipt Header".Dim3)
            {
            }
            column(Dim4_ReceiptHeader; "Receipt Header".Dim4)
            {
            }
            column(BankName_ReceiptHeader; "Receipt Header"."Bank Name")
            {
            }
            column(ReceiptType_ReceiptHeader; "Receipt Header"."Receipt Type")
            {
            }
            column(DimensionSetID_ReceiptHeader; "Receipt Header"."Dimension Set ID")
            {
            }
            column(Dim1_ReceiptHeader; "Receipt Header".Dim1)
            {
            }
            column(Dim2_ReceiptHeader; "Receipt Header".Dim2)
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

            column(Dim1Code; GenLedgerSetup."Global Dimension 1 Code")
            {
            }
            column(Dim2Code; GenLedgerSetup."Global Dimension 2 Code")
            {
            }
            dataitem("Receipt Line"; "Receipt Line")
            {
                DataItemLink = No = field("No.");
                DataItemTableView = sorting("Line No.", No) order(ascending);
                column(ReportForNavId_7160; 7160)
                {
                }
                column(No_ReceiptLine; "Receipt Line".No)
                {
                }
                column(Date_ReceiptLine; "Receipt Line".Date)
                {
                }
                column(Type_ReceiptLine; "Receipt Line".Type)
                {
                }
                column(PayMode_ReceiptLine; "Receipt Line"."Pay Mode")
                {
                }
                column(ChequeDepositSlipNo_ReceiptLine; "Receipt Line"."Cheque/Deposit Slip No")
                {
                }
                column(ChequeDepositSlipDate_ReceiptLine; "Receipt Line"."Cheque/Deposit Slip Date")
                {
                }
                column(ChequeDepositSlipType_ReceiptLine; "Receipt Line"."Cheque/Deposit Slip Type")
                {
                }
                column(BankCode_ReceiptLine; "Receipt Line"."Bank Code")
                {
                }
                column(ReceivedFrom_ReceiptLine; "Receipt Line"."Received From")
                {
                }
                column(OnBehalfOf_ReceiptLine; "Receipt Line"."On Behalf Of")
                {
                }
                column(Cashier_ReceiptLine; "Receipt Line".Cashier)
                {
                }
                column(AccountType_ReceiptLine; "Receipt Line"."Account Type")
                {
                }
                column(AccountNo_ReceiptLine; "Receipt Line"."Account No.")
                {
                }
                column(NoSeries_ReceiptLine; "Receipt Line"."No. Series")
                {
                }
                column(AccountName_ReceiptLine; "Receipt Line"."Account Name")
                {
                }
                column(Posted_ReceiptLine; "Receipt Line".Posted)
                {
                }
                column(DatePosted_ReceiptLine; "Receipt Line"."Date Posted")
                {
                }
                column(TimePosted_ReceiptLine; "Receipt Line"."Time Posted")
                {
                }
                column(PostedBy_ReceiptLine; "Receipt Line"."Posted By")
                {
                }
                column(Amount_ReceiptLine; "Receipt Line".Amount)
                {
                }
                column(Remarks_ReceiptLine; "Receipt Line".Remarks)
                {
                }
                column(TransactionName_ReceiptLine; "Receipt Line"."Transaction Name")
                {
                }
                column(BranchCode_ReceiptLine; "Receipt Line"."Branch Code")
                {
                }
                column(AgentCode_ReceiptLine; "Receipt Line"."Agent Code")
                {
                }
                column(Grouping_ReceiptLine; "Receipt Line".Grouping)
                {
                }
                column(GlobalDimension1Code_ReceiptLine; "Receipt Line"."Global Dimension 1 Code")
                {
                }
                column(ShortcutDimension2Code_ReceiptLine; "Receipt Line"."Shortcut Dimension 2 Code")
                {
                }
                column(VAT_ReceiptLine; "Receipt Line"."VAT %")
                {
                }
                column(CurrencyCode_ReceiptLine; "Receipt Line"."Currency Code")
                {
                }
                column(CurrencyFactor_ReceiptLine; "Receipt Line"."Currency Factor")
                {
                }
                column(VATBusPostingGroup_ReceiptLine; "Receipt Line"."VAT Bus. Posting Group")
                {
                }
                column(VATProdPostingGroup_ReceiptLine; "Receipt Line"."VAT Prod. Posting Group")
                {
                }
                column(GenPostingType_ReceiptLine; "Receipt Line"."Gen. Posting Type")
                {
                }
                column(GenBusPostingGroup_ReceiptLine; "Receipt Line"."Gen. Bus. Posting Group")
                {
                }
                column(GenProdPostingGroup_ReceiptLine; "Receipt Line"."Gen. Prod. Posting Group")
                {
                }
                column(VATCalculationType_ReceiptLine; "Receipt Line"."VAT Calculation Type")
                {
                }
                column(VATAmount_ReceiptLine; "Receipt Line"."VAT Amount")
                {
                }
                column(TotalAmount_ReceiptLine; "Receipt Line"."Total Amount")
                {
                }
                column(UserID_ReceiptLine; "Receipt Line"."User ID")
                {
                }
                column(Applyto_ReceiptLine; "Receipt Line"."Apply to")
                {
                }
                column(ApplytoID_ReceiptLine; "Receipt Line"."Apply to ID")
                {
                }
                column(DestGlobalDimension1Code_ReceiptLine; "Receipt Line"."Dest Global Dimension 1 Code")
                {
                }
                column(DestShortcutDimension2Code_ReceiptLine; "Receipt Line"."Dest Shortcut Dimension 2 Code")
                {
                }
                column(LineNo_ReceiptLine; "Receipt Line"."Line No.")
                {
                }
                column(PrintNo_ReceiptLine; "Receipt Line"."Print No.")
                {
                }
                column(Status_ReceiptLine; "Receipt Line".Status)
                {
                }
                column(DepositSlipTime_ReceiptLine; "Receipt Line"."Deposit Slip Time")
                {
                }
                column(TellerID_ReceiptLine; "Receipt Line"."Teller ID")
                {
                }
                column(CustomerPaymentOnAccount_ReceiptLine; "Receipt Line"."Customer Payment On Account")
                {
                }
                column(Select_ReceiptLine; "Receipt Line".Select)
                {
                }
                column(BatchPosted_ReceiptLine; "Receipt Line"."Batch Posted")
                {
                }
                column(TransactionNo_ReceiptLine; "Receipt Line"."Transaction No.")
                {
                }
                column(ChequeDepositSlipBank_ReceiptLine; "Receipt Line"."Cheque/Deposit Slip Bank")
                {
                }
                column(BankAccount_ReceiptLine; "Receipt Line"."Bank Account")
                {
                }
                column(Confirmed_ReceiptLine; "Receipt Line".Confirmed)
                {
                }
                column(Reconciled_ReceiptLine; "Receipt Line".Reconciled)
                {
                }
                column(OrigCashier_ReceiptLine; "Receipt Line"."Orig. Cashier")
                {
                }
                column(Cancelled_ReceiptLine; "Receipt Line".Cancelled)
                {
                }
                column(CancelledBy_ReceiptLine; "Receipt Line"."Cancelled By")
                {
                }
                column(CancelledDate_ReceiptLine; "Receipt Line"."Cancelled Date")
                {
                }
                column(CancelledTime_ReceiptLine; "Receipt Line"."Cancelled Time")
                {
                }
                column(PostDated_ReceiptLine; "Receipt Line"."Post Dated")
                {
                }
                column(ChequeRetrieved_ReceiptLine; "Receipt Line"."Cheque Retrieved")
                {
                }
                column(RegisterNumber_ReceiptLine; "Receipt Line"."Register Number")
                {
                }
                column(FromEntryNo_ReceiptLine; "Receipt Line"."From Entry No")
                {
                }
                column(ToEntryNo_ReceiptLine; "Receipt Line"."To Entry No")
                {
                }
                column(BatchPostedUserID_ReceiptLine; "Receipt Line"."Batch Posted UserID")
                {
                }
                column(BDRegisterNumber_ReceiptLine; "Receipt Line"."BD Register Number")
                {
                }
                column(BDFromNumber_ReceiptLine; "Receipt Line"."BD From Number")
                {
                }
                column(BDToNumber_ReceiptLine; "Receipt Line"."BD To Number")
                {
                }
                column(ReversalBy_ReceiptLine; "Receipt Line"."Reversal By")
                {
                }
                column(ReversalDate_ReceiptLine; "Receipt Line"."Reversal Date")
                {
                }
                column(ReversalTime_ReceiptLine; "Receipt Line"."Reversal Time")
                {
                }
                column(ReversalRegisterNo_ReceiptLine; "Receipt Line"."Reversal Register No.")
                {
                }
                column(ReversalFromEntryNo_ReceiptLine; "Receipt Line"."Reversal From Entry No.")
                {
                }
                column(ReversalToEntryNo_ReceiptLine; "Receipt Line"."Reversal To Entry No.")
                {
                }
                column(Reversed_ReceiptLine; "Receipt Line".Reversed)
                {
                }
                column(AppliestoDocType_ReceiptLine; "Receipt Line"."Applies-to Doc. Type")
                {
                }
                column(AppliestoDocNo_ReceiptLine; "Receipt Line"."Applies-to Doc. No.")
                {
                }
                column(AppliestoID_ReceiptLine; "Receipt Line"."Applies-to ID")
                {
                }
                column(GrantNo_ReceiptLine; "Receipt Line"."Grant No")
                {
                }
                column(InstallmentNumber_ReceiptLine; "Receipt Line"."Installment Number")
                {
                }
                column(NextInstallmentDate_ReceiptLine; "Receipt Line"."Next Installment Date")
                {
                }
                column(DimensionSetID_ReceiptLine; "Receipt Line"."Dimension Set ID")
                {
                }
                column(Donor_ReceiptLine; "Receipt Line".Donor)
                {
                }
                column(LoanNo_ReceiptLine; "Receipt Line"."Loan No.")
                {
                }
                column(TransactionType_ReceiptLine; "Receipt Line"."Transaction Type")
                {
                }
                column(NumberText; NumberText[1])
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                CashierName := '';
                /*
                objLogos.RESET;
                 objLogos.SETRANGE(objLogos.Code,"Receipt Header"."Global Dimension 1 Code");
                IF objLogos.FIND('-') THEN BEGIN
                    objLogos.CALCFIELDS(objLogos.Picture);
                END ELSE BEGIN
                    objLogos.SETRANGE(objLogos.Default,TRUE);
                    objLogos.CALCFIELDS(objLogos.Picture);
                END;
                */
                GenLedgerSetup.Get;
                Amount := Amount + "Receipt Line".Amount;
                CheckReport.InitTextVariable;
                CheckReport.FormatNoText(NumberText, "Receipt Header"."Total Amount", '');
                UserSetup.Reset;
                UserSetup.SetRange("User ID", "Receipt Header".Cashier);
                if UserSetup.Find('-') then begin
                    CashierName := UserSetup."Full Name";
                    //MESSAGE(CashierName);

                end;

            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);
            end;
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
        Chq__Slip_No_CaptionLbl: label 'Chq./Slip No.';
        DescriptionCaptionLbl: label 'Description';
        No_CaptionLbl: label 'No.';
        Received_fromCaptionLbl: label 'Received from';
        Currency_CaptionLbl: label 'Currency:';
        VATCaptionLbl: label 'VAT';
        DateCaptionLbl: label 'Date';
        DepartmentCaptionLbl: label 'Department';
        TotalCaptionLbl: label 'Total';
        Signature___________________Lbl: label '..................................';
        Amount_Incl__VATCaptionLbl: label 'Amount Incl. VAT';
        You_were_served_by_CaptionLbl: label 'You were served by:';
        TimeCaptionLbl: label 'Time';
        Amount_in_wordsCaptionLbl: label 'Amount in words';
        VAT_Amount_CaptionLbl: label 'VAT Amount:';
        Amount_Excl_VATCaptionLbl: label 'Amount Excl VAT';
        Signature_CaptionLbl: label 'Signature:';
        CompanyInfo: Record "Company Information";
        CheckReport: Report Check;
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;

        NumberText: array[2] of Text;
        Amount: Decimal;
        GenLedgerSetup: Record "General Ledger Setup";
        CashierName: Text;
        User: Record User;
        UserSetup: Record "User Setup";
}
