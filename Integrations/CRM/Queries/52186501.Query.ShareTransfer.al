query 52186501 "Share Transfer Application"
{
    QueryType = API;
    APIGroup = 'crm';
    APIPublisher = 'sky';
    APIVersion = 'v1.0';
    Caption = 'Share Transfers', Locked = true;
    EntityName = 'shareCapitalTransfer';
    EntitySetName = 'shareCapitalTransfers';

    EntityCaption = 'Share Capital Transfer Application';
    EntitySetCaption = 'Share Capital Transfer Applications';

    elements
    {
        dataitem(QueryElementMain; "Share Capital Transfer Buffer")
        {
            dataitem(Buyers; "Share Capital Transfer Lines")
            {
                DataItemLink = "Document No." = QueryElementMain."Document No";
                SqlJoinType = InnerJoin;

                column(buyerMemberNo; "Destination Member No")
                {
                    Caption = 'Buyer Member Number';
                }
                column(buyerMemberName; "Destination Member Name")
                {
                    Caption = 'Buyer Member Name';
                }
                column(buyerAmount; "Allocation Amount")
                {
                    Caption = 'Buyer Amount';
                }
                column(buyerMobileNo; "Mobile No")
                {
                    Caption = 'Buyer Mobile No';
                }
                column(buyerIDNo; "ID No")
                {
                    Caption = 'Buyer ID No';
                }
                column(buyerAccountNo; "Account No")
                {
                    Caption = 'Buyer Account No';
                }

                dataitem(Buyer; Members)
                {
                    DataItemLink = "No." = Buyers."Destination Member No";
                    SqlJoinType = InnerJoin;
                    column(buyerStatus; Status)
                    {
                        Caption = 'Buyer Status';
                    }
                    column(buyerEmployerCode; "Employer Code")
                    {
                        Caption = 'Buyer Employer Code';
                    }
                    column(buyerEmployerName; "Employer Name")
                    {
                        Caption = 'Buyer Employer Name';
                    }

                    dataitem(Seller; Members)
                    {
                        DataItemLink = "No." = QueryElementMain."Source Member No";
                        SqlJoinType = InnerJoin;
                        column(sellerStatus; Status)
                        {
                            Caption = 'Seller Status';
                        }

                        dataitem(SellerAccount; "Savings Accounts")
                        {
                            DataItemLink = "No." = Buyers."Account No";
                            SqlJoinType = InnerJoin;
                            column(buyerAccountBalance; "Balance (LCY)")
                            {
                                Caption = 'Buyer Account Balance';
                            }

                            dataitem(Comments; "Loan Appraisal Comments")
                            {
                                DataItemLink = "Loan No." = QueryElementMain."Document No";
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
            column(documentNo; "Document No")
            {
                Caption = 'Document No';
            }
            column(sourceAccountNo; "Source Account No")
            {
                Caption = 'Source Account No';
            }
            column(sourceMemberNo; "Source Member No")
            {
                Caption = 'Source Member No';
            }
            column(sourceMemberName; "Source Member Name")
            {
                Caption = 'Source Member Name';
            }
            column(sourceBalance; "Source Balance")
            {
                Caption = 'Source Balance';
            }
            column(sourceMobileNumber; "Source Mobile Number")
            {
                Caption = 'Source Mobile Number';
            }
            column(sourceIDNo; "Source ID No.")
            {
                Caption = 'Source ID No.';
            }
            column(transfered; Transfered)
            {
                Caption = 'Transfered';
            }
            column(transferReason; "Transfer Reason")
            {
                Caption = 'Transfer Reason';
            }
            column(status; Status)
            {
                Caption = 'Status';
            }
            column("transactionType"; "Transaction Type")
            {
                Caption = 'Transaction Type';
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
            column(sentBackToCRM; "Sent Back to CRM")
            {
                Caption = 'Sent Back to CRM';
            }
            column(posted; Posted)
            {
                Caption = 'Posted';
            }
            column(referenceNo; "Reference No")
            {
                Caption = 'Reference No';
            }
            column(applicationDate; "Application Date")
            {
                Caption = ' Application Date';
            }
            column(receiptAmount; "Receipt Amount")
            {
                Caption = 'Receipt Amount';
            }
            column(responsibleOfficer; "Responsible Officer")
            {
                Caption = 'Responsible Officer';
            }
            column(approvedBy; "Approved By")
            {
                Caption = 'Approved By';
            }
            column(approvalDate; "Approval Date")
            {
                Caption = 'Approval Date';
            }

            column(noneAllocated; "Responsible Officer")
            {
                Caption = 'None allocated';
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
