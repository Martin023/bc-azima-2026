#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185748 "Update Payroll Deductions"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Update Payroll Deductions';
    RDLCLayout = './bc-azima-2026/Layout/Update Payroll Deductions.rdl';

    dataset
    {
        dataitem("PR Employee Transactions"; "PR Employee Transactions")
        {
            RequestFilterFields = "Employee Code";
            column(Transaction_Code; "Transaction Code")
            {
            }
            column(Employee_Code; "Employee Code")
            {
            }
            dataitem(Loans; Loans)
            {
                DataItemLink = "Staff No" = field("Employee Code");

                //DataItemTableView= where("Source Unit" = filter("HR LOANS");

                column(Loan_No_; "Loan No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    loans.Reset();
                    loans.SetRange("Staff No", "Employer Code");
                    if loans.FindSet then begin
                        repeat
                            if Loans.Get("Staff No") then begin
                                Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest");
                                if (Loans."Outstanding Balance" > 0) or (Loans."Outstanding Interest" > 0) then begin
                                    "PR Employee Transactions".Init();
                                    "PR Employee Transactions"."Loan Number" := "Loan No.";
                                    "PR Employee Transactions"."Interest Due" := "Outstanding Interest";
                                    "PR Employee Transactions"."Loan Interest Rate" := interest;
                                    "PR Employee Transactions".Amount := "Outstanding Balance";
                                    "PR Employee Transactions"."Original Amount" := "Approved Amount";
                                    "PR Employee Transactions"."Start Date" := "Repayment Start Date";
                                    "PR Employee Transactions"."End Date" := "Expected Date of Completion";
                                    "PR Employee Transactions"."Loan Interest Rate" := Interest;
                                    PRTransactionCodes.Reset();
                                    PRTransactionCodes.setrange(PRTransactionCodes."Transaction Name", "PR Employee Transactions"."Transaction Name");
                                    if PRTransactionCodes.FindFirst() then begin
                                        "PR Employee Transactions"."Transaction Code" := PRTransactionCodes."Transaction Code";
                                    end;
                                    "PR Employee Transactions".Insert();
                                end;
                            end;
                        until loans.next = 0;
                    end;

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

    var
        Members: Record "Members";

        PRTransactionCodes: Record "PR Transaction Codes";

}
