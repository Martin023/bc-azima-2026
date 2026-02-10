query 52186500 "Loan Guarantor Substitution"
{
    QueryType = API;
    APIPublisher = 'sky';
    APIGroup = 'crm';
    APIVersion = 'v1.0';
    Caption = 'Loan Guarantor Substitution', Locked = true;
    EntityName = 'loanGuarantorSubstitution';
    EntitySetName = 'loanGuarantorSubstitutions';

    EntityCaption = 'Loan Guarantor Substitution';
    EntitySetCaption = 'Loan Guarantor Substitutions';

    elements
    {
        dataitem(QueryElementMain; "Guarantors Substitution")
        {
            column(no; "No.")
            {
                Caption = 'No.';
            }
            column(loanNo; "Loan No.")
            {
                Caption = 'Loan No.';
            }
            column(loanType; "Loan Product Type")
            {
                Caption = 'Loan Product Type';
            }
            column("date"; "Date")
            {
                Caption = 'Date';
            }
            column(loanAccountNo; "Loan Account No.")
            {
                Caption = 'Loan Account No.';
            }
            column(name; Name)
            {
                Caption = 'Name';
            }
            column(accountStatus; "Account Status")
            {
                Caption = 'Account Status';
            }
            column(status; Status)
            {
                Caption = 'Status';
            }
            column(approvedBy; "Posted By")
            {
                Caption = 'Approved By';
            }
            column(createdBy; "Captured By")
            {
                Caption = 'Created By';
            }
            column(activityCode; "Global Dimension 2 Code")
            {
                Caption = 'Activity Code';
            }
            column(branchCode; "Global Dimension 1 Code")
            {
                Caption = 'Branch Code';
            }
            column(documentNo; "Document No.")
            {
                Caption = 'Document No.';
            }
            column("approvalDate"; "Approval Date")
            {
                Caption = 'Approval Date';
            }

            column(posted; Posted)
            {
                Caption = 'Posted';
            }
            column(crmApplicationNo; "CRM Application No.")
            {
                Caption = 'CRM Application No.';
            }
            column(crmCreatedBy; "CRM Created By")
            {
                Caption = 'CRM Created By';
            }
            column(crmOriginatingBranch; "CRM Originating Branch")
            {
                Caption = 'CRM Originating Branch';
            }
            column(crmNotes; "CRM Notes")
            {
                Caption = 'CRM Notes';
            }
            column(loaneeMemberNo; "Member No.")
            {
                Caption = 'Loanee Member No.';
            }
            column(noneAllocated; "Responsible Officer")
            {
                Caption = 'None allocated';
            }

            column(sentBackToCRM; "Sent Back to CRM")
            {
                Caption = 'Sent Back to CRM';
            }
            column(rejectedBy; "Rejected By")
            {
                Caption = 'Rejected By';
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

            dataitem(QueryElement1; "Loan Guarantors Sub")
            {
                DataItemLink = "No." = QueryElementMain."No.";
                SqlJoinType = LeftOuterJoin;

                dataitem(OutgoingGuarantor; "Savings Accounts")
                {
                    DataItemLink = "No." = QueryElement1."Member Substituted";
                    SqlJoinType = InnerJoin;
                    column(outgoingGuarantorMemberNo; "Member No.")
                    {
                        Caption = 'Outgoing Guarantor Member No';
                    }

                    dataitem(IncomingGuarantor; "Savings Accounts")
                    {
                        DataItemLink = "No." = QueryElement1."Savings Account No.";
                        SqlJoinType = InnerJoin;
                        column(incomingGuarantorMemberNo; "Member No.")
                        {
                            Caption = 'Incoming Guarantor Member No';
                        }

                        dataitem(Loanee; Members)
                        {
                            DataItemLink = "No." = QueryElement1."Member No";
                            SqlJoinType = InnerJoin;
                            column(loaneePrimaryIdentifierType; "Primary Identification Type")
                            {
                                Caption = 'loaneePrimaryIdentifierType';
                            }
                            column(loaneePrimaryIdentifier; "Primary Identification")
                            {
                                Caption = 'loaneePrimaryIdentifier';
                            }
                            column(loaneeStatus; Status)
                            {
                                Caption = 'loaneeStatus';
                            }

                            dataitem(Comments; "Loan Appraisal Comments")
                            {
                                DataItemLink = "Loan No." = QueryElementMain."Loan No.";
                                SqlJoinType = LeftOuterJoin;

                                column(statusComment; "Comment")
                                {
                                    Caption = 'Status Comment';
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}