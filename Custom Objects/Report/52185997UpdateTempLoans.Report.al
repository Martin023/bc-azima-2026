#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185997 "Update Temp Loans"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Update Temp Loans.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Outstanding Balance" = filter(> 0), "Member No." = filter(''));
            RequestFilterFields = "Loan No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                TempLoans.Reset;
                TempLoans.SetRange("Loan No.", Loans."Loan No.");
                if TempLoans.Find('-') then begin
                    if LoanType.Get(TempLoans."Loan Product Type") then begin
                        CreditLed.Reset();
                        CreditLed.SetRange("Loan No", loans."Loan No.");
                        if CreditLed.Find('-') then begin
                            //  Loans.TRANSFERFIELDS(TempLoans,TRUE);
                            //  Loans.MODIFY;
                            Loans."Member No." := TempLoans."Member No.";
                            Loans."Member Name" := TempLoans."Member Name";
                            Loans."Staff No" := TempLoans."Staff No";
                            Loans."Approved Amount" := TempLoans."Approved Amount";
                            Loans."Requested Amount" := TempLoans."Requested Amount";
                            Loans."Loan Account" := TempLoans."Loan Account";
                            Loans.Installments := TempLoans.Installments;
                            Loans.Interest := TempLoans.Interest;
                            Loans."Interest Calculation Method" := TempLoans."Interest Calculation Method";
                            Loans.Repayment := TempLoans.Repayment;
                            Loans."Loan Principle Repayment" := TempLoans."Loan Principle Repayment";
                            Loans."Loan Interest Repayment" := TempLoans."Loan Interest Repayment";
                            Loans."Application Date" := TempLoans."Application Date";
                            Loans."Disbursement Date" := TempLoans."Disbursement Date";
                            Loans."Repayment Start Date" := TempLoans."Repayment Start Date";
                            Loans."Recovery Mode" := TempLoans."Recovery Mode";
                            Loans."Repayment Frequency" := Loans."repayment frequency"::Monthly;
                            Loans."Loan Product Type" := TempLoans."Loan Product Type";
                            Loans."Loan Product Type Name" := TempLoans."Loan Product Type Name";
                            Loans."Source Unit" := LoanType."Source Unit";
                            Loans."Posted By" := CreditLed."User ID";
                            Loans."Loan Span" := TempLoans."Loan Span";
                            Loans."Disbursement Account No" := TempLoans."Disbursement Account No";
                            Loans."Amount To Disburse" := TempLoans."Amount To Disburse";
                            Loans."Captured By" := TempLoans."Captured By";
                            Loans."Loan Appraised By" := TempLoans."Loan Appraised By";
                            Loans."Approval Date" := TempLoans."Approval Date";
                            Loans."Expected Date of Completion" := TempLoans."Expected Date of Completion";
                            Loans."Batch No." := TempLoans."Batch No.";
                            Loans."Global Dimension 2 Code" := TempLoans."Global Dimension 2 Code";
                            Loans.Status := Loans.Status::Posted;
                            Loans.Posted := true;
                            Loans.Modify;
                        end;
                    end;
                end;
                Message('Loan Entered Here');
            end;
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
        TempLoans: Record "Temp Loans";
        LoanType: Record "Product Factory";
        CreditLed: Record "Credit Ledger Entry";
}
