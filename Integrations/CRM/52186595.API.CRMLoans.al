page 52186595 "CRM Loans API"
{
    APIGroup = 'crm';
    APIPublisher = 'sky';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'loansAPI';
    DelayedInsert = true;
    EntityName = 'loan';
    EntitySetName = 'loans';
    PageType = API;
    SourceTable = Loans;

    EntityCaption = 'Loan';
    EntitySetCaption = 'Loans';

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
                field(loanNo; Rec."Loan No.")
                {
                    Caption = 'Loan No.';
                }
                field(memberNo; Rec."Member No.")
                {
                    Caption = 'Member No.';
                }
                field(memberNames; Rec."Member Name")
                {
                    Caption = 'Member Names';
                }

                field(memberPrimaryIdentifierType; Rec."Member Primary Identifier Type")
                {
                    Caption = 'Member Primary Identifier Type';
                }
                field(memberPrimaryIdentifier; Rec."Member Primary Identifier")
                {
                    Caption = 'Member Primary Identifier';
                }

                field(membershipStatus; Rec."Member Status")
                {
                    Caption = 'Member Status';
                }
                field(applicationStatus; Rec."Status")
                {
                    Caption = 'Member Status';
                }
                field(purposeOfLoan; Rec."Purpose of Loan")
                {
                    Caption = 'Purpose of Loan';
                }
                field(lendingUnit; Rec."Source Unit")
                {
                    Caption = 'Source Unit';
                }
                field(sourceApplication; Rec."Source Aplication")
                {
                    Caption = 'Source Application';
                }
                field(loanProductNo; Rec."Loan Product Type")
                {
                    Caption = 'Loan Product Type';
                }
                field(loanProductTypeName; Rec."Loan Product Type Name")
                {
                    Caption = 'Loan Product Type Name';
                }
                field(sasraMainSectorCode; Rec."Main Sector")
                {
                    Caption = 'Main Sector';
                }
                field(sasraMainSectorDescription; Rec."Main Sector Description")
                {
                    Caption = 'Main Sector Description';
                }
                field(sasraSubSectorLevel1Code; Rec."Sub Sector Level1")
                {
                    Caption = 'Sub Sector Level1';
                }
                field(sasraSubSectorLevel1Description; Rec."Sub Sector Level1 Description")
                {
                    Caption = 'Sub Sector Level1 Description';
                }
                field(sasraSubSectorLevel2Code; Rec."Sub Sector Level2")
                {
                    Caption = 'Sub Sector Level2';
                }
                field(sasraSubSectorLevel2Description; Rec."Sub Sector Level2 Description")
                {
                    Caption = 'Sub Sector Level2 Description';
                }
                field(interest; Rec.Interest)
                {
                    Caption = 'Interest';
                }
                field(interestCalculationMethod; Rec."Interest Calculation Method")
                {
                    Caption = 'Interest Calculation Method';
                }
                field(newInterestRate; Rec."New Interest Rate")
                {
                    Caption = 'New Interest Rate';
                }
                field(outstandingInterest; Rec."Outstanding Interest")
                {
                    Caption = 'Outstanding Interest';
                }
                field(terms; Rec.Installments)
                {
                    Caption = 'Installments';
                }
                field(appliedAmount; Rec."Requested Amount")
                {
                    Caption = 'Requested Amount';
                }
                field(approvedAmount; Rec."Approved Amount")
                {
                    Caption = 'Approved Amount';
                }
                field(crmCreatedBy; Rec."CRM Created By")
                {
                    Caption = 'CRM Created By';
                }
                field(crmApplicationNo; Rec."CRM Application No.")
                {
                    Caption = 'CRM Application No';
                }
                field(crmOriginatingBranch; Rec."CRM Originating Branch")
                {
                    Caption = 'CRM Originating Branch';
                }
                field(selfGuarantee; Rec."Self Guarantee")
                {
                    Caption = 'Self Guarantee';
                }
                field(disbursementDate; Rec."Disbursement Date")
                {
                    Caption = 'Disbursement Date';
                }
                field(monthlyRepayment; Rec.Repayment)
                {
                    Caption = 'Repayment';
                }
                field(loanApplicationFormNo; Rec."Loan Appl.form No.")
                {
                    Caption = 'Loan Appl.form No.';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(loanBalance; Rec."Total Loan Balance")
                {
                    Caption = 'Total Loan Balance';
                }
                field(createdBy; Rec."CRM Created By")
                {
                    Caption = 'Created By';
                }
                field(approvedBy; Rec."Approved By")
                {
                    Caption = 'Approved By';
                }
                field(approvalDate; Rec."Approval Date")
                {
                    Caption = 'Approval Date';
                }
                field(applicationDate; Rec."Application Date")
                {
                    Caption = 'Application Date';
                }

                field(employerCode; Rec."Employer Code")
                {
                    Caption = 'Employer Code';
                }

                field(priority; Rec."CRM Priority")
                {
                    Caption = 'Priority';
                }

                // field(noneAllocated; Rec."Captured By" = '')
                // {
                //     Caption = 'None allocated';
                // }
                field(responsibleOfficer; Rec."Responsible Officer")
                {
                    Caption = 'Responsible Officer';
                }

                field(noneAllocated; '' + Rec."Responsible Officer")
                {
                    Caption = 'None allocated';
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
