
namespace KenpipeCBS.KenpipeCBS;
using Microsoft.Sales.Customer;

report 52185842 "Recover Overpaid Loans"
{
    ApplicationArea = All;
    Caption = 'Recover Overpaid Loans';
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

                Loans.Reset();
                if EmployerCode <> '' then
                    Loans.SetRange("Employer Code", EmployerCode);
                Loans.CalcFields("Total Balance");
                Loans.SetFilter("Total Balance", '<0');
                // Loans.SetFilter("Recovery Mode", '<>%1', Loans."Recovery Mode"::Dividend);
                if Loans.FindFirst() then begin
                    repeat
                        SavAcc.reset;
                        SavAcc.SetRange("Member No.", loans."Member No.");
                        SavAcc.SetRange("Product Type", '001');
                        if SavAcc.FindFirst() then begin
                            // if AvAmt > 0 then begin
                            Loans.CalcFields("Outstanding Interest");
                            if Loans."Outstanding Interest" < 0 then begin
                                LoansInterest.Init();
                                LoansInterest."Refund Header No." := "Interest Header"."No";
                                LoansInterest."Member No." := loans."Member No.";
                                LoansInterest."No." += 1;
                                LoansInterest."Source Loan Transaction." := LoansInterest."Source Loan Transaction."::"Interest Due";
                                LoansInterest."Source Loan No." := Loans."Loan No.";
                                LoansInterest."Source Account" := '';
                                LoansInterest."Destination Account" := SavAcc."No.";
                                LoansInterest."Loan No." := '';
                                LoansInterest."Destination Description" := '';
                                LoansInterest.Amount := -(Loans."Outstanding Interest");
                                if LoansInterest.Amount > 0 then
                                    LoansInterest.Insert(true);
                            end;
                            loans.CalcFields("Outstanding Balance");
                            if Loans."Outstanding Balance" < 0 then begin
                                LoansInterest.Init();
                                LoansInterest."Refund Header No." := "Interest Header"."No";
                                LoansInterest."Member No." := loans."Member No.";
                                LoansInterest."No." += 1;
                                LoansInterest."Source Loan Transaction." := LoansInterest."Source Loan Transaction."::Loan;
                                LoansInterest."Source Account" := '';
                                LoansInterest."Destination Account" := SavAcc."No.";
                                LoansInterest."Loan No." := '';
                                LoansInterest."Source Loan No." := Loans."Loan No.";
                                LoansInterest.Amount := -(Loans."Outstanding Balance");
                                LoansInterest."Destination Account" := SavAcc."No.";
                                LoansInterest."Loan No." := '';
                                LoansInterest."Destination Description" := '';
                                if LoansInterest.Amount > 0 then
                                    LoansInterest.Insert(true);

                            end;
                        end;
                    // end;
                    until Loans.Next() = 0;
                end;
            end;
            //                 end;
            //             end;
            //         until SavAcc.Next() = 0;
            //     end;
            // end;

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
                    field(EmployerCode; EmployerCode)
                    {
                        Caption = 'Employer Code';
                        tablerelation = Customer where("Account Type" = const("Employer Code"));
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