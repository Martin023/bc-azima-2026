namespace ALProject.ALProject;
using Microsoft.Foundation.Company;

report 52186972 FlaggedDividendRegister
{
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings

    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Flagged Dividend Register.rdl';

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", Status, "Employer Code";
            DataItemTableView = where("Subflag" = filter(Deceased | "Rejoined" | "Partial withdrawn" | Withdrawal));

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
            column(No_Members; Members."No.")
            {
            }
            column(Name_Members; Members.Name)
            {
            }
            Column(KraPin; Members."P.I.N Number")
            {

            }
            column(Shares_DividendProgression; Amount[1])
            {
            }
            column(QualifyingShares_DividendProgression; Amount[7])
            {
            }
            column(SharesQualifyingShares_DividendProgression; Amount[2])
            {
            }
            column(DepQualifyingShares_DividendProgression; Amount[6])
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
            column(Sno; Sno)
            {
            }
            column(Status_Members; Members.Status)
            {
            }
            column(LoanCat; LoanCat)
            {
            }
            column(EmployerCode_Members; Members."Employer Code")
            {
            }
            column(PayrollStaffNo_Members; Members."Payroll/Staff No.")
            {
            }
            column(SavingsStatus; SavingsStatus)
            {
            }
            column(ShareCapital; Shares)
            {
            }
            column(DepositContributions; Deposits)
            {
            }
            column(AmountCapitalize; AmountCapitalize)
            {

            }
            column(LoanArrears; LoanArrears)
            {

            }
            column(BBFArrears; BBFArrears)
            {

            }
            column(RiskArrears; RiskArrears)
            {

            }

            trigger OnAfterGetRecord()
            begin
                Shares := 0;
                Deposits := 0;
                HrLoanArrears := 0;
                BOSALoanArrears := 0;
                FosaLoans := 0;
                LoanArrears := 0;
                BBFArrears := 0;
                RiskArrears := 0;
                DividendProgression.Reset;
                DividendProgression.SetRange(DividendProgression."Member No", Members."No.");
                DividendProgression.SetRange(Year, DividendsYear);
                if DividendProgression.Find('-') then begin
                    If DividendProgression."Product Type" = '2' then begin
                        Amount[2] := DividendProgression."Qualifying Shares";
                    End else
                        If DividendProgression."Product Type" = '1' then begin
                            DividendProgression.CalcSums(DividendProgression."Qualifying Shares");
                            Amount[6] := DividendProgression."Qualifying Shares";

                        End;
                    DividendProgression.CalcSums(DividendProgression.Shares, DividendProgression."Gross Dividends", DividendProgression."Qualifying Shares",
                                                 DividendProgression."Witholding Tax", DividendProgression."Net Dividends");

                    Amount[1] := DividendProgression.Shares;
                    Amount[2] := DividendProgression."Qualifying Shares";
                    Amount[3] := DividendProgression."Gross Dividends";
                    Amount[4] := DividendProgression."Witholding Tax";
                    Amount[5] := DividendProgression."Net Dividends";
                    Amount[7] := DividendProgression."Qualifying Shares";




                end else
                    CurrReport.Skip;


                DividendProgression.Reset;
                DividendProgression.SetRange(DividendProgression."Member No", Members."No.");
                DividendProgression.SetRange(Year, DividendsYear);
                DividendProgression.SetFilter("Product Type", '2|3');
                if DividendProgression.Find('-') then begin
                    DividendProgression.CalcSums(DividendProgression.Shares, DividendProgression."Qualifying Shares", DividendProgression."Gross Dividends",
                                                 DividendProgression."Witholding Tax", DividendProgression."Net Dividends");
                    Shares := DividendProgression.Shares;
                end;

                DividendProgression.Reset;
                DividendProgression.SetRange(DividendProgression."Member No", Members."No.");
                DividendProgression.SetRange(Year, DividendsYear);
                DividendProgression.SetFilter("Product Type", '1');
                if DividendProgression.Find('-') then begin
                    DividendProgression.CalcSums(DividendProgression.Shares, DividendProgression."Qualifying Shares", DividendProgression."Gross Dividends",
                                                 DividendProgression."Witholding Tax", DividendProgression."Net Dividends");
                    Deposits := DividendProgression.Shares;
                end;


                Sno += 1;
                Loans.Reset;
                Loans.SetRange("Member No.", Members."No.");
                Loans.SetFilter("Outstanding Balance", '>%1', 0);
                Loans.SetCurrentkey("Loans Category-SASRA");
                if Loans.FindLast then begin
                    LoanCat := Loans."Loans Category-SASRA";
                end;
                SavingsStatus := Savingsstatus::" ";
                SavingsAccounts.Reset;
                SavingsAccounts.SetRange("Member No.", Members."No.");
                SavingsAccounts.SetRange("Loan Disbursement Account", true);
                if SavingsAccounts.Find('-') then begin
                    SavingsStatus := SavingsAccounts.Status;
                end;

                HrLoanArrears := LoansProcess.CalculateMemberArrearsPerSourceUnit(Members."No.", Today, 4);
                BusinessLoans := LoansProcess.CalculateMemberArrearsPerSourceUnit(Members."No.", Today, 3);
                BOSALoanArrears := LoansProcess.CalculateMemberArrearsPerSourceUnit(Members."No.", Today, 2);
                FosaLoans := LoansProcess.CalculateMemberArrearsPerSourceUnit(Members."No.", Today, 1);
                LoanArrears := HrLoanArrears + BusinessLoans + BOSALoanArrears + FosaLoans;
                Evaluate(PeriodRange, '50Y');
                RiskArrears := RegnProcess.CalculateSavingArrears(Members."No.", '5', PeriodRange, Today);
                BBFArrears := RegnProcess.CalculateSavingArrears(Members."No.", '4', PeriodRange, Today);
                DividendInstr.Reset();
                DividendInstr.setrange("Member No.", Members."No.");
                If DividendInstr.FIND('-') THEN begin
                    AmountCapitalize := DividendInstr.Amount;
                end;

            end;

            trigger OnPreDataItem()
            begin
                if DividendsYear = 0 then Error('Kindly specify dividends year');
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
                field("Dividends Year"; DividendsYear)
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
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
        CompanyInformation: record "Company Information";
        DividendProgression: Record "Dividend Progression";
        DividendSavings: Decimal;
        QualifyingSavings: Decimal;
        GrossDividend: Decimal;
        WTax: Decimal;
        NetDividend: Decimal;
        Amount: array[10] of Decimal;
        ProductFactory: Record "Product Factory";
        IntOnDep: Decimal;
        ShareCapInt: Decimal;
        DividendsYear: Integer;
        Sno: Integer;
        Loans: Record Loans;
        LoanCat: Option Perfoming,Watch,Substandard,Doubtful,Loss;
        SavingsAccounts: Record "Savings Accounts";
        SavingsStatus: Option " ",New,Active,Dormant,Frozen,"Withdrawal Application",Withdrawn,Deceased,Defaulter,Closed;
        Shares: Decimal;
        Deposits: Decimal;
        MemberFactBox: record "Member FactBox";
        LoanArrears: decimal;
        BBFArrears: decimal;
        RiskArrears: decimal;
        InterestArrears: decimal;
        LoansProcess: Codeunit "Loans Process";
        HrLoanArrears: decimal;
        BusinessLoans: decimal;
        BOSALoanArrears: decimal;
        FosaLoans: decimal;
        RegnProcess: Codeunit "Registration Process";
        PeriodRange: DateFormula;
        DividendInstr: record "Dividend Instructions - Member";
        AmountCapitalize: decimal;


}
