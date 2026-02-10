page 52186582 "CRM BBF Applications API"
{
    APIGroup = 'crm';
    APIPublisher = 'sky';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'crmBBFApplicationsAPI';
    DelayedInsert = true;
    EntityName = 'bbfApplication';
    EntitySetName = 'bbfApplications';
    PageType = API;
    SourceTable = "SinkFund Report Information";

    EntityCaption = 'BBF Application';
    EntitySetCaption = 'BBF Applications';

    ODataKeyFields = SystemId;

    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    // ID No.

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(no; Rec.No)
                {
                    Caption = 'No';
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
                field(sentBackToCRM; Rec."Sent Back to CRM")
                {
                    Caption = 'Sent Back to CRM';
                }
                field("date"; Rec."Date")
                {
                    Caption = 'Date';
                }
                field(reportedByName; Rec."Reported By Name")
                {
                    Caption = 'Reported By Name';
                }
                field(reportedByIDNo; Rec."Reported By ID No")
                {
                    Caption = 'Reported By ID No';
                }
                field(reportedByRelationship; Rec."Reported By Relationship")
                {
                    Caption = 'Reported By Relationship';
                }

                field(nok; Rec."Next of KIN")
                {
                    Caption = 'Next of Kin';
                }
                field(nokName; Rec."NOK Name")
                {
                    Caption = 'Next of Kin Name';
                }
                field(nokRelationship; Rec.Relationship)
                {
                    Caption = 'Next of Kin Relationship';
                }

                field(memberNo; Rec."Member No")
                {
                    Caption = 'Member No';
                }
                field(idNo; Rec."Primary Identification")
                {
                    Caption = 'ID No';
                }
                field(memberStatus; Rec."Member Status")
                {
                    Caption = 'Member Status';
                }
                field(dateOfDeath; Rec."Date of Death")
                {
                    Caption = 'Date of Death';
                }
                field(deceasedPerson; Rec."Deceased Person")
                {
                    Caption = 'Deceased Person';
                }
                field(memberName; Rec."Member Name")
                {
                    Caption = 'Member Name';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(capturedBy; Rec."Captured By")
                {
                    Caption = 'Captured By';
                }
                field(posted; Rec.Posted)
                {
                    Caption = 'Posted';
                }
                field(datePosted; Rec."Date Posted")
                {
                    Caption = 'Date Posted';
                }
                field(postedBy; Rec."Posted By")
                {
                    Caption = 'Posted By';
                }
                field(claimType; Rec."Claim Type")
                {
                    Caption = 'Claim Type';
                }
                field(bbfClaimAmout; Rec."BBF Claim Amount")
                {
                    Caption = 'BBF Claim Amout';
                }
                field(totalSavings; Rec."Total Savings")
                {
                    Caption = 'Total Savings';
                }
                field(totalLoans; Rec."Total Loans")
                {
                    Caption = 'Total Loans';
                }
                field(netEffects; Rec."Net Effects")
                {
                    Caption = 'Net Effects';
                }
                field(receiptDocumentNumber; Rec."Receipt Document Number")
                {
                    Caption = 'Insurance Receipt Document Number';
                }
                field(receiptAmount; Rec."Receipt Amount")
                {
                    Caption = 'Insurance Receipt Amount';
                }
                field(totalAmountAllocated; Rec."Total Amount Allocated")
                {
                    Caption = 'Total Amount Allocated to Loans';
                }
                field(availableBeneficiaryAmount; Rec."Available Beneficiary Amount")
                {
                    Caption = 'Available Beneficiary Amount';
                }
                field(burialPermitNumber; Rec."Burial Permit Number")
                {
                    Caption = 'Burial Permit Number';
                }

                field(approvedBy; Rec."Approved By")
                {
                    Caption = 'Approved By';
                }
                field("approvalDate"; Rec."Approval Date")
                {
                    Caption = 'Approval Date';
                }
                field(statusComment; 'The current status is: ' + Format(Rec.Status))
                {
                    Caption = 'Status Comment';
                }
                // field(noneAllocated; Rec."Captured By" = '')
                // {
                //     Caption = 'None allocated';
                // }
                field(noneAllocated; '' + Rec."Approved By")
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
