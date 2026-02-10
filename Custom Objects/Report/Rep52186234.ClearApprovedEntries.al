namespace KenpipeCBS.KenpipeCBS;

using System.Automation;
using System.Security.User;

report 52186234 "Clear Approved Entries"
{
    ApplicationArea = All;
    Caption = 'Clear Approved Entries';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(ApprovalEntry; "Approval Entry")
        {
            DataItemTableView = where(Status = const(Open));
            column(DocumentNo; "Document No.")
            {
            }
            column(EntryNo; "Entry No.")
            {
            }
            column(SenderID; "Sender ID")
            {
            }
            column(DateTimeSentforApproval; "Date-Time Sent for Approval")
            {
            }
            trigger OnAfterGetRecord()
            begin
                if Loans.get("Document No.") then begin
                    if (Loans.Status <> Loans.Status::Pending) or (Loans.Posted) then
                        Approvalmgmt.DeleteApprovalEntries("Record ID to Approve");
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(ApproverID; ApproverID)
                    {
                        Caption = 'Apprpver ID';
                        TableRelation = "User Setup";
                    }

                }
            }
        }
        actions
        {
            area(Processing)
            {

            }
        }
    }

    trigger OnPreReport()
    begin

    end;

    trigger OnPostReport()
    begin
        Message('Approved Entries Cleared');
    end;

    var
        ApproverID: code[100];
        Loans: Record Loans;
        Approvalmgmt: Codeunit "Approvals Mgmt.";
}
