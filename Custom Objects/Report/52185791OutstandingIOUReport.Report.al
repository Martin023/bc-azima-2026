#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185791 "Outstanding IOU Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Outstanding IOU Report.rdl';

    dataset
    {
        dataitem("Staff Advance Header"; "Staff Advance Header")
        {
            DataItemTableView = where(Status = const(Posted), "Surrender Status" = const(" "));
            RequestFilterFields = Date, "Responsibility Center";
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(No_StaffAdvanceHeader; "Staff Advance Header"."No.")
            {
            }
            column(Date_StaffAdvanceHeader; "Staff Advance Header".Date)
            {
            }
            column(CurrencyCode_StaffAdvanceHeader; "Staff Advance Header"."Currency Code")
            {
            }
            column(Payee_StaffAdvanceHeader; "Staff Advance Header".Payee)
            {
            }
            column(OnBehalfOf_StaffAdvanceHeader; "Staff Advance Header"."On Behalf Of")
            {
            }
            column(Cashier_StaffAdvanceHeader; "Staff Advance Header".Cashier)
            {
            }
            column(Posted_StaffAdvanceHeader; "Staff Advance Header".Posted)
            {
            }
            column(DatePosted_StaffAdvanceHeader; "Staff Advance Header"."Date Posted")
            {
            }
            column(TimePosted_StaffAdvanceHeader; "Staff Advance Header"."Time Posted")
            {
            }
            column(PostedBy_StaffAdvanceHeader; "Staff Advance Header"."Posted By")
            {
            }
            column(TotalPaymentAmount_StaffAdvanceHeader; "Staff Advance Header"."Total Payment Amount")
            {
            }
            column(PayingBankAccount_StaffAdvanceHeader; "Staff Advance Header"."Paying Bank Account")
            {
            }
            column(TotalVATAmount_StaffAdvanceHeader; "Staff Advance Header"."Total VAT Amount")
            {
            }
            column(TotalWitholdingTaxAmount_StaffAdvanceHeader; "Staff Advance Header"."Total Witholding Tax Amount")
            {
            }
            column(TotalNetAmount_StaffAdvanceHeader; "Staff Advance Header"."Total Net Amount")
            {
            }
            column(TotalNetAmountLCY_StaffAdvanceHeader; "Staff Advance Header"."Total Net Amount LCY")
            {
            }
            column(Purpose_StaffAdvanceHeader; "Staff Advance Header".Purpose)
            {
            }
            column(AccountType_StaffAdvanceHeader; "Staff Advance Header"."Account Type")
            {
            }
            column(AccountNo_StaffAdvanceHeader; "Staff Advance Header"."Account No.")
            {
            }
            column(ComapnyName; CompanyInfo.Name)
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(RemainingAmount; RemainingAmount)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CustLedger.Reset;
                CustLedger.SetRange(CustLedger."Customer No.", "Staff Advance Header"."Account No.");
                //CustLedger.SETRANGE(CustLedger."Posting Date","Staff Advance Header"."Date Posted");
                CustLedger.SetRange(CustLedger."Document No.", "Staff Advance Header"."No.");
                if CustLedger.FindFirst then begin
                    CustLedger.CalcFields("Remaining Amount");
                    RemainingAmount := CustLedger."Remaining Amount";
                end
                else
                    RemainingAmount := 0;
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

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        RemainingAmount: Decimal;
        CustLedger: Record "Cust. Ledger Entry";
}
