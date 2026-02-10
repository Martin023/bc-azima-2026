// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185909 "Staff Allowance  P9"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-kenpipe-2024/Layout/Staff Allowance  P9.rdl';

//     dataset
//     {
//         dataitem("HR Employee"; "HR Employee")
//         {
//             PrintOnlyIfDetail = true;
//             RequestFilterFields = "No.";
//             column(ReportForNavId_7066; 7066)
//             {
//             }
//             column(SelectedPeriod; SelectedPeriod)
//             {
//             }
//             column(EmployerPIN; EmployerPIN)
//             {
//             }
//             column(HR_Employee__First_Name_; "First Name")
//             {
//             }
//             column(HR_Employee__Last_Name_; "Last Name")
//             {
//             }
//             column(HR_Employee__Middle_Name_; Name)
//             {
//             }
//             column(HR_Employee__No__; "No.")
//             {
//             }
//             column(HR_Employee__PIN_Number_; "P.I.N Number")
//             {
//             }
//             column(Total_Tax_Charged_; "Total Tax Charged")
//             {
//             }
//             column(TotalL; TotalL)
//             {
//             }
//             column(TotaA; TotaA)
//             {
//             }
//             column(TotalB; TotalB)
//             {
//             }
//             column(totalD; totalD)
//             {
//             }
//             column(totalC; totalC)
//             {
//             }
//             column(TotalF; TotalF)
//             {
//             }
//             column(TotalE3; TotalE3)
//             {
//             }
//             column(TotalE2_PensionFT_InsuranceFT; TotalE2 + PensionFT + InsuranceFT)
//             {
//             }
//             column(TotalE1; TotalE1)
//             {
//             }
//             column(TotalL_Control1102756148; TotalL)
//             {
//             }
//             column(TotalK; TotalK)
//             {
//             }
//             column(TotalJ; TotalJ)
//             {
//             }
//             column(TotalH; TotalH)
//             {
//             }
//             column(TotalG; TotalG)
//             {
//             }
//             column(TOTAL_CHARGEABLE_PAY__COL_h__KshsCaption; TOTAL_CHARGEABLE_PAY__COL_h__KshsCaptionLbl)
//             {
//             }
//             column(TOTAL_CHARGEABLE_PAY__COL_l__Caption; TOTAL_CHARGEABLE_PAY__COL_l__KshsCaptionLbl)
//             {
//             }
//             column(Income_Tax_DepartmentCaption; Income_Tax_DepartmentCaptionLbl)
//             {
//             }
//             column(INCOME_TAX_DEDUCTION_CARD_YEAR_Caption; INCOME_TAX_DEDUCTION_CARD_YEAR_CaptionLbl)
//             {
//             }
//             column(EMPLOYER_S_PINCaption; EMPLOYER_S_PINCaptionLbl)
//             {
//             }
//             column(MONTHCaption; MONTHCaptionLbl)
//             {
//             }
//             column(Basic_SalaryCaption; Basic_SalaryCaptionLbl)
//             {
//             }
//             column(Benefits__Non_CashCaption; Benefits__Non_CashCaptionLbl)
//             {
//             }
//             column(Value_Of__QuartersCaption; Value_Of__QuartersCaptionLbl)
//             {
//             }
//             column(Total__Gross_PayCaption; Total__Gross_PayCaptionLbl)
//             {
//             }
//             column(Defined_Contribution__Retirement_SchemeCaption; Defined_Contribution__Retirement_SchemeCaptionLbl)
//             {
//             }
//             column(Owner_Occupier_InterestCaption; Owner_Occupier_InterestCaptionLbl)
//             {
//             }
//             column(Retirement_Contribution___Owner_OccupierCaption; Retirement_Contribution___Owner_OccupierCaptionLbl)
//             {
//             }
//             column(IMPORTANTCaption; IMPORTANTCaptionLbl)
//             {
//             }
//             column(Column_D_G__Chargeable_AmountCaption; Column_D_G__Chargeable_AmountCaptionLbl)
//             {
//             }
//             column(prEmployee_P9_Info__Tax_Charged_Caption; "prEmployee P9 Info".FieldCaption("Tax Charged"))
//             {
//             }
//             column(Personal__ReliefCaption; Personal__ReliefCaptionLbl)
//             {
//             }
//             column(prEmployee_P9_Info__Insurance_Relief_Caption; "prEmployee P9 Info".FieldCaption("Insurance Relief"))
//             {
//             }
//             column(P_A_Y_E__TAXCaption; P_A_Y_E__TAXCaptionLbl)
//             {
//             }
//             column(ECaption; ECaptionLbl)
//             {
//             }
//             column(E1__30_Caption; E1__30_CaptionLbl)
//             {
//             }
//             column(E2__ActualCaption; E2__ActualCaptionLbl)
//             {
//             }
//             column(E3__FIXEDCaption; E3__FIXEDCaptionLbl)
//             {
//             }
//             column(b__AttachCaption; b__AttachCaptionLbl)
//             {
//             }
//             column(ACaption; ACaptionLbl)
//             {
//             }
//             column(TotalBenefits; TotalBenefits)
//             {
//             }
//             column(TotalE2; TotalE2)
//             {
//             }
//             column(Mortgage; Mortgage)
//             {
//             }
//             column(Actual; Actual)
//             {
//             }
//             column(BCaption; BCaptionLbl)
//             {
//             }
//             column(CCaption; CCaptionLbl)
//             {
//             }
//             column(DCaption; DCaptionLbl)
//             {
//             }
//             column(V1__Use_P9ACaption; V1__Use_P9ACaptionLbl)
//             {
//             }
//             column(a__For_all_liable_employees_and_where_director_employee_received_Benefits_in_additions_to_cash_emoluments_Caption; a__For_all_liable_employees_and_where_director_employee_received_Benefits_in_additions_to_cash_emoluments_CaptionLbl)
//             {
//             }
//             column(b__Where_an_employee_is_eligible_to_deduction_on_owner_occupier_interest_Caption; b__Where_an_employee_is_eligible_to_deduction_on_owner_occupier_interest_CaptionLbl)
//             {
//             }
//             column(V2___a__Allowable_interest_in_respect_of_any_month_mustnot_exceed_Kshs_12_500___per_year_Caption; V2___a__Allowable_interest_in_respect_of_any_month_mustnot_exceed_Kshs_12_500___per_year_CaptionLbl)
//             {
//             }
//             column(V2___a__Allowable_interest_in_respect_of_any_month_mustnot_exceed_Kshs_12_500___per_year_Caption_Control1102755010; V2___a__Allowable_interest_in_respect_of_any_month_mustnot_exceed_Kshs_12_500___per_year_Caption_Control1102755010Lbl)
//             {
//             }
//             column(See_back_of_this_card_for_further_information_required_by_the_department__Caption; See_back_of_this_card_for_further_information_required_by_the_department__CaptionLbl)
//             {
//             }
//             column(ii__THE_DECLARATION_duly_signed_by_the_employee_Caption; ii__THE_DECLARATION_duly_signed_by_the_employee_CaptionLbl)
//             {
//             }
//             column(i__Photostat_copy_of_interest_certificate_and_statement_of_account_from_the_Financial_Institution_Caption; i__Photostat_copy_of_interest_certificate_and_statement_of_account_from_the_Financial_Institution_CaptionLbl)
//             {
//             }
//             column(F__Amount_of_InterestCaption; F__Amount_of_InterestCaptionLbl)
//             {
//             }
//             column(G__Lowest_of_E_added_to_FCaption; G__Lowest_of_E_added_to_FCaptionLbl)
//             {
//             }
//             column(HCaption; HCaptionLbl)
//             {
//             }
//             column(JCaption; JCaptionLbl)
//             {
//             }
//             column(V1_162_00Caption; V1_162_00CaptionLbl)
//             {
//             }
//             column(KCaption; KCaptionLbl)
//             {
//             }
//             column(V0Caption; V0CaptionLbl)
//             {
//             }
//             column(LCaption; LCaptionLbl)
//             {
//             }
//             column(Total__Kshs___1_162_00Caption; Total__Kshs___1_162_00CaptionLbl)
//             {
//             }
//             column(Employee_s_NameCaption; Employee_s_NameCaptionLbl)
//             {
//             }
//             column(Personal_File_No_Caption; Personal_File_No_CaptionLbl)
//             {
//             }
//             column(Employee_PINCaption; Employee_PINCaptionLbl)
//             {
//             }
//             column(Employer_s_NameCaption; Employer_s_NameCaptionLbl)
//             {
//             }
//             column(TOTAL_CHARGEABLE_PAY__COL_J__K_PoundCaption; TOTAL_CHARGEABLE_PAY__COL_J__K_PoundCaptionLbl)
//             {
//             }
//             column(TOTAL_TAX__COL_M__KshsCaption; TOTAL_TAX__COL_M__KshsCaptionLbl)
//             {
//             }
//             column(DataItem1102756111; V1__Date_employee_commenced_if_during_the_year______________________________________________________Name_and_address_of_emploLbl)
//             {
//             }
//             column(DataItem1102756112; V2__Date_left_if_during_the_year_____________________________________________________________________________Name_and_addressLbl)
//             {
//             }
//             column(V3__Where_housing_is_provided__State_monthly_rent___________________________________Caption; V3__Where_housing_is_provided__State_monthly_rent___________________________________CaptionLbl)
//             {
//             }
//             column(CERTIFICATE_OF_PAY_AND_TAXCaption; CERTIFICATE_OF_PAY_AND_TAXCaptionLbl)
//             {
//             }
//             column(NAME_______________________________________________________________Caption; NAME_______________________________________________________________CaptionLbl)
//             {
//             }
//             column(ADDRESS___________________________________________________________Caption; ADDRESS___________________________________________________________CaptionLbl)
//             {
//             }
//             column(SIGNATURE___________________________________________________________Caption; SIGNATURE___________________________________________________________CaptionLbl)
//             {
//             }
//             column(DATE___STAMP___________________________________________________________Caption; DATE___STAMP___________________________________________________________CaptionLbl)
//             {
//             }
//             column(P9ACaption; P9ACaptionLbl)
//             {
//             }
//             column(V4___Where_any_of_the_pay_relates_to_a_period_other_that_this_year_e_g_gratuity__give_details___________________Caption; V4___Where_any_of_the_pay_relates_to_a_period_other_that_this_year_e_g_gratuity__give_details___________________CaptionLbl)
//             {
//             }
//             column(YearCaption; YearCaptionLbl)
//             {
//             }
//             column(Amount__Kenya_Pounds_Caption; Amount__Kenya_Pounds_CaptionLbl)
//             {
//             }
//             column(Tax__Shs_Caption; Tax__Shs_CaptionLbl)
//             {
//             }
//             column(DataItem1102756145; NAMES_OF_MORTGAGE_FINANCIAL_INSTITUTION______________________________________________________________________________________Lbl)
//             {
//             }
//             column(DataItem1102756146; L_R__No__OF_OWNER_OCCUPIED_HOUSE_____________________________________________________________________________DATE_OF_OCCUPATILbl)
//             {
//             }
//             column(Reference_No__________________________________________Caption; Reference_No__________________________________________CaptionLbl)
//             {
//             }
//             column(TotalCaption; TotalCaptionLbl)
//             {
//             }
//             dataitem("prEmployee P9 Info"; "prEmployee P9 Info")
//             {
//                 DataItemLink = "Employee Code" = field("No.");
//                 DataItemTableView = sorting("Employee Code", "Payroll Period") order(ascending);
//                 column(ReportForNavId_7242; 7242)
//                 {
//                 }
//                 column(Employer_Name_; "Employer Name")
//                 {
//                 }
//                 column(prEmployee_P9_Info__Basic_Pay_; "Basic Pay")
//                 {
//                 }
//                 column(prEmployee_P9_Info_Benefits; Benefits)
//                 {
//                 }
//                 column(prEmployee_P9_Info__Value_Of_Quarters_; "Value Of Quarters")
//                 {
//                 }
//                 column(prEmployee_P9_Info__Gross_Pay_; "Gross Pay")
//                 {
//                 }
//                 column(prEmployee_P9_Info__Owner_Occupier_Interest_; "Owner Occupier Interest")
//                 {
//                 }
//                 column(Basic_Pay__0_3; "Basic Pay" * 0.3)
//                 {
//                 }
//                 column(prEmployee_P9_Info_NSSF; NSSF)
//                 {
//                 }
//                 column(fixedDefContri; fixedDefContri)
//                 {
//                 }
//                 column(Gross_Pay__ColG; "Gross Pay" - ColG)
//                 {
//                 }
//                 column(prEmployee_P9_Info__Tax_Charged_; "Tax Charged")
//                 {
//                 }
//                 column(prEmployee_P9_Info__Tax_Relief_; "Tax Relief")
//                 {
//                 }
//                 column(prEmployee_P9_Info__Insurance_Relief_; "Insurance Relief")
//                 {
//                 }
//                 column(prEmployee_P9_Info_PAYE; PAYE)
//                 {
//                 }
//                 column(ColG; ColG)
//                 {
//                 }
//                 column(prEmployee_P9_Info_Employee_Code; "Employee Code")
//                 {
//                 }
//                 column(prEmployee_P9_Info_Payroll_Period; Format("Payroll Period", 0, '<Month Text>'))
//                 {
//                 }
//                 column(EmployerName; EmployerName)
//                 {
//                 }
//                 column(Allowances_prEmployeeP9Info; "prEmployee P9 Info".Allowances)
//                 {
//                 }
//                 column(FORMAT__prEmployee_P9_Info___Payroll_Period__0___Month_Text___; Format("Payroll Period", 0, '<Month Text>'))
//                 {
//                 }

