#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185629 "Dividend Slip"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Dividend Slip.rdl';

    dataset
    {
        //dataitem(DividendProgression; "52185713")
        dataitem(DividendProgression; "Dividend Progression")
        {
            RequestFilterFields = "Member No", Year, "Start Date", "End Date", "Employer Code";
            column(ReportForNavId_1; 1)
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
            column(StartDate_DividendProgression; DividendProgression."End Date")
            {
            }
            column(ProductType_DividendProgression; DividendProgression."Product Type")
            {
            }
            column(ProductName_DividendProgression; DividendProgression."Product Name")
            {
            }
            column(QualifyingShares_DividendProgression; DividendProgression."Qualifying Shares")
            {
            }
            column(Shares_DividendProgression; DividendProgression.Shares)
            {
            }
            column(GrossDividends_DividendProgression; DividendProgression."Gross Dividends")
            {
            }
            column(WitholdingTax_DividendProgression; DividendProgression."Witholding Tax")
            {
            }
            column(NetDividends_DividendProgression; DividendProgression."Net Dividends")
            {
            }
            column(No_Members; DividendProgression."Member No")
            {
            }
            column(ElectrolZone; ElectrolZone)
            {
            }
            column(Maddress; Maddress)
            {
            }
            column(Mcity; Mcity)
            {
            }
            column(Mname; MName)
            {
            }
            column(MPayrollNo; MPayrollNo)
            {
            }
            column(MNo; MNo)
            {
            }
            column(DivRate; DivRate)
            {
            }
            column(IntRate; IntRate)
            {
            }
            column(WthTax; WthTax)
            {
            }
            column(Status; Status)
            {
            }
            column(Retained; Retained)
            {
            }
            column(RetainedTotal; RetainedTotal)
            {
            }
            column(rates; rates)
            {
            }
            column(RateRetained; RateRetained)
            {
            }
            column(LastContr; LastContr)
            {
            }
            column(LastDate; LastDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(ProcessingYear; ProcessingYear)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ProcessingYear := DividendProgression.Year;
                EndDate := Format(Dmy2date(31, 12, ProcessingYear));


                Members.Reset;
                Members.SetRange("No.", DividendProgression."Member No");
                if Members.Find('-') then begin
                    ElectrolZone := Members."Delegates Zone";
                    //Department:=
                    Maddress := Members."Post Code";
                    Mcity := Members.City;
                    MName := Members.Name;
                    MNo := Members."No.";
                    MPayrollNo := Members."Payroll/Staff No.";
                    Status := Members.Status;
                end;

                Retained := 0;
                RetainedTotal := 0;
                rates := 0;


                if ProductFactory.Get(DividendProgression."Product Type") then begin
                    if ProductFactory."Interest Rate (Max.)" <> 0 then
                        DivRate := ProductFactory."Interest Rate (Max.)" / 100;
                    if ProductFactory."Interest Rate (Min.)" <> 0 then
                        DivRate := ProductFactory."Interest Rate (Min.)" / 100;
                    if ProductFactory."WithHolding Tax" <> 0 then
                        WthTax := ROUND(ProductFactory."WithHolding Tax", 0.5, '>');

                    if ProductFactory."Product Category" = ProductFactory."product category"::"Share Capital" then begin
                        if Members.Status = Members.Status::Active then
                            DivRate := 1
                        else
                            //DivRate:=0;
                            DivRate := ProductFactory."Interest Rate (Max.)";
                        DividendProgression1.Reset;
                        DividendProgression1.SetRange("Member No", Members."No.");
                        DividendProgression1.SetRange("Product Type", ProductFactory."Product ID");
                        if DividendProgression1.Find('-') then begin
                            DividendProgression1.CalcSums("Net Dividends");
                            Retained := 0;//((DividendProgression1."Net Dividends")/DivRate);
                            ShareCp := Retained;
                            WthTax := ROUND(ProductFactory."WithHolding Tax", 0.05, '=');
                            RateRetained := '100 % of Net Dividends ';
                            rates := ProductFactory."Interest Rate (Max.)";
                        end;
                    end else
                        if ProductFactory."Product Category" = ProductFactory."Product Category"::"BOSA Deposits" then begin
                            DividendProgression1.Reset;
                            DividendProgression1.SetRange("Member No", Members."No.");
                            DividendProgression1.SetRange("Product Type", ProductFactory."Product ID");
                            if DividendProgression1.Find('-') then begin
                                DividendProgression1.CalcSums("Net Dividends");
                                Retained := 0;//((DividendProgression1."Net Dividends")/DivRate)/100;
                                DepContr := Retained;
                                WthTax := ROUND(ProductFactory."WithHolding Tax", 0.5, '>');
                                rates := ROUND(ProductFactory."Interest Rate (Max.)", 0.05, '=');
                                RateRetained := '';//'1/7 % of Net Interest';
                            end;

                        end;

                    RetainedTotal := 0;//DepContr+ShareCp;
                end;

                LastContr := 0;
                CurrentYear := (Date2dmy(Today, 3)) - 1;
                SLedgerEntry.SetRange(SLedgerEntry."Customer No.", DividendProgression."Account No");
                SLedgerEntry.SetFilter("Posting Date", '%1..%2', Dmy2date(1, 12, CurrentYear), Dmy2date(31, 12, CurrentYear));
                if SLedgerEntry.Find('-') then begin
                    SLedgerEntry.CalcSums(Amount);
                    LastContr := -SLedgerEntry.Amount;
                end;

                LastDate := Dmy2date(31, 12, CurrentYear);
            end;

            trigger OnPreDataItem()
            begin
                if DividendProgression.GetFilter(DividendProgression.Year) = '' then
                    DividendProgression.Year := (Date2dmy(Today, 3)) - 1
                else
                    DividendProgression.Year := DividendProgression.Year;
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
        MNo: Code[50];
        MName: Text[100];
        MPayrollNo: Code[50];
        MIDNumber: Code[50];
        MEmployer: Code[50];
        Members: Record "Members";
        ElectrolZone: Text;
        Department: Code[20];
        Section: Code[20];
        Maddress: Text[20];
        Mcity: Text[20];
        ProductFactory: Record "Product Factory";
        DivRate: Decimal;
        IntRate: Decimal;
        WthTax: Decimal;
        Status: Option " ",New,Active,Dormant,Frozen,"Withdrawal Application",Withdrawn,Deceased,Defaulter,Closed;
        Retained: Decimal;
        DividendProgression1: Record "Dividend Progression";
        RetainedTotal: Decimal;
        ShareCp: Decimal;
        DepContr: Decimal;
        rates: Decimal;
        RateRetained: Text;
        SLedgerEntry: Record "Savings Ledger Entry";
        CurrentYear: Integer;
        LastContr: Decimal;
        LastDate: Date;
        ProcessingYear: Integer;
        EndDate: Text;
}
