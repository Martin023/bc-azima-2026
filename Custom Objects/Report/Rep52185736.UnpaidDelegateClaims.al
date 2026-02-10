report 52185736 "Unpaid Delegate Claims"
{
    ApplicationArea = All;
    Caption = 'Unpaid Delegate Claims';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Unpaid Delegate Claims.rdl';

    dataset
    {
        dataitem(DelegatesMinutesHeader; "Delegates Minutes Header")
        {
            DataItemTableView = WHERE("Meeting Paid" = CONST(FALSE));
            RequestFilterFields = "Meeting Paid", Code;
            Column(MeetingCode; Code)
            {
            }
            column(Quarter; Quarter)
            {
            }
            column(Electoral_Name; "Electoral Name")
            {
            }
            column(Electoral_Region; "Electoral Region")
            {
            }
            column(DelegateMemberNo; DelegateMemberNo)
            {
            }
            column(Delegate_Member_Name; DelegateMemberName)
            {
            }
            column(Delegate_Position; DelegatePosition)
            {
            }
            column(Amount; Amount)
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
                DataItemLinkReference = DelegatesMinutesHeader;
                DataItemLink = "Header No" = FIELD(Code);
                column(Header_No; "Header No") { }
                column(DelegateMembNo; "Delegate No.") { }
                column(DelegateMemberName; "Delegate Name") { }
                column(DelegatePosition; "Delegate Position") { }
                trigger OnAfterGetRecord()


                begin
                    DelegateMemberNo := '';
                    DelegateMemberName := '';
                    DelegatePosition := '';

                    DelegatesMeetingAttendees.RESET;
                    DelegatesMeetingAttendees.SETRANGE("Header No", DelegatesMinutesHeader.Code);
                    if DelegatesMeetingAttendees.Find('-') then begin
                        repeat
                            DelegateMemberNo := DelegatesMeetingAttendees."Delegate No.";
                            DelegateMemberName := DelegatesMeetingAttendees."Delegate Name";
                            DelegatePosition := DelegatesMeetingAttendees."Delegate Position";
                            DelegatePayementLines.RESET;
                            DelegatePayementLines.SetRange("Delegate MNO.", DelegatesMeetingAttendees."Delegate No.");
                            if DelegatePayementLines.Find('-') then begin
                                repeat
                                    Amount := DelegatePayementLines.Amount;
                                until DelegatePayementLines.NEXT = 0;
                            end;
                        until DelegatesMeetingAttendees.NEXT = 0;
                    end;
                end;

            }

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
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
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
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

    var

        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        DelegatesMeetingAttendees: Record "Delegates Meeting Attendees";
        DelegateMemberNo: Code[20];
        DelegateMemberName: Text[50];
        DelegatePosition: Text[50];
        DelegatePayementLines: Record "Delegate Payment Line";
        Amount: Decimal;
}