//                 trigger OnAfterGetRecord()
//                 var
//                     prPayrollProcess: Codeunit "Registration Process";
//                 begin

//                     P9.Reset;
//                     P9.SetRange(P9."Employee Code", "HR Employee"."No.");
//                     P9.SetRange(P9."Period Year", SelectedPeriod);
//                     if P9.Find('-') then begin
//                         repeat
//                             TotaA := TotaA + P9."Basic Pay";
//                             TotalB := TotalB + P9.Benefits;
//                             totalC := totalC + P9."Value Of Quarters";
//                             totalD := totalD + P9."Gross Pay";
//                             TotalE1 := TotalE1 + (P9."Basic Pay" * 0.3);
//                             TotalE2 := TotalE2 + (P9.NSSF/*+P9."Defined Contribution"*/);
//                             TotalE3 := TotalE3 + 20000;
//                             TotalF := TotalF + P9."Owner Occupier Interest";
//                             if P9.NSSF < 20000 then begin
//                                 //TotalG:=TotalG+P9.NSSF;
//                                 TotalH := TotalH + (P9."Gross Pay"/*-(P9.NSSF+P9."Defined Contribution")*/);
//                             end else begin
//                                 //TotalG:=TotalG+20000;
//                                 TotalH := TotalH + (P9."Gross Pay" - 20000);
//                             end;
//                             TotalJ := TotalJ + P9."Tax Charged";
//                             TotalK := TotalK + (P9."Tax Relief" + P9."Insurance Relief");
//                             TotalL := TotalL + P9.PAYE;
//                         until P9.Next = 0;
//                     end;

