#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52187389 "Generate Year Selectively"
{
    ProcessingOnly = true;
    dataset
    {
        dataitem(EndYearTransferHeader; "End Year Transfer Header")
        {
            trigger OnAfterGetRecord()
            begin
                EndYearTransferHeader.TestField("Start Date");
                EndYearTransferHeader.TestField("End Date");
                EndYearTransferHeader.TestField(Description);
                EndYearTransferHeader.TestField("Responsibility Center");
                EndYearTransferHeader.TestField("Shortcut Dimension 1 Code");
                EndYearTransferHeader.TestField("Document No.");
                EndYearTransferHeader.TestField("Shortcut Dimension 2 Code");
                IntEarned := 0;

                if not Confirm(MSGConfirmation, true, EndYearTransferHeader."Start Date", EndYearTransferHeader."End Date") then
                    exit else begin
                    InterestBuffer2.Reset;
                    InterestBuffer2.SetRange(InterestBuffer2.No, EndYearTransferHeader."No.");
                    if InterestBuffer2.Find('-') then
                        if EndYearTransferHeader.Posted = false then
                            InterestBuffer2.DeleteAll else
                            Error(ErrPosted);

                    IntEarned := 0;
                    if (ProductId <> '') and (SavingsAccountNo = '') then begin
                        ProductFactory.Reset();
                        if ProductFactory.Get(ProductId) then begin
                            SavingsAccounts.SETRANGE("Product Type", ProductId);
                            if SavingsAccounts.Find('-') then begin
                                //SavingsAccounts.CALCFIELDS("Savings Interest Earned");
                                repeat
                                    // IF SavingsAccounts."Savings Interest Earned">0 THEN
                                    //  BEGIN
                                    IntEarned := 0;
                                    if ProductFactory.Get(SavingsAccounts."Product Type") then begin
                                        ProductFactoryCode := ProductFactory."Product ID";
                                        InterestRate := ProductFactory."Interest Rate (Min.)";
                                        PayableAccount := ProductFactory."Interest Payable Account";
                                        ExpenseAccount := ProductFactory."Interest Expense Account";
                                    end;
                                    /*
                                            SavingsInterestBuffer.RESET;
                                            SavingsInterestBuffer.SETRANGE(SavingsInterestBuffer."Account No",SavingsAccounts."No.");
                                            IF SavingsInterestBuffer.FIND('-') THEN
                                              BEGIN
                                                IntEarned:=0;
                                                REPEAT
                                                  IF (InterestBuffer."Interest Date">="Start Date") AND (InterestBuffer."Interest Date"<="End Date") THEN
                                                  IntEarned+=SavingsInterestBuffer."Interest Amount";
                                                  UNTIL SavingsInterestBuffer.NEXT=0;
                                                END;
                                    */
                                    SavingsInterestBuffer.SetCurrentkey(SavingsInterestBuffer."Account No", SavingsInterestBuffer."Interest Date");
                                    SavingsInterestBuffer.SetRange(SavingsInterestBuffer."Account No", SavingsAccounts."No.");
                                    SavingsInterestBuffer.SetRange(SavingsInterestBuffer."Interest Date", EndYearTransferHeader."Start Date", EndYearTransferHeader."End Date");
                                    SavingsInterestBuffer.CalcSums(SavingsInterestBuffer."Interest Amount");
                                    IntEarned := SavingsInterestBuffer."Interest Amount";
                                    //IF IntEarned<>0 THEN
                                    // MESSAGE('here %1',IntEarned);
                                    InterestBuffer.Init;
                                    InterestBuffer."Account No" := SavingsAccounts."No.";
                                    InterestBuffer."Account Type" := InterestBuffer."account type"::Savings;
                                    SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)");
                                    InterestBuffer."Account Balance" := SavingsAccounts."Balance (LCY)";
                                    InterestBuffer."Bal. Account Type" := InterestBuffer."bal. account type"::"G/L Account";
                                    InterestBuffer.Blocked := SavingsAccounts.Blocked;
                                    InterestBuffer.Description := EndYearTransferHeader.Description;
                                    InterestBuffer."Interest Amount" := IntEarned;
                                    InterestBuffer."Interest Date" := EndYearTransferHeader."End Date";
                                    InterestBuffer.Name := SavingsAccounts.Name;
                                    InterestBuffer.No := EndYearTransferHeader."No.";
                                    InterestBuffer."Payable Account" := PayableAccount;
                                    InterestBuffer."Product Factory Code" := SavingsAccounts."Product Type";
                                    if Members.Get(SavingsAccounts."Member No.") then begin
                                        InterestBuffer."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                        InterestBuffer."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                                    end;
                                    InterestBuffer."User ID" := UserId;
                                    if InterestBuffer."Interest Amount" <> 0 then
                                        InterestBuffer.Insert(true);
                                //END;
                                until SavingsAccounts.Next = 0;
                            end;
                        end;
                    end else
                        if SavingsAccountNo <> '' then begin
                            if SavingsAccounts.get(SavingsAccountNo) then begin
                                //SavingsAccounts.CALCFIELDS("Savings Interest Earned")
                                // IF SavingsAccounts."Savings Interest Earned">0 THEN
                                //  BEGIN
                                IntEarned := 0;
                                if ProductFactory.Get(SavingsAccounts."Product Type") then begin
                                    ProductFactoryCode := ProductFactory."Product ID";
                                    InterestRate := ProductFactory."Interest Rate (Min.)";
                                    PayableAccount := ProductFactory."Interest Payable Account";
                                    ExpenseAccount := ProductFactory."Interest Expense Account";
                                end;
                                /*
                                        SavingsInterestBuffer.RESET;
                                        SavingsInterestBuffer.SETRANGE(SavingsInterestBuffer."Account No",SavingsAccounts."No.");
                                        IF SavingsInterestBuffer.FIND('-') THEN
                                          BEGIN
                                            IntEarned:=0;
                                            REPEAT
                                              IF (InterestBuffer."Interest Date">="Start Date") AND (InterestBuffer."Interest Date"<="End Date") THEN
                                              IntEarned+=SavingsInterestBuffer."Interest Amount";
                                              UNTIL SavingsInterestBuffer.NEXT=0;
                                            END;
                                */
                                SavingsInterestBuffer.SetCurrentkey(SavingsInterestBuffer."Account No", SavingsInterestBuffer."Interest Date");
                                SavingsInterestBuffer.SetRange(SavingsInterestBuffer."Account No", SavingsAccounts."No.");
                                SavingsInterestBuffer.SetRange(SavingsInterestBuffer."Interest Date", EndYearTransferHeader."Start Date", EndYearTransferHeader."End Date");
                                SavingsInterestBuffer.CalcSums(SavingsInterestBuffer."Interest Amount");
                                IntEarned := SavingsInterestBuffer."Interest Amount";
                                //IF IntEarned<>0 THEN
                                // MESSAGE('here %1',IntEarned);
                                InterestBuffer.Init;
                                InterestBuffer."Account No" := SavingsAccounts."No.";
                                InterestBuffer."Account Type" := InterestBuffer."account type"::Savings;
                                SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)");
                                InterestBuffer."Account Balance" := SavingsAccounts."Balance (LCY)";
                                InterestBuffer."Bal. Account Type" := InterestBuffer."bal. account type"::"G/L Account";
                                InterestBuffer.Blocked := SavingsAccounts.Blocked;
                                InterestBuffer.Description := EndYearTransferHeader.Description;
                                InterestBuffer."Interest Amount" := IntEarned;
                                InterestBuffer."Interest Date" := EndYearTransferHeader."End Date";
                                InterestBuffer.Name := SavingsAccounts.Name;
                                InterestBuffer.No := EndYearTransferHeader."No.";
                                InterestBuffer."Payable Account" := PayableAccount;
                                InterestBuffer."Product Factory Code" := SavingsAccounts."Product Type";
                                if Members.Get(SavingsAccounts."Member No.") then begin
                                    InterestBuffer."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                    InterestBuffer."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                                end;
                                InterestBuffer."User ID" := UserId;
                                if InterestBuffer."Interest Amount" <> 0 then
                                    InterestBuffer.Insert(true);
                                //END;
                            end;
                        end;
                end;
                Message(MSGEntriesGenerated);
            end;

            trigger OnPostDataItem()
            begin
                ProgressWindow.Close;
                Message('Done!!!');
            end;

            trigger OnPreDataItem()
            begin
                if (ProductId = '') and (SavingsAccountNo = '') then
                    Error('You have not filled any filters please ensure you have atleast one before proceeding');
                Counter := 0;
                ProgressWindow.Open('Processing Account Interest No. #1#######');
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

                field(ProductId; ProductId)
                {
                    Caption = 'Product Id';
                    TableRelation = "Product Factory"."Product ID";
                }
                field(SavingsAccountNo; SavingsAccountNo)
                {
                    Caption = 'Saving Account No';
                    TableRelation = "Savings Accounts"."No.";
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        ProductId := '';
        SavingsAccountNo := '';
    end;

    var
        InterestBuffer: Record "End Year Interest Buffer";
        InterestBuffer2: Record "End Year Interest Buffer";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        PeriodicActivities: Codeunit "Periodic Activities";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        // CustomApprovals: Codeunit "Custom Approvals Codeunit";
        SavingsAccounts: Record "Savings Accounts";
        FromDateS: Text[100];
        ToDateS: Text[100];
        DateFilter: Text[100];
        ProductFactory: Record "Product Factory";
        ProductFactoryCode: Code[20];
        InterestRate: Decimal;
        PayableAccount: Code[20];
        ExpenseAccount: Code[20];
        BankingUserTemplate: Record "Banking User Template";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        JTemp: Code[20];
        JBatch: Code[20];
        PageEditable: Boolean;
        Members: Record Members;
        SavingsInterestBuffer: Record "Savings Interest Buffer";
        IntEarned: Decimal;
        ErrNotApproved: label 'This document has not been approved';
        ErrNoEntries: label 'This Document has no Lines to post';
        MSGEntriesGenerated: label 'Entries Generated Successfully';
        MSGConfirmation: label 'Confirm interest Generation for period starting %1 and Ending %2';
        ErrPosted: label 'This document has already been posted';
        RunLoan: Boolean;
        SimulatedTodaysDate: Date;
        ProgressWindow: Dialog;
        Counter: Integer;
        AsAt: Date;
        DaysInArrears: Decimal;
        SimulatedDaysInArreas: Integer;
        SavingsAccountNo: Code[50];
        ProductId: Code[10];
        StartDate: Date;
        EndDate: Date;
}
