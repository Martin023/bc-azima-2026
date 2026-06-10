#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185656 "Checkoff Advice - Loans"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Checkoff Advice - Loans.rdl';

    dataset
    {
        dataitem("Checkoff Advice Header"; "Checkoff Advice Header")
        {
            RequestFilterFields = "No.";
            column(EmployerName; EmployerName)
            {
            }

            dataitem("Checkoff Advice Line"; "Checkoff Advice Line")
            {
                DataItemLink = "Advice Header No." = field("No.");
                RequestFilterFields = "Employer Code";

                column(MemberNo; "Checkoff Advice Line"."Member No.")
                {
                }
                column(PayrollNo; "Checkoff Advice Line"."Payroll No")
                {
                }
                column(AmountOn; "Checkoff Advice Line"."Amount On")
                {
                }

                column(BalanceOn; "Checkoff Advice Line"."Balance On")
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

                column(Work_Station; "Work Station")
                {
                }
                column(Reference; Reference)
                {
                }
                column(Product_Type; "Product Type")
                {
                }
                column(Loan_No_; "Loan No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Amount := 0;
                    ApprovedAmount := 0;

                    if ProductFactory.Get("Checkoff Advice Line"."Product Type") then begin
                        if ProductFactory."Product Class Type" = ProductFactory."product class type"::Savings then
                            CurrReport.Skip;
                    end;

                    // if Members.Get("Checkoff Advice Line"."Member No.") then begin
                    //     CheckoffAdviceLine.Reset;
                    //     CheckoffAdviceLine.SetCurrentkey("Member No.");
                    //     CheckoffAdviceLine.SetRange("Advice Header No.", "Checkoff Advice Header"."No.");
                    //     CheckoffAdviceLine.SetRange("Member No.", Members."No.");
                    //     if CheckoffAdviceLine.Find('-') then begin
                    //         repeat
                    //             MemberNo := CheckoffAdviceLine."Member No.";
                    //             Name := CheckoffAdviceLine.Names;
                    //             Amount := Amount + CheckoffAdviceLine."Amount On" + CheckoffAdviceLine.Interest;
                    //         until CheckoffAdviceLine.Next = 0;
                    //     end;
                    // end;

                    // if "Checkoff Advice Line"."Advice Type" = "Checkoff Advice Line"."advice type"::Adjustment then begin
                    //     NarationCode := Format("Checkoff Advice Line"."Employer Code") + 'ADJUSTMENT';
                    //     ActionCode := '5';
                    //     TransCode := 1;

                    // end else
                    //     if "Checkoff Advice Line"."Advice Type" = "Checkoff Advice Line"."advice type"::Stoppage then begin
                    //         NarationCode := Format("Checkoff Advice Line"."Employer Code") + 'STOPPAGE';
                    //         ActionCode := '3';
                    //         TransCode := 1;
                    //     end else
                    //         if "Checkoff Advice Line"."Advice Type" = "Checkoff Advice Line"."advice type"::"New Loan" then begin
                    //             NarationCode := Format("Checkoff Advice Line"."Employer Code") + 'NEW LOAN';
                    //             TransCode := 2;
                    //             ActionCode := '12';
                    //         end else
                    //             if "Checkoff Advice Line"."Advice Type" = "Checkoff Advice Line"."advice type"::Variations then begin
                    //                 NarationCode := Format("Checkoff Advice Line"."Employer Code") + 'VARIATION';
                    //                 ActionCode := '2';
                    //                 TransCode := 1;
                    //             end;
                    // if Loans.Get("Checkoff Advice Line"."Loan No.") then begin
                    //     ApprovedAmount := Loans."Approved Amount";
                    //     if (Loans."Interest Calculation Method" = Loans."interest calculation method"::"Reducing Flat") or
                    //       (Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised) then
                    //         IntCode := 1
                    //     else
                    //         IntCode := 0;
                    //     if Loans."Moratorium Loan" = true then begin
                    //         Moratorium := Loans."Moratorium Loan";
                    //         StartDatemoratorium := Loans."Moratorium Start Date";
                    //         EndDateMoratorium := Loans."Moratorium End date";
                    //     end;

                    // end;
                    //IF Turn=2 THEN CurrReport.SKIP
                    EDcode := Company."ED Code";
                    SaccoCode := Company."Sacco Code";
                    BookNo := CopyStr("Checkoff Advice Line"."Payroll No", 10, 1);
                end;

                trigger OnPreDataItem()
                begin
                    i := 1;
                    if "Checkoff Advice Header"."Employer Code" <> '' then begin
                        EmployerName := "Checkoff Advice Header"."Employer Code";
                        "Checkoff Advice Line".SetRange("Employer Code", "Checkoff Advice Header"."Employer Code");
                    end
                    else
                        EmployerName := '';
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
        EmployerName: Text;

}
