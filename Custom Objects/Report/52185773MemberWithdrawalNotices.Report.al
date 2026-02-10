#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185773 "Pending Withdrawal Notices"
{
    DefaultLayout = RDLC;
    Caption = 'Pending Member Withdrawal Notices';
    RDLCLayout = './bc-azima-2026/Layout/Member Withdrawal Notices.rdl';
    UsageCategory = ReportsAndAnalysis;


    dataset
    {

        dataitem("Membership Closure"; "Membership Closure")
        {
            DataItemTableView = where(Status = Filter("Pending" | "Open"));
            column(ClosureNO; "No.") { }
            column(MemberNo; "Member No.") { }
            column(Member_Name; "Member Name") { }
            column(MemberWithdrawalNo; MemberWithdrawalNo) { }
            column(ApprovalStatus; Status) { }
            column(CRMNo; CRMNo) { }
            column(DaysPending; DaysPending) { }
            column(ReasonforWithdrawal; ReasonforWithdrawal) { }
            column(DateInitiated; DateInitiated) { }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin

                CRMNo := ' ';
                DaysPending := 0;
                DateInitiated := 0D;
                ReasonforWithdrawal := ' ';
                MemberWithdrawalNo := ' ';


                MemberWithdrawal.RESET;
                MemberWithdrawal.SetRange("Member No.", "Membership Closure"."Member No.");
                if MemberWithdrawal.FindFirst() then begin
                    MemberWithdrawalNo := MemberWithdrawal."No.";
                    CRMNo := MemberWithdrawal."CRM Application No.";
                    DaysPending := MemberWithdrawal."No. of Days Remaining";
                    ReasonforWithdrawal := MemberWithdrawal."Reason for withdrawal";
                    DateInitiated := MemberWithdrawal."Date Entered";
                end;

            end;
        }
        // dataitem("Member withdrawal Notice"; "Member withdrawal Notice")
        // {
        //     RequestFilterFields = "Member No.", "Maturity Date", "Notice Type", "Entered By";
        //     DataItemTableView = where(Status = const("Pending"));
        //     column(ReportForNavId_1; 1)
        //     {
        //     }
        //     column(CRM_Application_No_; "CRM Application No.") { }
        //     column(Reason_for_withdrawal; "Reason for withdrawal") { }
        //     column(No__of_Days_Remaining; "No. of Days Remaining") { }
        //     column(Maturity_Date; "Maturity Date") { }
        //     column(Duration; Duration) { }
        //     column(No; "Member withdrawal Notice"."No.")
        //     {
        //     }
        //     column(MemberNo; "Member withdrawal Notice"."Member No.")
        //     {
        //     }
        //     column(Name; "Member withdrawal Notice".Name)
        //     {
        //     }
        //     column(WithdrawaNoticelDate; "Member withdrawal Notice"."Withdrawal Notice Date")
        //     {
        //     }
        //     column(MaturityDate; "Member withdrawal Notice"."Maturity Date")
        //     {
        //     }
        //     column(Status; "Member withdrawal Notice".Status)
        //     {
        //     }
        //     column(LoansOutstandingBalance; "Member withdrawal Notice"."Loans Outstanding Balance")
        //     {
        //     }
        //     column(LoansOutstandingInterest; "Member withdrawal Notice"."Loans Outstanding Interest")
        //     {
        //     }
        //     column(MemberDeposit; "Member withdrawal Notice"."Member Deposit")
        //     {
        //     }
        //     column(NoticeType; "Member withdrawal Notice"."Notice Type")
        //     {
        //     }
        //     column(DateClosed; DatePaid)
        //     {
        //     }
        //     column(Refund; AmntRefunded)
        //     {
        //     }
        //     column(PaymentStatus; PaymentStatus)
        //     {
        //     }

        //     trigger OnAfterGetRecord()
        //     begin
        //         DatePaid := 0D;
        //         AmntRefunded := 0;
        //         PaymentStatus := '';
        //         Mclosure.Reset;
        //         Mclosure.SetRange("Member No.", "Member withdrawal Notice"."Member No.");
        //         Mclosure.SetRange(Posted, true);
        //         Mclosure.SetRange(Status, Mclosure.Status::Approved);
        //         if Mclosure.Find('+') then begin
        //             repeat
        //                 AmntRefunded := Mclosure."Deposit Refundable";
        //                 PaymentStatus := 'Paid'
        //             until Mclosure.Next = 0;
        //         end else
        //             PaymentStatus := 'Pending';


        //         Mclosure.Reset;
        //         Mclosure.SetRange("Member No.", "Member withdrawal Notice"."Member No.");
        //         Mclosure.SetRange(Posted, true);
        //         Mclosure.SetRange(Status, Mclosure.Status::Approved);
        //         if Mclosure.Find('+') then begin
        //             repeat
        //                 AmntRefunded := Mclosure."Deposit Refundable";
        //                 DatePaid := Mclosure."Closing Date";
        //                 Duration := DatePaid - "Member withdrawal Notice"."Withdrawal Notice Date";
        //             until Mclosure.Next = 0;
        //         end;
        //     end;
        // }
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
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;


    var
        Mclosure: Record "Membership closure";
        DatePaid: Date;
        AmntRefunded: Decimal;
        PaymentStatus: Text;
        Duration: Integer;
        MemberWithdrawal: Record "Member Withdrawal Notice";
        CRMNo: Code[200];
        DateInitiated: Date;
        ReasonforWithdrawal: Text[1000];
        DaysPending: Integer;
        MemberWithdrawalNo: Code[100];
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;


}