//                     "Total Tax Charged" := TotalJ;






//                     PensionF := 0;
//                     PeriodTrans.Reset;
//                     PeriodTrans.SetRange(PeriodTrans."Employee Code", "prEmployee P9 Info"."Employee Code");
//                     PeriodTrans.SetRange(PeriodTrans."Payroll Period", "prEmployee P9 Info"."Payroll Period");
//                     PeriodTrans.SetFilter(PeriodTrans."Transaction Code", 'D13');
//                     if PeriodTrans.Find('-') then begin
//                         PensionF := PeriodTrans.Amount;
//                         PensionFT += PensionF;
//                     end;

//                     InsuranceF := 0;
//                     PeriodTrans.Reset;
//                     PeriodTrans.SetRange(PeriodTrans."Employee Code", "prEmployee P9 Info"."Employee Code");
//                     PeriodTrans.SetRange(PeriodTrans."Payroll Period", "prEmployee P9 Info"."Payroll Period");
//                     PeriodTrans.SetFilter(PeriodTrans."Transaction Code", 'D0008');
//                     if PeriodTrans.Find('-') then begin
//                         InsuranceF := PeriodTrans.Amount;
//                         InsuranceFT += InsuranceF;
//                     end;

//                     if (/*"Defined Contribution"+*/NSSF + PensionF + InsuranceF) > 20000 then begin
//                         ColG := 20000 + "Owner Occupier Interest";
//                         TotalG := TotalG + ColG;
//                     end
//                     else begin
//                         ColG := (/*"Defined Contribution"+*/NSSF + PensionF + InsuranceF) + "Owner Occupier Interest";
//                         TotalG := TotalG + ColG;
//                     end;

