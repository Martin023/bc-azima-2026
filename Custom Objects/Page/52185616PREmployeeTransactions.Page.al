page 52185616 "PR Employee Transactions"
{
    Caption = 'Transaction List';
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Import Transactions,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "PR Employee Transactions";
    ApplicationArea = Basic, Suite;


    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    var
                        PREmpTrans: Record "PR Employee Transactions";
                        CurrentYear: Integer;
                        CurrentMonth: Integer;
                    begin
                        blnIsLoan := false;

                        PRTransactionCodes.Reset;
                        PRTransactionCodes.SetRange(PRTransactionCodes."Transaction Code", Rec."Transaction Code");
                        if PRTransactionCodes.Find('-') then
                            Rec."Transaction Name" := PRTransactionCodes."Transaction Name";
                        Rec."Sacco loan" := PRTransactionCodes."IsCoop/LnRep";

                        Rec."Payroll Period" := SelectedPeriod;
                        Rec."Period Month" := PeriodMonth;
                        Rec."Period Year" := PeriodYear;

                        if PRTransactionCodes."Special Transactions" = 8 then blnIsLoan := true;

                        if PRTransactionCodes."Is Formula" = true then begin
                            empCode := Rec."Employee Code";
                            //CLEAR(objOcx);
                            // curTransAmount:=objOcx.fnDisplayFrmlValues(empCode,PeriodMonth,PeriodYear,PRTransactionCodes.Formula);
                            Rec.Amount := curTransAmount;
                        end;

                        //*************ENTER IF EMPLOYER DEDUCTION IS SET UP
                        curTransAmount := 0;

                        if PRTransactionCodes."Include Employer Deduction" = true then begin
                            //  curTransAmount:=objOcx.fnDisplayFrmlValues(empCode,PeriodMonth,PeriodYear,PRTransactionCodes."Is Formula for employer");
                            Rec."Employer Amount" := curTransAmount;
                        end;


                        //  ******************* FOR NIB MWEA *****************************************

                        //  **************************************************************************
                    end;
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("No of Units"; Rec."No of Units")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        if (blnIsLoan = true) and (Rec.Balance > 0) and (Rec.Amount > 0) then begin
                            Rec."#of Repayments" := Round(Rec.Balance / Rec.Amount, 1, '>');
                            Rec."#of Repayments" := Round(Rec."#of Repayments", 1, '>');
                        end;
                    end;
                }
                field("Original Amount"; Rec."Original Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        if (blnIsLoan = true) and (Rec.Balance > 0) and (Rec.Amount > 0) then begin
                            Rec."#of Repayments" := Round(Rec.Balance / Rec.Amount, 1, '>');
                            Rec."#of Repayments" := Round(Rec."#of Repayments", 1, '>');
                        end;
                    end;
                }
                field(Variated; Rec.Variated)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Frequency;Rec.Frequency)
                {
                    
                }
                field("Reference No"; Rec."Reference No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Stop for Next Period"; Rec."Stop for Next Period")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amortized Loan Total Repay Amt"; Rec."Amortized Loan Total Repay Amt")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Stopped; Rec.Stopped)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Savings Account No.";Rec."Savings Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Exempt from Interest"; Rec."Exempt from Interest")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Interest Rate"; Rec."Loan Interest Rate")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Number"; Rec."Loan Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Due"; Rec."Interest Due")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("#of Repayments"; Rec."#of Repayments")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Subledger Account"; Rec."Subledger Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Subledger; Rec.Subledger)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Period Month"; Rec."Period Month")
                {
                    // Editable=false;

                }
                field("Period Year"; Rec."Period Year")
                {

                }
                // field("Employee Code"; Rec.PRTransactionCodes."Employee Code Filter")
                // {
                // }
                // field(levy;Rec.levy)
                // {

                // }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Import Earnings/Deductions")
            {
                ApplicationArea = Basic;
                Caption = 'Import Earnings/Deductions';
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Category7;
                RunObject = xmlport earningsdeductions;



            }
        }
    }

    trigger OnInit()
    begin
        objPeriod.Reset;
        objPeriod.SetRange(objPeriod.Closed, false);
        if objPeriod.Find('-') then begin
            SelectedPeriod := objPeriod."Date Opened";
            PeriodName := objPeriod."Period Name";
            PeriodMonth := objPeriod."Period Month";
            PeriodYear := objPeriod."Period Year";
            //objEmpTrans.RESET;
            //objEmpTrans.SETRANGE("Payroll Period",SelectedPeriod);
        end;

        //Filter per period  - Dennis
        Rec.SetFilter("Payroll Period", Format(objPeriod."Date Opened"));
        //objPeriod.SETFILTER(objPeriod.Closed,'FALSE');
    end;

    trigger OnOpenPage()
    begin
        Rec.SetFilter("Payroll Period", Format(objPeriod."Date Opened"));
    end;

    var
        //
        //PRTransactionCode: Code;
        PRTransactionCodes: Record "PR Transaction Codes";
        SelectedPeriod: Date;
        objPeriod: Record "PR Payroll Periods";
        PeriodName: Text[30];
        PeriodTrans: Record "PR Period Transactions";
        PeriodMonth: Integer;
        PeriodYear: Integer;
        blnIsLoan: Boolean;
        transType: Text[30];
        strExtractedFrml: Text[30];
        curTransAmount: Decimal;
        empCode: Text[30];
        PREmployeeTrans: Record "PR Employee Transactions";
        i: Integer;
        HREmp: Record "HR Employees";
    // [RunOnClient]
    // MyValue: DotNet Interaction;
}

