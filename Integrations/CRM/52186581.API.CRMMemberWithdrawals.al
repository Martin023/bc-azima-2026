page 52186581 "CRM Member Withdrawals API"
{
    APIGroup = 'crm';
    APIPublisher = 'sky';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'CRM Member Withdrawals API';
    DelayedInsert = true;
    EntityName = 'memberWithdrawal';
    EntitySetName = 'memberWithdrawals';
    PageType = API;
    SourceTable = "Member withdrawal Notice";

    EntityCaption = 'Member Withdrawal';
    EntitySetCaption = 'Member Withdrawals';

    ODataKeyFields = SystemId;

    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(memberNo; Rec."Member No.")
                {
                    Caption = 'Member No.';
                }
                field(reasonForWithdrawal; Rec."Reason for withdrawal")
                {
                    Caption = 'Reason for withdrawal';
                }
                field(withdrawalNoticeDate; Rec."Withdrawal Notice Date")
                {
                    Caption = 'Withdrawal Notice Date';
                }
                field(maturityDate; Rec."Maturity Date")
                {
                    Caption = 'Maturity Date';
                }
                field(enteredBy; Rec."Entered By")
                {
                    Caption = 'Entered By';
                }
                field(dateEntered; Rec."Date Entered")
                {
                    Caption = 'Date Entered';
                }
                field(timeEntered; Rec."Time Entered")
                {
                    Caption = 'Time Entered';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(noticeType; Rec."Notice Type")
                {
                    Caption = 'Notice Type';
                }
                field(remarks; Rec.Remarks)
                {
                    Caption = 'Remarks';
                }
                field(rejectionRemarks; Rec."Rejection Remarks")
                {
                    Caption = 'Rejection Remarks';
                }
                field(crmApplicationNo; Rec."CRM Application No.")
                {
                    Caption = 'CRM Application No.';
                }
                field(crmCreatedBy; Rec."CRM Created By")
                {
                    Caption = 'CRM Created By';
                }
                field(crmOriginatingBranch; Rec."CRM Originating Branch")
                {
                    Caption = 'CRM Originating Branch';
                }
                field(crmNotes; Rec."CRM Notes")
                {
                    Caption = 'CRM Notes';
                }
                field(noticeFinalized; Rec."Notice Finalized")
                {
                    Caption = 'Notice Finalized';
                }
                field(approvalDate; Rec."DateTime Finalized")
                {
                    Caption = 'Approval Date';
                }
                field(approvedBy; Rec."Finalized By")
                {
                    Caption = 'Approved By';
                }
                field(sentBackToCRM; Rec."Sent Back to CRM")
                {
                    Caption = 'Sent Back to CRM';
                }
                field(percentage; Rec.Percentage)
                {
                    Caption = 'Percentage';
                }
                field(employerLiability; Rec."Employer Liability")
                {
                    Caption = 'Employer Liability';
                }
                field(idNo; Rec."ID No.")
                {
                    Caption = 'ID No.';
                }
                field(membershipStatus; Rec."Member Status")
                {
                    Caption = 'Member Status';
                }
                field(totalAssets; Rec."Total Assets")
                {
                    Caption = 'Total Assets';
                }
                field(netLiabilities; Rec."Employer Liability" + Rec."Loans Outstanding Balance" + Rec."Loans Outstanding Interest")
                {
                    Caption = 'Net Liabilities';
                }
                field(netOutflows; Rec."Total Assets" - (Rec."Employer Liability" + Rec."Loans Outstanding Balance" + Rec."Loans Outstanding Interest"))
                {
                    Caption = 'Net Outflows';
                }
                field(statusComment; 'The application status is: ' + Format(Rec.Status))
                {
                    Caption = 'Status Comment';
                }
                field(delegateZone; Rec."Delegate Zone")
                {
                    Caption = 'Delegate Zone';
                }
                field(employer; Rec.Employer)
                {
                    Caption = 'Employer';
                }
                // field(noneAllocated; Rec."Entered By" = '')
                // {
                //     Caption = 'None allocated';
                // }
                field(noneAllocated; '' + Rec."Finalized By")
                {
                    Caption = 'None allocated';
                }


                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
            }
        }
    }
}
