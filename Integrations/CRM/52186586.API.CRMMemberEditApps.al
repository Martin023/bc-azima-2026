page 52186586 "CRM Member Edit Apps API"
{
    APIGroup = 'crm';
    APIPublisher = 'sky';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'CRM Member Edit Applications API';
    DelayedInsert = true;
    EntityName = 'memberEdit';
    EntitySetName = 'memberEdits';
    PageType = API;
    SourceTable = "CRM Member Edit";

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
                field(memberName; Rec."Member Name")
                {
                    Caption = 'Member Name';
                }
                field(memberStatus; Rec."Member Status")
                {
                    Caption = 'Member Status';
                }
                field(idNo; Rec."ID No")
                {
                    Caption = 'ID No.';
                }
                field(editInformation; Rec."Edit Information")
                {
                    Caption = 'Edit Information';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(statusComment; 'The current status is: ' + Format(Rec.Status))
                {
                    Caption = 'Status comment';
                }
                field(crmNo; Rec."CRM No.")
                {
                    Caption = 'CRM No.';
                }
                field(crmCreatedBy; Rec."CRM Created By")
                {
                    Caption = 'CRM Created By';
                }
                field(crmBranch; Rec."CRM Branch")
                {
                    Caption = 'CRM Branch';
                }
                field(applicationDate; Rec."Application Date")
                {
                    Caption = 'Application Date';
                }
                field(createdBy; Rec."Created By")
                {
                    Caption = 'Created By';
                }
                field(responsibleOfficer; Rec."Responsible Officer")
                {
                    Caption = 'Responsible Officer';
                }
                field(supervisorID; Rec."Supervisor ID")
                {
                    Caption = 'Supervisor ID';
                }
                field(changeComplete; Rec."Change Complete")
                {
                    Caption = 'Change Complete';
                }
                field(typeOfEdit; Rec."Type of Edit")
                {
                    Caption = 'Type of Edit';
                }
                field(sentBackToCRM; Rec."Sent Back to CRM")
                {
                    Caption = 'Sent Back to CRM';
                }

                field(approvedBy; Rec."Approved By")
                {
                    Caption = 'Approved By';
                }
                field(approvalDate; Rec."Approval Date")
                {
                    Caption = 'Approval Date';
                }
                field(employer; Rec.Employer)
                {
                    Caption = 'Employer';
                }
                field(delegateZone; Rec."Delegate Zone")
                {
                    Caption = 'Delegate Zone';
                }
                // field(noneAllocated; false)
                // {
                //     Caption = 'None allocated';
                // }
                field(noneAllocated; '' + Rec."Responsible Officer")
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
