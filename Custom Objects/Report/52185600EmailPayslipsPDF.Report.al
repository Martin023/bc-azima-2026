#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185600 "Email Payslips PDF"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
        {
            DataItemTableView = where(Status = const(New));
            RequestFilterFields = "No.", "Current Month Filter", "E-Mail", "Location/Division Code";
            column(ReportForNavId_1000000001; 1000000001)
            {
            }
            column(No; "HR Employees"."No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //cyrus
                /*
                {
                "HR-Employee".RESET;
                IF "HR-Employee"."E-Mail"='' THEN
                ERROR('Email address has to be specified in Employee %1',"HR-Employee"."No.");
                 }
                
                SMTPSetup.GET;
                
                IF "Selected Period"=0D THEN ERROR(' Kindly select a period to continue ');
                
                objPayrollPeriod.RESET;
                objPayrollPeriod.SETRANGE(objPayrollPeriod."Chosen To Send",TRUE);
                IF objPayrollPeriod.FIND('-') THEN
                BEGIN
                 objPayrollPeriod."Chosen To Send":=FALSE;
                 objPayrollPeriod.MODIFY;
                END;
                
                objPayrollPeriod.RESET;
                objPayrollPeriod.SETRANGE(objPayrollPeriod."Date Opened","Selected Period");
                IF objPayrollPeriod.FIND('-') THEN BEGIN
                 objPayrollPeriod."Chosen To Send":= TRUE;
                 objPayrollPeriod.MODIFY;
                END;
                
                
                HR.RESET;
                HR.SETRANGE(HR."No.","HR-Employee"."No.");
                HR.SETRANGE(HR."Current Month Filter","Selected Period");
                IF HR.FIND('-') THEN BEGIN
                REPEAT
                
                IF EXISTS(Filename) THEN
                ERASE(Filename);
                
                prPostingGroup.GET("HR-Employee"."Posting Group");
                PayslipReportToPrint :=prPostingGroup."Payslip Report";
                IF PayslipReportToPrint = 0 THEN
                  PayslipReportToPrint := 39005585;
                
                Filename:= SMTPSetup."Path to Save Report"+'Payslip.pdf';
                REPORT.SAVEASPDF(PayslipReportToPrint,Filename,HR);
                SMTPMail.CreateMessage(SMTPSetup."Email Sender Name",SMTPSetup."Email Sender Address",{'awaweru@coretec.co.ke'}"HR-Employee"."E-Mail",'Payslip','',TRUE);
                SMTPMail.AppendBody('*******************************');
                SMTPMail.AppendBody('<br><br>');
                //SMTPMail.AppendBody('Dear '+ HR."First Name" +' '+ HR."Middle Name"+' ,');
                SMTPMail.AppendBody('Hello, ');
                SMTPMail.AppendBody('<br><br>');
                SMTPMail.AppendBody('Please find attached your payslip for '+ FORMAT("Selected Period"));// for the month of January 2014');
                SMTPMail.AppendBody('<br><br>');
                SMTPMail.AppendBody('Thanks & Regards');
                SMTPMail.AppendBody('<br><br>');
                SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
                SMTPMail.AppendBody('<br><br>');
                SMTPMail.AppendBody('<HR>');
                //SMTPMail.AppendBody('blaaaaaaaaaaaaaaaaaaaaaaaaaaPlease find attached your payslip');
                //SMTPMail.AppendBody('<br><br>');
                SMTPMail.AppendBody('This is a system generated mail.');
                SMTPMail.AppendBody('<br><br>');
                SMTPMail.AppendBody('All Enquires regarding wages should be sent to '+ SMTPSetup."Email Sender Address");
                SMTPMail.AppendBody('<br><br>');
                
                SMTPMail.AddAttachment(Filename);
                SMTPMail.Send;
                
                IF EXISTS(Filename) THEN
                ERASE(Filename);
                
                //MESSAGE('Passed through');
                
                UNTIL HR.NEXT=0
                END;
                */

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
                field("Selected Period"; "Selected Period")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll Period';
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

    var
        Filename: Text[50];
        //SMTPSetup: Record "SMTP Mail Setup";
        // SMTPMail: Codeunit 400;
        HR: Record "HR Employees";
        "Selected Period": Date;
        objPayrollPeriod: Record "PR Payroll Periods";
        PayslipReportToPrint: Integer;
        prPostingGroup: Record "prEmployee Posting Group";
}
