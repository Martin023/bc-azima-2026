#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185514 "Asset Finance Loans"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Asset Finance Loans.rdl';

    dataset
    {
        dataitem("Asset Finance Loan"; "Asset Finance Loan")
        {
            DataItemTableView = where(Amount = filter(> 0));
            column(ReportForNavId_1; 1)
            {
            }
            column(VendorNo; "Asset Finance Loan"."Vendor No.")
            {
            }
            column(VendorName; "Asset Finance Loan"."Vendor Name")
            {
            }
            column(LoanNo; "Asset Finance Loan"."Loan No.")
            {
            }
            column(Description; "Asset Finance Loan".Description)
            {
            }
            column(Payee; "Asset Finance Loan".Payee)
            {
            }
            column(Amount; "Asset Finance Loan".Amount)
            {
            }
            column(Name; memberName)
            {
            }
            column(MemberNo; mbr)
            {
            }
            column(Sno; Sno)
            {
            }
            column(TaxAmnt; TaxAmnt)
            {
            }
            column(SaccoCommision; SaccoCommision)
            {
            }
            column(NetToVendor; NetToVendor)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Sno += 1;
                ApprovedAmnt := 0;
                DatePosted := 0D;
                TaxAmnt := 0;
                SaccoCommision := 0;
                NetToVendor := 0;
                GeneralSetUp.Get();
                Loans.Reset;
                Loans.SetRange("Loan No.", "Asset Finance Loan"."Loan No.");
                Loans.SetRange(Posted, true);
                if Loans.Find('-') then begin
                    repeat
                        mbr := Loans."Member No.";
                        memberName := Loans."Member Name";
                        ApprovedAmnt := Loans."Approved Amount";
                        DatePosted := Loans."Disbursement Date";
                        NetToVendor := "Asset Finance Loan".Amount / 1.03;
                        SaccoCommision := "Asset Finance Loan".Amount - NetToVendor;
                        TaxAmnt := SaccoCommision * GeneralSetUp."Excise Duty (%)" * 0.01;
                    until Loans.Next = 0;
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
        Loans: Record Loans;
        ApprovedAmnt: Decimal;
        DatePosted: Date;
        mbr: Code[20];
        memberName: Text;
        Sno: Integer;
        TaxAmnt: Decimal;
        SaccoCommision: Decimal;
        NetToVendor: Decimal;
        GeneralSetUp: Record "General Set-Up";
}
