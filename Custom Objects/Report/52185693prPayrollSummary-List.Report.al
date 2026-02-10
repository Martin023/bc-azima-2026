#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185693 "prPayrollSummary-List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/prPayrollSummary-List.rdl';

    dataset
    {
        dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Global Dimension 1 Code";
            column(SharesContr; SharesContr) { }
            column(DepositsCOntr; DepositsCOntr) { }
            column(SHIF; SHIF) { }
            column(HousingLevy; HousingLevy) { }

            column(PeriodName; PeriodName)
            {
            }
            column(PayrollMode; PayrollMode)
            {
            }
            column(strEmpName; strEmpName)
            {
            }
            column(BasicPay; BasicPay)
            {
            }
            column(Grosspay; Grosspay)
            {
            }
            column(PAYE; PAYE)
            {
            }
            column(ProjLoan; ProjLoan)
            {
            }
            column(Helb; Helb)
            {
            }
            column(prPayrollPeriodsDateOpened; objPeriod."Date Opened")
            {
            }
            column(Periodyear; objPeriod."Period Year")
            {
            }
            column(TestH; TestH)
            {
            }
            column(NHIF; NHIF)
            {
            }
            column(SaccContr; SaccContr)
            {
            }
            column(PenVoContr; PenVoContr)
            {
            }
            column(SIContr; SIContr)
            {
            }
            column(SaccLoan; SaccLoan)
            {
            }
            column(Nssf; Nssf)
            {
            }
            column(nonTaxAmount; nonTaxAmount)
            {
            }
            column(statutoryDed; statutoryDed)
            {
            }
            column(NetPay; NetPay)
            {
            }
            column(OtherAllow; OtherAllow)
            {
            }
            column(TotalDeductions; TotalDeductions)
            {
            }
            column(nonstatutoryDed; nonstatutoryDed)
            {
            }
            column(Pension; Pension)
            {
            }
            column(Branch; "Global Dimension 1 Code")

            {

            }
            column(negNet; negNet)
            {
            }
            column(strCodes; strCodes)
            {
            }
            column(TotnegNet; TotnegNet)
            {
            }
            column(TotNetPay; TotNetPay)
            {
            }
            column(totTotalDeductions; totTotalDeductions)
            {
            }
            column(TotPension; TotPension)
            {
            }
            column(TotnonstatutoryDed; TotnonstatutoryDed)
            {
            }
            column(TotstatutoryDed; TotstatutoryDed)
            {
            }
            column(TotnonTaxAmount; TotnonTaxAmount)
            {
            }
            column(TotGrosspay; TotGrosspay)
            {
            }
            column(TotOtherAllow; TotOtherAllow)
            {
            }
            column(TotBasicPay; TotBasicPay)
            {
            }
            column(DATE____________________________________________________________; 'DATE...........................................................')
            {
            }
            column(NAME_________________________________________________________________________________________; 'NAME........................................................................................')
            {
            }
            column(DESIGNATION_____________________________________________________; 'DESIGNATION....................................................')
            {
            }
            column(SIGNATURE____________________________________________________; 'SIGNATURE...................................................')
            {
            }
            column(SIGNATURE_____________________________________________________Control1102756035; 'SIGNATURE...................................................')
            {
            }
            column(DATE_____________________________________________________________Control1102756042; 'DATE...........................................................')
            {
            }
            column(NAME__________________________________________________________________________________________Control1102756031; 'NAME........................................................................................')
            {
            }
            column(DESIGNATION______________________________________________________Control1102756034; 'DESIGNATION....................................................')
            {
            }
            column(Payroll_Summary_ListCaption; Payroll_Summary_ListCaptionLbl)
            {
            }
            column(Gross_Taxable_PayCaption; Gross_Taxable_PayCaptionLbl)
            {
            }
            column(Non_Taxable_AmountCaption; Non_Taxable_AmountCaptionLbl)
            {
            }
            column(Statutory_DeductionsCaption; Statutory_DeductionsCaptionLbl)
            {
            }
            column(Total_DeductionsCaption; Total_DeductionsCaptionLbl)
            {
            }
            column(Pension_Staff_Cont_Caption; Pension_Staff_Cont_CaptionLbl)
            {
            }
            column(Negative_Net_PayCaption; Negative_Net_PayCaptionLbl)
            {
            }
            column(Other_AllowancesCaption; Other_AllowancesCaptionLbl)
            {
            }
            column(Net_PayCaption; Net_PayCaptionLbl)
            {
            }
            column(Basic_PayCaption; Basic_PayCaptionLbl)
            {
            }
            column(Employee_Name_Caption; Employee_Name_CaptionLbl)
            {
            }
            column(Non_Statutory_DeductionsCaption; Non_Statutory_DeductionsCaptionLbl)
            {
            }
            column(Employee_Code_Caption; Employee_Code_CaptionLbl)
            {
            }
            column(Totals_Caption; Totals_CaptionLbl)
            {
            }
            column(Checked_byCaption; Checked_byCaptionLbl)
            {
            }
            column(HR_Employee_No_; "No.")
            {
            }
            column(ReportForNavId_8631; 8631)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }

            trigger OnAfterGetRecord()
            begin

                strEmpName := "Last Name" + ' ' + "First Name" + ' ' + "Middle Name";
                strCodes := "No.";

                BasicPay := 0;
                Allow := 0;
                Grosspay := 0;
                PenGrat := 0;
                Nssf := 0;
                HseAllow := 0;
                statutoryDed := 0;
                nonstatutoryDed := 0;
                TaxablePay := 0;
                Reliefs := 0;
                OtherAllow := 0;
                TotalDeductions := 0;
                NetPay := 0;
                negNet := 0;
                nonTaxAmount := 0;
                Pension := 0;
                NHIF := 0;
                PAYE := 0;
                Helb := 0;
                SaccLoan := 0;
                SIContr := 0;
                PenVoContr := 0;
                SaccContr := 0;
                StaffAdv := 0;
                ProjLoan := 0;
                totTotalDeductions := 0;
                VolNssf := 0;
                SHIF := 0;
                HousingLevy := 0;
                DepositsCOntr := 0;
                SharesContr := 0;

                //Gross Taxable Pay
                //NSSF
                //SHIF
                //PAYE
                //AHL
                //TOTALDEDUCTION
                //Net Pay



                //Loop through the Income/Earnings and deductions************************************************************************
                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "No.");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetCurrentkey(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                PeriodTrans."Group Order", PeriodTrans."Sub Group Order");

                if PeriodTrans.Find('-') then
                    repeat
                        //Basic Pay************************START
                        if (PeriodTrans."Group Order" = 1) and (PeriodTrans."Sub Group Order" = 1) and (PeriodTrans."Transaction Code" = 'BPAY') then begin
                            BasicPay := PeriodTrans.Amount;
                            TotBasicPay := TotBasicPay + BasicPay;
                        end;

                        //Other Allowances************************START
                        if (PeriodTrans."Group Order" = 1) and (PeriodTrans."Sub Group Order" = 1) and (PeriodTrans."Transaction Code" <> 'BPAY') then begin
                            OtherAllow := OtherAllow + PeriodTrans.Amount;
                            TotOtherAllow := TotOtherAllow + PeriodTrans.Amount;
                        end;

                        //Gross Pay************************START
                        if (PeriodTrans."Group Order" = 1) and (PeriodTrans."Sub Group Order" = 7) then begin
                            Grosspay := Grosspay + PeriodTrans.Amount;
                            TotGrosspay := TotGrosspay + PeriodTrans.Amount;
                        end;

                        //other non taxable*************START
                        TransCodes.Reset;
                        TransCodes.SetRange(TransCodes."Transaction Code", PeriodTrans."Transaction Code");
                        TransCodes.SetRange(TransCodes.Taxable, false);
                        if TransCodes.FindFirst then begin
                            nonTaxAmount := nonTaxAmount + PeriodTrans.Amount;
                            TotnonTaxAmount := TotnonTaxAmount + PeriodTrans.Amount;
                        end;
                        /*
                         //Deductions Totals*************START
                           PeriodTrans.RESET;
                           PeriodTrans.SETRANGE(TransCodes."Transaction Code",PeriodTrans."Transaction Code");
                           PeriodTrans.SETRANGE(TransCodes.Taxable,FALSE) ;
                           IF PeriodTrans.FINDFIRST  THEN
                            BEGIN
                              nonTaxAmount:=nonTaxAmount+PeriodTrans.Amount;
                              TotnonTaxAmount:=TotnonTaxAmount+PeriodTrans.Amount;
                             END;
                       */

                        //Statutory Deductions*************
                        // SHIF,PAYE,AHL,NSSF
                        //if (PeriodTrans."Group Order" = 7) then begin
                        if (PeriodTrans."Transaction Code" = 'PAYE') or (PeriodTrans."Transaction Code" = 'NSSF') or (PeriodTrans."Transaction Code" = 'D048') or (PeriodTrans."Transaction Code" = 'D049') then begin
                            statutoryDed := statutoryDed + PeriodTrans.Amount;
                            TotstatutoryDed := TotstatutoryDed + PeriodTrans.Amount;
                        end;


                        //Pension ***************************START
                        if (PeriodTrans."Group Order" = 8) and (PeriodTrans."Sub Group Order" = 0) then begin
                            if PeriodTrans."Transaction Code" = 'D001' then begin
                                Pension := PeriodTrans.Amount;
                            end;
                        end;


                        //Sacco Contribution***************************START
                        // if (PeriodTrans."Group Order" = 8) and (PeriodTrans."Sub Group Order" = 0) then begin
                        //     if PeriodTrans."Transaction Code" = 'D02' then begin
                        //         SaccContr := PeriodTrans.Amount;
                        //     end;
                        // end;


                        //SIC Contribution***************************START
                        // if (PeriodTrans."Group Order" = 8) and (PeriodTrans."Sub Group Order" = 0) then begin
                        //     if PeriodTrans."Transaction Code" = 'D14' then begin
                        //         SIContr := PeriodTrans.Amount;
                        //     end;
                        // end;


                        //Pension Voluntary Contribution***************************START
                        // if (PeriodTrans."Group Order" = 8) and (PeriodTrans."Sub Group Order" = 0) then begin
                        //     if PeriodTrans."Transaction Code" = 'D048' then begin
                        //         PenVoContr := PeriodTrans.Amount;
                        //     end;
                        // end;

                        //Staff Advances***************************START
                        // if (PeriodTrans."Group Order" = 8) and (PeriodTrans."Sub Group Order" = 0) then begin
                        //     if PeriodTrans."Transaction Code" = 'D005' then begin
                        //         StaffAdv := PeriodTrans.Amount;
                        //     end;
                        // end;


                        //Sacco Loan Contribution***************************START
                        //if (PeriodTrans."Group Order" = 8) and (PeriodTrans."Sub Group Order" = 0) then begin
                        //IF (PeriodTrans."Transaction Code"='D23') AND
                        if PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::loan then begin
                            SaccLoan := SaccLoan + PeriodTrans.Amount;
                        end;
                        //end;

                        //HELB Contribution***************************START
                        // if (PeriodTrans."Group Order" = 8) and (PeriodTrans."Sub Group Order" = 0) then begin
                        // if PeriodTrans."Transaction Code" = 'D028' then begin
                        //     Helb := Helb + PeriodTrans.Amount;
                        // end;
                        //end;


                        //HELB Contribution***************************START
                        // if (PeriodTrans."Group Order" = 8) and (PeriodTrans."Sub Group Order" = 0) then begin
                        //     if PeriodTrans."Transaction Code" = 'D24' then begin
                        //         ProjLoan := ProjLoan + PeriodTrans.Amount;
                        //     end;
                        // end;

                        //Voluntary NSSF ***************************START
                        // if (PeriodTrans."Group Order" = 8) and (PeriodTrans."Sub Group Order" = 0) then begin
                        //     if PeriodTrans."Transaction Code" = 'D087' then begin
                        //         VolNssf := VolNssf + PeriodTrans.Amount;
                        //         //ERROR(FORMAT(VolNssf))
                        //     end
                        // end;

                        //NSSF ***************************START
                        //if (PeriodTrans."Group Order" = 7) and (PeriodTrans."Sub Group Order" = 1) then begin
                        if (PeriodTrans."Transaction Code" = 'NSSF') then begin
                            Nssf := PeriodTrans.Amount;
                            //ERROR(FORMAT(VolNssf));
                        end;


                        if (PeriodTrans."Transaction Code" = 'D049') then begin
                            SHIF := PeriodTrans.Amount;
                            //ERROR(FORMAT(VolNssf));
                        end;

                        if (PeriodTrans."Transaction Code" = 'D048') then begin
                            HousingLevy := PeriodTrans.Amount;
                            //ERROR(FORMAT(VolNssf));
                        end;



                        //PAYE ***************************START
                        if (PeriodTrans."Transaction Code" = 'PAYE') then begin
                            PAYE := PAYE + PeriodTrans.Amount;
                        end;


                        //NHIF ***************************START
                        // if (PeriodTrans."Group Order" = 7) and (PeriodTrans."Sub Group Order" = 2) then begin
                        //     NHIF := NHIF + PeriodTrans.Amount;
                        // end;

                        //Total Deductions***********************
                        // if (PeriodTrans."Group Order" = 8) and (PeriodTrans."Sub Group Order" = 0) then begin
                        //     TotalDeductions := TotalDeductions + PeriodTrans.Amount + Nssf + PAYE + NHIF;

                        // end;

                        TransCodes.Reset;
                        TransCodes.Setrange(TransCodes."Transaction Code", PeriodTrans."Transaction Code");
                        TransCodes.Setrange(TransCodes."Transaction Type", TransCodes."Transaction Type"::Deduction);
                        TransCodes.SetRange("Product Category", TransCodes."Product Category"::"BOSA Deposits");
                        if TransCodes.find('-') then begin
                            DepositsCOntr := PeriodTrans.Amount;
                        end;

                        TransCodes.Reset;
                        TransCodes.Setrange(TransCodes."Transaction Code", PeriodTrans."Transaction Code");
                        TransCodes.Setrange(TransCodes."Transaction Type", TransCodes."Transaction Type"::Deduction);
                        TransCodes.SetRange("Product Category", TransCodes."Product Category"::"Share Capital");
                        if TransCodes.find('-') then begin
                            SharesContr := PeriodTrans.Amount;
                        end;

                        TransCodes.Reset;
                        TransCodes.Setrange(TransCodes."Transaction Code", PeriodTrans."Transaction Code");
                        TransCodes.Setrange(TransCodes."Transaction Type", TransCodes."Transaction Type"::Deduction);
                        if TransCodes.find('-') then begin
                            TotalDeductions := TotalDeductions + PeriodTrans.Amount;
                        end;

                        //totTotalDeductions := Pension + SaccContr + SIContr + SaccLoan + PenVoContr + StaffAdv + ProjLoan + Helb + Nssf + PAYE + NHIF;

                        if (PeriodTrans."Transaction Code" = 'TOT-DED') then begin
                            totTotalDeductions := PeriodTrans.Amount;
                        end;

                        //Net Pay************************START
                        //if (PeriodTrans."Group Order" = 9) and (PeriodTrans."Sub Group Order" = 0) then begin
                        if (PeriodTrans."Transaction Code" = 'NPAY') then begin
                            if PeriodTrans.Amount < 0 then begin
                                NetPay := NetPay + 0;
                                TotNetPay := TotNetPay + 0;
                                negNet := PeriodTrans.Amount;
                                TotnegNet := TotnegNet + PeriodTrans.Amount;
                            end
                            else begin
                                NetPay := NetPay + PeriodTrans.Amount;
                                TotNetPay := TotNetPay + PeriodTrans.Amount
                            end;
                        end;
                    until PeriodTrans.Next = 0
                else
                    CurrReport.Skip;

            end;

            trigger OnPreDataItem()
            begin
                /*
                IF PayrollMode<>PayrollMode::" " THEN BEGIN
                    Table39003917.SETRANGE(Table39003917."Payment Mode",PayrollMode);
                END;
                */
                //OnViewCurrRec();

            end;
        }
        dataitem("PR Period Transactions"; "PR Period Transactions")
        {
            RequestFilterFields = "Payroll Period";
            column(ReportForNavId_1000000010; 1000000010)
            {
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

        //SelectedPeriod:=objPeriod.GETFILTER("Date Opened");
        SelectedPeriod := "PR Period Transactions".GetRangeMin("Payroll Period");
        objPeriod.Reset;
        objPeriod.SetRange(objPeriod."Date Opened", SelectedPeriod);
        if objPeriod.Find('-') then begin
            PeriodName := objPeriod."Period Name";
        end;


        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        strEmpName: Text[100];
        BasicPay: Decimal;
        Allow: Decimal;
        Grosspay: Decimal;
        PenGrat: Decimal;
        Nssf: Decimal;
        subTotNssf: Decimal;
        TotBasicPay: Decimal;
        TotAllow: Decimal;
        TotGrosspay: Decimal;
        TotPenGrat: Decimal;
        TotNssf: Decimal;
        PeriodTrans: Record "PR Period Transactions";
        TransCodes: Record "PR Transaction Codes";
        objPeriod: Record "PR Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[50];
        HseAllow: Decimal;
        HseTotAllow: Decimal;
        HREmployee: Record "HR Employees";
        subTotNHIF: Decimal;
        TotNHIF: Decimal;
        statutoryDed: Decimal;
        TotstatutoryDed: Decimal;
        subTotstatutoryDed: Decimal;
        TaxablePay: Decimal;
        TotTaxablePay: Decimal;
        SubTotTaxablePay: Decimal;
        Reliefs: Decimal;
        TotReliefs: Decimal;
        TaxCharged: Decimal;
        TotTaxCharged: Decimal;
        UnusedRelief: Decimal;
        SubTotUnusedRelief: Decimal;
        TotUnusedRelief: Decimal;
        PersonalRelief: Decimal;
        SubTotPersonalRelief: Decimal;
        TotPersonalRelief: Decimal;
        PAYETaxDeduction: Decimal;
        TotPAYETaxDeduction: Decimal;
        OtherDeduction: Decimal;
        TotOtherDeduction: Decimal;
        NetPay: Decimal;
        subTotNetPay: Decimal;
        TotNetPay: Decimal;
        subTotBasicPay: Decimal;
        subTotHseAllow: Decimal;
        SubTotGrosspay: Decimal;
        OtherAllow: Decimal;
        TotOtherAllow: Decimal;
        SubTotOtherAllow: Decimal;
        subtotTotalDeductions: Decimal;
        totTotalDeductions: Decimal;
        TotalDeductions: Decimal;
        companyHousing: Decimal;
        TotcompanyHousing: Decimal;
        SubTotcompanyHousing: Decimal;
        subTotReliefs: Decimal;
        SubTotTaxCharged: Decimal;
        subtotPAYETaxDeduction: Decimal;
        subTotOtherDeductions: Decimal;
        nonTaxAmount: Decimal;
        TotnonTaxAmount: Decimal;
        subTotnonTaxAmount: Decimal;
        nonstatutoryDed: Decimal;
        TotnonstatutoryDed: Decimal;
        subTotnonstatutoryDed: Decimal;
        Pension: Decimal;
        TotPension: Decimal;
        subTotPension: Decimal;
        negNet: Decimal;
        TotnegNet: Decimal;
        subTotnegNet: Decimal;
        strCodes: Code[10];
        CompanyInfo: Record "Company Information";
        PayrollMode: Option " ","Bank Transfer",Cheque,Cash,SACCO;
        Payroll_Summary_ListCaptionLbl: label 'Payroll Summary-List';
        Gross_Taxable_PayCaptionLbl: label 'Gross Taxable Pay';
        Non_Taxable_AmountCaptionLbl: label 'Non-Taxable Amount';
        Statutory_DeductionsCaptionLbl: label 'Statutory Deductions';
        Total_DeductionsCaptionLbl: label 'Total Deductions';
        Pension_Staff_Cont_CaptionLbl: label 'Pension Staff Cont.';
        Negative_Net_PayCaptionLbl: label 'Negative Net Pay';
        Other_AllowancesCaptionLbl: label 'Other Allowances';
        Net_PayCaptionLbl: label 'Net Pay';
        Basic_PayCaptionLbl: label 'Basic Pay';
        Employee_Name_CaptionLbl: label 'Employee Name:';
        Non_Statutory_DeductionsCaptionLbl: label 'Non Statutory Deductions';
        Employee_Code_CaptionLbl: label 'Employee Code:';
        Totals_CaptionLbl: label 'Totals:';
        Checked_byCaptionLbl: label 'Checked by';
        NHIF: Decimal;
        PAYE: Decimal;
        Helb: Decimal;
        SaccLoan: Decimal;
        SIContr: Decimal;
        PenVoContr: Decimal;
        SaccContr: Decimal;
        StaffAdv: Decimal;
        TestH: Decimal;
        ProjLoan: Decimal;
        TrCodes: Record "PR Transaction Codes";
        VolNssf: Decimal;
        SHIF: Decimal;
        TotSHIF: Decimal;
        HousingLevy: Decimal;
        TotHousingLevy: Decimal;
        SharesContr: Decimal;
        DepositsCOntr: Decimal;
        TotSharesContr: Decimal;
        TotDepositsCOntr: Decimal;


    //Gross Taxable Pay
    //NSSF
    //SHIF
    //PAYE
    //AHL
    //TOTALDEDUCTION
    //Net Pay



    procedure OnViewCurrRec()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestricViewTxt: label 'You do not have Permissions to VIEW,MODIFY or DELETE on this record. Contact system administrator for assistance. %';
    begin
        ChangePermission.Reset;
        ChangePermission.SetRange("User ID", UserId);
        ChangePermission.SetRange("View Payroll", true);
        ChangePermission.SetRange("Function Extended", ChangePermission."function extended"::"View Payroll");
        if not ChangePermission.Find('-') then
            Error(ErrorOnRestricViewTxt, UserId);
    end;
}
