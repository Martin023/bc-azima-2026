#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185587 "prStaff Pension Contribution"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/prStaff Pension Contribution.rdl';

    dataset
    {
        dataitem("PR Salary Card"; "PR Salary Card")
        {
            RequestFilterFields = "Period Filter", "Job Title", "Identification Number", "Mobile Number", Nationality, "Date of Birth", "Scheme Code 2";
            column(ReportForNavId_6207; 6207)
            {
            }
            column(GETFILTERS; "PR Salary Card".GetFilters)
            {
            }
            column(USERID; UserId)
            {
            }
            //column(CurrReport_PAGENO; CurrReport.PageNo)
            //{
            //}
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Companyinfo_Picture; Companyinfo.Picture)
            {
            }
            column(prSalary_Card__prSalary_Card___Employee_Code_; "PR Salary Card"."Employee Code")
            {
            }
            column(SelfContrib; SelfContrib)
            {
            }
            column(CompanyContrib; CompanyContrib)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(CummContrib; CummContrib)
            {
            }
            column(PINNo; PINNo)
            {
            }
            column(PensionH; PensionH)
            {
            }
            column(RCount; RCount)
            {
            }
            column(TotCompanyContrib; TotCompanyContrib)
            {
            }
            column(TotSelfContrib; TotSelfContrib)
            {
            }
            column(TotCummContrib; TotCummContrib)
            {
            }
            column(Self_ContributionCaption; Self_ContributionCaptionLbl)
            {
            }
            column(Company_Contrib_Caption; Company_Contrib_CaptionLbl)
            {
            }
            column(Cumm_ContributionCaption; Cumm_ContributionCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee_Earnings_SummaryCaption; Employee_Earnings_SummaryCaptionLbl)
            {
            }
            column(NamesCaption; NamesCaptionLbl)
            {
            }
            column(Employee_CodeCaption; Employee_CodeCaptionLbl)
            {
            }
            column(Pension_No_Caption; Pension_No_CaptionLbl)
            {
            }
            column(Pension_HouseCaption; Pension_HouseCaptionLbl)
            {
            }
            column(Prepared_by_Caption; Prepared_by_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(Authorised_by_Caption; Authorised_by_CaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755030; EmptyStringCaption_Control1102755030Lbl)
            {
            }
            column(NameCaption_Control1102755031; NameCaption_Control1102755031Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755032; EmptyStringCaption_Control1102755032Lbl)
            {
            }
            column(Approved_by_Caption; Approved_by_CaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755034; EmptyStringCaption_Control1102755034Lbl)
            {
            }
            column(Signature___DateCaption; Signature___DateCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755037; EmptyStringCaption_Control1102755037Lbl)
            {
            }
            column(Signature___DateCaption_Control1102755039; Signature___DateCaption_Control1102755039Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755041; EmptyStringCaption_Control1102755041Lbl)
            {
            }
            column(NameCaption_Control1102755042; NameCaption_Control1102755042Lbl)
            {
            }
            column(Signature___DateCaption_Control1102755043; Signature___DateCaption_Control1102755043Lbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                PINNo := '';
                EmployeeName := '';

                objEmp.Reset;
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then begin
                    EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";
                    PINNo := objEmp."PIN No.";
                    PensionH := objEmp."Pension House";
                    if PensionHouse <> '' then begin
                        if PensionHouse <> objEmp."Pension House" then
                            CurrReport.Skip;
                    end;
                end;

                //**changes added to enhance exclusion of employees without pin
                if ExcludeEmpWithoutPin = true then
                    if PINNo = '' then
                        CurrReport.Skip;


                SelfContrib := 0;
                CompanyContrib := 0;
                SelfContribARREARS := 0;
                CompanyContribARREARS := 0;

                //Get the Basic pay
                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange(PeriodTrans."Group Order", 1);
                PeriodTrans.SetRange(PeriodTrans."Sub Group Order", 1);
                if PeriodTrans.Find('-') then begin
                    BasicPay := PeriodTrans.Amount;
                end;


                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                //PeriodTrans.SETRANGE(PeriodTrans."Transaction Name",'PENSION');
                PeriodTrans.SetRange(PeriodTrans."Company Deduction", false);  //dennis
                PeriodTrans.SetRange(PeriodTrans."Transaction Code", SelfContribCode);
                if PeriodTrans.Find('-') then begin
                    SelfContrib := PeriodTrans.Amount;
                    CompanyContrib := SelfContrib; //PKK
                end;

                SelfContrib := SelfContrib + SelfContribARREARS;

                //PKK
                /*
                prEmployerContrib.RESET;
                prEmployerContrib.SETRANGE(prEmployerContrib."Employee Code","Employee Code");
                prEmployerContrib.SETRANGE(prEmployerContrib."Payroll Period",SelectedPeriod);
                prEmployerContrib.SETRANGE(prEmployerContrib."Transaction Code",SelfContribCode);
                IF prEmployerContrib.FIND('-') THEN
                BEGIN
                CompanyContrib:=prEmployerContrib.Amount;
                END;
                */



                CompanyContrib := CompanyContrib + CompanyContribARREARS;

                CummContrib := SelfContrib + CompanyContrib;

                if (SelfContrib <= 0) and (CompanyContrib <= 0) then
                    CurrReport.Skip;
                TotBasicPay := TotBasicPay + BasicPay;
                TotSelfContrib := TotSelfContrib + SelfContrib;
                TotCompanyContrib := TotCompanyContrib + CompanyContrib;
                TotCummContrib := TotCummContrib + CummContrib;
                /*
                IF PrintToExcel THEN BEGIN
                IF HeaderCreated = FALSE THEN BEGIN
                MakeExcelDataHeader;
                HeaderCreated := TRUE;
                END;
                END;
                
                IF PrintToExcel THEN
                  MakeExcelDataBody;
                
                */
                RCount := RCount + 1;

            end;

            trigger OnPreDataItem()
            begin
                objTransCode.Reset;
                //objTransCode.SETRANGE(objTransCode.Pension,TRUE);
                if objTransCode.Find('-') then
                    SelfContribCode := objTransCode."Transaction Code";


                PensionHouse := "PR Salary Card".GetFilter("Job Title");

                if Companyinfo.Get() then
                    Companyinfo.CalcFields(Companyinfo.Picture);
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
                field(ExcludeEmpWithoutPin; ExcludeEmpWithoutPin)
                {
                    ApplicationArea = Basic;
                    Caption = 'Exclude Employee Without Pension No.';
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
        PeriodFilter := "PR Salary Card".GetFilter("Period Filter");
        if PeriodFilter = '' then Error('You must specify the period filter');

        SelectedPeriod := "PR Salary Card".GetRangeMin("Period Filter");
        objPeriod.Reset;
        if objPeriod.Get(SelectedPeriod) then PeriodName := objPeriod."Period Name";

        //self contribution...Defined contribution is a Special Transaction 1
        objTransCode.Reset;
        //objTransCode.SETRANGE(objTransCode.Pension,TRUE);
        //objTransCode.SETRANGE(objTransCode."Special Transactions",1); //Defined contribution/pension
        //objTransCode.SETRANGE(objTransCode."Employer Deduction",FALSE);
        //objTransCode.SETRANGE(objTransCode."Transaction Code",'0007'); //HARD CODED TO ENSURE THE self pension is calx - Dennis
        if objTransCode.Find('-') then begin
            SelfContribCode := objTransCode."Transaction Code";
        end;

        //self contribution...Defined contribution is a Special Transaction 1 PENSION ARREARS
        objTransCode.Reset;
        //objTransCode.SETRANGE(objTransCode."Special Transactions",1); //Defined contribution/pension
        //objTransCode.SETRANGE(objTransCode."Employer Deduction",FALSE);
        objTransCode.SetRange(objTransCode."Transaction Code", '114'); //HARD CODED TO ENSURE THE self pension is calx - Dennis
        if objTransCode.Find('-') then begin
            SelfContribCodeArrears := objTransCode."Transaction Code";
        end;


        //Company contribution
        objTransCode.Reset;
        //objTransCode.SETRANGE(objTransCode."Special Transactions",1);
        //objTransCode.SETRANGE(objTransCode."Employer Deduction",TRUE);
        objTransCode.SetRange(objTransCode."Transaction Code", 'Emp-455'); //HARD CODED TO ENSURE THE self pension is calx - Dennis
        if objTransCode.Find('-') then begin
            // CompanyContribCode:=objTransCode."Transaction Code";
        end;
        CompanyContribCode := 'Emp-455';


        //Company contribution ARREARS
        objTransCode.Reset;
        //objTransCode.SETRANGE(objTransCode."Special Transactions",1);
        //objTransCode.SETRANGE(objTransCode."Employer Deduction",TRUE);
        objTransCode.SetRange(objTransCode."Transaction Code", 'Emp-114'); //HARD CODED TO ENSURE THE self pension is calx - Dennis
        if objTransCode.Find('-') then begin
            // CompanyContribCode:=objTransCode."Transaction Code";
        end;
        CompanyContribCodeArrears := 'Emp-114';


        if Companyinfo.Get() then
            Companyinfo.CalcFields(Companyinfo.Picture);
    end;

    var
        PeriodTrans: Record "PR Period Transactions";
        BasicPay: Decimal;
        SelfContrib: Decimal;
        CompanyContrib: Decimal;
        CummContrib: Decimal;
        TotBasicPay: Decimal;
        TotSelfContrib: Decimal;
        TotCompanyContrib: Decimal;
        TotCummContrib: Decimal;
        EmployeeName: Text[200];
        objEmp: Record "HR Employees";
        objPeriod: Record "PR Payroll Periods";
        SelectedPeriod: Date;
        PeriodFilter: Text[30];
        PeriodName: Text[30];
        SelfContribCode: Text[30];
        CompanyContribCode: Text[30];
        objTransCode: Record "PR Transaction Codes";
        SelfContribCodeArrears: Text[30];
        CompanyContribCodeArrears: Text[30];
        SelfContribARREARS: Decimal;
        CompanyContribARREARS: Decimal;
        prEmployerContrib: Record "prEmployer Deductions";
        Companyinfo: Record "Company Information";
        PINNo: Code[50];
        PensionHouse: Code[100];
        PensionH: Code[20];
        RCount: Integer;
        PrintToExcel: Boolean;
        HeaderCreated: Boolean;
        GrandTotal: Decimal;
        Self_ContributionCaptionLbl: label 'Self Contribution';
        Company_Contrib_CaptionLbl: label 'Company Contrib.';
        Cumm_ContributionCaptionLbl: label 'Cumm Contribution';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Employee_Earnings_SummaryCaptionLbl: label 'Employee Earnings Summary';
        NamesCaptionLbl: label 'Names';
        Employee_CodeCaptionLbl: label 'Employee Code';
        Pension_No_CaptionLbl: label 'Pension No.';
        Pension_HouseCaptionLbl: label 'Pension House';
        Prepared_by_CaptionLbl: label 'Prepared by:';
        NameCaptionLbl: label 'Name';
        EmptyStringCaptionLbl: label '......................................................................................................................................................';
        Authorised_by_CaptionLbl: label 'Authorised by:';
        EmptyStringCaption_Control1102755030Lbl: label '......................................................................................................................................................';
        NameCaption_Control1102755031Lbl: label 'Name';
        EmptyStringCaption_Control1102755032Lbl: label '......................................................................................................................................................';
        Approved_by_CaptionLbl: label 'Approved by:';
        EmptyStringCaption_Control1102755034Lbl: label '......................................................................................................................................................';
        Signature___DateCaptionLbl: label 'Signature & Date';
        EmptyStringCaption_Control1102755037Lbl: label '......................................................................................................................................................';
        Signature___DateCaption_Control1102755039Lbl: label 'Signature & Date';
        EmptyStringCaption_Control1102755041Lbl: label '......................................................................................................................................................';
        NameCaption_Control1102755042Lbl: label 'Name';
        Signature___DateCaption_Control1102755043Lbl: label 'Signature & Date';
        PensionNo: Code[10];
        ExcludeEmpWithoutPin: Boolean;
}
