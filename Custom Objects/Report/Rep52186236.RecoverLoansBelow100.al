namespace KenpipeCBS.KenpipeCBS;
using Microsoft.Sales.Customer;

report 52186236 "Recover Loans Below 100"
{
    ApplicationArea = All;
    Caption = 'Recover Loans Below Amount';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem("Interest Header"; "Refund,Account Transfer Header")
        {
            RequestFilterFields = No;
            trigger OnAfterGetRecord()
            begin
                LoansInterest.reset();
                LoansInterest.setrange("Refund Header No.", "Interest Header"."No");
                if LoansInterest.findset then
                    LoansInterest.DeleteAll();

                SavAcc.reset;
                SavAcc.SetRange("Product Type", '191');
                if EmployerCode <> '' then
                    SavAcc.SetRange("Employer Code", EmployerCode);
                if SavAcc.Findset() then begin
                    repeat
                        // AmtDed := 0;
                        AvAmt := 0;
                        AvAmt := SavAcc.GetAvailableBalance(SavAcc."No.");
                        if Members.get(SavAcc."Member No.") then begin
                            if Members.Status <> Members.Status::Deceased then begin
                                Loans.Reset();
                                Loans.SetRange("Member No.", SavAcc."Member No.");
                                Loans.CalcFields("Total Balance");
                                Loans.SetFilter("Total Balance", '1..%1', AmountToRecover);
                                Loans.SetFilter("Recovery Mode", '<>%1', Loans."Recovery Mode"::Dividend);
                                if Loans.FindFirst() then begin
                                    repeat
                                        if AvAmt > 0 then begin
                                            Loans.CalcFields("Outstanding Interest");
                                            if Loans."Outstanding Interest" > 0 then begin
                                                LoansInterest.Init();
                                                LoansInterest."Refund Header No." := "Interest Header"."No";
                                                LoansInterest."Member No." := loans."Member No.";
                                                LoansInterest."No." += 1;
                                                LoansInterest."Source Loan Transaction." := LoansInterest."Source Loan Transaction."::" ";
                                                LoansInterest."Source Account" := SavAcc."No.";
                                                if AvAmt >= loans."Outstanding Interest" then
                                                    LoansInterest.Amount := -(Loans."Outstanding Interest")
                                                else
                                                    LoansInterest.Amount := AvAmt;
                                                LoansInterest."Destination Account" := '';
                                                LoansInterest."Loan No." := Loans."Loan No.";
                                                LoansInterest.Description := "Interest Header".Description;
                                                if LoansInterest.Amount > 0 then
                                                    LoansInterest.Insert(true);
                                                AvAmt -= LoansInterest.Amount;
                                                AmtDed += LoansInterest.Amount;
                                            end;
                                            loans.CalcFields("Outstanding Balance");
                                            if Loans."Outstanding Balance" > 0 then begin
                                                if AvAmt > 0 then begin
                                                    LoansInterest.Init();
                                                    LoansInterest."Refund Header No." := "Interest Header"."No";
                                                    LoansInterest."Member No." := loans."Member No.";
                                                    LoansInterest."No." += 1;
                                                    LoansInterest."Source Loan Transaction." := LoansInterest."Source Loan Transaction."::" ";
                                                    LoansInterest."Source Account" := SavAcc."No.";
                                                    if AvAmt >= loans."Outstanding Balance" then
                                                        LoansInterest.Amount := -(Loans."Outstanding Balance")
                                                    else
                                                        LoansInterest.Amount := AvAmt;

                                                    LoansInterest."Destination Account" := '';
                                                    LoansInterest."Loan No." := Loans."Loan No.";
                                                    LoansInterest.Description := "Interest Header".Description;
                                                    if LoansInterest.Amount > 0 then
                                                        LoansInterest.Insert(true);
                                                    AvAmt -= LoansInterest.Amount;
                                                    AmtDed += LoansInterest.Amount;
                                                end;
                                            end;
                                        end;
                                    until Loans.Next() = 0;
                                end;
                            end;
                        end;
                    until SavAcc.Next() = 0;
                end;
            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin
                Message('Generation Complete');
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
                group(GroupName)
                {
                    field(AmountToRecover; AmountToRecover)
                    {
                        Caption = 'Amount To Recover';
                        ApplicationArea = Basic, Suite;
                    }
                    field(EmployerCode; EmployerCode)
                    {
                        Caption = 'Employer Code';
                        tablerelation = Customer where("Account Type" = const(Employer));
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
        }
    }
    var
        LoansInterest: Record "refund,Account Transfer lines";
        loans: Record Loans;
        FosaAcc: Record "Savings Accounts";
        members: Record Members;
        RefundHeader: Record "Refund,Account Transfer Header";
        GettheFilters: Text;
        EmployerCode: Code[50];
        SavAcc: record "Savings Accounts";
        AvAmt: Decimal;
        AmtDed: Decimal;

        AmountToRecover: Decimal;
}