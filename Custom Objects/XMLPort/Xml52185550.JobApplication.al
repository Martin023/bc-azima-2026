xmlport 52185550 "Job Application"
{
    Caption = 'Job Application';
    Format = VariableText;
    Direction = Both;

    schema
    {
        textelement(Root)
        {
            tableelement(hrjobapplications; "hr job applications")
            {
                fieldelement(JobApplicationNo; hrjobapplications."Job Application No.")
                {
                }
                fieldelement(DateApplied; hrjobapplications."Date Applied")
                {
                }

                fieldelement(ApplicantType; hrjobapplications."Applicant Type")
                {
                }
                fieldelement(EmployeeRequisitionNo; hrjobapplications."Employee Requisition No")
                {

                }
                fieldelement(JobAppliedFor; hrjobapplications."Job Applied For")
                {
                }
                fieldelement(JobAppliedforDescription; hrjobapplications."Job Applied for Description")
                {
                }
                fieldelement(FirstName; hrjobapplications."First Name")
                {
                }
                fieldelement(MiddleName; hrjobapplications."Middle Name")
                {
                }
                fieldelement(LastName; hrjobapplications."Last Name")
                {
                }
                fieldelement(FirstLanguageRWS; hrjobapplications."First Language (R/W/S)")
                {
                }
                fieldelement(FirstLanguageRead; hrjobapplications."First Language Read")
                {
                }
                fieldelement(FirstLanguageSpeak; hrjobapplications."First Language Speak")
                {
                }
                fieldelement(FirstLanguageWrite; hrjobapplications."First Language Write")
                {
                }
                fieldelement(SecondLanguageRWS; hrjobapplications."Second Language (R/W/S)")
                {
                }
                fieldelement(SecondLanguageRead; hrjobapplications."Second Language Read")
                {
                }
                fieldelement(SecondLanguageSpeak; hrjobapplications."Second Language Speak")
                {
                }
                fieldelement(SecondLanguageWrite; hrjobapplications."Second Language Write")
                {
                }
                fieldelement(IDNumber; hrjobapplications."ID Number")
                {
                }
                fieldelement(AdditionalLanguage; hrjobapplications."Additional Language")
                {
                }
                fieldelement(Gender; hrjobapplications.Gender)
                {
                }
                fieldelement(PostCode; hrjobapplications."Post Code")
                {
                }
                fieldelement(PostalAddress; hrjobapplications."Postal Address")
                {
                }
                fieldelement(ResidentialAddress; hrjobapplications."Residential Address")
                {
                }
                fieldelement(HomePhoneNumber; hrjobapplications."Home Phone Number")
                {
                }
                fieldelement(CellPhoneNumber; hrjobapplications."Cell Phone Number")
                {
                }
                fieldelement(WorkPhoneNumber; hrjobapplications."Work Phone Number")
                {
                }
                fieldelement(EMail; hrjobapplications."E-Mail")
                {
                }
                fieldelement(MaritalStatus; hrjobapplications."Marital Status")
                {
                }
                fieldelement(Disabled; hrjobapplications.Disabled)
                {
                }
                fieldelement(DateOfBirth; hrjobapplications."Date Of Birth")
                {
                }
                fieldelement(Ag; hrjobapplications.Ag)
                {
                }

                fieldelement(Citizenship; hrjobapplications.Citizenship)
                {
                }
                fieldelement(CitizenshipDetails; hrjobapplications."Citizenship Details")
                {
                }

                fieldelement(Status; hrjobapplications.Status)
                {
                }
                fieldelement(ProposedSalary; hrjobapplications."Proposed Salary")
                {
                }
                fieldelement(RejectionReason; hrjobapplications."Rejection Reason")
                {
                }
            }
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPostXmlPort()
    begin
        Message('Job Application Uploaded Successfuly');
    end;
}
