#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185895 "Process Fixed Deposit"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './bc-kenpipe-2024/Layout/Process Fixed Deposit.rdl';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Fixed Deposit Contract"; "Fixed Deposit Contract")
        {
            DataItemTableView = where("Product Category" = const("Fixed Deposit"), "Fixed Deposit Status" = const(Active));//, "Balance (LCY)" = filter(> 0));
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin

                // if "Fixed Deposit Contract".Balance <= 0 then Error('Fixed Deposit Contract must have a a balance of greater 0, current balance is %1.', "Fixed Deposit Contract".Balance);
                // if "Fixed Deposit Contract"."FD Maturity Date" > Today then Error('This Fixed deposit maturity is %1. For payment, proceed to terminate.', "Fixed Deposit Contract"."FD Maturity Date");
                RunDate := "Fixed Deposit Contract"."FD Maturity Date";
                if RunDate = 0D then begin
                    if "Fixed Deposit Contract"."Application Date" = 0D then "Fixed Deposit Contract"."Application Date" := today;
                    if Format("Fixed Deposit Contract"."FD Duration") <> '' then
                        RunDate := CalcDate("Fixed Deposit Contract"."FD Duration", "Fixed Deposit Contract"."Application Date") else
                        RunDate := CalcDate('1D', "Fixed Deposit Contract"."Application Date")
                end;
                IF RunDate = 0D THEN
                    RunDate := TODAY;

                if "Fixed Deposit Contract".get("Fixed Deposit Contract"."No.") then begin
                    if "Fixed Deposit Contract"."FD Maturity Instructions" = "Fixed Deposit Contract"."fd maturity instructions"::"Renew Principal & Interest" then
                        FDManagement.RollOver("Fixed Deposit Contract", RunDate, JTemplate, JBatch)
                    else
                        if "Fixed Deposit Contract"."FD Maturity Instructions" = "Fixed Deposit Contract"."fd maturity instructions"::"Renew Principal" then
                            FDManagement.Renew("Fixed Deposit Contract", RunDate, JTemplate, JBatch)
                        else
                            if "Fixed Deposit Contract"."FD Maturity Instructions" = "Fixed Deposit Contract"."fd maturity instructions"::"Transfer all to Savings" then
                                FDManagement.CloseNonRenewable("Fixed Deposit Contract", RunDate, JTemplate, JBatch);

                end;

                // if "Fixed Deposit Contract"."FD Maturity Instructions" = "Fixed Deposit Contract"."fd maturity instructions"::"Renew Principal & Interest" then
                //     FDManagement.RollOver("Fixed Deposit Contract", RunDate, JTemplate, JBatch)
                // else
                //     if "Fixed Deposit Contract"."FD Maturity Instructions" = "Fixed Deposit Contract"."fd maturity instructions"::"Renew Principal" then
                //         FDManagement.Renew("Fixed Deposit Contract", RunDate, JTemplate, JBatch)
                //     else
                //         if "Fixed Deposit Contract"."FD Maturity Instructions" = "Fixed Deposit Contract"."fd maturity instructions"::"Transfer all to Savings" then
                //             FDManagement.CloseNonRenewable("Fixed Deposit Contract", RunDate, JTemplate, JBatch);
                // Message(Format(RunDate));
                // if CalcDate('-5D', "Fixed Deposit Contract"."FD Maturity Date") = Today then begin
                //     //  SendMessage:=TRUE;
                //     //  LoanGuarantorsandSecurity.RESET;
                //     //  LoanGuarantorsandSecurity.SETRANGE("Savings Account No./Member No.","Fixed Deposit Contract"."No.");
                //     //  IF LoanGuarantorsandSecurity.FIND('-') THEN BEGIN
                //     //    REPEAT
                //     //      IF Loans.GET(LoanGuarantorsandSecurity."Loan No") THEN BEGIN
                //     //        Loans.CALCFIELDS("Outstanding Balance");
                //     //        IF Loans."Outstanding Balance"<>0 THEN
                //     //        SendMessage:=FALSE;
                //     //      END;
                //     //      UNTIL LoanGuarantorsandSecurity.NEXT=0;
                //     //    END;
                //     //    IF SendMessage=TRUE THEN
                //     Members.Get("Fixed Deposit Contract"."Member No.");
                //     msg := 'Your Fixed Deposit will Mature on ' + Format("Fixed Deposit Contract"."FD Maturity Date");
                //     //////SendSMS.SendSms(Source::FIXED_DEPOSIT_MATURITY, Members."Phone No.", msg, Format("Fixed Deposit Contract"."Savings Account No."), '', true, 0, false, 'CBS', "Fixed Deposit Contract"."Savings Account No.", 'CBS');
                // end;
            end;

            trigger OnPreDataItem()
            begin

                // if "Fixed Deposit Contract".Balance <= 0 then Error('Fixed Deposit Contract must have a a balance of greater 0, current balance is %1.', "Fixed Deposit Contract".Balance);
                // if "Fixed Deposit Contract"."FD Maturity Date" > Today then Error('This Fixed deposit maturity is %1. For payment, proceed to terminate.', "Fixed Deposit Contract"."FD Maturity Date");
                // RunDate := "Fixed Deposit Contract"."FD Maturity Date";
                // if RunDate = 0D then begin
                //     if "Fixed Deposit Contract"."Application Date" = 0D then "Fixed Deposit Contract"."Application Date" := today;
                //     if Format("Fixed Deposit Contract"."FD Duration") <> '' then
                //         RunDate := CalcDate("Fixed Deposit Contract"."FD Duration", "Fixed Deposit Contract"."Application Date") else
                //         RunDate := CalcDate('1D', "Fixed Deposit Contract"."Application Date")
                // end;

                if RunDate = 0D then
                    RunDate := Today;


                Temp.Get(UserId);

                JTemplate := Temp."Cashier Journal Template";
                JBatch := Temp."Cashier Journal Batch";

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", JTemplate);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                if GenJournalLine.Find('-') then
                    GenJournalLine.DeleteAll;


                DefaultBatch.Reset;
                DefaultBatch.SetRange(DefaultBatch."Journal Template Name", JTemplate);
                DefaultBatch.SetRange(DefaultBatch.Name, JBatch);
                if DefaultBatch.Find('-') = false then begin

                    DefaultBatch.Init;
                    DefaultBatch."Journal Template Name" := JTemplate;
                    DefaultBatch.Name := JBatch;
                    DefaultBatch.Description := 'Fixed Deposit Journal';
                    DefaultBatch.Validate(DefaultBatch."Journal Template Name");
                    DefaultBatch.Validate(DefaultBatch.Name);
                    DefaultBatch.Insert;
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
        FDManagement: Codeunit "Sacco Transactions";
        RunDate: Date;
        GenJournalLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        JTemplate: Code[10];
        JBatch: Code[10];
        Temp: Record "Banking User Template";

}

