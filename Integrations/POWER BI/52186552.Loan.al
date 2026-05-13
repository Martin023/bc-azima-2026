page 52186552 Loan
{
    APIGroup = 'powerBI';
    APIPublisher = 'sky';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'loans';
    DelayedInsert = true;
    EntityName = 'loan';
    EntitySetName = 'loans';
    PageType = API;
    SourceTable = Loans;

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
                field(paymentSlip; Rec."20% Payment Slip")
                {
                    Caption = '20% Payment Slip';
                }
                field(advice; Rec.Advice)
                {
                    Caption = 'Advice';
                }
                field(adviceType; Rec."Advice Type")
                {
                    Caption = 'Advice Type';
                }
                field(allPostingThroughSavingsAc; Rec."All Posting through Savings Ac")
                {
                    Caption = 'All Posting through Savings Ac';
                }
                field(alreadySuggested; Rec."Already Suggested")
                {
                    Caption = 'Already Suggested';
                }
                field(amountToDisburse; Rec."Amount To Disburse")
                {
                    Caption = 'Amount To Disburse';
                }
                field(applicationDate; Rec."Application Date")
                {
                    Caption = 'Application Date';
                }
                field(applnBetweenCurrencies; Rec."Appln. between Currencies")
                {
                    Caption = 'Appln. between Currencies';
                }
                field(appraisalFee; Rec."Appraisal Fee")
                {
                    Caption = 'Appraisal Fee';
                }
                field(appraisalParameterType; Rec."Appraisal Parameter Type")
                {
                    Caption = 'Appraisal Parameter Type';
                }
                field(approvalDate; Rec."Approval Date")
                {
                    Caption = 'Approval Date';
                }
                field(approvedAmount; Rec."Approved Amount")
                {
                    Caption = 'Approved Amount';
                }
                field(approvedBy; Rec."Approved By")
                {
                    Caption = 'Approved By';
                }
                field(availableCreditLimit; Rec."Available Credit Limit")
                {
                    Caption = 'Available Credit Limit';
                }
                field(bdeType; Rec."BDE Type")
                {
                    Caption = 'Relation Officer Type';
                }
                field(bankTransferMode; Rec."Bank Transfer Mode")
                {
                    Caption = 'Bank Transfer Mode';
                }
                field(batchNo; Rec."Batch No.")
                {
                    Caption = 'Batch No.';
                }
                field(crbRating; Rec."CRB Rating")
                {
                    Caption = 'CRB Rating';
                }
                field(crmApplicationNo; Rec."CRM Application No.")
                {
                    Caption = 'CRM Application No.';
                }
                // field(crmCapturedTime; Rec."CRM Captured Time")
                // {
                //     Caption = 'CRM Captured Time';
                // }
                field(crmCapturedBy; Rec."CRM Captured by")
                {
                    Caption = 'CRM Captured by';
                }
                field(crmCreated; Rec."CRM Created")
                {
                    Caption = 'CRM Created';
                }
                field(crmCreatedBy; Rec."CRM Created By")
                {
                    Caption = 'CRM Created By';
                }
                field(crmDate; Rec."CRM Date")
                {
                    Caption = 'CRM Date';
                }
                field(crmNoSeries; Rec."CRM No. Series")
                {
                    Caption = 'CRM No. Series';
                }
                field(crmNotes; Rec."CRM Notes")
                {
                    Caption = 'CRM Notes';
                }
                field(crmOriginatingBranch; Rec."CRM Originating Branch")
                {
                    Caption = 'CRM Originating Branch';
                }
                field(capturedBy; Rec."Captured By")
                {
                    Caption = 'Captured By';
                }
                field(clientAccountNo; Rec."Client Account No")
                {
                    Caption = 'Client Account No';
                }
                field(clientBankCode; Rec."Client Bank Code")
                {
                    Caption = 'Client Bank Code';
                }
                field(clientBankName; Rec."Client Bank Name")
                {
                    Caption = 'Client Bank Name';
                }
                field(commentForExemptions; Rec."Comment for Exemptions")
                {
                    Caption = 'Comment for Exemptions';
                }
                field(commercialApproval; Rec."Commercial Approval")
                {
                    Caption = 'Commercial Approval';
                }
                field(commercialBuyoff; Rec."Commercial Buyoff")
                {
                    Caption = 'Commercial Buyoff';
                }
                field(commercialSent; Rec."Commercial sent")
                {
                    Caption = 'Commercial sent';
                }
                field(computeInterestDueOnPostin; Rec."Compute Interest Due on Postin")
                {
                    Caption = 'Compute Interest Due on Postin';
                }
                field(costValueOfHouse; Rec."Cost Value of House")
                {
                    Caption = 'Cost Value of House';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(currencyFilter; Rec."Currency Filter")
                {
                    Caption = 'Currency Filter';
                }
                field(currentUser; Rec."Current User")
                {
                    Caption = 'Current User';
                }
                field(dailyInterest; Rec."Daily Interest")
                {
                    Caption = 'Daily Interest';
                }
                field(dateRescheduled; Rec."Date Rescheduled")
                {
                    Caption = 'Date Rescheduled';
                }
                field(daysInArrears; Rec."Days In Arrears")
                {
                    Caption = 'Days In Arrears';
                }
                field(defaulted; Rec.Defaulted)
                {
                    Caption = 'Defaulted';
                }
                field(demandLetterDate; Rec."Demand Letter Date")
                {
                    Caption = 'Demand Letter Date';
                }
                field(demandLetterStatus; Rec."Demand Letter Status")
                {
                    Caption = 'Demand Letter Status';
                }
                field(detailsVerifiedBy; Rec."Details Verified By")
                {
                    Caption = 'Details Verified By';
                }
                field(disbursementAccountNo; Rec."Disbursement Account No")
                {
                    Caption = 'Disbursement Account No';
                }
                field(disbursementDate; Rec."Disbursement Date")
                {
                    Caption = 'Disbursement Date';
                }
                field(disbursementDestination; Rec."Disbursement Destination")
                {
                    Caption = 'Disbursement Destination';
                }
                field(disbursementPriority; Rec."Disbursement Priority")
                {
                    Caption = 'Disbursement Priority';
                }
                field(discountedAmount; Rec."Discounted Amount")
                {
                    Caption = 'Discounted Amount';
                }
                field(discountedLoanNo; Rec."Discounted Loan No.")
                {
                    Caption = 'Discounted Loan No.';
                }
                field(domesticInsuranceCover; Rec."Domestic Insurance Cover")
                {
                    Caption = 'Domestic Insurance Cover';
                }
                field(domesticInsuranceCoverNo; Rec."Domestic Insurance Cover No")
                {
                    Caption = 'Domestic Insurance Cover No';
                }
                field(drawdownSchedule; Rec."Drawdown Schedule")
                {
                    Caption = 'Drawdown Schedule';
                }
                field(dummyAppraisal; Rec."Dummy Appraisal")
                {
                    Caption = 'Dummy Appraisal';
                }
                field(employerBalance; Rec."Employer Balance")
                {
                    Caption = 'Employer Balance';
                }
                field(employerCode; Rec."Employer Code")
                {
                    Caption = 'Employer Code';
                }
                field(employerIntroductionLetter; Rec."Employer Introduction Letter")
                {
                    Caption = 'Employer Introduction Letter';
                }
                field(employerLoanNo; Rec."Employer Loan No.")
                {
                    Caption = 'Employer Loan No.';
                }
                field(expectedDateOfCompletion; Rec."Expected Date of Completion")
                {
                    Caption = 'Expected Date of Completion';
                }
                field(externalSTOAmount; Rec."External STO  Amount")
                {
                    Caption = 'External STO  Amount';
                }
                field(externalSTOEffectiveDate; Rec."External STO Effective Date")
                {
                    Caption = 'External STO Effective Date';
                }
                field(fosaBalanceLCY; Rec."Fosa Balance (LCY)")
                {
                    Caption = 'Balance (LCY)';
                }
                field(fullyDisbursed; Rec."Fully Disbursed")
                {
                    Caption = 'Fully Disbursed';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                }
                field(gracePeriod; Rec."Grace Period")
                {
                    Caption = 'Grace Period';
                }
                field(holdOneMonthInstallment; Rec."Hold Installment(s)")
                {
                    Caption = 'Hold One Month Installment';
                }
                field(idNo; Rec."ID No.")
                {
                    Caption = 'ID No.';
                }
                field(idNoSL; Rec."ID No.SL")
                {
                    Caption = 'ID No.SL';
                }
                field(injuryBenefitInsurance; Rec."Injury Benefit Insurance")
                {
                    Caption = 'Injury Benefit Insurance';
                }
                field(installmentPeriod; Rec."Installment Period")
                {
                    Caption = 'Installment Period';
                }
                field(installments; Rec.Installments)
                {
                    Caption = 'Installments';
                }
                field(installmentsFallOff; Rec."Installments FallOff")
                {
                    Caption = 'Installments FallOff';
                }
                field(interest; Rec.Interest)
                {
                    Caption = 'Interest';
                }
                field(interestCalculationMethod; Rec."Interest Calculation Method")
                {
                    Caption = 'Interest Calculation Method';
                }
                field(interestPaid; Rec."Interest Paid")
                {
                    Caption = 'Interest Paid';
                }
                field(kraPIN; Rec."KRA PIN")
                {
                    Caption = 'KRA PIN';
                }
                field(kraPINCopy; Rec."KRA PIN Copy")
                {
                    Caption = 'KRA PIN Copy';
                }
                field(kraPINNoSL; Rec."KRA PIN No.SL")
                {
                    Caption = 'KRA PIN No.SL';
                }
                field(landValuationDone; Rec."Land Valuation Done")
                {
                    Caption = 'Land Valuation Done';
                }
                field(lastAdviceDate; Rec."Last Advice Date")
                {
                    Caption = 'Last Advice Date';
                }
                field(lastMobileLoanRemDate; Rec."Last Mobile Loan Rem. Date")
                {
                    Caption = 'Last Mobile Loan Rem. Date';
                }
                field(lastPayDate; Rec."Last Pay Date")
                {
                    Caption = 'Last Pay Date';
                }
                field(lastRepaymentDate; Rec."Last Repayment Date")
                {
                    Caption = 'Last Repayment Date';
                }
                field(leaseNoSL; Rec."Lease No SL")
                {
                    Caption = 'Lease No SL';
                }
                field(loanAccount; Rec."Loan Account")
                {
                    Caption = 'Loan Account';
                }
                field(loanAmount; Rec."Loan Amount")
                {
                    Caption = 'Loan Amount';
                }
                field(loanApplFormNo; Rec."Loan Appl.form No.")
                {
                    Caption = 'Loan Appl.form No.';
                }
                field(loanAppraisedBy; Rec."Loan Appraised By")
                {
                    Caption = 'Loan Appraised By';
                }
                field(loanBDE; Rec."Relation Officer")
                {
                    Caption = 'Relation Officer';
                }
                field(loanBDEPaid; Rec."Loan BDE Paid")
                {
                    Caption = 'Loan BDE Paid';
                }
                field(loanBalanceAtRescheduling; Rec."Loan Balance at Rescheduling")
                {
                    Caption = 'Loan Balance at Rescheduling';
                }
                field(loanCycle; Rec."Loan Cycle")
                {
                    Caption = 'Loan Cycle';
                }
                field(loanDefferalReason; Rec."Loan Defferal Reason")
                {
                    Caption = 'Loan Defferal Reason';
                }
                field(loanExceptions; Rec."Loan Exceptions")
                {
                    Caption = 'Loan Exceptions';
                }
                field(loanInterestRepayment; Rec."Loan Interest Repayment")
                {
                    Caption = 'Loan Interest Repayment';
                }
                field(loanLinkingNo; Rec."Loan Linking No.")
                {
                    Caption = 'Loan Linking No.';
                }
                field(loanNo; Rec."Loan No.")
                {
                    Caption = 'Loan No.';
                }
                field(loanPrincipleRepayment; Rec."Loan Principle Repayment")
                {
                    Caption = 'Loan Principle Repayment';
                }
                field(loanProductType; Rec."Loan Product Type")
                {
                    Caption = 'Loan Product Type';
                }
                field(loanProductTypeName; Rec."Loan Product Type Name")
                {
                    Caption = 'Loan Product Type Name';
                }
                field(loanRecoveryNo; Rec."Loan Recovery No.")
                {
                    Caption = 'Loan Recovery No.';
                }
                field(loanRejectionReason; Rec."Loan Rejection Reason")
                {
                    Caption = 'Loan Rejection Reason';
                }
                field(loanRescheduled; Rec."Loan Rescheduled")
                {
                    Caption = 'Loan Rescheduled';
                }
                field(loanSpan; Rec."Loan Span")
                {
                    Caption = 'Loan Span';
                }
                field(loanTransferred; Rec."Loan Transferred")
                {
                    Caption = 'Loan Transferred';
                }
                field(loansDepositPurchase; Rec."Loans - Deposit Purchase")
                {
                    Caption = 'Loans - Deposit Purchase';
                }
                field(loansCategorySASRA; Rec."Loans Category-SASRA")
                {
                    Caption = 'Loans Category-SASRA';
                }
                field(mainSector; Rec."Main Sector")
                {
                    Caption = 'Main Sector';
                }
                field(mainSectorDescription; Rec."Main Sector Description")
                {
                    Caption = 'Main Sector Description';
                }
                field(markForListing; Rec."Mark For Listing")
                {
                    Caption = 'Mark For Listing';
                }
                field(maxInstallments; Rec."Max. Installments")
                {
                    Caption = 'Max. Installments';
                }
                field(maxLoanAmount; Rec."Max. Loan Amount")
                {
                    Caption = 'Max. Loan Amount';
                }
                field(maximumLimit; Rec."Maximum Limit")
                {
                    Caption = 'Maximum Limit';
                }
                field(memberAge; Rec."Member Age")
                {
                    Caption = 'Member Age';
                }
                field(memberCategory; Rec."Member Class")
                {
                    Caption = 'Member Category';
                }
                field(memberDeposits; Rec."Member Deposits")
                {
                    Caption = 'Member Deposits';
                }
                field(memberName; Rec."Member Name")
                {
                    Caption = 'Member Name';
                }
                field(memberNo; Rec."Member No.")
                {
                    Caption = 'Member No.';
                }
                field(memberSegment; Rec."Member Segment")
                {
                    Caption = 'Member Segment';
                }
                field(mobileLoan; Rec."Mobile Loan")
                {
                    Caption = 'Mobile Loan';
                }
                field(mobileLoanReminder; Rec."Mobile Loan Reminder")
                {
                    Caption = 'Mobile Loan Reminder';
                }
                field(modeOfDisbursement; Rec."Mode of Disbursement")
                {
                    Caption = 'Mode of Disbursement';
                }
                field(moratoriumEndDate; Rec."Moratorium End date")
                {
                    Caption = 'Moratorium End date';
                }
                field(moratoriumLoan; Rec."Moratorium Loan")
                {
                    Caption = 'Moratorium Loan';
                }
                field(moratoriumStartDate; Rec."Moratorium Start Date")
                {
                    Caption = 'Moratorium Start Date';
                }
                field(mortgageInsuranceAmount; Rec."Mortgage Insurance Amount")
                {
                    Caption = 'Mortgage Insurance Amount';
                }
                field(mortgageLoan; Rec."Mortgage Loan")
                {
                    Caption = 'Mortgage Loan';
                }
                field(mortgageProtectionPolicy; Rec."Mortgage Protection Policy")
                {
                    Caption = 'Mortgage Protection Policy';
                }
                field(mortgageProtectionPolicyNo; Rec."Mortgage Protection Policy No")
                {
                    Caption = 'Mortgage Protection Policy No';
                }
                field(mwalimuSmartCallbackURL; Rec."Mwalimu Smart Callback URL")
                {
                    Caption = 'Mwalimu Smart Callback URL';
                }
                field(nationalID; Rec."National ID")
                {
                    Caption = 'National ID';
                }
                field(netAmount; Rec."Net Amount")
                {
                    Caption = 'Net Amount';
                }
                field(newGracePeriod; Rec."New Grace Period")
                {
                    Caption = 'New Grace Period';
                }
                field(newInstallmentPeriod; Rec."New Installment Period")
                {
                    Caption = 'New Installment Period';
                }
                field(newInterestRate; Rec."New Interest Rate")
                {
                    Caption = 'New Interest Rate';
                }
                field(newNoOfInstallment; Rec."New No. of Installment")
                {
                    Caption = 'New No. of Installment';
                }
                field(nextPenaltyDate; Rec."Next Penalty Date")
                {
                    Caption = 'Next Penalty Date';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(nonPerformanceAlert; Rec."Non Performance Alert")
                {
                    Caption = 'Non Performance Alert';
                }
                field(outstandingBalance; Rec."Outstanding Balance")
                {
                    Caption = 'Outstanding Balance';
                }
                field(outstandingBills; Rec."Outstanding Bills")
                {
                    Caption = 'Outstanding Bills';
                }
                field(outstandingInterest; Rec."Outstanding Interest")
                {
                    Caption = 'Outstanding Interest';
                }
                field(overrideLoanQualification; Rec."Override Loan Qualification")
                {
                    Caption = 'Override Loan Qualification';
                }
                field(penaltyCharge; Rec."Penalty Charge")
                {
                    Caption = 'Penalty Charge';
                }
                field(penaltyFrequency; Rec."Penalty Frequency")
                {
                    Caption = 'Penalty Frequency';
                }
                field(pickedMobileLoan; Rec."Picked Mobile Loan")
                {
                    Caption = 'Picked Mobile Loan';
                }
                field(posted; Rec.Posted)
                {
                    Caption = 'Posted';
                }
                field(postedBy; Rec."Posted By")
                {
                    Caption = 'Posted By';
                }
                field(principlePaid; Rec."Principle Paid")
                {
                    Caption = 'Principle Paid';
                }
                field(propertyCostValue; Rec."Property Cost Value")
                {
                    Caption = 'Property Cost Value';
                }
                field(prorataAmount; Rec."Prorata Amount")
                {
                    Caption = 'Prorata Amount';
                }
                field(purposeOfLoan; Rec."Purpose of Loan")
                {
                    Caption = 'Purpose of Loan';
                }
                field(recommendedAmount; Rec."Recommended Amount")
                {
                    Caption = 'Recommended Amount';
                }
                field(recoverShareCapital; Rec."Recover ShareCapital")
                {
                    Caption = 'Recover ShareCapital';
                }
                field(recoveredLoan; Rec."Recovered Loan")
                {
                    Caption = 'Recovered Loan';
                }
                field(recoveryCreteria; Rec."Recovery Creteria")
                {
                    Caption = 'Recovery Creteria';
                }
                field(recoveryLevel; Rec."Recovery Level")
                {
                    Caption = 'Recovery Level';
                }
                field(recoveryMode; Rec."Recovery Mode")
                {
                    Caption = 'Recovery Mode';
                }
                field(recoveryPriority; Rec."Recovery Priority")
                {
                    Caption = 'Recovery Priority';
                }
                field(recoveryProduct; Rec."Recovery Product")
                {
                    Caption = 'Recovery Product';
                }
                field(rejectedBy; Rec."Rejected By")
                {
                    Caption = 'Rejected By';
                }
                field(relationshipManager; Rec."Relationship Manager")
                {
                    Caption = 'Relationship Manager';
                }
                field(remarks; Rec.Remarks)
                {
                    Caption = 'Remarks';
                }
                field(repayment; Rec.Repayment)
                {
                    Caption = 'Repayment';
                }
                field(repaymentAlert; Rec."Repayment Alert")
                {
                    Caption = 'Repayment Alert';
                }
                field(repaymentFrequency; Rec."Repayment Frequency")
                {
                    Caption = 'Repayment Frequency';
                }
                field(repaymentMethodAlert; Rec."Repayment Method Alert")
                {
                    Caption = 'Repayment Method Alert';
                }
                field(repaymentStartDate; Rec."Repayment Start Date")
                {
                    Caption = 'Repayment Start Date';
                }
                field(requestedAmount; Rec."Requested Amount")
                {
                    Caption = 'Requested Amount';
                }
                field(rescheduleBy; Rec."Reschedule by")
                {
                    Caption = 'Reschedule by';
                }
                field(responsibilityCenter; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                }
                field(responsibilityCentre; Rec."Responsibility Centre")
                {
                    Caption = 'Responsibility Centre';
                }
                field(responsibleOfficer; Rec."Responsible Officer")
                {
                    Caption = 'Responsible Officer';
                }
                field(retirementExpiryDate; Rec."Retirement/Expiry Date")
                {
                    Caption = 'Retirement/Expiry Date';
                }
                field(sadNo; Rec."SAD No.")
                {
                    Caption = 'SAD No.';
                }
                field(smsSent; Rec."SMS Sent")
                {
                    Caption = 'SMS Sent';
                }
                field(saleAgreement; Rec."Sale Agreement")
                {
                    Caption = 'Sale Agreement';
                }
                field(salesAgent; Rec."Sales Agent")
                {
                    Caption = 'Sales Agent';
                }
                field(selfGuarantee; Rec."Self Guarantee")
                {
                    Caption = 'Self Guarantee';
                }
                field(sentOnline; Rec."Sent Online")
                {
                    Caption = 'Sent Online';
                }
                field(shareBoostedAmount; Rec."Share Boosted Amount")
                {
                    Caption = 'Share Boosted Amount';
                }
                field(sixMonthsBankStatement; Rec."Six Months Bank Statement")
                {
                    Caption = 'Six Months Bank Statement';
                }
                field(source; Rec.Source)
                {
                    Caption = 'Source';
                }
                field(sourceAplication; Rec."Source Aplication")
                {
                    Caption = 'Source Aplication';
                }
                field(sourceUnit; Rec."Source Unit")
                {
                    Caption = 'Source Unit';
                }
                field(staffNo; Rec."Staff No")
                {
                    Caption = 'Staff No';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(subSectorLevel1; Rec."Sub Sector Level1")
                {
                    Caption = 'Sub Sector Level1';
                }
                field(subSectorLevel1Description; Rec."Sub Sector Level1 Description")
                {
                    Caption = 'Sub Sector Level1 Description';
                }
                field(subSectorLevel2; Rec."Sub Sector Level2")
                {
                    Caption = 'Sub Sector Level2';
                }
                field(subSectorLevel2Description; Rec."Sub Sector Level2 Description")
                {
                    Caption = 'Sub Sector Level2 Description';
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
                field(threeMonthsPayslip; Rec."Three Months Payslip")
                {
                    Caption = 'Three Months Payslip';
                }
                field(titleDeed; Rec."Title Deed")
                {
                    Caption = 'Title Deed';
                }
                field(titleLeaseProvideSL; Rec."Title Lease Provide SL")
                {
                    Caption = 'Title Lease Provide SL';
                }
                field(titleLeaseNo; Rec."Title/Lease No")
                {
                    Caption = 'Title/Lease No';
                }
                field(titleLeaseProvided; Rec."Title/Lease Provided")
                {
                    Caption = 'Title/Lease Provided';
                }
                field(totalBalance; Rec."Total Balance")
                {
                    Caption = 'Total Balance';
                }
                field(totalChargesAndCommissions; Rec."Total Charges and Commissions")
                {
                    Caption = 'Total Charges and Commissions';
                }
                field(totalDisbursed; Rec."Total Disbursed")
                {
                    Caption = 'Total Disbursed';
                }
                field(totalLoanBalance; Rec."Total Loan Balance")
                {
                    Caption = 'Total Loan Balance';
                }
                field(totalTopUp; Rec."Total TopUp")
                {
                    Caption = 'Total TopUp';
                }
                field(tpayApproved; Rec."Tpay Approved")
                {
                    Caption = 'Tpay Approved';
                }
                field(variatedAmount; Rec."Variated Amount")
                {
                    Caption = 'Variated Amount';
                }
                field(vendorLetterSaleAgreement; Rec."Vendor Letter/Sale Agreement")
                {
                    Caption = 'Vendor Letter/Sale Agreement';
                }
                field(workTime; Rec.WorkTime)
                {
                    Caption = 'WorkTime';
                }
            }
        }
    }
}
