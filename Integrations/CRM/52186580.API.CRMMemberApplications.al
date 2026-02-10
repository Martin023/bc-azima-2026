page 52186580 "CRM Member Applications API"
{
    APIGroup = 'crm';
    APIPublisher = 'sky';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'crmMemberApplicationAPI';
    DelayedInsert = true;
    EntityName = 'memberApplication';
    EntitySetName = 'memberApplications';
    PageType = API;
    SourceTable = "Member Application";

    EntityCaption = 'Member Application';
    EntitySetCaption = 'Member Applications';

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
                field(oldMemberNo; Rec."Old Member No.")
                {
                    Caption = 'Old Member No.';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(firstName; Rec."First Name")
                {
                    Caption = 'First Name';
                }
                field(middleName; Rec."Middle Name")
                {
                    Caption = 'Last Name';
                }
                field(otherNames; Rec."Other Names")
                {
                    Caption = 'Other Names';
                }
                field(currentAddress; Rec."Current Address")
                {
                    Caption = 'Address';
                }
                field(homeAddress; Rec."Home Address")
                {
                    Caption = 'Permanent Address';
                }
                field(phoneNo; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                }
                field(officeTelephoneNo; Rec."Office Telephone No.")
                {
                    Caption = 'Office Telephone No.';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(statusComment; 'The application is at status: ' + Format(Rec.Status))
                {
                    Caption = 'Status Comment';
                }
                field(eMail; Rec."E-Mail")
                {
                    Caption = 'E-Mail';
                }
                field(primaryIdentificationType; Rec."Primary Identification Type")
                {
                    Caption = 'Primary Identification Type';
                }
                field(secondaryIdentificationType; Rec."Secondary Identification Type")
                {
                    Caption = 'Secondary Identification Type';
                }
                field(primaryIdentification; Rec."Primary Identification")
                {
                    Caption = 'Primary Identification';
                }
                field(secondaryIdentification; Rec."Secondary Identification")
                {
                    Caption = 'Secondary Identification';
                }
                field(applicationDate; Rec."Application Date")
                {
                    Caption = 'Application Date';
                }
                field(applicationTime; Rec."Application Time")
                {
                    Caption = 'Application Time';
                }
                field(nationality; Rec.Nationality)
                {
                    Caption = 'Nationality';
                }
                field(religion; Rec.Religion)
                {
                    Caption = 'Religion';
                }
                field(maritalStatus; Rec."Marital Status")
                {
                    Caption = 'Marital Status';
                }
                field(gender; Rec.Gender)
                {
                    Caption = 'Gender';
                }
                field(postCode; Rec."Post Code")
                {
                    Caption = 'Current Post Code';
                }
                field(recruitedByType; Rec."Recruited by Type")
                {
                    Caption = 'Recruited by Type';
                }
                field(recruitedBy; Rec."Recruited By")
                {
                    Caption = 'Salesperson Code';
                }
                field(recruitedByName; Rec."Recruited By Name")
                {
                    Caption = 'Recruited By Name';
                }
                field(pINNumber; Rec."P.I.N Number")
                {
                    Caption = 'KRA Pin No.';
                }
                field(bankCode; Rec."Bank Code")
                {
                    Caption = 'Bank Code';
                }
                field(branchCode; Rec."Branch Code")
                {
                    Caption = 'Branch Code';
                }
                field(termsOfEmployment; Rec."Terms of Employment")
                {
                    Caption = 'Terms of Employment';
                }
                field(countryOfOperation; Rec."Country Of Operation")
                {
                    Caption = 'Country Of Operation';
                }
                field(countryName; Rec."Country Of Operation Name")
                {
                    Caption = 'Country Name';
                }
                field(county; Rec.County)
                {
                    Caption = 'County';
                }
                field(countyName; Rec."County Name")
                {
                    Caption = 'County Name';
                }
                field(city; Rec.City)
                {
                    Caption = 'City';
                }
                field(workStation; Rec."Work Station")
                {
                    Caption = 'Work Station';
                }
                field(employmentDesignation; Rec."Employment Designation")
                {
                    Caption = 'Employment Designation';
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
                field(createdBy; Rec."Created By")
                {
                    Caption = 'Created By';
                }
                field(approvedBy; Rec."Approved By")
                {
                    Caption = 'Approved By';
                }
                field(selfEmployed; Rec."Self Employed")
                {
                    Caption = 'Self Employed';
                }
                field(employerCode; Rec."Employer Code")
                {
                    Caption = 'Employer Code';
                }
                field(employerName; Rec."Employer Name")
                {
                    Caption = 'Employer Name';
                }
                field(payrollStaffNo; Rec."Payroll/Staff No.")
                {
                    Caption = 'Payroll/Staff No.';
                }
                field(memberClass; Rec."Member Class")
                {
                    Caption = 'Member Class';
                }
                field(dateOfBirth; Rec."Date of Birth")
                {
                    Caption = 'Date of Birth';
                }
                field(principleMember; Rec."Principle Member")
                {
                    Caption = 'Principle Member';
                }
                field(typeOfApplication; Rec."Type of Application")
                {
                    Caption = 'Type of Application';
                }
                field(fromAnotherSacco; Rec."From Another Sacco")
                {
                    Caption = 'From Another Sacco';
                }
                field(delegatesZone; Rec."Delegates Zone")
                {
                    Caption = 'Delegates Zone';
                }
                field(electrolZoneDescr; Rec."Electrol Zone Descr.")
                {
                    Caption = 'Electrol Zone Descr.';
                }
                field(salutation; Rec.Salutation)
                {
                    Caption = 'Salutation';
                }
                field(responsibleOfficer; Rec."Responsible Officer")
                {
                    Caption = 'Responsible Officer';
                }
                field(supervisorID; Rec."Supervisor ID")
                {
                    Caption = 'Supervisor ID';
                }
                field(accountProfile; Rec."Account Profile")
                {
                    Caption = 'Account Profile';
                }
                field(transactionalMobileNumber; Rec."Transactional Mobile Number")
                {
                    Caption = 'Transactional Mobile Number';
                }
                field(age; Rec.Age)
                {
                    Caption = 'Age';
                }
                field(subCounty; Rec."Sub-County")
                {
                    Caption = 'Sub-County';
                }
                field(officeEMail; Rec."Office E-Mail")
                {
                    Caption = 'Office E-Mail';
                }
                field(tscNumber; Rec."TSC Number")
                {
                    Caption = 'TSC Number';
                }
                field(companyRegistrationNo; Rec."Company Registration No.")
                {
                    Caption = 'Company Registration No.';
                }
                field(allocatedOfficer; Rec."Allocated Officer")
                {
                    Caption = 'Allocated Officer';
                }
                field(allocatedOfficerName; Rec."Allocated Officer Name")
                {
                    Caption = 'Allocated Officer Name';
                }
                field(yearOfIncorporation; Rec."Year of Incorporation")
                {
                    Caption = 'Year of Incorporation';
                }
                field(requestForATM; Rec."Request for ATM")
                {
                    Caption = 'Request for ATM';
                }
                field(requestMobileBanking; Rec."Request Mobile Banking")
                {
                    Caption = 'Request Mobile Banking';
                }
                field(requestMwalimuSmart; Rec."Request Mwalimu Smart")
                {
                    Caption = 'Request Mwalimu Smart';
                }
                field(passportExpiryDate; Rec."Passport Expiry Date")
                {
                    Caption = 'Passport Expiry Date';
                }
                field(dateApproved; Rec."Date Approved")
                {
                    Caption = 'Date Approved';
                }

                field(dateOfCommencement; Rec."Contribution Start Date")
                {
                    Caption = 'Date Of Commencement';
                }
                field(contributionAmount; Rec."Contribution Amount")
                {
                    Caption = 'Date Of Commencement';
                }
                // field(noneAllocated; Rec."Allocated Officer" = '')
                // {
                //     Caption = 'None allocated';
                // }
                field(noneAllocated; '' + Rec."Responsible Officer")
                {
                    Caption = 'None allocated';
                }
                field(membershipStatus; Rec."Membership Status")
                {
                    Caption = 'Membership Status';
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

                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}
