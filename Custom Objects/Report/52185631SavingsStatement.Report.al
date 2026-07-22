#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185631 "Savings Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Savings Statement.rdl';

    dataset
    {
        dataitem(SavingsAccounts; "Savings Accounts")
        {
            CalcFields = "Lien Placed", "Uncleared Cheques";
            RequestFilterFields = "No.";
            column(ReportForNavId_2; 2)
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
            column(No_SavingsAccounts; SavingsAccounts."No.")
            {
            }
            column(Name_SavingsAccounts; SavingsAccounts.Name)
            {
            }
            column(MemberNo_SavingsAccounts; SavingsAccounts."Member No.")
            {
            }
            column(SavingsAccountName; SavingsAccountName)
            {
            }
            column(IDNumber_SavingsAccounts; SavingsAccounts."ID No.")
            {
            }
            column(MobilePhoneNo_SavingsAccounts; SavingsAccounts."Mobile Phone No")
            {
            }
            column(County_SavingsAccounts; SavingsAccounts.County)
            {
            }
            column(EMail_SavingsAccounts; SavingsAccounts."E-Mail")
            {
            }
            column(PayrollStaffNo_SavingsAccounts; SavingsAccounts."Payroll/Staff No.")
            {
            }
            column(ProductType_SavingsAccounts; SavingsAccounts."Product Type")
            {
            }
            column(BalanceBF; BalanceBF)
            {
            }
            column(UnclearedCheques_SavingsAccounts; SavingsAccounts."Uncleared Cheques")
            {
            }
            column(LienPlaced_SavingsAccounts; SavingsAccounts."Lien Placed")
            {
            }
            column(AccountBal; AccountBal)
            {
            }
            dataitem(SavingsLedgerEntry; "Savings Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Customer No.", "Posting Date", "Currency Code.") where("Posting Date" = filter(<> 0D), Reversed = filter(false));
                ;

                column(MemberNo_SavingsLedgerEntry; SavingsLedgerEntry."Member No.")
                {
                }
                column(CustomerNo_SavingsLedgerEntry; SavingsLedgerEntry."Customer No.")
                {
                }
                column(PostingDate_SavingsLedgerEntry; SavingsLedgerEntry."Posting Date")
                {
                }
                column(DocumentNo_SavingsLedgerEntry; SavingsLedgerEntry."Document No.")
                {
                }
                column(Description_SavingsLedgerEntry; SavingsLedgerEntry.Description)
                {
                }
                column(DebitAmountLCY_SavingsLedgerEntry; SavingsLedgerEntry."Debit Amount (LCY)")
                {
                }
                column(CreditAmountLCY_SavingsLedgerEntry; SavingsLedgerEntry."Credit Amount (LCY)")
                {
                }
                column(AmountLCY_SavingsLedgerEntry; SavingsLedgerEntry."Amount (LCY)")
                {
                }
                column(SavingsAccountRunBal; SavingsAccountRunBal)
                {
                }
                column(SavingsAccountBal; SavingsAccounts.Balance)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SRBalance += -SavingsLedgerEntry."Amount (LCY)";
                    SavingsAccountRunBal := SRBalance + BalanceBF;
                end;

                trigger OnPreDataItem()
                begin
                    SavingsAccountRunBal := 0;
                    SRBalance := 0;
                    if StartDate = 0D then
                        BalanceBF := 0;
                end;
            }

            trigger OnAfterGetRecord()
            var
                ProductFactory: Record "Product Factory";
                AvailableBal: Decimal;
                TransactionCharges: Record "Transaction Charges";
                ChargeAmount: Decimal;
                TChargeAmount: Decimal;
                TariffDetails: Record "Tiered Charges Lines";
                TCharges: Decimal;
                Temp: Record "Banking User Template";
                Jtemplate: Code[20];
                JBatch: Code[20];
                LineN: Integer;
                GenJLine: Record "Gen. Journal Line";
                JournalPosting: Codeunit "Journal Posting";
                GenSetup: Record "General Set-Up";
            begin
                if StartDate = 0D then StartDate := 0D;
                if EndDate = 0D then EndDate := Today;
                if not GuiAllowed then begin
                    if SavingsAccounts.GetFilter("Date Filter") <> '' then DFilter := SavingsAccounts.GetFilter("Date Filter");

                    if DFilter <> '' then begin
                        if CopyStr(DFilter, 1, 2) = '..' then begin
                            StartDate := 0D;
                            EndDate := SavingsAccounts.GetRangemax("Date Filter");
                        end
                        else begin
                            StartDate := SavingsAccounts.GetRangeMin("Date Filter");
                            EndDate := SavingsAccounts.GetRangemax("Date Filter");
                        end;
                    end
                end;
                AccountBal := 0;
                SavingsAccounts.SetRange(SavingsAccounts."Date Filter", StartDate, EndDate);//CALCDATE('-1D',EndDate));
                SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)");
                //BalanceBF:=SavingsAccounts."Balance (LCY)";



                if StartDate <> 0D then begin
                    SavingsAccounts1.Reset;
                    SavingsAccounts1.SetRange("No.", SavingsAccounts."No.");
                    SavingsAccounts1.SetRange(SavingsAccounts1."Date Filter", 0D, CalcDate('-1D', StartDate));
                    if SavingsAccounts1.FindFirst then begin
                        SavingsAccounts1.CalcFields(SavingsAccounts1."Balance (LCY)");
                        BalanceBF := SavingsAccounts1."Balance (LCY)";
                    end;
                end;

                SavingsAccounts1.Reset;
                SavingsAccounts1.SetRange("No.", SavingsAccounts."No.");
                SavingsAccounts1.SetRange(SavingsAccounts1."Date Filter", 0D, EndDate);
                if SavingsAccounts1.FindFirst then
                    SavingsAccounts1.CalcFields(SavingsAccounts1."Balance (LCY)");
                //BalanceBF:=SavingsAccounts1."Balance (LCY)";



                //**SavingsAccounts.SETRANGE(SavingsAccounts."Date Filter",StartDate,EndDate);
                SavingsAccountName := SavingsAccounts."Product Type" + '-' + SavingsAccounts."Product Name";
                //Get Account Ballance
                SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)", SavingsAccounts."Authorised Over Draft",
                                           SavingsAccounts."Uncleared Cheques", SavingsAccounts."ATM Transactions", SavingsAccounts."Lien Placed");
                if ProductFac.Get(SavingsAccounts."Product Type") then begin
                    AccountBal := (SavingsAccounts1."Balance (LCY)" + SavingsAccounts."Authorised Over Draft") -
                                   (SavingsAccounts."Uncleared Cheques" + SavingsAccounts."ATM Transactions" +
                                    ProductFac."Minimum Balance" + SavingsAccounts."Lien Placed");
                end;
                if StatementCharge then begin
                    GenSetup.Get();
                    Temp.Get(UserId);
                    Temp.TestField(Temp."Cashier Journal Template");
                    Temp.TestField(Temp."Cashier Journal Batch");
                    Jtemplate := Temp."Cashier Journal Template";
                    JBatch := Temp."Cashier Journal Batch";

                    GenJLine.Reset;
                    GenJLine.SetRange(GenJLine."Journal Template Name", Temp."Cashier Journal Template");
                    GenJLine.SetRange(GenJLine."Journal Batch Name", Temp."Cashier Journal Batch");
                    GenJLine.DeleteAll;

                    AvailableBal := 0;
                    SavingsAccounts.SetFilter(SavingsAccounts.Blocked, '%1', SavingsAccounts.Blocked::" ");
                    SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)", SavingsAccounts."Authorised Over Draft",
                                               SavingsAccounts."Uncleared Cheques", SavingsAccounts."ATM Transactions", SavingsAccounts."Lien Placed");

                    FosaAcc.reset;
                    FosaAcc.setrange("Member No.", SavingsAccounts."Member No.");
                    FosaAcc.SetRange("Product Type", '191');
                    if FosaAcc.FindFirst() then begin
                        FosaAccNo := FosaAcc."No.";
                        AvailableBal := FosaAcc.GetAvailableBalance(FosaAcc."No.");
                    

                        if ProductFactory.Get(FosaAcc."Product Type") then begin
                            if StatementType = StatementType::Certified then
                                ProductFactory.TestField(ProductFactory."Certified Statement Charge")
                            else
                                ProductFactory.TestField(ProductFactory."Statement Charge");
                            // AvailableBal := (SavingsAccounts1."Balance (LCY)" + SavingsAccounts."Authorised Over Draft") -
                            //                (SavingsAccounts."Uncleared Cheques" + SavingsAccounts."ATM Transactions" +
                            //                 ProductFactory."Minimum Balance");


                            AccountBal := (BalanceBF + SavingsAccounts."Authorised Over Draft") -
                                        (SavingsAccounts."Uncleared Cheques" + SavingsAccounts."ATM Transactions" +
                                            ProductFactory."Minimum Balance" + SavingsAccounts."Lien Placed");
                        end;
                    end;

                    

                    TCharges := 0;
                    TransactionCharges.Reset;
                    if StatementType = StatementType::Certified then
                        TransactionCharges.SetRange(TransactionCharges."Transaction Type", ProductFactory."Certified Statement Charge")
                    else
                        TransactionCharges.SetRange(TransactionCharges."Transaction Type", ProductFactory."Statement Charge");
                    if TransactionCharges.Find('-') then begin
                    repeat
                        ChargeAmount := 0;
                        if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" then
                            ChargeAmount := (AvailableBal * TransactionCharges."Percentage of Amount") * 0.01
                        else
                            ChargeAmount := TransactionCharges."Charge Amount";

                        if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                            TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                            TariffDetails.Reset;
                            TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                            if TariffDetails.Find('-') then begin
                                repeat
                                    if (AvailableBal >= TariffDetails."Lower Limit") and
                                    (AvailableBal <= TariffDetails."Upper Limit") then begin
                                        if TariffDetails."Use Percentage" then
                                            ChargeAmount := AvailableBal * TariffDetails.Percentage * 0.01
                                        else
                                            ChargeAmount := TariffDetails."Charge Amount";
                                    end;
                                until TariffDetails.Next = 0;
                            end;
                        end;

                        if NumberOfPages > 0 then
                        ChargeAmount := (ChargeAmount * NumberOfPages);                   
                        
                        LineN += 1;
                        GenJLine.Init;
                        GenJLine."Journal Template Name" := Temp."Cashier Journal Template";
                        GenJLine."Journal Batch Name" := Temp."Cashier Journal Batch";
                        GenJLine."Line No." := LineN;
                        GenJLine."Posting Date" := Today;
                        GenJLine."Document No." := CopyStr(('S-FEE_' + SavingsAccounts."No."), 1, 50);
                        GenJLine."External Document No." := SavingsAccounts."No.";
                        GenJLine."Account Type" := GenJLine."account type"::Savings;
                        GenJLine.Validate(GenJLine."Account No.", FosaAccNo);
                        GenJLine.Description := TransactionCharges.Description;
                        GenJLine.Validate(GenJLine.Amount, ChargeAmount);
                        GenJLine."Bal. Account Type" := GenJLine."bal. account type"::"G/L Account";
                        GenJLine.Validate(GenJLine."Bal. Account No.", '');
                        GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", SavingsAccounts."Global Dimension 1 Code");
                        GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", SavingsAccounts."Global Dimension 2 Code");
                        if GenJLine.Amount <> 0 then
                            GenJLine.Insert;
                        
                        LineN += 1;
                        GenJLine.Init;
                        GenJLine."Journal Template Name" := Temp."Cashier Journal Template";
                        GenJLine."Journal Batch Name" := Temp."Cashier Journal Batch";
                        GenJLine."Line No." := LineN;
                        GenJLine."Posting Date" := Today;
                        GenJLine."Document No." := CopyStr(('S-FEE_' + SavingsAccounts."No."), 1, 50);
                        GenJLine."External Document No." := SavingsAccounts."No.";
                        GenJLine."Account Type" := GenJLine."account type"::"G/L Account";
                        GenJLine.Validate(GenJLine."Account No.", TransactionCharges."G/L Account");
                        GenJLine.Description := TransactionCharges.Description;
                        GenJLine.Validate(GenJLine.Amount, -(ChargeAmount));
                        GenJLine."Bal. Account Type" := GenJLine."bal. account type"::"G/L Account";
                        GenJLine.Validate(GenJLine."Bal. Account No.", '');
                        GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", SavingsAccounts."Global Dimension 1 Code");
                        GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", SavingsAccounts."Global Dimension 2 Code");
                        if GenJLine.Amount <> 0 then
                            GenJLine.Insert;

                        TCharges+=ChargeAmount;

                        if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                            (TransactionCharges."Recover Excise Duty" = true) then begin
                            //Excise
                            LineN += 1;
                                GenJLine.Init;
                                GenJLine."Journal Template Name" := Temp."Cashier Journal Template";
                                GenJLine."Journal Batch Name" := Temp."Cashier Journal Batch";
                                GenJLine."Line No." := LineN;
                                GenJLine."Posting Date" := Today;
                                GenJLine."Document No." := CopyStr(('S-FEE_' + SavingsAccounts."No."), 1, 50);
                                GenJLine."External Document No." := SavingsAccounts."No.";
                                GenJLine."Account Type" := GenJLine."account type"::Savings;
                                GenJLine.Validate(GenJLine."Account No.", FosaAccNo);
                                GenJLine.Description := TransactionCharges.Description + ' Excise Duty';
                                GenJLine.Validate(GenJLine.Amount, (TCharges * GenSetup."Excise Duty (%)") * 0.01);
                                GenJLine."Bal. Account Type" := GenJLine."bal. account type"::"G/L Account";
                                GenJLine.Validate(GenJLine."Bal. Account No.", GenSetup."Excise Duty G/L");
                                GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", SavingsAccounts."Global Dimension 1 Code");
                                GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", SavingsAccounts."Global Dimension 2 Code");
                                if GenJLine.Amount <> 0 then
                                    GenJLine.Insert;
                                end;
                            
                    until TransactionCharges.Next = 0;
                end;
                    
                    if AvailableBal >= TCharges then begin
                        

                        GenJLine.Reset;
                        GenJLine.SetRange(GenJLine."Journal Template Name", Temp."Cashier Journal Template");
                        GenJLine.SetRange(GenJLine."Journal Batch Name", Temp."Cashier Journal Batch");
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJLine);

                    end else
                        error('Member has insufficient Balance hence charges Cannot be applied!');

                end;
            end;

            trigger OnPreDataItem()
            begin
                SavingsAccountName := '';
                BalanceBF := 0;
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
                group("Date Filter")
                {
                    field("Start Date:"; StartDate)
                    {
                        ApplicationArea = Basic;
                    }
                    field("End Date:"; EndDate)
                    {
                        ApplicationArea = Basic;
                    }
                }
                group(Control5)
                {
                    field("Charge "; StatementCharge)
                    {
                        ApplicationArea = Basic;
                    }
                    field(StatementType; StatementType)
                    {
                        ApplicationArea = basic;
                    }
                    field(NumberOfPages; NumberOfPages)
                    {
                        Caption = 'Number of Pages To charge';
                        ApplicationArea = Basic;
                    }
                    field("Lien Printing"; AccountwithLien)
                    {
                        ApplicationArea = Basic;
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
        if (StatementCharge = true) and (StatementType = StatementType::Certified) then begin
            if NumberOfPages <= 0 then
                Error('Number of pages to charge must be greater than zero');
        end;
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";

        SavingsAccounts.CalcFields(SavingsAccounts."Lien Placed");
        if SavingsAccounts."Lien Placed" > 0 then begin
            if not AccountwithLien then
                Error(LienErrorTxt);
        end;
    end;

    var
        BalanceBF: Decimal;
        SavingsAccountName: Text;
        SRBalance: Decimal;
        SavingsAccountRunBal: Decimal;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        StartDate: Date;
        EndDate: Date;
        StatementCharge: Boolean;
        StatementType: Option Uncertified,Certified;
        LienErrorTxt: label 'This account has lien attached to it.';
        AccountwithLien: Boolean;
        AccountBal: Decimal;
        ProductFac: Record "Product Factory";
        SavingsAccounts1: Record "Savings Accounts";
        DFilter: Text;
        NumberOfPages : Integer;
        FosaAcc : Record "Savings Accounts";
        FosaAccNo : Code[100];


    procedure PostStatementCharge()
    var
        ProductFactory: Record "Product Factory";
        AvailableBal: Decimal;
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        TCharges: Decimal;
        Temp: Record "Banking User Template";
        Jtemplate: Code[20];
        JBatch: Code[20];
        LineN: Integer;
        GenJLine: Record "Gen. Journal Line";
        JournalPosting: Codeunit "Journal Posting";
    begin
        /*
        AvailableBal:=0;
        SavingsAccounts.SETFILTER(SavingsAccounts.Blocked,'%1',SavingsAccounts.Blocked::" ");
        SavingsAccounts.CALCFIELDS(SavingsAccounts."Balance (LCY)",SavingsAccounts."Authorised Over Draft",
                                   SavingsAccounts."Uncleared Cheques",SavingsAccounts."ATM Transactions");
        
        IF ProductFactory.GET(SavingsAccounts."Product Type") THEN
        ProductFactory.TESTFIELD(ProductFactory."Statement Charge");
        AvailableBal:= (SavingsAccounts."Balance (LCY)" + SavingsAccounts."Authorised Over Draft") -
                       (SavingsAccounts."Uncleared Cheques" + SavingsAccounts."ATM Transactions" +
                        ProductFactory."Minimum Balance");
        
        TCharges:=0;
        TransactionCharges.RESET;
        TransactionCharges.SETRANGE(TransactionCharges."Transaction Type",ProductFactory."Statement Charge");
        IF TransactionCharges.FIND('-') THEN BEGIN
         REPEAT
         ChargeAmount:=0;
         IF TransactionCharges."Charge Type"=TransactionCharges."Charge Type"::"% of Amount" THEN
          ChargeAmount:=(AvailableBal*TransactionCharges."Percentage of Amount")*0.01
         ELSE
          ChargeAmount:=TransactionCharges."Charge Amount";
        
         IF TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::Staggered THEN BEGIN
          TransactionCharges.TESTFIELD(TransactionCharges."Staggered Charge Code");
        
         TariffDetails.RESET;
         TariffDetails.SETRANGE(TariffDetails.Code,TransactionCharges."Staggered Charge Code");
         IF TariffDetails.FIND('-') THEN BEGIN
          REPEAT
          IF (AvailableBal >= TariffDetails."Lower Limit") AND
             (AvailableBal <= TariffDetails."Upper Limit") THEN BEGIN
           IF TariffDetails."Use Percentage" THEN
            ChargeAmount:=AvailableBal*TariffDetails.Percentage*0.01
           ELSE
            ChargeAmount := TariffDetails."Charge Amount";
          END;
          UNTIL TariffDetails.NEXT =0;
         END;
        END;
        
        TChargeAmount+=ChargeAmount;
        UNTIL TransactionCharges.NEXT = 0;
        END;
          TCharges:=TChargeAmount;
        
        
        
          Temp.GET(USERID);
          Temp.TESTFIELD(Temp."Cashier Journal Template"); Temp.TESTFIELD(Temp."Cashier Journal Batch");
          Jtemplate:=Temp."Cashier Journal Template"; JBatch:=Temp."Cashier Journal Batch";
        
          GenJLine.RESET;
          GenJLine.SETRANGE(GenJLine."Journal Template Name",Jtemplate);
          GenJLine.SETRANGE(GenJLine."Journal Batch Name",JBatch);
          GenJLine.DELETEALL;
        
        IF AvailableBal >= TCharges THEN BEGIN
          LineN+=1;
          GenJLine.INIT;
          GenJLine."Journal Template Name":=Jtemplate;
          GenJLine."Journal Batch Name":=JBatch;
          GenJLine."Line No.":=LineN;
          GenJLine."Posting Date":=TODAY;
          GenJLine."Document No.":='S-FEE';
          GenJLine."External Document No.":=SavingsAccounts."Member No.";
          GenJLine."Account Type":=GenJLine."Account Type"::Savings;
          GenJLine.VALIDATE(GenJLine."Account No.",SavingsAccounts."No.");
          GenJLine.Description:=TransactionCharges.Description;
          GenJLine.VALIDATE(GenJLine.Amount,TCharges);
          GenJLine."Bal. Account Type":=GenJLine."Bal. Account Type"::"G/L Account";
          GenJLine.VALIDATE(GenJLine."Bal. Account No.",TransactionCharges."G/L Account");
          GenJLine.VALIDATE(GenJLine."Shortcut Dimension 1 Code",SavingsAccounts."Global Dimension 1 Code");
          GenJLine.VALIDATE(GenJLine."Shortcut Dimension 2 Code",SavingsAccounts."Global Dimension 2 Code");
          IF GenJLine.Amount<>0 THEN
          GenJLine.INSERT;
          END ELSE
          EXIT;
        */

    end;
}
