report 52185893 "Un-Surrendered Imprests"
{
    ApplicationArea = All;
    Caption = 'Un-Surrendered Imprests';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-azima-2026/Layout/Un-Surrendered Imprests.rdl';
    dataset
    {
        dataitem("Imprest Header"; "Imprest Header")
        {
            CalcFields = "Total Net Amount LCY";
            DataItemTableView = where("Surrender Status" = filter(" " | Partial), Status = filter(Posted));
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
            column(No_; "No.")
            {
            }
            column(AccountNo; "Account No.")
            {
            }
            column(AccountType; "Account Type")
            {
            }
            column(DatePosted; "Date Posted")
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(Payee; Payee)
            {
            }
            column(PayingBankAccount; "Paying Bank Account")
            {
            }
            column(PaymentType; "Payment Type")
            {
            }
            column(Posted; Posted)
            {
            }
            column(Status; Status)
            {
            }
            column(PF_Staff_No; "PF/Staff No")
            {
            }
            column(UnsurrenderedAmt; UnsurrenderedAmt)
            {
            }
            column(purpose; purpose)
            {
            }
            column(Total_Net_Amount_LCY; "Total Net Amount LCY")
            { }
            trigger OnAfterGetRecord()
            begin
                "Imprest Header".calcfields("Total Net Amount LCY");
                UnsurrenderedAmt := 0;
                TotalSurrenderedAmt := 0;
                ImprestSurrender.RESET;
                ImprestSurrender.SETRANGE("Imprest Issue Doc. No", "Imprest Header"."No.");
                if ImprestSurrender.FindFirst() then begin
                    repeat
                        ImprestSurrender.CalcFields("Amount Surrendered LCY");
                        TotalSurrenderedAmt += ImprestSurrender."Amount Surrendered LCY";
                    until
                     ImprestSurrender.Next() = 0;
                    UnsurrenderedAmt := "Imprest Header"."Total Net Amount LCY" - TotalSurrenderedAmt;
                end
                else
                    UnsurrenderedAmt := "Imprest Header"."Total Net Amount LCY";
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
        UnsurrenderedAmt: Decimal;
        ImprestSurrender: Record "Imprest Surrender Header";
        TotalSurrenderedAmt: Decimal;

}
