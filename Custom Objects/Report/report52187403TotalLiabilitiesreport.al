report 52187403 "Total Liabilities report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Total Liabilities Report';
    RDLCLayout = './bc-azima-2026/Layout/Total Liabilities Report.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Outstanding Balance" = filter(> 0));
            column(Loan_No_; "Loan No.")
            {

            }
            column(Member_No_; "Member No.")
            {

            }
            column(Member_Name; "Member Name")
            {

            }
            column(Total_Balance; "Total Balance")
            {

            }
            column(Repayment; Repayment)
            {

            }
            column(Installments; Installments)
            {

            }
            column(Approved_Amount; "Approved Amount")
            { }
            column(DepositsAmt; DepositsAmt)
            { }
            column(Gender; Gender)
            {

            }
            column(CompanyAddress; CompanyAddress)
            {

            }
            column(picture; CompanyInformation.Picture)
            {
            }
            column(CompanyNam; CompanyNam)
            { }
            column(CompanyTelephone; CompanyTelephone)
            {

            }
            column(AccountBal; AccountBal)
            {

            }
            column(TotalLiab; TotalLiab)
            { }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                savingsac: Record "Savings Accounts";
                Members: Record Members;
                LoanRec: Record Loans;
                TotalOutstandings: Decimal;
                TotalLiab: Decimal;
                GuaraSec: Record "Loan Guarantors and Security";
                AmountGua: Decimal;
            begin
                GuaraSec.Reset();
                GuaraSec.SetRange("Member No", Loans."Member No.");
                if GuaraSec.FindFirst() then begin
                    repeat
                        AmountGua := AmountGua + GuaraSec."Amount Guaranteed";
                    until GuaraSec.Next() = 0;
                end;
                Members.Reset();
                Members.SetRange("No.", Loans."Member No.");
                if Members.FindFirst() then begin
                    if Members."Date of Birth" <> 0D then
                        DOB := GlobalsFunc.FormatDate(Members."Date of Birth");
                    Gender := Format(Members.Gender);

                end;
                LoanRec.Reset();
                LoanRec.SetRange("Member No.", Loans."Member No.");
                if LoanRec.FindFirst() then begin
                    LoanRec.CalcFields(LoanRec."Outstanding Balance", LoanRec."Outstanding Interest");
                    TotalOutstandings := LoanRec."Outstanding Balance" + LoanRec."Outstanding Interest";
                end;
                savingsac.Reset();
                savingsac.SetRange("Product Category", savingsac."Product Category"::"BOSA Deposits");
                savingsac.SetRange("Member No.", Loans."Member No.");
                if savingsac.FindFirst() then begin
                    savingsac.CalcFields(Balance);
                    DepositsAmt := savingsac.Balance;
                    AccountBal := savingsac.GetAvailableBalance(savingsac."No.");
                end;
                TotalLiab := TotalOutstandings + AmountGua;

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
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(CompanyInformation.Picture);

        CompanyNam := CompanyInformation.Name;
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        // IF (StartDate = 0D) OR (StartDate = 0D) THEN ERROR('Start date or End date must have a value!');
        // StartDateText := SkyHarambee.FormatDate(StartDate);
        // EndDateText := SkyHarambee.FormatDate(EndDate);
    end;

    var
        myInt: Integer;
        AccountBal: Decimal;
        DepositsAmt: Decimal;
        TotalLiab: Decimal;
        CompanyInformation: Record "Company Information";
        DOB: Text;
        CompanyTelephone: Text;
        GlobalsFunc: Codeunit "Global Functions";
        Gender: Text;
        CompanyNam: Text;
        CompanyAddress: Text;
}