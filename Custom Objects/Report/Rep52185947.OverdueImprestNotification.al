report 52185947 "Overdue Imprest Notification"
{
    ApplicationArea = All;
    Caption = 'Overdue Imprest Notification';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(StaffImpAcc; Customer)
        {
            CalcFields = "Balance (LCY)";
            DataItemTableView = where("Account type" = filter("Staff Imprest"), "Balance (LCY)" = filter(> 0));
            RequestFilterFields = "No.", Name, "Mobile Phone No.", "Balance (LCY)";

            trigger Onpredataitem()
            begin
                if HeaderNo <> '' then begin
                    ImpHeader.GET(HeaderNo);
                    StaffImpAcc.RESET;
                    StaffImpAcc.Setrange("No.", ImpHeader."Account No.");


                    //Filters := Customer.GetFilters;
                end;

            end;

            trigger OnAfterGetRecord()
            begin
                //  If StaffImpAcc.GetFilter("Date Filter") = '' then
                //         StaffImpAcc.SetFilter("Date Filter", '..%1', Today);
                //     LastTransactiondate := StaffImpAcc.GetRangeMax("Date Filter");
                StaffImpAcc.CalcFields("Last Transaction Date");
                LastTransactiondate := StaffImpAcc."Last Transaction Date";

                StaffImpAcc.calcfields("Balance (LCY)", "Last Transaction Date");
                if StaffImpAcc."Balance (LCY)" > 0 then begin
                    if StaffImpAcc."Last Transaction Date" <> 0D then begin
                        if (LastTransactiondate + 3 < Today) and (LastTransactiondate + 10 < Today) then
                            if not CheckAlreadySentSMS(1) then
                                SendSMS.SendSMS(Source::LOAN_DEFAULTED, StaffImpAcc."Mobile Phone No.", ' Your imprest account is overdue by more than 24 hours. Please clear the outstanding amount of ' + FORMAT(StaffImpAcc."Balance (LCY)") + '.', 'IMPRESTNOTICE1', '', false, 0, false, 'CBS', "No.", '', Today)
                            // 7- 14 days
                            else if (LastTransactiondate + 10 < Today) and (LastTransactiondate + 17 < Today) then
                                if not CheckAlreadySentSMS(2) then
                                    SendSMS.SendSMS(Source::LOAN_DEFAULTED, StaffImpAcc."Mobile Phone No.", ' Your imprest account is overdue by more than 7 days. Please clear the outstanding amount of ' + FORMAT(StaffImpAcc."Balance (LCY)") + ' to avoid recovery from HR.', 'IMPRESTNOTICE2', '', false, 0, false, 'CBS', "No.", '', Today)
                                //After 14 days
                                else if (LastTransactiondate + 18 < Today) then
                                    if not CheckAlreadySentSMS(3) then begin
                                        SendSMS.SendSMS(Source::LOAN_DEFAULTED, StaffImpAcc."Mobile Phone No.", ' Your imprest account is overdue by 14 days. Please clear the outstanding amount of ' + FORMAT(StaffImpAcc."Balance (LCY)") + ' immediately. This has been forwaded to HR for recovery', 'IMPRESTNOTICE3', '', false, 0, false, 'CBS', "No.", '', Today);
                                        // Send the imprest to HR for recovery via payroll
                                        InsertDeductionInPayroll(StaffImpAcc);
                                    end;
                    end;
                end;

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
                group(ImprestHeader)
                {
                    field("Imprest Header"; HeaderNo)
                    {
                        TableRelation = "Imprest Header"."No." where(Posted = filter(true), "Surrender Status" = filter(" " | partial));
                    }
                }
            }
        }
    }

    procedure CheckAlreadySentSMS(NoticeType: Integer): Boolean
    begin
        SkySMS.Reset();
        SkySMS.Setrange("Account To Charge", StaffImpAcc."No.");
        SkySMS.setfilter("SMS Date", '>%1', LastTransactiondate);
        case
            NoticeType of
            1:
                SkySMS.SETRANGE(msg_destination_reference, 'IMPRESTNOTICE1');
            2:
                SkySMS.SETRANGE(msg_destination_reference, 'IMPRESTNOTICE2');
            3:
                SkySMS.SETRANGE(msg_destination_reference, 'IMPRESTNOTICE3');
        end;
        if SkySMS.Find('-') then
            exit(true)
        else
            exit(false);
    end;

    procedure InsertDeductionInPayroll(ImprestAcc: record Customer)
    begin
        ImprestAcc.CalcFields("Balance (LCY)");
        UserSetUp.Reset();
        UserSetUp.setrange("Imprest Account", ImprestAcc."No.");
        if UserSetUp.findfirst then begin
            HREmployees.RESET;
            HREmployees.SETRANGE("Employee UserID", UserSetUp."User ID");
            if HREmployees.findfirst then begin
                // PREmployeeTrans.RESET;
                // PREmployeeTrans.SETRANGE("Employee Code", HREmployees."No.");
                // PREmployeeTrans.SETRANGE("Reference No", 'IMPREC');
                // if not PREmployeeTrans.findfirst then begin
                PrTransCodes.reset;
                PrTransCodes.setrange("Special Transactions", PrTransCodes."Special Transactions"::"Imprest Recovery");
                if PrTransCodes.findfirst then begin
                    repeat
                        PREmployeeTrans.INIT;
                        PREmployeeTrans."Transaction Code" := PrTransCodes."Transaction Code";
                        PREmployeeTrans."Employee Code" := HREmployees."No.";
                        PREmployeeTrans.Amount := ImprestAcc."Balance (LCY)";
                        PREmployeeTrans."Reference No" := 'IMPREC';
                        PREmployeeTrans.Insert();
                    until PrTransCodes.NEXT = 0;
                end else
                    // TO DO--Remove if in job queue
                    Error('We cannot find the transaction code for imprest recovery. Please contact the system administrator.');
                // end;
            end;
        end;
    end;


    var
        SendSMS: Codeunit SendSms;
        NotType: Option " ","1st alert-24hrs","2nd alert-7days","3rd alert-14days";
        CustLedgEntry: Record "Cust. Ledger Entry";
        Source: enum "SMS Source";
        LastTransactiondate: Date;
        SkySMS: record "Sky SMS Messages";
        UserSetUp: Record "User Setup";
        HREmployees: Record "HR Employees";
        PREmployeeTrans: Record "PR Employee Transactions";
        ImpHeader: record "Imprest Header";
        HeaderNo: code[50];
        PrTransCodes: Record "PR Transaction Codes";
}
