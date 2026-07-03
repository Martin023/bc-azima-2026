#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185491 "Leave Balance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Leave Balance.rdl';

    dataset
    {
        dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
        {
            RequestFilterFields = "No.", "Department Code", "Responsibility Center";
            CalcFields = "Allocated Leave Days", "Total Leave Taken";
            column(ReportForNavId_1; 1)
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
            column(USERID; UserId)
            {
            }
            column(TODAY; Today)
            {
            }
            column(No_HREmployees; "HR Employees"."No.")
            {
            }
            column(FullName_HREmployees; "HR Employees"."Full Name")
            {
            }
            column(TotalLeaveDays_HREmployees; "HR Employees"."Total (Leave Days)")
            {
            }
            column(TotalLeaveTaken_HREmployees; "HR Employees"."Total Leave Taken" * -1)
            {
            }
            column(LeaveBal; LeaveBal)
            {
            }
            column(AllocatedLeaveDays; "HR Employees"."Allocated Leave Days")
            {
            }
            column(TotalAllocated; TotalAllocated)
            {

            }
            column(TotalTaken; TotalTaken) { }
            column(TotalReimbursed; TotalReimbursed) { }
            column(PFNo_HREmployees; "HR Employees"."PF No.")
            {
            }
            column(DepartmentCode_HREmployees; "HR Employees"."Department Code")
            {
            }
            column(ResponsibilityCenter_HREmployees; "HR Employees"."Responsibility Center")
            {
            }
            column(DepartmentName; DepartmentName)
            {
            }
            column(DaysUtilized; DaysUtilized)
            {
            }
            column(DaysAvailable; DaysAvailable)
            {
            }
            trigger OnAfterGetRecord()
            begin
                LeaveBal := 0;
                TotalAllocated := 0;
                TotalTaken := 0;
                TotalReimbursed := 0;
                DaysUtilized := 0;
                DaysAvailable := 0;
                DepartmentName := '';

                LeaveLedger.Reset();
                LeaveLedger.SetRange("Staff No.", "No.");
                if LeaveType <> '' then
                    LeaveLedger.setrange("Leave Type", LeaveType);
                if format(LeavetypeEnum) <> ' ' then
                    LeaveLedger.setrange("Leave Type Enum", LeavetypeEnum);
                LeaveLedger.SetRange(Closed, false);
                if LeaveLedger.FindFirst() then begin
                    repeat
                        case LeaveLedger."Leave Entry Type" of
                            LeaveLedger."Leave Entry Type"::Negative:
                                TotalTaken += LeaveLedger."No. of days";
                            LeaveLedger."Leave Entry Type"::Positive:
                                totalAllocated += LeaveLedger."No. of days";
                            LeaveLedger."Leave Entry Type"::Reimbursement:
                                TotalReimbursed += LeaveLedger."No. of days";
                        end;
                    until LeaveLedger.Next() = 0;
                end;
                TotalTaken *= -1;
                LeaveBal := (totalAllocated + TotalReimbursed) - TotalTaken;
                DaysUtilized := TotalTaken;
                DaysAvailable := LeaveBal;

                if ResponsibilityCenterRec.Get("Responsibility Center") then
                    DepartmentName := ResponsibilityCenterRec.Name;
            end;

            trigger OnPreDataItem()
            begin

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
                field(LeaveType; LeaveType)
                {
                    ApplicationArea = Basic;
                    Caption = 'Leave Name.';
                    TableRelation = "HR Leave Types".Code;
                    trigger OnValidate()
                    begin
                        if LeaveType <> '' then
                            LeaveTypeEnum := LeaveTypeEnum::" ";
                    end;
                }
                field(LeaveTypeEnum; LeaveTypeEnum)
                {
                    ApplicationArea = Basic;
                    Caption = 'Leave Type.';
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
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        LeaveBal: Decimal;
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        LeaveLedger: record "HR Leave Ledger Entries";
        LeaveType: code[50];
        TotalTaken: Integer;
        TotalAllocated: Integer;
        TotalReimbursed: Integer;
        LeaveTypeEnum: enum "Leave Type Enum";
        DepartmentName: Text[100];
        DaysUtilized: Decimal;
        DaysAvailable: Decimal;
        ResponsibilityCenterRec: Record "Responsibility CenterBR";
}