#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185523 "PR NHIF"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/PR NHIF.rdl';

    dataset
    {
        dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_8631; 8631)
            {
            }
            column(USERID; UserId)
            {
            }
            column(TODAY; Today)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            //column(CurrReport_PAGENO; CurrReport.PageNo)
            //{
            //}


            column(NHIFNo; NHIFNo)
            {
            }
            column(Address; Address)
            {
            }
            column(PeriodName_Control1102760003; PeriodName)
            {
            }
            column(TelNo; TelNo)
            {
            }
            column(HR_Employee__No__; "No.")
            {
            }
            column(HR_Employee__NHIF_No__; "NHIF No.")
            {
            }
            column(NhifAmount; NhifAmount)
            {
            }
            column(HR_Employee__Last_Name_; "Last Name")
            {
            }
            column(IDs; "HR Employees"."Primary Identification")
            {
            }
            column(EmployeeName; FullName)
            {
            }
            column(TotNhifAmount; TotNhifAmount)
            {
            }
            column(NATIONAL_HOSPITAL_INSURANCE_FUNDCaption; NATIONAL_HOSPITAL_INSURANCE_FUNDCaptionLbl)
            {
            }
            column(User_Name_Caption; User_Name_CaptionLbl)
            {
            }
            column(Print_Date_Caption; Print_Date_CaptionLbl)
            {
            }
            column(Period_Caption; Period_CaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(EMPLOYER_NO_Caption; EMPLOYER_NO_CaptionLbl)
            {
            }
            column(ADDRESS_Caption; ADDRESS_CaptionLbl)
            {
            }
            column(PERIOD_Caption_Control1102755031; PERIOD_Caption_Control1102755031Lbl)
            {
            }
            column(TEL_NO_Caption; TEL_NO_CaptionLbl)
            {
            }
            column(HR_Employee__No__Caption; FieldCaption("No."))
            {
            }
            column(HR_Employee__ID_Number_Caption; FieldCaption("ID Number"))
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(LAST_NAMECaption; LAST_NAMECaptionLbl)
            {
            }
            column(OTHER_NAMESCaption; OTHER_NAMESCaptionLbl)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_KRAPIN; CompanyInformation."KRA PIN")
            {
            }
            COLUMN(NHIF; CompanyInformation.NHIF)
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
            column(HR_Employee__NHIF_No__Caption; FieldCaption("NHIF No."))
            {
            }
            column(prepared; Preparedby)
            {
            }
            column(checked; Checkedby)
            {
            }
            column(authorized; Authorizedby)
            {
            }
            column(approved; Approvedby)
            {
            }
            column(Total_NHIF_Caption; Total_NHIF_CaptionLbl)
            {
            }
            column(Counter; Counter)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CoInfo.Get();
                //NHIFNo:=CoInfo."N.H.I.F No";
                Address := CoInfo.Address;
                TelNo := CoInfo."Phone No.";

                Counter := Counter + 1;
                EmployeeName := "First Name" + ' ' + "Middle Name";

                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "No.");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetFilter(PeriodTrans."Group Order", '=7');
                PeriodTrans.SetFilter(PeriodTrans."Sub Group Order", '=2');
                PeriodTrans.SetCurrentkey(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                PeriodTrans."Group Order", PeriodTrans."Sub Group Order");

                NhifAmount := 0;

                if Status <> Status::Active then
                    CurrReport.Skip;

                if PeriodTrans.Find('-') then begin
                    NhifAmount := PeriodTrans.Amount;
                end;

                if NhifAmount <= 0 then
                    CurrReport.Skip;
                TotNhifAmount := TotNhifAmount + NhifAmount;

                // if PrintToExcel then
            end;


            trigger OnPreDataItem()
            begin

                OnViewCurrRec();
                CompanyInformation.Get;
                CompanyInformation.CalcFields(CompanyInformation.Picture);
                // if PrintToExcel then
            end;



            // dataitem("PR Period Transactions"; "PR Period Transactions")
            // {
            //     RequestFilterFields = "Payroll Period";
            //     column(ReportForNavId_8028; 8028)
            //     {
            //     }
            // }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(SelectedPeriod; SelectedPeriod)
                {
                    ApplicationArea = Basic;
                    Caption = 'SelectedPeriod';
                    TableRelation = "PR Payroll Periods";
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

    trigger OnPostReport()
    begin
        // if PrintToExcel then
    end
;

    trigger OnPreReport()
    begin


        if SelectedPeriod = 0D then Error('You must specify the period filter');
        objPeriod.Reset;
        if objPeriod.Get(SelectedPeriod) then begin
            PeriodName := objPeriod."Period Name";
        end;
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";

        // if PrintToExcel then

    end;


    var
        PeriodTrans: Record "PR Period Transactions";
        NhifAmount: Decimal;
        TotNhifAmount: Decimal;
        EmployeeName: Text[100];
        objPeriod: Record "PR Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        NHIFNo: Text[100];
        NSSFNo: Code[100];
        PINNo: Code[100];
        Address: Text[100];
        TelNo: Text[100];
        ExcelBuf: Record "Excel Buffer" temporary;
        GLFilter: Text[250];
        PeriodText: Text[30];
        PrintToExcel: Boolean;
        CurrFormat: Text[30];
        Text000: label 'Period: %1';
        Text001: label 'NHIF';
        Text002: label 'NHIF';
        Text003: label 'Names';
        Text004: label 'Amount';
        Text005: label 'Company Name';
        Text006: label 'Report No.';
        Text007: label 'Report Name';
        Text008: label 'User ID';
        Text009: label 'Date';
        Text010: label 'G/L Filter';
        Text011: label 'Period Filter';
        Text012: label 'ID Number';
        Text013: label 'NHIF No.';
        Text014: label 'Total Amount';
        CoInfo: Record "Company Information";
        CompanyInformation: Record "Company Information";
        NATIONAL_HOSPITAL_INSURANCE_FUNDCaptionLbl: label 'NATIONAL HOSPITAL INSURANCE FUND';
        User_Name_CaptionLbl: label 'User Name:';
        Print_Date_CaptionLbl: label 'Print Date:';
        Period_CaptionLbl: label 'Period:';
        Page_No_CaptionLbl: label 'Page No:';
        EMPLOYER_NO_CaptionLbl: label 'EMPLOYER NHIF NO:';
        ADDRESS_CaptionLbl: label 'ADDRESS:';
        PERIOD_Caption_Control1102755031Lbl: label 'PERIOD:';
        TEL_NO_CaptionLbl: label 'TEL NO:';
        AmountCaptionLbl: label 'Amount';
        LAST_NAMECaptionLbl: label 'LAST NAME';
        OTHER_NAMESCaptionLbl: label 'OTHER NAMES';
        Total_NHIF_CaptionLbl: label 'Total NHIF:';
        Preparedby: label 'Prepared By: ...............................................Date:..............................................';
        Checkedby: label 'Checked By :................................................Date:..............................................';
        Authorizedby: label 'Authorized By:..............................................Date:..............................................';
        Approvedby: label 'Approved By:...............................................Date:..............................................';
        Counter: Integer;
        Scheme: Text[30];
        ContractType: Text[30];
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;


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

