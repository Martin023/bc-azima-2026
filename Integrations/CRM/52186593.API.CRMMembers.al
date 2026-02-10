page 52186593 "CRM Members API"
{
    APIGroup = 'crm';
    APIPublisher = 'sky';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'membersAPI';
    DelayedInsert = true;
    EntityName = 'member';
    EntitySetName = 'members';
    PageType = API;
    SourceTable = Members;

    EntityCaption = 'Member';
    EntitySetCaption = 'Members';

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
                field(memberNo; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(firstName; Rec."First Name")
                {
                    Caption = 'First Name';
                }
                field(middleName; Rec."Middle Name")
                {
                    Caption = 'Last Name';
                }
                field(lastName; Rec."Other Names")
                {
                    Caption = 'Other Names';
                }
                field(fullName; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(subStatus; Rec.Subflag)
                {
                    Caption = 'Sub Status';
                }
                field(identificationType; Rec."Primary Identification Type")
                {
                    Caption = 'Primary Identification Type';
                }
                field(identificationNo; Rec."Primary Identification")
                {
                    Caption = 'Primary Identification';
                }
                field(secondaryIdentificationType; Rec."Secondary Identification Type")
                {
                    Caption = 'Secondary Identification Type';
                }
                field(secondaryIdentificationNo; Rec."Secondary Identification")
                {
                    Caption = 'Secondary Identification';
                }
                field(payrollNo; Rec."Payroll/Staff No.")
                {
                    Caption = 'Payroll No';
                }
                field(countryCode; Rec.Nationality)
                {
                    Caption = 'Country Code';
                }
                field(countyNo; Rec.County)
                {
                    Caption = 'Country Code';
                }
                field(transactionalMobileNumber; Rec."Transactional Mobile Number")
                {
                    Caption = 'Transactional Mobile Number';
                }
                field(phoneNumber; Rec."Phone No.")
                {
                    Caption = 'Phone Number';
                }
                field(officePhone; Rec."Office Telephone No.")
                {
                    Caption = 'Office Telephone No.';
                }
                field(city; Rec.City)
                {
                    Caption = 'City';
                }
                field(currentAddress; Rec."Current Address")
                {
                    Caption = 'Current Address';
                }
                field(kraPin; Rec."P.I.N Number")
                {
                    Caption = 'KRA PIN';
                }
                field(email; Rec."E-Mail")
                {
                    Caption = 'Email';
                }
                field(permanentAddress; Rec."Home Address")
                {
                    Caption = 'Permanent Address';
                }
                field(poBox; Rec."Post Code")
                {
                    Caption = 'P.O Box';
                }
                field(fosaBranchCode; Rec."Branch Code")
                {
                    Caption = 'FOSA Branch Code';
                }
                field(delegateZone; Rec."Delegates Zone")
                {
                    Caption = 'Delegates Zone';
                }
                field(recruiterType; Rec."Recruited by Type")
                {
                    Caption = 'Recruited by Type';
                }
                field(accountType; Rec."Account Type")
                {
                    Caption = 'Account Type';
                }
                field(accountProfile; Rec."Account Profile")
                {
                    Caption = 'Account Profile';
                }
                field(memberClass; Rec."Member Class")
                {
                    Caption = 'Member Class';
                }
                field(bankCode; Rec."Bank Code")
                {
                    Caption = 'Bank Code';
                }
                field(bankBranchCode; Rec."Branch Code")
                {
                    Caption = 'Bank Branch Code';
                }
                field(bankAccountNo; Rec."Bank Account No.")
                {
                    Caption = 'Bank Account No';
                }
                field(dateOfBirth; Rec."Date of Birth")
                {
                    Caption = 'Date of Birth';
                }
                field(gender; Rec."Gender")
                {
                    Caption = 'Gender';
                }
                field(maritalStatus; Rec."Marital Status")
                {
                    Caption = 'Marital Status';
                }
                field(anyPhysicalDisability; Rec."Any Physical Disability")
                {
                    Caption = 'Any Physical Disability';
                }
                field(dateOfRegistration; Rec."Registration Date")
                {
                    Caption = 'Registration Date';
                }
                field(isFromAnotherSACCO; Rec."From Another Sacco")
                {
                    Caption = 'From Another Sacco';
                }
                field(dateOfContributionCommencement; Rec."Contribution Start Date")
                {
                    Caption = 'Contribution Start Date';
                }
                field(religion; Rec.Religion)
                {
                    Caption = 'Religion';
                }
                field(natureOfEmployment; Rec."Terms of Employment")
                {
                    Caption = 'Nature of Employment';
                }
                field(employerCode; Rec."Employer Code")
                {
                    Caption = 'Employer Code';
                }
                field(designation; Rec."Employment Designation")
                {
                    Caption = 'Employment Designation';
                }
                field(totalSavings; Rec."Total Savings")
                {
                    Caption = 'Total Savings';
                }
                field(loanBalances; Rec."Loan Balances")
                {
                    Caption = 'Loan Balances';
                }
                field(assignedBCUser; Rec."Allocated Officer Name")
                {
                    Caption = 'Assigned BC User';
                }
                field(createdBy; Rec."Created By")
                {
                    Caption = 'Created By';
                }
                field(approvedBy; Rec."Approved By")
                {
                    Caption = 'Approved By';
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
