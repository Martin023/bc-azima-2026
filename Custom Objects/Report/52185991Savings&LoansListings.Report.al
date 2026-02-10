#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185991 "Savings & Loans Listings"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Savings & Loans Listings.rdl';

    dataset
    {
        dataitem(members; members)
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(CompanyName; CompanyNam)
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
            column(PayrollStaffNo_Members; Members."Payroll/Staff No.")
            {
            }
            column(No_Members; Members."No.")
            {
            }
            column(Name_Members; Members.Name)
            {
            }
            column(InvBalance; InvBalance)
            {
            }
            column(RMFBalance; RMFBalance)
            {
            }
            column(SharesCap; SharesCap)
            {
            }
            column(DepositBal; DepositBal)
            {
            }
            column(DevLoanBal; DevLoanBal)
            {
            }
            column(SchFeeLoanBal; SchFeeLoanBal)
            {
            }
            column(EmergLoanBal; EmergLoanBal)
            {
            }
            column(DefLoanBal; DefLoanBal)
            {
            }
            column(SerialNo; SerialNo)
            {
            }
            column(TotalLoans; TotalLoans)
            {
            }
            column(BBFBalance; BBFBalance)
            {
            }
            column(KaribuLoan; karibubal)
            {
            }
            column(JisaidieTopUp; Jisaidietopupbal)
            {
            }
            column(MkomboziLoan; mkomboziBal)
            {
            }
            column(Jisaidie72Loan; Jisaidie72Bal)
            {
            }
            column(FosaAdvance; FosaadvanceBal)
            {
            }
            column(PersonalLoan; PersonalBal)
            {
            }
            column(SalaryInAdvance; SalInAdvancebal)
            {
            }
            column(MboostaLoan; Mboostabal)
            {
            }
            column(MOULoan; MOUbal)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {

            }
            column(MaendeleoLoan; Maendeleobal)
            {
            }
            column(RefinancingLoan; Refinancebal)
            {
            }
            column(SalaryAdvance; Salaryadvancebal)
            {
            }

            trigger OnAfterGetRecord()
            begin

                SerialNo := SerialNo + 1;
                SharesCap := 0;
                BBFBalance := 0;
                InvBalance := 0;
                DepositBal := 0;

                /*IF StartDate=0D THEN StartDate:=19500101D; IF EndDate=0D THEN EndDate:=30500101D;*/

                Evaluate(FromDate, Format(StartDate));
                Evaluate(ToDate, Format(EndDate));
                DateFilter := FromDate + '..' + ToDate;

                DateFilter := Members.GetFilter("Date Filter");

                SavingAcc.Reset;
                SavingAcc.SetRange("Member No.", Members."No.");
                SavingAcc.SetFilter("Date Filter", DateFilter);
                SavingAcc.SetRange("Product Category", SavingAcc."Product Category"::"BOSA Deposits");
                if SavingAcc.Find('-') then begin
                    SavingAcc.CalcFields("Balance (LCY)");
                    DepositBal := SavingAcc."Balance (LCY)";
                end;


                SavingAcc.Reset;
                SavingAcc.SetRange("Member No.", Members."No.");
                SavingAcc.SetFilter("Date Filter", DateFilter);
                SavingAcc.SetRange("Product Category", SavingAcc."product category"::"Share Capital");
                if SavingAcc.Find('-') then begin
                    SavingAcc.CalcFields("Balance (LCY)");
                    SharesCap := SavingAcc."Balance (LCY)";
                end;
                /*
                SavingAcc.RESET;
                SavingAcc.SETRANGE("Member No.",Members."No.");
                //SavingAcc.SETFILTER("Date Filter",DateFilter);
                SavingAcc.SETRANGE("Product Category",SavingAcc."Product Category"::Investment);
                IF SavingAcc.FIND('-') THEN BEGIN
                  SavingAcc.CALCFIELDS("Balance (LCY)");
                  InvBalance:=SavingAcc."Balance (LCY)";
                  END;
                  */

                SavingAcc.Reset;
                SavingAcc.SetRange("Member No.", Members."No.");
                SavingAcc.SetFilter("Date Filter", DateFilter);
                SavingAcc.SetRange("Product Category", SavingAcc."Product Category"::"Benevolent (BBF)");
                if SavingAcc.Find('-') then begin
                    SavingAcc.CalcFields("Balance (LCY)");
                    BBFBalance := SavingAcc."Balance (LCY)";
                end;

                GetProduct;

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
        OustandBal: Decimal;
        Instal: Integer;
        CompanyInformation: Record "Company Information";
        CompanyNam: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        CountN: Integer;
        SharesCap: Decimal;
        RMFBalance: Decimal;
        InvBalance: Decimal;
        SavingAcc: Record "Savings Accounts";
        DepositBal: Decimal;
        DateFilter: Text[100];
        FromDate: Text[100];
        ToDate: Text[100];
        StartDate: Date;
        EndDate: Date;
        DevLoanBal: Decimal;
        TotalLoans: Decimal;
        SchFeeLoanBal: Decimal;
        EmergLoanBal: Decimal;
        RefLoanBal: Decimal;
        DefLoanBal: Decimal;
        AlmLoanBal: Decimal;
        JongLoanBal: Decimal;
        ShujLoanBal: Decimal;
        TibLoanBal: Decimal;
        MPoaLoanBal: Decimal;
        CreditAcc: Record Loans;
        ProductFac: Record "Product Factory";
        DevLoan: Code[10];
        SchFeeLoan: Code[10];
        EmergLoan: Code[10];
        RefLoan: Code[10];
        DefLoan: Code[10];
        AlmLoan: Code[10];
        JongLoan: Code[10];
        ShujLoan: Code[10];
        TibLoan: Code[10];
        MPoaLoan: Code[10];
        PlotLoan: Code[10];
        SerialNo: Integer;
        OutBal: Decimal;
        OutBalance: Integer;
        karibu: Code[20];
        karibubal: Decimal;
        Jisaidietopupbal: Decimal;
        Jisaidietopup: Code[20];
        mkomboziBal: Decimal;
        mkombozi: Code[20];
        Jisaidie72Bal: Decimal;
        Jisaidie72: Code[20];
        FosaadvanceBal: Decimal;
        Fosaadvance: Code[20];
        PersonalBal: Decimal;
        Personal: Code[20];
        SalInAdvance: Code[20];
        SalInAdvancebal: Decimal;
        Mboostabal: Decimal;
        Mboosta: Code[20];
        MOUbal: Decimal;
        MOU: Code[20];
        Maendeleobal: Decimal;
        Maendeleo: Code[20];
        Refinancebal: Decimal;
        Refinance: Code[20];
        Jisadietopup: Code[20];
        Salaryadvancebal: Decimal;
        Salaryadvance: Code[20];
        BBFBalance: Decimal;


    procedure GetProduct()
    begin

        DevLoanBal := 0;
        SchFeeLoanBal := 0;
        EmergLoanBal := 0;
        Jisaidietopupbal := 0;
        DefLoanBal := 0;
        mkomboziBal := 0;
        Jisaidie72Bal := 0;
        FosaadvanceBal := 0;
        PersonalBal := 0;
        karibubal := 0;
        SalInAdvancebal := 0;
        mkomboziBal := 0;
        Mboostabal := 0;
        MOUbal := 0;
        Salaryadvancebal := 0;
        Maendeleobal := 0;
        Refinancebal := 0;
        TotalLoans := 0;

        CreditAcc.Reset;
        CreditAcc.SetRange("Member No.", Members."No.");
        CreditAcc.SetFilter("Outstanding Balance", '>0');
        CreditAcc.SetFilter("Date Filter", DateFilter);
        if CreditAcc.Find('-') then begin
            repeat
                CreditAcc.CalcFields("Outstanding Balance");
                if ProductFac.Get(CreditAcc."Loan Product Type") then begin
                    case ProductFac."Product ID" of
                        '111':
                            begin
                                DevLoan := ProductFac."Product ID";
                                DevLoanBal := CreditAcc."Outstanding Balance";
                            end;
                        '113':
                            begin
                                SchFeeLoan := ProductFac."Product ID";
                                SchFeeLoanBal := CreditAcc."Outstanding Balance";
                            end;

                        '112':
                            begin
                                EmergLoan := ProductFac."Product ID";
                                EmergLoanBal := CreditAcc."Outstanding Balance";
                            end;

                        '115':
                            begin
                                Jisadietopup := ProductFac."Product ID";
                                Jisaidietopupbal := CreditAcc."Outstanding Balance";
                            end;

                        '133':
                            begin
                                DefLoan := ProductFac."Product ID";
                                DefLoanBal := CreditAcc."Outstanding Balance";
                            end;

                        '165':
                            begin
                                mkombozi := ProductFac."Product ID";
                                mkomboziBal := CreditAcc."Outstanding Balance";
                            end;

                        '124':
                            begin
                                Jisaidie72 := ProductFac."Product ID";
                                Jisaidie72Bal := CreditAcc."Outstanding Balance";
                            end;

                        '134':
                            begin
                                Personal := ProductFac."Product ID";
                                PersonalBal := CreditAcc."Outstanding Balance";
                            end;
                        '118':
                            begin
                                Fosaadvance := ProductFac."Product ID";
                                FosaadvanceBal := CreditAcc."Outstanding Balance";
                            end;
                        '119':
                            begin
                                Salaryadvance := ProductFac."Product ID";
                                Salaryadvancebal := CreditAcc."Outstanding Balance";
                            end;
                        '114':
                            begin
                                karibu := ProductFac."Product ID";
                                karibubal := CreditAcc."Outstanding Balance";
                            end;

                        '123':
                            begin
                                SalInAdvance := ProductFac."Product ID";
                                SalInAdvancebal := CreditAcc."Outstanding Balance";
                            end;
                        '125':
                            begin
                                mkombozi := ProductFac."Product ID";
                                mkomboziBal := CreditAcc."Outstanding Balance";
                            end;
                        '126':
                            begin
                                Mboosta := ProductFac."Product ID";
                                Mboostabal := CreditAcc."Outstanding Balance";
                            end;
                        '127':
                            begin
                                MOU := ProductFac."Product ID";
                                MOUbal := CreditAcc."Outstanding Balance";
                            end;
                        '128':
                            begin
                                Maendeleo := ProductFac."Product ID";
                                Maendeleobal := CreditAcc."Outstanding Balance";
                            end;
                        '130':
                            begin
                                Refinance := ProductFac."Product ID";
                                Refinancebal := CreditAcc."Outstanding Balance";
                            end;

                    end;

                end;
            until CreditAcc.Next = 0;
        end;

        TotalLoans := (DevLoanBal +
        SchFeeLoanBal +
        EmergLoanBal +
        Jisaidietopupbal +
        DefLoanBal +
        mkomboziBal +
        Jisaidie72Bal +
        FosaadvanceBal +
        PersonalBal +
        karibubal +
        SalInAdvancebal +
        mkomboziBal +
        Mboostabal +
        MOUbal +
        Maendeleobal +
        Refinancebal +
        Salaryadvancebal
        );
    end;
}
