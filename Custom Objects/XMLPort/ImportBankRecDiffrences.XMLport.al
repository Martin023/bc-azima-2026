#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185436 "Import Bank Rec Diffrences"
{
    Direction = Import;
    Format = VariableText;
    UseRequestPage = false;

    schema
    {
        textelement(Journr)
        {
            tableelement("Bank Acc. Reconciliation Line"; "Bank Acc. Reconciliation Line")
            {
                AutoUpdate = true;
                XmlName = 'Journal';
                fieldelement(TransDate; "Bank Acc. Reconciliation Line"."Transaction Date")
                {
                }
                fieldelement(BankAccountNo; "Bank Acc. Reconciliation Line"."Bank Account No.")
                {
                    FieldValidate = yes;

                    trigger OnAfterAssignField()
                    begin

                        CounterVar += 1;
                    end;
                }
                fieldelement(StatementNo; "Bank Acc. Reconciliation Line"."Statement No.")
                {
                }
                fieldelement(TransDescription; "Bank Acc. Reconciliation Line".Description)
                {
                }
                fieldelement(StatementAmount; "Bank Acc. Reconciliation Line"."Statement Amount")
                {
                    FieldValidate = yes;

                    trigger OnAfterAssignField()
                    begin

                        "Bank Acc. Reconciliation Line"."Applied Amount" := "Bank Acc. Reconciliation Line"."Statement Amount";
                        // "Bank Acc. Reconciliation Line".Type := "Bank Acc. Reconciliation Line".Type::Difference;
                        "Bank Acc. Reconciliation Line"."Statement Line No." := fn_GetLastLineNo;
                    end;
                }
                fieldelement(DocumentNo; "Bank Acc. Reconciliation Line"."Document No.")
                {
                }
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

    trigger OnPostXmlPort()
    begin

        Message('%1 Records Imported', CounterVar);
    end;

    trigger OnPreXmlPort()
    begin

        CounterVar := 0;
    end;

    var
        CounterVar: Integer;

    local procedure fn_GetLastLineNo(): Integer
    var
        BRECLines_4: Record "Bank Acc. Reconciliation Line";
    begin
        BRECLines_4.Reset;
        BRECLines_4.SetRange("Bank Account No.", "Bank Acc. Reconciliation Line"."Bank Account No.");
        BRECLines_4.SetRange("Statement No.", "Bank Acc. Reconciliation Line"."Statement No.");
        if BRECLines_4.Find('+') then begin
            exit(BRECLines_4."Statement Line No." + 1);
        end else begin
            exit(1000);
        end;
    end;
}
