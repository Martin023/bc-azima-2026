namespace ALProject.ALProject;
using Microsoft.Foundation.Company;
using System.Security.User;
using Microsoft.Finance.Dimension;

report 52186507 "Self Service Slip Portal"
{
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings

    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Self Service Individual Payslip Portal.rdl';


    dataset
    {
        dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
        {
            DataItemTableView = sorting("No.") WHERE(Status = filter(Active));
            PrintOnlyIfDetail = true;


            column(ReportForNavId_8631; 8631)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(IDNumber_HREmployees; "HR Employees"."Primary Identification")
            {
            }
            column(COMPANYNAME_Control1102756028; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Picture_Control1102756013; CompanyInfo.Picture)
            {
            }
            column(CompanyInfoCompanyWatermark; CompanyInfo."Company Watermark2")
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

            column(HR_Employee_No_; "No.")
            {
            }
            column(Age; "HR EMPLOYEES".Age)
            {

            }
            column(ages; ages)
            {

            }
            column(GlobalDimension1Code_HREmployees; "HR Employees"."Global Dimension 1 Code")
            {
            }
            column(PINNo_HREmployees; "HR Employees"."PIN No.")
            {
            }
            column(NSSFNo_HREmployees; "HR Employees"."NSSF No.")
            {
            }
            column(NHIFNo_HREmployees; "HR Employees"."NHIF No.")
            {
            }
            column(GlobalDimension2Code_HREmployees; "HR Employees"."Global Dimension 2 Code")
            {
            }
            column(No_HREmployees; "HR Employees"."No.")
            {
            }
            column(FullName_HREmployees; "HR Employees"."Full Name")
            {
            }
            column(JobTitle_HREmployees; "HR Employees"."Job Title")
            {
            }
            column(Spacer; Spacer)
            {
            }
            column(CountyName; CountyName)
            {
            }
            column(Department; Department)
            {

            }
            dataitem("PR Salary Card"; "PR Salary Card")
            {
                DataItemLink = "Employee Code" = field("No.");
                DataItemTableView = sorting("Employee Code") order(ascending);
                PrintOnlyIfDetail = false;
                RequestFilterFields = "Employee Code", "Period Filter";
                column(ReportForNavId_9285; 9285)
                {
                }
                column(NoDaysWorked; NoDaysWorked)
                {
                }
                column(RatePerDay; RatePerDay)
                {
                }
                column(Trans_1__1_; Trans[1] [1])
                {
                }
                column(TransAmt_1__1_; TransAmt[1] [1])
                {
                }
                column(TransBal_1__1_; TransBal[1] [1])
                {
                }
                column(TransBal_1__2_; TransBal[1] [2])
                {
                }
                column(TransAmt_1__2_; TransAmt[1] [2])
                {
                }
                column(Trans_1__2_; Trans[1] [2])
                {
                }
                column(TransBal_1__3_; TransBal[1] [3])
                {
                }
                column(TransAmt_1__3_; TransAmt[1] [3])
                {
                }
                column(Trans_1__3_; Trans[1] [3])
                {
                }
                column(TransBal_1__4_; TransBal[1] [4])
                {
                }
                column(TransBal_1__5_; TransBal[1] [5])
                {
                }
                column(TransBal_1__6_; TransBal[1] [6])
                {
                }
                column(TransAmt_1__4_; TransAmt[1] [4])
                {
                }
                column(TransAmt_1__5_; TransAmt[1] [5])
                {
                }
                column(TransAmt_1__6_; TransAmt[1] [6])
                {
                }
                column(Trans_1__4_; Trans[1] [4])
                {
                }
                column(Trans_1__5_; Trans[1] [5])
                {
                }
                column(Trans_1__6_; Trans[1] [6])
                {
                }
                column(TransBal_1__7_; TransBal[1] [7])
                {
                }
                column(TransBal_1__8_; TransBal[1] [8])
                {
                }
                column(TransBal_1__9_; TransBal[1] [9])
                {
                }
                column(TransAmt_1__7_; TransAmt[1] [7])
                {
                }
                column(TransAmt_1__8_; TransAmt[1] [8])
                {
                }
                column(TransAmt_1__9_; TransAmt[1] [9])
                {
                }
                column(Trans_1__7_; Trans[1] [7])
                {
                }
                column(Trans_1__8_; Trans[1] [8])
                {
                }
                column(Trans_1__9_; Trans[1] [9])
                {
                }
                column(TransBal_1__10_; TransBal[1] [10])
                {
                }
                column(TransBal_1__12_; TransBal[1] [12])
                {
                }
                column(TransBal_1__13_; TransBal[1] [13])
                {
                }
                column(TransAmt_1__10_; TransAmt[1] [10])
                {
                }
                column(TransAmt_1__12_; TransAmt[1] [12])
                {
                }
                column(TransAmt_1__13_; TransAmt[1] [13])
                {
                }
                column(Trans_1__10_; Trans[1] [10])
                {
                }
                column(Trans_1__12_; Trans[1] [12])
                {
                }
                column(Trans_1__13_; Trans[1] [13])
                {
                }
                column(TransBal_1__14_; TransBal[1] [14])
                {
                }
                column(TransBal_1__15_; TransBal[1] [15])
                {
                }
                column(TransBal_1__16_; TransBal[1] [16])
                {
                }
                column(TransBal_1__17_; TransBal[1] [17])
                {
                }
                column(TransBal_1__18_; TransBal[1] [18])
                {
                }
                column(TransBal_1__19_; TransBal[1] [19])
                {
                }
                column(TransBal_1__11_; TransBal[1] [11])
                {
                }
                column(TransBal_1__20_; TransBal[1] [20])
                {
                }
                column(TransAmt_1__14_; TransAmt[1] [14])
                {
                }
                column(TransAmt_1__15_; TransAmt[1] [15])
                {
                }
                column(TransAmt_1__16_; TransAmt[1] [16])
                {
                }
                column(TransAmt_1__17_; TransAmt[1] [17])
                {
                }
                column(TransAmt_1__18_; TransAmt[1] [18])
                {
                }
                column(TransAmt_1__19_; TransAmt[1] [19])
                {
                }
                column(TransAmt_1__11_; TransAmt[1] [11])
                {
                }
                column(TransAmt_1__20_; TransAmt[1] [20])
                {
                }
                column(Trans_1__14_; Trans[1] [14])
                {
                }
                column(Trans_1__15_; Trans[1] [15])
                {
                }
                column(Trans_1__16_; Trans[1] [16])
                {
                }
                column(Trans_1__17_; Trans[1] [17])
                {
                }
                column(Trans_1__18_; Trans[1] [18])
                {
                }
                column(Trans_1__19_; Trans[1] [19])
                {
                }
                column(Trans_1__11_; Trans[1] [11])
                {
                }
                column(Trans_1__20_; Trans[1] [20])
                {
                }
                column(Addr_1__1_; Addr[1] [1])
                {
                }
                column(Addr_1__2_; Addr[1] [2])
                {
                }
                column(Addr_1__3_; Addr[1] [3])
                {
                }
                column(TransBal_1__21_; TransBal[1] [21])
                {
                }
                column(TransBal_1__22_; TransBal[1] [22])
                {
                }
                column(TransAmt_1__21_; TransAmt[1] [21])
                {
                }
                column(TransAmt_1__22_; TransAmt[1] [22])
                {
                }
                column(TransBal_1__23_; TransBal[1] [23])
                {
                }
                column(TransAmt_1__23_; TransAmt[1] [23])
                {
                }
                column(TransBal_1__24_; TransBal[1] [24])
                {
                }
                column(TransAmt_1__24_; TransAmt[1] [24])
                {
                }
                column(Trans_1__21_; Trans[1] [21])
                {
                }
                column(Trans_1__23_; Trans[1] [23])
                {
                }
                column(Trans_1__24_; Trans[1] [24])
                {
                }
                column(Trans_1__22_; Trans[1] [22])
                {
                }
                column(TransBal_1__25_; TransBal[1] [25])
                {
                }
                column(TransAmt_1__25_; TransAmt[1] [25])
                {
                }
                column(Trans_1__25_; Trans[1] [25])
                {
                }
                column(TransBal_1__26_; TransBal[1] [26])
                {
                }
                column(TransAmt_1__26_; TransAmt[1] [26])
                {
                }
                column(Trans_1__26_; Trans[1] [26])
                {
                }
                column(TransBal_1__27_; TransBal[1] [27])
                {
                }
                column(TransAmt_1__27_; TransAmt[1] [27])
                {
                }
                column(Trans_1__27_; Trans[1] [27])
                {
                }
                column(TransBal_1__28_; TransBal[1] [28])
                {
                }
                column(TransAmt_1__28_; TransAmt[1] [28])
                {
                }
                column(Trans_1__28_; Trans[1] [28])
                {
                }
                column(TransBal_1__29_; TransBal[1] [29])
                {
                }
                column(TransAmt_1__29_; TransAmt[1] [29])
                {
                }
                column(Trans_1__29_; Trans[1] [29])
                {
                }
                column(TransBal_1__30_; TransBal[1] [30])
                {
                }
                column(TransAmt_1__30_; TransAmt[1] [30])
                {
                }
                column(Trans_1__30_; Trans[1] [30])
                {
                }
                column(TransBal_1__31_; TransBal[1] [31])
                {
                }
                column(TransAmt_1__31_; TransAmt[1] [31])
                {
                }
                column(Trans_1__31_; Trans[1] [31])
                {
                }
                column(TransBal_1__32_; TransBal[1] [32])
                {
                }
                column(TransBal_1__33_; TransBal[1] [33])
                {
                }
                column(TransBal_1__34_; TransBal[1] [34])
                {
                }
                column(TransBal_1__35_; TransBal[1] [35])
                {
                }
                column(TransBal_1__36_; TransBal[1] [36])
                {
                }
                column(TransBal_1__37_; TransBal[1] [37])
                {
                }
                column(TransBal_1__38_; TransBal[1] [38])
                {
                }
                column(TransBal_1__39_; TransBal[1] [39])
                {
                }
                column(TransBal_1__40_; TransBal[1] [40])
                {
                }
                column(TransAmt_1__32_; TransAmt[1] [32])
                {
                }
                column(TransAmt_1__33_; TransAmt[1] [33])
                {
                }
                column(TransAmt_1__34_; TransAmt[1] [34])
                {
                }
                column(TransAmt_1__35_; TransAmt[1] [35])
                {
                }
                column(TransAmt_1__36_; TransAmt[1] [36])
                {
                }
                column(TransAmt_1__37_; TransAmt[1] [37])
                {
                }
                column(TransAmt_1__38_; TransAmt[1] [38])
                {
                }
                column(TransAmt_1__39_; TransAmt[1] [39])
                {
                }
                column(TransAmt_1__40_; TransAmt[1] [40])
                {
                }
                column(Trans_1__32_; Trans[1] [32])
                {
                }
                column(Trans_1__34_; Trans[1] [34])
                {
                }
                column(Trans_1__35_; Trans[1] [35])
                {
                }
                column(Trans_1__33_; Trans[1] [33])
                {
                }
                column(Trans_1__36_; Trans[1] [36])
                {
                }
                column(Trans_1__37_; Trans[1] [37])
                {
                }
                column(Trans_1__38_; Trans[1] [38])
                {
                }
                column(Trans_1__39_; Trans[1] [39])
                {
                }
                column(Trans_1__40_; Trans[1] [40])
                {
                }
                column(Trans_1__45_; Trans[1] [45])
                {
                }
                column(TransAmt_1__45_; TransAmt[1] [45])
                {
                }
                column(TransAmt_1__46_; TransAmt[1] [46])
                {
                }
                column(TransAmt_1__47_; TransAmt[1] [47])
                {
                }
                column(TransAmt_1__48_; TransAmt[1] [48])
                {
                }
                column(TransAmt_1__49_; TransAmt[1] [49])
                {
                }
                column(Trans_1__46_; Trans[1] [46])
                {
                }
                column(Trans_1__47_; Trans[1] [47])
                {
                }
                column(Trans_1__48_; Trans[1] [48])
                {
                }
                column(Trans_1__49_; Trans[1] [49])
                {
                }
                column(TransAmt_1__50_; TransAmt[1] [50])
                {
                }
                column(TransAmt_1__51_; TransAmt[1] [51])
                {
                }
                column(Trans_1__50_; Trans[1] [50])
                {
                }
                column(Trans_1__51_; Trans[1] [51])
                {
                }
                column(Trans_1__53_; Trans[1] [53])
                {
                }
                column(TransBal_1__42_; TransBal[1] [42])
                {
                }
                column(TransAmt_1__42_; TransAmt[1] [42])
                {
                }
                column(Trans_1__42_; Trans[1] [42])
                {
                }
                column(TransBal_1__43_; TransBal[1] [43])
                {
                }
                column(TransAmt_1__43_; TransAmt[1] [43])
                {
                }
                column(Trans_1__43_; Trans[1] [43])
                {
                }
                column(TransBal_1__44_; TransBal[1] [44])
                {
                }
                column(TransAmt_1__44_; TransAmt[1] [44])
                {
                }
                column(Trans_1__44_; Trans[1] [44])
                {
                }
                column(Trans_1__41_; Trans[1] [41])
                {
                }
                column(TransAmt_1__41_; TransAmt[1] [41])
                {
                }
                column(TransBal_1__41_; TransBal[1] [41])
                {
                }
                column(TransAmt_1__52_; TransAmt[1] [52])
                {
                }
                column(Trans_1__52_; Trans[1] [52])
                {
                }
                column(TransBal_1__45_; TransBal[1] [45])
                {
                }
                column(TransBal_1__46_; TransBal[1] [46])
                {
                }
                column(TransBal_1__47_; TransBal[1] [47])
                {
                }
                column(TransBal_1__48_; TransBal[1] [48])
                {
                }
                column(TransBal_1__49_; TransBal[1] [49])
                {
                }
                column(EmptyStringCaption; EmptyStringCaptionLbl)
                {
                }
                column(Employee_Caption; Employee_CaptionLbl)
                {
                }
                column(Department_Caption; Department_CaptionLbl)
                {
                }
                column(Period_Caption; Period_CaptionLbl)
                {
                }
                column(PR_Salary_Card_Employee_Code; "Employee Code")
                {
                }
                column(PayslipMessage; PayslipMessage)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ages := 0;
                    strNssfNo := '. ';
                    strNhifNo := '. ';
                    strBank := '. ';
                    strBranch := '. ';
                    strAccountNo := '. ';
                    strPin := '. ';
                    STRGRATUITY := 0;
                    RecordNo := RecordNo + 1;
                    ColumnNo := ColumnNo + 1;

                    //Get the staff details (header)
                    HREmployeePR.Reset;
                    HREmployeePR.SetRange(HREmployeePR."No.", strEmpCode);
                    if HREmployeePR.Find('-') then begin
                        ages := DATE2DMY(TODAY, 3) - DATE2DMY(HREmployeePR."Date Of Birth", 3);
                        strEmpName := '[' + "Employee Code" + '] ' + HREmployeePR."Last Name" + ' ' + HREmployeePR."First Name" + ' ' + HREmployeePR."Middle Name";
                        strPin := HREmployeePR."PIN No.";
                        dtDOE := HREmployeePR."Date Of Join";
                        Status := Format(HREmployeePR.Status);
                        "Served Notice Period" := HREmployeePR."Served Notice Period";
                        dept := HREmployeePR."Department Code";
                        if HREmployeePR."Date Of Leaving" = 0D then
                            dtOfLeaving := Dmy2date(31, 12, 9999)
                        else
                            dtOfLeaving := HREmployeePR."Date Of Leaving";

                        strNssfNo := HREmployeePR."NSSF No.";
                        strNhifNo := HREmployeePR."NHIF No.";
                        strPin := HREmployeePR."PIN No.";
                        //Get the staff banks in the payslip - Dennis ***************************************************
                        strBankno := HREmployeePR."Main Bank";
                        strBranchno := HREmployeePR."Branch Bank";

                        PRBankStructure.Reset;
                        PRBankStructure.SetRange(PRBankStructure."Branch Code", strBankno);
                        PRBankStructure.SetRange(PRBankStructure."Bank Code", strBranchno);
                        if PRBankStructure.Find('-') then begin
                            strAccountNo := HREmployeePR."Bank Account Number";
                            strBank := PRBankStructure."Bank Code";
                            //strBranch:=PRBankStructure."Branch Name";
                        end;

                        //*************************************************************************************************

                    end;


                    /*If the Employee's Pay is suspended, OR  the guy is active DO NOT execute the following code
                    *****************************************************************************************************/
                    if ("Suspend Pay" = false) then begin
                        //CLEAR(PRPayrollProcessing);
                        strEmpCode := "Employee Code";
                        //PRPayrollProcessing.fnProcesspayroll(strEmpCode,dtDOE,"Basic Pay","Pays PAYE","Pays NSSF","Pays NHIF",SelectedPeriod,STATUS,
                        //dtOfLeaving,"Served Notice Period", dept);
                    end;
                    /******************************************************************************************************/

                    //Clear headers
                    Addr[ColumnNo] [1] := '';
                    Addr[ColumnNo] [2] := '';
                    Addr[ColumnNo] [3] := '';
                    Addr[ColumnNo] [4] := '';
                    Addr[ColumnNo] [5] := '';

                    //Clear previous Transaction entries 53
                    for intRow := 1 to 55 do begin
                        Trans[ColumnNo, intRow] := '';
                        TransAmt[ColumnNo, intRow] := '';
                        TransBal[ColumnNo, intRow] := '';
                    end;

                    //Loop through the transactions
                    PeriodTrans.Reset;
                    PeriodTrans.SetRange(PeriodTrans."Employee Code", strEmpCode);
                    PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                    PeriodTrans.SetRange(PeriodTrans."Company Deduction", false);         //dennis to filter our company deductions

                    PeriodTrans.SetCurrentkey(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                    PeriodTrans."Group Order", PeriodTrans."Sub Group Order");


                    Addr[ColumnNo] [1] := Format(strEmpName);
                    Addr[ColumnNo] [2] := dept; //Depart
                    Addr[ColumnNo] [3] := PeriodName; //Period
                    Addr[ColumnNo] [4] := strPin; //Pin


                    Index := 1;
                    strGrpText := '';
                    if PeriodTrans.Find('-') then
                        repeat


                            //Check if the group has changed
                            if strGrpText <> PeriodTrans."Group Text" then begin
                                if PeriodTrans."Group Order" <> 1 then begin
                                    Index := Index + 1;

                                end;

                                Index := Index + 1;
                                strGrpText := PeriodTrans."Group Text";
                                Trans[ColumnNo, Index] := strGrpText;
                                TransAmt[ColumnNo, Index] := '.';
                                TransBal[ColumnNo, Index] := '.';

                                // IF PeriodTrans.Amount>0 THEN
                                // BEGIN
                                Index := Index + 1;
                                Trans[ColumnNo, Index] := PeriodTrans."Transaction Name";
                                Evaluate(TransAmt[ColumnNo, Index], Format(PeriodTrans.Amount));

                                if (PeriodTrans.Balance = 0) then
                                    Evaluate(TransBal[ColumnNo, Index], Format('                           '))
                                else
                                    Evaluate(TransBal[ColumnNo, Index], Format(PeriodTrans.Balance));
                                // END;

                            end else begin
                                //  IF PeriodTrans.Amount>0 THEN
                                //  BEGIN
                                Index := Index + 1;
                                strGrpText := PeriodTrans."Group Text";
                                Trans[ColumnNo, Index] := PeriodTrans."Transaction Name";
                                Evaluate(TransAmt[ColumnNo, Index], Format(PeriodTrans.Amount));
                                if PeriodTrans.Balance = 0 then
                                    Evaluate(TransBal[ColumnNo, Index], Format('                           .'))
                                else
                                    Evaluate(TransBal[ColumnNo, Index], Format(PeriodTrans.Balance + PeriodTrans."Emp Amount"));
                                //  END;
                            end;
                        until PeriodTrans.Next = 0;
                    //******************************************************************************
                    // DW - Display Employer Contributions on the Payslip
                    Index += 1;
                    Trans[ColumnNo, Index] := '......................................';
                    Evaluate(TransAmt[ColumnNo, Index], '......................................');

                    Index += 1;
                    Trans[ColumnNo, Index] := 'EMPLOYER CONTRIBUTIONS:';
                    Evaluate(TransAmt[ColumnNo, Index], '.');

                    PREmployerContr.Reset;
                    PREmployerContr.SetRange(PREmployerContr."Payroll Period", SelectedPeriod);
                    //PREmployerContr.SETRANGE(PREmployerContr."Transaction Code",'NSSF');
                    PREmployerContr.SetRange(PREmployerContr."Employee Code", strEmpCode);
                    if PREmployerContr.Find('-') then begin
                        repeat
                            if PREmployerContr."Transaction Code" = 'NSSF' then begin
                                Index += 1;
                                Trans[ColumnNo, Index] := 'N.S.S.F: ';
                                Evaluate(TransAmt[ColumnNo, Index], Format(PREmployerContr.Amount));
                            end;
                            if PREmployerContr."Transaction Code" = 'D048' then begin
                                Index += 1;
                                Trans[ColumnNo, Index] := 'Employer Pension Contribution: ';
                                Evaluate(TransAmt[ColumnNo, Index], Format(PREmployerContr.Amount));
                            end;
                            if PREmployerContr."Transaction Code" = 'D080' then begin
                                Index += 1;
                                Trans[ColumnNo, Index] := 'Employer Housing Levy Contribution: ';
                                Evaluate(TransAmt[ColumnNo, Index], Format(PREmployerContr.Amount));
                            end;


                        until PREmployerContr.Next = 0;
                    end;

                    //******************************************************************************
                    /*
                    //Fill-in the other staff information
                    //******************************************************************************
                    Index+=1;
                    Trans[ColumnNo,Index]:='......................................';
                    EVALUATE(TransAmt[ColumnNo,Index],'......................................');

                    Index+=1;
                    Trans[ColumnNo,Index]:='STAFF INFORMATION:';
                    EVALUATE(TransAmt[ColumnNo,Index],'.');

                    //N.S.S.F No:
                    Index+=1;
                    Trans[ColumnNo,Index]:='N.S.S.F No:';
                    EVALUATE(TransAmt[ColumnNo,Index],FORMAT(strNssfNo));

                    //N.H.I.F No:
                    Index+=1;
                    Trans[ColumnNo,Index]:='N.H.I.F No:';
                    EVALUATE(TransAmt[ColumnNo,Index],FORMAT(strNhifNo));

                    //Bank:
                    Index+=1;
                    Trans[ColumnNo,Index]:='Bank:';
                    EVALUATE(TransAmt[ColumnNo,Index],FORMAT(strBank));

                    //Branch:
                    Index+=1;
                    Trans[ColumnNo,Index]:='Branch:';
                    EVALUATE(TransAmt[ColumnNo,Index],FORMAT(strBranch));

                    //Account No:
                    Index+=1;
                    Trans[ColumnNo,Index]:='Account No';
                    //EVALUATE(TransAmt[ColumnNo,Index],FORMAT(strAccountNo));


                    //Account No:
                    Index+=1;
                    Trans[ColumnNo,Index]:='PIN No';
                    EVALUATE(TransAmt[ColumnNo,Index],FORMAT(strPin));
                    */


                    /*
                   //Gratuity:
                   PRSalaryCard.RESET;
                   PRSalaryCard.SETRANGE(PRSalaryCard."Employee Code","Employee Code");
                   IF PRSalaryCard.FIND('-') THEN
                   BEGIN
                   Index+=1;
                   Trans[ColumnNo,Index]:='Gratuity:';
                   EVALUATE(TransAmt[ColumnNo,Index],FORMAT(PRSalaryCard."Gratuity Amount"));
                    END;
                    */

                    //Index+=1;
                    HREmailParam.Reset;
                    if HREmailParam.Get(HREmailParam."associate with"::"Send Payslip Email") then begin
                        //Index+=1;
                        //Trans[ColumnNo,Index]
                        PayslipMessage := HREmailParam."Payslip Message";
                        //error(format(Index));
                        // error(format(Index));
                        //EVALUATE(TransAmt[ColumnNo,Index],HREmailParam."payslip message");

                    end;
                    //******************************************************************************


                    //COMPRESSARRAY(Addr[ColumnNo]);
                    //COMPRESSARRAY(Trans[ColumnNo]);
                    //COMPRESSARRAY(TransAmt[ColumnNo]);
                    //COMPRESSARRAY(TransBal[ColumnNo]);

                    if (RecordNo = NoOfRecords) and (ColumnNo < 3) then begin
                        for i := ColumnNo + 1 to NoOfColumns do begin
                            Clear(Addr[i]);
                            Clear(Trans[i]);
                            Clear(TransAmt[i]);
                            Clear(TransBal[i]);
                        end;
                        ColumnNo := 0;

                    end else begin
                        if ColumnNo = NoOfColumns then
                            ColumnNo := 0;
                    end;

                end;

                trigger OnPreDataItem()
                begin
                    NoOfRecords := "PR Salary Card".Count;
                    NoOfColumns := 2;

                    PRPayrollPeriods.reset();
                    PRPayrollPeriods.SetRange("Period Year", PRPayrollPeriods."Period Year");
                    if PRPayrollPeriods.FindSet() then begin
                        intyear := PRPayrollPeriods."Period Year";
                    end;

                    /*
                    PeriodTrans.RESET;
                    PeriodTrans.SETRANGE(PeriodTrans."Employee Code","prSalary Card"."Employee Code");
                    PeriodTrans.SETRANGE(PeriodTrans."Payroll Period",SelectedPeriod);
                    PeriodTrans.SETRANGE(PeriodTrans."Transaction Code",'NPAY');
                    IF PeriodTrans.FIND('-') =FALSE THEN
                     CurrReport.SKIP;
                     */


                    strNssfNo := '.';
                    strNhifNo := '.';
                    strBank := '.';
                    strBranch := '.';
                    strAccountNo := '.';

                end;
            }

            trigger OnAfterGetRecord()
            begin
                Department := '';
                DimensionValue.Reset;
                DimensionValue.SetRange(DimensionValue."Global Dimension No.", 1);
                DimensionValue.SetRange(DimensionValue.Code, "Global Dimension 1 Code");
                if DimensionValue.Find('-') then begin
                    CountyName := UpperCase(DimensionValue.Name);
                end;
                EmployeeTransfer.reset();
                EmployeeTransfer.setrange("Employee Code", "HR EMPLOYEES"."No.");
                EmployeeTransfer.setrange(Month, Date2DMY(selectedPeriod, 2));
                if EmployeeTransfer.FindLast() then
                    if EmployeeTransfer.month = Date2DMY(selectedPeriod, 2) then
                        Department := "HR EMPLOYEES"."Responsibility Center" else
                        Department := EmployeeTransfer.Department

            end;

            trigger OnPreDataItem()
            begin
                // if strEmpCode = '' THEN Error('You must Input your employee code');
                // If UserSetup.get(UserId) then begin
                //     "HR EMPLOYEES".setrange("No.",UserSetup."Employee No.");
                //     "HR EMPLOYEES".setrange("User ID",UserSetup."User ID");
                // "HR EMPLOYEES".setfilter("User ID", UserId)

            end;
        }
    }

    trigger OnPreReport()
    begin
        PeriodFilter := "PR Salary Card".GetFilter("Period Filter");
        if PeriodFilter = '' then Error('You must specify the period filter');

        SelectedPeriod := "PR Salary Card".GetRangeMin("Period Filter");
        PRPayrollPeriods.Reset;
        if PRPayrollPeriods.Get(SelectedPeriod) then PeriodName := PRPayrollPeriods."Period Name";

        strEmpCode := "PR Salary Card"."Employee Code";
        "HR EMPLOYEES".setfilter("No.", "PR Salary Card"."Employee Code");


        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(CompanyInfo.Picture);
        CompanyInfo.CalcFields(CompanyInfo."Company Watermark2");
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;


    var
        HREmailParam: Record "HR E-Mail Parameters";
        Addr: array[2, 10] of Text[250];
        NoOfRecords: Integer;
        RecordNo: Integer;
        NoOfColumns: Integer;
        ColumnNo: Integer;
        intInfo: Integer;
        i: Integer;
        PeriodTrans: Record "PR Period Transactions";
        intRow: Integer;
        Index: Integer;
        HREmployeePR: Record "HR Employees";
        strEmpName: Text[250];
        strPin: Text[30];
        Trans: array[2, 60] of Text;
        TransAmt: array[2, 60] of Text;
        TransBal: array[2, 60] of Text;
        strGrpText: Text[100];
        strNssfNo: Text[30];
        strNhifNo: Text[30];
        strBank: Text[100];
        strBranch: Text[100];
        strAccountNo: Text[100];
        strMessage: Text[100];
        PeriodName: Text[30];
        PeriodFilter: Text[30];
        SelectedPeriod: Date;
        PRPayrollPeriods: Record "PR Payroll Periods";
        dtDOE: Date;
        strEmpCode: Text[30];
        STATUS: Text[30];
        ControlInfo: Record "Company Information";
        dtOfLeaving: Date;
        "Served Notice Period": Boolean;
        dept: Text[30];
        PRBankStructure: Record "PR Bank Branches";
        emploadva: Record "PR Employee Transactions";
        strBankno: Text[30];
        strBranchno: Text[30];
        CompanyInfo: Record "Company Information";
        PRPayrollProcessing: Codeunit "PR Payroll Processing";
        STRGRATUITY: Decimal;
        Gratuitty: array[2, 10] of Decimal;
        Gratuittities: Decimal;
        PRSalaryCard: Record "prJournal Details";
        EmptyStringCaptionLbl: label '................................................................................................................';
        Employee_CaptionLbl: label 'Employee:';
        Department_CaptionLbl: label 'Department:';
        Period_CaptionLbl: label 'Period:';
        PREmployerContr: Record "prEmployer Deductions";
        PayslipMessage: Text;
        RatePerDay: Decimal;
        NoDaysWorked: Decimal;
        PRPerTrans: Record "PR Period Transactions";
        Spacer: label ' - ';
        CountyName: Text;
        DimensionValue: record "Dimension Value";
        intyear: integer;
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        StaffNo: code[100];
        UserSetup: record "User Setup";
        EmployeeTransfer: record "Employee Transfer";
        Department: code[40];
        ages: integer;
}
