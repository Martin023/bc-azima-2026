#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186001 "Delegates Payment Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Delegates Payment Voucher Slip.rdl';
    //UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Delegates Minutes Header"; "Delegates Minutes Header")
        {
            column(MeetingCode; Code)
            {
            }
            column(PaymentCode; PaymentCode)
            {
            }
            column(PaymentNarration; PaymentNarration)
            {
            }
            column(TotalPayment; TotalPayment)
            {
            }
            column(DelegateName; DelegateName)
            {
            }
            column(DelegateNo; DelegateNo)
            {
            }
            column(Position; Position)
            {
            }
            column(Approved_By; Approved_By)
            {
            }
            column(Created_By; Created_By)
            {
            }
            column(NoofMeetings; NoofMeetings)
            {
            }
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
                column(LinesDelegate_no; "Delegate No.")
                {
                }
                column(LinesDelegate_Name; "Delegate Name")
                {
                }
                column(LinesHeader_No; "Header No")
                {
                }
                column(LinesDelegate_Position; "Delegate Position")
                {
                }
                column(LinesAllowancesPaid; AllowancesPaid)
                {

                }
                column(LinesTaxPaid; TaxPaid)
                {

                }
                column(LinesNetPayableAmount; NetPayableAmount)
                {

                }

                trigger OnAfterGetRecord()
                var
                    PaymentHeader: Record "Delegates Payment";
                begin
                    AllowancesPaid := 0;
                    TaxPaid := 0;
                    NetPayableAmount := 0;
                    Created_By := '';
                    Approved_By := '';

                    PaymentHeader.Reset();
                    PaymentHeader.SetRange("Minute No.", "Delegates Minutes Header".Code);
                    //PaymentHeader.SetRange(Posted, true);
                    if PaymentHeader.FindFirst() then begin
                        repeat
                            Created_By := PaymentHeader."Created By";
                            Approved_By := PaymentHeader."Approved By";
                            DelegatePaymentLines.Reset();
                            DelegatePaymentLines.SetRange(Code, PaymentHeader.Code);
                            DelegatePaymentLines.SetRange("Delegate MNO.", "Delegates Meeting Attendees"."Delegate No.");
                            if DelegatePaymentLines.Find('-') then begin
                                repeat
                                    AllowancesPaid += DelegatePaymentLines.Amount;
                                    TaxPaid += DelegatePaymentLines."Withholding Tax";
                                    NetPayableAmount += DelegatePaymentLines."Amount Payable";
                                until DelegatePaymentLines.Next() = 0;
                            end;
                        until PaymentHeader.Next() = 0;
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
                PaymentHeader: Record "Delegates Payment";
            begin
                AllowancesPaid := 0;
                TaxPaid := 0;
                NetPayableAmount := 0;
                PaymentHeader.Reset();
                PaymentHeader.SetRange("Minute No.", "Delegates Minutes Header".Code);
                //PaymentHeader.SetRange(Posted, true);
                if PaymentHeader.FindFirst() then begin
                    DelegatePaymentLines.Reset();
                    DelegatePaymentLines.SetRange(Code, PaymentHeader.Code);
                    if DelegatePaymentLines.Find('-') then begin
                        repeat
                            TotalPayment += DelegatePaymentLines.Amount;
                        until DelegatePaymentLines.Next() = 0;
                    end;

                    PaymentCode := PaymentHeader.Code;
                    PaymentNarration := PaymentHeader."Payment Narration";
                end;
            end;
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

    var
        CompanyInformation: Record "Company Information";
        Customer: Record Customer;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        DelegatePaymentLines: Record "Delegate Payment Line";
        DelegateNo: Code[20];
        DelegateName: Text[100];
        AllowancesPaid: Decimal;
        TaxPaid: Decimal;
        NetPayableAmount: Decimal;
        Position: Text[100];
        DelegatePaymentList: Record "Delegates Payment";
        TotalPayment: Decimal;
        Approved_By: Code[20];
        Created_By: Code[20];
        NoofMeetings: Integer;
        PaymentCode: Code[20];
        PaymentNarration: Text[250];
}
