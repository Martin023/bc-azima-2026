#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185760 "Duplicate RTGS Transfer Lines"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Duplicate EFT Transfer Lines.rdl';

    dataset
    {
        //dataitem(52185715;52185715)
        dataitem(RTGSTrasferHeader; 52185715)
        {
            column(ReportForNavId_26; 26)
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
                column(Transferred_RTGSTransferLines; "RTGS Transfer Lines".Transferred)
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

                    Mycount := 0;
                    RTGSTransferLines.Reset;
                    RTGSTransferLines.SetRange("Account No.", "RTGS Transfer Lines"."Account No.");
                    if RTGSTransferLines.Find('-') then begin
                        repeat
                            Mycount += 1;
                        until RTGSTransferLines.Next = 0;
                    end;
                    // MESSAGE('my count %1',Mycount);
                    if Mycount > 2 then begin
                        Multiple := true;
                        "RTGS Transfer Lines"."Multiple Accounts" := true;
                        "RTGS Transfer Lines".Modify;
                    end else begin
                        Multiple := false;
                        "RTGS Transfer Lines"."Multiple Accounts" := false;
                        "RTGS Transfer Lines".Modify;
                    end;
                    if Multiple = false then
                        CurrReport.Skip;
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

    var
        sno: Integer;
        RTGSTransferLines: Record "RTGS Transfer Lines";
        Multiple: Boolean;
        Mycount: Integer;
}
