#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185524 "PR Transfer To Journal"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("PR Salary Card"; "PR Salary Card")
        {
            RequestFilterFields = "Period Filter", "Employee Code";
            column(ReportForNavId_9285; 9285)
            {
            }

            trigger OnAfterGetRecord()
            var
            //Text000: label '@1@@@@@@@@@@';
            begin


                //For use when posting Pension and NSSF
                PostingGroup.Get('PERM');
                /*
                PostingGroup.TESTFIELD("SSF Employer Account");
                PostingGroup.TESTFIELD("SSF Employee Account");
                PostingGroup.TESTFIELD("Pension Employer Acc");
                PostingGroup.TESTFIELD("Pension Employee Acc");
                  */
                //Get the staff details (header)
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then begin
                    strEmpName := '[' + "Employee Code" + '] ' + objEmp."Last Name" + ' ' + objEmp."First Name" + ' ' + objEmp."Middle Name";
                    GlobalDim1 := objEmp."Global Dimension 1 Code";
                    GlobalDim2 := objEmp."Global Dimension 2 Code";

                end;

                LineNumber := LineNumber + 10;


                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                if PeriodTrans.Find('-') then begin
                    //MyDialog.Open(Text000, PeriodTrans."Employee Code");  //**
                    repeat
                        //MyDialog.Update(); //**
                        if PeriodTrans."Journal Account Code" <> '' then begin
                            AmountToDebit := 0;
                            AmountToCredit := 0;
                            if PeriodTrans."Post As" = PeriodTrans."post as"::Debit then
                                AmountToDebit := PeriodTrans.Amount;

                            if PeriodTrans."Post As" = PeriodTrans."post as"::Credit then
                                AmountToCredit := PeriodTrans.Amount;

                            if PeriodTrans."Journal Account Type" = Jac::"G/L Account" then  //GL
                                IntegerPostAs := 0;   //0 debit
                            if PeriodTrans."Journal Account Type" = Jac::Customer then
                                IntegerPostAs := 1;  // 1 =
                            if PeriodTrans."Journal Account Type" = Jac::Vendor then
                                IntegerPostAs := 2;  // 1 =
                            if PeriodTrans."Journal Account Type" = Jac::Savings then
                                IntegerPostAs := 6;  // 1 =
                            if PeriodTrans."Journal Account Type" = Jac::Credit then
                                IntegerPostAs := 7;  // 1 =

                            SaccoTransactionType := Saccotransactiontype::" ";


                            if PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::loan then begin
                                LoanInterest := 0;
                                LoanPrinc := 0;
                                Loans.Get(PeriodTrans."Loan Number");
                                ProductFactory.Get(Loans."Loan Product Type");
                                TransCode.Get(PeriodTrans."Transaction Code");
                                Loans.CalcFields("Outstanding Balance", "Outstanding Bills", "Outstanding Interest");
                                if TransCode."Repayment Method" <> TransCode."repayment method"::Amortized then begin
                                    if AmountToCredit < Loans."Outstanding Interest" then
                                        LoanInterest := AmountToCredit else
                                        LoanInterest := Loans."Outstanding Interest";
                                    if LoanInterest < 0 then LoanInterest := 0;
                                end;

                                //Loan repayment
                                SaccoTransactionType := Saccotransactiontype::Repayment;
                                //LoanPrinc:=AmountToCredit-LoanInterest;
                                LoanPrinc := AmountToCredit;
                                if LoanPrinc < 0 then LoanPrinc := 0;
                                CreateJnlEntry(7, PeriodTrans."Journal Account Code",
                                GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", AmountToDebit, LoanPrinc,
                                PeriodTrans."Post As", PeriodTrans."Loan Number", SaccoTransactionType);



                                SaccoTransactionType := Saccotransactiontype::Bills;
                                CreateJnlEntry(7, PeriodTrans."Journal Account Code",
                                GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", AmountToDebit, LoanPrinc,
                                PeriodTrans."Post As", PeriodTrans."Loan Number", SaccoTransactionType);
                                CreateJnlEntry(0, ProductFactory."Billed Account",
                                GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", LoanPrinc * 1, 0, 1, '',
                                SaccoTransactionType);

                            end else begin


                                if PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::"loan Interest" then
                                    SaccoTransactionType := Saccotransactiontype::"Interest Paid";

                                //IF PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::Welfare THEN
                                // SaccoTransactionType:=SaccoTransactionType::"Welfare Contribution";

                                //IF PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::shares THEN
                                // SaccoTransactionType:=SaccoTransactionType::"Deposit Contribution";



                                CreateJnlEntry(IntegerPostAs, PeriodTrans."Journal Account Code",
                                GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", AmountToDebit, AmountToCredit,
                                PeriodTrans."Post As", PeriodTrans."Loan Number", SaccoTransactionType);
                            end;
                            //Pension  chacha
                            if PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::Pension then begin
                                //Get from Employer Deduction

                                EmployerDed.Reset;
                                EmployerDed.SetRange(EmployerDed."Employee Code", PeriodTrans."Employee Code");
                                EmployerDed.SetRange(EmployerDed."Transaction Code", PeriodTrans."Transaction Code");
                                EmployerDed.SetRange(EmployerDed."Payroll Period", PeriodTrans."Payroll Period");
                                if EmployerDed.Find('-') then begin
                                    //Credit Payables
                                    CreateJnlEntry(0, PostingGroup."Pension Employee Acc",
                                    GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 0,
                                   EmployerDed.Amount, PeriodTrans."Post As", '', SaccoTransactionType);

                                    //Debit Staff Expense
                                    CreateJnlEntry(0, PostingGroup."Pension Employer Acc",
                                    GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", EmployerDed.Amount, 0, 1, '',
                                    SaccoTransactionType);

                                end;
                            end;
                            // End of Pension


                            //NSSF
                            if PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::NSSF then begin
                                //Credit Payables

                                CreateJnlEntry(0, PostingGroup."SSF Employee Account",
                                GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 0, PeriodTrans.Amount,
                                PeriodTrans."Post As", '', SaccoTransactionType);

                                //Debit Staff Expense

                                CreateJnlEntry(0, PostingGroup."SSF Employer Account",
                                GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", PeriodTrans.Amount, 0, 1, '',
                                SaccoTransactionType);
                            end;

                        end;

                    until PeriodTrans.Next = 0;
                end;
                //Update Monthly Cont
                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange("Transaction Code", 'D008');
                if PeriodTrans.Find('-') then begin

                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange("Payroll/Staff No.", PeriodTrans."Employee Code");
                    //SavingsAccounts.SetFilter("Employer Code", '00');
                    SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                    if SavingsAccounts.Find('-') then begin
                        SavingsAccounts."Monthly Contribution" := PeriodTrans.Amount;
                        SavingsAccounts.Modify;

                        Members.Reset;
                        Members.SetRange("No.", SavingsAccounts."Member No.");
                        Members.SetFilter(Status, '%1', Members.Status::New);
                        if Members.FindFirst then begin
                            Members.Status := Members.Status::Active;
                            Members.Modify;
                        end;
                    end;
                end;

            end;

            trigger OnPostDataItem()
            begin
                //MyDialog.Close();
                Message('Payroll Journal Generated Succesfully');
            end;

            trigger OnPreDataItem()
            begin
                //   OnViewCurrRec();
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'PAYMENT');
                GenJournalLine.SetRange("Journal Batch Name", 'SALARIES');
                if GenJournalLine.Find('-') then begin
                    //******************************* Check if journal journal has entries for a different period *******************************
                    if (GenJournalLine."Document No." <> UpperCase(PeriodName)) and (GenJournalLine.Count > 2) then begin
                        Error(Text10001, GenJournalLine.Count, GenJournalLine."Document No.");
                    end else begin
                        //Journal Approval Status
                        GenJnlBatch.Reset;
                        GenJnlBatch.SetRange(GenJnlBatch."Journal Template Name", 'PAYMENT');
                        GenJnlBatch.SetRange(GenJnlBatch.Name, 'SALARIES');
                        if GenJnlBatch.Find('-') then begin
                            /*
                          GenJnlBatch.Status:=GenJnlBatch.Status::Open;
                            GenJnlBatch.MODIFY;
                            */
                        end;
                        //Clear journal
                        GenJournalLine.DeleteAll;
                    end;
                    //******************************* Check if journal journal has entries for a different period *******************************
                end;


                LineNo := 10000;

                //Create batch*****************************************************************************
                //MESSAGE('get the journal batch');
                GenJnlBatch.Reset;
                GenJnlBatch.SetRange(GenJnlBatch."Journal Template Name", 'PAYMENT');
                GenJnlBatch.SetRange(GenJnlBatch.Name, 'SALARIES');
                if GenJnlBatch.Find('-') = false then begin
                    GenJnlBatch.Init;
                    GenJnlBatch."Journal Template Name" := 'PAYMENT';
                    GenJnlBatch.Name := 'SALARIES';
                    GenJnlBatch.Insert;
                end;
                // End Create Batch************************************************************************
                "Slip/Receipt No" := UpperCase(objPeriod."Period Name");

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
        PeriodFilter := "PR Salary Card".GetFilter("Period Filter");
        if PeriodFilter = '' then Error('You must specify the period filter');

        SelectedPeriod := "PR Salary Card".GetRangeMin("Period Filter");
        objPeriod.Reset;
        if objPeriod.Get(SelectedPeriod) then PeriodName := objPeriod."Period Name";

        PostingDate := CalcDate('1M-1D', SelectedPeriod);
        //MESSAGE('get period filter');
        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        PeriodTrans: Record "PR Period Transactions";
        NssfAmount: Decimal;
        TotNssfAmount: Decimal;
        objEmp: Record "HR Employees";
        EmployeeName: Text[30];
        NssfNo: Text[30];
        IDNumber: Text[30];
        objPeriod: Record "PR Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodFilter: Text[30];
        "Volume Amount": Decimal;
        "TotVolume Amount": Decimal;
        TotalAmount: Decimal;
        totTotalAmount: Decimal;
        CompanyInfo: Record "Company Information";
        ExcelBuf: Record "Excel Buffer" temporary;
        PrinttoExcel: Boolean;
        EmployerNSSFNo: Integer;
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        DocumentNo: Code[100];
        NHIfAmount: Decimal;
        totNHIFTotalAmount: Decimal;
        PAYEAmount: Decimal;
        totPAYETotalAmount: Decimal;
        PENSIONAmount: Decimal;
        totPENSIONTotalAmount: Decimal;
        totHELBTotalAmount: Decimal;
        HELBAMOUNT: Decimal;
        totGRATTotalAmount: Decimal;
        GRATAMOUNT: Decimal;
        ICEAAMOUNT: Decimal;
        totSACCOTotalAmount: Decimal;
        SACCOAMOUNT: Decimal;
        totICEATotalAmount: Decimal;
        Pension: Decimal;
        NssfAmountemployer: Decimal;
        TotalNssfAmountemployer: Decimal;
        totTotalNssfAmountemployer: Decimal;
        NssfAmountemployee: Decimal;
        TotalNssfAmountemployee: Decimal;
        totTotalNssfAmountemployee: Decimal;
        ICEATotalAmount: Decimal;
        GeneraljnlLine: Record "Gen. Journal Line";
        GenJnlBatch: Record "Gen. Journal Batch";
        gRATAMOUNT1: Decimal;
        prsalrycard: Record "PR Salary Card";
        amount: Decimal;
        TOTALamountGRAT: Decimal;
        nETPAY: Decimal;
        Finlemsacco: Decimal;
        csrcontribution: Decimal;
        sALARYaDVANCE: Decimal;
        CarLoanInt: Decimal;
        Staffloanint: Decimal;
        "prEmployee Transactions": Record "PR Employee Transactions";
        TotalAmountarrears: Decimal;
        GRATAMOUNTarrears: Decimal;
        totGRATTotalAmount1: Decimal;
        totGRATTotalAmounttot: Decimal;
        toGrossAmount: Decimal;
        "Slip/Receipt No": Code[50];
        PostingGroup: Record "prEmployee Posting Group";
        strEmpName: Text[150];
        AmountToDebit: Decimal;
        AmountToCredit: Decimal;
        IntegerPostAs: Integer;
        SaccoTransactionType: Option " ",Loan,Repayment,"Interest Due","Interest Paid",Bills,Appraisal;
        PostingDate: Date;
        GlobalDim1: Code[20];
        GlobalDim2: Code[20];
        EmployerDed: Record "prEmployer Deductions";
        TransCode: Record "PR Transaction Codes";
        LineNumber: Integer;
        MyDialog: Dialog;
        MyNext: Integer;
        JAC: Option " ","G/L Account",Customer,Vendor,Savings,Credit;
        Text10001: label 'There are [%1] entries that exist in the Journal for Payroll Period [%2] Please post the before generating a new Journal';
        SavingsAccounts: Record "Savings Accounts";
        Loans: Record Loans;
        LoanInterest: Decimal;
        LoanPrinc: Decimal;
        ProductFactory: Record "Product Factory";
        Members: Record "Members";


    procedure CreateJnlEntry(AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Savings,Credit; AccountNo: Code[20]; GlobalDime1: Code[20]; GlobalDime2: Code[20]; Description: Text[150]; DebitAmount: Decimal; CreditAmount: Decimal; PostAs: Option " ",Debit,Credit; LoanNo: Code[20]; TransType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Loan Penalty","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee Due","Loan Guard",Prepayment,"Administration Fee Paid","Car Savings","SchFees Savings","Holiday Savings","CIC Fixed Deposit","Withdrawable Savings","Children Savings","KMA Investment","KMA Fixed Deposit","UAP Premiums","UAP Admin Fee","Direct Debit")
    begin


        LineNumber := LineNumber + 100;
        GeneraljnlLine.Init;
        GeneraljnlLine."Journal Template Name" := 'PAYMENT';
        GeneraljnlLine."Journal Batch Name" := 'SALARIES';
        GeneraljnlLine."Line No." := LineNumber;
        GeneraljnlLine."Document No." := "Slip/Receipt No";
        GeneraljnlLine."Loan No" := LoanNo;
        GeneraljnlLine."Transaction Type" := SaccoTransactionType;
        GeneraljnlLine."Posting Date" := PostingDate;
        GeneraljnlLine."Account Type" := AccountType;
        GeneraljnlLine."Account No." := AccountNo;
        GeneraljnlLine.Validate(GeneraljnlLine."Account No.");
        GeneraljnlLine.Description := Description;
        if PostAs = Postas::Debit then begin
            GeneraljnlLine."Debit Amount" := DebitAmount;
            GeneraljnlLine.Validate("Debit Amount");
        end else begin
            GeneraljnlLine."Credit Amount" := CreditAmount;
            GeneraljnlLine.Validate("Credit Amount");
        end;
        GeneraljnlLine."Shortcut Dimension 1 Code" := GlobalDime1;
        GeneraljnlLine.Validate(GeneraljnlLine."Shortcut Dimension 1 Code");
        GeneraljnlLine."Shortcut Dimension 2 Code" := GlobalDime2;
        GeneraljnlLine.Validate(GeneraljnlLine."Shortcut Dimension 2 Code");
        GeneraljnlLine."Loan No" := LoanNo;
        GeneraljnlLine."Transaction Type" := SaccoTransactionType;
        if GeneraljnlLine.Amount <> 0 then
            GeneraljnlLine.Insert;
    end;


    procedure OnViewCurrRec()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestricViewTxt: label 'You do not have Permissions to VIEW,MODIFY or DELETE on this record. Contact system administrator for assistance. %';
    begin
        ChangePermission.Reset;
        ChangePermission.SetRange("User ID", UserId);
        ChangePermission.SetRange("View Payroll", true);
        ChangePermission.SetRange("Function Extended", ChangePermission."function extended"::"View Payroll");
        if not ChangePermission.Find('-') then
            Error(ErrorOnRestricViewTxt, UserId);
    end;
}
