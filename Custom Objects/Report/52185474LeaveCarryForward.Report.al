#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185474 "Leave Carry Forward"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Leave Carry Forward.rdl';

    dataset
    {
        dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_7; 7)
            {
            }
            column(No_HREmployees; "HR Employees"."No.")
            {
            }
            column(FullName_HREmployees; "HR Employees"."Full Name")
            {
            }
            column(Days; Days)
            {
            }
            column(DaysTocarryforward; DaysTocarryforward)
            {
            }
            column(Balance; Balance)
            {
            }
            column(Daysgreaterthanzero; Daysgreaterthanzero)
            {
            }

            trigger OnAfterGetRecord()
            begin
                HRLeaveTypes.Reset;
                HRLeaveTypes.SetFilter(HRLeaveTypes.Code, '%1|%2', 'LTY01', 'LTY02');
                HRLeaveTypes.SetRange(HRLeaveTypes."Carry Forward Allowed", true);
                if HRLeaveTypes.Find('-') then begin
                    DaysTocarryforward := HRLeaveTypes."Max Carry Forward Days";
                end;

                LeaveLedger.Reset;
                LeaveLedger.SetRange(LeaveLedger."Staff No.", "HR Employees"."No.");
                "HR Employees".SetRange(Status, Status::Active);
                LeaveLedger.SetFilter(LeaveLedger."Leave Type", '%1|%2', 'LTY01', 'LTY02');
                LeaveLedger.SetRange("Leave Calendar Code", FromPeriod);
                if LeaveLedger.Find('-') then begin
                    Days := 0;
                    repeat
                        Days := LeaveLedger."No. of days" + Days;

                    until LeaveLedger.Next = 0;
                end;

                if Days > DaysTocarryforward then
                    Balance := DaysTocarryforward
                else
                    if Days <= DaysTocarryforward then
                        Balance := Days;


                if Days < 0 then
                    CurrReport.Skip;

                if Days = 0 then
                    CurrReport.Skip;


                LeaveJournalLine.Reset;
                LeaveJournalLine.Init;

                LeaveJournalLine."Journal Template Name" := 'LEAVE';
                LeaveJournalLine."Journal Batch Name" := 'POSITIVE';

                LeaveJournalLine."Line No." := LeaveJournalLine."Line No." + 1000;
                LeaveJournalLine."Leave Calendar Code" := ToPeriod;
                LeaveJournalLine."Leave Period Start Date" := Today;
                LeaveJournalLine."Staff No." := "HR Employees"."No.";
                LeaveJournalLine."Staff Name" := "HR Employees"."Full Name";
                LeaveJournalLine."Posting Date" := Today;
                LeaveJournalLine.Description := Description;
                LeaveJournalLine."Leave Entry Type" := LeaveJournalLine."leave entry type"::Positive;
                LeaveJournalLine."Leave Type" := LeaveLedger."Leave Type";
                LeaveJournalLine."Document No." := DocumentNo;
                LeaveJournalLine."No. of Days" := Balance;

                LeaveJournalLine.Insert;
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
                field(FromPeriod; FromPeriod)
                {
                    ApplicationArea = Basic;
                    Caption = 'From Period';
                }
                field(ToPeriod; ToPeriod)
                {
                    ApplicationArea = Basic;
                    Caption = 'To Period';
                }
                field(DocumentNo; DocumentNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Document No';
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                    Caption = 'Description';
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
        LeaveLedger: Record "HR Leave Ledger Entries";
        Days: Decimal;
        DaysTocarryforward: Decimal;
        Balance: Decimal;
        LeaveJournalLine: Record "HR Leave Journal Line";
        Daysgreaterthanzero: Decimal;
        FromPeriod: Code[10];
        ToPeriod: Code[10];
        Description: Text;
        DocumentNo: Code[20];
        HRLeaveTypes: Record "HR Leave Types";
        LN: Integer;
}
