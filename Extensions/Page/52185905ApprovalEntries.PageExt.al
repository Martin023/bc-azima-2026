#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185905 pageextension52185905 extends "Approval Entries"
{

    layout
    {
        modify(Overdue)
        {
            ToolTip = 'Overdue Entry';
            ApplicationArea = Basic;
        }
        modify("Table ID")
        {
            ApplicationArea = Basic;
        }
        modify("Limit Type")
        {
            ApplicationArea = Basic;
        }
        modify("Approval Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify(RecordIDText)
        {
            ApplicationArea = Basic;
        }
        modify(Details)
        {
            ApplicationArea = Basic;
        }
        modify("Sequence No.")
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify("Sender ID")
        {
            ApplicationArea = Basic;
        }
        modify("Salespers./Purch. Code")
        {
            ApplicationArea = Basic;
        }
        modify("Approver ID")
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify("Amount (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Available Credit Limit (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Date-Time Sent for Approval")
        {
            ApplicationArea = Basic;
        }
        modify("Last Date-Time Modified")
        {
            ApplicationArea = Basic;
        }
        modify("Last Modified By User ID")
        {
            ApplicationArea = Basic;
        }
        modify(Comment)
        {
            ApplicationArea = Basic;
        }
        modify("Due Date")
        {
            ApplicationArea = Basic;
        }



    }
    actions
    {
        modify("Record")
        {
            ApplicationArea = Basic;
        }
        modify(Comments)
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("O&verdue Entries")
        {
            ApplicationArea = Basic;
        }
        modify("All Entries")
        {
            ApplicationArea = Basic;
        }
        modify("&Delegate")
        {
            ApplicationArea = Basic;
            Visible = true;
        }
        addafter(Comments)
        {
            action("Clear Approval Entry")
            {
                ApplicationArea = Basic;
                Caption = 'Delete Approval Entry';
                Image = Delete;
                trigger OnAction()
                var
                    ApprovalMgt: Codeunit 1535;
                    Text000: Label 'Are you sure you wish to clear this approval entry?';
                begin
                    if Confirm(Text000, true) then begin
                        ApprovalMgt.DeleteApprovalEntries(Rec."Record ID to Approve");
                        Message('You have successfully cleared this approval entry');
                    end else
                        Message('You have selected not to clear this approval entry');
                end;
            }
        }



    }

    var
        ApprovalCommentLine: Record "Approval Comment Line";

    var
        Usersetup: Record "User Setup";


}
