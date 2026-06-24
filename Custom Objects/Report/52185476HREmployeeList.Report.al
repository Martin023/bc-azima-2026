#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185476 "HR Employee List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/HR Employee List.rdl';

    dataset
    {
        dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
        {
            //DataItemTableView = where(Status = filter(Active));
            RequestFilterFields = "No.", Status;
            column(Grade_HREMPLOYEES; Grade)
            {
            }
            column(Age_HREMPLOYEES; Age)
            {
            }
            column(DateOfJoin_HREMPLOYEES; "Date Of Join")
            {
            }
            column(JobTitle_HREMPLOYEES; "Job Title")
            {
            }
            column(No_HREMPLOYEES; "No.")
            {
            }
            column(Primary_Identification_Type; "Primary Identification Type")
            {

            }
            column(IDNumber_HREMPLOYEES; "Primary Identification")
            {
            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {
            }
            column(Global_Dimension_2_Code; "Global Dimension 2 Code")
            {
            }

            column(FullNames; FullNames)
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
            column(Status; Status)
            {

            }
            column(Date_Of_Birth; "Date Of Birth")
            {
            }
            column(NSSF_No; "NSSF No.")
            {
            }
            column(NHIF_No; "NHIF No.")
            {
            }
            column(Retirement_date; "Retirement date")
            {
            }
            column(Ages; Ages)
            {

            }
            column(Salary_Grade; "Salary Grade")
            {

            }
            column(Years_of_service; "Years of service")
            {

            }

            trigger OnAfterGetRecord()
            begin
                ages := 0;
                "No of Employees" := "No of Employees" + 1;

                FullNames := '';
                FullNames := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";
                ages := DATE2DMY(TODAY, 3) - DATE2DMY("HR EMPLOYEES"."Date Of Birth", 3);


            end;

            trigger OnPreDataItem()
            begin
                // OnViewCurrRec();
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
        CI: Record "Company Information";
        EmployeeCaptionLbl: label 'Employee';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Employee_ListCaptionLbl: label 'Employee List';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        Full_NamesCaptionLbl: label 'Full Names';
        "No of Employees": Integer;
        FullNames: Text[150];
        UserSetup: Record "User Setup";
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Ages: integer;




    // procedure OnViewCurrRec()
    // var
    //     ChangePermission: Record "Status Change Permissions.";
    //     ErrorOnRestricViewTxt: label 'You do not have Permissions to VIEW,MODIFY or DELETE on this record. Contact system administrator for assistance. %';
    // begin
    //     ChangePermission.Reset;
    //     ChangePermission.SetRange("User ID", UserId);
    //     ChangePermission.SetRange("View Payroll", true);
    //     if not ChangePermission.Find('-') then
    //         Error(ErrorOnRestricViewTxt, UserId);
    // end;
}
