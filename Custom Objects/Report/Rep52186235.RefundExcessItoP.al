namespace KenpipeCBS.KenpipeCBS;
using Microsoft.Sales.Customer;

report 52186235 "Refund Excess I to P"
{
    ApplicationArea = All;
    Caption = 'Refund Excess I to P';
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
                Loans.SetFilter("Total Balance", '>0');
                if Loans.FindFirst() then begin
                    repeat
                        Loans.CalcFields("Outstanding Interest");
                        if Loans."Outstanding Interest" < 0 then begin
                            if Loans."Outstanding Balance" > 0 then begin
                                LoansInterest.Init();
                                LoansInterest."Refund Header No." := "Interest Header"."No";
                                LoansInterest."Member No." := loans."Member No.";
                                LoansInterest."No." += 1;
                                LoansInterest."Source Loan Transaction." := LoansInterest."Source Loan Transaction."::"Interest Due";
                                LoansInterest."Source Account" := Loans."Loan Account";
                                LoansInterest.Amount := -(Loans."Outstanding Interest");
                                LoansInterest."Destination Account" := Loans."Loan Account";
                                LoansInterest."Loan No." := Loans."Loan No.";
                                LoansInterest."Destination Description" := "Interest Header".Description;
                                if LoansInterest.Amount > 0 then
                                    LoansInterest.Insert(true);
                            end
                            else begin
                                // Send to Unallocated.
                                LoansInterest.Init();
                                LoansInterest."Refund Header No." := "Interest Header"."No";
                                LoansInterest."Member No." := loans."Member No.";
                                LoansInterest."No." += 1;
                                LoansInterest."Source Loan Transaction." := LoansInterest."Source Loan Transaction."::"Interest Due";
                                LoansInterest."Source Account" := Loans."Loan Account";
                                LoansInterest.Amount := -(Loans."Outstanding Interest");
                                LoansInterest."Destination Account" := Loans."Loan Account";
                                LoansInterest."Loan No." := Loans."Loan No.";
                                LoansInterest."Destination Description" := "Interest Header".Description;
                                if LoansInterest.Amount > 0 then
                                    LoansInterest.Insert(true);
                            end;
                        end;
                    until Loans.Next() = 0;
                end;

            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin
                Message('Process Complete');
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
                    // field(CheckoffHeader; CheckoffHeader)
                    // {
                    //     Caption = 'Checkoff Header No.';
                    //     tablerelation = "Checkoff Header" where(Posted = filter(true), "CheckOff Type" = const(Loans));
                    // }
                    field(EmployerCode; EmployerCode)
                    {
                        Caption = 'Employer Code';
                        tablerelation = Customer where("Account Type" = const(Employer));
                    }
                }
            }
        }



    }
    trigger OnPreReport()
    var
        SeriesSetup: Record "Credit Nos. Series";
    begin
        LoansInterest.Reset();
        LoansInterest.SetRange(LoansInterest."Refund Header No.", "Interest Header"."No");
        LoansInterest.DeleteAll();


        //if CheckoffHeader = '' then Error('Please Insert checkoff Header before proceeding');
        if EmployerCode = '' then Error('Please Insert Employer Code before proceeding');
    end;


    var
        LoansInterest: Record "refund,Account Transfer lines";
        loans: Record Loans;
        FosaAcc: Record "Savings Accounts";
        members: Record Members;
        RefundHeader: Record "Refund,Account Transfer Header";
        GettheFilters: Text;
        EmployerCode: Code[50];
}
