page 52186584 "CRM Product Variations API"
{
    APIGroup = 'crm';
    APIPublisher = 'sky';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'crmProductVariationsAPI';
    DelayedInsert = true;
    EntityName = 'productVariation';
    EntitySetName = 'productVariations';
    PageType = API;
    SourceTable = "Product Variations";

    EntityCaption = 'Product Variation';
    EntitySetCaption = 'Product Variations';

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
                field(memberName; Rec."Member Name")
                {
                    Caption = 'Member Name';
                }
                // field(amountOn; Rec."Amount On")
                // {
                //     Caption = 'Amount On';
                // }
                field(amountOff; Rec."Amount Off")
                {
                    Caption = 'Amount Off';
                }
                field(prorata; Rec.Prorata)
                {
                    Caption = 'Prorata';
                }
                field(approvedAmount; Rec."Amount On")
                {
                    Caption = 'Approved Amount';
                }
                field(applicationDate; Rec."Application Date")
                {
                    Caption = 'Application Date';
                }
                field(capturedBy; Rec."Captured By")
                {
                    Caption = 'Captured By';
                }
                field(reference; Rec.Reference)
                {
                    Caption = 'Reference';
                }
                field(accountNo; Rec."Account No")
                {
                    Caption = 'Account No';
                }
                field(productType; Rec."Product Type")
                {
                    Caption = 'Product Type';
                }
                field(productName; Rec."Product Name")
                {
                    Caption = 'Product Name';
                }
                field(variationType; Rec."Variation Type")
                {
                    Caption = 'Variation Type';
                }
                field(actualAmount; Rec."Actual Amount")
                {
                    Caption = 'Actual Amount';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(crmApplicationNo; Rec."CRM Application No.")
                {
                    Caption = 'CRM Application No.';
                }
                field(crmNotes; Rec."CRM Notes")
                {
                    Caption = 'CRM Notes';
                }
                field(crmOriginatingBranch; Rec."CRM Originating Branch")
                {
                    Caption = 'CRM Originating Branch';
                }
                field(crmCreatedBy; Rec."CRM Created By")
                {
                    Caption = 'CRM Created By';
                }
                field(effectiveDate; Rec."Effective Month")
                {
                    Caption = 'Effective Date';
                }
                field(posted; Rec.posted)
                {
                    Caption = 'Posted';
                }
                field(responsibleOfficer; Rec."Responsible Officer")
                {
                    Caption = 'Responsible Officer';
                }
                field(sentBackToCRM; Rec."Sent Back to CRM")
                {
                    Caption = 'Sent Back to CRM';
                }
                field(idNo; '')
                {
                    Caption = 'ID No.';
                }
                field(membershipStatus; Rec."Member Status")
                {
                    Caption = 'Member Status';
                }
                field(idNumber; Rec."Member ID No.")
                {
                    Caption = 'Member ID No.';
                }
                field(approvedBy; Rec."Approved By")
                {
                    Caption = 'Approved By';
                }
                field(approvalDate; Rec."Approval Date")
                {
                    Caption = 'Approval Date';
                }
                field(statusComment; 'The application status is: ' + Format(Rec.Status))
                {
                    Caption = 'Status Comment';
                }
                field(employerCode; Rec."Employer Code")
                {
                    Caption = 'Employer Code';
                }
                // field(noneAllocated; false)
                // {
                //     Caption = 'None allocated';
                // }
                field(noneAllocated; '' + Rec."Responsible Officer")
                {
                    Caption = 'None allocated';
                }
                field(netDifference; Rec."Amount On" - Rec."Amount Off")
                {
                    Caption = 'Net Difference';
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
