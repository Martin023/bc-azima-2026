Report 52186080 "CRM Loan Guaranteed Reports"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/CRM Loan Guaranteed Reports.rdl';
    UsageCategory = ReportsAndAnalysis;
    Caption = 'CRM Loan Guaranteed Reports';
    dataset
    {
        dataitem(Members; "Members")
        {
            RequestFilterFields = "No.", "Payroll/Staff No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(CompPic; Company.Picture)
            {

            }
            column(No_Member; Members."No.")
            {
            }
            column(Name_Member; Members.Name)
            {
            }

            column(EmployerCode_Members; Members."Employer Code")
            {
            }
            column(EmployerName_Members; Members."Employer Name")
            {
            }

            dataitem("Loan Guarantors and Security"; "Loan Guarantors and Security")
            {
                DataItemLink = "Member No" = field("No.");
                RequestFilterFields = "Total Loan Balance";
                column(ReportForNavId_1102755002; 1102755002)
                {
                }
                column(Loan_No; "Loan No")
                {
                }
                column(Loan_Type; "Loan Type")
                {
                }
                column(Loanee_Name; "Loanee Name")
                {
                }
                column(Loan_Balance; "Loan Balance")
                {

                }
                column(Amount_Guaranteed; "Amount Guaranteed")
                {

                }
                column(Date_Substituted; "Date Substituted")
                {

                }
                column(Substituted; Substituted)
                {

                }


                trigger OnAfterGetRecord()
                var
                    MemB: Record Members;
                    Cust: Record Customer;
                    LoanGua: Record "Loan Guarantors and Security";
                    CountNo: Integer;
                    TotaAmtGUR: Decimal;
                begin
                    MemB.Reset();
                    MemB.SetRange("No.", "Loan Guarantors and Security"."Member No");
                    MemB.SetRange(Status, MemB.Status::Deceased);
                    if MemB.FindFirst() then
                        LoanGua.Reset;
                    LoanGua.SetRange("Loan No", "Loan No");
                    LoanGua.SetRange("Guarantor Type", LoanGua."guarantor type"::Guarantor);
                    if LoanGua.Find('-') then begin
                        CountNo := LoanGua.Count;
                        LoanGua.CalcSums("Amount Guaranteed");
                        TotaAmtGUR := LoanGua."Amount Guaranteed";
                    end;
                    if TotaAmtGUR <> 0 then begin
                        PercentageGur := Round(((("Loan Guarantors and Security"."Amount Guaranteed" / TotaAmtGUR) * 100)), 0.01, '=');
                    end;

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
        Company.GET();
        Company.CALCFIELDS(Company.Picture);
        CompanyNam := Company.Name;
        CompanyAddress := Company.Address + ' -Post Code: ' + Company."Post Code" + ' -City:' + Company.City + ' Region: ' + Company."Country/Region Code";
        CompanyTelephone := 'Tel: ' + Company."Phone No." + ' -Office Tel: ' + Company."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + Company."E-Mail" + '- Website: ' + Company."Home Page";
    end;

    var
        Company: Record "Company Information";
        TotalLoan: Decimal;
        PercentageGur: Decimal;
        CompanyNam: Text;
        CompanyTelephone: Text;
        CompanyAddress: Text;
        MmberDeceased: Boolean;
        CommunicationOnline: Text;
        TotaAmtGUR: Decimal;
        GurantorEmpcode: Code[30];
}

