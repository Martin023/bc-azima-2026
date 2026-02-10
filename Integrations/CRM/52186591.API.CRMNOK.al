page 52186591 "CRM NOK API"
{
    APIGroup = 'crm';
    APIPublisher = 'sky';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'nokAPI';
    DelayedInsert = true;
    EntityName = 'nominee';
    EntitySetName = 'nominees';
    PageType = API;
    SourceTable = "Next of KIN";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(fullName; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(identificationType; Rec."Identification Type")
                {
                    Caption = 'Identification Type';
                }
                field(identification; Rec.Identification)
                {
                    Caption = 'Identification';
                }
                field(allocation; Rec.Allocation)
                {
                    Caption = 'Allocation';
                }
                field(memberNo; Rec."Record ID")
                {
                    Caption = 'Record ID';
                }
                field(memberName; Rec."Member Name")
                {
                    Caption = 'Member Name';
                }
                field(phone; Rec.Telephone)
                {
                    Caption = 'Mobile No.';
                }
                field(email; Rec.Email)
                {
                    Caption = 'Email';
                }
                field(relationship; Rec.Relationship)
                {
                    Caption = 'Relationship';
                }
                field(gender; Rec.Gender)
                {
                    Caption = 'Relationship';
                }
                field(dateOfBirth; Rec."Date of Birth")
                {
                    Caption = 'Date of Birth';
                }
                field(isContactPerson; Rec."Is Contact Person")
                {
                    Caption = 'Is Contact Person';
                }
                field(isNominee; Rec."Is Nominee")
                {
                    Caption = 'Is Nominee';
                }
                field(isABeneficiary; Rec."Is a Beneficiary")
                {
                    Caption = 'Is a Beneficiary';
                }
                field(isNextOfKin; Rec."Is Next of Kin")
                {
                    Caption = 'Is Next Of Kin';
                }
                field(deceased; Rec.Deceased)
                {
                    Caption = 'Deceased';
                }
                field(address; Rec.Address)
                {
                    Caption = 'Address';
                }
                field(approvalDate; Rec."Date Approved")
                {
                    Caption = 'Approval Date';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
            }
        }
    }
}
