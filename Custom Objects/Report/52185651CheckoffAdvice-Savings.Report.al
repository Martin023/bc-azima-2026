Report 52185651 "Checkoff Advice - Savings"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Checkoff Advice - Savings.rdl';
    UsageCategory = Lists;
    ApplicationArea = All;
    dataset
    {
        dataitem("Checkoff Advice Header"; "Checkoff Advice Header")
        {
            RequestFilterFields = "No.";

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
                column(Name; "Checkoff Advice Line".Names)
                {
                }
                column(AmountOn; "Checkoff Advice Line"."Amount On")
                {
                }
                column(AmountOff; "Checkoff Advice Line"."Amount Off")
                {
                }
                column(BalanceOn; Amount)
                {
                }
                column(BalaceOff; "Checkoff Advice Line"."Balance Off")
                {
                }
                column(ProductFactory; ProdName)
                {
                }
                column(CompanyNameS; Company.Name)
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
                column(Narration; "Checkoff Advice Line"."Advice Type")
                {
                }
                column(BookNo; BookNo)
                {
                }
                column(Reference; Reference)
                {
                }
                column(Remarks; "Variation Action")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Amount := 0;
                    if ProductFactory.Get("Checkoff Advice Line"."Product Type") then begin
                        if ProductFactory."Product Class Type" = ProductFactory."product class type"::Loan then
                            CurrReport.Skip;
                        ProdName := ProductFactory."Product Description"
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

                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange("No.", "Checkoff Advice Line"."Account No.");
                    SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                    if SavingsAccounts.Find('-') then begin

                        SavingsAccounts2.Reset;
                        SavingsAccounts2.SetRange("Member No.", SavingsAccounts."Member No.");
                        SavingsAccounts2.SetRange("Product Category", SavingsAccounts2."product category"::"Share Capital");
                        if SavingsAccounts2.Find('-') then begin

                            SavingsAccounts2.CalcFields("Balance (LCY)");
                            Amount +=/*SavingsAccounts2."Balance (LCY)"+*/"Checkoff Advice Line"."Balance On";
                            //MESSAGE('t%1',Amount);
                        end;
                    end;
                    //IF Turn=2 THEN CurrReport.SKIP
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
        ProdName: Text;
        SavingsAccounts: Record "Savings Accounts";
        SavingsAccounts2: Record "Savings Accounts";
        BookNo: Code[10];
        DODCode: Option " ",Army,Officers,Navy,"Army-Const","Air Force";
        KDFNo: Integer;
        MYPf: Integer;
}
