#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185689 "CashierCredit Deposit Slip"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/CashierCredit Deposit Slip.rdl';

    dataset
    {
        dataitem(Transactions; "Cashier Transactions")
        {
            DataItemTableView = sorting(No);
            RequestFilterFields = No;
            column(ReportForNavId_5806; 5806)
            {
            }
            column(Transactions_Transactions__Book_Balance_; Transactions."Book Balance")
            {
            }
            column(Transactions_No; No)
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
            column(AccountNo; "Account No")
            {
            }
            column(AccountName; "Account Name")
            {
            }
            column(Amount; Amount)
            {
            }
            column(PayrollNo; StaffNo)
            {
            }
            column(Prod_Name; ProductName)
            {
            }
            column(BranchCode; Transactions."Global Dimension 1 Code")
            {
            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {
            }
            column(Branch_Name; "Branch Name")
            {
            }
            column(Transactions__Transaction_Date_; "Transaction Date")
            {
            }
            column(Transactions_Transactions__Transaction_Time_; Transactions."Transaction Time")
            {
            }
            column(Transactions__Cheque_No_; "Cheque No")
            {
            }
            column(Transactions_Type; Type)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(Company_Address; CompanyInfo.Address)
            {
            }
            column(Co_phone; CompanyInfo."Phone No.")
            {
            }
            column(Company_Pic; CompanyInfo.Picture)
            {
            }
            column(Transactions_Transactions_Cashier; Transactions.Cashier)
            {
            }
            column(Amount_WithdrawnCaption; Amount_WithdrawnCaptionLbl)
            {
            }
            column(Book_Balance_Caption; Book_Balance_CaptionLbl)
            {
            }
            column(Transaction_No_Caption; Transaction_No_CaptionLbl)
            {
            }
            column(Account_No_Caption; Account_No_CaptionLbl)
            {
            }
            column(Account_Name_Caption; Account_Name_CaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Time_Caption; Time_CaptionLbl)
            {
            }
            column(Transactions__Cheque_No_Caption; Transactions.FieldCaption("Cheque No"))
            {
            }
            column(Member_No_Caption; Member_No_CaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(Signature_Caption; Signature_CaptionLbl)
            {
            }
            column(I_acknowledge_receipt_of_the_above_amountCaption; I_acknowledge_receipt_of_the_above_amountCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1000000048; EmptyStringCaption_Control1000000048Lbl)
            {
            }
            column(I_D_No_Caption; I_D_No_CaptionLbl)
            {
            }
            column(Availbal; Available_Balance_CaptionLbl)
            {
            }
            column(BookBal_; Book_Balance_Caption_Control1102760006Lbl)
            {
            }
            column(EmptyStringCaption_Control1102756001; EmptyStringCaption_Control1102756001Lbl)
            {
            }
            column(al; Name_CaptionLbl)
            {
            }
            column(Withdrawn_By_______________________________________Caption; Withdrawn_By_______________________________________CaptionLbl)
            {
            }
            column(You_were_served_by__Caption; You_were_served_by__CaptionLbl)
            {
            }
            column(THANK_YOUCaption; THANK_YOUCaptionLbl)
            {
            }
            column(Better_life_for_our_members_globallyCaption; Better_life_for_our_members_globallyCaptionLbl)
            {
            }
            column(Transactions_Transaction_Type; "Transaction Type")
            {
            }
            column(ExpectedMaturityDate; "Expected Maturity Date")
            {
            }
            column(ChequeNo_Transactions; Transactions."Cheque No")
            {
            }
            column(TransactionDescription_Transactions; Transactions."Transaction Description")
            {
            }
            column(Cashier_Transactions; Transactions.Cashier)
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(NumberText; NumberText[1])
            {
            }
            column(SumTransactionCharges; SumTransactionCharges)
            {
            }
            column(AvailableBalance; "Available Balance")
            {
            }
            column(NewAvailable; "Available Balance" - (SumTransactionCharges + Amount))
            {
            }
            column(Dublicate; Transactions.Dublicate)
            {
            }
            column(CashierName; CashierName)
            {
            }
            //MASKED COLUMNS FOR PRIVACY
            column(MaskedAccountNo; MaskedAccountNo)
            {
            }
            column(CashierNameOnly; CashierNameOnly)
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(Reprint; Reprint)
            {
            }
            column(ReprintDate; ReprintDate)
            {
            }
            column(ReprintTime; ReprintTime)
            {
            }

            dataitem("Transaction Charges"; "Transaction Charges")
            {
                DataItemLink = "Transaction Type" = field("Transaction Type");
                column(ReportForNavId_8541; 8541)
                {
                }
                column(Description; Description)
                {
                }
                column(ChAmount; ChAmount)
                {
                }
                column(Transaction_Charges_Transaction_Type; "Transaction Type")
                {
                }
                column(Transaction_Charges_Charge_Code; "Charge Code")
                {
                }
            }
            dataitem("Cashier Transaction Lines"; "Cashier Transaction Lines")
            {
                DataItemLink = "Transaction No" = field(No);
                column(ReportForNavId_5; 5)
                {
                }
                column(CL_Account_no; "Cashier Transaction Lines"."Account No")
                {
                }
                column(CL_MaskedAccountNo; CL_MaskedAccountNo)
                {
                }
                column(CL_Loan_no; "Cashier Transaction Lines"."Loan No")
                {
                }
                column(CL_Amount; "Cashier Transaction Lines".Amount)
                {
                }
                column(CL_TransType; "Cashier Transaction Lines"."Transaction Type")
                {
                }
                column(CSName; CSName)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CL_MaskedAccountNo := '';

                    //Mask transaction line account number
                    if StrLen("Cashier Transaction Lines"."Account No") > 3 then begin
                        CL_MaskedAccountNo := CopyStr("Cashier Transaction Lines"."Account No", 1, 3) + 
                                            PadStr('', StrLen("Cashier Transaction Lines"."Account No") - 3, '*');
                    end else
                        CL_MaskedAccountNo := "Cashier Transaction Lines"."Account No";

                    if "Cashier Transaction Lines".Type = "Cashier Transaction Lines".Type::Credit then begin

                        CSName := '';
                        Credit.Reset;
                        Credit.SetRange(Credit."No.", "Cashier Transaction Lines"."Account No");
                        if Credit.Find('-') then begin
                            CSName := Credit."Product Name";
                        end;
                    end;

                    if "Cashier Transaction Lines".Type = "Cashier Transaction Lines".Type::Savings then begin
                        Savings.Reset;
                        Savings.SetRange("No.", "Cashier Transaction Lines"."Account No");
                        if Savings.Find('-') then begin
                            CSName := Savings."Product Name";
                        end;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                StaffNo := '';
                ProductName := '';
                CashierName := '';
                MaskedAccountNo := '';
                CashierNameOnly := '';

                //FIXED: Use transaction cashier instead of current logged-in user
                user.Reset;
                user.SetRange("User Name", Transactions.Cashier);
                if user.Find('-') then begin
                    CashierName := user."User Name";
                    //Extract name after backslash
                    if StrPos(CashierName, '\') > 0 then
                        CashierNameOnly := CopyStr(CashierName, StrPos(CashierName, '\') + 1)
                    else
                        CashierNameOnly := CashierName;
                end;

                //Mask account number: show first 2 and last 2 digits
                if StrLen("Account No") > 4 then begin
                    MaskedAccountNo := CopyStr("Account No", 1, 2) + 
                                      PadStr('', StrLen("Account No") - 4, '*') + 
                                      CopyStr("Account No", StrLen("Account No") - 1, 2);
                end else
                    MaskedAccountNo := "Account No";
                //calculate the charges
                SavingsLedgerEntry.Reset;
                SavingsLedgerEntry.SetRange("Customer No.", "Account No");
                SavingsLedgerEntry.SetRange("Document No.", No);
                if SavingsLedgerEntry.FindSet then begin
                    SavingsLedgerEntry.CalcSums(Amount);
                    SumTransactionCharges := SavingsLedgerEntry.Amount - Amount;
                    //MESSAGE('the trans charges are %1',SumTransactionCharges);
                end;

                Savings.Reset;
                Savings.SetRange(Savings."No.", Transactions."Account No");
                if Savings.Find('-') then begin
                    StaffNo := Savings."Payroll/Staff No.";
                    ProductName := Savings."Product Name";
                end;

                // ADDED REPRINT LOGIC
                Reprint := '';
                if "Transaction Date" < Today then
                    Reprint := 'REPRINT'
                else if ("Transaction Date" = Today) and ("Transaction Time" <> 0T) then begin
                    if Time > "Transaction Time" then begin
                        if (Time - "Transaction Time") > 60000 then 
                            Reprint := 'REPRINT';
                    end;
                end;
                ReprintDate := Today;
                ReprintTime := Time;

                // GENERATE AMOUNT IN WORDS NATIVELY
                NumberText[1] := ConvertAmountToWords(Amount);
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(CompanyInfo.Picture);
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
        Amount_WithdrawnCaptionLbl: label 'Amount Withdrawn';
        Book_Balance_CaptionLbl: label 'Book Balance:';
        Transaction_No_CaptionLbl: label 'Transaction No.';
        Account_No_CaptionLbl: label 'Account No:';
        Account_Name_CaptionLbl: label 'Account Name:';
        Date_CaptionLbl: label 'Date:';
        Time_CaptionLbl: label 'Time:';
        Member_No_CaptionLbl: label 'Member No:';
        EmptyStringCaptionLbl: label '..........................................................';
        Signature_CaptionLbl: label 'Signature:';
        I_acknowledge_receipt_of_the_above_amountCaptionLbl: label 'I acknowledge receipt of the above amount';
        EmptyStringCaption_Control1000000048Lbl: label '..........................................................';
        I_D_No_CaptionLbl: label 'I/D No.';
        Available_Balance_CaptionLbl: label 'Available Balance:';
        Book_Balance_Caption_Control1102760006Lbl: label 'Book Balance:';
        EmptyStringCaption_Control1102756001Lbl: label '..........................................................';
        Name_CaptionLbl: label 'Name:';
        Withdrawn_By_______________________________________CaptionLbl: label 'Withdrawn By :.....................................';
        You_were_served_by__CaptionLbl: label 'You were served by :';
        THANK_YOUCaptionLbl: label 'THANK YOU';
        Better_life_for_our_members_globallyCaptionLbl: label 'Better life for our members globally';
        CompanyInfo: Record "Company Information";
        //CheckReport: Report Check;
        NumberText: array[2] of Text[120];
        SumTransactionCharges: Decimal;
        ChAmount: Decimal;
        AvailableBalance: Decimal;
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        Savings: Record "Savings Accounts";
        StaffNo: Code[20];
        ProductName: Text[50];
        Credit: Record "Credit Accounts";
        CSName: Text[50];
        CL_MaskedAccountNo: Text; //Masked account for transaction lines
        Copy: Boolean;
        CashierName: Text;
        MaskedAccountNo: Text; //Masked account number (first 2 + stars + last 2)
        CashierNameOnly: Text; //Cashier name without domain prefix
        user: Record User;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        
        // ADDED REPRINT AND WORD VARS
        Reprint: Text;
        ReprintDate: Date;
        ReprintTime: Time;
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];

    local procedure InitTextVariable()
    begin
        OnesText[1] := 'One'; OnesText[2] := 'Two'; OnesText[3] := 'Three'; OnesText[4] := 'Four';
        OnesText[5] := 'Five'; OnesText[6] := 'Six'; OnesText[7] := 'Seven'; OnesText[8] := 'Eight';
        OnesText[9] := 'Nine'; OnesText[10] := 'Ten'; OnesText[11] := 'Eleven'; OnesText[12] := 'Twelve';
        OnesText[13] := 'Thirteen'; OnesText[14] := 'Fourteen'; OnesText[15] := 'Fifteen'; OnesText[16] := 'Sixteen';
        OnesText[17] := 'Seventeen'; OnesText[18] := 'Eighteen'; OnesText[19] := 'Nineteen';
        TensText[1] := ''; TensText[2] := 'Twenty'; TensText[3] := 'Thirty'; TensText[4] := 'Forty';
        TensText[5] := 'Fifty'; TensText[6] := 'Sixty'; TensText[7] := 'Seventy'; TensText[8] := 'Eighty';
        TensText[9] := 'Ninety';
    end;

    local procedure ConvertAmountToWords(AmountToConvert: Decimal): Text
    var
        WholeAmount: Decimal;
        CentsAmount: Decimal;
        Words: Text;
        CentsWords: Text;
    begin
        if AmountToConvert = 0 then exit('Zero');
        WholeAmount := Round(AmountToConvert, 1, '<');
        CentsAmount := Round((AmountToConvert - WholeAmount) * 100, 1, '=');
        InitTextVariable();
        Words := ConvertNumberToText(WholeAmount);
        if CentsAmount > 0 then begin
            CentsWords := ConvertNumberToText(CentsAmount);
            exit(Words + ' And ' + CentsWords + ' Cents Only');
        end;
        exit(Words + ' Only');
    end;

    local procedure ConvertNumberToText(Number: Decimal): Text
    var
        ResultText: Text;
        Millions: Integer;
        Thousands: Integer;
        Hundreds: Integer;
        TensAndOnes: Integer;
    begin
        if Number = 0 then exit('');
        Millions := Round(Number / 1000000, 1, '<');
        Number := Number - (Millions * 1000000);
        Thousands := Round(Number / 1000, 1, '<');
        Number := Number - (Thousands * 1000);
        Hundreds := Round(Number / 100, 1, '<');
        TensAndOnes := Round(Number - (Hundreds * 100), 1, '<');
        ResultText := '';
        if Millions > 0 then ResultText += ConvertHundreds(Millions) + ' Million ';
        if Thousands > 0 then ResultText += ConvertHundreds(Thousands) + ' Thousand ';
        if Hundreds > 0 then ResultText += ConvertHundreds(Hundreds) + ' Hundred ';
        if TensAndOnes > 0 then begin
            if ResultText <> '' then ResultText += 'and ';
            ResultText += ConvertTens(TensAndOnes);
        end;
        exit(DelChr(ResultText, '>', ' '));
    end;

    local procedure ConvertHundreds(Number: Integer): Text
    var
        Hundreds: Integer;
        TensAndOnes: Integer;
        ResultText: Text;
    begin
        Hundreds := Number div 100;
        TensAndOnes := Number mod 100;
        if Hundreds > 0 then begin
            ResultText := OnesText[Hundreds] + ' Hundred';
            if TensAndOnes > 0 then ResultText += ' and ' + ConvertTens(TensAndOnes);
            exit(ResultText);
        end else exit(ConvertTens(TensAndOnes));
    end;

    local procedure ConvertTens(Number: Integer): Text
    begin
        if Number = 0 then exit('');
        if Number < 20 then exit(OnesText[Number]);
        if (Number mod 10) = 0 then exit(TensText[Number div 10])
        else exit(TensText[Number div 10] + ' ' + OnesText[Number mod 10]);
    end;
}