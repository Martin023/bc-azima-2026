#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185705 "Transfer Net Pay To Fosa"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("prSalary Card"; "PR Salary Card")
        {
            RequestFilterFields = "Period Filter", "Employee Code";
            column(ReportForNavId_6207; 6207)
            {
            }

            trigger OnAfterGetRecord()
            begin
                LineNumber := LineNumber + 1;


                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "prSalary Card"."Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange(PeriodTrans."Group Text", 'NET PAY');
                if PeriodTrans.Find('-') then begin
                    REPEAT
                        //MESSAGE('Sal Amt %1 Acc %2',PeriodTrans.Amount,PeriodTrans."Employee Code");
                        SalaryPrLines.Init;
                        SalaryPrLines."No." := LineNumber;
                        //SalaryPrLines."Account No.":="prSalary Card"."Bank Account Number";
                        SalaryPrLines.VALIDATE(SalaryPrLines."Account No.");
                        SalaryPrLines."Staff No." := PeriodTrans."Employee Code";
                        SalaryPrLines.Validate(SalaryPrLines."Staff No.");
                        SalaryPrLines.Date := Today;
                        SalaryPrLines."Salary Header No." := SalHeader;
                        SalaryPrLines.Amount := PeriodTrans.Amount;
                        SalaryPrLines.Insert;
                    UNTIL PeriodTrans.NEXT = 0;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Salary Transfered Successfully');
            end;

            trigger OnPreDataItem() 
            begin

                //  OnViewCurrRec();
                "Slip/Receipt No" := UpperCase(objPeriod."Period Name");

                SalheaderDet.Reset;
                SalheaderDet.SetRange(SalheaderDet.No, SalHeader);
                if SalheaderDet.Find('-') then begin
                    if SalheaderDet.Posted = true then
                        Error('Header already posted');
                end else
                    Error('Salary Header No % not found', SalHeader);

                SalaryPrLines.Reset;
                SalaryPrLines.SetRange(SalaryPrLines."Salary Header No.", SalHeader);
                if SalaryPrLines.Find('-') then
                    SalaryPrLines.DeleteAll;
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
                field(SalHeader; SalHeader)
                {
                    ApplicationArea = Basic;
                    Caption = 'Salary Header No';
                    //TableRelation = "Salary Header".No where(Posted = filter(No));
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
        PeriodFilter := "prSalary Card".GetFilter("Period Filter");
        if PeriodFilter = '' then Error('You must specify the period filter');

        SelectedPeriod := "prSalary Card".GetRangeMin("Period Filter");
        objPeriod.Reset;
        if objPeriod.Get(SelectedPeriod) then begin
            PeriodName := objPeriod."Period Name";
            if objPeriod.Closed = true then Error('The Period %1 is Closed', objPeriod."Date Opened");
        end;
        PostingDate := CalcDate('1M-1D', SelectedPeriod);
    end;

    var
        PeriodTrans: Record "PR Period Transactions";
        objEmp: Record "HR Employees";
        PeriodName: Text[30];
        PeriodFilter: Text[30];
        SelectedPeriod: Date;
        objPeriod: Record "PR Payroll Periods";
        ControlInfo: Record "Control-Information";
        strEmpName: Text[150];
        GeneraljnlLine: Record "Gen. Journal Line";
        GenJnlBatch: Record "Gen. Journal Batch";
        "Slip/Receipt No": Code[50];
        LineNumber: Integer;
        "Salary Card": Record "PR Salary Card";
        TaxableAmount: Decimal;
        PostingGroup: Record "prEmployee Posting Group";
        GlobalDim1: Code[10];
        GlobalDim2: Code[10];
        TransCode: Record "PR Transaction Codes";
        PostingDate: Date;
        AmountToDebit: Decimal;
        AmountToCredit: Decimal;
        IntegerPostAs: Integer;
        SaccoTransactionType: Option " ","Deposit Contribution","Share Capital","Benevolent Contribution",Loan,Repayment,"Interest Due","Interest Paid","Un Allocated Amount";
        EmployerDed: Record "prEmployer Deductions";
        SalheaderDet: Record "Salary Header";
        SalaryPrLines: Record "Salary Lines";
        SalHeader: Code[20];


    procedure CreateJnlEntry(AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member; AccountNo: Code[20]; GlobalDime1: Code[20]; GlobalDime2: Code[20]; Description: Text[50]; DebitAmount: Decimal; CreditAmount: Decimal; PostAs: Option " ",Debit,Credit; LoanNo: Code[20]; TransType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Welfare Contribution","Deposit Contribution","Loan Penalty","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Welfare Contribution 2"; BalAccountNo: Code[20])
    begin
        /*IF AccountType=AccountType::Customer THEN BEGIN
        AccountType:=AccountType::Member;
        END;
        
        
         LineNumber:=LineNumber+100;
         GeneraljnlLine.INIT;
         GeneraljnlLine."Journal Template Name":='GENERAL';
         GeneraljnlLine."Journal Batch Name":='STAFF PR';
         GeneraljnlLine."Line No.":=LineNumber;
         GeneraljnlLine."Document No.":="Slip/Receipt No";
         GeneraljnlLine."Loan No":=LoanNo;
         GeneraljnlLine."Transaction Type":=TransType;
         GeneraljnlLine."Posting Date":=TODAY;
         GeneraljnlLine."Account Type":=AccountType;
         GeneraljnlLine."Account No.":=AccountNo;
         //GeneraljnlLine.VALIDATE(GeneraljnlLine."Account No.");
         GeneraljnlLine.Description:=Description;
         IF PostAs = PostAs::Debit THEN BEGIN
         GeneraljnlLine."Debit Amount":=DebitAmount;
         GeneraljnlLine.VALIDATE("Debit Amount");
         END ELSE BEGIN
         GeneraljnlLine."Credit Amount":=CreditAmount;
         GeneraljnlLine.VALIDATE("Credit Amount");
         END;
         //GeneraljnlLine."Bal. Account No.":=BalAccountNo;
         GeneraljnlLine."Shortcut Dimension 1 Code":=GlobalDime1;
         GeneraljnlLine.VALIDATE(GeneraljnlLine."Shortcut Dimension 1 Code");
        // GeneraljnlLine."Shortcut Dimension 2 Code":=GlobalDime2;
        // GeneraljnlLine.VALIDATE(GeneraljnlLine."Shortcut Dimension 2 Code");
         IF GeneraljnlLine.Amount<>0 THEN
              GeneraljnlLine.INSERT;
         */

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
