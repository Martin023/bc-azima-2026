report 52185458 "Staff Imprests Report"
{
    ApplicationArea = All;
    Caption = 'Staff Imprests Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-kenpipe-2024/Layout/Staff Imprests Report.rdl';
    dataset
    {
        dataitem(ImprestHeader; "Imprest Header")
        {
            RequestFilterFields = Posted, "Payment Release Date", "Posted By", Status, "Surrender Status", Payee, "Paying Bank Account", Cashier, "Cheque No.", "Approved By", "PF/Staff No";
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
            column(No; "No.")
            {
            }
            column(PFStaffNo; "PF/Staff No")
            {
            }
            column(AccountNo; "Account No.")
            {
            }
            column(ApprovedBy; "Approved By")
            {
            }
            column(BankName; "Bank Name")
            {
            }
            column(Cashier; Cashier)
            {
            }
            column(ChequeNo; "Cheque No.")
            {
            }
            column(Date; "Date")
            {
            }
            column(DatePosted; "Date Posted")
            {
            }
            column(Payee; Payee)
            {
            }
            column(PayingBankAccount; "Paying Bank Account")
            {
            }
            column(PaymentReleaseDate; "Payment Release Date")
            {
            }
            column(Posted; Posted)
            {
            }
            column(PostedBy; "Posted By")
            {
            }
            column(Purpose; Purpose)
            {
            }
            column(SurrenderStatus; "Surrender Status")
            {
            }
            column(Status; Status)
            {
            }
            column(TotalNetAmount; "Total Net Amount")
            {
            }
            column(TotalNetAmountLCY; "Total Net Amount LCY")
            {
            }
            column(TotalPaymentAmount; "Total Payment Amount")
            {
            }
            column(TotalWitholdingTaxAmount; "Total Witholding Tax Amount")
            {
            }
            column(TotalVATAmount; "Total VAT Amount")
            {
            }
            column(SurrenderedAmt; SurrenderedAmt) { }

            trigger OnAfterGetRecord()
            begin
                ImprestSurrender.reset;
                ImprestSurrender.SetRange(Posted, true);
                ImprestSurrender.setrange("Apply to ID", ImprestHeader."No.");
                if ImprestSurrender.FindFirst()
                then begin
                    repeat
                        SurrenderedAmt += ImprestSurrender."Amount Surrendered LCY";
                    until ImprestSurrender.Next = 0;
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
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        StartDate: Date;
        EndDate: Date;
        ImprestSurrender: record "Imprest Surrender Header";
        SurrenderedAmt: Decimal;
}
