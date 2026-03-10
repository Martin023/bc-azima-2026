#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185743 "Dividend Register Filtered"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Dividend Register Filtered.rdl';

    dataset
    {
        dataitem(Members; Members)
        {
            column(ReportForNavId_11; 11)
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
            column(PayrollStaffNo_Members; Members."Payroll/Staff No.")
            {
            }
            column(EmployerCode_Members; Members."Employer Code")
            {
            }
            column(No_Members; Members."No.")
            {
            }
            column(Name_Members; Members.Name)
            {
            }
            column(Shares_DividendProgression; Amount[1])
            {
            }
            column(QualifyingShares_DividendProgression; Amount[2])
            {
            }
            column(GrossDividends_DividendProgression; Amount[3])
            {
            }
            column(WitholdingTax_DividendProgression; Amount[4])
            {
            }
            column(NetDividends_DividendProgression; Amount[5])
            {
            }
            column(ProductName; ProductName)
            {
            }
            column(LoanCat; LoanCat)
            {
            }
            column(MemberStatus; Members.Status)
            {
            }
            column(FosaStatus; FosaStatus)
            {
            }
            column(Dept; Members."Employer Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                DividendProgression.Reset;
                DividendProgression.SetRange(DividendProgression."Member No", "No.");
                DividendProgression.SetRange("Product Type", ProductCode);
                DividendProgression.SetRange(Year, "Dividend Year");
                if DividendProgression.Find('-') then begin

                    DividendProgression.CalcSums(
                    DividendProgression.Shares, DividendProgression."Qualifying Shares", DividendProgression."Gross Dividends",
                    DividendProgression."Witholding Tax", DividendProgression."Net Dividends");
                    ProductName := DividendProgression."Product Name";
                    Amount[1] := ROUND(DividendProgression.Shares, 0.5, '=');
                    Amount[2] := ROUND(DividendProgression."Qualifying Shares", 0.5, '=');
                    Amount[3] := ROUND(DividendProgression."Gross Dividends", 0.5, '=');
                    Amount[4] := ROUND(DividendProgression."Witholding Tax", 0.5, '=');
                    Amount[5] := ROUND(DividendProgression."Net Dividends", 0.5, '=');


                    Loans.Reset;
                    Loans.SetRange("Member No.", Members."No.");
                    Loans.SetFilter("Outstanding Balance", '>%1', 0);
                    Loans.SetCurrentkey("Loans Category-SASRA");
                    if Loans.FindLast then begin
                        LoanCat := Loans."Loans Category-SASRA";
                    end;
                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange("Member No.", Members."No.");
                    SavingsAccounts.SetRange("Loan Disbursement Account", true);
                    SavingsAccounts.SetCurrentkey(Status);
                    if SavingsAccounts.FindLast then begin
                        FosaStatus := SavingsAccounts.Status;
                    end


                end else
                    CurrReport.Skip;
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
                field(ProductCode; ProductCode)
                {
                    ApplicationArea = Basic;
                    Caption = 'Product Type';
                    TableRelation = "Product Factory"."Product ID" where("Product Class Type" = const(Savings));
                }
                field("Dividend Year"; "Dividend Year")
                {
                    ApplicationArea = Basic;
                    Caption = 'Year';
                }
            }
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
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        CompanyInformation: Record "Company Information";
        DividendProgression: Record "Dividend Progression";
        DividendSavings: Decimal;
        QualifyingSavings: Decimal;
        GrossDividend: Decimal;
        WTax: Decimal;
        NetDividend: Decimal;
        Amount: array[10] of Decimal;
        ProductCode: Code[10];
        ProductName: Text[150];
        "Dividend Year": Integer;
        Loans: Record Loans;
        LoanCat: Enum "Loan Sasra Categories";//Option Perfoming,Watch,Substandard,Doubtful,Loss;
        FosaStatus: Enum "Savings Account Status";//Option " ",New,Active,Dormant,Frozen,"Withdrawal Application",Withdrawn,Deceased,Defaulter,Closed;
        SavingsAccounts: Record "Savings Accounts";
}