//                 end;

//                 trigger OnPreDataItem()
//                 begin
//                     "prEmployee P9 Info".SetFilter("prEmployee P9 Info"."Period Year", Format(SelectedPeriod));
//                     PensionFT := 0;
//                     InsuranceFT := 0;
//                 end;
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 TotaA := 0;
//                 TotalB := 0;
//                 totalC := 0;
//                 totalD := 0;
//                 TotalE1 := 0;
//                 TotalE2 := 0;
//                 TotalE3 := 0;
//                 TotalF := 0;
//                 TotalG := 0;
//                 TotalH := 0;
//                 TotalJ := 0;
//                 TotalK := 0;
//                 TotalL := 0;

//                 /*
//                 P9.RESET;
//                 P9.SETRANGE(P9."Employee Code","HR Employee"."No.");
//                 P9.SETRANGE(P9."Period Year",SelectedPeriod);
//                 IF P9.FIND('-') THEN
//                  BEGIN
//                   REPEAT
//                    TotaA:=TotaA+P9."Basic Pay";
//                    TotalB:=TotalB+P9.Benefits;
//                    totalC:=totalC+P9."Value Of Quarters";
//                    totalD:=totalD+P9."Gross Pay";
//                    TotalE1:=TotalE1+(P9."Basic Pay"*0.3);
//                    TotalE2:=TotalE2+(P9.NSSF{+P9."Defined Contribution"});
//                    TotalE3:=TotalE3+20000;
//                    TotalF:=TotalF+P9."Owner Occupier Interest";
//                    IF P9.NSSF<20000 THEN BEGIN
//                     //TotalG:=TotalG+P9.NSSF;
//                     TotalH:=TotalH+(P9."Gross Pay"{-(P9.NSSF+P9."Defined Contribution")});
//                    END ELSE BEGIN
//                      //TotalG:=TotalG+20000;
//                      TotalH:=TotalH+(P9."Gross Pay"-20000);
//                    END;
//                    TotalJ:=TotalJ+P9."Tax Charged";
//                    TotalK:=TotalK+(P9."Tax Relief"+P9."Insurance Relief");
//                    TotalL:=TotalL+P9.PAYE;
//                   UNTIL P9.NEXT=0;
//                  END;

