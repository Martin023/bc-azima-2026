namespace ALProject.ALProject;
using Microsoft.Foundation.Company;

report 52186177 "Fringe Benefit"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Fringe Benefit Report.rdl';
    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Source Unit" = filter("HR LOANS"), Posted = const(True));
            column(Member_No_; "Member No.")
            {

            }
            Column(Member_Name; "Member Name")

            {

            }
            column(Staff_No; "Staff No")
            {

            }
            column(Approved_Amount; "Approved Amount")
            {

            }
            column(Interest; Interest)
            {

            }
            column(KRA_PIN; "KRA PIN")
            {

            }
            column(Loan_No_; "Loan No.")
            {

            }
            column(Outstanding_Balance; "Outstanding Balance")
            {

            }
            column(Loan_Product_Type; "Loan Product Type")
            {

            }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
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
            column(MarketInterest; MarketInterest)
            {

            }
            column(Loan_Interest_Repayment; "Loan Interest Repayment")
            {

            }
            column(MarketAmount; MarketAmount)
            {

            }
            column(Difference; Difference)
            {

            }
            column(PercentofDifference; PercentofDifference)
            {

            }

            trigger OnAfterGetRecord()
            var
                RatesCeilings: record "PR Vital Setup Info";
            begin
                MarketInterest := 0;
                MarketAmount := 0;
                Difference := 0;
                PercentofDifference := 0;
                if Loans."Loan No." <> '' then begin
                    Loans.CalcFields("Outstanding Balance");
                    RatesCeilings.get();
                    RatesCeilings.testfield("Loan Market Rate");
                    MarketInterest := RatesCeilings."Loan Market Rate";


                    MarketAmount := (MarketInterest * Loans."Outstanding Balance" / 100) / 12;
                    Difference := MarketAmount - Loans."Loan Interest Repayment";
                    PercentofDifference := 0.30 * Difference;
                end;

            end;

            trigger OnPreDataItem()
            begin

                if startDate = 0D then
                    startDate := 19900101D;

                if Enddate = 0D then
                    Enddate := Today;

                Loans.SetRange("Disbursement Date", startDate, Enddate);

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
                group("Date Filter")
                {
                    field(startDate; startDate)
                    {

                        Caption = 'Start Date';
                        ShowMandatory = true;

                    }
                    field(Enddate; Enddate)
                    {
                        Caption = 'End Date';
                        ShowMandatory = true;
                    }
                }

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

        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        MarketInterest: decimal;
        MarketAmount: decimal;
        Difference: decimal;
        PercentofDifference: decimal;
        startDate: date;
        Enddate: date;
}
