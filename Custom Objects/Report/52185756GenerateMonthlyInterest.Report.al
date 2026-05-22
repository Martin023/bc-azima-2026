#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185756 "Generate Monthly Interest"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Interest Header"; "Interest Header")
        {
            RequestFilterFields = "No.";


            dataitem(Loans; Loans)
            {
                CalcFields = "Outstanding Balance", "Outstanding Interest";
                RequestFilterFields = "Loan No.", "Employer Code", "Member No.", "Source Unit", "Loan Product Type";
                DataItemTableView = where("Outstanding Balance" = filter(> 0), "Loan Account" = filter(<> ''));
                // DataItemTableView = where("Daily Interest" = filter(> 0), "Outstanding Balance" = filter(> 0), "Loan Account" = filter(<> ''));
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    intProgressTotal := COUNT;

                    intProgressI := 0;
                    TimeProgress := TIME;
                    NoOfRecsProgress := intProgressTotal DIV 100;
                    NoOfProgressed := 0;

                    diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);

                end;

                trigger OnAfterGetRecord()
                var
                    UserSetup: Record "User Setup";
                    InterestBuffer: Record "Loans Interest Buffer";
                    // LoansRec: Record LoansRec;
                    intrestHeader: Record "Interest Header";
                    Loanprocess: Codeunit "Loans Process";
                    IntAmt: Decimal;


                begin
                    intProgressI += 1;

                    // IF (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) THEN BEGIN
                    IF (intProgressI >= NoOfRecsProgress) THEN BEGIN
                        NoOfProgressed := NoOfProgressed + intProgressI;
                        if intProgressTotal = 0 then
                            intProgressTotal := 1;
                        diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                        intProgressI := 0;
                        TimeProgress := TIME;
                    END;

                    // Loanprocess.ComputeDaillyLoanInterest(LoansRec."Loan No.", PostingDate);
                    PostingDate := "Interest Header"."Posting Date";
                    LoansRec.Reset();
                    LoansRec.setrange(LoansRec."Loan No.", "Loan No.");
                    LoansRec.SetFilter("Date Filter", '..%1', "Interest Header"."End Date");
                    LoansRec.SetFilter("Last Interest Run Date", '<>%1', "Interest Header"."Posting Date");
                    if LoansRec.find('-') then begin
                        if ProductFactory.get(LoansRec."Loan Product Type") then begin
                            if ProductFactory."Guarantor Loan" = false then begin //excempt guarantor loan from billing interest
                                if (ProductFactory."Interest Recovered Upfront" = false) then
                                    if (ProductFactory."Compute Interest Due on Postin" <> ProductFactory."Compute Interest Due on Postin"::"Full Period Interest")
                                    and (ProductFactory."No Interest Bills" = false)
                                    and (ProductFactory."Product Class Type" = ProductFactory."Product Class Type"::Loan) then begin

                                        LoansRec.CalcFields(LoansRec."Outstanding Balance", LoansRec."Outstanding Interest");

                                        if (LoansRec."Outstanding Balance") > 0 then begin
                                            if LoansRec."Loan Account" <> '' then begin
                                                Members.Reset;
                                                Members.SetRange("No.", LoansRec."Member No.");
                                                Members.SetFilter(Status, '<>%1', Members.Status::Deceased);

                                                if Members.Find('-') then begin

                                                    if LoansRec."Interest Calculation Method" = LoansRec."Interest Calculation Method"::"Straight Line" then
                                                        IntCharged := LoansRec."Approved Amount" * ((LoansRec.Interest) / 1200) * 1
                                                    else
                                                        IntCharged := LoansRec."Outstanding Balance" * ((LoansRec.Interest) / 1200) * 1;

                                                    // Fetch last repayment date
                                                    // LoanRepayments.Reset();
                                                    // LoanRepayments.SetRange("Loan No", LoansRec."Loan No.");
                                                    // LoanRepayments.SetRange("Transaction Type", LoanRepayments."Transaction Type"::Repayment);
                                                    // LoanRepayments.SetFilter("Posting Date", '<=%1', PostingDate);
                                                    // LoanRepayments.SetCurrentKey("Posting Date");

                                                    // if LoanRepayments.FindLast() then
                                                    //     LastRepaymentDate := LoanRepayments."Posting Date"
                                                    // else
                                                    //     // No repayment made
                                                    //     LastRepaymentDate := LoansRec."Disbursement Date";


                                                    // //  Stop interest accrual if no payment for the past 3 smonthsP

                                                    // if (LastRepaymentDate <> 0D) then begin
                                                    //     if (CalcDate('<+3M>', LastRepaymentDate) < PostingDate) then
                                                    //         IntCharged := 0;
                                                    // end;

                                                    if IntCharged > 0 then begin
                                                        Dim1 := LoansRec."Global Dimension 1 Code";
                                                        Dim2 := LoansRec."Global Dimension 2 Code";

                                                        if (Dim2 = '') or (Dim1 = '') then begin
                                                            UserSetup.Reset;
                                                            UserSetup.SetRange("User ID", LoansRec."Posted By");
                                                            if UserSetup.FindFirst then begin
                                                                Dim1 := UserSetup."Global Dimension 1 Code";
                                                                Dim2 := UserSetup."Global Dimension 2 Code";
                                                            end;
                                                        end;
                                                        LoansRecInterest.Reset();
                                                        LoansRecInterest.SetRange("Loan No.", LoansRec."Loan No.");
                                                        //LoansRecInterest.SetRange(LoansRecInterest."Interest Date", "Interest Header"."Posting Date");
                                                        LoansRecInterest.setrange(No, "Interest Header"."No.");

                                                        if not LoansRecInterest.Find('-') then begin
                                                            LoansRecInterest.Init;
                                                            LoansRecInterest.No := "Interest Header"."No.";
                                                            LoansRecInterest."Entry No" := LoansRecInterest."Entry No" + 1;
                                                            LoansRecInterest."Loan No." := LoansRec."Loan No.";
                                                            LoansRecInterest."Account No" := LoansRec."Loan Account";
                                                            LoansRecInterest."Emp code" := LoansRec."Employer Code";
                                                            LoansRecInterest."Issued Date" := LoansRec."Disbursement Date";
                                                            LoansRecInterest."Loan Product type" := LoansRec."Loan Product Type";
                                                            LoansRecInterest."Interest Date" := "Interest Header"."Interest Due Date";
                                                            LoansRecInterest."Issued Date" := LoansRec."Disbursement Date";
                                                            LoansRecInterest.Posted := false;

                                                            // Grace Period Interest Handling
                                                            if Format(ProductFactory."Grace Period - Interest") <> '' then begin
                                                                if CalcDate(ProductFactory."Grace Period - Interest", LoansRec."Disbursement Date") <= PostingDate then
                                                                    LoansRecInterest."Interest Bill" := IntCharged
                                                                else
                                                                    LoansRecInterest."Interest Bill" := 0;
                                                            end else begin
                                                                LoansRecInterest."Interest Bill" := IntCharged;
                                                            end;

                                                            LoansRecInterest."Interest Amount" := IntCharged;
                                                            LoansRecInterest."Interest Rate" := LoansRec.Interest;
                                                            LoansRecInterest."Member No" := LoansRec."Member No.";
                                                            LoansRecInterest."Outstanding Balance" := LoansRec."Outstanding Balance";
                                                            LoansRecInterest."Outstanding Interest" := LoansRec."Outstanding Interest";
                                                            LoansRecInterest.Status := Members.Status;
                                                            LoansRecInterest.Blocked := Members.Blocked;
                                                            LoansRecInterest."Account Type" := LoansRecInterest."account type"::Credit;
                                                            LoansRecInterest."Account No" := LoansRec."Loan Account";
                                                            LoansRecInterest."Shortcut Dimension 1 Code" := Dim1;
                                                            LoansRecInterest."Shortcut Dimension 2 Code" := Dim2;
                                                            LoansRecInterest."Monthly Repayment" := LoansRec.Repayment;
                                                            LoansRecInterest."Outstanding Balance" := LoansRec."Outstanding Balance";
                                                            LoansRecInterest."Outstanding Interest" := LoansRec."Outstanding Interest";

                                                            if LoansRecInterest."Interest Amount" > 0 then
                                                                LoansRecInterest.Insert;
                                                        end;
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                            end;
                        end;
                    end;

                end;


                trigger OnPostDataItem()
                begin

                    Message('Process Complete');

                end;
            }

            trigger OnAfterGetRecord()
            begin
                LoansRecInterest.Reset();
                LoansRecInterest.SetRange(LoansRecInterest.No, "Interest Header"."No.");
                LoansRecInterest.DeleteAll();
            end;
        }

    }


    labels
    {
    }

    trigger OnPreReport()
    var
        SeriesSetup: Record "Credit Nos. Series";
    begin

    end;

    var
        LoanType: Record "Product Factory";
        Gnljnline: Record "Gen. Journal Line";
        LineNo: Integer;
        DocNo: Code[20];
        HeaderNo: Code[30];
        PDate: Date;
        LoansRecCaptionLbl: label 'LoansRec';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        VarienceCaptionLbl: label 'Varience';
        "Document No.": Code[20];
        RecBuffer: Record "Interest Header";
        LoanAmount: Decimal;
        BillAmount: Decimal;
        CustMember: Record "Credit Accounts";
        Text001: label 'Document No. Must be equal to No.';
        CurrDate: Date;
        FirstMonthDate: Date;
        CurrMonth: Date;
        MidDate: Date;
        EndDate: Date;
        LastMonthDate: Date;
        FirstDay: Date;
        FirstDate: Date;
        LoansRecInterest: Record "Loans Interest";
        IntCharged: Decimal;
        Principle: Decimal;
        SuspendedInterestAccounts: Record "Suspended Interest Accounts";
        MonthDays: Integer;
        InterestDuePeriod: Record "Interest Due Period";

        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
        Generating: Label 'Task Progress ...';
        diaProgress: Dialog;
        intProgress: Integer;
        //Members: Record "Members";
        //GeneralSetUp: Record "General Set-Up";
        //Memb: Record "Members";
        Dim1: Code[50];
        Dim2: Code[50];
        PostingDate: Date;
        ProductFactory: Record "Product Factory";
        Members: Record Members;
        LoanRepayments: record "Credit Ledger Entry";
        LoansRec: record Loans;
        AmountInArrearsSACCO: Decimal;
        AmountInArrearsSASRA: Decimal;

        LastRepaymentDate: Date;
}
