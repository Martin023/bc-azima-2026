#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185681 "Process Cheques"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Process Cheques.rdl';

    dataset
    {
        dataitem("Inward file Buffer"; "Inward file Buffer")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin

                BOSANO := '';
                BOSANO := CopyStr("Inward file Buffer"."Account No", 3, 5);
                //Confirm if cheque has been issued before
                CheqReg.Reset;
                CheqReg.SetRange(CheqReg."Cheque No.", "Inward file Buffer"."Cheque No");
                if CheqReg.Find('-') then begin
                    if (CheqReg.Status = CheqReg.Status::Cancelled) or (CheqReg.Status = CheqReg.Status::stopped) then begin
                        Message('The cheque no. %1 for %2 is either cancelled or stopped', "Inward file Buffer"."Cheque No", BOSANO);
                    end else begin
                        if CheqReg.Status <> CheqReg.Status::Pending then
                            Message('The cheque no. %1 for %2 is already used', "Inward file Buffer"."Cheque No", BOSANO);
                    end;

                end else
                    Message('The cheque no.%1  does not exist', "Inward file Buffer"."Cheque No");


                Translation.Reset;
                Translation.SetRange(Translation.Code, BOSANO);
                if Translation.Find('-') then begin

                    ChequeLines.Init;
                    ChequeLines."Chq Receipt No" := "Inward file Buffer"."Transaction Code2";
                    ChequeLines."Cheque Serial No" := "Inward file Buffer"."Cheque No";

                    Vend.Reset;
                    Vend.SetRange(Vend."Member No.", Translation."Member No");
                    Vend.SetRange(Vend."Product Category", Vend."product category"::" ");
                    Vend.SetFilter(Vend."Product Type", '801');
                    if Vend.Find('-') then begin
                        ChequeLines."Account No." := Vend."No.";
                        ChequeLines."Account Name" := Vend.Name;
                    end else
                        Error('Account Number %1 does not exist', BOSANO);
                    ChequeLines."Date _Refference No." := "Inward file Buffer"."Serial No";
                    ChequeLines."Transaction Code" := "Inward file Buffer"."Transaction Code";
                    ChequeLines."Branch Code" := "Inward file Buffer"."Branch Code";
                    ChequeLines.Currency := "Inward file Buffer".Currency;
                    ChequeLines.Amount := "Inward file Buffer".Amount;
                    Evaluate(ChequeLines."Date-1", "Inward file Buffer"."Date Code1");
                    //ChequeLines."Family Routing No.":="Inward file Buffer".Field15;
                    ChequeLines.Fillers := "Inward file Buffer"."Bank Code 2";
                    ChequeLines."Transaction Refference" := "Inward file Buffer"."Branch Code 3";
                    ChequeLines."Family Account No." := "Inward file Buffer"."Account No";
                    ChequeLines.Insert;

                end;
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        ChequeLines: Record "Cheque Issue Lines";
        Vend: Record "Savings Accounts";
        BOSANO: Code[10];
        CheqReg: Record "Cheques Register";
        Translation: Record "Data Translation";
}
