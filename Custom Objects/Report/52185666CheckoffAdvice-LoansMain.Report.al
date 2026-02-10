#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185666 "Checkoff Advice - Loans Main"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Checkoff Advice - Loans Main.rdl';

    dataset
    {
        dataitem("Checkoff Advice Header"; "Checkoff Advice Header")
        {
            RequestFilterFields = "No.";

            dataitem("Checkoff Advice Line"; "Checkoff Advice Line")
            {
                DataItemLink = "Advice Header No." = field("No.");
                DataItemTableView = sorting("Entry No", "Advice Date", Time, "Member No.") order(ascending);
                RequestFilterFields = "Employer Code";
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
                column(EmployerAccountNo; EmployerAccountNo)
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
                column(BookNo; BookNo)
                {
                }
                column(SADNo_CheckoffAdviceLine; SADNo)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    "Checkoff Advice Line".CalcFields("SAD No.");
                    SADNo := "Checkoff Advice Line"."SAD No.";
                    Amount := 0;

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
                                if "Checkoff Advice Line"."Advice Type" = "Checkoff Advice Line"."advice type"::Refeeding then begin
                                    NarationCode := Format("Checkoff Advice Line"."Employer Code") + 'NEW LOAN';
                                    TransCode := 1;
                                    ActionCode := '12';
                                end else
                                    if "Checkoff Advice Line"."Advice Type" = "Checkoff Advice Line"."advice type"::Variations then begin
                                        NarationCode := Format("Checkoff Advice Line"."Employer Code") + 'VARIATION';
                                        ActionCode := '2';
                                        TransCode := 1;
                                    end;
                    if Loans.Get("Checkoff Advice Line"."Loan No.") then begin
                        if (Loans."Interest Calculation Method" = Loans."interest calculation method"::"Reducing Flat") or
                          (Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised) then
                            IntCode := 1
                        else
                            IntCode := 0;
                    end;
                    //IF Turn=2 THEN CurrReport.SKIP
                    EDcode := Company."ED Code";
                    SaccoCode := Company."Sacco Code";
                    BookNo := CopyStr("Checkoff Advice Line"."Payroll No", 10, 1);
                    if "Checkoff Advice Line"."Employer Account No." = '' then
                        EmployerAccountNo := "Checkoff Advice Line"."Account No." else
                        EmployerAccountNo := "Checkoff Advice Line"."Employer Account No.";
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
        EmployerAccountNo: Code[50];
        SADNo: Code[30];
}
