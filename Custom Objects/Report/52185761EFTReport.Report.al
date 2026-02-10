#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185761 "RTGS Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/EFT Report.rdl';

    dataset
    {
        //dataitem(52185715;52185715)
        dataitem("RTGS Transfer Header"; "RTGS Transfer Header")
        {
            RequestFilterFields = "No.", "Date Transferred", Status;
            column(ReportForNavId_26; 26)
            {
            }
            column(RTGSTransferHeader_RecordTotal; "RTGS Transfer Header"."Record Total")
            {
            }
            column(RTGSTransferHeader_CreatedBy; "RTGS Transfer Header"."Created By")
            {
            }
            //dataitem(52185716;52185716)
            dataitem("RTGS Transfer Lines"; "RTGS Transfer Lines")
            {
                DataItemLink = "Document No." = field("No.");
                column(ReportForNavId_1; 1)
                {
                }
                column(EntryNo_RTGSTransferLines; sno)
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
                column(DocumentNo_RTGSTransferLines; "RTGS Transfer Lines"."Document No.")
                {
                }
                column(EnteredBy_RTGSTransferLines; "RTGS Transfer Lines"."Entered By")
                {
                }
                column(AccountType_RTGSTransferLines; "RTGS Transfer Lines"."Account Type")
                {
                }
                column(AccountNo_RTGSTransferLines; "RTGS Transfer Lines"."Account No.")
                {
                }
                column(AccountName_RTGSTransferLines; "RTGS Transfer Lines"."Account Name")
                {
                }
                column(MemberNo_RTGSTransferLines; "RTGS Transfer Lines"."Member No.")
                {
                }
                column(ExternalAccountName_RTGSTransferLines; "RTGS Transfer Lines"."External Account Name")
                {
                }
                column(ChargeAmount_RTGSTransferLines; "RTGS Transfer Lines"."Charge Amount")
                {
                }
                column(DontCharge_RTGSTransferLines; "RTGS Transfer Lines"."Don't Charge")
                {
                }
                column(PhoneNo_RTGSTransferLines; "RTGS Transfer Lines"."Phone No.")
                {
                }
                column(Amount_RTGSTransferLines; "RTGS Transfer Lines".Amount)
                {
                }
                column(AmountText_RTGSTransferLines; "RTGS Transfer Lines"."Amount Text")
                {
                }
                column(BankCode_RTGSTransferLines; "RTGS Transfer Lines"."Bank Code")
                {
                }
                column(BranchCode_RTGSTransferLines; "RTGS Transfer Lines"."Branch Code")
                {
                }
                column(BankName_RTGSTransferLines; "RTGS Transfer Lines"."Bank Name")
                {
                }
                column(OverDrawn_RTGSTransferLines; "RTGS Transfer Lines"."Over Drawn")
                {
                }
                column(StandingOrderNo_RTGSTransferLines; "RTGS Transfer Lines"."Standing Order No")
                {
                }
                column(StandingOrderRegisterNo_RTGSTransferLines; "RTGS Transfer Lines"."Standing Order Register No")
                {
                }
                column(NotAvailable_RTGSTransferLines; "RTGS Transfer Lines"."Not Available")
                {
                }
                column(ChargeAccount_RTGSTransferLines; "RTGS Transfer Lines"."Charge Account")
                {
                }
                column(Transferred_RTGSTransferLines; Trans)
                {
                }
                column(ExportFormat_RTGSTransferLines; "RTGS Transfer Lines".ExportFormat)
                {
                }
                column(ExternalAccountNo_RTGSTransferLines; "RTGS Transfer Lines"."External Account No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    // CompanyInformation.Get();
                    // CompanyInformation.CalcFields(CompanyInformation.Picture);
                    if "RTGS Transfer Lines".Transferred = true then
                        Trans := 'Yes' else
                        Trans := 'No';
                    sno += 1;
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
        sno: Integer;
        RTGSTransferLines: Record "RTGS Transfer Lines";
        Multiple: Boolean;
        Mycount: Integer;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Trans: Text;
}
