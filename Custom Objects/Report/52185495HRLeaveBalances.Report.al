#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185495 "HR Leave Balances"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/HR Leave Balances.rdl';

    dataset
    {
        dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
        {
            //RequestFilterFields = "No.", Field2038;
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
            // column(CI_Picture; CI.Picture)
            // {
            // }
            // column(CI_City; CI.City)
            // {
            // }
            // column(CI__Address_2______CI__Post_Code_; CI."Address 2" + ' ' + CI."Post Code")
            // {
            // }
            // column(CI_Address; CI.Address)
            // {
            // }
            // column(HR_Employees__No__; "No.")
            // {
            // }
            // column(HR_Employees__FullName; "HR Employees"."First Name" + ' ' + "HR Employees"."Middle Name")
            // {
            // }
            // column(HR_Employees__HR_Employees___Leave_Balance_; "HR Employees"."Leave Balance")
            // {
            // }
            // column(EmployeeCaption; EmployeeCaptionLbl)
            // {
            // }
            // column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            // {
            // }
            // column(Employee_Leave_StatementCaption; Employee_Leave_StatementCaptionLbl)
            // {
            // }
            // column(P_O__BoxCaption; P_O__BoxCaptionLbl)
            // {
            // }
            // column(HR_Employees__No__Caption; UnknownTable"HR EMPLOYEES".FieldCaption("No."))
            // {
            // }
            // column(NameCaption; NameCaptionLbl)
            // {
            // }
            // column(Leave_BalanceCaption; Leave_BalanceCaptionLbl)
            // {
            // }
            // column(Day_s_Caption; Day_s_CaptionLbl)
            // {
            // }
            // column(No; No)
            // {
            // }
            // column(Allocated; Allocated)
            // {
            // }
            // column(Balance; Balance)
            // {
            // }
            // column(Taken; Taken)
            // {
            // }
            // column(Total; Total)
            // {
            // }
            // column(Remb; Remb)
            // {
            // }
            column(Employee_No; "HR Employees"."No.")
            {
            }
            dataitem("HR Leave Ledger Entries"; "HR Leave Ledger Entries")
            {
                DataItemLink = "Staff No." = field("No.");
                DataItemTableView = sorting("Entry No.") where("Leave Calendar Code" = filter(2018));
                column(ReportForNavId_4961; 4961)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    No := No + 1;
                end;

                trigger OnPreDataItem()
                begin
                    //"HR Leave Ledger Entries".SETFILTER("HR Leave Ledger Entries"."Leave Type",
                    //"HR-Employee".GETFILTER("HR-Employee"."Leave Type Filter"));
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //"HR Employees".VALIDATE("HR Employees"."Allocated Leave Days");
                //LeaveBalance:="HR Employees"."Leave Balance";


                Allocated := 0;
                Taken := 0;
                Balance := 0;
                Remb := 0;
                LeaveType := 'ANNUAL';

                if HREmp.Get("HR Employees"."No.") then begin
                    HREmp.SetFilter(HREmp."Leave Type Filter", LeaveType);
                    HREmp.CalcFields(HREmp."Allocated Leave Days");
                    Allocated := HREmp."Allocated Leave Days";
                    //message(format(Allocated));

                    HREmp.Validate(HREmp."Allocated Leave Days");
                    //dEarnd := HREmp."Total (Leave Days)";
                    HREmp.CalcFields(HREmp."Total Leave Taken");
                    Taken := HREmp."Total Leave Taken";
                    Balance := Allocated + Taken;
                    //dLeft :=  HREmp."Leave Balance";
                    Remb := HREmp."Cash - Leave Earned";
                    //cPerDay := HREmp."Cash per Leave Day" ;
                    HREmp.CalcFields(HREmp."Reimbursed Leave Days");
                    Remb := HREmp."Reimbursed Leave Days";
                end;
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
        CI.Get();
        CI.CalcFields(CI.Picture);
    end;

    var
        LeaveType: Code[20];
        CI: Record "Company Information";
        LeaveBalance: Decimal;
        EmployeeCaptionLbl: label 'Employee';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Employee_Leave_StatementCaptionLbl: label 'Employee Leave Statement';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        NameCaptionLbl: label 'Name';
        Leave_BalanceCaptionLbl: label 'Leave Balance';
        Day_s_CaptionLbl: label 'Day(s)';
        No: Decimal;
        Remb: Decimal;
        Allocated: Decimal;
        Total: Decimal;
        Taken: Decimal;
        Balance: Decimal;
        HREmp: Record "HR Employees";
}
