#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185585 "NHF Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/NHF Schedule.rdl';

    dataset
    {
        dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
        {
            DataItemTableView = sorting("No.") where(Status = const(New));
            RequestFilterFields = "Current Month Filter", "Location/Division Code", "Department Code", "Cost Center Code", "Salary Grade", "Salary Notch/Step";
            column(ReportForNavId_8631; 8631)
            {
            }
            column(GETFILTERS; "HR EMPLOYEES".GetFilters)
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
            column(cHeader_1_; cHeader[1])
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(strEmpName; strEmpName)
            {
            }
            column(HR_Employee__HR_Employee___No__; "HR Employees"."No.")
            {
            }
            column(cValue_1_; cValue[1])
            {
            }
            column(HR_Employee__NHF_No__; "NHIF No.")
            {
            }
            column(cValue_1__Control1102755066; cValue[1])
            {
            }
            column(RCount; RCount)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(Employee_CodeCaption; Employee_CodeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(NHF_ScheduleCaption; NHF_ScheduleCaptionLbl)
            {
            }
            column(HR_Employee__NHF_No__Caption; "HR EMPLOYEES".FieldCaption("NHIF No."))
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
            column(EmptyStringCaption_Control1102755018; EmptyStringCaption_Control1102755018Lbl)
            {
            }
            column(NameCaption_Control1102755020; NameCaption_Control1102755020Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755021; EmptyStringCaption_Control1102755021Lbl)
            {
            }
            column(Approved_by_Caption; Approved_by_CaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755023; EmptyStringCaption_Control1102755023Lbl)
            {
            }
            column(Signature___DateCaption; Signature___DateCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755025; EmptyStringCaption_Control1102755025Lbl)
            {
            }
            column(Signature___DateCaption_Control1102755026; Signature___DateCaption_Control1102755026Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755027; EmptyStringCaption_Control1102755027Lbl)
            {
            }
            column(NameCaption_Control1102755028; NameCaption_Control1102755028Lbl)
            {
            }
            column(Signature___DateCaption_Control1102755029; Signature___DateCaption_Control1102755029Lbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                strEmpName := "Last Name" + ' ' + "First Name" + ' ' + "Middle Name";

                i := 1;
                repeat
                    i := i + 1;
                    cValue[i] := 0;
                until i = 6;

                Trans.Reset;
                Trans.SetFilter(Trans."Transaction Code", 'NHF');
                Trans.SetFilter(Trans."Current Month Filter", "HR Employees".GetFilter("Current Month Filter"));
                Trans.SetFilter(Trans."Employee Code Filter", "HR Employees"."No.");
                if Trans.Find('-') then begin
                    repeat
                        Trans.CalcFields("Curr. Amount");
                        //Basic Pay
                        cHeader[1] := 'NHF';
                        if Trans."Transaction Code" = 'NHF' then begin
                            cValue[1] := Trans."Curr. Amount";
                        end;

                    /*
                    //Housing
                    cHeader[2]:='Gross Pay';
                    IF Trans."Transaction Code" = 'GPAY' THEN BEGIN
                    cValue[2]:=cValue[2]+Trans."Curr. Amount";
                    END;

                    //Transport
                    cHeader[3]:='Net Pay';
                    IF Trans."Transaction Code" = 'NPAY' THEN BEGIN
                    cValue[3]:=cValue[3]+Trans."Curr. Amount";
                    END;
                    */

                    until Trans.Next = 0;

                end;


                if (cValue[1] = 0) then
                    CurrReport.Skip;

                RCount := RCount + 1;

            end;

            trigger OnPreDataItem()
            begin
                if "HR Employees".GetFilter("HR Employees"."Current Month Filter") = '' then
                    Error('You must specify current Period filter.');

                CurrReport.CreateTotals(cValue[1], cValue[2], cValue[3], cValue[4], cValue[5], cValue[6], cValue[7], cValue[8], cValue[9], cValue[10]);
                CurrReport.CreateTotals(cValue[11], cValue[12], cValue[13], cValue[14], cValue[15], cValue[16], cValue[17]);
                CurrReport.CreateTotals(cValue[18], cValue[19], cValue[20]);

                if VitalInfo.Get('') then
                    //NISTFRate:=VitalInfo."NISTF % of Basic Pay";

                    if CompanyInfo.Get() then
                        CompanyInfo.CalcFields(CompanyInfo.Picture);
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
        strEmpName: Text[100];
        cHeader: array[200] of Text[200];
        cValue: array[200] of Decimal;
        Trans: Record "PR Transaction Codes";
        ColNo: Integer;
        i: Integer;
        RCount: Integer;
        VitalInfo: Record "PR Vital Setup Info";
        NISTFRate: Decimal;
        SalaryGrades: Record "Salary Grades";
        CompanyInfo: Record "Company Information";
        Employee_NameCaptionLbl: label 'Employee Name';
        Employee_CodeCaptionLbl: label 'Employee Code';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        NHF_ScheduleCaptionLbl: label 'NHF Schedule';
        Prepared_by_CaptionLbl: label 'Prepared by:';
        NameCaptionLbl: label 'Name';
        EmptyStringCaptionLbl: label '......................................................................................................................................................';
        Authorised_by_CaptionLbl: label 'Authorised by:';
        EmptyStringCaption_Control1102755018Lbl: label '......................................................................................................................................................';
        NameCaption_Control1102755020Lbl: label 'Name';
        EmptyStringCaption_Control1102755021Lbl: label '......................................................................................................................................................';
        Approved_by_CaptionLbl: label 'Approved by:';
        EmptyStringCaption_Control1102755023Lbl: label '......................................................................................................................................................';
        Signature___DateCaptionLbl: label 'Signature & Date';
        EmptyStringCaption_Control1102755025Lbl: label '......................................................................................................................................................';
        Signature___DateCaption_Control1102755026Lbl: label 'Signature & Date';
        EmptyStringCaption_Control1102755027Lbl: label '......................................................................................................................................................';
        NameCaption_Control1102755028Lbl: label 'Name';
        Signature___DateCaption_Control1102755029Lbl: label 'Signature & Date';
}
