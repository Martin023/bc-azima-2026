query 52186503 "CRM Members Marketing API"
{
    APIGroup = 'crm';
    APIPublisher = 'sky';
    APIVersion = 'v1.0';
    EntityName = 'member';
    EntitySetName = 'members';
    QueryType = API;

    elements
    {
        dataitem(members; Members)
        {
            column(memberNo; "No.")
            {
                Caption = 'No.';
            }
            column(firstName; "First Name")
            {
                Caption = 'First Name';
            }
            column(middleName; "Middle Name")
            {
                Caption = 'Last Name';
            }
            column(lastName; "Other Names")
            {
                Caption = 'Other Names';
            }
            column(fullName; Name)
            {
                Caption = 'Name';
            }
            column(age; Age)
            {
                Caption = 'Age';
            }
            column(status; Status)
            {
                Caption = 'Status';
            }
            column(subStatus; Subflag)
            {
                Caption = 'Sub Status';
            }
            column(identificationType; "Primary Identification Type")
            {
                Caption = 'Primary Identification Type';
            }
            column(identificationNo; "Primary Identification")
            {
                Caption = 'Primary Identification';
            }
            column(secondaryIdentificationType; "Secondary Identification Type")
            {
                Caption = 'Secondary Identification Type';
            }
            column(secondaryIdentificationNo; "Secondary Identification")
            {
                Caption = 'Secondary Identification';
            }
            column(payrollNo; "Payroll/Staff No.")
            {
                Caption = 'Payroll No';
            }
            column(countryCode; Nationality)
            {
                Caption = 'Country Code';
            }
            column(countyNo; County)
            {
                Caption = 'Country Code';
            }

            column(transactionalMobileNumber; "Transactional Mobile Number")
            {
                Caption = 'Transactional Mobile Number';
            }
            column(phoneNumber; "Phone No.")
            {
                Caption = 'Phone Number';
            }
            column(officePhone; "Office Telephone No.")
            {
                Caption = 'Office Telephone No.';
            }
            column(city; City)
            {
                Caption = 'City';
            }
            column(currentAddress; "Current Address")
            {
                Caption = 'Current Address';
            }
            column(kraPin; "P.I.N Number")
            {
                Caption = 'KRA PIN';
            }
            column(email; "E-Mail")
            {
                Caption = 'Email';
            }
            column(permanentAddress; "Home Address")
            {
                Caption = 'Permanent Address';
            }
            column(poBox; "Post Code")
            {
                Caption = 'P.O Box';
            }
            column(fosaBranchCode; "Branch Code")
            {
                Caption = 'FOSA Branch Code';
            }
            column(recruiterType; "Recruited by Type")
            {
                Caption = 'Recruited by Type';
            }
            column(recruiterName; "Recruited By Name")
            {
                Caption = 'Recruited By Name';
            }
            column(accountType; "Account Type")
            {
                Caption = 'Account Type';
            }
            column(accountProfile; "Account Profile")
            {
                Caption = 'Account Profile';
            }
            column(memberClass; "Member Class")
            {
                Caption = 'Member Class';
            }
            column(bankCode; "Bank Code")
            {
                Caption = 'Bank Code';
            }
            column(bankBranchCode; "Branch Code")
            {
                Caption = 'Bank Branch Code';
            }
            column(bankAccountNo; "Bank Account No.")
            {
                Caption = 'Bank Account No';
            }
            column(dateOfBirth; "Date of Birth")
            {
                Caption = 'Date of Birth';
            }
            column(gender; "Gender")
            {
                Caption = 'Gender';
            }
            column(maritalStatus; "Marital Status")
            {
                Caption = 'Marital Status';
            }
            column(anyPhysicalDisability; "Any Physical Disability")
            {
                Caption = 'Any Physical Disability';
            }
            column(dateOfRegistration; "Registration Date")
            {
                Caption = 'Registration Date';
            }
            column(isFromAnotherSACCO; "From Another Sacco")
            {
                Caption = 'From Another Sacco';
            }
            column(dateOfContributionCommencement; "Contribution Start Date")
            {
                Caption = 'Contribution Start Date';
            }
            column(religion; Religion)
            {
                Caption = 'Religion';
            }
            column(natureOfEmployment; "Terms of Employment")
            {
                Caption = 'Nature of Employment';
            }
            column(employerCode; "Employer Code")
            {
                Caption = 'Employer Code';
            }
            column(workstation; "Work Station")
            {
                Caption = 'Work Station';
            }
            column(designation; "Employment Designation")
            {
                Caption = 'Employment Designation';
            }
            column(totalSavings; "Total Savings")
            {
                Caption = 'Total Savings';
            }
            column(loanBalances; "Loan Balances")
            {
                Caption = 'Loan Balances';
            }
            column(assignedBCUser; "Allocated Officer Name")
            {
                Caption = 'Assigned BC User';
            }
            column(createdBy; "Created By")
            {
                Caption = 'Created By';
            }
            column(approvedBy; "Approved By")
            {
                Caption = 'Approved By';
            }
            column(approvalDate; "Date Approved")
            {
                Caption = 'Approval Date';
            }
            column(countyName; County)
            {
                Caption = 'County Name';
            }


            dataitem(TheFosaAccount; "Savings Accounts")
            {
                DataItemLink = "Member No." = members."No.";

                SqlJoinType = LeftOuterJoin;
                DataItemTableFilter = "Product Category" = const("FOSA Account");
                column(fosaAccountNo; "No.")
                {
                    Caption = 'Fosa Account';
                }
                column(fosaAccountBalance; "Balance (LCY)")
                {
                    Caption = 'Fosa Account Balance';
                }

                dataitem(Shares; "Savings Accounts")
                {
                    DataItemLink = "Member No." = members."No.";
                    SqlJoinType = LeftOuterJoin;
                    DataItemTableFilter = "Product Category" = const("Share Capital");
                    column(sharesAccountNo; "No.")
                    {
                        Caption = 'Shares Account';
                    }
                    column(sharesAccountBalance; "Balance (LCY)")
                    {
                        Caption = 'Shares Account Balance';
                    }

                    dataitem(TransferredShares; "Savings Accounts")
                    {
                        DataItemLink = "Member No." = members."No.";
                        SqlJoinType = LeftOuterJoin;
                        DataItemTableFilter = "Product Category" = const("Transfered Share Capital");
                        column(transferredSharesAccountNo; "No.")
                        {
                            Caption = 'Transferred Shares Account';
                        }
                        column(transferredSharesAccountBalance; "Balance (LCY)")
                        {
                            Caption = 'Transferred Shares Account Balance';
                        }

                        dataitem(deposits; "Savings Accounts")
                        {
                            DataItemLink = "Member No." = members."No.";
                            SqlJoinType = LeftOuterJoin;
                            DataItemTableFilter = "Product Category" = const("BOSA Deposits");
                            column(depositsAccountNo; "No.")
                            {
                                Caption = 'BOSA Deposits';
                            }
                            column(depositsAccountBalance; "Balance (LCY)")
                            {
                                Caption = 'Deposits Account Balance';
                            }

                            column(monthlyContribution; "Monthly Contribution")
                            {
                                Caption = 'Monthly Contribution';
                            }


                            dataitem(dividendProgression; "Dividend Progression")
                            {
                                DataItemLink = "Member No" = members."No.";
                                SqlJoinType = LeftOuterJoin;
                                column(dividends; "Net Dividends")
                                {
                                    Caption = 'Dividends';
                                    Method = Sum;
                                }

                                dataitem(DelegateZone; "Electoral Zones")
                                {
                                    DataItemLink = Code = members."Delegates Zone";
                                    SqlJoinType = LeftOuterJoin;

                                    column(delegateZoneCode; Code)
                                    {
                                        Caption = 'Delegates Zone Code';
                                    }
                                    column(delegateZoneName; "Electoral Zone Name")
                                    {
                                        Caption = 'Delegates Zone Name';
                                    }

                                    // dataitem(RegistrationFee; "Savings Accounts")
                                    // {
                                    //     DataItemLink = "Member No." = members."No.";
                                    //     DataItemTableFilter = "Product Category" = const("Entrance Fee");
                                    //     column(regAccountNo; "No.")
                                    //     {
                                    //         Caption = 'Registration Account';
                                    //     }
                                    //     column(regAccountBalance; "Balance (LCY)")
                                    //     {
                                    //         Caption = 'Registration Account Balance';
                                    //     }
                                    // }
                                }
                            }
                        }
                    }
                }
            }

            column(systemId; SystemId)
            {
                Caption = 'SystemId';
            }
            column(systemCreatedAt; SystemCreatedAt)
            {
                Caption = 'SystemCreatedAt';
            }
            column(systemModifiedAt; SystemModifiedAt)
            {
                Caption = 'SystemModifiedAt';
            }
        }
    }

    trigger OnBeforeOpen()
    begin
        // fosaAccountNo := GFunc.GetSavingsAccountAvailableBalance(TheFosaAccount);
    end;

    var
        GFunc: Codeunit "Global Functions";
}
