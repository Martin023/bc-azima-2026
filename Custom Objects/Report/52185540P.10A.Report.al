#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185540 "P.10 A"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/P.10 A.rdl';

    dataset
    {
        dataitem("PR Salary Card"; "PR Salary Card")
        {
            DataItemTableView = sorting("Employee Code") order(ascending);
            column(ReportForNavId_6207; 6207)
            {
            }
            column(UPPERCASE_COMPANYNAME_; UpperCase(COMPANYNAME))
            {
            }
            column(CompanySetup__Company_P_I_N_; CompanySetup."Company P.I.N")
            {
            }
            column(YR; YR)
            {
            }
            column(Employee_Payroll___First_Name_______Employee_Payroll___Middle_Name_______Employee_Payroll___Last_Name_; "Employee Payroll"."First Name" + ' ' + "Employee Payroll"."Middle Name" + ' ' + "Employee Payroll"."Last Name")
            {
            }
            column(GrossPay; GrossPay)
            {
            }
            column(ABS_MyPAYE_; Abs(MyPAYE))
            {
            }
            column(Employee_Payroll___PIN_No__; "Employee Payroll"."PIN No.")
            {
            }
            column(ABS_MyPAYE__Control1102756065; Abs(MyPAYE))
            {
            }
            column(GrossPay_Control1102756086; GrossPay)
            {
            }
            column(ABS_MyPAYE__Control1102756092; Abs(MyPAYE))
            {
            }
            column(GrossPay_Control1102756113; GrossPay)
            {
            }
            column(PAYE_DEDUCTED_KSHS_Caption; PAYE_DEDUCTED_KSHS_CaptionLbl)
            {
            }
            column(TOTAL_EMOLUMENTS_KSHS_Caption; TOTAL_EMOLUMENTS_KSHS_CaptionLbl)
            {
            }
            column(EMPLOYEE_S_NAMECaption; EMPLOYEE_S_NAMECaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102756009; EmptyStringCaption_Control1102756009Lbl)
            {
            }
            column(EMPLOYER_S_NAMECaption; EMPLOYER_S_NAMECaptionLbl)
            {
            }
            column(EMPLOYER_S_PINCaption; EMPLOYER_S_PINCaptionLbl)
            {
            }
            column(P_A_Y_E_SUPPORTING_LIST_FOR_END_OF_YEAR_CERTIFICATE__YEARCaption; P_A_Y_E_SUPPORTING_LIST_FOR_END_OF_YEAR_CERTIFICATE__YEARCaptionLbl)
            {
            }
            column(EMPLOYEE_S_PINCaption; EMPLOYEE_S_PINCaptionLbl)
            {
            }
            column(P_10ACaption; P_10ACaptionLbl)
            {
            }
            column(APPENDIX_5ACaption; APPENDIX_5ACaptionLbl)
            {
            }
            column(DOMESTIC_TAXES_DEPARTMENTCaption; DOMESTIC_TAXES_DEPARTMENTCaptionLbl)
            {
            }
            column(ATTACH_TWO_COPIES_OF_THIS_LIST_TO_END_OF_YEAR_CERTIFICATE__P10_Caption; ATTACH_TWO_COPIES_OF_THIS_LIST_TO_END_OF_YEAR_CERTIFICATE__P10_CaptionLbl)
            {
            }
            column(DELETE_AS_APPROPRIATECaption; DELETE_AS_APPROPRIATECaptionLbl)
            {
            }
            column(NOTE_TO_EMPLOYER_Caption; NOTE_TO_EMPLOYER_CaptionLbl)
            {
            }
            column(TOTAL_TAX_DEDUCTED__TOTAL_C_F_TO_NEXT_LISTCaption; TOTAL_TAX_DEDUCTED__TOTAL_C_F_TO_NEXT_LISTCaptionLbl)
            {
            }
            column(TAX_ON_LUMP_SUM__AUDIT__INTEREST___PENALTYCaption; TAX_ON_LUMP_SUM__AUDIT__INTEREST___PENALTYCaptionLbl)
            {
            }
            column(TOTAL_WCPSCaption; TOTAL_WCPSCaptionLbl)
            {
            }
            column(TOTAL_PAYE_TAXCaption; TOTAL_PAYE_TAXCaptionLbl)
            {
            }
            column(TOTAL_EMOLUMENTSCaption; TOTAL_EMOLUMENTSCaptionLbl)
            {
            }
            column(ATTACH_TWO_COPIES_OF_THIS_LIST_TO_END_OF_YEAR_CERTIFICATE__P10_Caption_Control1102756087; ATTACH_TWO_COPIES_OF_THIS_LIST_TO_END_OF_YEAR_CERTIFICATE__P10_Caption_Control1102756087Lbl)
            {
            }
            column(DELETE_AS_APPROPRIATECaption_Control1102756088; DELETE_AS_APPROPRIATECaption_Control1102756088Lbl)
            {
            }
            column(TOTAL_TAX_DEDUCTED__TOTAL_C_F_TO_NEXT_LISTCaption_Control1102756091; TOTAL_TAX_DEDUCTED__TOTAL_C_F_TO_NEXT_LISTCaption_Control1102756091Lbl)
            {
            }
            column(NOTE_TO_EMPLOYER_Caption_Control1102756095; NOTE_TO_EMPLOYER_Caption_Control1102756095Lbl)
            {
            }
            column(TAX_ON_LUMP_SUM__AUDIT__INTEREST___PENALTYCaption_Control1102756096; TAX_ON_LUMP_SUM__AUDIT__INTEREST___PENALTYCaption_Control1102756096Lbl)
            {
            }
            column(TOTAL_WCPSCaption_Control1102756103; TOTAL_WCPSCaption_Control1102756103Lbl)
            {
            }
            column(TOTAL_PAYE_TAXCaption_Control1102756107; TOTAL_PAYE_TAXCaption_Control1102756107Lbl)
            {
            }
            column(TOTAL_EMOLUMENTSCaption_Control1102756112; TOTAL_EMOLUMENTSCaption_Control1102756112Lbl)
            {
            }
            column(prSalary_Card_Employee_Code; "Employee Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "Employee Payroll".Get("PR Salary Card"."Employee Code") then begin

                end;

                MyPAYE := 0;
                GrossPay := 0;
                "PR Salary Card".CalcFields("PR Salary Card"."Cumm PAYE");
                "PR Salary Card".CalcFields("PR Salary Card"."Cumm Allowances", "PR Salary Card"."Cumm BasicPay");
                "PR Salary Card".CalcFields("PR Salary Card"."Cumm GrossPay");
                PAYE := Abs("PR Salary Card"."Cumm PAYE");
                TotalCumm := TotalCumm + Abs("PR Salary Card"."Cumm PAYE");
                MyPAYE := "PR Salary Card"."Cumm PAYE";

                if Abs("PR Salary Card"."Cumm PAYE") > 0 then begin
                    GrossPay := "PR Salary Card"."Cumm GrossPay";
                    Index := Index + 1;
                end;
                CurrReport.CreateTotals(MyPAYE, GrossPay);
            end;

            trigger OnPreDataItem()
            begin
                "PR Salary Card".SetRange("PR Salary Card"."Period Filter", StringDate, EndDate);
                YR := Date2dmy(StringDate, 3);
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

    var
        StringDate: Date;
        EndDate: Date;
        PAYE: Decimal;
        TotPAYE: Decimal;
        CompanySetup: Record "Control-Information";
        YR: Integer;
        TotalCumm: Decimal;
        Index: Integer;
        TotPayeTemp: Decimal;
        EmpLedgerentry: Record "PR Period Transactions";
        GrossPay: Decimal;
        EmpCalc: Record "PR Salary Card";
        MyPAYE: Decimal;
        MyPAYETot: Decimal;
        MyPGROSSTot: Decimal;
        "Employee Payroll": Record "HR Employees";
        PAYE_DEDUCTED_KSHS_CaptionLbl: label 'PAYE DEDUCTED KSHS.';
        TOTAL_EMOLUMENTS_KSHS_CaptionLbl: label 'TOTAL EMOLUMENTS KSHS.';
        EMPLOYEE_S_NAMECaptionLbl: label 'EMPLOYEE''S NAME';
        EmptyStringCaptionLbl: label '...........................................................';
        EmptyStringCaption_Control1102756009Lbl: label '...........................................................';
        EMPLOYER_S_NAMECaptionLbl: label 'EMPLOYER''S NAME';
        EMPLOYER_S_PINCaptionLbl: label 'EMPLOYER''S PIN';
        P_A_Y_E_SUPPORTING_LIST_FOR_END_OF_YEAR_CERTIFICATE__YEARCaptionLbl: label 'P.A.Y.E SUPPORTING LIST FOR END OF YEAR CERTIFICATE: YEAR';
        EMPLOYEE_S_PINCaptionLbl: label 'EMPLOYEE''S PIN';
        P_10ACaptionLbl: label 'P.10A';
        APPENDIX_5ACaptionLbl: label 'APPENDIX 5A';
        DOMESTIC_TAXES_DEPARTMENTCaptionLbl: label 'DOMESTIC TAXES DEPARTMENT';
        ATTACH_TWO_COPIES_OF_THIS_LIST_TO_END_OF_YEAR_CERTIFICATE__P10_CaptionLbl: label 'ATTACH TWO COPIES OF THIS LIST TO END OF YEAR CERTIFICATE (P10)';
        DELETE_AS_APPROPRIATECaptionLbl: label '*DELETE AS APPROPRIATE';
        NOTE_TO_EMPLOYER_CaptionLbl: label 'NOTE TO EMPLOYER:';
        TOTAL_TAX_DEDUCTED__TOTAL_C_F_TO_NEXT_LISTCaptionLbl: label '*TOTAL TAX DEDUCTED/ TOTAL C/F TO NEXT LIST';
        TAX_ON_LUMP_SUM__AUDIT__INTEREST___PENALTYCaptionLbl: label '*TAX ON LUMP SUM/ AUDIT/ INTEREST / PENALTY';
        TOTAL_WCPSCaptionLbl: label 'TOTAL WCPS';
        TOTAL_PAYE_TAXCaptionLbl: label 'TOTAL PAYE TAX';
        TOTAL_EMOLUMENTSCaptionLbl: label 'TOTAL EMOLUMENTS';
        ATTACH_TWO_COPIES_OF_THIS_LIST_TO_END_OF_YEAR_CERTIFICATE__P10_Caption_Control1102756087Lbl: label 'ATTACH TWO COPIES OF THIS LIST TO END OF YEAR CERTIFICATE (P10)';
        DELETE_AS_APPROPRIATECaption_Control1102756088Lbl: label '*DELETE AS APPROPRIATE';
        TOTAL_TAX_DEDUCTED__TOTAL_C_F_TO_NEXT_LISTCaption_Control1102756091Lbl: label '*TOTAL TAX DEDUCTED/ TOTAL C/F TO NEXT LIST';
        NOTE_TO_EMPLOYER_Caption_Control1102756095Lbl: label 'NOTE TO EMPLOYER:';
        TAX_ON_LUMP_SUM__AUDIT__INTEREST___PENALTYCaption_Control1102756096Lbl: label '*TAX ON LUMP SUM/ AUDIT/ INTEREST / PENALTY';
        TOTAL_WCPSCaption_Control1102756103Lbl: label 'TOTAL WCPS';
        TOTAL_PAYE_TAXCaption_Control1102756107Lbl: label 'TOTAL PAYE TAX';
        TOTAL_EMOLUMENTSCaption_Control1102756112Lbl: label 'TOTAL EMOLUMENTS';
}
