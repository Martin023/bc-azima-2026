#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185497 "Inward File Import"
{
    Direction = Import;
    FieldSeparator = '|';
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Inward file Buffer"; "Inward file Buffer")
            {
                XmlName = 'Inwrdfile';
                fieldattribute(ClearingSystem; "Inward file Buffer"."Clearing System")
                {
                }
                fieldattribute(Serial; "Inward file Buffer"."Serial No")
                {
                }
                fieldattribute(TransCode; "Inward file Buffer"."Transaction Code")
                {
                }
                fieldattribute(Branch_Code; "Inward file Buffer"."Branch Code")
                {
                }
                fieldattribute(Account_No; "Inward file Buffer"."Account No")
                {
                }
                fieldattribute(Branch_Code_2; "Inward file Buffer"."Branch Code 2")
                {
                }
                fieldattribute(CheqNo; "Inward file Buffer"."Cheque No")
                {
                }
                fieldattribute(Currency; "Inward file Buffer".Currency)
                {
                }
                fieldattribute(Amount; "Inward file Buffer".Amount)
                {
                }
                fieldattribute(DateCode_1; "Inward file Buffer"."Date Code1")
                {
                }
                fieldattribute(DateCode_2; "Inward file Buffer"."Date Code2")
                {
                }
                fieldattribute(Bank_Code; "Inward file Buffer"."Bank Code")
                {
                }
                fieldattribute(Unused_1; "Inward file Buffer"."Unused 1")
                {
                }
                fieldattribute(Unused_2; "Inward file Buffer"."Unused 2")
                {
                }
                fieldattribute(Unused_3; "Inward file Buffer"."Unused 3")
                {
                }
                fieldattribute(Bank_Code_2; "Inward file Buffer"."Bank Code 2")
                {
                }
                fieldattribute(Branch_Code_3; "Inward file Buffer"."Branch Code 3")
                {
                }
                fieldattribute(Unused_4; "Inward file Buffer"."Unused 4")
                {
                }
                fieldattribute(Unused_5; "Inward file Buffer"."Unused 5")
                {
                }
                fieldattribute(Unused_6; "Inward file Buffer"."Unused 6")
                {
                }
                fieldattribute(Unused_7; "Inward file Buffer"."Unused 7")
                {
                }

                trigger OnPreXmlItem()
                begin

                    LineNo := 0;
                    TransactionsImportBuffer.Reset;
                    TransactionsImportBuffer.DeleteAll;
                    TransactionsImportBuffer.Reset;
                    TransactionsImportBuffer.SetRange(TransactionsImportBuffer.CurrentUserID, UserId);
                    if TransactionsImportBuffer.Find('-') then begin
                        TransactionsImportBuffer.DeleteAll;
                    end;



                    ReferenceBuffer.Reset;
                    ReferenceBuffer.SetRange(ReferenceBuffer.CurrUserID, UserId);
                    if ReferenceBuffer.Find('-') then begin
                    end
                    else begin
                        Error('Main transaction reference empty.');
                    end;
                end;

                trigger OnBeforeInsertRecord()
                begin

                    LineNo := LineNo + 1;
                    "Inward file Buffer".CurrentUserID := UserId;
                    "Inward file Buffer".Primary := LineNo;
                    "Inward file Buffer"."Transaction Code2" := ReferenceBuffer."Reference No";
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

    var
        TransactionsImportBuffer: Record "Inward file Buffer";
        ReferenceBuffer: Record "Refference Number";
        LineNo: Integer;
}
