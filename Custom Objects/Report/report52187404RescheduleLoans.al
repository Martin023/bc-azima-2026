report 52187404 "Rescheduled Loans report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Loan Resheduling Report';
    RDLCLayout = './bc-azima-2026/Layout/Loan Rescheduling Report.rdl';

    dataset
    {
        dataitem("Loan Rescheduling"; "Loan Rescheduling")
        {
            DataItemTableView = where(Rescheduled = const(true));
            column(Member_No_; "Member No.")
            {

            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CompanyNam; CompanyNam)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(picture; CompanyInformation.Picture)
            {
            }
            column(Member_Name; "Member Name")
            {

            }
            column(New_Amortised; "New Amortised")
            {

            }
            column(New_Installments; "New Installments")
            {

            }
            column(Rescheduled_By; "Rescheduled By")
            {

            }
            column(Rescheduling_Date; "Rescheduling Date")
            {

            }
            column(ReshuName; ReshuName)
            {

            }
            column(Original_Installments; "Original Installments")
            {

            }
            column(ReschDate; ReschDate)
            {

            }

            column(OustandBal; OustandBal)
            {

            }
            column(CountN; CountN)
            {

            }
            column(Instal; Instal)
            {

            }
            trigger OnAfterGetRecord()
            var
                LoansRec: Record Loans;

            begin
                if "Loan Rescheduling"."Rescheduling Date" <> 0D then
                    ReschDate := GlobalFunc.FormatDate("Rescheduling Date");

                ReshuName := GlobalFunc.FormatUserName("Rescheduled By");
                LoansRec.Reset();
                LoansRec.SetRange("Loan No.", "Loan Rescheduling"."Loan No.");
                if LoansRec.FindFirst() then begin
                    CountN += 1;
                    LoansRec.CalcFields("Outstanding Balance");
                    Instal := LoansRec.Installments;
                    OustandBal := LoansRec."Outstanding Balance";
                end;
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
                group(GroupName)
                {
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyNam := CompanyInformation.Name;
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;


    var
        myInt: Integer;
        ReshuName: Text;
        GlobalFunc: Codeunit "Global Functions";
        OustandBal: Decimal;
        ReschDate: Text;
        Instal: Integer;
        CompanyInformation: Record "Company Information";
        CompanyNam: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        CountN: Integer;
}