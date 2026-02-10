report 52186041 "Delegate Claims Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/ Delegate Claims Report.rdl';
    dataset
    {

        dataitem("Delegates Minutes Header"; "Delegates Minutes Header")
        {
            RequestFilterFields = Status, "Meeting Paid";
            //DataItemTableView = WHERE(Status = CONST(Approved), "Meeting Paid" = CONST(TRUE));
            DataItemTableView = WHERE(Status = CONST(Approved));
            column(Code; Code)
            {
            }
            column(Quarter; Quarter)
            {
            }
            column(Electoral_Region; "Electoral Region")
            {
            }
            column(FOSABranch; FOSABranch) { }
            column(PayrollNo; PayrollNo) { }
            column(SavingsAccountNo; SavingsAccountNo) { }

            column(Electoral_Name; "Electoral Name")
            {
            }
            column(Meeting_Date; "Meeting Date")
            {
            }
            column(Meeting_Type; "Meeting Type")
            {
            }
            column(Delegate_Member_No; "Delegate Member No")
            {
            }
            column(Delegate_Name; "Delegate Name")
            {
            }
            // column(PaymentLinesDelegateMemberNo; PaymentLinesDelegateMemberNo) { }
            // column(PaymentLinesDelegateMemberName; PaymentLinesDelegateMemberName) { }
            // column(PaymentLinesDelegatePosition; PaymentLinesDelegatePosition) { }
            // column(PaymentLinesAmount; PaymentLinesAmount) { }
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

            dataitem("Delegates Meeting Attendees"; "Delegates Meeting Attendees")
            {
                DataItemLink = "Header No" = field(Code);
                column(Delegate_No_; "Delegate No.")
                {
                }
                column(DelegateName; "Delegate Name")
                {
                }
                column(Delegate_Email; "Delegate Email")
                {
                }
                column(Delegate_Position; "Delegate Position")
                {
                }
                column(Quater1Payment; Quater1Payment) { }
                column(Quater2Payment; Quater2Payment) { }
                column(Quater3Payment; Quater3Payment) { }
                column(TotalQuatersPayment; TotalQuatersPayment) { }
                // column(delegateMemberNo; delegateMemberNo) { }
                // column(delegateMemberName; delegateMemberName) { }
                // column(delegatePosition; delegatePosition) { }
                // column(PaymentLinesDelegateMemberNo; PaymentLinesDelegateMemberNo) { }
                // column(PaymentLinesDelegateMemberName; PaymentLinesDelegateMemberName) { }
                // column(PaymentLinesDelegatePosition; PaymentLinesDelegatePosition) { }
                column(PaymentLinesAmount; PaymentLinesAmount) { }
                trigger OnAfterGetRecord()

                begin
                    // Members.Reset();
                    // Members.SetRange("No.", "Delegates Meeting Attendees"."Delegate No.");
                    // if Members.Find('-') then begin
                    //     FOSABranch := Members."Branch Code";
                    //     PayrollNo := Members."Payroll/Staff No.";
                    //     if SavingsAccounts.Get(Members."No.") then
                    //         SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"FOSA Account");
                    //     SavingsAccountNo := SavingsAccounts."No.";
                    // end;

                    DelegateMemberNo := '';
                    DelegateMemberName := '';
                    DelegatePosition := '';
                    PaymentLinesAmount := 0;
                    //Payments
                    Quater1Payment := 0;
                    Quater2Payment := 0;
                    Quater3Payment := 0;
                    TotalQuatersPayment := 0;


                    DelegatePayment.Reset();
                    DelegatePayment.SetRange("Minute No.", "Delegates Minutes Header".Code);
                    DelegatePayment.SetRange(Posted, true);
                    //DelegatePayment.setrange(Typ)
                    if DelegatePayment.FindFirst() then begin
                        repeat
                            DelegatePaymentLines.Reset();
                            DelegatePaymentLines.SetRange(DelegatePaymentLines.Code, DelegatePayment.Code);
                            DelegatePaymentLines.SetRange("Delegate MNO.", "Delegates Meeting Attendees"."Delegate No.");
                            if DelegatePaymentLines.FindFirst() then begin
                                repeat
                                    //DelegatePaymentLines.CalcSums("Amount Payable");

                                    // DelegateMemberNo := DelegatePaymentLines."Delegate MNO.";
                                    // DelegateMemberName := DelegatePaymentLines."Delegate Name";
                                    // DelegatePosition := DelegatePaymentLines.Position;

                                    if "Delegates Minutes Header".Quarter = "Delegates Minutes Header".Quarter::"First Quarter" then
                                        Quater1Payment += DelegatePaymentLines."Amount Payable";
                                    if "Delegates Minutes Header".Quarter = "Delegates Minutes Header".Quarter::"Second Quarter" then
                                        Quater2Payment += DelegatePaymentLines."Amount Payable";
                                    if "Delegates Minutes Header".Quarter = "Delegates Minutes Header".Quarter::"Third Quarter" then
                                        Quater3Payment += DelegatePaymentLines."Amount Payable";

                                    TotalQuatersPayment += (Quater1Payment + Quater2Payment + Quater3Payment);

                                until DelegatePaymentLines.Next = 0;
                            end;
                        until DelegatePayment.Next = 0;
                    end;

                end;

                trigger OnPreDataItem()
                begin
                    CompanyInformation.Get;
                    CompanyInformation.CalcFields(Picture);
                end;
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin


                // DelegatesMeetingAttendees.Reset();
                // DelegatesMeetingAttendees.setrange("Header No", "Delegates Minutes Header".Code);
                // if DelegatesMeetingAttendees.FindFirst() then begin
                //     repeat

                //     until DelegatesMeetingAttendees.Next = 0;
                // end;

            end;

        }
        // dataitem("Delegate Members"; "Delegate Members")
        // {
        //     trigger OnAfterGetRecord()
        //     begin

        //     end;
        // }
    }

    requestpage
    {
        SaveValues = true;
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
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    // procedure CheckDelegatePaidAmt(DelegateMeeting: record "Delegates Minutes Header"; DelgegateNo: Code[20])
    // begin
    //     DelegatePayment.Reset();
    //     DelegatePayment.SetRange(Code, DelegateMeeting.Code);
    //     if DelegatePayment.FindFirst() then begin
    //         DelegatePaymentLines.Reset();
    //         DelegatePaymentLines.SetRange(DelegatePaymentLines.Code, DelegatePayment.Code);
    //         // DelegatePaymentLines.SetRange("Delegate MNO.", "Delegates Meeting Attendees"."Delegate No.");
    //         if DelegatePaymentLines.Find('-') then begin
    //             repeat
    //                 DelegateMemberNo := DelegatePaymentLines."Delegate MNO.";
    //                 DelegateMemberName := DelegatePaymentLines."Delegate Name";
    //                 DelegatePosition := DelegatePaymentLines.Position;
    //                 PaymentLinesAmount := DelegatePaymentLines.Amount;
    //                 Quater1Payment := 0;
    //                 Quater2Payment := 0;
    //                 Quater3Payment := 0;
    //                 TotalQuatersPayment := 0;
    //                 if "Delegates Minutes Header"."Meeting Paid" then begin
    //                     Quater1Payment := DelegatePaymentLines."Q1 Amount";
    //                     Quater2Payment := DelegatePaymentLines."Q2 Amount";
    //                     Quater3Payment := DelegatePaymentLines."Q3 Amount";
    //                     TotalQuatersPayment := Quater1Payment + Quater2Payment + Quater3Payment;
    //                 end;

    //             until DelegatePaymentLines.Next = 0;
    //         end;
    //     end;
    // end;


    var
        myInt: Integer;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        "SNo.": Integer;
        //DelegatesMeetingAttendees: Record "Delegates Meeting Attendees";
        DelegateMemberNo: Code[20];
        DelegateMemberName: Text[50];
        DelegatePosition: Text[50];

        PaymentLinesAmount: Decimal;
        DelegatePayment: Record "Delegates Payment";
        DelegatePaymentLines: Record "Delegate Payment Line";
        Members: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        SavingsAccountNo: Code[50];
        PayrollNo: Code[50];
        FOSABranch: Code[50];
        Quater1Payment: Decimal;
        Quater2Payment: Decimal;
        Quater3Payment: Decimal;
        TotalQuatersPayment: Decimal;
}