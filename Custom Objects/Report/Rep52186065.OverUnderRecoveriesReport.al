namespace MNS.MNS;
using Microsoft.Foundation.Company;
using Microsoft.Sales.Customer;

report 52186065 "Over/Under Recovery Loans Rep"
{
    ApplicationArea = All;
    Caption = 'Over/Under Recoveries Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Over&Under Recoveries Report Loans.rdl';
    dataset
    {
        dataitem(CheckoffHeader; "Checkoff Header")
        {
            DataItemTableView = where("CheckOff Type" = const(loans), Posted = const(True));
            RequestFilterFields = "No.", "Posting Period";
            //DataItemTableView = where(Posted = const(True));
            //Over / under recoveries report (Variance Report) of Loan, interest, 
            //deposits, risk and BBF with the following fields: MNO, names, product type, amount expected, amount paid, variance, description, comments, user
            column(HeaderNo_; "No.") { }
            column(LoanExpectedInterest; LoanExpectedInterest) { }
            column(LoanExpectedPrincipal; LoanExpectedPrincipal) { }
            column(PaidInterest; PaidInterest) { }
            column(PaidPrincipal; PaidPrincipal) { }
            column(InterestVariance; InterestVariance) { }
            column(PrincipalVariance; PrincipalVariance) { }
            column(LoanProductType; LoanProductTypeName) { }
            column(Entered_By; "Entered By") { }
            column(Posting_Date; "Posting Date") { }
            column(StartDate; EndDate) { }
            column(Posting_Period; "Posting Period") { }
            column(TotalVariance; TotalVariance) { }
            column(PFNo; PFNo) { }
            column(EmployerCode; EmployerCode) { }
            column(EmployerName; EmployerName) { }
            column(LoanOutstandingBal; LoanOutstandingBal) { }
            column(InterestDue; InterestDue) { }
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
            dataitem(CheckoffLines_; "Checkoff Lines")
            {

                DataItemLink = "Checkoff Header" = FIELD("No.");
                column(CheckoffHeaderNo_; "Checkoff Header")
                {
                }
                column(Member_No_; "Member No.")
                {
                }
                column(Name; Name) { }
                column(Remarks; Remarks) { }
                column(CheckoffLinescreditAccount; "Credit Account")
                {
                }
                column(Refundable_Amount; "Refundable Amount")
                {
                    //overecovered amount
                }
                column(CheckoffLinesavingsAccount; "Savings Account")
                {
                }
                column(CheckoffLinesLoanNo_; "Loan No.")
                {
                }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;

                begin
                    OutstandingLoanBal := 0;
                    LoanExpectedInterest := 0;
                    LoanExpectedPrincipal := 0;
                    PaidInterest := 0;
                    PaidPrincipal := 0;
                    PrincipalVariance := 0;
                    InterestVariance := 0;

                    // if LoansTable.Get(CheckoffLines."Loan No.") then begin
                    //     LoanProductTypeName := LoansTable."Loan Product Type Name";
                    //     LoansTable.CalcFields(LoansTable."Outstanding Interest");
                    //     LoanExpectedPrincipal := LoansTable."Loan Principle Repayment";
                    //     LoanExpectedInterest := LoansTable."Outstanding Interest";

                    Members.RESET;
                    Members.Setrange("No.", CheckoffLines_."Member No.");
                    Members.SetLoadFields("Payroll/Staff No.", "Employer Code", "Employer Name");
                    if Members.Find('-') THEN begin
                        Members.CalcFields(Members."Employer Name");
                        PFNo := Members."Payroll/Staff No.";
                        EmployerCode := Members."Employer Code";
                        EmployerName := Members."Employer Name";

                        if EmployerName = '' then begin
                            if Employers.get(EmployerCode) then
                                EmployerName := Employers.Name;
                        end;
                    end;

                    LoansTable.Reset();
                    LoansTable.SetRange("Loan No.", CheckoffLines_."Loan No.");
                    LoansTable.SetAutoCalcFields(LoansTable."Outstanding Interest", LoansTable."Outstanding Balance", LoansTable."Total Balance");
                    If LoansTable.Find('-') then begin
                        LoanProductTypeName := LoansTable."Loan Product Type Name";

                        LoanOutstandingBal := LoansTable."Outstanding Balance";

                        CreditLedgerEntry.Reset();
                        CreditLedgerEntry.SetRange("Customer No.", LoansTable."Loan Account");
                        CreditLedgerEntry.SetRange("Loan No", LoansTable."Loan No.");
                        CreditLedgerEntry.SetRange("Document No.", CheckoffHeader."Document No.");
                        if CreditLedgerEntry.FindSet() then begin
                            repeat
                                if CreditLedgerEntry."Transaction Type" = CreditLedgerEntry."Transaction Type"::Repayment then begin
                                    PaidPrincipal += (CreditLedgerEntry.Amount * -1);
                                end
                                else if CreditLedgerEntry."Transaction Type" = CreditLedgerEntry."Transaction Type"::"Interest Paid" then begin
                                    PaidInterest += (CreditLedgerEntry.Amount * -1);
                                end;
                            until CreditLedgerEntry.Next = 0;
                        end;
                        LoansTable.SetFilter("Date Filter", '..' + Format(CalcDate('<CM>', CheckoffHeader."Posting Period")));
                        LoansTable.CalcFields("Outstanding Interest");

                        InterestDue := LoansTable."Outstanding Interest";
                        if InterestDue < 0 then InterestDue := 0;

                        // Get Expected Principal and Interest
                        if LoansTable."Interest Calculation Method" = LoansTable."Interest Calculation Method"::"Reducing Balance" then begin
                            LoanExpectedPrincipal := LoansTable."Loan Principle Repayment";
                            // Expected Interest
                            LoanRepaySchedule.reset;
                            LoanRepaySchedule.SetRange("Loan No.", LoansTable."Loan No.");
                            if LoanRepaySchedule.Find('-') then begin
                                repeat
                                    if LoanRepaySchedule."Repayment Date" = CalcDate('<CM>', CheckoffHeader."Posting Period") then begin
                                        LoanExpectedInterest := LoanRepaySchedule."Monthly Interest"
                                    end;
                                until LoanRepaySchedule.Next() = 0;
                            end;

                        end
                        else
                            if LoansTable."Interest Calculation Method" = LoansTable."Interest Calculation Method"::Amortised then begin

                            end;
                        LoanExpectedInterest := LoansTable."Outstanding Interest";
                        //if LoansTable."Interest Calculation Method" = LoansTable."Interest Calculation Method"::"Reducing Balance" then begin
                        //LoanExpectedPrincipal := LoansTable."Loan Principle Repayment";
                        // Expected Interest
                        LoanRepaySchedule.reset;
                        LoanRepaySchedule.SetRange("Loan No.", LoansTable."Loan No.");
                        if not LoanRepaySchedule.Find('-') then begin
                            // if LoansTable."Loan Rescheduled" then begin
                            //     RescheduledLn.Reset;
                            //     RescheduledLn.SetRange(RescheduledLn."Loan No.", LoansTable."Loan No.");
                            //     RescheduledLn.SetRange(RescheduledLn.Rescheduled, true);
                            //     if RescheduledLn.Find('-') then begin
                            //         // LRepaymentSchedule.Reset;
                            // LRepaymentSchedule.SetRange(LRepaymentSchedule."Loan No.", LoanRescheduling."Loan No.");
                            // LRepaymentSchedule.SetRange("Repayment Date", CalcDate('<CM-1M+1D>', LoanRescheduling."Rescheduling Date"), 99991230D);
                            // if LRepaymentSchedule.Find('-') then LRepaymentSchedule.DeleteAll;
                            //repeat
                            LoanProcess.GenerateSchedule(LoansTable, True);
                            // GetNewRepayment(LoanRescheduling."No.");
                            //until RescheduledLn.Next = 0;
                            // end;

                        end;
                        LoanRepaySchedule.reset;
                        LoanRepaySchedule.SetRange("Loan No.", LoansTable."Loan No.");
                        if LoanRepaySchedule.Find('-') then begin
                            repeat
                                if LoanRepaySchedule."Repayment Date" = CalcDate('<CM>', CheckoffHeader."Posting Period") then begin
                                    LoanExpectedPrincipal := LoanRepaySchedule."Principal Repayment";
                                    LoanExpectedInterest := LoanRepaySchedule."Monthly Interest";
                                    ExpectedPI := LoanExpectedPrincipal + LoanExpectedInterest;
                                    break;
                                end;
                            until LoanRepaySchedule.Next() = 0;
                        end;
                        // end
                        // else
                        //     if LoansTable."Interest Calculation Method" = LoansTable."Interest Calculation Method"::Amortised then begin
                        //         LoanExpectedPrincipal := LoansTable."Loan Principle Repayment";
                        //         LoanExpectedInterest := LoansTable."Outstanding Interest";
                        // end;
                        //LoanExpectedInterest := LoansTable."Outstanding Interest";

                        PrincipalVariance := LoanExpectedPrincipal - PaidPrincipal;
                        InterestVariance := LoanExpectedInterest - PaidInterest;
                        TotalVariance := PrincipalVariance + InterestVariance;
                    end;
                end;

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    // CheckoffHeader.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                end;
            }
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                // group("Date Filters")
                // {
                //     field(StartDate; StartDate) { }

                //     field(EndDate; EndDate) { }

                // }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        // if StartDate = 0D Then Error('Please select a Start Date');
        // if EndDate = 0D Then Error('Please select an End Date');
        if StartDate > EndDate Then Error('Start Date cannot be greater than End Date');

        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        LoansTable: Record "Loans";
        OutstandingLoanBal: Decimal;
        OutstandingInterest: Decimal;
        LoanExpectedPrincipal: Decimal;
        LoanExpectedInterest: Decimal;
        CreditLedgerEntry: Record "Credit Ledger Entry";
        PaidPrincipal: Decimal;
        PaidInterest: Decimal;
        PrincipalVariance: Decimal;
        InterestVariance: Decimal;
        LoanProductTypeName: Text;
        StartDate: Date;
        EndDate: Date;
        TotalVariance: Decimal;
        Members: Record "Members";
        EmployerName: Text;
        EmployerCode: Code[50];
        PFNo: Code[50];
        LoanOutstandingBal: Decimal;
        InterestDue: Decimal;
        Employers: record Customer;
        LoanRepaySchedule: record "Ideal Repayment Schedule";
        ExpectedPI: Decimal;
        LoanProcess: Codeunit "Loans Process";
        RescheduledLn: record "Loan Rescheduling";
}
