#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52187384 "Generate Selectively"
{
    ProcessingOnly = true;
    dataset
    {

        dataitem(SavingsInterestHeader; "Savings Interest Header")
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                intProgressI += 1;


                SavingsInterestHeader.TestField(Posted, false);
                SavingsInterestHeader.TestField("Start Date");
                SavingsInterestHeader.TestField("End Date");
                SavingsInterestHeader.TestField(Description);
                SavingsInterestHeader.TestField("Responsibility Center");
                SavingsInterestHeader.TestField("Shortcut Dimension 1 Code");
                SavingsInterestHeader.TestField("Document No.");
                SavingsInterestHeader.TestField("Shortcut Dimension 2 Code");

                AsAt := SavingsInterestHeader."Start Date";
                //Turn := 0;
                IntDays := 0;
                //RIntDays := 0;
                MonthDays := 0;
                StartDate := SavingsInterestHeader."Start Date";
                EndDate := SavingsInterestHeader."End Date";

                if not Confirm(MSGConfirmation, true, SavingsInterestHeader."Start Date", SavingsInterestHeader."End Date") then
                    CurrReport.skip;
                //Delete entries
                InterestBuffer2.Reset;
                InterestBuffer2.SetRange(InterestBuffer2.No, SavingsInterestHeader."No.");
                if InterestBuffer2.Find('-') then
                    InterestBuffer2.DeleteAll;

                Evaluate(FromDateS, Format(SavingsInterestHeader."Start Date"));
                Evaluate(ToDateS, Format(SavingsInterestHeader."End Date"));
                //DateFilter := '..' + ToDateS;
                MonthDays := (CalcDate('<CM>', SavingsInterestHeader."Start Date")) - (CalcDate('<-CM>', SavingsInterestHeader."Start Date") + 1)
            end;

            trigger OnPreDataItem()
            begin
                intProgressTotal := COUNT;

                intProgressI := 0;
                TimeProgress := TIME;
                NoOfRecsProgress := intProgressTotal DIV 100;
                NoOfProgressed := 0;

                diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
            end;
        }
        dataitem(SavingsAccounts; "Savings Accounts")
        {
            CalcFields = "Balance (LCY)", Balance;
            RequestFilterFields = "No.", "Employer Code", "Product Type";
            //DataItemLink = "Product Type" = field("Product ID");
            trigger OnAfterGetRecord()
            begin
                DateFilter := '..' + Format(ToDateS);
                SavingsAccounts.SetFilter("Date Filter", DateFilter);
                SavingsAccounts.CalcFields(Balance, "Net Change (LCY)", "Balance (LCY)");
                if SavingsAccounts.Balance > 0 then begin//BAL>0
                    Turn := 0;
                    IntDays := (SavingsInterestHeader."End Date" - SavingsInterestHeader."Start Date") + 1;
                    //RIntDays := IntDays;
                    if Productfactory.get(SavingsAccounts."Product Type") then begin
                        LowestBal := 0;
                        InterestRate := ProductFactory."Interest Rate (Min.)";
                        PayableAccount := ProductFactory."Interest Payable Account";
                        ExpenseAccount := ProductFactory."Interest Expense Account";
                        repeat
                            IntDays := IntDays - 1;
                            DateFilter2 := '..' + Format(AsAt);
                            SavingsAccounts.SetFilter(SavingsAccounts."Date Filter", DateFilter2);
                            SavingsAccounts.CalcFields(SavingsAccounts."Net Change (LCY)", SavingsAccounts."Balance (LCY)");
                            // Account.Reset;
                            // Account.SetRange(Account."No.", SavingsAccounts."No.");
                            // Account.SetFilter(Account."Date Filter", DateFilter2);
                            // if Account.Find('-') then begin//Account found

                            Bal := SavingsAccounts."Net Change (LCY)";
                            // MESSAGE('Bal is %1',Bal);
                            if SavingsAccounts."Net Change (LCY)" >= ProductFactory."Interest Calc Min Balance" then begin // Balalnce is greater then bal in Product
                                IntRate := ProductFactory."Interest Rate (Min.)";
                                if Turn = 0 then
                                    LowestBal := Bal//Account."Net Change (LCY)"
                                else
                                    if LowestBal > Bal/*Account."Net Change (LCY)"*/ then
                                        LowestBal := Bal;//Account."Net Change (LCY)";
                                                         //  MESSAGE('Lowest Bal %1',LowestBal);
                            end else begin
                                LowestBal := 0;
                            end;

                            if LowestBal = 0 then exit;

                            Turn += 1;
                            AsAt := CalcDate('1D', AsAt);
                        until IntDays = 0;
                        //**************************************************************************************************************************************
                        InterestBuffer.Init;
                        InterestBuffer.No := SavingsInterestHeader."No.";
                        InterestBuffer."Account No" := SavingsAccounts."No.";
                        InterestBuffer.Name := SavingsAccounts.Name;
                        InterestBuffer."Account Type" := InterestBuffer."account type"::Savings;
                        InterestBuffer."Bal. Account Type" := InterestBuffer."bal. account type"::"G/L Account";
                        InterestBuffer."Payable Account" := PayableAccount;
                        InterestBuffer."Expense Account" := ExpenseAccount;
                        InterestBuffer."Account Balance" := LowestBal;//SavingsAccounts.Balance;
                        InterestBuffer.Blocked := SavingsAccounts.Blocked;
                        InterestBuffer.Description := SavingsInterestHeader.Description;
                        InterestBuffer."Interest Date" := CalcDate('<CM>', SavingsInterestHeader."Start Date");
                        InterestBuffer."Interest Rate" := InterestRate;
                        InterestBuffer."Interest Amount" := LowestBal/*SavingsAccounts.Balance*/* ((InterestRate * MonthDays) / 36500);
                        InterestBuffer."Product Factory Code" := Productfactory."Product ID";
                        InterestBuffer."Shortcut Dimension 1 Code" := SavingsAccounts."Global Dimension 1 Code";
                        InterestBuffer."Shortcut Dimension 2 Code" := SavingsAccounts."Global Dimension 2 Code";
                        InterestBuffer."User ID" := UserId;
                        if InterestBuffer."Interest Amount" <> 0 then
                            InterestBuffer.Insert(true);
                    end;
                end;

                IF (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) THEN BEGIN
                    NoOfProgressed := NoOfProgressed + intProgressI;
                    diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                    intProgressI := 0;
                    TimeProgress := TIME;
                END;
            end;

            // trigger OnPreDataItem()
            // begin
            //     SavingsAccounts.Reset();
            //     DateFilter := '..' + ToDateS;
            //     SavingsAccounts.SetFilter("Date Filter", DateFilter);
            // end;


        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {


            }
        }
    }

    trigger Onprereport()
    begin
        // if ToDateS = 0D then
        //     error('You must input the Start Date.');




    end;

    var
        RunLoan: Boolean;
        SimulatedTodaysDate: Date;
        ProgressWindow: Dialog;
        Counter: Integer;
        DaysInArrears: Decimal;
        SimulatedDaysInArreas: Integer;
        SavingsAccountNo: Code[50];
        ProductId: Code[10];
        EndDate: Date;
        EmpCode: Code[20];
        Productfactory: Record "Product Factory";
        InterestRate: Decimal;
        PayableAccount: Code[20];
        ExpenseAccount: Code[20];
        BankingUserTemplate: Record "Banking User Template";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        JTemp: Code[20];
        JBatch: Code[20];
        PageEditable: Boolean;
        //Members: Record Members;
        ErrNotApproved: label 'This document has not been approved';
        ErrNoEntries: label 'This Document has no Lines to post';
        MSGEntriesGenerated: label 'Entries Generated Successfully';
        MSGConfirmation: label 'Confirm interest Generation for period starting %1 and Ending %2';
        ErrPosted: label 'This document has already been posted';
        IntDays: Integer;
        BalAccount: Record "Savings Accounts";
        Bal: Decimal;
        IntRate: Decimal;
        LowestBal: Decimal;
        MinBal: Boolean;
        //RIntDays: Integer;
        AsAt: Date;
        StartDate: Date;
        AccruedInt: Decimal;
        Turn: Integer;
        timProgress: Time;
        Counter1: Integer;
        Generating: Label 'Generating Interests: ';
        Counter2: Integer;
        PercentComplete: Decimal;
        MonthDays: Integer;
        InterestBuffer: Record "Savings Interest Buffer";
        FromDateS: Text[100];
        ToDateS: Text[100];
        DateFilter: Text[100];
        // SavingsInterestHeader: Record "Savings Interest Header";
        // SavingsInterestHeaderNo: Date;
        InterestBuffer2: Record "Savings Interest Buffer";
        //Account: Record "Savings Accounts";
        DateFilter2: Text[100];
        diaProgress: Dialog;
        intProgress: Integer;
        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
}
