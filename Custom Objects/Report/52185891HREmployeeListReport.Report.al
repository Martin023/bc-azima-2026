#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185891 "HR Employee List Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/HR Employee List Report.rdl';

    dataset
    {
        dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
        {
            DataItemTableView = where(Status = filter(Active));
            RequestFilterFields = "No.";
            column(ReportForNavId_6075; 6075)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            //column(CurrReport_PAGENO; CurrReport.PageNo)
            //{
            //}
            column(USERID; "HR Employees"."User ID")
            {
            }
            column(DateOfJoin_HREmployees; "HR Employees"."Date Of Join")
            {
            }
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_Address2; CI."Address 2")
            {
                IncludeCaption = true;
            }
            column(Num; "No of Employees")
            {
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            column(Ages; Ages)
            {
            }
            column(CI_EMail; CI."E-Mail")
            {
                IncludeCaption = true;
            }
            column(CI_HomePage; CI."Home Page")
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(UserID_HREmployees; "HR Employees"."User ID")
            {
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            column(IDNumber; "HR Employees"."ID Number")
            {
            }
            column(HR_Employees__No__; "No.")
            {
            }
            column(GlobalDimension1Name_HREmployees; "HR Employees"."Global Dimension 1 Name")
            {
            }
            column(GlobalDimension2Name_HREmployees; "HR Employees"."Global Dimension 2 Name")
            {
            }
            column(HR_Employees__Job_Description_; "HR Employees"."Job Title")
            {
            }
            column(HR_Employees__FullName; "HR Employees"."First Name")
            {
            }
            column(HR_Employees__Cell_Phone_Number_; "HR Employees"."Cellular Phone Number")
            {
            }
            column(Company_EMail; "HR Employees"."Company E-Mail")
            {
            }
            column(EmployeeCaption; EmployeeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee_ListCaption; Employee_ListCaptionLbl)
            {
            }
            column(P_O__BoxCaption; P_O__BoxCaptionLbl)
            {
            }
            column(HR_Employees__No__Caption; "HR EMPLOYEES".FieldCaption("No."))
            {
            }
            column(HR_Employees__ID_Number_Caption; "HR EMPLOYEES".FieldCaption("ID Number"))
            {
            }
            column(HR_Employees__Job_Description_Caption; "HR EMPLOYEES".FieldCaption("Job Title"))
            {
            }
            column(Full_NamesCaption; Full_NamesCaptionLbl)
            {
            }
            column(HR_Employees__Cell_Phone_Number_Caption; "HR EMPLOYEES".FieldCaption("Cellular Phone Number"))
            {
            }
            column(NoofEmployees; "No of Employees")
            {
            }
            column(FullNames; FullNames)
            {
            }
            column(ContractType_HREmployees; "HR Employees"."Contract Type")
            {
            }
            column(Region_HREmployees; "HR Employees".Region)
            {
            }
            column(Age_HREmployees; "HR Employees".Age)
            {
            }
            column(Grade_HREmployees; "HR Employees".Grade)
            {
            }
            column(PINNo_HREmployees; "HR Employees"."PIN No.")
            {
            }
            column(MaritalStatus_HREmployees; "HR Employees"."Marital Status")
            {
            }
            column(Gender_HREmployees; "HR Employees".Gender)
            {
            }
            column(IDNumber_HREmployees; "HR Employees"."ID Number")
            {
            }
            column(Salary; Salary)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "No of Employees" := "No of Employees" + 1;

                FullNames := '';
                FullNames := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";

                UserSetup.Reset;
                UserSetup.SetRange(UserSetup."User ID", UserId);
                if UserSetup.Find('-') then begin
                    //   IF UserSetup."Double Login"=FALSE THEN
                    //  ERROR('You have no rights')
                end;
                Ages := DetermineAge("Date Of Birth", Today);
            end;

            // trigger OnPreDataItem()
            // begin
            //     //OnViewCurrRec();
            // end;
        }
        dataitem("HR Employee Kin"; "HR Employee Kin")
        {
            column(ReportForNavId_12; 12)
            {
            }
            column(EmployeeCodeK; "HR Employee Kin"."Employee Code")
            {
            }
            column(RelationshipK; "HR Employee Kin".Relationship)
            {
            }

            column(OtherNamesK; "HR Employee Kin"."Other Names")
            {
            }
            column(IDNoPassportNoK; "HR Employee Kin"."ID No/Passport No")
            {
            }
            column(AddressK; "HR Employee Kin".Address)
            {
            }
            column(HomeTelNoK; "HR Employee Kin"."Home Tel No")
            {
            }
            column(TypeK; "HR Employee Kin".Type)
            {
            }
            column(Namesk; Namesk)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Namesk := '';
                HREmp.Reset;
                HREmp.SetRange("No.", "HR Employee Kin"."Employee Code");
                HREmp.SetRange(Status, HREmp.Status::Active);
                if HREmp.Find('-') then
                    Namesk := HREmp."Full Name"
                else
                    CurrReport.Skip;
            end;
        }
        dataitem("HR Employee Qualifications"; "HR Employee Qualifications")
        {
            column(ReportForNavId_20; 20)
            {
            }
            column(EmployeeNoQ; "HR Employee Qualifications"."Employee No.")
            {
            }
            column(TypeQ; "HR Employee Qualifications".Type)
            {
            }
            column(DescriptionQ; "HR Employee Qualifications".Description)
            {
            }
            column(QualificationTypeQ; "HR Employee Qualifications"."Qualification Type")
            {
            }
            column(QualificationCodeQ; "HR Employee Qualifications"."Qualification Code")
            {
            }
            column(QualificationDescriptionQ; "HR Employee Qualifications"."Qualification Description")
            {
            }
            column(NamesQ; NamesQ)
            {
            }

            trigger OnAfterGetRecord()
            begin
                NamesQ := '';
                HREmp.Reset;
                HREmp.SetRange("No.", "HR Employee Qualifications"."Employee No.");
                HREmp.SetRange(Status, HREmp.Status::Active);
                if HREmp.Find('-') then
                    NamesQ := HREmp."Full Name"
                else
                    CurrReport.Skip;
            end;
        }
        dataitem("HR Professional Bodies Lines"; "HR Professional Bodies Lines")
        {
            column(ReportForNavId_28; 28)
            {
            }
            column(Nop; "HR Professional Bodies Lines"."No.")
            {
            }
            column(QualificationTypep; "HR Professional Bodies Lines"."Qualification Type")
            {
            }
            column(QualificationCodep; "HR Professional Bodies Lines"."Qualification Code")
            {
            }
            column(QualificationDescriptionp; "HR Professional Bodies Lines"."Qualification Description")
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
        CI.Get();
        CI.CalcFields(CI.Picture);
        "No of Employees" := 0;
        Message('Detailed Employee list with Next of kin, Qualifications and Professional Bodies');
    end;

    var
        CI: Record "Company Information";
        EmployeeCaptionLbl: label 'Employee';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Employee_ListCaptionLbl: label 'Employee List';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        Full_NamesCaptionLbl: label 'Full Names';
        "No of Employees": Integer;
        FullNames: Text[150];
        UserSetup: Record "User Setup";
        HRCodeunit: Codeunit "HR Codeunit3";
        Ages: Text;
        Namesk: Text;
        HREmp: Record "HR Employees";
        NamesQ: Text;
        Salary: Decimal;


    procedure OnViewCurrRec()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestricViewTxt: label 'You do not have Permissions to VIEW,MODIFY or DELETE on this record. Contact system administrator for assistance. %';
    begin
        ChangePermission.Reset;
        ChangePermission.SetRange("User ID", UserId);
        ChangePermission.SetRange("View Payroll", true);
        if not ChangePermission.Find('-') then
            Error(ErrorOnRestricViewTxt, UserId);
    end;


    procedure DetermineAge(DateOfBirth: Date; DateOfJoin: Date) AgeString: Text[150]
    var
        dayB: Integer;
        monthB: Integer;
        yearB: Integer;
        dayJ: Integer;
        monthJ: Integer;
        yearJ: Integer;
        Year: Integer;
        Month: Integer;
        Day: Integer;
        monthsToBirth: Integer;
        D: Date;
        DateCat: Integer;
    begin
        if ((DateOfBirth <> 0D) and (DateOfJoin <> 0D)) then begin
            dayB := Date2dmy(DateOfBirth, 1);
            monthB := Date2dmy(DateOfBirth, 2);
            yearB := Date2dmy(DateOfBirth, 3);
            dayJ := Date2dmy(DateOfJoin, 1);
            monthJ := Date2dmy(DateOfJoin, 2);
            yearJ := Date2dmy(DateOfJoin, 3);
            Day := 0;
            Month := 0;
            Year := 0;
            //DateCat := HRCodeunit.DateCategory(dayB, dayJ, monthB, monthJ, yearB, yearJ);
            case (DateCat) of
                1:
                    begin
                        Year := yearJ - yearB;
                        if monthJ >= monthB then
                            Month := monthJ - monthB
                        else begin
                            Month := (monthJ + 12) - monthB;
                            Year := Year - 1;
                        end;

                        if (dayJ >= dayB) then
                            Day := dayJ - dayB
                        else
                            if (dayJ < dayB) then begin
                                //Day := (HRCodeunit.DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                Month := Month - 1;
                            end;

                        AgeString := '%1Y, %2M and #3#D';
                        AgeString := StrSubstNo(AgeString, Year, Month, Day);

                    end;

                2, 3, 7:
                    begin
                        if (monthJ <> monthB) then begin
                            if monthJ >= monthB then
                                Month := monthJ - monthB
                            //  ELSE ERROR('The wrong date category!');
                        end;

                        if (dayJ <> dayB) then begin
                            if (dayJ >= dayB) then
                                Day := dayJ - dayB
                            else
                                if (dayJ < dayB) then begin
                                    //Day := (HRCodeunit.DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                    Month := Month - 1;
                                end;
                        end;

                        AgeString := '%1M %2D';
                        AgeString := StrSubstNo(AgeString, Month, Day);
                    end;
                4:
                    begin
                        Year := yearJ - yearB;
                        AgeString := '#1#Y';
                        AgeString := StrSubstNo(AgeString, Year);
                    end;
                5:
                    begin
                        if (dayJ >= dayB) then
                            Day := dayJ - dayB
                        else
                            if (dayJ < dayB) then begin
                                //Day := (HRCodeunit.DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                monthJ := monthJ - 1;
                                Month := (monthJ + 12) - monthB;
                                yearJ := yearJ - 1;
                            end;

                        Year := yearJ - yearB;
                        AgeString := '%1Y, %2M and #3#D';
                        AgeString := StrSubstNo(AgeString, Year, Month, Day);
                    end;
                6:
                    begin
                        if monthJ >= monthB then
                            Month := monthJ - monthB
                        else begin
                            Month := (monthJ + 12) - monthB;
                            yearJ := yearJ - 1;
                        end;
                        Year := yearJ - yearB;
                        AgeString := '%1Y and #2#M';
                        AgeString := StrSubstNo(AgeString, Year, Month);
                    end;
                else
                    AgeString := '';
            end;
        end else
            Message('For Date Calculation Enter All Applicable Dates!');
        exit;
    end;
}
