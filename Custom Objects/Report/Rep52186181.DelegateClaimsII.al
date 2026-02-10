namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52186181 "Delegate Claims II"
{
    ApplicationArea = All;
    Caption = 'Dalegate Claims II';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Delegate Claims II.rdl';

    dataset
    {
        dataitem("Delegate Members"; "Delegate Members")
        {
            RequestFilterFields = "Delegate Code", "Electoral Zone Name";
            DataItemTableView = Where(Status = filter(Approved), Retired = const(false));

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

            column(Delegate_Code; "Delegate Code")
            {
            }
            column(Delegate_Name; "Delegate Name")
            {
            }
            column(Electoral_Zone_Name; "Electoral Zone Name")
            {
            }
            column(Electoral_Zone; "Electoral Zone")
            {
            }
            column(Quater1Payment; Quater1Payment)
            {
            }
            column(Quater2Payment; Quater2Payment)
            {
            }
            column(Quater3Payment; Quater3Payment)
            {
            }
            column(TotalQuatersPayment; TotalQuatersPayment)
            {
            }
            column(Quarter4Payment; Quarter4Payment)
            {
            }
            column(MeetingDate; MeetingDate)
            {
            }
            trigger OnAfterGetRecord()
            begin
                Quater1Payment := 0;
                Quater2Payment := 0;
                Quater3Payment := 0;
                TotalQuatersPayment := 0;
                Quarter4Payment := 0;
                MeetingDate := 0D;

                DelegateMeetingHeader.Reset();
                DelegateMeetingHeader.SetRange(Status, DelegateMeetingHeader.Status::"Approved");
                DelegateMeetingHeader.Setfilter(Quarter, '<>%1', DelegateMeetingHeader.Quarter::" ");
                DelegateMeetingHeader.SetRange("Meeting Date", StartDate, EndDate);
                DelegateMeetingHeader.setrange("Electoral Region", "Delegate Members"."Electoral Zone");
                DelegateMeetingHeader.setrange("Meeting Paid", true);
                if DelegateMeetingHeader.find('-') then begin
                    repeat
                        DelegateMeetingLine.Reset();
                        DelegateMeetingLine.SetRange("Header No", DelegateMeetingHeader.code);
                        DelegateMeetingLine.SetRange("Delegate No.", "Delegate Members"."Delegate MNO.");
                        if DelegateMeetingLine.FindFirst() then begin
                            repeat
                                DelegatePayment.Reset();
                                DelegatePayment.SetRange("Minute No.", DelegateMeetingHeader.code);
                                DelegatePayment.SetRange(Posted, true);
                                //DelegatePayment.setrange(Typ)
                                if DelegatePayment.FindFirst() then begin
                                    repeat
                                        DelegatePaymentLines.Reset();
                                        DelegatePaymentLines.SetRange(DelegatePaymentLines.Code, DelegatePayment.Code);
                                        DelegatePaymentLines.SetRange("Delegate MNO.", "Delegate Members"."Delegate MNO.");
                                        if DelegatePaymentLines.FindFirst() then begin
                                            //DelegatePaymentLines.CalcSums("Amount Payable");
                                            repeat
                                                if DelegateMeetingHeader.Quarter = DelegateMeetingHeader.Quarter::"First Quarter" then
                                                    Quater1Payment += DelegatePaymentLines."Amount Payable";
                                                if DelegateMeetingHeader.Quarter = DelegateMeetingHeader.Quarter::"Second Quarter" then
                                                    Quater2Payment += DelegatePaymentLines."Amount Payable";
                                                if DelegateMeetingHeader.Quarter = DelegateMeetingHeader.Quarter::"Third Quarter" then
                                                    Quater3Payment += DelegatePaymentLines."Amount Payable";
                                                if DelegateMeetingHeader.Quarter = DelegateMeetingHeader.Quarter::"Fourth Quarter" then
                                                    Quarter4Payment += DelegatePaymentLines."Amount Payable";

                                            until DelegatePaymentLines.Next = 0;
                                        end;
                                    until DelegatePayment.Next = 0;
                                end;
                            until DelegateMeetingLine.Next = 0;
                        end;
                    until DelegateMeetingHeader.Next = 0;
                end;
                TotalQuatersPayment := (Quater1Payment + Quater2Payment + Quater3Payment);
            end;
        }

    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(DateFilter)
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                    }

                }
            }
        }
    }
    trigger OnPreReport()
    begin
        if StartDate = 0D then
            StartDate := 20230101D;
        if EndDate = 0D then
            EndDate := Today;

        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;



    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;

        DelegateMeetingHeader: Record "Delegates Minutes Header";
        DelegateMeetingLine: Record "Delegates Meeting Attendees";

        DelegatePayment: Record "Delegates Payment";
        DelegatePaymentLines: Record "Delegate Payment Line";

        StartDate: Date;
        EndDate: Date;

        Quater1Payment: Decimal;
        Quater2Payment: Decimal;
        Quater3Payment: Decimal;
        TotalQuatersPayment: Decimal;
        Quarter4Payment: Decimal;
        MeetingDate: Date;

}