//                 "Total Tax Charged":=TotalJ;
//                 */

//             end;

//             trigger OnPreDataItem()
//             begin
//                 if SelectedPeriod = 0 then begin
//                     Error('Select Period');
//                 end;
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//             area(content)
//             {
//                 field("Selected Period :"; SelectedPeriod)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     trigger OnInitReport()
//     begin
//         SelectedPeriod := Date2dmy(Today, 3) - 1;
//     end;

//     trigger OnPreReport()
//     begin

//         if "control info".Get then begin
//             "control info".CalcFields(Picture);
//         end;
//         CompInfo.Reset;
//         if CompInfo.Get() then begin
//             EmployerPIN := CompInfo."PIN No";
//             "Employer Name" := CompInfo.Name;
//         end;


//         CompInfo.Reset;
//         if CompInfo.Get() then begin
//             "Employer Name" := CompInfo.Name;
//         end;
//     end;

//     var
//         CompInfo: Record "Company Information";
//         strEmpName: Text[250];
//         strPin: Text[30];
//         EmployerPIN: Text[30];
//         SelectedPeriod: Integer;
//         fixedDefContri: Decimal;
//         "Total Tax Charged": Decimal;
//         "Total PAYE": Decimal;
//         TotaA: Decimal;
//         TotalB: Decimal;
//         totalC: Decimal;
//         totalD: Decimal;
//         TotalE1: Decimal;
//         TotalE2: Decimal;
//         TotalE3: Decimal;
//         TotalF: Decimal;
//         TotalG: Decimal;
//         TotalH: Decimal;
//         TotalI: Decimal;
//         TotalJ: Decimal;
//         TotalK: Decimal;
//         TotalL: Decimal;
//         Mortgage: Decimal;
//         Actual: Decimal;
//         P9: Record "PR Employee P9 Info";
//         TotalBenefits: Decimal;
//         ColG: Decimal;
//         "control info": Record "Company Information";
//         "Employer Name": Text[50];
//         PeriodTrans: Record "PR Period Transactions";
//         PensionF: Decimal;
//         PensionFT: Decimal;
//         InsuranceF: Decimal;
//         InsuranceFT: Decimal;
//         Income_Tax_DepartmentCaptionLbl: label 'DOMESTIC TAXES DEPARTMENT';
//         INCOME_TAX_DEDUCTION_CARD_YEAR_CaptionLbl: label 'TAX DEDUCTION CARD YEAR:';
//         EMPLOYER_S_PINCaptionLbl: label 'EMPLOYER''S PIN';
//         MONTHCaptionLbl: label 'MONTH';
//         Basic_SalaryCaptionLbl: label 'Basic Salary';
//         Benefits__Non_CashCaptionLbl: label 'Benefits\ Non-Cash';
//         Value_Of__QuartersCaptionLbl: label 'Value Of\ Quarters';
//         Total__Gross_PayCaptionLbl: label 'Total\ Gross Pay';
//         Defined_Contribution__Retirement_SchemeCaptionLbl: label 'Defined Contribution\ Retirement Scheme';
//         Owner_Occupier_InterestCaptionLbl: label 'Owner Occupier Interest';
//         i__Photostat_copy_of_interest_certificate_and_statement_of_account_from_the_Financial_Institution_CaptionLbl: label ' (i) Photostat copy of interest certificate and statement of account from the Financial Institution.';
//         Retirement_Contribution___Owner_OccupierCaptionLbl: label 'Retirement Contribution \ Owner Occupier';
//         Column_D_G__Chargeable_AmountCaptionLbl: label 'Column D-G\ Chargeable Amount';
//         Personal__ReliefCaptionLbl: label 'Personal\ Relief';
//         TOTAL_CHARGEABLE_PAY__COL_h__KshsCaptionLbl: label 'TOTAL CHARGEABLE PAY (COL h) Kshs';
//         TOTAL_CHARGEABLE_PAY__COL_l__KshsCaptionLbl: label 'TOTAL CHARGEABLE PAY (COL l) Kshs';
//         P_A_Y_E__TAXCaptionLbl: label 'P.A.Y.E. TAX';
//         ECaptionLbl: label 'E';
//         E1__30_CaptionLbl: label 'E1 \30%';
//         E2__ActualCaptionLbl: label 'E2 \Actual';
//         E3__FIXEDCaptionLbl: label 'E3 \FIXED';
//         ACaptionLbl: label 'A';
//         BCaptionLbl: label 'B';
//         CCaptionLbl: label 'C';
//         DCaptionLbl: label 'D';
//         F__Amount_of_InterestCaptionLbl: label 'Amount of Interest';
//         G__Lowest_of_E_added_to_FCaptionLbl: label 'Lowest of E added to F';
//         HCaptionLbl: label 'H';
//         JCaptionLbl: label 'J';
//         V1_162_00CaptionLbl: label '1,162.00';
//         KCaptionLbl: label 'K';
//         V0CaptionLbl: label '0';
//         LCaptionLbl: label 'L';
//         Total__Kshs___1_162_00CaptionLbl: label 'Total (Kshs)';
//         Employee_s_NameCaptionLbl: label 'Employee''s Name';
//         Personal_File_No_CaptionLbl: label 'Personal File No.';
//         Employee_PINCaptionLbl: label 'Employee PIN';
//         Employer_s_NameCaptionLbl: label 'Employer''s Name';
//         TOTAL_CHARGEABLE_PAY__COL_J__K_PoundCaptionLbl: label 'TOTAL CHARGEABLE PAY (COL J) K-Pound';
//         TOTAL_TAX__COL_M__KshsCaptionLbl: label 'TOTAL TAX (COL M) Kshs';
//         V1__Date_employee_commenced_if_during_the_year______________________________________________________Name_and_address_of_emploLbl: label '(1) Date employee commenced if during the year .....................................';
//         V2__Date_left_if_during_the_year_____________________________________________________________________________Name_and_addressLbl: label '(2) Date left if during the year .................................................................. ';
//         V3__Where_housing_is_provided__State_monthly_rent___________________________________CaptionLbl: label '(3) Where housing is provided, State monthly rent ..................................';
//         CERTIFICATE_OF_PAY_AND_TAXCaptionLbl: label 'CERTIFICATE OF PAY AND TAX';
//         NAME_______________________________________________________________CaptionLbl: label 'NAME      .........................................................';
//         ADDRESS___________________________________________________________CaptionLbl: label 'ADDRESS  .........................................................';
//         SIGNATURE___________________________________________________________CaptionLbl: label 'SIGNATURE  .........................................................';
//         DATE___STAMP___________________________________________________________CaptionLbl: label 'DATE & STAMP  .........................................................';
//         P9ACaptionLbl: label 'P9A';
//         V4___Where_any_of_the_pay_relates_to_a_period_other_that_this_year_e_g_gratuity__give_details___________________CaptionLbl: label '(4)  Where any of the pay relates to a period other that this year e.g gratuity, give details...................';
//         YearCaptionLbl: label 'Year';
//         Amount__Kenya_Pounds_CaptionLbl: label 'Amount (Kenya Pounds)';
//         Tax__Shs_CaptionLbl: label 'Tax (Shs)';
//         NAMES_OF_MORTGAGE_FINANCIAL_INSTITUTION______________________________________________________________________________________Lbl: label 'NAMES OF MORTGAGE FINANCIAL INSTITUTION .........................................................................................';
//         L_R__No__OF_OWNER_OCCUPIED_HOUSE_____________________________________________________________________________DATE_OF_OCCUPATILbl: label 'L.R. No. OF OWNER OCCUPIED HOUSE........................................................................ .';
//         Reference_No__________________________________________CaptionLbl: label 'Reference No: ........................................';
//         TotalCaptionLbl: label 'Total';
//         EmployerName: Text;
//         IMPORTANTCaptionLbl: label 'IMPORTANT';
//         b__AttachCaptionLbl: label '(b) Attach';
//         ii__THE_DECLARATION_duly_signed_by_the_employee_CaptionLbl: label ' (ii) THE DECLARATION duly signed by the employee.';
//         V1__Use_P9ACaptionLbl: label '1. Use P9A';
//         a__For_all_liable_employees_and_where_director_employee_received_Benefits_in_additions_to_cash_emoluments_CaptionLbl: label '(a) For all liable employees and where director/employee received';
//         next: label ' Benefits in additions to cash emoluments.';
//         b__Where_an_employee_is_eligible_to_deduction_on_owner_occupier_interest_CaptionLbl: label '(b) Where an employee is eligible to deduction on owner occupier interest.';
//         V2___a__Allowable_interest_in_respect_of_any_month_mustnot_exceed_Kshs_12_500___per_year_CaptionLbl: label '2. (a) Allowable interest in respect of any month must not exceed Kshs.25,000/= per year.';
//         V2___a__Allowable_interest_in_respect_of_any_month_mustnot_exceed_Kshs_12_500___per_year_Caption_Control1102755010Lbl: label '2. (a) Allowable interest in respect of any month must not exceed Kshs.25,000/= per year.';
//         See_back_of_this_card_for_further_information_required_by_the_department__CaptionLbl: label '(See back of this card for further information required by the department).';
// }

