namespace KenpipeCBS.KenpipeCBS;

report 52186217 "Update Loan Repayment Mode"
{
    ApplicationArea = All;
    Caption = 'Update Loan Repayment Mode';
    UsageCategory = ReportsAndAnalysis;
    processingonly = true;
    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.", "Recovery Mode";
            column(LoanNo; "Loan No.")
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Loans.GetFilters() = '' then
                    Error('Please select the loans to update.');

                if Loans."Recovery Mode" <> NewRepayMode then begin
                    Loans."Recovery Mode" := NewRepayMode;
                    if Loans."Recovery Mode" = Loans."Recovery Mode"::Salary then begin
                        if Loans."Source Unit" = Loans."Source Unit"::FOSA then begin
                            ForTheLoan := false;
                            StanndingOrder.Reset();
                            StanndingOrder.SetRange("Member No.", Loans."Member No.");
                            StanndingOrder.SetRange(Status, StanndingOrder.Status::Approved);
                            if StanndingOrder.FindFirst() then begin
                                repeat
                                    StOLines.Reset();
                                    StOLines.SetRange("Document No.", StanndingOrder."No.");
                                    StOLines.setrange("Loan No.", Loans."Loan No.");
                                    StOLines.SetFilter(Amount, '>0');
                                    if StOLines.FindFirst() then begin
                                        // repeat
                                        ForTheLoan := true;
                                        // until StOLines.Next() = 0;
                                    end;
                                    if ForTheLoan then begin
                                        StanndingOrder.Status := StanndingOrder.Status::Stopped;
                                        StanndingOrder."Stopped By" := UserId();
                                        StanndingOrder.Modify();
                                    end;
                                until StanndingOrder.Next() = 0;
                            end;
                        end
                        else
                            Error('Recovery mode cannot be salary for non FOSA loans.');
                    end;
                    Loans."Repayment Mode Updated By" := UserId();
                    Loans.Modify();
                end;
            end;
        }
    }


    requestpage
    {
        layout
        {
            area(Content)
            {
                group(NewLoanRepaymentMode)
                {
                    Caption = 'New Loan Repayment Mode';
                    field(NewRepayMode; NewRepayMode)
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the loan number.';
                        ShowMandatory = true;
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    trigger OnpreReport()
    begin
        if NewRepayMode = NewRepayMode::" " then
            Error('Please select a new loan repayment mode.');
    end;

    trigger OnPostReport()
    begin
        Message('Loan repayment mode updated successfully.');
    end;

    var
        NewRepayMode: Enum "Loan Recovery Mode";
        StanndingOrder: record "Standing Order Header";
        StOLines: record "Standing Order Lines";
        ForTheLoan: Boolean;
}
