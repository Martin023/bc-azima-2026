query 52186502 "CRM Product Variations API"
{
    QueryType = API;
    APIGroup = 'crm';
    APIPublisher = 'sky';
    APIVersion = 'v1.0';
    Caption = 'crmProductVariationsAPI', Locked = true;
    EntityName = 'productVariation';
    EntitySetName = 'productVariations';

    EntityCaption = 'Product Variation';
    EntitySetCaption = 'Product Variations';

    elements
    {
        dataitem(QueryElementMain; "Product Variations")
        {
            column(no; "No.")
            {
                Caption = 'No.';
            }
            column(memberNo; "Member No.")
            {
                Caption = 'Member No.';
            }
            column(memberName; "Member Name")
            {
                Caption = 'Member Name';
            }
            column(amountOn; "Amount On")
            {
                Caption = 'Amount On';
            }
            column(amountOff; "Amount Off")
            {
                Caption = 'Amount Off';
            }
            column(prorata; Prorata)
            {
                Caption = 'Prorata';
            }
            column(approvedAmount; "Amount On")
            {
                Caption = 'Approved Amount';
            }
            column(applicationDate; "Application Date")
            {
                Caption = 'Application Date';
            }
            column(capturedBy; "Captured By")
            {
                Caption = 'Captured By';
            }
            column(reference; Reference)
            {
                Caption = 'Reference';
            }
            column(accountNo; "Account No")
            {
                Caption = 'Account No';
            }
            column(productType; "Product Type")
            {
                Caption = 'Product Type';
            }
            column(productName; "Product Name")
            {
                Caption = 'Product Name';
            }
            column(variationType; "Variation Type")
            {
                Caption = 'Variation Type';
            }
            column(actualAmount; "Actual Amount")
            {
                Caption = 'Actual Amount';
            }
            column(status; Status)
            {
                Caption = 'Status';
            }
            column(crmApplicationNo; "CRM Application No.")
            {
                Caption = 'CRM Application No.';
            }
            column(crmNotes; "CRM Notes")
            {
                Caption = 'CRM Notes';
            }
            column(crmOriginatingBranch; "CRM Originating Branch")
            {
                Caption = 'CRM Originating Branch';
            }
            column(crmCreatedBy; "CRM Created By")
            {
                Caption = 'CRM Created By';
            }
            column(Effective_Month; "Effective Month")
            {
                Caption = 'Effective Date';
            }
            column(posted; posted)
            {
                Caption = 'Posted';
            }
            column(responsibleOfficer; "Responsible Officer")
            {
                Caption = 'Responsible Officer';
            }
            column(sentBackToCRM; "Sent Back to CRM")
            {
                Caption = 'Sent Back to CRM';
            }
            column(membershipStatus; "Member Status")
            {
                Caption = 'Member Status';
            }
            column(idNumber; "Member ID No.")
            {
                Caption = 'Member ID No.';
            }
            column(approvedBy; "Approved By")
            {
                Caption = 'Approved By';
            }
            column(approvalDate; "Approval Date")
            {
                Caption = 'Approval Date';
            }
            column(employerCode; "Employer Code")
            {
                Caption = 'Employer Code';
            }


            column(systemCreatedAt; SystemCreatedAt)
            {
                Caption = 'SystemCreatedAt';
            }
            column(systemCreatedBy; SystemCreatedBy)
            {
                Caption = 'SystemCreatedBy';
            }
            column(systemId; SystemId)
            {
                Caption = 'SystemId';
            }
            column(systemModifiedAt; SystemModifiedAt)
            {
                Caption = 'SystemModifiedAt';
            }
            column(systemModifiedBy; SystemModifiedBy)
            {
                Caption = 'SystemModifiedBy';
            }
        }
    }
}
