#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185920 "Sink Fund Receipt Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Sink Fund Receipt Report.rdl';

    dataset
    {
        dataitem("Receipts Header"; "Receipts Header")
        {
            RequestFilterFields = "Consolidated Doc No";

            column(CompanyInfo__Address_2_; Company."Address 2")
            {
            }
            column(CompanyInfo_Address; Company.Address)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(MemName; MemberName)
            {
            }
            column(memberNo; "Receipts Header"."Member No")
            {
            }
            column(InternalClaimNo; "Receipts Header"."Insurance Claim no")
            {
            }
            column(CICClaimNo; "Receipts Header"."CIC Claim No(External)")
            {
            }
            column(InternalReceiptNo; "Receipts Header"."No.")
            {
            }
            column(DeceasedPer; "Receipts Header"."Claim For")
            {
            }
            column(TotalAmnt; "Receipts Header"."Total Amount")
            {
            }
            column(ConsDocNo; "Receipts Header"."Consolidated Doc No")
            {
            }
            column(PaymentDate; DatePayed)
            {
            }
            column(DatePrinted; DatePrinted)
            {
            }
            column(DPInternalClaimNo; "Receipts Header"."Date Posted")
            {
            }

            trigger OnAfterGetRecord()
            begin
                DatePayed := 0D;
                BBFRequiHeader.Reset;
                BBFRequiHeader.SetRange(BBFRequiHeader."Report Notice No", "Receipts Header"."Insurance Claim no");
                if BBFRequiHeader.Find('-') then
                    DatePayed := BBFRequiHeader."Payment Release Date";

                Memb.Reset;
                Memb.SetRange(Memb."No.", "Receipts Header"."Member No");
                if Memb.Find('-') then
                    MemberName := Memb.Name;

                DatePrinted := Today;
            end;

            trigger OnPreDataItem()
            begin
                if Company.Get() then
                    Company.CalcFields(Company.Picture);
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
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        MemberName: Text;
        Company: Record "Company Information";
        ConsolidatedDocNo: Code[20];
        Memb: Record "Members";
        MemberNo: Code[20];
        InternalClaimNo: Code[50];
        ClaimFor: Text;
        Tamount: Decimal;
        ReceiptNo: Code[20];
        CICclaimNo: Code[20];
        RC: Record "Receipts Header";
        DatePrinted: Date;
        BBFRequiHeader: Record "BBF Requisation Header";
        DatePayed: Date;
}
