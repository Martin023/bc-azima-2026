#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185656 "Checkoff Advice - Loans"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Checkoff Advice - Loans.rdl';

    dataset
    {
        dataitem("Checkoff Advice Header"; "Checkoff Advice Header")
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_2; 2)
            {
            }
            dataitem("Checkoff Advice Line"; "Checkoff Advice Line")
            {
                DataItemLink = "Advice Header No." = field("No.");
                RequestFilterFields = "Employer Code";
                column(ReportForNavId_1; 1)
                {
                }
                column(Moratorium; Moratorium)
                {

                }
                column(StartDatemoratorium; StartDatemoratorium)
                {

                }
                column(EndDateMoratorium; EndDateMoratorium)
                {

                }
                column(MemberNo; "Checkoff Advice Line"."Member No.")
                {
                }
                column(PayrollNo; "Checkoff Advice Line"."Payroll No")
                {
                }
                column(Name; Name)
                {
                }
                column(AmountOn; "Checkoff Advice Line"."Amount On")
                {
                }
                column(AmountOff; "Checkoff Advice Line"."Amount Off")
                {
                }
                column(BalanceOn; "Checkoff Advice Line"."Balance On")
                {
                }
                column(BalaceOff; "Checkoff Advice Line"."Balance Off")
                {
                }
                column(ProductFactory; CheckoffAdviceLine."Product Name")
                {
                }
                column(Product_Type; "Product Type")
                { }
                column(Loan_No_; "Loan No.")
                {

                }
                column(CompanyName; Company.Name)
                {
                }
                column(CompanyAddress; Company.Address)
                {
                }
                column(ComapnyPicture; Company.Picture)
                {
                }
                column(Period; "Checkoff Advice Header".Period)
                {
                }
                column(EmployerName; "Checkoff Advice Header"."Employer Name")
                {
                }
                column(EmployerAccountNo; "Checkoff Advice Line"."Employer Account No.")
                {
                }
                column(Narration; NarationCode)
                {
                }
                column(VoteNo; "Checkoff Advice Line"."Employer Code")
                {
                }
                column(SaccoCode; SaccoCode)
                {
                }
                column(ApprovedAmount; ApprovedAmount)
                { }
                column(EDcode; EDcode)
                {
                }
                column(TransType; ActionCode)
                {
                }
                column(Interest; IntCode)
                {
                }
                column("Action"; TransCode)
                {
                }
                column(Loan_Interest_Repayment; "Loan Interest Repayment")
                { }
                column(Loan_Principle_Repayment; "Loan Principle Repayment")
                { }
                column(BookNo; BookNo)
                {
                }
                column(Reference; Reference)
                {
                }
                column(Remarks; "Variation Action")
                {
                }
                column(Employer_Code; "Employer Code") { }
                column(Member_No_; "Member No.") { }
                column(Standing_Order_amount; "Standing Order amount")
                {
                }
                column(Total_Loan_Repayment; "Total Loan Repayment")
                { }

                trigger OnAfterGetRecord()
                begin
                    Amount := 0;
                    ApprovedAmount := 0;

                    if ProductFactory.Get("Checkoff Advice Line"."Product Type") then begin
                        if ProductFactory."Product Class Type" = ProductFactory."product class type"::Savings then
                            CurrReport.Skip;
                    end;

                    if Members.Get("Checkoff Advice Line"."Member No.") then begin
                        CheckoffAdviceLine.Reset;
                        CheckoffAdviceLine.SetCurrentkey("Member No.");
                        CheckoffAdviceLine.SetRange("Advice Header No.", "Checkoff Advice Header"."No.");
                        CheckoffAdviceLine.SetRange("Member No.", Members."No.");
                        if CheckoffAdviceLine.Find('-') then begin
                            repeat
                                MemberNo := CheckoffAdviceLine."Member No.";
                                Name := CheckoffAdviceLine.Names;
                                Amount := Amount + CheckoffAdviceLine."Amount On" + CheckoffAdviceLine.Interest;
                            until CheckoffAdviceLine.Next = 0;
                        end;
                    end;

                    if "Checkoff Advice Line"."Advice Type" = "Checkoff Advice Line"."advice type"::Adjustment then begin
                        NarationCode := Format("Checkoff Advice Line"."Employer Code") + 'ADJUSTMENT';
                        ActionCode := '5';
                        TransCode := 1;

                    end else
                        if "Checkoff Advice Line"."Advice Type" = "Checkoff Advice Line"."advice type"::Stoppage then begin
                            NarationCode := Format("Checkoff Advice Line"."Employer Code") + 'STOPPAGE';
                            ActionCode := '3';
                            TransCode := 1;
                        end else
                            if "Checkoff Advice Line"."Advice Type" = "Checkoff Advice Line"."advice type"::"New Loan" then begin
                                NarationCode := Format("Checkoff Advice Line"."Employer Code") + 'NEW LOAN';
                                TransCode := 2;
                                ActionCode := '12';
                            end else
                                if "Checkoff Advice Line"."Advice Type" = "Checkoff Advice Line"."advice type"::Variations then begin
                                    NarationCode := Format("Checkoff Advice Line"."Employer Code") + 'VARIATION';
                                    ActionCode := '2';
                                    TransCode := 1;
                                end;
                    if Loans.Get("Checkoff Advice Line"."Loan No.") then begin
                        ApprovedAmount := Loans."Approved Amount";
                        if (Loans."Interest Calculation Method" = Loans."interest calculation method"::"Reducing Flat") or
                          (Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised) then
                            IntCode := 1
                        else
                            IntCode := 0;
                        if Loans."Moratorium Loan" = true then begin
                            Moratorium := Loans."Moratorium Loan";
                            StartDatemoratorium := Loans."Moratorium Start Date";
                            EndDateMoratorium := Loans."Moratorium End date";
                        end;

                    end;
                    //IF Turn=2 THEN CurrReport.SKIP
                    EDcode := Company."ED Code";
                    SaccoCode := Company."Sacco Code";
                    BookNo := CopyStr("Checkoff Advice Line"."Payroll No", 10, 1);
                end;

                trigger OnPreDataItem()
                begin
                    i := 1;
                end;
            }
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
        Company.Get;
        Company.CalcFields(Picture);
    end;

    var
        ProductFactory: Record "Product Factory";
        Loans: Record Loans;
        Members: Record "Members";
        ClolumHeader: Code[10];
        ColumnValue: Decimal;
        MemberNo: Code[10];
        PayrollNo: Code[10];
        Name: Text;
        Interest: Decimal;
        Amount: Decimal;
        CheckoffAdviceLine: Record "Checkoff Advice Line";
        Turn: Integer;
        CulumnA: array[50] of Code[10];
        Company: Record "Company Information";
        i: Integer;
        EDcode: Code[10];
        SaccoCode: Code[10];
        NarationCode: Text;
        IntCode: Integer;
        ActionCode: Code[10];
        TransCode: Integer;
        BookNo: Code[10];
        Moratorium: Boolean;
        StartDatemoratorium: date;
        EndDateMoratorium: Date;
        ApprovedAmount: Decimal;

}
