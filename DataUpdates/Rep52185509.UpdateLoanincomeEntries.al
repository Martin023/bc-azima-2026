namespace AZIMA.AZIMA;
using Microsoft.Finance.GeneralLedger.Ledger;

report 52185509 "Update Loan income Entries"
{
    ApplicationArea = All;
    Caption = 'Update Loan income Entries';
    UsageCategory = Lists;
    dataset
    {
        dataitem(Loans; Loans)
        {
            column(LoanNo; "Loan No.")
            {
            }
            trigger OnAfterGetRecord()
            begin
                CreditLedger.reset();
                CreditLedger.setrange("Loan No", Loans."Loan No.");
                Creditledger.setrange("Transaction Type", CreditLedger."Transaction Type"::"Interest Due");
                if CreditLedger.Findset() then begin
                    repeat
                        CreditLedger."Global Dimension 1 Code" := Loans."Global Dimension 1 Code";
                        CreditLedger."Global Dimension 2 Code" := Loans."Global Dimension 2 Code";
                        CreditLedger.Modify();

                        GlEntry.reset();
                        GlEntry.SetRange(GlEntry."Entry No.", CreditLedger."Entry No.");
                        if GlEntry.FindFirst() then begin
                            GlEntry."Global Dimension 1 Code" := Loans."Global Dimension 1 Code";
                            GlEntry."Global Dimension 2 Code" := Loans."Global Dimension 2 Code";
                            GlEntry.Modify();
                        end;
                    until CreditLedger.Next() = 0;
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
                group(GroupName)
                {
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

    var
        GlEntry: Record "G/L Entry";
        CreditLedger: record "Credit Ledger Entry";
}
