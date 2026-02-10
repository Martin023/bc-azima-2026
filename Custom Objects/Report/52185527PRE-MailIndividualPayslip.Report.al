#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185527 "PR E-Mail Individual Payslip"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("PR Salary Card"; "PR Salary Card")
        {
            RequestFilterFields = "Period Filter", "Employee Code";
            RequestFilterHeading = 'REQUIRED Fields';


            trigger OnAfterGetRecord()
            begin
                //Check if employee is Active
                HREmp2.Reset;
                if HREmp2.Get("Employee Code") then begin
                    //if HREmp2.Status = HREmp2.Status::Active then begin
                    //Send E-Mail
                    fnSendEmail;
                    //end;
                end;
            end;

            trigger OnPostDataItem()
            begin

                Message('Email Generation Complete %1 Email Generated', Counter);
                //MyDialog.CLOSE();
            end;

            trigger OnPreDataItem()
            begin
                OnViewCurrRec();
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

        //GET PAYROLL PERIOD DETAILS
        fnGetPayrollPeriod;




        Counter := 0;
    end;

    var
        PREmailStatus: Record "PR Email Status";
        SelectedPeriod: Date;
        PRPayrollPeriod: Record "PR Payroll Periods";
        PeriodName: Text;
        PeriodStartDate: Date;
        PRSalaryCard: Record "PR Salary Card";
        EmployeeNo: Code[10];
        HREmp: Record "HR Employees";
        HREmailParam: Record "HR E-Mail Parameters";
        FileExists: Boolean;
        FileErased: Boolean;
        ElapsedTime: Integer;
        currTime1: Time;
        currTime2: Time;
        DelayTime: Integer;
        // SMTP: Codeunit ;
        Counter: Integer;
        FileStillExists: Boolean;
        FileRename: Boolean;
        MyDialog: Dialog;
        MyNext: Integer;
        Text000: label '@1@@@@@@@@@@';
        HREmp2: Record "HR Employees";


    procedure fnGetPayrollPeriod()
    begin
        SelectedPeriod := "PR Salary Card".GetRangeMin("Period Filter");

        if SelectedPeriod = 0D then Error('Please select a Payroll Period');

        PRPayrollPeriod.SetRange(PRPayrollPeriod."Date Opened", SelectedPeriod);
        if PRPayrollPeriod.Find('-') then begin
            PeriodName := PRPayrollPeriod."Period Name";
            PeriodStartDate := PRPayrollPeriod."Date Opened";
        end else begin
            Error('No Payroll Period exists within the applied filters %1', SelectedPeriod);
        end;
    end;


    procedure fnSendEmail()
    begin
        "PR Salary Card".SetRange("Period Filter", PeriodStartDate);

        //DELETE EMAIL STATUS FOR CURRENT PAYROLL PERIOD FOR RE PROCESSING
        PREmailStatus.Reset;
        PREmailStatus.SetRange(PREmailStatus."Payroll Period", SelectedPeriod);
        PREmailStatus.SetRange(PREmailStatus."Employee No", "PR Salary Card"."Employee Code");
        if PREmailStatus.Find('-') then begin
            PREmailStatus.DeleteAll;
        end;

        PRSalaryCard.Reset;
        PRSalaryCard.SetRange(PRSalaryCard."Employee Code", "PR Salary Card"."Employee Code");
        PRSalaryCard.SetRange(PRSalaryCard."Period Filter", PeriodStartDate);
        if PRSalaryCard.Find('-') then begin
            EmployeeNo := PRSalaryCard."Employee Code";

            //GET EMPLOYEE EMAIL ADDRESS
            HREmp.SetRange(HREmp."No.", "PR Salary Card"."Employee Code");
            if HREmp.Find('-') then begin
                //GIVE ERROR IF EMAIL ADDRESS IS BLANK
                HREmp.TestField(HREmp."Company E-Mail");

                //Get Details from HRSetup
                if HREmailParam.Get(HREmailParam."associate with"::"Send Payslip Email") then begin
                    //Ensure Parameters are setup
                    HREmailParam.TestField(HREmailParam."Sender Name");
                    HREmailParam.TestField(HREmailParam."Sender Address");
                    HREmailParam.TestField(HREmailParam.Subject);
                    HREmailParam.TestField(HREmailParam.Body);
                    HREmailParam.TestField(HREmailParam."Template Path");
                    HREmailParam.TestField(HREmailParam."Payslip Message");



                    FileExists := false;
                    FileErased := false;

                    // //CHECK IF FILE EXIST IN THE SPECIFIED TEMPLATE
                    // FileExists := FILE.Exists(HREmailParam."Template Path" + 'Payslip.pdf');

                    // //DELETE FILE IF FILEEXIST = TRUE
                    // if FileExists then begin
                    //     Erase(HREmailParam."Template Path" + 'Payslip.pdf');
                    //     //SLEEP(3000); //Pause for 3 Seconds to delete the file
                    // end;


                    // //If the file exists make sure it has been deleted
                    // if FileExists = true then begin
                    //     FileStillExists := FILE.Exists(HREmailParam."Template Path" + 'Payslip.pdf');
                    //     if FileStillExists = true then begin
                    //         Error('Error occured while Deleting the file, Please make sure it is not OPEN or in USE');
                    //     end;
                    // end;



                    // //RUN PAYSLIP REPORT FOR CURRENT EMPLOYEE, WITH NO REQUEST PAGE
                    // Report.SaveAsPdf(Report::"PR Individual Payslip", HREmailParam."Template Path" + 'Payslip.pdf', PRSalaryCard);

                    // Sleep(10000);


                    // //CREATE EMAIL

                    // SMTP.CreateMessage(HREmailParam."Sender Name", HREmailParam."Sender Address",
                    //                   HREmp."Company E-Mail", HREmailParam.Subject + ' - ' + PeriodName,
                    //                    HREmailParam.Body + ' for ' + PeriodName, false);

                    // //ADD ATTACHMENT
                    // SMTP.AddAttachment(HREmailParam."Template Path" + 'Payslip.pdf', 'Payslip.pdf');




                    // //SEND EMAIL
                    // SMTP.Send();

                    //UPDATE EMAIL STATUS TABLE
                    PREmailStatus.Reset;

                    PREmailStatus.Init;

                    PREmailStatus."Employee No" := HREmp."No.";
                    PREmailStatus."Payroll Period" := SelectedPeriod;
                    PREmailStatus."Date Sent" := Today;
                    PREmailStatus.Status := 'Sent to ' + HREmp."Company E-Mail" + ' at ' + Format(CurrentDatetime) + ' Sent by ' + UserId;

                    PREmailStatus.Insert;
                    Counter += 1;
                end else begin
                    Error('Please setup HR Email Parameters for Sending Payslip Email');
                end;
            end;

        end;
    end;


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
