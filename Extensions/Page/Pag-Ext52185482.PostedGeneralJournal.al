namespace KenpipeCBS.KenpipeCBS;

using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Finance.GeneralLedger.Ledger;
using System.Automation;

pageextension 52185482 PostedGeneralJournal extends "Posted General Journal"
{
    layout
    {

        addlast(Control1)
        {
            field(Approver; Approver)
            {
                Caption = 'Approved by';
                ApplicationArea = All;
            }
        }

    }
    var
        Approver: code[30];
        PostedApprovals: record "Posted Approval Entry";
        Glregister: record "G/L Register";

    trigger OnAfterGetCurrRecord()
    begin
        Approver := '';
        if Glregister.get(rec."G/L Register No.") then begin
            PostedApprovals.Reset();
            PostedApprovals.SetLoadFields("Table ID", "Posted Record ID", "Approver ID", Status);
            PostedApprovals.SetRange("Table ID", 45);
            PostedApprovals.SetRange("Posted Record ID", Glregister.RecordID);
            PostedApprovals.SetRange(Status, PostedApprovals.Status::Approved);
            if PostedApprovals.FindFirst() then
                Approver := PostedApprovals."Approver ID";
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        Approver := '';
        if Glregister.get(rec."G/L Register No.") then begin
            PostedApprovals.Reset();
            PostedApprovals.SetLoadFields("Table ID", "Posted Record ID", "Approver ID", Status);
            PostedApprovals.SetRange("Table ID", 45);
            PostedApprovals.SetRange("Posted Record ID", Glregister.RecordID);
            PostedApprovals.SetRange(Status, PostedApprovals.Status::Approved);
            if PostedApprovals.FindFirst() then
                Approver := PostedApprovals."Approver ID";
        end;
    end;
}

