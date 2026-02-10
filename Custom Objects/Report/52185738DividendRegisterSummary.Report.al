#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185738 "Dividend Register Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Dividend Register Summary.rdl';

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", Status, "Employer Code";
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
            column(Amount; Amount[1])
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
            column(EmpName; EmpName)
            {
            }
            column(ProductName; ProductName)
            {
            }
            column(BOSARATE; BOSARATE)
            {
            }
            column(SHCAPRATE; SHCAPRATE)
            {
            }
            column(BLNRATE; BLNRATE)
            {
            }
            column(Jan; Jan) { }
            column(Feb; Feb) { }
            column(Mar; Mar) { }
            column(Apr; Apr) { }
            column(May; May) { }
            column(Jun; Jun) { }
            column(Jul; Jul) { }
            column(Aug; Aug) { }
            column(Sep; Sep) { }
            column(Oct; Oct) { }
            column(Nov; Nov) { }
            column(Dec; Dec) { }
            column(Total; Total) { }
            column(WTax; WTax) { }
            column(NetDividend; NetDividend) { }
            column(DivAdv; DivAdv) { }

            trigger OnAfterGetRecord()
            begin
                Jan := 0;
                Feb := 0;
                Mar := 0;
                Apr := 0;
                May := 0;
                Jun := 0;
                Jul := 0;
                Aug := 0;
                Sep := 0;
                Oct := 0;
                Nov := 0;
                Dec := 0;
                Total := 0;
                WTax := 0;
                NetDividend := 0;
                DivAdv := 0;

                DividendProgression.Reset;
                DividendProgression.SetRange(DividendProgression."Member No", Members."No.");
                if ProductCode <> '' then
                    DividendProgression.SetRange("Product Type", ProductCode);
                DividendProgression.SetRange(Year, DividendsYear);
                if DividendProgression.Find('-') then begin
                    repeat
                        case
                            DividendProgression.Month of
                            1:
                                Jan += DividendProgression."Gross Dividends";
                            2:
                                Feb += DividendProgression."Gross Dividends";
                            3:
                                Mar += DividendProgression."Gross Dividends";
                            4:
                                Apr += DividendProgression."Gross Dividends";
                            5:
                                May += DividendProgression."Gross Dividends";
                            6:
                                Jun += DividendProgression."Gross Dividends";
                            7:
                                Jul += DividendProgression."Gross Dividends";
                            8:
                                Aug += DividendProgression."Gross Dividends";
                            9:
                                Sep += DividendProgression."Gross Dividends";
                            10:
                                Oct += DividendProgression."Gross Dividends";
                            11:
                                Nov += DividendProgression."Gross Dividends";
                            12:
                                Dec += DividendProgression."Gross Dividends";
                        end;
                        WTax += DividendProgression."Witholding Tax";
                        NetDividend += DividendProgression."Net Dividends";
                    until DividendProgression.Next() = 0;
                    Total := Jan + Feb + Mar + Apr + May + Jun + Jul + Aug + Sep + Oct + Nov + Dec;
                end;
                Loans.Reset;
                Loans.SetRange("Member No.", Members."No.");
                Loans.SetAutoCalcFields("Total Loan Balance");
                loans.setrange("Recovery Mode", loans."Recovery Mode"::Dividend);
                if Loans.FindSet() then begin
                    repeat
                        loans.CalcFields("Total Loan Balance");
                        DivAdv += Loans."Total Loan Balance";
                    until Loans.Next() = 0;
                end;
                // Sno += 1;
                // Loans.Reset;
                // Loans.SetRange("Member No.", Members."No.");
                // Loans.SetFilter("Outstanding Balance", '>%1', 0);
                // Loans.SetCurrentkey("Loans Category-SASRA");
                // if Loans.FindLast then begin
                //     LoanCat := Loans."Loans Category-SASRA";
                // end;
                EmpName := '';
                if Customer.Get(Members."Employer Code") then
                    EmpName := Customer.Name;
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
                field(ProductCode; ProductCode)
                {
                    ApplicationArea = Basic;
                    TableRelation = "Product Factory"."Product ID";
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
        NetDividend: Decimal;
        Amount: array[10] of Decimal;
        ProductFactory: Record "Product Factory";
        IntOnDep: Decimal;
        ShareCapInt: Decimal;
        DividendsYear: Integer;
        Sno: Integer;
        Loans: Record Loans;
        LoanCat: Enum "Loan Sasra categories";
        EmpName: Text;
        Customer: Record Customer;
        ProductCode: Code[10];
        ProductName: Text;
        Jan: Decimal;
        Feb: Decimal;
        Mar: Decimal;
        Apr: Decimal;
        May: Decimal;
        Jun: Decimal;
        Jul: Decimal;
        Aug: Decimal;
        Sep: Decimal;
        Oct: Decimal;
        Nov: Decimal;
        Dec: Decimal;
        Total: Decimal;
        BOSARATE: Decimal;
        SHCAPRATE: Decimal;
        BLNRATE: Decimal;
        GrossDIV: Decimal;
        WTAx: Decimal;
        DivAdv: Decimal;

}
