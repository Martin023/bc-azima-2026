namespace MNS.MNS;

using Microsoft.Bank.Deposit;
using Microsoft.Finance.GeneralLedger.Journal;
using System.Automation;
using System.Security.User;

pageextension 52185462 "Bank Deposits Card Extension" extends "Bank Deposit"
{
    PromotedActionCategories = 'New,Process,Report,Posting,Bank Deposit,Approvals,Import,Clear Lines';

    layout
    {
        addAfter("Currency Code")
        {
            field("Journal Template Name"; Rec."Journal Template Name")
            {
                ApplicationArea = All;
            }
            field("Journal Batch Name"; Rec."Journal Batch Name")
            {
                ApplicationArea = All;
            }
            field(status; Rec.Status)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter("Change &Batch")
        {
            action(SendApprovalRequest)
            {
                ApplicationArea = All;
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                Enabled = NOT OpenApprovalEntriesExist;

                trigger OnAction()
                var
                    CustomApprovals: Codeunit "Custom Approvals Codeunit";
                begin
                    // if LinesExist() then
                    //     Error('You cannot send an approval request for a bank deposit with lines');

                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = All;
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                Enabled = OpenApprovalEntriesExist;

                trigger OnAction()
                var
                    CustomApprovals: Codeunit "Custom Approvals Codeunit";
                begin
                    VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;

            }
            action(Import)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    xmlport.Run(xmlport::"Bank Deposits Import");
                end;
            }
            action("Clear lines")
            {
                ApplicationArea = All;
                Caption = 'Clear lines';
                //Image = ClearLines;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Open then
                        SaccoTrans.InitJournal(Rec."Journal Template Name", Rec."Journal Batch Name")
                    else
                        Error('You cannot clear lines for a posted/Pending bank deposit');
                end;
            }
        }
        //modify(Post)
        // {
        //     trigger OnBeforeAction()
        //     var
        //         UserSetup: Record "User Setup";
        //         journalBatch: record "Gen. Journal Batch";
        //     begin
        //         //UserSetup.get(UserId);

        //     end;
        // }
    }
    var
        VarVariant: Variant;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        SaccoTrans: Codeunit "Sacco Transactions";



    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;


    procedure SetControlAppearance()
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);

        // if Rec.Status = Rec.Status::Open then begin
        //     SendApprovalVisible := true;
        // end;

        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false;
    end;
}
