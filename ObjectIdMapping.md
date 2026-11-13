# Object ID Mapping

All AzimaCBS object IDs were moved into the range **50000-99999** (`app.json` -> `idRanges`).

**Rule:** `new = old - 52100000`, i.e. the leading `521` is dropped: `52185700 -> 85700`.
It applies to every ID in 52185423-52187422 whatever the object type, so a bare number in code
(`RecRef.Open(...)`, `"Table ID" = CONST(...)`, `dataitem(X; ...)`) maps the same way as the declaration.
Objects already in 50100-50149 keep their IDs.

| Old range | New range |
|---|---|
| 50100 - 50149 | 50100 - 50149 (unchanged) |
| 52185423 - 52187422 | 85423 - 87422 |

## Summary

| Object type | Renumbered | Unchanged |
|---|---:|---:|
| Table | 1003 | 0 |
| Table Extension | 51 | 0 |
| Page | 1556 | 0 |
| Page Extension | 1566 | 0 |
| Report | 921 | 2 |
| Report Extension | 1 | 0 |
| Codeunit | 119 | 1 |
| Query | 42 | 0 |
| XmlPort | 157 | 0 |
| Enum | 66 | 0 |
| Enum Extension | 10 | 2 |
| **Total** | **5492** | **5** |

Also updated: 359 numeric ID references in code, 3 table-extension field IDs, and 16 Word layouts (see below).

File names were **not** renamed, so most still show the old ID. Find a file by its old ID, then look it up here.

## Table (1003)

```text
52185423 -> 85423   Asset Transfer Line
52185424 -> 85424   Bulk ATM Application
52185425 -> 85425   Loan Closure Line
52185426 -> 85426   Pictures and Signtures+
52185427 -> 85427   Loan Schedule Error Log
52185428 -> 85428   Resignation
52185429 -> 85429   Procurement Cue Table
52185430 -> 85430   Loan Appraisal History
52185431 -> 85431   Sub Classes
52185432 -> 85432   ATM Nos
52185433 -> 85433   Audit Trail
52185434 -> 85434   Online Tokenssas
52185435 -> 85435   Online Special Requests
52185436 -> 85436   Member Card Printing Log
52185437 -> 85437   Pictures and Signtures
52185438 -> 85438   Security Valuers
52185439 -> 85439   Appeals Table
52185440 -> 85440   Digit Custodian Setup
52185441 -> 85441   Loan Appraisal Comments
52185442 -> 85442   Sky PIN Reset Buffer
52185443 -> 85443   Actual Loan Shedule
52185444 -> 85444   Loan Clearance Lines
52185445 -> 85445   Online Loan Guarantorsssss
52185446 -> 85446   Blocked Employers
52185447 -> 85447   Shares Market
52185448 -> 85448   Shares Bid
52185449 -> 85449   Shares Successful
52185450 -> 85450   Online Transactionss
52185451 -> 85451   Perfection File Action
52185452 -> 85452   E-Channels Cue Table
52185453 -> 85453   Contract Request
52185454 -> 85454   Document Attachment Table
52185455 -> 85455   Perfection Lines
52185456 -> 85456   Sub Contracts
52185457 -> 85457   Insurance Claims
52185458 -> 85458   Coop ATM  Setup
52185459 -> 85459   Dormancy Log
52185460 -> 85460   Coop Transaction Codes
52185461 -> 85461   Coop ATM Charges
52185462 -> 85462   Mpesa Manual Upload
52185463 -> 85463   Sky Services
52185464 -> 85464   Sky Services Change Logs
52185465 -> 85465   Gaming Paybills Setup
52185466 -> 85466   Mobile Loan Installments
52185467 -> 85467   User Access Request Lines
52185468 -> 85468   SkyTempBlob
52185469 -> 85469   Sky Email Update Buffer
52185470 -> 85470   Vehicle Types
52185471 -> 85471   Sky Mobile Setup
52185472 -> 85472   IT System Setup
52185473 -> 85473   Dividend Header
52185474 -> 85474   Product Supported Classes
52185475 -> 85475   Sky Safcom Corporate Charges
52185476 -> 85476   Sky USSD Auth
52185477 -> 85477   Sky PIN Change Log
52185478 -> 85478   Sky SMS Messages
52185479 -> 85479   Virtual Member Reg Buffer
52185480 -> 85480   Virtual Member Reg Images
52185481 -> 85481   Sky Mobile Loan Appraisal
52185482 -> 85482   Loan Product Availability
52185483 -> 85483   Contract Templates
52185484 -> 85484   HR Department Target Line
52185485 -> 85485   Sky Agency Companies
52185486 -> 85486   Sales Route Plans
52185487 -> 85487   Sky Agents Transactions
52185488 -> 85488   Sky Search Options
52185489 -> 85489   Sky Agent Withdrawals Buffer
52185490 -> 85490   Sky Agency Devices
52185491 -> 85491   Sky New Members Buffer
52185492 -> 85492   Sky Agency Setup
52185493 -> 85493   Sky Agent Transfer
52185494 -> 85494   Sales Route Lines
52185495 -> 85495   Password History
52185496 -> 85496   HR Department Targets Header
52185497 -> 85497   Purchase Quote Vendor
52185498 -> 85498   Sales Leads Lines
52185499 -> 85499   Sky Virtual Member
52185500 -> 85500   Sky Business Accounts
52185501 -> 85501   Dividend Slip Years Buffer
52185502 -> 85502   Sky Insurance
52185503 -> 85503   Sky Mortgage
52185504 -> 85504   HR Appraisal Discussion Log
52185505 -> 85505   Mobile Transaction Types
52185506 -> 85506   Sky Portal Transactions
52185507 -> 85507   HR Job Responsiblities
52185508 -> 85508   HR Jobs
52185509 -> 85509   HR Job Requirements
52185510 -> 85510   HR Job Occupations
52185511 -> 85511   HR Job Qualifications
52185512 -> 85512   HR Job Applications
52185513 -> 85513   HR Employee Target Assignment
52185514 -> 85514   HR Appraisal Ledger Entries
52185515 -> 85515   HR Appraisal Period
52185516 -> 85516   HR Company Targets Header
52185517 -> 85517   HR Succession Job Rotation
52185518 -> 85518   HR Employee Kin
52185519 -> 85519   HR Employee Requisitions
52185520 -> 85520   HR Employee Qualifications
52185521 -> 85521   HR Employee Exit Interviews
52185522 -> 85522   HR Employee SIC Numbers
52185523 -> 85523   HR Employee Course Comp.
52185524 -> 85524   HR Employee Attachments
52185525 -> 85525   HR Employee Grievance
52185526 -> 85526   HR Individual Target Line
52185527 -> 85527   HR Company Target Line
52185528 -> 85528   HR Employee Course of Study
52185529 -> 85529   HR Employees Supervisees
52185530 -> 85530   HR Notification Log
52185531 -> 85531   HR Leave Types
52185532 -> 85532   HR Leave Application
52185533 -> 85533   HR Leave Journal Template
52185534 -> 85534   HR Leave Journal Batch
52185535 -> 85535   HR Leave Periods
52185536 -> 85536   HR Leave Register
52185537 -> 85537   HR Leave Ledger Entries
52185538 -> 85538   HR Leave Attachments
52185539 -> 85539   HR Leave Family Groups
52185540 -> 85540   HR Leave Family Employees
52185541 -> 85541   HR Leave Reimbursement
52185542 -> 85542   HR Leave Planner Header
52185543 -> 85543   HR Leave Planner Lines
52185544 -> 85544   HR Leave Journal Line
52185545 -> 85545   HR Applicant Qualifications
52185546 -> 85546   HR Applicant Referees
52185547 -> 85547   Mobile Transaction Types Lines
52185548 -> 85548   HR Shortlisted Applicants
52185549 -> 85549   HR E-Mail Parameters
52185550 -> 85550   HR Setup
52185551 -> 85551   HR Leave Calendar
52185552 -> 85552   HR Lookup Values
52185553 -> 85553   HR Leave Calendar Lines
52185554 -> 85554   HR Non Working Days & Dates
52185555 -> 85555   HR Commitee Members
52185556 -> 85556   HR Committees
52185557 -> 85557   HR Policies
52185558 -> 85558   HR Company Attachments
52185559 -> 85559   HR Training Need Request
52185560 -> 85560   HR Leave Recall Lines
52185561 -> 85561   HR OSAccident
52185562 -> 85562   HR OSAccident Line
52185563 -> 85563   HR OSMeasure Line
52185564 -> 85564   Mobile Loan Exceptions
52185565 -> 85565   HR OSSafety Rules
52185566 -> 85566   Survey Logs
52185567 -> 85567   Trigger Survey Setup
52185568 -> 85568   HR Disciplinary Cases
52185569 -> 85569   HR Transport Allocation Lines
52185570 -> 85570   HR Transport Allocations Head
52185571 -> 85571   HR Transport Requisition Head
52185572 -> 85572   Vendor SubCategories
52185573 -> 85573   HR Succession Training Needs
52185574 -> 85574   Guarantor Notice Letters
52185575 -> 85575   HR Disciplinary Actions
52185576 -> 85576   HR Employee Transfer Header
52185577 -> 85577   HR Employee Transfer Lines
52185578 -> 85578   Portfolio Manager
52185579 -> 85579   CEO Cue
52185580 -> 85580   HR Training App Header
52185581 -> 85581   HR Training Needs
52185582 -> 85582   HR Training Cost
52185583 -> 85583   HR Training App Lines
52185584 -> 85584   HR Training Bonding Conditions
52185585 -> 85585   HR Exit Training Bonding
52185586 -> 85586   HR Individual Targets Header
52185587 -> 85587   HR Medical Schemes
52185588 -> 85588   HR Medical Scheme Members
52185589 -> 85589   HR Medical Claims
52185590 -> 85590   HR Jobs to Succeed
52185591 -> 85591   HR Employee Confirmation
52185592 -> 85592   HR Promo. Recommend Header
52185593 -> 85593   HR Promo. Recommend Lines
52185594 -> 85594   HR Professional body Header
52185595 -> 85595   HR Professional Bodies Lines
52185596 -> 85596   HR Appraissal Appeal
52185597 -> 85597   HR Medical Overexpenditure
52185598 -> 85598   HR Succession Employee
52185599 -> 85599   HR Succession Comments
52185600 -> 85600   HR Employee Qualification Gaps
52185601 -> 85601   HR Position Forecasting Header
52185602 -> 85602   HR Appraisal Header
52185603 -> 85603   HR Appraisal Lines
52185604 -> 85604   HR Appraisal Eval Areas
52185605 -> 85605   HR Appraisal Company Target
52185606 -> 85606   HR Perspectives Setup
52185607 -> 85607   prNHIF
52185608 -> 85608   prPAYE
52185609 -> 85609   PR Bank Branches
52185610 -> 85610   PR Bank Accounts
52185611 -> 85611   HR Interns
52185612 -> 85612   HR Interns Requisition
52185613 -> 85613   PR Payroll Periods
52185614 -> 85614   PR Transaction Codes
52185615 -> 85615   prInsurancePolicies
52185616 -> 85616   prEmployee Banks
52185617 -> 85617   prBank SFI
52185618 -> 85618   prBank Transfer Figures
52185619 -> 85619   prEmployee Cost Centers
52185620 -> 85620   prSalary Arrears
52185621 -> 85621   prStatutory Exemptions
52185622 -> 85622   prUnused Relief
52185623 -> 85623   PR Employee Transactions
52185624 -> 85624   PR Period Transactions
52185625 -> 85625   PR Employee P9 Info
52185626 -> 85626   prEmployer Deductions
52185627 -> 85627   prJournal Headers
52185628 -> 85628   prJournal Details
52185629 -> 85629   prJournal Analyzers
52185630 -> 85630   prJournal Trans Mapping
52185631 -> 85631   prCurrency Denominations
52185632 -> 85632   Marketing Teams Header
52185633 -> 85633   prEmployee Motor Vehicles
52185634 -> 85634   prHousing Scheme
52185635 -> 85635   prPayroll Type
52185636 -> 85636   PR Vital Setup Info
52185637 -> 85637   PR Salary Card
52185638 -> 85638   Missing-39004001
52185639 -> 85639   prFormula Results
52185640 -> 85640   prStaff Dimensions
52185641 -> 85641   prTimeSheets
52185642 -> 85642   prMembership Groups
52185643 -> 85643   prInstitutional Membership
52185644 -> 85644   prPeriodLumpSummedItems
52185645 -> 85645   prEmployeeRepeatingTx
52185646 -> 85646   prEmployee Posting Group
52185647 -> 85647   Global Bulk SMS Filter
52185648 -> 85648   Control Summary Buffer
52185649 -> 85649   prEmployee Trans IMP BAL
52185650 -> 85650   HR Employees
52185651 -> 85651   Control-Information
52185652 -> 85652   Salary Grades
52185653 -> 85653   prPension Details
52185654 -> 85654   Monthly Reconcilliation
52185655 -> 85655   Payroll Variations
52185656 -> 85656   Salary Notch
52185657 -> 85657   Salary Step/Notch Transactions
52185658 -> 85658   prPayroll Variations
52185659 -> 85659   prAssignEmployeeLoan
52185660 -> 85660   HR Lateness Ledger
52185661 -> 85661   prNet Pay
52185662 -> 85662   prEmployee Banks Temp
52185663 -> 85663   PrOtherSetups
52185664 -> 85664   prLatenessLedger
52185665 -> 85665   HR SMS CC Recipient Buffer
52185666 -> 85666   prTax Law
52185667 -> 85667   PrMonthly Variance
52185668 -> 85668   prNSSF Tiers
52185669 -> 85669   HR Leave Reliver
52185670 -> 85670   Leave Allowances
52185671 -> 85671   PR Employee Allowances
52185672 -> 85672   HR Leave Planner Drill
52185673 -> 85673   HR CEO Goals Header
52185674 -> 85674   prSalary Advance
52185675 -> 85675   HR Staff Loan Typesw
52185676 -> 85676   Staff Loan Types
52185677 -> 85677   prSalary Card Casual
52185678 -> 85678   PrCasual Payroll Setup
52185679 -> 85679   HR Appraisal Learning & Growth
52185680 -> 85680   HR Appraisal Financial
52185681 -> 85681   Dividends Provision Header
52185682 -> 85682   Checkoff  Receipt Transactions
52185683 -> 85683   Checkoff  Receipt Trans Lines
52185684 -> 85684   Tariff Codes
52185685 -> 85685   Loan Charges
52185686 -> 85686   EDMS
52185687 -> 85687   Status Change Permissions.
52185688 -> 85688   Credit Nos. Series
52185689 -> 85689   General Set-Up
52185690 -> 85690   Product Factory
52185691 -> 85691   Member Application
52185692 -> 85692   Next of KIN Application
52185693 -> 85693   Relationship Types
52185694 -> 85694   Segment/County/Dividend/Signat
52185695 -> 85695   Savings Account Registration
52185696 -> 85696   Mobile loan App. Buffer
52185697 -> 85697   Signatory Application
52185698 -> 85698   Financial Appraisal setup
52185699 -> 85699   Business Loan Appraisal
52185700 -> 85700   Members
52185701 -> 85701   Next of KIN
52185702 -> 85702   Image Data
52185703 -> 85703   Account Signatories
52185704 -> 85704   Savings Account Application
52185705 -> 85705   Fixed Deposit Type
52185706 -> 85706   FD Interest Calculation Rules
52185707 -> 85707   Fixed Deposit Notification Lis
52185708 -> 85708   Dividend SetUp
52185709 -> 85709   SASRA Categorization
52185710 -> 85710   Dividend Simulation Header
52185711 -> 85711   Dividend Simulation Lines
52185712 -> 85712   Dividend Instructions - Member
52185713 -> 85713   Dividend Progression
52185714 -> 85714   Dividend Posting Buffer
52185715 -> 85715   RTGS Transfer Header
52185716 -> 85716   RTGS Transfer Lines
52185717 -> 85717   Standing Order Header
52185718 -> 85718   Standing Order Lines
52185719 -> 85719   Standing Order Register
52185720 -> 85720   Bank Code Structure
52185721 -> 85721   FingerPrint Authentication
52185722 -> 85722   Standing Order Control
52185723 -> 85723   Member Classes
52185724 -> 85724   Application Document Setup
52185725 -> 85725   Product Documents
52185726 -> 85726   Application Documents
52185727 -> 85727   Member Documents
52185728 -> 85728   Loan Required Documents
52185729 -> 85729   Loans
52185730 -> 85730   Savings Accounts
52185731 -> 85731   Credit Accounts
52185732 -> 85732   Savings Ledger Entry
52185733 -> 85733   Credit Ledger Entry
52185734 -> 85734   Loan Product Charges
52185735 -> 85735   Schedule of Loan Payment
52185736 -> 85736   Loan Disbursement Header
52185737 -> 85737   Loan Disbursement Lines
52185738 -> 85738   Ideal Repayment Schedule
52185739 -> 85739   Loan Guarantors and Security
52185740 -> 85740   Collateral
52185741 -> 85741   Interest Buffer
52185742 -> 85742   Loans Top up
52185743 -> 85743   Other Commitements Clearance
52185744 -> 85744   Appraisal Salary Details
52185745 -> 85745   Appraisal Salary Set-up
52185746 -> 85746   Loan Collateral
52185747 -> 85747   Loan Application Credit Score
52185748 -> 85748   Loan Product Parameters
52185749 -> 85749   Collateral Types Ratings
52185750 -> 85750   Related Product
52185751 -> 85751   Partial Disbursement Schedule
52185752 -> 85752   Account Access Log
52185753 -> 85753   Dependancies Applications
52185754 -> 85754   Admin Bookings Planner
52185755 -> 85755   HR CEO Goal HOD Assignment
52185756 -> 85756   M-SACCO Paybill Keywords
52185757 -> 85757   M-SACCO Applications
52185758 -> 85758   M-SACCO Application Details
52185759 -> 85759   M-PESA Transactions
52185760 -> 85760   M-SACCO Withdrawal Limits
52185761 -> 85761   M-SACCO Loans
52185762 -> 85762   M-SACCO Other Services
52185763 -> 85763   M-SACCO Virtual Registrations
52185764 -> 85764   Welfare Advance
52185765 -> 85765   Bulk SMS Header
52185766 -> 85766   Bulk SMS Lines
52185767 -> 85767   M-SACCO Guarantors
52185768 -> 85768   M-SACCO Change PIN No
52185769 -> 85769   HR CEO Goal Line
52185770 -> 85770   M-SACCO Transactions
52185771 -> 85771   Notification Subscription
52185772 -> 85772   M-SACCO Account Setup
52185773 -> 85773   Transaction Types
52185774 -> 85774   Transaction Charges
52185775 -> 85775   Cheque Types
52185776 -> 85776   Cashier Transactions
52185777 -> 85777   Tiered Charges Lines
52185778 -> 85778   Treasury Cashier Transactions
52185779 -> 85779   Coinage
52185780 -> 85780   Denominations
52185781 -> 85781   Banking No Setup
52185782 -> 85782   Banking User Template
52185783 -> 85783   Salary Header
52185784 -> 85784   Salary Lines
52185785 -> 85785   Cheque Book Application
52185786 -> 85786   Cheque Issue Lines
52185787 -> 85787   Cheque Receipts
52185788 -> 85788   Cheques Register
52185789 -> 85789   Cheque Return Codes
52185790 -> 85790   Inward file Buffer
52185791 -> 85791   Refference Number
52185792 -> 85792   Cheque Set Up
52185793 -> 85793   Bankers Cheque Application
52185794 -> 85794   Bankers Cheques Register
52185795 -> 85795   Over Draft Authorisation
52185796 -> 85796   Cashier Transaction Lines
52185797 -> 85797   Account Transfer Header
52185798 -> 85798   Account Transfer Source
52185799 -> 85799   Account Transfer Destination
52185800 -> 85800   Tiered Charges Header
52185801 -> 85801   Delegate Groups
52185802 -> 85802   Disabilities
52185803 -> 85803   Salutation Tittles
52185804 -> 85804   Delegate Groups Application
52185805 -> 85805   Branch Treasury Accounts
52185806 -> 85806   Main Treasury Account
52185807 -> 85807   Investment Header
52185808 -> 85808   Investment Type
52185809 -> 85809   Investment Lines
52185810 -> 85810   Fixed Deposit History
52185811 -> 85811   Loan FIle Upload
52185812 -> 85812   HR CEO Setup
52185813 -> 85813   Data Translation
52185814 -> 85814   File Requests
52185815 -> 85815   Collective Asset Insurance
52185816 -> 85816   Loan Linking Line
52185817 -> 85817   Loan Linking
52185818 -> 85818   Checkoff Advice Line
52185819 -> 85819   Checkoff Header
52185820 -> 85820   Checkoff Lines
52185821 -> 85821   Checkoff Buffer
52185822 -> 85822   Checkoff Advice Header
52185823 -> 85823   Loan Rescheduling
52185824 -> 85824   Membership Closure
52185825 -> 85825   Account Closure Line
52185826 -> 85826   Member withdrawal Notice
52185827 -> 85827   Loan Guarantors Sub
52185828 -> 85828   Guarantors Substitution
52185829 -> 85829   Loan Recovery Header
52185830 -> 85830   Email Status
52185831 -> 85831   SMS Setup
52185832 -> 85832   SMS Series
52185833 -> 85833   SMS Account Subscription
52185834 -> 85834   SMS Codes
52185835 -> 85835   Bond
52185836 -> 85836   Bond Setup
52185837 -> 85837   Bond Company
52185838 -> 85838   Bond Security
52185839 -> 85839   Loan History
52185840 -> 85840   Securities Register
52185841 -> 85841   Loan Securities Set-up
52185842 -> 85842   ATM Linking Applications
52185843 -> 85843   Securities Collection Register
52185844 -> 85844   ATM Linking  Statistics
52185845 -> 85845   Savings Interest Header
52185846 -> 85846   Savings Interest Buffer
52185847 -> 85847   End Year Transfer Header
52185848 -> 85848   End Year Interest Buffer
52185849 -> 85849   Buffer table
52185850 -> 85850   ATM Applications
52185851 -> 85851   ATM Card Types
52185852 -> 85852   BBF Entitlement
52185853 -> 85853   BBF Claim Lines
52185854 -> 85854   Suspended Interest Accounts
52185855 -> 85855   CRM Application
52185856 -> 85856   Bank Transfer Modes
52185857 -> 85857   HR Email Notification Log
52185858 -> 85858   Daily Loans Interest Buffer
52185859 -> 85859   Loans Interest
52185860 -> 85860   Interest Header
52185861 -> 85861   Interest Due Period
52185862 -> 85862   Marketing Teams Lines
52185863 -> 85863   Social Listening Sites App.
52185864 -> 85864   Social Listening Sites
52185865 -> 85865   Farmer Purchase Broker Setup
52185866 -> 85866   Budgetary Control Setup
52185867 -> 85867   Committment
52185868 -> 85868   Store Requistion Header
52185869 -> 85869   Store Requistion Lines
52185870 -> 85870   Procurement Limit Code
52185871 -> 85871   Travel Destination
52185872 -> 85872   Destination Rate Entry
52185873 -> 85873   Cash Office User Template
52185874 -> 85874   Receipts and Payment Types
52185875 -> 85875   Cash Payments Header
52185876 -> 85876   Tariff Code s
52185877 -> 85877   Receipt Line
52185878 -> 85878   Payment Line
52185879 -> 85879   Imprest Details-User
52185880 -> 85880   Cash Payment Line
52185881 -> 85881   InterBank Transfers
52185882 -> 85882   Bank Slip
52185883 -> 85883   Bank Slip Line
52185884 -> 85884   Payment Mode Charges
52185885 -> 85885   Imprest Surrender Header
52185886 -> 85886   Imprest Surrender Details
52185887 -> 85887   Cash Office Setup
52185888 -> 85888   Payments Header
52185889 -> 85889   Receipts Header
52185890 -> 85890   Expense Code
52185891 -> 85891   Imprest Details
52185892 -> 85892   Asset Transfer
52185893 -> 85893   Temp Dimension
52185894 -> 85894   Payment Line Board
52185895 -> 85895   Payments Header Board
52185896 -> 85896   Payment Line Temp
52185897 -> 85897   HR Email Template
52185898 -> 85898   Payment Line Delegate
52185899 -> 85899   Procurement Methods
52185900 -> 85900   Procurement Method Stages
52185901 -> 85901   W/P Budget Buffer
52185902 -> 85902   HR Email Template Variables
52185903 -> 85903   User Document Cancellation
52185904 -> 85904   Document Cancellation Users
52185905 -> 85905   Responsibility CenterBR
52185906 -> 85906   Staff Allowance Setup
52185907 -> 85907   Staff Members
52185908 -> 85908   Staff Allowance Grades
52185909 -> 85909   Imprest Header
52185910 -> 85910   Imprest Lines
52185911 -> 85911   Value Posting
52185912 -> 85912   Staff Claims Header
52185913 -> 85913   Staff Claim Lines
52185914 -> 85914   Staff Advance Header
52185915 -> 85915   Staff Advance Lines
52185916 -> 85916   Staff Advance Surrender Header
52185917 -> 85917   Staff Advanc Surrender Details
52185918 -> 85918   Staff Allowance P9
52185919 -> 85919   Funds Management Cue
52185920 -> 85920   Central Payment
52185921 -> 85921   HR SMS Notification Log
52185922 -> 85922   Vote Transfer
52185923 -> 85923   Staff Allowance Lines
52185924 -> 85924   Payment Line Staff
52185925 -> 85925   HR SMS Template
52185926 -> 85926   Purchase Quote Header
52185927 -> 85927   Purchase Quote Line
52185928 -> 85928   Quote Specifications
52185929 -> 85929   HR SMS Template Variables
52185930 -> 85930   Quotation Request Vendors
52185931 -> 85931   Purchase Committments
52185932 -> 85932   Purchase Quote Params
52185933 -> 85933   Order/Req Buffer
52185934 -> 85934   Approval Entry Archive
52185935 -> 85935   Bid Analysis
52185936 -> 85936   Overtime Claim Header
52185937 -> 85937   Overtime Claim Lines
52185938 -> 85938   FA WIP Suggest Lines
52185939 -> 85939   Contract Cycle
52185940 -> 85940   SinkFund Report Information
52185941 -> 85941   Maintain Machne/Vehicles
52185942 -> 85942   Contracts
52185943 -> 85943   Milestones
52185944 -> 85944   Nature Of Sevices
52185945 -> 85945   Contract Documents
52185946 -> 85946   Contract Lines Types
52185947 -> 85947   Contract Cyclee
52185948 -> 85948   Contract Cycle Stage
52185949 -> 85949   Contract Expectation Details
52185950 -> 85950   Contract Expectations
52185951 -> 85951   Contract Stage Activities
52185952 -> 85952   All Stages Per Contract
52185953 -> 85953   Contract Line
52185954 -> 85954   Global SMS Template
52185955 -> 85955   Global SMS Template History
52185956 -> 85956   Global SMS Token Registry
52185957 -> 85957   Legal
52185958 -> 85958   Damages
52185959 -> 85959   Advocate
52185960 -> 85960   Legal Line
52185961 -> 85961   Witnesses
52185962 -> 85962   Verdict
52185963 -> 85963   Case Cost List
52185964 -> 85964   Surety Management
52185965 -> 85965   Cases Noitification
52185966 -> 85966   HR Employee Change Log
52185967 -> 85967   TestTable
52185968 -> 85968   Performance Attributes
52185969 -> 85969   Attributes
52185970 -> 85970   HRDisciplinary Appeal
52185971 -> 85971   HRDisciplinary Case Withdrawal
52185972 -> 85972   Bank Acc. Statement Line
52185973 -> 85973   Applied Bank Account Ledger2
52185974 -> 85974   Posted Bank Acc. Recon Line
52185975 -> 85975   HR Service Management Header
52185976 -> 85976   HR Drivers
52185977 -> 85977   HR Service Management Lines
52185978 -> 85978   HR Fuel Management Header
52185979 -> 85979   HR Fuel Management Lines
52185980 -> 85980   Item Budget Dimension
52185981 -> 85981   SMS Template Token Usage
52185982 -> 85982   Global Bulk SMS Header
52185983 -> 85983   Jobs-Setup
52185984 -> 85984   Global Bulk SMS Line
52185985 -> 85985   Global Bulk SMS Token Map
52185986 -> 85986   Workplan Dimension
52185987 -> 85987   Employer Loan Eligibility
52185989 -> 85989   Procur. Plan Budget Allocation
52185990 -> 85990   Temp Budget Alloc Purch
52185991 -> 85991   Temp Budget Alloc Sale
52185992 -> 85992   Temp Budget Alloc G/L
52185995 -> 85995   Test2016
52185996 -> 85996   Stages
52185997 -> 85997   Agent Applications..
52185998 -> 85998   Update Agent Application
52185999 -> 85999   Unit Setup Charges
52186000 -> 86000   BOSA Account Activation
52186001 -> 86001   Contract Files
52186002 -> 86002   Charges
52186003 -> 86003   Floor
52186004 -> 86004   General Setup
52186005 -> 86005   Property Details
52186006 -> 86006   Property Charges
52186007 -> 86007   Unit
52186008 -> 86008   Lease
52186009 -> 86009   Lease Line
52186010 -> 86010   Lease Charge Review
52186011 -> 86011   Lease Bill Lines
52186013 -> 86013   Landlord Commision Calc Lines
52186014 -> 86014   Files Table
52186015 -> 86015   Water Billing rate
52186016 -> 86016   Caretaker
52186018 -> 86018   Defined SLA
52186022 -> 86022   Disposal Lines
52186023 -> 86023   Floor Codes
52186024 -> 86024   Bills Batch
52186025 -> 86025   Leases Billed
52186031 -> 86031   Lease Line Invoices
52186032 -> 86032   Leases Billed New
52186033 -> 86033   Property Expense List
52186034 -> 86034   Zones
52186035 -> 86035   Payment Schedule
52186036 -> 86036   Sms SPV Buffer
52186037 -> 86037   Salary Agreement
52186038 -> 86038   Salary Agreement Counter
52186039 -> 86039   Permission Requisition
52186040 -> 86040   Permission Requisition Lines
52186041 -> 86041   Systems Affected
52186042 -> 86042   Computer Asset Register
52186043 -> 86043   Reason For Request
52186044 -> 86044   Asset Register Setup
52186045 -> 86045   ATM Charges
52186046 -> 86046   ATM Alerts
52186047 -> 86047   Hexa Binary
52186048 -> 86048   ISO-Defined Data Elements
52186049 -> 86049   POS Commissions
52186050 -> 86050   ATM Transactions 2
52186051 -> 86051   ATM Log Entries
52186052 -> 86052   Online Special Request
52186054 -> 86054   Online Loan Guarantors
52186055 -> 86055   Salary Thru FOSA Update
52186056 -> 86056   Delegates Minutes Header
52186057 -> 86057   Delegates Meeting Attendees
52186058 -> 86058   Delegates Meeting Minutes
52186059 -> 86059   Region Delegates Tariff
52186060 -> 86060   Delegates Tariff
52186061 -> 86061   System Edit Reasons
52186062 -> 86062   Delegate Region
52186063 -> 86063   Delegate Members
52186064 -> 86064   Delegate Region Applicationss
52186065 -> 86065   Delegate Region Mem Retirement
52186066 -> 86066   Delegate Members Retirementss
52186067 -> 86067   Delegates Payment
52186068 -> 86068   Delegate Payment Line
52186069 -> 86069   Online Users
52186070 -> 86070   Online Tokens
52186071 -> 86071   Exceptions/ Rejection Reason
52186072 -> 86072   Loan Calculator
52186073 -> 86073   Loan Repayment Schedule-Calc
52186074 -> 86074   Delegate Region Change
52186075 -> 86075   Delegate AGM Retire Update
52186076 -> 86076   Delegate AGM Appoint Update
52186077 -> 86077   Delegate AGM Update Header
52186078 -> 86078   ADM Registration
52186079 -> 86079   Loanee Infomation Base
52186080 -> 86080   File Tracker
52186081 -> 86081   File Location
52186082 -> 86082   Movement Tracker
52186083 -> 86083   File Stations
52186084 -> 86084   File Remarks
52186085 -> 86085   File Movement Remarks
52186086 -> 86086   User Stations
52186087 -> 86087   Daily Mortgage Interest Buffer
52186088 -> 86088   Mortgage Loans Doc Register
52186089 -> 86089   Mortgage Loans Doc Release
52186090 -> 86090   DCS Parameter
52186091 -> 86091   DCS Parameter Matrix
52186092 -> 86092   DCS Customer Credit Score
52186093 -> 86093   DCS Parameter Range
52186094 -> 86094   VB Payment Option
52186095 -> 86095   Product Checklist
52186096 -> 86096   Loan Mandatory Requirements
52186097 -> 86097   Business Income
52186098 -> 86098   Loan Products to Bridge
52186099 -> 86099   Online Transactions
52186100 -> 86100   DCS CRB Data
52186101 -> 86101   DCS CRB Account Type
52186102 -> 86102   DCS Data Source
52186103 -> 86103   Agent Tariff Details
52186104 -> 86104   Agent Applications
52186105 -> 86105   Agent Transactions
52186106 -> 86106   Agent Tarriff Header
52186107 -> 86107   Agent Biometric Data
52186108 -> 86108   Agent Next Of Kin Details
52186109 -> 86109   Agent Group Schedule
52186110 -> 86110   Agent Error Messages
52186111 -> 86111   Virtual Registrations
52186112 -> 86112   Sectoral Classification
52186113 -> 86113   Agent Sent Sms
52186114 -> 86114   Agency Setup
52186115 -> 86115   Agent Transactions Charged
52186116 -> 86116   Electrol Zones/Area Svr Center
52186117 -> 86117   Product Factory Application
52186118 -> 86118   Related Product Application
52186119 -> 86119   Loan Product Charge Appl.
52186120 -> 86120   DCS Parameter Matrix Appl.
52186121 -> 86121   Product Application Documents
52186122 -> 86122   Payment Methods
52186123 -> 86123   Loan Purpose
52186124 -> 86124   Payment Methods Application
52186125 -> 86125   Account Associations
52186126 -> 86126   BBF Requisation Header
52186127 -> 86127   BBF Requisation Lines
52186130 -> 86130   BDE Management Buffer
52186132 -> 86132   Revenue Collection
52186133 -> 86133   M-SACCO SMS MessagesBackup
52186134 -> 86134   Promise Topay Lines
52186135 -> 86135   Checkoff Buffer Consolidation
52186136 -> 86136   Withdrawal Reason
52186137 -> 86137   PR Trans Codes Groups
52186138 -> 86138   DCS Loan Summary
52186139 -> 86139   Account Trans Summary
52186140 -> 86140   DCS Member Transaction
52186141 -> 86141   Loan Categorization
52186142 -> 86142   Email Update Requests
52186143 -> 86143   Asset Finance Loan
52186144 -> 86144   Statement Requests
52186145 -> 86145   HR Appraisal Journal Line
52186146 -> 86146   HR BSC Register
52186147 -> 86147   HR Employment History
52186148 -> 86148   HR Appraisal Journal Batch
52186149 -> 86149   HR Appraisal Journal Template
52186150 -> 86150   HR Interview Details
52186151 -> 86151   HR Job Interview
52186152 -> 86152   HR Hiring Criteria
52186153 -> 86153   HR Induction Schedule
52186154 -> 86154   HR Staff  Induction
52186155 -> 86155   HR Dept. Responsibilities
52186156 -> 86156   Journal Line Dimension
52186157 -> 86157   HR Company Activities
52186158 -> 86158   HR Activity Participants
52186159 -> 86159   HR Employee Separation
52186160 -> 86160   HR Shortlisting Panel
52186161 -> 86161   HR Officer Cue
52186162 -> 86162   HR Disciplinary Cases NCA
52186163 -> 86163   Company Vehicles
52186165 -> 86165   HR Manager Cue
52186166 -> 86166   HR Staff Loan Typess
52186167 -> 86167   HR Batches
52186168 -> 86168   HR Staff Loan Request
52186169 -> 86169   HR Car Loan Setup
52186170 -> 86170   Travelling Officers
52186171 -> 86171   HR Movement Tracker
52186172 -> 86172   HR File Movement Tracker
52186173 -> 86173   HR Loan Repayment Schedule
52186174 -> 86174   HR Overtime Header
52186175 -> 86175   HR Overtime Lines
52186176 -> 86176   HR Staff Loan Guarantors
52186177 -> 86177   HR Overtime Rates
52186178 -> 86178   PR Email Status
52186179 -> 86179   HR Overtime Ledger Entries
52186180 -> 86180   HR Employee Bank Accounts
52186181 -> 86181   HR Bank Summary
52186182 -> 86182   HR Employee Competence
52186183 -> 86183   Responsibility Center B
52186184 -> 86184   Comments
52186185 -> 86185   Master Record Creation Lines
52186186 -> 86186   Master Record Creation Header
52186187 -> 86187   HR Employee Login Management
52186188 -> 86188   HR Shift Management
52186189 -> 86189   HR Shift Schedule Header
52186190 -> 86190   HR Shift Schedule Lines
52186191 -> 86191   HR Shift Assignment
52186192 -> 86192   HR Heads of Departments
52186193 -> 86193   prBoard
52186194 -> 86194   PR Board Transactions
52186195 -> 86195   prBoard Payment Setup
52186196 -> 86196   Board members
52186197 -> 86197   prBoard Earnings
52186198 -> 86198   prBracket Tables
52186199 -> 86199   prBoard Deductions
52186200 -> 86200   prBoard Category
52186201 -> 86201   prBoard Salary Steps
52186202 -> 86202   PrBoard Loan Transactions
52186203 -> 86203   PR Board NPAY & PAYE
52186205 -> 86205   HR Training Feedback Form
52186206 -> 86206   Performance Attributes1
52186207 -> 86207   HR Medical Scheme Rates
52186208 -> 86208   CRB Data
52186209 -> 86209   AGM Delegates Payment
52186210 -> 86210   AGM Delegate Payment Line
52186211 -> 86211   Banking Account Closure
52186212 -> 86212   Update Employer Code
52186213 -> 86213   Journal Two
52186214 -> 86214   Property Category
52186215 -> 86215   Unit Type
52186216 -> 86216   Unit Sub Type
52186217 -> 86217   HR Approvals Set Up
52186218 -> 86218   HR Applicant Hobbies
52186219 -> 86219   File Volumes
52186220 -> 86220   Posting Times
52186221 -> 86221   Sky Transactions II
52186222 -> 86222   File Locations
52186223 -> 86223   Installments Tracker
52186224 -> 86224   BBF Entitlement SetUp
52186225 -> 86225   Delegates Monthly Returns
52186226 -> 86226   Delegates Returns Lines
52186227 -> 86227   Complain and Remarks
52186228 -> 86228   Sky Portal Setup
52186229 -> 86229   Portal Tiered Charges
52186230 -> 86230   Worker Table
52186231 -> 86231   Worker T 2
52186232 -> 86232   Complaint Categories
52186233 -> 86233   Portal Member App Handlers
52186234 -> 86234   Sky Mobile Tiered Lines
52186235 -> 86235   Reverse ATM Expired Trans
52186236 -> 86236   M-PESA Manual Upload
52186237 -> 86237   Portal Endpoints
52186238 -> 86238   Log Endpoint  Entiries
52186239 -> 86239   Electoral Zones
52186240 -> 86240   Delegate Officials
52186241 -> 86241   Meeting Types
52186242 -> 86242   Allowed Allowances
52186243 -> 86243   Board Payroll Deductions
52186244 -> 86244   Batch No Table
52186245 -> 86245   Batch Lines Table
52186246 -> 86246   Batching Process Table
52186247 -> 86247   File Sub Types
52186249 -> 86249   Clearance Lines
52186250 -> 86250   Final Dues
52186251 -> 86251   Risk External Payment
52186252 -> 86252   Admin Booking Calendar
52186253 -> 86253   Employee Transfer
52186254 -> 86254   Loans Daily Interest
52186255 -> 86255   Salary Grade Lines
52186256 -> 86256   HR Training Planner
52186257 -> 86257   Contract Templates Lines
52186258 -> 86258   Vendor Categories
52186259 -> 86259   Recruitment Costs
52186260 -> 86260   Credit Ledger Temp
52186261 -> 86261   Actual Loan Schedule
52186262 -> 86262   Member Sub-Status Tracker
52186263 -> 86263   ATM Repin Table
52186264 -> 86264   Monthly Contrib Logs
52186265 -> 86265   Deleg. Payment Withholding Tax
52186267 -> 86267   ATM Return Table
52186268 -> 86268   Mobile Banking Table
52186269 -> 86269   Credit Officers Cue Table
52186270 -> 86270   Excempted Product Charges
52186271 -> 86271   BBF/Nominee Register
52186272 -> 86272   Loan Ageing Table
52186273 -> 86273   Triggered Advice Line
52186274 -> 86274   Excel Data
52186275 -> 86275   NCBA Pension Buffer
52186276 -> 86276   Group Members Edit
52186277 -> 86277   Group Member Exit & Update
52186278 -> 86278   IPRS API Setup
52186279 -> 86279   Mobile Deposits Keywords Setup
52186280 -> 86280   Dividend Progression Import
52186281 -> 86281   Saving Interest Import Buffer
52186300 -> 86300   Banking Cue
52186322 -> 86322   Mobile Guarantors Setup
52186405 -> 86405   Stock Keeping
52186406 -> 86406   Stock Keeping Lines
52186446 -> 86446   DO Payment Card Type
52186447 -> 86447   DO Payment Connection Details
52186448 -> 86448   DO Payment Connection Setup
52186451 -> 86451   DO Payment Setup
52186500 -> 86500   CRM API Setup
52186501 -> 86501   CRB Trans Union API Setup
52186502 -> 86502   Sky M-Banking Trans. Buffer
52186504 -> 86504   EDMS API Setup
52186505 -> 86505   EDMS Files
52186506 -> 86506   Sky ATM Transactions Buffer
52186507 -> 86507   EDMS Scanned Apps. Log
52186508 -> 86508   Sky Background Process Manager
52186509 -> 86509   Sky Channels Loan Applications
52186510 -> 86510   CRM Originations Setup
52186511 -> 86511   Satellite Branches Setup
52186513 -> 86513   M-Smart API Setup
52186519 -> 86519   Sky Loan Guarantor Requests
52186520 -> 86520   Sky Guarantor Sub Applications
52186521 -> 86521   E-Channels Transaction Setup
52186523 -> 86523   Salary Lines P
52186524 -> 86524   Sky Guarantor Sub Requests
52186533 -> 86533   M-Smart Loan Corrections
52186540 -> 86540   Other Apprails products
52186543 -> 86543   M-Smart Documents Setup
52186544 -> 86544   M-Smart Documents
52186560 -> 86560   CRB DPI File Submissions
52186561 -> 86561   CRB Metropol API Setup
52186562 -> 86562   CRB Log Buffer
52186563 -> 86563   Sky Interest Log Buffer
52186564 -> 86564   Channel Application Documents
52186570 -> 86570   CRB Monthly ICE File Subm.
52186571 -> 86571   CRB Monthly NICE File Subm.
52186580 -> 86580   Mobile Loan Guarantors
52186599 -> 86599   BC API Logs
52186788 -> 86788   CF Station Actions
52186789 -> 86789   CF Tracker
52186790 -> 86790   Edits Helper
52186791 -> 86791   DMU SMS Templates
52186792 -> 86792   Promise Topay Header
52186793 -> 86793   PromiseTopay SMS Log
52186794 -> 86794   Loan Recovery Header II
52186795 -> 86795   Loan Recovery Lines II
52186796 -> 86796   Loan Reapotionment Lines II
52186797 -> 86797   Loan Reversal Lines II
52186798 -> 86798   Debt Collectors Staging
52186799 -> 86799   Debt Collectors Header
52186800 -> 86800   Debt Lines
52186801 -> 86801   Debt Lines Logs
52186810 -> 86810   OverDue Loans
52186811 -> 86811   Exit Clearance
52186812 -> 86812   Employee Group
52186830 -> 86830   NextofKin Payment Allocation
52186831 -> 86831   Overtime Need Request Lines
52186833 -> 86833   Account Activation
52186834 -> 86834   Member FactBox
52186840 -> 86840   Notification EmSms setup
52187001 -> 87001   User Tasks
52187002 -> 87002   Certificate Management
52187003 -> 87003   Present Users
52187004 -> 87004   Portfolio Manager Lines
52187005 -> 87005   Treasury Cheques Register
52187006 -> 87006   Treasury Cheque Application
52187007 -> 87007   Share Capital Transfer Buffer
52187008 -> 87008   52187008 Employer Product Attr
52187009 -> 87009   Member Form List
52187010 -> 87010   Moratorium Loan
52187011 -> 87011   Loans Interest Buffer
52187012 -> 87012   Target Employers
52187013 -> 87013   B/S Loan Account Application
52187014 -> 87014   One Month Installment
52187015 -> 87015   Business Loan Clossure
52187018 -> 87018   SMS Alerts Header
52187019 -> 87019   SMS Alerts Lines
52187020 -> 87020   Loan Reapotionment Lines
52187021 -> 87021   Loan Recovery Lines
52187022 -> 87022   DMU Case Forwarding
52187023 -> 87023   DMU Case Forwarding Lines
52187024 -> 87024   SMS Alerts Manager
52187025 -> 87025   Loan Reversal Lines
52187026 -> 87026   ATM Inventory
52187027 -> 87027   ATM Card Table
52187028 -> 87028   Alerts Loan Lines
52187029 -> 87029   Fixed Deposit Contract
52187030 -> 87030   Skipped Loans
52187031 -> 87031   Digital Signature
52187032 -> 87032   Clearance Form
52187033 -> 87033   General SMS Lines
52187034 -> 87034   General SMS Header
52187035 -> 87035   Business Types
52187036 -> 87036   MKey Forwarding
52187037 -> 87037   MKey Lines
52187040 -> 87040   Dispatch ATM Header
52187042 -> 87042   Investment Interest Lines
52187043 -> 87043   Investment Interest Header
52187044 -> 87044   ATM Card Storage
52187045 -> 87045   DMU Cue
52187050 -> 87050   Security Perfection
52187051 -> 87051   Nominee Legal
52187058 -> 87058   Vehicle Movement
52187059 -> 87059   Conference & Meeting Rooms-T
52187060 -> 87060   Parking Space
52187061 -> 87061   Motor Vehicle Request
52187062 -> 87062   Conf & Meeting Rooms List
52187063 -> 87063   Office Keys
52187064 -> 87064   Witheld Tax Obligations On PV
52187069 -> 87069   Member Prorata_Contractual Dep
52187070 -> 87070   User Creation Requests
52187071 -> 87071   User Termination
52187072 -> 87072   Loan Terms And Conditions
52187073 -> 87073   Share Capital Transfer Lines
52187074 -> 87074   System Edits
52187075 -> 87075   System Edits Filters
52187076 -> 87076   System Edits Fields
52187077 -> 87077   System Edits Tables
52187078 -> 87078   System Reversal
52187079 -> 87079   Staff Welfare
52187080 -> 87080   Dividend Provision
52187098 -> 87098   To Do
52187099 -> 87099   Loan Appraisal
52187100 -> 87100   CRM Member Edit
52187101 -> 87101   Bosa Salary Appraisal
52187102 -> 87102   Bosa Salary Appraisal Set-up
52187103 -> 87103   Loan Defferals
52187149 -> 87149   Sky Email Buffer
52187150 -> 87150   M-Smart Member Edit
52187151 -> 87151   Loan Listing Report List
52187152 -> 87152   Bulk Processing Errors
52187153 -> 87153   Loan FallOff
52187154 -> 87154   Deposit Listing
52187155 -> 87155   CRB Monthly Manual
52187156 -> 87156   CRB Daily Manual
52187157 -> 87157   Member Listing
52187160 -> 87160   Product SLA Setup
52187161 -> 87161   M-Banking Whitelist App
52187221 -> 87221   Legal Upcoming Matters
52187233 -> 87233   Nominee Form Request
52187260 -> 87260   Mobile Loan Restrictions
52187300 -> 87300   Loan Cue
52187301 -> 87301   Self Loan Application
52187334 -> 87334   PayrollCue
52187336 -> 87336   Payroll Activities Cue
52187340 -> 87340   Treasury Cue Table
52187341 -> 87341   Other Operations Cue Table
52187348 -> 87348   Appeal Lines Table
52187354 -> 87354   Security Discharge
52187360 -> 87360   Nominee Lines Table
52187364 -> 87364   Key Request Table
52187365 -> 87365   Accident Lines Table
52187366 -> 87366   Vehicle Servicing Table
52187369 -> 87369   Share Certificate Buffer
52187376 -> 87376   Parking List Table
52187389 -> 87389   Tenant Escalation Buffer
52187390 -> 87390   Guarantor Failure Reasons
52187401 -> 87401   Membership Activities Cue
52187402 -> 87402   Office Keys List
52187413 -> 87413   Refund,Account Transfer Header
52187414 -> 87414   Refund,Account Transfer lines
52187415 -> 87415   Fosa Payments Header
52187416 -> 87416   FOSA Payment Line
52187421 -> 87421   Product Variations
52187422 -> 87422   Admin Cue Table
```

## Table Extension (51)

```text
52185424 -> 85424   Sales Lines EXT
52185425 -> 85425   tableextension52185425
52185426 -> 85426   tableextension52185426
52185427 -> 85427   tableextension52185427
52185428 -> 85428   FA Reclass. Journal Line
52185429 -> 85429   Dimension Code Buffer Ext
52185430 -> 85430   Bank Deposit Header Extension
52185431 -> 85431   FA Class table Extension
52185432 -> 85432   FA Depreciation Book EXT
52186247 -> 86247   tableextension52186247
52186258 -> 86258   vendoraccount
52186401 -> 86401   tableextension52186401
52186402 -> 86402   G/L Account Ext
52186403 -> 86403   tableextension52186403
52186404 -> 86404   tableextension52186404
52186405 -> 86405   tableextension52186405
52186406 -> 86406   tableextension52186406
52186407 -> 86407   tableextension52186407
52186408 -> 86408   tableextension52186408
52186409 -> 86409   tableextension52186409
52186410 -> 86410   tableextension52186410
52186411 -> 86411   tableextension52186411
52186412 -> 86412   tableextension52186412
52186413 -> 86413   tableextension52186413
52186415 -> 86415   tableextension52186415
52186416 -> 86416   tableextension52186416
52186417 -> 86417   tableextension52186417
52186418 -> 86418   tableextension52186418
52186419 -> 86419   tableextension52186419
52186420 -> 86420   tableextension52186420
52186421 -> 86421   tableextension52186421
52186422 -> 86422   tableextension52186422
52186423 -> 86423   tableextension52186423
52186424 -> 86424   tableextension52186424
52186425 -> 86425   tableextension52186425
52186426 -> 86426   tableextension52186426
52186427 -> 86427   tableextension52186427
52186428 -> 86428   tableextension52186428
52186429 -> 86429   tableextension52186429
52186430 -> 86430   tableextension52186430
52186432 -> 86432   tableextension52186432
52186433 -> 86433   tableextension52186433
52186434 -> 86434   tableextension52186434
52186435 -> 86435   tableextension52186435
52186436 -> 86436   tableextension52186436
52186437 -> 86437   tableextension52186437
52186438 -> 86438   tableextension52186438
52186446 -> 86446   exitarticles
52186835 -> 86835   Error Messages TableEXT
52187236 -> 87236   tableextension52187236
52187341 -> 87341   Insurance
```

## Page (1556)

```text
52185423 -> 85423   Loan Closure Line
52185424 -> 85424   Deleg. Payment Withholding Tax
52185425 -> 85425   Revenue Collection List
52185426 -> 85426   Digit Custodian Setup
52185427 -> 85427   Loan Reappotionment List
52185428 -> 85428   Welfare Advance
52185429 -> 85429   User Access Request Subpage
52185430 -> 85430   Member Listing Report
52185431 -> 85431   Mbanking Registered Members
52185432 -> 85432   Sky Mbanking Changes List
52185433 -> 85433   Sky Mbanking Changes Card
52185434 -> 85434   Bulk Processing Errors List
52185435 -> 85435   Bulk Atm List
52185436 -> 85436   ATM Card Delink Reason
52185437 -> 85437   IT System Setup List
52185438 -> 85438   Error Messages Log
52185439 -> 85439   Mobile Loan Eligibility
52185440 -> 85440   Dividend Header List
52185441 -> 85441   Dividend Header Card
52185442 -> 85442   Product Supported Classes List
52185443 -> 85443   Sky Mobile Loans
52185444 -> 85444   Blocked Employers List
52185445 -> 85445   Loan Product Availability
52185446 -> 85446   Sky SMS Messages
52185447 -> 85447   Gaming Paybills Setup
52185448 -> 85448   HR Department Targets Card
52185449 -> 85449   CRB Daily Manual
52185450 -> 85450   Revenue Collection Card
52185451 -> 85451   Sky Mobile Loan Appraisal
52185452 -> 85452   Hr Leave Application List All
52185453 -> 85453   Loan Reversal List
52185454 -> 85454   Loan Topup ListPart
52185455 -> 85455   Loan Guarantors ListPart
52185456 -> 85456   Sky Agent Transactions
52185457 -> 85457   Sales Route Plan Card
52185458 -> 85458   Sales Routes Plan List
52185459 -> 85459   Loan Clearance Lines
52185460 -> 85460   Agent Withdrawals Buffer
52185461 -> 85461   CRB Monthly Manual List
52185462 -> 85462   Agency Setup Page
52185463 -> 85463   Global Bulk SMS Card
52185464 -> 85464   Sky Agent Transfer List
52185465 -> 85465   Agent Transfer Page
52185466 -> 85466   HR Department Targets List
52185467 -> 85467   Sales Leads Lines
52185468 -> 85468   Conference Room Booking Card
52185469 -> 85469   Created Sky Virtual Member
52185470 -> 85470   Sky Business Accounts
52185471 -> 85471   Created Sky Business Accounts
52185472 -> 85472   Mobile Transaction types List
52185473 -> 85473   Sky Portal Transactions
52185474 -> 85474   Approved Conf Rooms - Creation
52185475 -> 85475   Appr Created Conf Rooms - Card
52185476 -> 85476   Sms Messages Archive
52185477 -> 85477   Internet Banking Transactions
52185478 -> 85478   Rejected Conf Rooms - Creation
52185479 -> 85479   Rej. Conf Rooms Creation Card
52185480 -> 85480   Commission Setup
52185481 -> 85481   Sub Classes
52185482 -> 85482   Member Form List
52185483 -> 85483   CRMGuarantors
52185484 -> 85484   Appraisal Loans List
52185485 -> 85485   Closed Conf Rooms - Creation L
52185486 -> 85486   Mortgage Requisition List
52185487 -> 85487   Actioned Mortgage
52185488 -> 85488   Mortgage Card
52185489 -> 85489   Insurance Requisition List
52185490 -> 85490   Insurance Actioned List
52185491 -> 85491   Sky Insurance Card
52185492 -> 85492   Loan FIle Upload
52185493 -> 85493   Sky Checkoff Advice
52185494 -> 85494   Funds Management Activity
52185495 -> 85495   Banking Activities
52185496 -> 85496   Procurement Cue Page
52185497 -> 85497   Treasury Cue Page
52185498 -> 85498   Treasury RC
52185499 -> 85499   E-Channels Role Center
52185500 -> 85500   Main Role Center
52185501 -> 85501   E-Channels Cue
52185502 -> 85502   Debt Management Unit
52185503 -> 85503   Department Target Lines
52185504 -> 85504   Payment Lists
52185505 -> 85505   HRHOD Department Targets
52185506 -> 85506   ATM Transaction Types Card
52185507 -> 85507   Approved Loans List
52185508 -> 85508   HR Job Applicants QualifiedL1
52185509 -> 85509   HR Job Occupants
52185510 -> 85510   HR Jobs Card
52185511 -> 85511   HR Job Responsiblities Lines
52185512 -> 85512   HR Job Applications Factbox
52185513 -> 85513   HR Jobs Factbox
52185514 -> 85514   HR Job Requirements
52185515 -> 85515   HR Job Responsibilities
52185516 -> 85516   HR Job Qualifications
52185517 -> 85517   HR Jobs List
52185518 -> 85518   HR Job Requirement Lines
52185519 -> 85519   HR Promotion Recommend List
52185520 -> 85520   HR Professional Bodies List
52185521 -> 85521   HR Job Requirement Lines(RO)
52185522 -> 85522   HR Appraisal Discussion Log
52185523 -> 85523   Survey Logs
52185524 -> 85524   Closed Conf Rooms - Creation C
52185525 -> 85525   Trigger Survey Setup
52185526 -> 85526   HR Employee ReqsListApproved1
52185527 -> 85527   Closed HR Exit Interview list1
52185528 -> 85528   HR Job Applications List
52185529 -> 85529   HR Job Applications Card
52185530 -> 85530   HR Employee List - New1
52185531 -> 85531   Deffered Conf Rooms Creation L
52185532 -> 85532   HR Proffesional Body Members
52185533 -> 85533   Deffered Conf Rooms Creation C
52185534 -> 85534   HR Employee Kin SF
52185535 -> 85535   HR Employee Requisition Card
52185536 -> 85536   HR Employee Requisitions List
52185537 -> 85537   Misc. Article Information List
52185538 -> 85538   Active Vehicles Card
52185539 -> 85539   Approved Appeals
52185540 -> 85540   HR Employee Qualification Line
52185541 -> 85541   HR Disciplinary Appeal List
52185542 -> 85542   Approved Appeals Card
52185543 -> 85543   HR Disciplinary Appeal Card
52185544 -> 85544   HR E-Mail Parameters List
52185545 -> 85545   HR Employee Grievance Card
52185546 -> 85546   HR Employee Grievance List
52185547 -> 85547   Rejected Appeals List
52185548 -> 85548   Global Bulk SMS Filter List
52185549 -> 85549   Nominee Request Form List
52185550 -> 85550   Nominee Form Request Card
52185551 -> 85551   HR Leave Journal Lines
52185552 -> 85552   HR Leave Types1
52185553 -> 85553   HR Leave Types Card
52185554 -> 85554   HR Leave Batches
52185555 -> 85555   HR Leave Application Card
52185556 -> 85556   HR Leave Jnl. Template List
52185557 -> 85557   HR Leave Ledger Entries
52185558 -> 85558   HR Leave Applications Factbox
52185559 -> 85559   HR Leave Applications List1
52185560 -> 85560   Perfection File Actions
52185561 -> 85561   Contract Request Card
52185562 -> 85562   Contract Request List
52185563 -> 85563   Custom Document Attach Factbox
52185564 -> 85564   HR Leave Reimbursment Card
52185565 -> 85565   HR Leave Reimbursment List1
52185566 -> 85566   HR Leave Applications History1
52185567 -> 85567   Loan Collaterals
52185568 -> 85568   Hr Leave Planner Lines
52185569 -> 85569   HR Leave Planner Card
52185570 -> 85570   HR Leave Planner List
52185571 -> 85571   HR Leave Period List
52185572 -> 85572   HR Applicant Qualifications
52185573 -> 85573   HR Applicant Referees
52185574 -> 85574   HR Applicant Hobbies
52185575 -> 85575   Perfection Lines
52185576 -> 85576   Assets Transfer Line
52185577 -> 85577   Sub Contract
52185578 -> 85578   Insurance Claims - List
52185579 -> 85579   Insurance Claims - Card
52185580 -> 85580   Mobile Transaction Types Card
52185581 -> 85581   Mobile Transaction types Lines
52185582 -> 85582   HR Disciplinary Actions1
52185583 -> 85583   Admin Booking Planner
52185584 -> 85584   Purchase Quote Vendors
52185585 -> 85585   HR Shortlisting List1
52185586 -> 85586   HR Shortlisting Card
52185587 -> 85587   HR Shortlisting Lines
52185588 -> 85588   HR Perspective Setup Card
52185589 -> 85589   HR Applicants UnQualified Card
52185590 -> 85590   HR Applicants UnQualified L1
52185591 -> 85591   HR E-Mail Parameters Card
52185592 -> 85592   HR Setup
52185593 -> 85593   HR Lookup Values List
52185594 -> 85594   HR Lookup Values Card
52185595 -> 85595   HR Leave Calendar Card
52185596 -> 85596   HR Non Working Days & Dates
52185597 -> 85597   HR Leave Calendar Lines
52185598 -> 85598   HR Committees
52185599 -> 85599   HR Commitee Members
52185600 -> 85600   Savings Variations
52185601 -> 85601   Savings Variations List
52185602 -> 85602   HR Perspective Setup List
52185603 -> 85603   HR OSAccident List
52185604 -> 85604   HR OSAccident Card
52185605 -> 85605   Member Form Lines
52185606 -> 85606   HR OSMeasure Line
52185607 -> 85607   File Request List
52185608 -> 85608   HR Employee List-Pending App1
52185609 -> 85609   File Request Card
52185610 -> 85610   prP.A.Y.E Setup
52185611 -> 85611   PR Bank Accounts
52185612 -> 85612   PR Payroll Periods
52185613 -> 85613   PR Bank Branches
52185614 -> 85614   HR Leave Recall Lines
52185615 -> 85615   PR Salary Information
52185616 -> 85616   PR Employee Transactions
52185617 -> 85617   prSalary Arrears
52185618 -> 85618   prEmployee Banks
52185619 -> 85619   prStaff Dimensions
52185620 -> 85620   Employee P9 Info
52185621 -> 85621   prEmployee Posting Group
52185622 -> 85622   prJournal Mapping
52185623 -> 85623   prPayroll Period
52185624 -> 85624   prMembership Groups
52185625 -> 85625   prInstitutional Membership
52185626 -> 85626   prInsurance Policies
52185627 -> 85627   PR Transaction Code Card
52185628 -> 85628   PR Rates & Ceilings
52185629 -> 85629   prPeriodTransaction List
52185630 -> 85630   Control-Information
52185631 -> 85631   HR Employee Card
52185632 -> 85632   prPayroll Type
52185633 -> 85633   Salary Grades
52185634 -> 85634   Salary Grades List
52185635 -> 85635   Pension Contribution Details
52185636 -> 85636   HR Employee Target Assgns List
52185637 -> 85637   prSalaryArrears
52185638 -> 85638   Payroll Changes Requested
52185639 -> 85639   Payroll Changes Requested Appr
52185640 -> 85640   prEmployer Deductions
52185641 -> 85641   Salary Notches
52185642 -> 85642   Salary Step/Notch Transactions
52185643 -> 85643   HR Employee Target Assgn Card
52185644 -> 85644   HR Employee Target Assignments
52185645 -> 85645   HR Notification Log
52185646 -> 85646   HR Training Need Request Card
52185647 -> 85647   HR Training Need Request List
52185648 -> 85648   PR Transaction Codes List
52185649 -> 85649   Collective Asset Insurance
52185650 -> 85650   prRates & Ceilings List
52185651 -> 85651   Training Need Requests - All
52185652 -> 85652   Mobile Loan Exceptions
52185653 -> 85653   Supervisor Appraisals List
52185654 -> 85654   Commission Setup Card
52185655 -> 85655   My Individual Appraisals List
52185656 -> 85656   Vendor SubCategories List
52185657 -> 85657   CEO Activities
52185658 -> 85658   Temporary Staff List
52185659 -> 85659   PR Salary List (ALL)
52185660 -> 85660   PR Header Salary Card - ALL
52185661 -> 85661   HR Employee List - Active
52185662 -> 85662   prOtherSetups
52185663 -> 85663   prLatenessLedger
52185664 -> 85664   HR Employees Factbox
52185665 -> 85665   HR Employee List - InActive
52185666 -> 85666   HR SMS CC Recipients
52185667 -> 85667   Global SMS Template Card
52185668 -> 85668   prNSSF List
52185669 -> 85669   prNHIF SetUp
52185670 -> 85670   Test Page
52185671 -> 85671   HR Leave Reliver
52185672 -> 85672   HR Leave Planner Lines Drill
52185673 -> 85673   prTransaction Code
52185674 -> 85674   prSalary Advance
52185675 -> 85675   prSalary Advance List
52185676 -> 85676   Staff Loan Types
52185677 -> 85677   Loan Type List
52185678 -> 85678   SMS Subscription List
52185679 -> 85679   SMS Series
52185680 -> 85680   SMS Setup
52185681 -> 85681   SMS Account Subscription
52185682 -> 85682   SMS Codes
52185683 -> 85683   Bond Card
52185684 -> 85684   Bond List
52185685 -> 85685   Bond Security List
52185686 -> 85686   Bond Setup
52185687 -> 85687   Bond Beneficiary Companies
52185688 -> 85688   +Checkoff Advice Header List
52185689 -> 85689   Checkoff Header Posted
52185690 -> 85690   Payslip Email Status
52185691 -> 85691   ATM Charge List
52185692 -> 85692   Agent Applications List
52185693 -> 85693   Agent Application Card
52185694 -> 85694   Approved Agents List
52185695 -> 85695   Clearance List
52185696 -> 85696   Agent Transactions
52185697 -> 85697   Agent Tarriff Header
52185698 -> 85698   Agent Tarriff Details
52185699 -> 85699   Virtual Registrations List
52185700 -> 85700   Virtual Registrations Card
52185701 -> 85701   Virtual Registration Fact Box
52185702 -> 85702   Checkoff Receipt Transactions
52185703 -> 85703   Checkoff Receipt Trans List
52185704 -> 85704   Checkoff Receipt Trans Lines
52185705 -> 85705   Posted Checkoff  Receipt List
52185706 -> 85706   Tariff Codes
52185707 -> 85707   EDMS
52185708 -> 85708   Account  Picture & Signature
52185709 -> 85709   Member Nos. Series
52185710 -> 85710   HR Employees ListPart
52185711 -> 85711   Product Factory List
52185712 -> 85712   Product Factory
52185713 -> 85713   Open Member Application List
52185714 -> 85714   Member Application Single
52185715 -> 85715   Member Application Group List
52185716 -> 85716   Member Application Group
52185717 -> 85717   Next of KIN Application
52185718 -> 85718   Relationship Types
52185719 -> 85719   Signatories Application
52185720 -> 85720   Signatories Application Card
52185721 -> 85721   Savings Account Registration
52185722 -> 85722   Member App Picture & Signature
52185723 -> 85723   Segment/County/Dividend/Signat
52185724 -> 85724   Bank Code Structure
52185725 -> 85725   Member Single List
52185726 -> 85726   Member Single
52185727 -> 85727   Member Group List
52185728 -> 85728   Member Group
52185729 -> 85729   Next of KIN
52185730 -> 85730   Member Picture & Signature
52185731 -> 85731   Dividend Setup
52185732 -> 85732   Dividend Simulation Header
52185733 -> 85733   Dividend Simulation Lines
52185734 -> 85734   Dividend Instructions - Member
52185735 -> 85735   Dividend Progression
52185736 -> 85736   Dividend Posting Buffer
52185737 -> 85737   Savings Account Application
52185738 -> 85738   Savings Acc. Application Card
52185739 -> 85739   Fixed Deposit Type List
52185740 -> 85740   Fixed Deposit Type
52185741 -> 85741   FD Interest Calculation
52185742 -> 85742   Fixed Deposit Notification Lis
52185743 -> 85743   CEO Role Center
52185744 -> 85744   Savings Account Card
52185745 -> 85745   Standing Order List
52185746 -> 85746   Standing Order
52185747 -> 85747   Standing Order Lines
52185748 -> 85748   Standing Order Register List
52185749 -> 85749   RTGS Transfer List
52185750 -> 85750   RTGS Transfer Header
52185751 -> 85751   RTGS Transfer Lines
52185752 -> 85752   Loans List
52185753 -> 85753   Loan Application Card
52185754 -> 85754   Savings Ledger Entries
52185755 -> 85755   Credit Ledger Entries
52185756 -> 85756   Loan Application List
52185757 -> 85757   Loan Charges
52185758 -> 85758   Loan Product Charges
52185759 -> 85759   Loan Payment Schedule
52185760 -> 85760   Loan Disbursement Header
52185761 -> 85761   Loan Guarantors and Security
52185762 -> 85762   Member Collaterals
52185763 -> 85763   Member List
52185764 -> 85764   Loan Top Up
52185765 -> 85765   Other Commitments Clearance
52185766 -> 85766   Loan Disbursement Lines
52185767 -> 85767   Loan Disbursement List
52185768 -> 85768   Loan Posted List
52185769 -> 85769   Loans Posted
52185770 -> 85770   Appraisal Salary Details
52185771 -> 85771   Appraisal Salary Set-up
52185772 -> 85772   Loan Collaterals1
52185773 -> 85773   Loan Appraisal Parameters
52185774 -> 85774   Loan Product Appraisal
52185775 -> 85775   Loan Appraisal Score
52185776 -> 85776   Related Product List
52185777 -> 85777   Savings  Ledg. Entr. Preview
52185778 -> 85778   Dividends Provision List
52185779 -> 85779   Dividends Provision
52185780 -> 85780   MBanking Change MPESA PIN No
52185781 -> 85781   HR CEO Goals Card
52185782 -> 85782   HR CEO Goals List
52185783 -> 85783   Loans Factbox
52185784 -> 85784   Loan appraisal forms
52185785 -> 85785   Change MPESA PIN List
52185786 -> 85786   Mpesa Transactions List
52185787 -> 85787   MBanking Loans
52185788 -> 85788   MBanking Virtual Registrations
52185789 -> 85789   Mpesa Applications List
52185790 -> 85790   Securities Register - List
52185791 -> 85791   Bulk SMS Header List
52185792 -> 85792   HR CEO Goal HOD Assignments
52185793 -> 85793   SMS Subscriptions
52185794 -> 85794   Cashier Transactions
52185795 -> 85795   Transactions Type
52185796 -> 85796   Transaction Charges
52185797 -> 85797   Tiered Charges Lines
52185798 -> 85798   Cheque Types
52185799 -> 85799   Cashier Transactions List
52185800 -> 85800   Denominations
52185801 -> 85801   Coinage
52185802 -> 85802   Transaction Types List
52185803 -> 85803   Banking No Setup
52185804 -> 85804   Treasury Cashier Transactions
52185805 -> 85805   Treasury Cashier List
52185806 -> 85806   Banking User Setup
52185807 -> 85807   Salary Lists
52185808 -> 85808   Salary Header
52185809 -> 85809   Salary Lines
52185810 -> 85810   Cheque Application
52185811 -> 85811   Cheque Receipts Header
52185812 -> 85812   Cheque Receipt Lines
52185813 -> 85813   Cheque Book Application List
52185814 -> 85814   Cheque Receipts List
52185815 -> 85815   Cheque Register List
52185816 -> 85816   Bankers Cheque Application
52185817 -> 85817   Bankers Application List
52185818 -> 85818   Bankers Cheque Register List
52185819 -> 85819   Over Draft Authorisation List
52185820 -> 85820   Over Draft Authorisation
52185821 -> 85821   Cashier Transaction Lines
52185822 -> 85822   Account Transfer
52185823 -> 85823   Account Transfer Source
52185824 -> 85824   Account Transfer Destination
52185825 -> 85825   Account Transfer List
52185826 -> 85826   Main Treasury
52185827 -> 85827   Branch Treasury
52185828 -> 85828   Branch Treasury List
52185829 -> 85829   Main Treasury List
52185830 -> 85830   Tiered Charges Header
52185831 -> 85831   Tiered Charges List
52185832 -> 85832   Savings Statistics FactBox
52185833 -> 85833   Denomination Setup
52185834 -> 85834   Cheque Clearance
52185835 -> 85835   Investment Card
52185836 -> 85836   Posted EFT Transfer List
52185837 -> 85837   Credit Accounts List
52185838 -> 85838   Credit Account Card
52185839 -> 85839   Checkoff Advice
52185840 -> 85840   Checkoff Header
52185841 -> 85841   Checkoff Lines
52185842 -> 85842   Checkoff Buffer
52185843 -> 85843   Account Access Log
52185844 -> 85844   Checkoff Header List
52185845 -> 85845   Checkoff Advice List
52185846 -> 85846   Checkoff Advice Header
52185847 -> 85847   Checkoff Advice Header List
52185848 -> 85848   Loan Rescheduling List
52185849 -> 85849   Loan Rescheduling
52185850 -> 85850   Open Closure List
52185851 -> 85851   Membership Closure
52185852 -> 85852   Account Closure Line
52185853 -> 85853   Open withdrawal Notice
52185854 -> 85854   Member withdrawal Notice
52185855 -> 85855   Guarantor Substitution
52185856 -> 85856   Guarantor Subsitution List
52185857 -> 85857   Loan Guarantors substition Ln
52185858 -> 85858   Recovery & Attachment List
52185859 -> 85859   Loan Recovery Header
52185860 -> 85860   Loan Recovery Lines
52185861 -> 85861   Leave Allowances
52185862 -> 85862   ATM Linking Application List
52185863 -> 85863   ATM Card Types
52185864 -> 85864   Signatories List
52185865 -> 85865   Signatories Card
52185866 -> 85866   Account Interest List
52185867 -> 85867   Account  Interest Header
52185868 -> 85868   Account Interest Buffer
52185869 -> 85869   Posted Account Interest List
52185870 -> 85870   Posted Account Interest Header
52185871 -> 85871   ATM Application List
52185872 -> 85872   ATM Application Card
52185873 -> 85873   Approved ATM Application List
52185874 -> 85874   Approved ATM Application Card
52185875 -> 85875   Posted End Year Interest
52185876 -> 85876   Posted End Year Interest List
52185877 -> 85877   Daily Loans Interest Buffer
52185878 -> 85878   Loans Interest
52185879 -> 85879   Interest Header Card
52185880 -> 85880   Interest Header List
52185881 -> 85881   ATM Linking Card
52185882 -> 85882   Interest Due Periods
52185883 -> 85883   End Year Interest List
52185884 -> 85884   End Year Interest Header
52185885 -> 85885   End Year Interest Buffer
52185886 -> 85886   BBF Claims Lines
52185887 -> 85887   BBF Entitlement2
52185888 -> 85888   Benevolent Claim Header1
52185889 -> 85889   Benevolent Claim List1
52185890 -> 85890   PR Employee Allowances Card
52185891 -> 85891   PR Employee Allowances List
52185892 -> 85892   Benv.Claim List-Posted
52185893 -> 85893   Benv.Claim Header-Posted
52185894 -> 85894   HR CEO Goal Lines
52185895 -> 85895   My CEO Goal Assignments
52185896 -> 85896   LnTrans Interest
52185897 -> 85897   HR CEO Setup
52185898 -> 85898   HR Email Notification Log
52185899 -> 85899   CRM Application List
52185900 -> 85900   CRM Application Card
52185901 -> 85901   Petty Cash Details
52185902 -> 85902   Store Requisition Header
52185903 -> 85903   Store Requisition Line
52185904 -> 85904   Internal Requisitions
52185905 -> 85905   Imprest List
52185906 -> 85906   Imprest Types
52185907 -> 85907   Procurement Type
52185908 -> 85908   Expense Code
52185909 -> 85909   Receipts List
52185910 -> 85910   Cash Office Setup
52185911 -> 85911   Cash Office User Template
52185912 -> 85912   Receipt Types
52185913 -> 85913   Payment Types
52185914 -> 85914   Receipt and Payment Types List
52185915 -> 85915   Tariff Code s
52185916 -> 85916   Receipt Header
52185917 -> 85917   Bank & Cash Transfer Request
52185918 -> 85918   HR Email Template Card
52185919 -> 85919   Released Store Requisitions Li
52185920 -> 85920   Imprest Surrender
52185921 -> 85921   Imprest Surrender Details
52185922 -> 85922   Bank Pay In Slip List
52185923 -> 85923   Cash Payment Header
52185924 -> 85924   Cash Payment Lines
52185925 -> 85925   Receipts Line
52185926 -> 85926   Payment Header
52185927 -> 85927   Payment Lines
52185928 -> 85928   Payment Vouchers List
52185929 -> 85929   Petty Cash Vouchers List
52185930 -> 85930   Bank & Cash Transfers List
52185931 -> 85931   Imprest Vouchers List
52185932 -> 85932   Imprest Surrender List
52185933 -> 85933   Store Requisitions List
52185934 -> 85934   Requisitions
52185935 -> 85935   InterBank Transfers List
52185936 -> 85936   HR Email Template List
52185937 -> 85937   HR Email Template Variables
52185938 -> 85938   Marketing Teams Header
52185939 -> 85939   Cash Receipts Line
52185940 -> 85940   HR Email Body Editor
52185941 -> 85941   Budgetary Control Setup
52185942 -> 85942   Imprest Request Details
52185943 -> 85943   Imprest Request Header
52185944 -> 85944   Imprest Details List
52185945 -> 85945   Responsibility Center CardBR
52185946 -> 85946   Responsibility Center ListBR
52185947 -> 85947   Staff Claims
52185948 -> 85948   Staff Claim Lines
52185949 -> 85949   Staff Advance Request
52185950 -> 85950   Staff Advance Lines
52185951 -> 85951   Staff Advance Surrender
52185952 -> 85952   Staff Advanc Surrender Details
52185953 -> 85953   Staff Advance Surrender List
52185954 -> 85954   Claim Types
52185955 -> 85955   Advance Types
52185956 -> 85956   Purchase Requisitions
52185957 -> 85957   Staff Claims List
52185958 -> 85958   Staff Advance Request List
52185959 -> 85959   HR SMS Notification Log
52185960 -> 85960   HR SMS Template Card
52185961 -> 85961   HR SMS Template List
52185962 -> 85962   Cancelled Staff Advance Reques
52185963 -> 85963   Cancelled Imprest Vouchers Lis
52185964 -> 85964   Cancelled Staff Claims List
52185965 -> 85965   HR SMS Template Variables
52185966 -> 85966   Cancelled Petty Cash Vouchers
52185967 -> 85967   Payment Mode Charges
52185968 -> 85968   Asset Transfer List Effected
52185969 -> 85969   Asset Transfer
52185970 -> 85970   Asset Transfer List
52185971 -> 85971   Payment Line FactBox
52185972 -> 85972   Purchase Line Budget FactBox
52185973 -> 85973   Mid Year Review
52185974 -> 85974   End Year Review
52185975 -> 85975   Posted Loan Recovery Header
52185976 -> 85976   Global SMS Template List
52185977 -> 85977   Payroll Salary Process
52185978 -> 85978   Rejected Leave Applications
52185979 -> 85979   View Checkoff Lines
52185980 -> 85980   SinkFund Notice
52185981 -> 85981   Released Purchase Requisitions
52185982 -> 85982   Staff Claim FactBox
52185983 -> 85983   Staff Advance FactBox
52185984 -> 85984   Staff Advance Surrender FactBo
52185985 -> 85985   PRF Lists
52185986 -> 85986   Imprest Types List
52185987 -> 85987   Advance Types List
52185988 -> 85988   Claim Types List
52185989 -> 85989   Payment Types Lists
52185990 -> 85990   Receipt Types List
52185991 -> 85991   Posted Payment Vouchers List
52185992 -> 85992   Posted Payment Header
52185993 -> 85993   Posted Petty Cash Vouchers
52185994 -> 85994   Posted Cash Payment Header
52185995 -> 85995   Posted Bank & Cash Transfers
52185996 -> 85996   Posted Bank & Cash Transfer
52185997 -> 85997   Posted Imprest Vouchers List
52185998 -> 85998   Destination Code List
52185999 -> 85999   Posted Imprest Acct. List
52186000 -> 86000   Destination Code Card
52186001 -> 86001   Posted Store Requisitions List
52186002 -> 86002   Posted Store Requisition
52186003 -> 86003   Posted Purchase Requisitions
52186004 -> 86004   Released Internal Requisitions
52186005 -> 86005   Posted Staff Claims List
52186006 -> 86006   BOSA Account Activation List
52186007 -> 86007   Posted Staff Advance Requests
52186008 -> 86008   Posted Staff Advance
52186009 -> 86009   Posted Staff Advance Surrender
52186010 -> 86010   Posted Staff Advance Account
52186011 -> 86011   Posted Receipt List
52186012 -> 86012   Posted Receipt Header
52186013 -> 86013   Posted Cash Receipts List
52186014 -> 86014   Posted Cash Receipt Header
52186015 -> 86015   Posted Imprest Request
52186016 -> 86016   Imprest FactBox
52186017 -> 86017   HR Disc Withdrawal list
52186018 -> 86018   HR Disc Wthdrawal Card
52186019 -> 86019   Global SMS Token List
52186020 -> 86020   Others
52186021 -> 86021   Global SMS Token Card
52186022 -> 86022   SMS Template Token Usage SF
52186023 -> 86023   Global SMS Template History
52186024 -> 86024   Contract Lines
52186025 -> 86025   Contract Stage Activities
52186026 -> 86026   Nature Of Services
52186027 -> 86027   Contract Documents
52186028 -> 86028   Contract Lines Type
52186029 -> 86029   Contract Cycle Stage
52186030 -> 86030   Contracts list
52186031 -> 86031   Contract Cycle
52186032 -> 86032   Contract Lines Types Card
52186033 -> 86033   Contract Cycle Stage List
52186034 -> 86034   Contract Expectation Details-L
52186035 -> 86035   Contract Cycle Activities
52186036 -> 86036   Contracts Details Card
52186037 -> 86037   RFQ Header
52186038 -> 86038   RFQ Subform
52186039 -> 86039   RFQ List
52186040 -> 86040   Quotation Request Vendors
52186041 -> 86041   Purchase Quote Parameters
52186042 -> 86042   Destination Rate List
52186043 -> 86043   Destination Rates Card
52186044 -> 86044   Closed RFQ Header
52186045 -> 86045   Closed RFQ List
52186046 -> 86046   Quote Specifications List
52186047 -> 86047   Bid Analysis Worksheet
52186048 -> 86048   Bid Analysis
52186049 -> 86049   Bid Analysis SubForm
52186050 -> 86050   Overtime Claim Header
52186051 -> 86051   Overtime Claim Lines
52186052 -> 86052   Overtime Claim List
52186053 -> 86053   Overtime Claim List-Cancelled
52186054 -> 86054   Overtime Claim List-Approved
52186055 -> 86055   All Users Activities
52186056 -> 86056   Vote Transfer
52186057 -> 86057   Vote Transfer List.
52186058 -> 86058   prSalary Info Casual
52186059 -> 86059   PrSalary Card Casual
52186060 -> 86060   PrSalary List Casual
52186061 -> 86061   PrCasual Payroll Setup
52186062 -> 86062   Application Document Setup
52186063 -> 86063   Application Doc. Setup Card
52186064 -> 86064   Product Document
52186065 -> 86065   Application Documents
52186066 -> 86066   Signatory Factbox
52186067 -> 86067   Account Signatory Image Fatbox
52186068 -> 86068   Loan Required Documents
52186069 -> 86069   Loan History
52186070 -> 86070   Required Documents
52186071 -> 86071   Milestones
52186072 -> 86072   Contract Milestone Entrie List
52186073 -> 86073   Global Bulk SMS Filter Part
52186074 -> 86074   Global Bulk SMS Line List
52186075 -> 86075   Maintain Machne/Vehicles
52186076 -> 86076   Damages List
52186077 -> 86077   Legal List
52186078 -> 86078   Legal Card
52186079 -> 86079   Legal Line
52186080 -> 86080   Witness Card
52186081 -> 86081   Witness Line
52186082 -> 86082   Bank Acc. Statement Lines
52186083 -> 86083   Posted Bank Acc. Recon Line
52186084 -> 86084   Case Cost List
52186085 -> 86085   Fleet Card
52186086 -> 86086   HR Employee Change Log
52186087 -> 86087   Posted Reversal List
52186088 -> 86088   BOSA Account Activation
52186089 -> 86089   Security Valuers List
52186090 -> 86090   Posted BOSA Account Activation
52186091 -> 86091   Advocate Page
52186092 -> 86092   Advocates List
52186093 -> 86093   HR Fuel Management Card
52186094 -> 86094   Global Bulk SMS Line Part
52186095 -> 86095   Global Bulk SMS List
52186096 -> 86096   FA WIP Job Task Lines
52186097 -> 86097   FA WIP Suggest Lines List
52186098 -> 86098   Performance Attributes Sheet
52186099 -> 86099   Advocate List
52186100 -> 86100   Legal Card Approved
52186101 -> 86101   Legal List Aproved
52186102 -> 86102   Verdict List
52186103 -> 86103   Verdict Card
52186104 -> 86104   Advocate Card
52186105 -> 86105   Appealed Legal Card
52186106 -> 86106   Appealed Legal List
52186107 -> 86107   Case Payment List
52186108 -> 86108   Case Payment Header
52186109 -> 86109   Contract Purchase Invoices
52186110 -> 86110   Defined SLA List
52186111 -> 86111   Case Invoice
52186112 -> 86112   Case Invoice Card
52186113 -> 86113   Renewed Contracts list
52186114 -> 86114   Renewed Contracts Card
52186115 -> 86115   Terminated Contracts list
52186116 -> 86116   Terminated Contracts Card
52186117 -> 86117   Approved Contract Details Card
52186118 -> 86118   Approved Contracts list
52186119 -> 86119   Surety Management List
52186120 -> 86120   Surety Management Card
52186121 -> 86121   Approved Surety Management
52186122 -> 86122   Payment Vouchers Contract
52186123 -> 86123   ApprovedSurety Management Card
52186124 -> 86124   Notification Cases
52186125 -> 86125   Payment Header Contract
52186126 -> 86126   Store Requisition List
52186127 -> 86127   Loanee Information Base
52186128 -> 86128   Global Bulk SMS Token List
52186129 -> 86129   BBF SinkFund List
52186130 -> 86130   SinkFund Receipt Header
52186131 -> 86131   Sinkfund Receipts Line
52186132 -> 86132   Sinkfund Receipts List
52186133 -> 86133   SinkFund Account Transfer
52186134 -> 86134   SinkFund Account Transfer List
52186135 -> 86135   Posted Account Transfer List
52186136 -> 86136   Cancelled Store Req List
52186137 -> 86137   Defined SLA Card
52186138 -> 86138   Global Bulk SMS Token Part
52186139 -> 86139   Global SMS Field Selector
52186140 -> 86140   Global SMS Recipient Selector
52186141 -> 86141   Employer Loan Eligibility
52186145 -> 86145   HR Individual Appraisal Card
52186146 -> 86146   HR Indiv Appraisal Card-Q3
52186149 -> 86149   Approved Salary Agreement List
52186150 -> 86150   Rejected Salary Agreement List
52186151 -> 86151   Disposal Requisition
52186152 -> 86152   Disposal Requisition List
52186153 -> 86153   Disposal Lines
52186154 -> 86154   Employee Selection List
52186155 -> 86155   My Assigned Targets
52186156 -> 86156   HR Individual Appraisals List
52186157 -> 86157   Procurement Methods Sub Page
52186158 -> 86158   Procurement Methods Card
52186159 -> 86159   Procurement Methods List
52186163 -> 86163   File Volumes List
52186164 -> 86164   Budget Committments
52186165 -> 86165   Bank Acc. Recon Lines 2015
52186166 -> 86166   Agent Registration Fact Box
52186167 -> 86167   Agent Error Messages
52186168 -> 86168   Agent Sent Sms Messages
52186169 -> 86169   Agency Setup
52186171 -> 86171   Update Agent Applications
52186172 -> 86172   Updated Agents List
52186173 -> 86173   Agent Member Application
52186174 -> 86174   Periodic Billing
52186176 -> 86176   Posted Vote Transfer List
52186178 -> 86178   Payment Sub Form Delegates
52186180 -> 86180   Customer Card-Tenant
52186182 -> 86182   General Setup
52186183 -> 86183   Property Details
52186184 -> 86184   Floor
52186185 -> 86185   Unit
52186186 -> 86186   Property List
52186187 -> 86187   Unit Type List
52186188 -> 86188   Unit Sub Type List
52186189 -> 86189   Unit Type Card
52186190 -> 86190   Unit Sub Type Card
52186191 -> 86191   Lease
52186192 -> 86192   Portfolio Manager List
52186193 -> 86193   Unit List
52186194 -> 86194   Charges Card
52186195 -> 86195   Charges List
52186196 -> 86196   Lease Line
52186197 -> 86197   Lease Charge Review View
52186198 -> 86198   Lease-Active
52186199 -> 86199   Lease-Commencement
52186200 -> 86200   Lease Review-Effect
52186201 -> 86201   Saving Interest Import Buffer
52186202 -> 86202   Lease-InActivate
52186204 -> 86204   Lease-List
52186206 -> 86206   Landlord Commission Calc  Line
52186207 -> 86207   Asset Register Setup
52186209 -> 86209   Lease-Expired
52186210 -> 86210   Computer Asset Register
52186211 -> 86211   Computer Asset Register List
52186212 -> 86212   Computer Asset Register (Disp)
52186213 -> 86213   Floor Description Card
52186214 -> 86214   Tenant Receipts Line
52186215 -> 86215   HR Employee List - (FixedTc)
52186216 -> 86216   Unit Rental Charges
52186217 -> 86217   Property Category
52186218 -> 86218   Active Properties
52186219 -> 86219   Water Billing rates
52186223 -> 86223   Active Properties-Edit
52186225 -> 86225   Floor Codes
52186229 -> 86229   HR Leave Approved Card
52186230 -> 86230   charge Card
52186232 -> 86232   Approved Leases
52186233 -> 86233   Posted Lease-Active
52186234 -> 86234   Property Charges
52186235 -> 86235   Reason For Request
52186238 -> 86238   Tenant List
52186241 -> 86241   Terminated Leases
52186242 -> 86242   Property Expense List
52186245 -> 86245   Common Area Charges
52186246 -> 86246   Lease line Invoice
52186248 -> 86248   Active Property List
52186249 -> 86249   Active Lease-List
52186250 -> 86250   Terminate Active Lease-List
52186256 -> 86256   Terminate Lease-Active
52186257 -> 86257   Terminated Active Lease-List
52186258 -> 86258   Payment Schedule
52186259 -> 86259   Tenant List-Water Billing
52186260 -> 86260   Customer Card-Tenant Billing
52186261 -> 86261   Land Property List
52186262 -> 86262   Land Property Details
52186263 -> 86263   All Property List
52186264 -> 86264   Status Change Permssion.
52186265 -> 86265   MBanking Loan Rejected List
52186266 -> 86266   MBanking Loan Appraised List
52186267 -> 86267   Permission Requisition Card
52186268 -> 86268   Permission Requisition Lines
52186269 -> 86269   Permission Requisition List
52186270 -> 86270   Systems Affected
52186271 -> 86271   Users Sessions
52186272 -> 86272   Staff Allowance Setup
52186273 -> 86273   Staff Member List
52186274 -> 86274   Staff Allowance Grade
52186275 -> 86275   Staff Allowance Lines
52186276 -> 86276   Loan Recovery Header(Modified)
52186277 -> 86277   File Locations List
52186278 -> 86278   Sectoral Classification
52186279 -> 86279   ATM Linking Statistics
52186280 -> 86280   Money Market Subform
52186281 -> 86281   Investment List
52186282 -> 86282   Investment Type
52186283 -> 86283   Cheque Discounting
52186284 -> 86284   Family Member App.
52186285 -> 86285   Nominee List
52186286 -> 86286   Cheque Set Up
52186287 -> 86287   Approved ATM Linking List
52186288 -> 86288   Approved ATM Linking Card
52186289 -> 86289   Cheque Return Codes
52186290 -> 86290   Interest Buffer
52186291 -> 86291   Fixed Deposit History
52186292 -> 86292   Delegate Groups Card
52186293 -> 86293   Delegate Group List
52186294 -> 86294   Batch No List
52186295 -> 86295   Salutation Tittles
52186296 -> 86296   File Volumes Card
52186297 -> 86297   Files Locations Card
52186298 -> 86298   Batching Process List
52186299 -> 86299   Payment Voucher Board
52186300 -> 86300   Payment Sub Form Board
52186301 -> 86301   Posted Payment Voucher Board L
52186302 -> 86302   Payment Voucher Board List
52186303 -> 86303   Posted Payment Voucher Board
52186304 -> 86304   Bank Transfer Modes
52186305 -> 86305   Payment Voucher Staff
52186306 -> 86306   Payment Sub Form Staff
52186307 -> 86307   Payment Voucher Staff List
52186308 -> 86308   Posted Payment Voucher Staff L
52186309 -> 86309   Posted Payment Voucher Staff
52186310 -> 86310   Batching Process Card
52186311 -> 86311   Comments List
52186312 -> 86312   Batching Lines
52186313 -> 86313   Batching Lines List
52186314 -> 86314   BBF Entitlement
52186315 -> 86315   Benevolent Claim Header
52186316 -> 86316   Benevolent Claim List
52186317 -> 86317   BBF Entitlement List
52186318 -> 86318   Loans Approval Entries
52186319 -> 86319   Approval Entries Archive
52186320 -> 86320   Delegate Meeting Header
52186321 -> 86321   Delegate Meeting Card
52186322 -> 86322   Delegate Meeting Attendees
52186323 -> 86323   Delegate Meeting Minutes
52186324 -> 86324   Degate Meeting Minutes Card
52186325 -> 86325   Delegate Tariffs
52186326 -> 86326   Region Delegate Tariffs
52186327 -> 86327   Delegates Payment Line List
52186328 -> 86328   Delegates Payment Card
52186329 -> 86329   Delegates Payment List
52186330 -> 86330   Comments Card
52186331 -> 86331   Delegate Group Lists
52186332 -> 86332   Rejected Loan Application List
52186333 -> 86333   System Edits Reasons
52186334 -> 86334   Delegate Change Cards
52186335 -> 86335   Delegate Group Retire Lists
52186336 -> 86336   Delegate Retire Memberss
52186337 -> 86337   Delegate Region App Cards
52186338 -> 86338   Delegate Group App Lists
52186339 -> 86339   Delegate Members Applicationss
52186340 -> 86340   Exceptions/ Rejection Reason
52186341 -> 86341   Loan Calculator
52186342 -> 86342   Loan Application Card Dummy
52186343 -> 86343   Delegate Members List
52186344 -> 86344   Savings Statistics Unallocated
52186346 -> 86346   ADM Registration List
52186347 -> 86347   Delegate AGM Registration
52186348 -> 86348   Banking Account Closure
52186349 -> 86349   Banking Closure List
52186350 -> 86350   File Tracker List
52186351 -> 86351   File Tracker Card
52186353 -> 86353   File Stages List
52186354 -> 86354   File Stations
52186355 -> 86355   AGMDelegates Payment Line List
52186356 -> 86356   AGM Delegates Payment Card
52186357 -> 86357   ADM Payment List
52186358 -> 86358   Asset Finance Loans
52186359 -> 86359   Email Update Requests
52186360 -> 86360   Posted Loan Disbursement List
52186361 -> 86361   Agent Tariff Header
52186362 -> 86362   Agent Tariff Card
52186363 -> 86363   Agent Tariff Details
52186364 -> 86364   Paid SinkFund List
52186365 -> 86365   Posted Membership Closure List
52186366 -> 86366   Micro Member  List
52186367 -> 86367   Micro Member Application List
52186368 -> 86368   Micro Member Application
52186369 -> 86369   Dialy Mortgage Interest List
52186370 -> 86370   Mortage Doc Release Card
52186371 -> 86371   Morgate Doc Release List
52186376 -> 86376   Salary Thru FOSA Update
52186377 -> 86377   Open Member Application V
52186378 -> 86378   Salary Agreement Card
52186379 -> 86379   Salary Agreement List
52186380 -> 86380   Marketing Teams Lines
52186382 -> 86382   File Mvt Remarks Card
52186383 -> 86383   User Station Card
52186384 -> 86384   User Station List
52186385 -> 86385   File MVT Remarks
52186386 -> 86386   File Station List
52186387 -> 86387   Delegate Region Change  Cards
52186388 -> 86388   Delegate Group Change Lists
52186389 -> 86389   Delegate  Memberss Transfer
52186390 -> 86390   Deleage AGM Update Header
52186391 -> 86391   Delegate Retire Lines
52186392 -> 86392   Delegate Appoint  Lines
52186393 -> 86393   Delegates AGM Update List
52186394 -> 86394   Apply Vendor Entries - New
52186395 -> 86395   MBanking Guarantors List
52186396 -> 86396   Checkoff Advice Lines
52186397 -> 86397   DCS Account Details
52186398 -> 86398   Online Loan Guarantors
52186399 -> 86399   DCS Admin
52186400 -> 86400   Product Required Documents
52186401 -> 86401   Member Documents
52186402 -> 86402   Business Incomes
52186403 -> 86403   Social Listening Sites App.
52186404 -> 86404   Social Listening Sites
52186405 -> 86405   Electrol Zones/Area Svr Center
52186406 -> 86406   Product Factory Appl. List
52186407 -> 86407   Product Factory Appl. Card
52186408 -> 86408   Product Application Document
52186409 -> 86409   Related Product Appl. List
52186410 -> 86410   Loan Product Charge Appl.
52186411 -> 86411   DCS Parameter Matrix Appl.
52186412 -> 86412   Collateral Register Card
52186413 -> 86413   Collateral Register - List
52186414 -> 86414   Loan Securities Set-Up
52186415 -> 86415   Loan Securites Card
52186416 -> 86416   Loan Payment Method
52186417 -> 86417   Loan Linking
52186418 -> 86418   Loan Linking List
52186419 -> 86419   Loans Linking List
52186420 -> 86420   Loan Products To Bridge
52186421 -> 86421   Loan Purpose
52186423 -> 86423   Payment Methods Application
52186424 -> 86424   Account Association
52186425 -> 86425   Promise Topay Lines
52186426 -> 86426   Collateral Collection - List
52186427 -> 86427   Collateral Collection Card
52186428 -> 86428   Financilal Appraisal
52186429 -> 86429   Business Appraisals
52186430 -> 86430   Appr. w_sheet
52186431 -> 86431   BBF Requisation Headers
52186432 -> 86432   BBF Requisation Header List
52186433 -> 86433   BBF Requisation Lines
52186437 -> 86437   BDE Management Buffer
52186438 -> 86438   Withdrawal Reason
52186439 -> 86439   DCS Savings Account List
52186440 -> 86440   CRB Data
52186441 -> 86441   DCS CRB Account Type
52186442 -> 86442   DCS Data Source List
52186443 -> 86443   DCS Member Transaction List
52186444 -> 86444   DCS Vendor Card
52186445 -> 86445   DCS Account List
52186446 -> 86446   DCS Loan Summary List
52186447 -> 86447   Loan Summary Card
52186448 -> 86448   DCS Account Trans Summ List
52186449 -> 86449   DCS Parameter List
52186450 -> 86450   DCS Product Parameter Matrix
52186451 -> 86451   DCS Vendor
52186452 -> 86452   DCS Parameter Range List
52186453 -> 86453   DCS Member Card
52186454 -> 86454   VB Loan Card
52186455 -> 86455   VB Loan List
52186456 -> 86456   VB Payment Option List
52186457 -> 86457   Loan Categorization
52186458 -> 86458   Online Users
52186461 -> 86461   Closure Verification Specimen
52186462 -> 86462   Clearance Lines
52186463 -> 86463   Dues Amount
52186464 -> 86464   Clearance Form List
52186465 -> 86465   Risk External Payment
52186466 -> 86466   General SMS Header List
52186467 -> 86467   General SMS Lines
52186468 -> 86468   HR Disciplinary Case Card Clsd
52186469 -> 86469   HR Disciplinary Cases ListCls1
52186470 -> 86470   Board Payroll Deductions
52186472 -> 86472   HR Company Activities List Cl1
52186473 -> 86473   HR 360 Appraisal Lines - ExS
52186474 -> 86474   HR Employee Transfer Card
52186475 -> 86475   HR Employee Transfer List1
52186476 -> 86476   General SMS Header Card
52186477 -> 86477   Approved General SMS List
52186478 -> 86478   Posted General SMS List
52186479 -> 86479   Imprest Application List S/S.
52186480 -> 86480   Unposted Loans Statistics
52186481 -> 86481   Admin Booking Calendar List
52186482 -> 86482   Admin Booking Calendar Card
52186483 -> 86483   HR Collateral Register
52186484 -> 86484   FIles List Part
52186485 -> 86485   HR Training Needs Card
52186486 -> 86486   HR Training ApplicationList
52186487 -> 86487   HR Training Needs List
52186488 -> 86488   HR Training Application Header
52186489 -> 86489   HR Training Cost
52186490 -> 86490   Sales Teams
52186491 -> 86491   Vehicle Types
52186492 -> 86492   HR Training Application Lines
52186493 -> 86493   HR Training Bonding Cond. List
52186494 -> 86494   Contract Templates Header
52186495 -> 86495   HR Disciplinary Cases SF
52186496 -> 86496   HR Disciplinary Cases
52186497 -> 86497   HR Disciplinary Cases List
52186498 -> 86498   Contract Templates List
52186499 -> 86499   Contract Template Lines
52186500 -> 86500   CRM API Setup
52186501 -> 86501   CRB Trans Union API Setup
52186502 -> 86502   Sky M-Banking Trans. Buffer
52186503 -> 86503   Sky M-Banking Trans. Buf. Card
52186504 -> 86504   HR Employee Exit Interviews1
52186505 -> 86505   EDMS API Setup
52186506 -> 86506   EDMS Files List
52186507 -> 86507   EDMS File Viewer
52186508 -> 86508   Vendor Categories List
52186509 -> 86509   HR 360 Appraisal Lines - EP
52186510 -> 86510   CRM Originations Setup
52186511 -> 86511   HR Appraissal Appeal1
52186512 -> 86512   HR Professional bodies
52186514 -> 86514   HR Promotion Recommend Header
52186515 -> 86515   Recruitment Costs
52186516 -> 86516   Sky ATM Transactions Buffer
52186517 -> 86517   Sky ATM Trans. Buffer Card
52186518 -> 86518   CRB DPI File Submissions
52186519 -> 86519   CRB DPI File Submission
52186520 -> 86520   Sky SMS Card
52186521 -> 86521   HR 360 Appraisals List - TS1
52186522 -> 86522   CRB Monthly ICE File Subm Card
52186523 -> 86523   HR 360 Appraisals List - TA1
52186524 -> 86524   HR 360 Appraisals List - EV1
52186525 -> 86525   HR 360 Appraisal Card
52186526 -> 86526   HR 360 Appraisal Lines - PG
52186527 -> 86527   HR 360 Appraisal Lines - JS
52186528 -> 86528   HR 360 Appraisal Lines - ES
52186529 -> 86529   CRB Monthly NICE File Subm.
52186530 -> 86530   CRB Monthly ICE File Subm.
52186531 -> 86531   CRM SMS API
52186532 -> 86532   CRM Email API
52186533 -> 86533   M-Smart Loan Corrections
52186537 -> 86537   EDMS File Annotation
52186542 -> 86542   HR Appraisal Period Setup
52186544 -> 86544   HR Policy List
52186545 -> 86545   HR Employment History Lines
52186546 -> 86546   Other Appraisal Products
52186547 -> 86547   CRB Monthly NICE File Sub Card
52186548 -> 86548   HR Professional Body Lines
52186549 -> 86549   HR Policies
52186550 -> 86550   Credit Ledger Entry
52186551 -> 86551   HR Job Interview
52186552 -> 86552   Loan
52186553 -> 86553   HR Interview Candidates List
52186554 -> 86554   Loans Top Up
52186555 -> 86555   HR Hiring Criteria
52186556 -> 86556   HR Job Applicants Qualified Ca
52186557 -> 86557   HR Induction Schedule List1
52186558 -> 86558   HR Induction Participants List
52186559 -> 86559   HR Induction Schedule Card
52186560 -> 86560   HR Job Applicants Uploaded1
52186561 -> 86561   CRB Metropol API Setup
52186562 -> 86562   CRB Metropol PDF Viewer
52186563 -> 86563   HR Leave Calendar List
52186564 -> 86564   Company Vehicles list
52186565 -> 86565   HR Company Activities Card
52186566 -> 86566   Employer Code List
52186567 -> 86567   HR Company Activities List1
52186568 -> 86568   HR Company Activities Factbox
52186569 -> 86569   HR Activity Participants SF
52186570 -> 86570   Product & references
52186571 -> 86571   HR Appraissal Appeal list
52186572 -> 86572   Cancelled/Archived Risk Claim
52186573 -> 86573   Cancelled/Archived withdrawal
52186574 -> 86574   M-Smart Document
52186575 -> 86575   Perfection In Progress list
52186576 -> 86576   HR Disciplinary Case Card N
52186577 -> 86577   HR Disciplinary Cases List N1
52186578 -> 86578   HR Shortlisting Panel
52186579 -> 86579   EDMS Scanned Apps. API
52186580 -> 86580   CRM Member Applications API
52186581 -> 86581   CRM Member Withdrawals API
52186582 -> 86582   CRM BBF Applications API
52186583 -> 86583   Audit Role center
52186584 -> 86584   CRM Product Variations API
52186585 -> 86585   Loan Appraisal form viewer
52186586 -> 86586   CRM Member Edit Apps API
52186587 -> 86587   HR Overtime Lines
52186588 -> 86588   Approved Leave Applications
52186589 -> 86589   User Time Register
52186590 -> 86590   Defaulter Notice Letters Card
52186591 -> 86591   CRM NOK API
52186592 -> 86592   HR Overtime List1
52186593 -> 86593   CRM Members API
52186594 -> 86594   HR Overtime Rates List1
52186595 -> 86595   CRM Loans API
52186596 -> 86596   CRM Loan Guarantors API
52186597 -> 86597   CRM Member Account API
52186598 -> 86598   HR Bank Accounts List
52186599 -> 86599   CRM Product Factory API
52186600 -> 86600   HR Exit Interview list1
52186601 -> 86601   HR Disciplinary Cases Factbox
52186602 -> 86602   HR  App Qualified Applicants1
52186603 -> 86603   MBanking Other Services
52186604 -> 86604   Loans Guaranteed List
52186605 -> 86605   Member Withdrawal Notices ALL
52186606 -> 86606   HR Employee Competence List
52186607 -> 86607   Member Sub-Status Tracker
52186608 -> 86608   ATM Repin Application List
52186609 -> 86609   ATM Repin Procssed List
52186610 -> 86610   Attributes
52186611 -> 86611   ATM Repin Card
52186612 -> 86612   Monthly Contrib Logs
52186613 -> 86613   Comments For Posted Documents
52186614 -> 86614   Open Member Readmission
52186615 -> 86615   User Permission Roles
52186616 -> 86616   Loan Clearance Card
52186617 -> 86617   Loan Clearance List
52186618 -> 86618   Guarantor Notice Letters List
52186619 -> 86619   HR Promotion RecommendAppList
52186620 -> 86620   HR Promotion Recommend AppHead
52186622 -> 86622   Loan Processing Activities
52186623 -> 86623   ATM Returned List
52186624 -> 86624   HR Head of Departments List
52186625 -> 86625   HR Interns List
52186626 -> 86626   HR Interns Card
52186627 -> 86627   HR Head of Departments Card
52186628 -> 86628   HR Intern Requisition List
52186629 -> 86629   HR Intern Requisition Card
52186630 -> 86630   PR Bank Summary
52186631 -> 86631   prBoard employee list
52186632 -> 86632   prBoard Employees Card
52186633 -> 86633   prBoard Payment
52186634 -> 86634   prBoard Earning
52186636 -> 86636   HR Leave Planner
52186637 -> 86637   ATM Return Card
52186638 -> 86638   BC API Log Card
52186639 -> 86639   BC API Logs List
52186640 -> 86640   HR Training Feedback
52186641 -> 86641   Member Statistics
52186642 -> 86642   Savings Statistics
52186643 -> 86643   Credit Statistics
52186644 -> 86644   Loans Statistics
52186645 -> 86645   Partial Disbursement Schedule
52186646 -> 86646   Dependancies Applications List
52186647 -> 86647   Dependancies Applications Card
52186648 -> 86648   Mobile Banking App List
52186649 -> 86649   Specimen File Viewer
52186650 -> 86650   Credit Ledg. Entr. Preview
52186651 -> 86651   Performance Attributes
52186654 -> 86654   Member Clasess
52186655 -> 86655   Standing Order Control List
52186656 -> 86656   Standing Order Control Card
52186657 -> 86657   Mobile Banking Card
52186658 -> 86658   Mobile Banking Procssed List
52186660 -> 86660   Deferred Loan Application List
52186661 -> 86661   BBF Entitlement SetUp
52186662 -> 86662   Pending Member Application
52186663 -> 86663   Approved Member Application
52186664 -> 86664   Rejected Member Application
52186665 -> 86665   Pending Member Application V
52186666 -> 86666   Approved Member Application V
52186667 -> 86667   Rejected Member Application V
52186668 -> 86668   Pending Withdrawal Notice
52186669 -> 86669   Approved Withdrawal Notice
52186670 -> 86670   Rejected Withdrawal Notice
52186671 -> 86671   Pending Closure List
52186672 -> 86672   Approved Closure List
52186673 -> 86673   Rejected Closure List
52186674 -> 86674   Monthly Returns List
52186675 -> 86675   Return Lines List
52186676 -> 86676   Return Complaints and Remarks
52186677 -> 86677   Return Other Remarks
52186678 -> 86678   Complains and Remarks Page
52186679 -> 86679   Transaction Types SetUp
52186680 -> 86680   Sky Portal Setup List
52186681 -> 86681   Sky Portal Setup Card
52186682 -> 86682   Portal Tiered Charges
52186683 -> 86683   Non Member Mortgage List
52186684 -> 86684   Rejected Cashier Transactions
52186685 -> 86685   Complaint Categories
52186686 -> 86686   Credit Officers RC
52186687 -> 86687   Credit Officers Cue Page
52186688 -> 86688   Your Loan Guarantors
52186689 -> 86689   Member Application Handlers
52186690 -> 86690   Excempted Product Charges
52186691 -> 86691   Sky Mobile Setup Card
52186692 -> 86692   Sky Tiered Lines List
52186693 -> 86693   BBF/Nominee Register
52186695 -> 86695   Portal Endpoints
52186696 -> 86696   Log Entries Endpoints
52186697 -> 86697   Posted Vouchers List
52186698 -> 86698   Cancelled Payments list
52186700 -> 86700   Electoral Application List
52186701 -> 86701   Approved Electoral List
52186702 -> 86702   Electoral Rejected List
52186703 -> 86703   Electoral Zones Card
52186704 -> 86704   Active Delegate Officials
52186705 -> 86705   Retired Delegate Officials
52186706 -> 86706   Delegate Official Applications
52186707 -> 86707   Delegate Officials Card
52186708 -> 86708   Officials List Part
52186709 -> 86709   Meeting Types List
52186710 -> 86710   Allowed Allowances Part
52186711 -> 86711   Meeting Type Card
52186712 -> 86712   Delegate Commitee
52186713 -> 86713   Retired Officials List Part
52186714 -> 86714   Present Users
52186715 -> 86715   User Tasks
52186716 -> 86716   Certificate Management
52186717 -> 86717   Treasury Cheque Application
52186718 -> 86718   Treasury Application List
52186719 -> 86719   52186719 Employer Product Attr
52186720 -> 86720   Member Prorata
52186721 -> 86721   Treasury Cheque Register List
52186722 -> 86722   Posted Salary List
52186723 -> 86723   Treasury Cheque Inventory
52186724 -> 86724   Target Employers
52186725 -> 86725   BLA Application List
52186726 -> 86726   B/S Loan Acc. Application Card
52186727 -> 86727   Approved BLA Application List
52186728 -> 86728   Approved Group App List
52186729 -> 86729   Rejected Group App List
52186730 -> 86730   Rejected BLA Application List
52186731 -> 86731   SMS Alert Header List
52186732 -> 86732   SMS Alerts Header Card
52186733 -> 86733   SMS Alerts Lines
52186734 -> 86734   Posted SMS Alerts List
52186735 -> 86735   Loan Reappotionment Lines
52186736 -> 86736   Fixed Deposit Contract List
52186737 -> 86737   ATM Inventory Card
52186738 -> 86738   Atm Inventory List
52186739 -> 86739   Fixed Deposit Contract
52186740 -> 86740   Approved SMS Alerts List
52186741 -> 86741   Alerts Loan Lines
52186742 -> 86742   Skipped Loans
52186743 -> 86743   Digital Signature
52186744 -> 86744   Clearance Form
52186746 -> 86746   BBF/Nominee Filter
52186747 -> 86747   Open Member Readmission List
52186748 -> 86748   NCBA Pension Card
52186749 -> 86749   NCBA Pension List
52186750 -> 86750   Dispatch ATM Header
52186752 -> 86752   Investment Interest Lines
52186753 -> 86753   ATM Card List
52186754 -> 86754   Loan Reversal Lines
52186755 -> 86755   Group Members Edit
52186756 -> 86756   Member Closure List All
52186757 -> 86757   Group Mem Exit & Update List
52186758 -> 86758   Group Mem Exit & Update Card
52186759 -> 86759   IPRS API Setup
52186760 -> 86760   Security Perfection List
52186761 -> 86761   Security Perfection Card
52186762 -> 86762   Motor Vehicle Request List
52186763 -> 86763   Motor Vehicle Request Card
52186764 -> 86764   Dividend Progression Import
52186765 -> 86765   Bulk SMS Header
52186766 -> 86766   Bulk SMS Lines Part
52186767 -> 86767   Matured withdrwal Notices
52186768 -> 86768   Per-Diem Receipt Card
52186769 -> 86769   Per-Diem Receipts list
52186770 -> 86770   Per-Diem Lines
52186771 -> 86771   Atm Card
52186772 -> 86772   Mobile Deposits Keywords Setup
52186773 -> 86773   Loans card
52186777 -> 86777   HR Salary Grade Lines
52186778 -> 86778   Finance Role Center
52186779 -> 86779   Training Evaluation
52186780 -> 86780   CRB log Buffer
52186781 -> 86781   DMU Cues
52186798 -> 86798   HR Establishment Card
52186800 -> 86800   Loan Defferals
52186801 -> 86801   Training Planner
52186802 -> 86802   File Locations
52186803 -> 86803   Loan Recovery Header List II
52186804 -> 86804   Posted Loan Recovery Header II
52186805 -> 86805   Loan Recovery Header II
52186806 -> 86806   Loan Recovery Lines II
52186807 -> 86807   Loan Reappotionment Lines II
52186808 -> 86808   Loan Reversal Lines II
52186809 -> 86809   Debt Collectors Staging
52186810 -> 86810   Debt Collectors Header List
52186811 -> 86811   Debt Collecrtors header
52186812 -> 86812   Debt Lines
52186813 -> 86813   Debt Lines Logs
52186820 -> 86820   Bosa Commecial Loan
52186821 -> 86821   Bosa Commercial List
52186822 -> 86822   Dividends Provision List Part
52186824 -> 86824   Hr Training Planner List
52186825 -> 86825   HR Employee Appointment
52186826 -> 86826   Investment Receipt
52186827 -> 86827   Investment Receipts List
52186828 -> 86828   Posted Investment Receipt List
52186829 -> 86829   Tenant Receipt
52186830 -> 86830   Tenant Receipts List
52186831 -> 86831   Posted Tenant Receipt List
52186832 -> 86832   Processed WithDrawal Notices
52186833 -> 86833   Employee Groups
52186834 -> 86834   Risk Claim List
52186835 -> 86835   Risk Claim Notice
52186836 -> 86836   Approved Risk Claim List
52186837 -> 86837   NextofKin Payment Allocation
52186838 -> 86838   Posted Risk Claim List
52186840 -> 86840   Business Group Closure Line
52186841 -> 86841   Member FactBox
52186842 -> 86842   OvertimeNeedsLines
52186850 -> 86850   Insurance Claim Notice
52186851 -> 86851   Insurance Claim List
52186870 -> 86870   Savings Accounts
52186871 -> 86871   52186871FA Analysis
52186875 -> 86875   Partially Posted Risk Claim
52186882 -> 86882   Account Activation
52186883 -> 86883   Account Activation List
52186884 -> 86884   Hr Establishment List
52186885 -> 86885   NotificationSetupSms
52186900 -> 86900   Stock Keeping Lines
52186901 -> 86901   Stock Keeping Header
52186902 -> 86902   StockKeeping List
52186987 -> 86987   Salary Lines P
52186990 -> 86990   Sky Background Process Manager
52186991 -> 86991   E-Channels Transaction Setup
52187007 -> 87007   Share Capital Transfer Card
52187008 -> 87008   Share Capital Transfer List
52187009 -> 87009   Moratorium Loan List
52187010 -> 87010   Moratorium Loan Card
52187011 -> 87011   Loan Restucturing
52187012 -> 87012   Posted Shares Transfer List
52187013 -> 87013   Loan Restructure List
52187022 -> 87022   Deposit List. Date Picker
52187023 -> 87023   Fall Off Filter
52187025 -> 87025   Loan List. Date Picker
52187026 -> 87026   Member List. Date Picker
52187034 -> 87034   Refund,Account Transfer 
52187035 -> 87035   Refund,Account Transfer Lines
52187036 -> 87036   Refund $ Account Trans List
52187037 -> 87037   Bulk Account Refunds
52187038 -> 87038   Bulk Refund Account Transfers
52187039 -> 87039   Variations List
52187040 -> 87040   Bulk Refunds Card
52187041 -> 87041   Bulk Refunds Card BL
52187042 -> 87042   Refund $ Account Trans List BL
52187043 -> 87043   Bulk Account Transfers BL
52187045 -> 87045   Business Types
52187046 -> 87046   Investment Interest Header
52187047 -> 87047   Investment Interest List
52187049 -> 87049   Posted Cashier Transactions
52187050 -> 87050   Parking Space Card
52187051 -> 87051   Parking Space List
52187052 -> 87052   Nominee Legal List
52187053 -> 87053   Nominee Legal Card
52187054 -> 87054   Dispatch ATM Lists
52187056 -> 87056   User Reactivation List
52187057 -> 87057   User Reactivation Card
52187058 -> 87058   ICT Department
52187065 -> 87065   Administration Role Center
52187066 -> 87066   Motor Vehicle Card
52187067 -> 87067   Motor Vehicle Movement
52187068 -> 87068   Motor Vehicle Movement List
52187069 -> 87069   Travelling Officers
52187071 -> 87071   Confe & Mtng Room Appl Card
52187072 -> 87072   MNS Conf & Meetings Appl List
52187073 -> 87073   Motor Vehicle Fueling List
52187076 -> 87076   Motor Vehicle Repair
52187077 -> 87077   User Creation Request List
52187078 -> 87078   Vehicles Repair
52187080 -> 87080   System Edits List
52187081 -> 87081   System Edits Card
52187082 -> 87082   System Edits Filters
52187083 -> 87083   System Edits Fields
52187084 -> 87084   Posted System Edits List
52187085 -> 87085   One Month Installments
52187086 -> 87086   Business Clossure List
52187087 -> 87087   Business Loan Clossure Card
52187088 -> 87088   Image Data Edits
52187089 -> 87089   System Edits Tables
52187090 -> 87090   System Reversal List
52187091 -> 87091   Reversed System Reversal List
52187092 -> 87092   System Reversal Card
52187093 -> 87093   User Termination Requests List
52187094 -> 87094   User Termination Card
52187095 -> 87095   Unforwarded Cases
52187096 -> 87096   Forwarded Cases
52187097 -> 87097   Actioned Cases
52187098 -> 87098   DMU CF Page
52187099 -> 87099   DMU Case Forwarding Lines
52187100 -> 87100   Staff Welfare 
52187101 -> 87101   Staff Welfare List
52187102 -> 87102   loan Tearms And Conditions
52187103 -> 87103   Approved Delegate Meetings
52187104 -> 87104   Posted Delegate Meetings
52187105 -> 87105   CRM Coupling Resource
52187106 -> 87106   Approved Delegates Payments
52187107 -> 87107   Posted Delegates Payments
52187108 -> 87108   Next Of Kin List
52187109 -> 87109   Approved BBF SinkFund List
52187110 -> 87110   CRM Coupling Unit of Measure
52187111 -> 87111   Pending Dependancies Apps
52187112 -> 87112   Created Dependancies Apps
52187113 -> 87113   Pending System Edits
52187114 -> 87114   Received Cases
52187115 -> 87115   MKey Sent Cases
52187116 -> 87116   CRM Coupling Item
52187117 -> 87117   MKey Received Cases
52187118 -> 87118   MKey Page
52187119 -> 87119   MKey Lines
52187154 -> 87154   Deposit Listing List
52187160 -> 87160   Product SLA Setup List
52187161 -> 87161   M-Banking Whitelist List
52187162 -> 87162   M-Banking Whitelist App. Card
52187163 -> 87163   Satellite Branches Setup
52187221 -> 87221   Upcoming Matters
52187231 -> 87231   52187231Loan Appr. Comments
52187233 -> 87233   Variations
52187234 -> 87234   Open CRM Member Edits
52187235 -> 87235   CRM Member Edit
52187236 -> 87236   Open M-Smart Member Edits
52187237 -> 87237   M-Smart Member Edit
52187250 -> 87250   Channel Application Documents
52187251 -> 87251   Channel Application Document
52187261 -> 87261   Mobile Loan Restrictions
52187290 -> 87290   Loan Application Card_BL
52187291 -> 87291   Loan Application List_HR
52187292 -> 87292   Loan Application Card_HR
52187293 -> 87293   Appraisal Loans List_BL
52187294 -> 87294   Approved Loans List_BL
52187300 -> 87300   Custom GL Register
52187301 -> 87301   Banking Management Role Center
52187302 -> 87302   Self Loan Application List
52187303 -> 87303   Self Loan Application Card
52187306 -> 87306   Loan Application List_FOSA
52187307 -> 87307   Loan Application Card_FOSA
52187308 -> 87308   Loan Application List_BL
52187309 -> 87309   HR  Manager Activities
52187310 -> 87310   Payroll processing Role Center
52187312 -> 87312   Credit Management Role Center
52187313 -> 87313   CF Station Actions List
52187314 -> 87314   Legal Role Center
52187315 -> 87315   CF Tracker List
52187316 -> 87316   Edits Helper
52187317 -> 87317   Member Card Edits
52187318 -> 87318   SMS Templates
52187319 -> 87319   Funds Management Role Center
52187320 -> 87320   AdvancedHumanResources
52187321 -> 87321   DMU SMS Templates
52187322 -> 87322   Promise Topay Header
52187323 -> 87323   Promise Topay Card
52187324 -> 87324   Conf Room Appl Card
52187325 -> 87325   Parking Space Creation
52187326 -> 87326   Procurement Role Center
52187327 -> 87327   Promise Topay SMS
52187328 -> 87328   Business Loans
52187329 -> 87329   Records
52187331 -> 87331   Data Migration
52187332 -> 87332   Procurement
52187333 -> 87333   Membership Activity cue
52187334 -> 87334   CustomHeadline
52187335 -> 87335   Promise Topay Header F
52187337 -> 87337   Payroll Activity
52187338 -> 87338   Appealed Lines
52187339 -> 87339   Witheld Tax Obligations On PV
52187340 -> 87340   Legal Cue Page
52187341 -> 87341   Closed Vehicles Card
52187342 -> 87342   Rejected Vehicles Card
52187343 -> 87343   Approved Vehicles Card
52187344 -> 87344   Closed vehicles
52187345 -> 87345   Rejected Vehicles
52187346 -> 87346   Approved Vehicle
52187347 -> 87347   Active Vehicles
52187348 -> 87348   Sales Route Lines
52187349 -> 87349   Closed Cases Card
52187350 -> 87350   ADR Card
52187351 -> 87351   Portfolio Manager Card
52187352 -> 87352   Discharged Securities List
52187353 -> 87353   Security Discharge App Card
52187355 -> 87355   Perfected Securities List
52187356 -> 87356   Approved Vehicle Movt Card
52187357 -> 87357   Rejected Security Perf Card
52187358 -> 87358   Rejected Security Perf. List
52187359 -> 87359   Approved Security Perf. Card
52187360 -> 87360   Nominee Legal Lines
52187361 -> 87361   Other Party Lines
52187362 -> 87362   Approved Security Perf. List
52187363 -> 87363   Key Request Card
52187364 -> 87364   Key Request List
52187365 -> 87365   Vehicle Servicing Card Page
52187366 -> 87366   Vehicle Servicing List Page
52187367 -> 87367   Drivers List
52187368 -> 87368   HR Drivers Card
52187369 -> 87369   Share Certificate Buffer List
52187370 -> 87370   Files List
52187371 -> 87371   Files Card
52187372 -> 87372   Rejected Parking Space - Card
52187373 -> 87373   Rejected Parking Space - List
52187374 -> 87374   Member Card Printing Log
52187376 -> 87376   MNS Parking Space List
52187377 -> 87377   Closed Conf & Meeting - List
52187378 -> 87378   Closed Conf & Meetings - Card
52187379 -> 87379   Rejected Conf & Meeting - Card
52187380 -> 87380   Closed Conf &Meeting - Card
52187381 -> 87381   Rejected Conf & Meeting - List
52187382 -> 87382   Approved Conf & Meeting - List
52187383 -> 87383   Closed Vehicle Req - Card
52187384 -> 87384   Closed Vehicle Req - List
52187385 -> 87385   Rejected Vehicle Req - Card
52187386 -> 87386   Rejected Vehicle Req - List
52187387 -> 87387   Deffered Vehicle Req - Card
52187388 -> 87388   Deffered Vehicle Req - List
52187389 -> 87389   Approved Vehicle Req - Card
52187390 -> 87390   Approved Vehicle Req - List
52187391 -> 87391   Deffered Vehicle Movt - Card
52187392 -> 87392   Admin Cue Page
52187393 -> 87393   Key Details
52187394 -> 87394   Approved Motor Vehicle Mvts
52187395 -> 87395   Approved Vehicle Movements
52187396 -> 87396   Rejected Vehicle Movt - List
52187397 -> 87397   Closed Vehicle Movements
52187398 -> 87398   Rejected Vehicle Movments Card
52187399 -> 87399   Closed Vehicle Movments - List
52187400 -> 87400   Deffered Vehicle Movt - List
52187403 -> 87403   Share capital Transfer Lines
52187404 -> 87404   Posted Share Capital List
52187405 -> 87405   pending ShareCapital List
52187407 -> 87407   Dividend Provision
52187408 -> 87408   Business Loans Members
52187409 -> 87409   Lien Transactions List
52187410 -> 87410   Lien Transactions
52187411 -> 87411   Bosa Salary Appraisal Set-up
52187412 -> 87412   Portfolio Management Lines
52187413 -> 87413   FOSA Payment Voucher List
52187414 -> 87414   FOSA Payment Voucher
52187415 -> 87415   Guarantors List
52187416 -> 87416   Dailly Interest Buffer
52187417 -> 87417   FOSA Payment Lines
52187418 -> 87418   Resheduled Loans Lists
52187419 -> 87419   Approved Rescheduling List
52187420 -> 87420   Mini Std. Purchase Code Card
52187421 -> 87421   Mini Std. Purch. Code Subform
52187422 -> 87422   Mini Standard Vendor Purchase
```

## Page Extension (1566)

```text
52185424 -> 85424   pageextension52185424
52185425 -> 85425   pageextension52185425
52185426 -> 85426   pageextension52185426
52185427 -> 85427   pageextension52185427
52185428 -> 85428   Purchase Quote EXT
52185429 -> 85429   pageextension52185429
52185430 -> 85430   pageextension52185430
52185431 -> 85431   pageextension52185431
52185432 -> 85432   pageextension52185432
52185433 -> 85433   pageextension52185433
52185434 -> 85434   pageextension52185434
52185435 -> 85435   pageextension52185435
52185436 -> 85436   pageextension52185436
52185437 -> 85437   pageextension52185437
52185438 -> 85438   GeneralLedgerEntriesEXT
52185439 -> 85439   pageextension52185439
52185440 -> 85440   pageextension52185440
52185441 -> 85441   pageextension52185441
52185442 -> 85442   pageextension52185442
52185443 -> 85443   pageextension52185443
52185444 -> 85444   pageextension52185444
52185445 -> 85445   pageextension52185445
52185446 -> 85446   pageextension52185446
52185447 -> 85447   pageextension52185447
52185448 -> 85448   pageextension52185448
52185449 -> 85449   pageextension52185449
52185450 -> 85450   pageextension52185450
52185451 -> 85451   pageextension52185451
52185452 -> 85452   pageextension52185452
52185453 -> 85453   SalesLineSubform
52185454 -> 85454   pageextension52185454
52185455 -> 85455   Purchase Quotes Subform Ext
52185456 -> 85456   PostedSalesInvoice
52185457 -> 85457   pageextension52185457
52185459 -> 85459   pageextension52185459
52185461 -> 85461   pageextension52185461
52185462 -> 85462   Bank Deposits Card Extension
52185463 -> 85463   pageextension52185463
52185464 -> 85464   Bank Deposit List
52185465 -> 85465   pageextension52185465
52185466 -> 85466   pageextension52185466
52185467 -> 85467   pageextension52185467
52185468 -> 85468   pageextension52185468
52185469 -> 85469   pageextension52185469
52185470 -> 85470   pageextension52185470
52185471 -> 85471   pageextension52185471
52185472 -> 85472   pageextension52185472
52185473 -> 85473   pageextension52185473
52185479 -> 85479   pageextension52185479
52185480 -> 85480   pageextension52185480
52185481 -> 85481   pageextension52185481
52185482 -> 85482   PostedGeneralJournal
52185484 -> 85484   pageextension52185484
52185485 -> 85485   pageextension52185485
52185486 -> 85486   pageextension52185486
52185487 -> 85487   pageextension52185487
52185488 -> 85488   pageextension52185488
52185489 -> 85489   pageextension52185489
52185491 -> 85491   pageextension52185491
52185492 -> 85492   pageextension52185492
52185493 -> 85493   pageextension52185493
52185494 -> 85494   pageextension52185494
52185495 -> 85495   pageextension52185495
52185496 -> 85496   pageextension52185496
52185498 -> 85498   pageextension52185498
52185499 -> 85499   pageextension52185499
52185500 -> 85500   pageextension52185500
52185501 -> 85501   pageextension52185501
52185502 -> 85502   pageextension52185502
52185503 -> 85503   pageextension52185503
52185505 -> 85505   pageextension52185505
52185506 -> 85506   pageextension52185506
52185507 -> 85507   pageextension52185507
52185508 -> 85508   pageextension52185508
52185509 -> 85509   pageextension52185509
52185510 -> 85510   pageextension52185510
52185511 -> 85511   pageextension52185511
52185512 -> 85512   pageextension52185512
52185513 -> 85513   pageextension52185513
52185514 -> 85514   pageextension52185514
52185515 -> 85515   pageextension52185515
52185516 -> 85516   pageextension52185516
52185517 -> 85517   pageextension52185517
52185518 -> 85518   pageextension52185518
52185519 -> 85519   pageextension52185519
52185520 -> 85520   pageextension52185520
52185522 -> 85522   pageextension52185522
52185523 -> 85523   pageextension52185523
52185524 -> 85524   pageextension52185524
52185525 -> 85525   pageextension52185525
52185526 -> 85526   pageextension52185526
52185527 -> 85527   pageextension52185527
52185528 -> 85528   pageextension52185528
52185529 -> 85529   pageextension52185529
52185530 -> 85530   pageextension52185530
52185531 -> 85531   pageextension52185531
52185532 -> 85532   pageextension52185532
52185533 -> 85533   pageextension52185533
52185534 -> 85534   pageextension52185534
52185535 -> 85535   pageextension52185535
52185536 -> 85536   pageextension52185536
52185537 -> 85537   pageextension52185537
52185538 -> 85538   pageextension52185538
52185539 -> 85539   pageextension52185539
52185540 -> 85540   pageextension52185540
52185541 -> 85541   pageextension52185541
52185542 -> 85542   pageextension52185542
52185543 -> 85543   pageextension52185543
52185544 -> 85544   pageextension52185544
52185545 -> 85545   pageextension52185545
52185546 -> 85546   pageextension52185546
52185547 -> 85547   pageextension52185547
52185548 -> 85548   pageextension52185548
52185549 -> 85549   pageextension52185549
52185550 -> 85550   pageextension52185550
52185551 -> 85551   pageextension52185551
52185553 -> 85553   pageextension52185553
52185554 -> 85554   pageextension52185554
52185555 -> 85555   pageextension52185555
52185556 -> 85556   pageextension52185556
52185557 -> 85557   pageextension52185557
52185558 -> 85558   pageextension52185558
52185559 -> 85559   pageextension52185559
52185561 -> 85561   pageextension52185561
52185562 -> 85562   pageextension52185562
52185563 -> 85563   pageextension52185563
52185564 -> 85564   pageextension52185564
52185565 -> 85565   pageextension52185565
52185566 -> 85566   pageextension52185566
52185567 -> 85567   pageextension52185567
52185570 -> 85570   pageextension52185570
52185571 -> 85571   pageextension52185571
52185572 -> 85572   pageextension52185572
52185573 -> 85573   pageextension52185573
52185574 -> 85574   pageextension52185574
52185575 -> 85575   pageextension52185575
52185576 -> 85576   pageextension52185576
52185577 -> 85577   pageextension52185577
52185578 -> 85578   pageextension52185578
52185579 -> 85579   pageextension52185579
52185580 -> 85580   pageextension52185580
52185581 -> 85581   pageextension52185581
52185582 -> 85582   pageextension52185582
52185583 -> 85583   pageextension52185583
52185584 -> 85584   pageextension52185584
52185585 -> 85585   pageextension52185585
52185586 -> 85586   pageextension52185586
52185589 -> 85589   pageextension52185589
52185590 -> 85590   pageextension52185590
52185591 -> 85591   pageextension52185591
52185592 -> 85592   pageextension52185592
52185593 -> 85593   pageextension52185593
52185594 -> 85594   pageextension52185594
52185595 -> 85595   Users List
52185596 -> 85596   pageextension52185596
52185597 -> 85597   pageextension52185597
52185598 -> 85598   pageextension52185598
52185599 -> 85599   pageextension52185599
52185600 -> 85600   pageextension52185600
52185601 -> 85601   pageextension52185601
52185602 -> 85602   pageextension52185602
52185603 -> 85603   pageextension52185603
52185604 -> 85604   pageextension52185604
52185605 -> 85605   pageextension52185605
52185606 -> 85606   pageextension52185606
52185607 -> 85607   pageextension52185607
52185608 -> 85608   pageextension52185608
52185609 -> 85609   pageextension52185609
52185610 -> 85610   pageextension52185610
52185611 -> 85611   pageextension52185611
52185612 -> 85612   pageextension52185612
52185613 -> 85613   pageextension52185613
52185614 -> 85614   pageextension52185614
52185615 -> 85615   pageextension52185615
52185616 -> 85616   pageextension52185616
52185620 -> 85620   pageextension52185620
52185621 -> 85621   pageextension52185621
52185622 -> 85622   pageextension52185622
52185623 -> 85623   pageextension52185623
52185625 -> 85625   pageextension52185625
52185626 -> 85626   pageextension52185626
52185627 -> 85627   pageextension52185627
52185629 -> 85629   pageextension52185629
52185630 -> 85630   pageextension52185630
52185631 -> 85631   pageextension52185631
52185632 -> 85632   pageextension52185632
52185633 -> 85633   pageextension52185633
52185634 -> 85634   pageextension52185634
52185635 -> 85635   pageextension52185635
52185636 -> 85636   pageextension52185636
52185640 -> 85640   pageextension52185640
52185641 -> 85641   pageextension52185641
52185642 -> 85642   pageextension52185642
52185643 -> 85643   pageextension52185643
52185644 -> 85644   pageextension52185644
52185646 -> 85646   pageextension52185646
52185647 -> 85647   pageextension52185647
52185648 -> 85648   pageextension52185648
52185649 -> 85649   pageextension52185649
52185650 -> 85650   pageextension52185650
52185651 -> 85651   pageextension52185651
52185652 -> 85652   pageextension52185652
52185653 -> 85653   pageextension52185653
52185655 -> 85655   pageextension52185655
52185656 -> 85656   pageextension52185656
52185657 -> 85657   pageextension52185657
52185658 -> 85658   pageextension52185658
52185659 -> 85659   pageextension52185659
52185660 -> 85660   pageextension52185660
52185661 -> 85661   pageextension52185661
52185662 -> 85662   pageextension52185662
52185663 -> 85663   pageextension52185663
52185664 -> 85664   pageextension52185664
52185665 -> 85665   pageextension52185665
52185666 -> 85666   pageextension52185666
52185667 -> 85667   pageextension52185667
52185668 -> 85668   pageextension52185668
52185669 -> 85669   pageextension52185669
52185670 -> 85670   pageextension52185670
52185671 -> 85671   pageextension52185671
52185672 -> 85672   pageextension52185672
52185673 -> 85673   pageextension52185673
52185674 -> 85674   pageextension52185674
52185675 -> 85675   pageextension52185675
52185676 -> 85676   pageextension52185676
52185677 -> 85677   pageextension52185677
52185678 -> 85678   pageextension52185678
52185679 -> 85679   pageextension52185679
52185680 -> 85680   pageextension52185680
52185681 -> 85681   pageextension52185681
52185682 -> 85682   pageextension52185682
52185683 -> 85683   pageextension52185683
52185684 -> 85684   pageextension52185684
52185685 -> 85685   pageextension52185685
52185686 -> 85686   pageextension52185686
52185687 -> 85687   pageextension52185687
52185688 -> 85688   pageextension52185688
52185689 -> 85689   pageextension52185689
52185690 -> 85690   pageextension52185690
52185691 -> 85691   pageextension52185691
52185692 -> 85692   pageextension52185692
52185693 -> 85693   pageextension52185693
52185694 -> 85694   pageextension52185694
52185695 -> 85695   pageextension52185695
52185696 -> 85696   pageextension52185696
52185697 -> 85697   pageextension52185697
52185698 -> 85698   pageextension52185698
52185699 -> 85699   pageextension52185699
52185700 -> 85700   pageextension52185700
52185701 -> 85701   pageextension52185701
52185702 -> 85702   pageextension52185702
52185703 -> 85703   pageextension52185703
52185706 -> 85706   pageextension52185706
52185707 -> 85707   pageextension52185707
52185708 -> 85708   pageextension52185708
52185709 -> 85709   pageextension52185709
52185710 -> 85710   pageextension52185710
52185711 -> 85711   pageextension52185711
52185712 -> 85712   pageextension52185712
52185713 -> 85713   pageextension52185713
52185714 -> 85714   pageextension52185714
52185715 -> 85715   pageextension52185715
52185716 -> 85716   pageextension52185716
52185717 -> 85717   pageextension52185717
52185718 -> 85718   pageextension52185718
52185719 -> 85719   pageextension52185719
52185720 -> 85720   pageextension52185720
52185721 -> 85721   pageextension52185721
52185723 -> 85723   pageextension52185723
52185724 -> 85724   pageextension52185724
52185725 -> 85725   pageextension52185725
52185727 -> 85727   pageextension52185727
52185728 -> 85728   pageextension52185728
52185729 -> 85729   pageextension52185729
52185730 -> 85730   pageextension52185730
52185731 -> 85731   pageextension52185731
52185733 -> 85733   pageextension52185733
52185735 -> 85735   pageextension52185735
52185737 -> 85737   pageextension52185737
52185739 -> 85739   pageextension52185739
52185740 -> 85740   pageextension52185740
52185741 -> 85741   pageextension52185741
52185742 -> 85742   pageextension52185742
52185743 -> 85743   pageextension52185743
52185744 -> 85744   pageextension52185744
52185745 -> 85745   pageextension52185745
52185746 -> 85746   pageextension52185746
52185747 -> 85747   pageextension52185747
52185748 -> 85748   pageextension52185748
52185749 -> 85749   pageextension52185749
52185750 -> 85750   pageextension52185750
52185751 -> 85751   pageextension52185751
52185752 -> 85752   pageextension52185752
52185753 -> 85753   pageextension52185753
52185754 -> 85754   pageextension52185754
52185755 -> 85755   pageextension52185755
52185756 -> 85756   pageextension52185756
52185757 -> 85757   pageextension52185757
52185758 -> 85758   pageextension52185758
52185759 -> 85759   pageextension52185759
52185760 -> 85760   pageextension52185760
52185761 -> 85761   pageextension52185761
52185762 -> 85762   pageextension52185762
52185763 -> 85763   pageextension52185763
52185764 -> 85764   pageextension52185764
52185765 -> 85765   pageextension52185765
52185766 -> 85766   pageextension52185766
52185767 -> 85767   pageextension52185767
52185768 -> 85768   pageextension52185768
52185769 -> 85769   pageextension52185769
52185770 -> 85770   pageextension52185770
52185771 -> 85771   pageextension52185771
52185774 -> 85774   pageextension52185774
52185775 -> 85775   pageextension52185775
52185777 -> 85777   pageextension52185777
52185778 -> 85778   pageextension52185778
52185779 -> 85779   pageextension52185779
52185780 -> 85780   pageextension52185780
52185781 -> 85781   pageextension52185781
52185782 -> 85782   pageextension52185782
52185783 -> 85783   pageextension52185783
52185784 -> 85784   pageextension52185784
52185785 -> 85785   pageextension52185785
52185786 -> 85786   pageextension52185786
52185788 -> 85788   pageextension52185788
52185789 -> 85789   pageextension52185789
52185790 -> 85790   pageextension52185790
52185791 -> 85791   pageextension52185791
52185794 -> 85794   pageextension52185794
52185795 -> 85795   pageextension52185795
52185796 -> 85796   pageextension52185796
52185797 -> 85797   pageextension52185797
52185798 -> 85798   pageextension52185798
52185799 -> 85799   pageextension52185799
52185800 -> 85800   pageextension52185800
52185801 -> 85801   pageextension52185801
52185802 -> 85802   pageextension52185802
52185803 -> 85803   pageextension52185803
52185804 -> 85804   pageextension52185804
52185805 -> 85805   pageextension52185805
52185806 -> 85806   pageextension52185806
52185807 -> 85807   pageextension52185807
52185808 -> 85808   pageextension52185808
52185811 -> 85811   pageextension52185811
52185812 -> 85812   pageextension52185812
52185813 -> 85813   pageextension52185813
52185814 -> 85814   pageextension52185814
52185815 -> 85815   pageextension52185815
52185816 -> 85816   pageextension52185816
52185818 -> 85818   pageextension52185818
52185819 -> 85819   pageextension52185819
52185820 -> 85820   pageextension52185820
52185821 -> 85821   pageextension52185821
52185822 -> 85822   pageextension52185822
52185823 -> 85823   pageextension52185823
52185824 -> 85824   pageextension52185824
52185825 -> 85825   pageextension52185825
52185826 -> 85826   pageextension52185826
52185827 -> 85827   pageextension52185827
52185828 -> 85828   pageextension52185828
52185829 -> 85829   pageextension52185829
52185830 -> 85830   pageextension52185830
52185831 -> 85831   pageextension52185831
52185832 -> 85832   pageextension52185832
52185833 -> 85833   pageextension52185833
52185834 -> 85834   pageextension52185834
52185835 -> 85835   pageextension52185835
52185836 -> 85836   pageextension52185836
52185837 -> 85837   pageextension52185837
52185839 -> 85839   pageextension52185839
52185840 -> 85840   pageextension52185840
52185841 -> 85841   pageextension52185841
52185842 -> 85842   pageextension52185842
52185843 -> 85843   pageextension52185843
52185844 -> 85844   pageextension52185844
52185855 -> 85855   pageextension52185855
52185856 -> 85856   pageextension52185856
52185857 -> 85857   pageextension52185857
52185858 -> 85858   pageextension52185858
52185859 -> 85859   pageextension52185859
52185863 -> 85863   pageextension52185863
52185864 -> 85864   pageextension52185864
52185865 -> 85865   pageextension52185865
52185866 -> 85866   pageextension52185866
52185867 -> 85867   pageextension52185867
52185868 -> 85868   pageextension52185868
52185869 -> 85869   pageextension52185869
52185870 -> 85870   pageextension52185870
52185871 -> 85871   pageextension52185871
52185872 -> 85872   pageextension52185872
52185873 -> 85873   pageextension52185873
52185874 -> 85874   pageextension52185874
52185875 -> 85875   pageextension52185875
52185877 -> 85877   pageextension52185877
52185879 -> 85879   pageextension52185879
52185881 -> 85881   pageextension52185881
52185882 -> 85882   pageextension52185882
52185883 -> 85883   pageextension52185883
52185884 -> 85884   pageextension52185884
52185885 -> 85885   pageextension52185885
52185886 -> 85886   pageextension52185886
52185887 -> 85887   pageextension52185887
52185888 -> 85888   pageextension52185888
52185889 -> 85889   pageextension52185889
52185890 -> 85890   pageextension52185890
52185891 -> 85891   pageextension52185891
52185892 -> 85892   pageextension52185892
52185893 -> 85893   pageextension52185893
52185894 -> 85894   pageextension52185894
52185895 -> 85895   pageextension52185895
52185896 -> 85896   pageextension52185896
52185897 -> 85897   pageextension52185897
52185898 -> 85898   pageextension52185898
52185899 -> 85899   pageextension52185899
52185900 -> 85900   pageextension52185900
52185901 -> 85901   pageextension52185901
52185902 -> 85902   pageextension52185902
52185903 -> 85903   pageextension52185903
52185904 -> 85904   pageextension52185904
52185905 -> 85905   pageextension52185905
52185906 -> 85906   pageextension52185906
52185907 -> 85907   pageextension52185907
52185908 -> 85908   pageextension52185908
52185909 -> 85909   pageextension52185909
52185910 -> 85910   pageextension52185910
52185911 -> 85911   pageextension52185911
52185912 -> 85912   pageextension52185912
52185913 -> 85913   pageextension52185913
52185914 -> 85914   pageextension52185914
52185915 -> 85915   pageextension52185915
52185916 -> 85916   pageextension52185916
52185917 -> 85917   pageextension52185917
52185918 -> 85918   pageextension52185918
52185919 -> 85919   pageextension52185919
52185920 -> 85920   pageextension52185920
52185921 -> 85921   pageextension52185921
52185922 -> 85922   pageextension52185922
52185923 -> 85923   pageextension52185923
52185924 -> 85924   pageextension52185924
52185930 -> 85930   pageextension52185930
52185931 -> 85931   pageextension52185931
52185933 -> 85933   pageextension52185933
52185934 -> 85934   pageextension52185934
52185935 -> 85935   pageextension52185935
52185936 -> 85936   pageextension52185936
52185937 -> 85937   pageextension52185937
52185938 -> 85938   pageextension52185938
52185939 -> 85939   pageextension52185939
52185940 -> 85940   pageextension52185940
52185941 -> 85941   pageextension52185941
52185942 -> 85942   pageextension52185942
52185943 -> 85943   pageextension52185943
52185944 -> 85944   pageextension52185944
52185945 -> 85945   pageextension52185945
52185946 -> 85946   pageextension52185946
52185947 -> 85947   pageextension52185947
52185948 -> 85948   pageextension52185948
52185949 -> 85949   pageextension52185949
52185950 -> 85950   pageextension52185950
52185951 -> 85951   pageextension52185951
52185952 -> 85952   pageextension52185952
52185953 -> 85953   pageextension52185953
52185954 -> 85954   pageextension52185954
52185955 -> 85955   pageextension52185955
52185956 -> 85956   pageextension52185956
52185957 -> 85957   pageextension52185957
52185958 -> 85958   pageextension52185958
52185959 -> 85959   pageextension52185959
52185960 -> 85960   pageextension52185960
52185961 -> 85961   pageextension52185961
52185962 -> 85962   pageextension52185962
52185963 -> 85963   pageextension52185963
52185964 -> 85964   pageextension52185964
52185965 -> 85965   pageextension52185965
52185966 -> 85966   pageextension52185966
52185967 -> 85967   pageextension52185967
52185968 -> 85968   pageextension52185968
52185969 -> 85969   pageextension52185969
52185970 -> 85970   pageextension52185970
52185971 -> 85971   pageextension52185971
52185972 -> 85972   pageextension52185972
52185973 -> 85973   pageextension52185973
52185974 -> 85974   pageextension52185974
52185975 -> 85975   pageextension52185975
52185977 -> 85977   pageextension52185977
52185978 -> 85978   pageextension52185978
52185979 -> 85979   pageextension52185979
52185980 -> 85980   pageextension52185980
52185981 -> 85981   pageextension52185981
52185982 -> 85982   pageextension52185982
52185983 -> 85983   pageextension52185983
52185984 -> 85984   pageextension52185984
52185985 -> 85985   pageextension52185985
52185986 -> 85986   pageextension52185986
52185987 -> 85987   pageextension52185987
52185988 -> 85988   pageextension52185988
52185989 -> 85989   pageextension52185989
52185990 -> 85990   pageextension52185990
52185991 -> 85991   pageextension52185991
52185992 -> 85992   pageextension52185992
52185993 -> 85993   pageextension52185993
52185994 -> 85994   pageextension52185994
52185995 -> 85995   pageextension52185995
52185996 -> 85996   pageextension52185996
52185997 -> 85997   pageextension52185997
52185998 -> 85998   pageextension52185998
52186003 -> 86003   pageextension52186003
52186004 -> 86004   pageextension52186004
52186005 -> 86005   pageextension52186005
52186006 -> 86006   pageextension52186006
52186007 -> 86007   pageextension52186007
52186008 -> 86008   pageextension52186008
52186009 -> 86009   pageextension52186009
52186010 -> 86010   pageextension52186010
52186011 -> 86011   pageextension52186011
52186012 -> 86012   pageextension52186012
52186013 -> 86013   pageextension52186013
52186014 -> 86014   pageextension52186014
52186015 -> 86015   pageextension52186015
52186016 -> 86016   pageextension52186016
52186017 -> 86017   pageextension52186017
52186018 -> 86018   pageextension52186018
52186019 -> 86019   pageextension52186019
52186020 -> 86020   pageextension52186020
52186021 -> 86021   pageextension52186021
52186022 -> 86022   pageextension52186022
52186023 -> 86023   pageextension52186023
52186024 -> 86024   pageextension52186024
52186025 -> 86025   pageextension52186025
52186026 -> 86026   pageextension52186026
52186027 -> 86027   pageextension52186027
52186028 -> 86028   pageextension52186028
52186030 -> 86030   pageextension52186030
52186031 -> 86031   pageextension52186031
52186032 -> 86032   pageextension52186032
52186033 -> 86033   pageextension52186033
52186034 -> 86034   pageextension52186034
52186035 -> 86035   pageextension52186035
52186036 -> 86036   pageextension52186036
52186037 -> 86037   pageextension52186037
52186038 -> 86038   pageextension52186038
52186039 -> 86039   pageextension52186039
52186040 -> 86040   pageextension52186040
52186041 -> 86041   pageextension52186041
52186042 -> 86042   pageextension52186042
52186043 -> 86043   pageextension52186043
52186044 -> 86044   pageextension52186044
52186045 -> 86045   pageextension52186045
52186046 -> 86046   pageextension52186046
52186047 -> 86047   pageextension52186047
52186048 -> 86048   pageextension52186048
52186049 -> 86049   pageextension52186049
52186050 -> 86050   pageextension52186050
52186051 -> 86051   pageextension52186051
52186052 -> 86052   pageextension52186052
52186053 -> 86053   pageextension52186053
52186054 -> 86054   pageextension52186054
52186055 -> 86055   pageextension52186055
52186056 -> 86056   pageextension52186056
52186057 -> 86057   pageextension52186057
52186058 -> 86058   pageextension52186058
52186059 -> 86059   pageextension52186059
52186060 -> 86060   pageextension52186060
52186061 -> 86061   pageextension52186061
52186062 -> 86062   pageextension52186062
52186063 -> 86063   pageextension52186063
52186064 -> 86064   pageextension52186064
52186065 -> 86065   pageextension52186065
52186066 -> 86066   pageextension52186066
52186070 -> 86070   pageextension52186070
52186071 -> 86071   pageextension52186071
52186074 -> 86074   pageextension52186074
52186075 -> 86075   pageextension52186075
52186076 -> 86076   pageextension52186076
52186077 -> 86077   pageextension52186077
52186078 -> 86078   pageextension52186078
52186079 -> 86079   pageextension52186079
52186080 -> 86080   pageextension52186080
52186081 -> 86081   pageextension52186081
52186082 -> 86082   pageextension52186082
52186083 -> 86083   pageextension52186083
52186084 -> 86084   pageextension52186084
52186085 -> 86085   pageextension52186085
52186086 -> 86086   pageextension52186086
52186087 -> 86087   pageextension52186087
52186088 -> 86088   pageextension52186088
52186089 -> 86089   pageextension52186089
52186090 -> 86090   pageextension52186090
52186091 -> 86091   pageextension52186091
52186092 -> 86092   pageextension52186092
52186093 -> 86093   pageextension52186093
52186094 -> 86094   pageextension52186094
52186095 -> 86095   pageextension52186095
52186096 -> 86096   pageextension52186096
52186097 -> 86097   pageextension52186097
52186098 -> 86098   pageextension52186098
52186099 -> 86099   pageextension52186099
52186100 -> 86100   pageextension52186100
52186101 -> 86101   pageextension52186101
52186102 -> 86102   pageextension52186102
52186103 -> 86103   pageextension52186103
52186104 -> 86104   pageextension52186104
52186105 -> 86105   pageextension52186105
52186106 -> 86106   pageextension52186106
52186107 -> 86107   pageextension52186107
52186108 -> 86108   pageextension52186108
52186109 -> 86109   pageextension52186109
52186110 -> 86110   pageextension52186110
52186111 -> 86111   pageextension52186111
52186112 -> 86112   pageextension52186112
52186113 -> 86113   pageextension52186113
52186114 -> 86114   pageextension52186114
52186115 -> 86115   pageextension52186115
52186116 -> 86116   pageextension52186116
52186117 -> 86117   pageextension52186117
52186118 -> 86118   pageextension52186118
52186119 -> 86119   pageextension52186119
52186120 -> 86120   pageextension52186120
52186121 -> 86121   pageextension52186121
52186122 -> 86122   pageextension52186122
52186123 -> 86123   pageextension52186123
52186124 -> 86124   pageextension52186124
52186125 -> 86125   pageextension52186125
52186126 -> 86126   pageextension52186126
52186127 -> 86127   pageextension52186127
52186128 -> 86128   pageextension52186128
52186129 -> 86129   pageextension52186129
52186130 -> 86130   pageextension52186130
52186131 -> 86131   pageextension52186131
52186132 -> 86132   pageextension52186132
52186133 -> 86133   pageextension52186133
52186134 -> 86134   pageextension52186134
52186135 -> 86135   pageextension52186135
52186136 -> 86136   pageextension52186136
52186137 -> 86137   pageextension52186137
52186138 -> 86138   pageextension52186138
52186139 -> 86139   pageextension52186139
52186140 -> 86140   pageextension52186140
52186141 -> 86141   pageextension52186141
52186142 -> 86142   pageextension52186142
52186143 -> 86143   pageextension52186143
52186144 -> 86144   pageextension52186144
52186147 -> 86147   pageextension52186147
52186148 -> 86148   pageextension52186148
52186150 -> 86150   pageextension52186150
52186151 -> 86151   pageextension52186151
52186152 -> 86152   pageextension52186152
52186153 -> 86153   pageextension52186153
52186154 -> 86154   pageextension52186154
52186155 -> 86155   pageextension52186155
52186157 -> 86157   pageextension52186157
52186158 -> 86158   pageextension52186158
52186159 -> 86159   pageextension52186159
52186160 -> 86160   pageextension52186160
52186161 -> 86161   pageextension52186161
52186162 -> 86162   pageextension52186162
52186163 -> 86163   pageextension52186163
52186164 -> 86164   pageextension52186164
52186165 -> 86165   pageextension52186165
52186166 -> 86166   pageextension52186166
52186169 -> 86169   pageextension52186169
52186171 -> 86171   pageextension52186171
52186173 -> 86173   pageextension52186173
52186175 -> 86175   pageextension52186175
52186179 -> 86179   pageextension52186179
52186182 -> 86182   pageextension52186182
52186186 -> 86186   pageextension52186186
52186187 -> 86187   pageextension52186187
52186190 -> 86190   pageextension52186190
52186191 -> 86191   pageextension52186191
52186192 -> 86192   pageextension52186192
52186193 -> 86193   pageextension52186193
52186194 -> 86194   pageextension52186194
52186195 -> 86195   pageextension52186195
52186196 -> 86196   pageextension52186196
52186197 -> 86197   pageextension52186197
52186198 -> 86198   pageextension52186198
52186199 -> 86199   pageextension52186199
52186200 -> 86200   pageextension52186200
52186201 -> 86201   pageextension52186201
52186202 -> 86202   pageextension52186202
52186203 -> 86203   pageextension52186203
52186204 -> 86204   pageextension52186204
52186205 -> 86205   pageextension52186205
52186206 -> 86206   pageextension52186206
52186207 -> 86207   pageextension52186207
52186208 -> 86208   pageextension52186208
52186209 -> 86209   pageextension52186209
52186210 -> 86210   pageextension52186210
52186211 -> 86211   pageextension52186211
52186212 -> 86212   pageextension52186212
52186213 -> 86213   pageextension52186213
52186214 -> 86214   pageextension52186214
52186215 -> 86215   pageextension52186215
52186216 -> 86216   pageextension52186216
52186217 -> 86217   pageextension52186217
52186218 -> 86218   pageextension52186218
52186219 -> 86219   pageextension52186219
52186220 -> 86220   pageextension52186220
52186221 -> 86221   pageextension52186221
52186222 -> 86222   pageextension52186222
52186223 -> 86223   pageextension52186223
52186224 -> 86224   pageextension52186224
52186225 -> 86225   pageextension52186225
52186226 -> 86226   pageextension52186226
52186227 -> 86227   pageextension52186227
52186228 -> 86228   pageextension52186228
52186229 -> 86229   pageextension52186229
52186230 -> 86230   pageextension52186230
52186231 -> 86231   pageextension52186231
52186232 -> 86232   pageextension52186232
52186233 -> 86233   pageextension52186233
52186234 -> 86234   pageextension52186234
52186235 -> 86235   pageextension52186235
52186236 -> 86236   pageextension52186236
52186237 -> 86237   pageextension52186237
52186238 -> 86238   pageextension52186238
52186239 -> 86239   pageextension52186239
52186240 -> 86240   pageextension52186240
52186241 -> 86241   pageextension52186241
52186242 -> 86242   pageextension52186242
52186243 -> 86243   pageextension52186243
52186244 -> 86244   pageextension52186244
52186245 -> 86245   pageextension52186245
52186246 -> 86246   pageextension52186246
52186247 -> 86247   pageextension52186247
52186248 -> 86248   pageextension52186248
52186249 -> 86249   pageextension52186249
52186250 -> 86250   pageextension52186250
52186251 -> 86251   pageextension52186251
52186252 -> 86252   pageextension52186252
52186253 -> 86253   pageextension52186253
52186254 -> 86254   pageextension52186254
52186255 -> 86255   pageextension52186255
52186256 -> 86256   pageextension52186256
52186257 -> 86257   pageextension52186257
52186258 -> 86258   pageextension52186258
52186259 -> 86259   pageextension52186259
52186260 -> 86260   pageextension52186260
52186261 -> 86261   pageextension52186261
52186262 -> 86262   pageextension52186262
52186263 -> 86263   pageextension52186263
52186264 -> 86264   pageextension52186264
52186265 -> 86265   pageextension52186265
52186266 -> 86266   pageextension52186266
52186267 -> 86267   pageextension52186267
52186268 -> 86268   pageextension52186268
52186269 -> 86269   pageextension52186269
52186270 -> 86270   pageextension52186270
52186273 -> 86273   pageextension52186273
52186274 -> 86274   pageextension52186274
52186275 -> 86275   pageextension52186275
52186276 -> 86276   pageextension52186276
52186277 -> 86277   pageextension52186277
52186278 -> 86278   pageextension52186278
52186280 -> 86280   pageextension52186280
52186282 -> 86282   pageextension52186282
52186283 -> 86283   pageextension52186283
52186284 -> 86284   pageextension52186284
52186285 -> 86285   pageextension52186285
52186286 -> 86286   pageextension52186286
52186287 -> 86287   pageextension52186287
52186288 -> 86288   pageextension52186288
52186289 -> 86289   pageextension52186289
52186290 -> 86290   pageextension52186290
52186291 -> 86291   pageextension52186291
52186292 -> 86292   pageextension52186292
52186293 -> 86293   pageextension52186293
52186294 -> 86294   pageextension52186294
52186295 -> 86295   pageextension52186295
52186296 -> 86296   pageextension52186296
52186297 -> 86297   pageextension52186297
52186298 -> 86298   pageextension52186298
52186299 -> 86299   pageextension52186299
52186300 -> 86300   pageextension52186300
52186301 -> 86301   pageextension52186301
52186302 -> 86302   pageextension52186302
52186303 -> 86303   pageextension52186303
52186304 -> 86304   pageextension52186304
52186305 -> 86305   pageextension52186305
52186306 -> 86306   pageextension52186306
52186308 -> 86308   pageextension52186308
52186309 -> 86309   pageextension52186309
52186311 -> 86311   pageextension52186311
52186312 -> 86312   pageextension52186312
52186313 -> 86313   pageextension52186313
52186314 -> 86314   pageextension52186314
52186315 -> 86315   pageextension52186315
52186316 -> 86316   pageextension52186316
52186317 -> 86317   pageextension52186317
52186318 -> 86318   pageextension52186318
52186319 -> 86319   pageextension52186319
52186320 -> 86320   pageextension52186320
52186321 -> 86321   pageextension52186321
52186322 -> 86322   pageextension52186322
52186323 -> 86323   pageextension52186323
52186324 -> 86324   pageextension52186324
52186325 -> 86325   pageextension52186325
52186326 -> 86326   pageextension52186326
52186327 -> 86327   pageextension52186327
52186328 -> 86328   pageextension52186328
52186329 -> 86329   pageextension52186329
52186330 -> 86330   pageextension52186330
52186331 -> 86331   pageextension52186331
52186332 -> 86332   pageextension52186332
52186333 -> 86333   pageextension52186333
52186334 -> 86334   pageextension52186334
52186335 -> 86335   pageextension52186335
52186338 -> 86338   pageextension52186338
52186339 -> 86339   pageextension52186339
52186341 -> 86341   pageextension52186341
52186342 -> 86342   pageextension52186342
52186343 -> 86343   pageextension52186343
52186344 -> 86344   pageextension52186344
52186345 -> 86345   pageextension52186345
52186346 -> 86346   pageextension52186346
52186347 -> 86347   pageextension52186347
52186348 -> 86348   pageextension52186348
52186349 -> 86349   pageextension52186349
52186350 -> 86350   pageextension52186350
52186351 -> 86351   pageextension52186351
52186352 -> 86352   pageextension52186352
52186353 -> 86353   pageextension52186353
52186354 -> 86354   pageextension52186354
52186355 -> 86355   pageextension52186355
52186356 -> 86356   pageextension52186356
52186357 -> 86357   pageextension52186357
52186358 -> 86358   pageextension52186358
52186359 -> 86359   pageextension52186359
52186360 -> 86360   pageextension52186360
52186361 -> 86361   pageextension52186361
52186362 -> 86362   pageextension52186362
52186363 -> 86363   pageextension52186363
52186364 -> 86364   pageextension52186364
52186365 -> 86365   pageextension52186365
52186366 -> 86366   pageextension52186366
52186367 -> 86367   pageextension52186367
52186368 -> 86368   pageextension52186368
52186369 -> 86369   pageextension52186369
52186370 -> 86370   pageextension52186370
52186371 -> 86371   Customer List Ext
52186372 -> 86372   pageextension52186372
52186373 -> 86373   pageextension52186373
52186374 -> 86374   pageextension52186374
52186375 -> 86375   pageextension52186375
52186376 -> 86376   pageextension52186376
52186377 -> 86377   pageextension52186377
52186378 -> 86378   pageextension52186378
52186379 -> 86379   pageextension52186379
52186380 -> 86380   pageextension52186380
52186381 -> 86381   pageextension52186381
52186382 -> 86382   pageextension52186382
52186383 -> 86383   pageextension52186383
52186384 -> 86384   pageextension52186384
52186385 -> 86385   pageextension52186385
52186386 -> 86386   pageextension52186386
52186387 -> 86387   pageextension52186387
52186388 -> 86388   pageextension52186388
52186389 -> 86389   pageextension52186389
52186390 -> 86390   pageextension52186390
52186391 -> 86391   pageextension52186391
52186392 -> 86392   pageextension52186392
52186393 -> 86393   pageextension52186393
52186394 -> 86394   pageextension52186394
52186395 -> 86395   pageextension52186395
52186396 -> 86396   pageextension52186396
52186397 -> 86397   pageextension52186397
52186398 -> 86398   pageextension52186398
52186411 -> 86411   pageextension52186411
52186412 -> 86412   pageextension52186412
52186414 -> 86414   pageextension52186414
52186415 -> 86415   pageextension52186415
52186416 -> 86416   pageextension52186416
52186417 -> 86417   pageextension52186417
52186418 -> 86418   pageextension52186418
52186420 -> 86420   pageextension52186420
52186421 -> 86421   pageextension52186421
52186422 -> 86422   pageextension52186422
52186423 -> 86423   pageextension52186423
52186424 -> 86424   pageextension52186424
52186426 -> 86426   pageextension52186426
52186427 -> 86427   pageextension52186427
52186428 -> 86428   pageextension52186428
52186429 -> 86429   pageextension52186429
52186430 -> 86430   pageextension52186430
52186431 -> 86431   pageextension52186431
52186432 -> 86432   pageextension52186432
52186433 -> 86433   pageextension52186433
52186434 -> 86434   pageextension52186434
52186435 -> 86435   pageextension52186435
52186436 -> 86436   pageextension52186436
52186437 -> 86437   pageextension52186437
52186438 -> 86438   pageextension52186438
52186439 -> 86439   pageextension52186439
52186440 -> 86440   pageextension52186440
52186441 -> 86441   pageextension52186441
52186442 -> 86442   pageextension52186442
52186443 -> 86443   pageextension52186443
52186444 -> 86444   pageextension52186444
52186445 -> 86445   pageextension52186445
52186447 -> 86447   pageextension52186447
52186448 -> 86448   pageextension52186448
52186450 -> 86450   pageextension52186450
52186451 -> 86451   pageextension52186451
52186452 -> 86452   pageextension52186452
52186453 -> 86453   pageextension52186453
52186454 -> 86454   pageextension52186454
52186455 -> 86455   pageextension52186455
52186456 -> 86456   pageextension52186456
52186457 -> 86457   pageextension52186457
52186458 -> 86458   pageextension52186458
52186459 -> 86459   pageextension52186459
52186460 -> 86460   pageextension52186460
52186461 -> 86461   pageextension52186461
52186462 -> 86462   pageextension52186462
52186463 -> 86463   pageextension52186463
52186464 -> 86464   pageextension52186464
52186465 -> 86465   pageextension52186465
52186466 -> 86466   pageextension52186466
52186467 -> 86467   pageextension52186467
52186468 -> 86468   pageextension52186468
52186470 -> 86470   pageextension52186470
52186472 -> 86472   pageextension52186472
52186473 -> 86473   pageextension52186473
52186474 -> 86474   pageextension52186474
52186475 -> 86475   pageextension52186475
52186476 -> 86476   pageextension52186476
52186477 -> 86477   pageextension52186477
52186479 -> 86479   pageextension52186479
52186480 -> 86480   pageextension52186480
52186481 -> 86481   pageextension52186481
52186482 -> 86482   pageextension52186482
52186484 -> 86484   pageextension52186484
52186485 -> 86485   pageextension52186485
52186486 -> 86486   pageextension52186486
52186487 -> 86487   pageextension52186487
52186488 -> 86488   pageextension52186488
52186489 -> 86489   pageextension52186489
52186490 -> 86490   pageextension52186490
52186491 -> 86491   pageextension52186491
52186492 -> 86492   pageextension52186492
52186493 -> 86493   pageextension52186493
52186494 -> 86494   pageextension52186494
52186495 -> 86495   pageextension52186495
52186496 -> 86496   pageextension52186496
52186497 -> 86497   pageextension52186497
52186498 -> 86498   pageextension52186498
52186499 -> 86499   pageextension52186499
52186500 -> 86500   pageextension52186500
52186501 -> 86501   pageextension52186501
52186502 -> 86502   pageextension52186502
52186503 -> 86503   pageextension52186503
52186504 -> 86504   pageextension52186504
52186505 -> 86505   pageextension52186505
52186506 -> 86506   pageextension52186506
52186507 -> 86507   pageextension52186507
52186508 -> 86508   pageextension52186508
52186509 -> 86509   pageextension52186509
52186510 -> 86510   pageextension52186510
52186511 -> 86511   pageextension52186511
52186512 -> 86512   pageextension52186512
52186513 -> 86513   pageextension52186513
52186514 -> 86514   pageextension52186514
52186515 -> 86515   pageextension52186515
52186516 -> 86516   pageextension52186516
52186517 -> 86517   pageextension52186517
52186523 -> 86523   pageextension52186523
52186524 -> 86524   pageextension52186524
52186525 -> 86525   pageextension52186525
52186526 -> 86526   pageextension52186526
52186527 -> 86527   pageextension52186527
52186528 -> 86528   pageextension52186528
52186529 -> 86529   pageextension52186529
52186530 -> 86530   pageextension52186530
52186531 -> 86531   pageextension52186531
52186532 -> 86532   pageextension52186532
52186533 -> 86533   pageextension52186533
52186534 -> 86534   pageextension52186534
52186535 -> 86535   pageextension52186535
52186536 -> 86536   pageextension52186536
52186537 -> 86537   pageextension52186537
52186538 -> 86538   pageextension52186538
52186539 -> 86539   pageextension52186539
52186540 -> 86540   pageextension52186540
52186541 -> 86541   pageextension52186541
52186543 -> 86543   pageextension52186543
52186544 -> 86544   pageextension52186544
52186545 -> 86545   pageextension52186545
52186546 -> 86546   pageextension52186546
52186547 -> 86547   pageextension52186547
52186549 -> 86549   pageextension52186549
52186551 -> 86551   pageextension52186551
52186552 -> 86552   pageextension52186552
52186553 -> 86553   pageextension52186553
52186554 -> 86554   pageextension52186554
52186555 -> 86555   pageextension52186555
52186557 -> 86557   pageextension52186557
52186558 -> 86558   pageextension52186558
52186559 -> 86559   pageextension52186559
52186560 -> 86560   pageextension52186560
52186561 -> 86561   pageextension52186561
52186562 -> 86562   pageextension52186562
52186563 -> 86563   pageextension52186563
52186564 -> 86564   pageextension52186564
52186565 -> 86565   pageextension52186565
52186566 -> 86566   pageextension52186566
52186567 -> 86567   pageextension52186567
52186568 -> 86568   pageextension52186568
52186569 -> 86569   pageextension52186569
52186570 -> 86570   pageextension52186570
52186571 -> 86571   pageextension52186571
52186572 -> 86572   pageextension52186572
52186573 -> 86573   pageextension52186573
52186574 -> 86574   pageextension52186574
52186575 -> 86575   pageextension52186575
52186576 -> 86576   pageextension52186576
52186577 -> 86577   pageextension52186577
52186578 -> 86578   pageextension52186578
52186579 -> 86579   pageextension52186579
52186581 -> 86581   pageextension52186581
52186582 -> 86582   pageextension52186582
52186583 -> 86583   pageextension52186583
52186584 -> 86584   pageextension52186584
52186585 -> 86585   pageextension52186585
52186586 -> 86586   pageextension52186586
52186587 -> 86587   pageextension52186587
52186588 -> 86588   pageextension52186588
52186589 -> 86589   pageextension52186589
52186590 -> 86590   pageextension52186590
52186591 -> 86591   pageextension52186591
52186592 -> 86592   pageextension52186592
52186593 -> 86593   pageextension52186593
52186594 -> 86594   pageextension52186594
52186595 -> 86595   pageextension52186595
52186596 -> 86596   pageextension52186596
52186597 -> 86597   pageextension52186597
52186598 -> 86598   pageextension52186598
52186599 -> 86599   pageextension52186599
52186600 -> 86600   pageextension52186600
52186601 -> 86601   pageextension52186601
52186602 -> 86602   pageextension52186602
52186603 -> 86603   pageextension52186603
52186605 -> 86605   pageextension52186605
52186606 -> 86606   pageextension52186606
52186607 -> 86607   pageextension52186607
52186608 -> 86608   pageextension52186608
52186610 -> 86610   pageextension52186610
52186612 -> 86612   pageextension52186612
52186613 -> 86613   pageextension52186613
52186614 -> 86614   pageextension52186614
52186615 -> 86615   pageextension52186615
52186616 -> 86616   pageextension52186616
52186617 -> 86617   pageextension52186617
52186618 -> 86618   pageextension52186618
52186619 -> 86619   pageextension52186619
52186620 -> 86620   pageextension52186620
52186621 -> 86621   pageextension52186621
52186622 -> 86622   pageextension52186622
52186623 -> 86623   pageextension52186623
52186624 -> 86624   pageextension52186624
52186625 -> 86625   pageextension52186625
52186626 -> 86626   pageextension52186626
52186627 -> 86627   pageextension52186627
52186628 -> 86628   pageextension52186628
52186629 -> 86629   pageextension52186629
52186630 -> 86630   pageextension52186630
52186631 -> 86631   pageextension52186631
52186632 -> 86632   pageextension52186632
52186633 -> 86633   pageextension52186633
52186634 -> 86634   pageextension52186634
52186635 -> 86635   pageextension52186635
52186636 -> 86636   pageextension52186636
52186637 -> 86637   pageextension52186637
52186638 -> 86638   pageextension52186638
52186639 -> 86639   pageextension52186639
52186640 -> 86640   pageextension52186640
52186641 -> 86641   pageextension52186641
52186642 -> 86642   pageextension52186642
52186643 -> 86643   pageextension52186643
52186644 -> 86644   pageextension52186644
52186645 -> 86645   pageextension52186645
52186646 -> 86646   pageextension52186646
52186647 -> 86647   pageextension52186647
52186648 -> 86648   pageextension52186648
52186649 -> 86649   pageextension52186649
52186650 -> 86650   pageextension52186650
52186651 -> 86651   pageextension52186651
52186652 -> 86652   pageextension52186652
52186653 -> 86653   pageextension52186653
52186654 -> 86654   pageextension52186654
52186655 -> 86655   pageextension52186655
52186656 -> 86656   pageextension52186656
52186657 -> 86657   pageextension52186657
52186658 -> 86658   pageextension52186658
52186659 -> 86659   pageextension52186659
52186660 -> 86660   pageextension52186660
52186661 -> 86661   pageextension52186661
52186662 -> 86662   pageextension52186662
52186663 -> 86663   pageextension52186663
52186664 -> 86664   pageextension52186664
52186665 -> 86665   pageextension52186665
52186666 -> 86666   pageextension52186666
52186667 -> 86667   pageextension52186667
52186668 -> 86668   pageextension52186668
52186669 -> 86669   pageextension52186669
52186670 -> 86670   pageextension52186670
52186671 -> 86671   pageextension52186671
52186672 -> 86672   pageextension52186672
52186673 -> 86673   pageextension52186673
52186674 -> 86674   pageextension52186674
52186675 -> 86675   pageextension52186675
52186676 -> 86676   pageextension52186676
52186677 -> 86677   pageextension52186677
52186678 -> 86678   pageextension52186678
52186679 -> 86679   pageextension52186679
52186680 -> 86680   pageextension52186680
52186681 -> 86681   pageextension52186681
52186682 -> 86682   pageextension52186682
52186683 -> 86683   pageextension52186683
52186684 -> 86684   pageextension52186684
52186685 -> 86685   pageextension52186685
52186686 -> 86686   pageextension52186686
52186687 -> 86687   pageextension52186687
52186688 -> 86688   pageextension52186688
52186689 -> 86689   pageextension52186689
52186690 -> 86690   pageextension52186690
52186691 -> 86691   pageextension52186691
52186692 -> 86692   pageextension52186692
52186693 -> 86693   pageextension52186693
52186694 -> 86694   pageextension52186694
52186695 -> 86695   pageextension52186695
52186696 -> 86696   pageextension52186696
52186697 -> 86697   pageextension52186697
52186698 -> 86698   pageextension52186698
52186699 -> 86699   pageextension52186699
52186700 -> 86700   pageextension52186700
52186701 -> 86701   pageextension52186701
52186702 -> 86702   pageextension52186702
52186703 -> 86703   pageextension52186703
52186704 -> 86704   pageextension52186704
52186705 -> 86705   pageextension52186705
52186706 -> 86706   pageextension52186706
52186707 -> 86707   pageextension52186707
52186708 -> 86708   pageextension52186708
52186709 -> 86709   pageextension52186709
52186710 -> 86710   pageextension52186710
52186711 -> 86711   pageextension52186711
52186712 -> 86712   pageextension52186712
52186713 -> 86713   pageextension52186713
52186714 -> 86714   pageextension52186714
52186715 -> 86715   pageextension52186715
52186716 -> 86716   pageextension52186716
52186717 -> 86717   pageextension52186717
52186718 -> 86718   pageextension52186718
52186719 -> 86719   pageextension52186719
52186720 -> 86720   pageextension52186720
52186721 -> 86721   pageextension52186721
52186722 -> 86722   pageextension52186722
52186723 -> 86723   pageextension52186723
52186724 -> 86724   pageextension52186724
52186725 -> 86725   pageextension52186725
52186726 -> 86726   pageextension52186726
52186727 -> 86727   pageextension52186727
52186728 -> 86728   pageextension52186728
52186729 -> 86729   pageextension52186729
52186730 -> 86730   pageextension52186730
52186731 -> 86731   pageextension52186731
52186732 -> 86732   pageextension52186732
52186733 -> 86733   pageextension52186733
52186734 -> 86734   pageextension52186734
52186735 -> 86735   pageextension52186735
52186736 -> 86736   pageextension52186736
52186737 -> 86737   pageextension52186737
52186738 -> 86738   pageextension52186738
52186739 -> 86739   pageextension52186739
52186740 -> 86740   pageextension52186740
52186741 -> 86741   pageextension52186741
52186742 -> 86742   pageextension52186742
52186743 -> 86743   pageextension52186743
52186744 -> 86744   pageextension52186744
52186745 -> 86745   pageextension52186745
52186746 -> 86746   pageextension52186746
52186747 -> 86747   pageextension52186747
52186749 -> 86749   pageextension52186749
52186750 -> 86750   pageextension52186750
52186751 -> 86751   pageextension52186751
52186752 -> 86752   pageextension52186752
52186753 -> 86753   pageextension52186753
52186754 -> 86754   pageextension52186754
52186755 -> 86755   pageextension52186755
52186756 -> 86756   pageextension52186756
52186757 -> 86757   pageextension52186757
52186758 -> 86758   pageextension52186758
52186759 -> 86759   pageextension52186759
52186760 -> 86760   pageextension52186760
52186761 -> 86761   pageextension52186761
52186762 -> 86762   pageextension52186762
52186763 -> 86763   pageextension52186763
52186764 -> 86764   pageextension52186764
52186766 -> 86766   pageextension52186766
52186767 -> 86767   pageextension52186767
52186768 -> 86768   pageextension52186768
52186769 -> 86769   pageextension52186769
52186771 -> 86771   pageextension52186771
52186772 -> 86772   pageextension52186772
52186773 -> 86773   pageextension52186773
52186774 -> 86774   pageextension52186774
52186776 -> 86776   pageextension52186776
52186777 -> 86777   pageextension52186777
52186778 -> 86778   pageextension52186778
52186779 -> 86779   pageextension52186779
52186780 -> 86780   pageextension52186780
52186781 -> 86781   pageextension52186781
52186782 -> 86782   pageextension52186782
52186783 -> 86783   pageextension52186783
52186784 -> 86784   pageextension52186784
52186785 -> 86785   pageextension52186785
52186786 -> 86786   pageextension52186786
52186787 -> 86787   pageextension52186787
52186788 -> 86788   pageextension52186788
52186789 -> 86789   pageextension52186789
52186790 -> 86790   pageextension52186790
52186791 -> 86791   pageextension52186791
52186792 -> 86792   pageextension52186792
52186793 -> 86793   pageextension52186793
52186794 -> 86794   pageextension52186794
52186802 -> 86802   pageextension52186802
52186803 -> 86803   pageextension52186803
52186804 -> 86804   pageextension52186804
52186805 -> 86805   pageextension52186805
52186806 -> 86806   pageextension52186806
52186807 -> 86807   pageextension52186807
52186808 -> 86808   pageextension52186808
52186809 -> 86809   pageextension52186809
52186810 -> 86810   pageextension52186810
52186811 -> 86811   pageextension52186811
52186812 -> 86812   pageextension52186812
52186813 -> 86813   pageextension52186813
52186814 -> 86814   pageextension52186814
52186815 -> 86815   pageextension52186815
52186816 -> 86816   pageextension52186816
52186818 -> 86818   pageextension52186818
52186819 -> 86819   pageextension52186819
52186820 -> 86820   pageextension52186820
52186821 -> 86821   pageextension52186821
52186822 -> 86822   pageextension52186822
52186823 -> 86823   pageextension52186823
52186824 -> 86824   pageextension52186824
52186825 -> 86825   pageextension52186825
52186826 -> 86826   pageextension52186826
52186827 -> 86827   pageextension52186827
52186828 -> 86828   pageextension52186828
52186833 -> 86833   pageextension52186833
52186834 -> 86834   pageextension52186834
52186844 -> 86844   pageextension52186844
52186845 -> 86845   pageextension52186845
52186846 -> 86846   pageextension52186846
52186847 -> 86847   pageextension52186847
52186848 -> 86848   pageextension52186848
52186849 -> 86849   pageextension52186849
52186850 -> 86850   pageextension52186850
52186851 -> 86851   pageextension52186851
52186852 -> 86852   pageextension52186852
52186853 -> 86853   pageextension52186853
52186854 -> 86854   pageextension52186854
52186855 -> 86855   pageextension52186855
52186856 -> 86856   pageextension52186856
52186858 -> 86858   pageextension52186858
52186859 -> 86859   pageextension52186859
52186860 -> 86860   pageextension52186860
52186861 -> 86861   pageextension52186861
52186862 -> 86862   pageextension52186862
52186863 -> 86863   pageextension52186863
52186864 -> 86864   pageextension52186864
52186865 -> 86865   pageextension52186865
52186866 -> 86866   pageextension52186866
52186867 -> 86867   pageextension52186867
52186868 -> 86868   pageextension52186868
52186869 -> 86869   pageextension52186869
52186870 -> 86870   pageextension52186870
52186872 -> 86872   pageextension52186872
52186873 -> 86873   pageextension52186873
52186875 -> 86875   pageextension52186875
52186876 -> 86876   pageextension52186876
52186877 -> 86877   pageextension52186877
52186879 -> 86879   pageextension52186879
52186880 -> 86880   pageextension52186880
52186881 -> 86881   pageextension52186881
52186882 -> 86882   pageextension52186882
52186883 -> 86883   pageextension52186883
52186884 -> 86884   pageextension52186884
52186885 -> 86885   pageextension52186885
52186886 -> 86886   pageextension52186886
52186887 -> 86887   pageextension52186887
52186888 -> 86888   pageextension52186888
52186889 -> 86889   pageextension52186889
52186890 -> 86890   pageextension52186890
52186891 -> 86891   pageextension52186891
52186892 -> 86892   pageextension52186892
52186894 -> 86894   pageextension52186894
52186897 -> 86897   pageextension52186897
52186899 -> 86899   pageextension52186899
52186900 -> 86900   pageextension52186900
52186901 -> 86901   pageextension52186901
52186902 -> 86902   pageextension52186902
52186903 -> 86903   pageextension52186903
52186904 -> 86904   pageextension52186904
52186905 -> 86905   pageextension52186905
52186906 -> 86906   pageextension52186906
52186907 -> 86907   pageextension52186907
52186908 -> 86908   pageextension52186908
52186909 -> 86909   pageextension52186909
52186910 -> 86910   pageextension52186910
52186911 -> 86911   pageextension52186911
52186912 -> 86912   pageextension52186912
52186913 -> 86913   pageextension52186913
52186914 -> 86914   pageextension52186914
52186915 -> 86915   pageextension52186915
52186916 -> 86916   pageextension52186916
52186917 -> 86917   pageextension52186917
52186919 -> 86919   pageextension52186919
52186920 -> 86920   pageextension52186920
52186921 -> 86921   pageextension52186921
52186922 -> 86922   pageextension52186922
52186923 -> 86923   pageextension52186923
52186924 -> 86924   pageextension52186924
52186925 -> 86925   pageextension52186925
52186926 -> 86926   pageextension52186926
52186927 -> 86927   pageextension52186927
52186928 -> 86928   pageextension52186928
52186929 -> 86929   pageextension52186929
52186930 -> 86930   pageextension52186930
52186931 -> 86931   pageextension52186931
52186932 -> 86932   pageextension52186932
52186933 -> 86933   pageextension52186933
52186934 -> 86934   pageextension52186934
52186935 -> 86935   pageextension52186935
52186936 -> 86936   pageextension52186936
52186937 -> 86937   pageextension52186937
52186938 -> 86938   pageextension52186938
52186939 -> 86939   pageextension52186939
52186940 -> 86940   pageextension52186940
52186941 -> 86941   pageextension52186941
52186942 -> 86942   pageextension52186942
52186943 -> 86943   pageextension52186943
52186944 -> 86944   pageextension52186944
52186945 -> 86945   pageextension52186945
52186946 -> 86946   pageextension52186946
52186947 -> 86947   pageextension52186947
52186948 -> 86948   pageextension52186948
52186949 -> 86949   pageextension52186949
52186951 -> 86951   pageextension52186951
52186952 -> 86952   pageextension52186952
52186953 -> 86953   pageextension52186953
52186954 -> 86954   pageextension52186954
52186955 -> 86955   pageextension52186955
52186956 -> 86956   pageextension52186956
52186957 -> 86957   pageextension52186957
52186958 -> 86958   pageextension52186958
52186959 -> 86959   pageextension52186959
52186960 -> 86960   pageextension52186960
52186961 -> 86961   pageextension52186961
52186962 -> 86962   pageextension52186962
52186963 -> 86963   pageextension52186963
52186964 -> 86964   pageextension52186964
52186965 -> 86965   pageextension52186965
52186966 -> 86966   pageextension52186966
52186967 -> 86967   pageextension52186967
52186968 -> 86968   pageextension52186968
52186969 -> 86969   pageextension52186969
52186970 -> 86970   pageextension52186970
52186971 -> 86971   pageextension52186971
52186972 -> 86972   pageextension52186972
52186973 -> 86973   pageextension52186973
52186974 -> 86974   pageextension52186974
52186975 -> 86975   pageextension52186975
52186976 -> 86976   pageextension52186976
52186977 -> 86977   pageextension52186977
52186978 -> 86978   pageextension52186978
52186979 -> 86979   pageextension52186979
52186980 -> 86980   pageextension52186980
52186981 -> 86981   pageextension52186981
52186982 -> 86982   pageextension52186982
52186983 -> 86983   pageextension52186983
52186984 -> 86984   pageextension52186984
52186986 -> 86986   pageextension52186986
52186987 -> 86987   pageextension52186987
52186990 -> 86990   pageextension52186990
52186994 -> 86994   pageextension52186994
52186998 -> 86998   pageextension52186998
52187001 -> 87001   pageextension52187001
52187002 -> 87002   pageextension52187002
52187003 -> 87003   pageextension52187003
52187006 -> 87006   pageextension52187006
52187008 -> 87008   pageextension52187008
52187010 -> 87010   pageextension52187010
52187011 -> 87011   pageextension52187011
52187012 -> 87012   pageextension52187012
52187013 -> 87013   pageextension52187013
52187015 -> 87015   pageextension52187015
52187016 -> 87016   pageextension52187016
52187017 -> 87017   pageextension52187017
52187018 -> 87018   pageextension52187018
52187019 -> 87019   pageextension52187019
52187020 -> 87020   pageextension52187020
52187021 -> 87021   pageextension52187021
52187022 -> 87022   pageextension52187022
52187023 -> 87023   pageextension52187023
52187024 -> 87024   pageextension52187024
52187025 -> 87025   pageextension52187025
52187027 -> 87027   pageextension52187027
52187028 -> 87028   pageextension52187028
52187029 -> 87029   pageextension52187029
52187031 -> 87031   pageextension52187031
52187032 -> 87032   pageextension52187032
52187033 -> 87033   pageextension52187033
52187034 -> 87034   pageextension52187034
52187035 -> 87035   pageextension52187035
52187036 -> 87036   pageextension52187036
52187037 -> 87037   pageextension52187037
52187038 -> 87038   pageextension52187038
52187039 -> 87039   pageextension52187039
52187040 -> 87040   pageextension52187040
52187041 -> 87041   pageextension52187041
52187042 -> 87042   pageextension52187042
52187043 -> 87043   pageextension52187043
52187044 -> 87044   pageextension52187044
52187045 -> 87045   pageextension52187045
52187046 -> 87046   pageextension52187046
52187047 -> 87047   pageextension52187047
52187048 -> 87048   pageextension52187048
52187049 -> 87049   pageextension52187049
52187050 -> 87050   pageextension52187050
52187051 -> 87051   pageextension52187051
52187052 -> 87052   pageextension52187052
52187053 -> 87053   pageextension52187053
52187054 -> 87054   pageextension52187054
52187055 -> 87055   pageextension52187055
52187057 -> 87057   pageextension52187057
52187058 -> 87058   pageextension52187058
52187059 -> 87059   pageextension52187059
52187060 -> 87060   pageextension52187060
52187061 -> 87061   pageextension52187061
52187062 -> 87062   pageextension52187062
52187063 -> 87063   pageextension52187063
52187064 -> 87064   pageextension52187064
52187065 -> 87065   pageextension52187065
52187068 -> 87068   pageextension52187068
52187071 -> 87071   pageextension52187071
52187072 -> 87072   pageextension52187072
52187073 -> 87073   pageextension52187073
52187074 -> 87074   pageextension52187074
52187075 -> 87075   pageextension52187075
52187076 -> 87076   pageextension52187076
52187077 -> 87077   pageextension52187077
52187078 -> 87078   pageextension52187078
52187079 -> 87079   pageextension52187079
52187083 -> 87083   pageextension52187083
52187084 -> 87084   pageextension52187084
52187085 -> 87085   pageextension52187085
52187086 -> 87086   pageextension52187086
52187087 -> 87087   pageextension52187087
52187088 -> 87088   pageextension52187088
52187089 -> 87089   pageextension52187089
52187090 -> 87090   pageextension52187090
52187091 -> 87091   pageextension52187091
52187092 -> 87092   pageextension52187092
52187093 -> 87093   pageextension52187093
52187094 -> 87094   pageextension52187094
52187095 -> 87095   pageextension52187095
52187096 -> 87096   pageextension52187096
52187097 -> 87097   pageextension52187097
52187098 -> 87098   pageextension52187098
52187099 -> 87099   pageextension52187099
52187100 -> 87100   pageextension52187100
52187101 -> 87101   pageextension52187101
52187102 -> 87102   pageextension52187102
52187103 -> 87103   pageextension52187103
52187105 -> 87105   pageextension52187105
52187106 -> 87106   pageextension52187106
52187107 -> 87107   pageextension52187107
52187108 -> 87108   pageextension52187108
52187109 -> 87109   pageextension52187109
52187110 -> 87110   pageextension52187110
52187111 -> 87111   pageextension52187111
52187112 -> 87112   pageextension52187112
52187113 -> 87113   pageextension52187113
52187114 -> 87114   pageextension52187114
52187115 -> 87115   pageextension52187115
52187116 -> 87116   pageextension52187116
52187118 -> 87118   pageextension52187118
52187119 -> 87119   pageextension52187119
52187120 -> 87120   pageextension52187120
52187121 -> 87121   pageextension52187121
52187122 -> 87122   pageextension52187122
52187123 -> 87123   pageextension52187123
52187124 -> 87124   pageextension52187124
52187125 -> 87125   pageextension52187125
52187126 -> 87126   pageextension52187126
52187127 -> 87127   pageextension52187127
52187128 -> 87128   pageextension52187128
52187129 -> 87129   pageextension52187129
52187130 -> 87130   pageextension52187130
52187131 -> 87131   pageextension52187131
52187132 -> 87132   pageextension52187132
52187133 -> 87133   pageextension52187133
52187134 -> 87134   pageextension52187134
52187135 -> 87135   pageextension52187135
52187136 -> 87136   pageextension52187136
52187138 -> 87138   pageextension52187138
52187140 -> 87140   pageextension52187140
52187141 -> 87141   pageextension52187141
52187142 -> 87142   pageextension52187142
52187143 -> 87143   pageextension52187143
52187144 -> 87144   pageextension52187144
52187145 -> 87145   pageextension52187145
52187146 -> 87146   pageextension52187146
52187147 -> 87147   pageextension52187147
52187148 -> 87148   pageextension52187148
52187149 -> 87149   pageextension52187149
52187150 -> 87150   pageextension52187150
52187151 -> 87151   pageextension52187151
52187152 -> 87152   pageextension52187152
52187153 -> 87153   pageextension52187153
52187154 -> 87154   pageextension52187154
52187155 -> 87155   pageextension52187155
52187156 -> 87156   pageextension52187156
52187157 -> 87157   pageextension52187157
52187158 -> 87158   pageextension52187158
52187159 -> 87159   pageextension52187159
52187160 -> 87160   pageextension52187160
52187161 -> 87161   pageextension52187161
52187166 -> 87166   pageextension52187166
52187167 -> 87167   pageextension52187167
52187168 -> 87168   pageextension52187168
52187169 -> 87169   pageextension52187169
52187170 -> 87170   pageextension52187170
52187171 -> 87171   pageextension52187171
52187172 -> 87172   pageextension52187172
52187173 -> 87173   pageextension52187173
52187174 -> 87174   pageextension52187174
52187184 -> 87184   pageextension52187184
52187187 -> 87187   pageextension52187187
52187188 -> 87188   pageextension52187188
52187189 -> 87189   pageextension52187189
52187191 -> 87191   pageextension52187191
52187192 -> 87192   pageextension52187192
52187193 -> 87193   pageextension52187193
52187198 -> 87198   pageextension52187198
52187199 -> 87199   pageextension52187199
52187201 -> 87201   pageextension52187201
52187205 -> 87205   pageextension52187205
52187207 -> 87207   pageextension52187207
52187208 -> 87208   pageextension52187208
52187211 -> 87211   pageextension52187211
52187212 -> 87212   pageextension52187212
52187216 -> 87216   pageextension52187216
52187217 -> 87217   pageextension52187217
52187218 -> 87218   pageextension52187218
52187219 -> 87219   pageextension52187219
52187234 -> 87234   pageextension52187234
52187235 -> 87235   pageextension52187235
52187236 -> 87236   pageextension52187236
52187237 -> 87237   pageextension52187237
52187238 -> 87238   pageextension52187238
52187301 -> 87301   CustomerCardExtension
```

## Report (921)

```text
52185423 -> 85423   Posted Loans Checkoff
52185424 -> 85424   Request for Quotation
52185425 -> 85425   Sales Routes Plan Report
52185426 -> 85426   One Month Installment
52185427 -> 85427   Available Parking Slots
52185428 -> 85428   Trial Balance Custom
52185429 -> 85429   Perfection Register
52185430 -> 85430   Create Journals
52185431 -> 85431   Loan Ageing Report
52185432 -> 85432   Release Guarantor
52185433 -> 85433   SMS Alerts
52185434 -> 85434   CRB Monthly Manual
52185435 -> 85435   Guarantor Substitution Report
52185436 -> 85436   NDA Contract
52185437 -> 85437   Bankers Cheque Report
52185438 -> 85438   Agent Transactions
52185439 -> 85439   All Tellers Cash Report
52185440 -> 85440   Bank Acc. Recononciliation
52185441 -> 85441   Withdrawal Summary
52185442 -> 85442   Mod Already Approved Batches
52185443 -> 85443   DPA Contract
52185444 -> 85444   Missing Ba Ledgers Entry Recon
52185445 -> 85445   Withdrawal Reasons
52185446 -> 85446   End of Day Reconciliation
52185447 -> 85447   DMU Case Forwarded
52185448 -> 85448   Ideal Repayment Schedule
52185449 -> 85449   Incomplete Application Report
52185450 -> 85450   Edit Audit Trail
52185451 -> 85451   Closure Listing
52185452 -> 85452   Upgrade Member Class
52185453 -> 85453   Unit Report
52185454 -> 85454   Account Activation Details
52185455 -> 85455   ClearedCheques
52185456 -> 85456   Validate translation Table
52185457 -> 85457   +Cashier Deposit Slip
52185458 -> 85458   Staff Imprests Report
52185459 -> 85459   Lease Escalation
52185460 -> 85460   Inter Bank Cheque
52185461 -> 85461   Update Images
52185462 -> 85462   CRB Monthly Attached
52185463 -> 85463   HR Jobs
52185464 -> 85464   HR Job Occupants
52185465 -> 85465   HR Jobs (Vacant)
52185466 -> 85466   HR Jobs (Occupied)
52185467 -> 85467   HR Job Responsibilities
52185468 -> 85468   HR Job Requirements
52185469 -> 85469   HR Job Applications
52185470 -> 85470   HR Overtime Report
52185471 -> 85471   HR Company Activities
52185472 -> 85472   Images Upload+
52185473 -> 85473   Poppulate Image Data
52185474 -> 85474   Leave Carry Forward
52185475 -> 85475   PR Company Totals
52185476 -> 85476   HR Employee List
52185477 -> 85477   HR Staff Supervisor
52185478 -> 85478   HR Leave Adjustment
52185479 -> 85479   Next of kin Allocation Report
52185480 -> 85480   HR Leave Application
52185481 -> 85481   HR Leave Statement
52185482 -> 85482   HR Leave Reimbursements
52185483 -> 85483   HR Leave Applications List
52185484 -> 85484   Actual Loan Schedule
52185485 -> 85485   HR Leave Summary
52185486 -> 85486   HR Applicant to Employee
52185487 -> 85487   Performance
52185488 -> 85488   HR Disciplinary Cases
52185489 -> 85489   HR Disciplinary Cases List
52185490 -> 85490   HR Transport Requisitions
52185491 -> 85491   Leave Balance
52185492 -> 85492   HR Training Needs
52185493 -> 85493   NSSF Tier II
52185494 -> 85494   Standing Order Report
52185495 -> 85495   HR Leave Balances
52185496 -> 85496   Counter Summary Report
52185497 -> 85497   Employee Confirmation Report
52185498 -> 85498   HR Leave Balance2
52185499 -> 85499   HR Leave Balance Summary
52185500 -> 85500   HR Create Leave Year
52185501 -> 85501   HR Medical Scheme Allotement
52185502 -> 85502   HR Medical Scheme Allotement S
52185503 -> 85503   Flagged Accounts
52185504 -> 85504   HR Suggest Participants OLD
52185505 -> 85505   HR Shift Closure
52185506 -> 85506   HR Suggest Participants
52185507 -> 85507   Deductions With Employer Contr
52185508 -> 85508   Petty Cash Expenses Report
52185509 -> 85509   Update Loan income Entries
52185510 -> 85510   Tellers Journal
52185511 -> 85511   Master Payroll Report
52185512 -> 85512   PR Individual Payslip wat
52185513 -> 85513   Loan Apprisal Report-Group
52185514 -> 85514   Asset Finance Loans
52185515 -> 85515   Tenant Escalation
52185516 -> 85516   prAllowances Report
52185517 -> 85517   prDeductions Report
52185518 -> 85518   Posted Tenant Receipt
52185519 -> 85519   P9
52185520 -> 85520   P10A
52185521 -> 85521   P10
52185522 -> 85522   PR Payroll Summary
52185523 -> 85523   PR NHIF
52185524 -> 85524   Recruitment Cost Report
52185525 -> 85525   PR Other PR Customers (Listin)
52185526 -> 85526   PR Bank Summary
52185527 -> 85527   PR E-Mail Individual Payslip
52185528 -> 85528   prPayroll Details
52185529 -> 85529   PR Individual Payslip
52185530 -> 85530   prMonthly Variance
52185531 -> 85531   Update Employee Loans Report
52185532 -> 85532   Member Balances Report
52185533 -> 85533   prPayroll Cheque Details
52185534 -> 85534   prBank Payments
52185535 -> 85535   prOther Payments
52185536 -> 85536   Store Analysis
52185537 -> 85537   Employee Pay Element Summary
52185538 -> 85538   Other Deductions
52185539 -> 85539   Expired Leases
52185540 -> 85540   Insurance Deposit Report
52185541 -> 85541   prGross Reconcilliation
52185542 -> 85542   Lease Report
52185543 -> 85543   Payroll Variation Requests
52185544 -> 85544   Schedule All Loans
52185545 -> 85545   New Employee Advise
52185546 -> 85546   Overtime Claim
52185547 -> 85547   Leases Approaching Expiry
52185548 -> 85548   Control Summary Report
52185549 -> 85549   Overtime Analysis
52185550 -> 85550   Deductions to Organizations
52185551 -> 85551   CreateAccountsProducts
52185552 -> 85552   prSalary Advise Slip
52185553 -> 85553   Staff Clearance Report
52185554 -> 85554   prLoan Payment History
52185555 -> 85555   Terminated Leases
52185556 -> 85556   Validate Employee Transactions
52185557 -> 85557   Recover Entrance Fee Report
52185558 -> 85558   Guarantor Substitution Form
52185559 -> 85559   Online M Application Report
52185560 -> 85560   Validate Salary Card
52185561 -> 85561   Buildings Report
52185562 -> 85562   Withdrawal Notice Form
52185563 -> 85563   Payroll - Global
52185564 -> 85564   pr1/3 Basic Pay
52185565 -> 85565   Reconciliation - By Entry/Exit
52185566 -> 85566   Service Charges
52185567 -> 85567   Negative Pay List
52185568 -> 85568   Payroll Summary
52185569 -> 85569   Bank Payment Schedule
52185570 -> 85570   Vacated Offices Per Period
52185571 -> 85571   Account Transfer
52185572 -> 85572   Employee Earnings Summary
52185573 -> 85573   PrAllowances Summary
52185574 -> 85574   PrDeductions Summary
52185575 -> 85575   Validate Employee Period
52185576 -> 85576   Generate Saving Advice
52185579 -> 85579   Clear Weekend OT
52185580 -> 85580   Up-Process Variations
52185581 -> 85581   Clear Old Code Variations
52185582 -> 85582   Mark as DOES NOT pay PAYE
52185583 -> 85583   Mark as PAYS PAYE
52185584 -> 85584   Update Employee PAYE
52185586 -> 85586   Gross Reconcilliation
52185587 -> 85587   prStaff Pension Contribution
52185588 -> 85588   Period Trans without Employee
52185589 -> 85589   Job Interview results
52185590 -> 85590   Litigaton Cases By Cost
52185591 -> 85591   Shortlisting Report
52185592 -> 85592   Payroll Summary Simplified
52185593 -> 85593   SSNIT TIER 1
52185594 -> 85594   SSNIT TIER 2
52185595 -> 85595   prUpdateNetPay
52185596 -> 85596   prPaye Report
52185597 -> 85597   prPaye Report-redeployed
52185598 -> 85598   prPaye Report-redeployed2
52185600 -> 85600   Email Payslips PDF
52185603 -> 85603   Onboarding Report Per Class
52185605 -> 85605   Dividend Statement
52185606 -> 85606   Approve Jobs Batch
52185607 -> 85607   UnApprove Jobs Batch
52185609 -> 85609   Generate Mass Transactions
52185610 -> 85610   Validate into SalCard
52185611 -> 85611   G/L Update Consolidation
52185612 -> 85612   Approve Employees Batch
52185613 -> 85613   UnApprove Employees Batch
52185614 -> 85614   Bank Income Statement Lists
52185615 -> 85615   Bank Acc. Recons
52185616 -> 85616   Member Application Register
52185617 -> 85617   Accounts Application Register
52185619 -> 85619   Member Register
52185620 -> 85620   Accounts Application Summary
52185621 -> 85621   Member Statement
52185622 -> 85622   M-SACCO Report.
52185623 -> 85623   Generate Advice Loans
52185624 -> 85624   Dividend Generation
52185625 -> 85625   Dividend Posting Buffer
52185626 -> 85626   Contract Expiry report
52185627 -> 85627   Dividend Posting
52185628 -> 85628   Dividend Register
52185629 -> 85629   Dividend Slip
52185630 -> 85630   FOSA Savings Register
52185631 -> 85631   Savings Statement
52185632 -> 85632   Member Card
52185633 -> 85633   Credit Register
52185634 -> 85634   Standing Order Processing
52185636 -> 85636   Clear Cheque Report
52185637 -> 85637   Deposit To Shares Transfer
52185638 -> 85638   Generate Dormant Accounts
52185640 -> 85640   Loan Appraisal Report-Salaried
52185641 -> 85641   Loan Appraisal - Bus
52185642 -> 85642   FOSA Loan Register
52185643 -> 85643   Fixed Deposit Certificate
52185644 -> 85644   Loan Disbursement Schedule
52185645 -> 85645   Loan Register
52185646 -> 85646   Check Mutiple Salary
52185647 -> 85647   Get Salary RTGS
52185648 -> 85648   Checkoff Advice - Products
52185649 -> 85649   Edits Applications
52185650 -> 85650   Uploaded Non Created Members
52185651 -> 85651   Checkoff Advice - Savings
52185652 -> 85652   Standing Order RTGS
52185653 -> 85653   Checkoff Advice Variance
52185654 -> 85654   End Year Savings Intetest
52185655 -> 85655   Business Evaluation
52185656 -> 85656   Checkoff Advice - Loans
52185657 -> 85657   Member Application Channels
52185658 -> 85658   Suggest Disbursement
52185659 -> 85659   SASRA Loan Categorization
52185660 -> 85660   Loans Defaulter Aging - SASRA
52185661 -> 85661   Escalation For Leases
52185663 -> 85663   Cheque Print
52185664 -> 85664   Bank Acc. Recon Manual
52185665 -> 85665   PR Transfer To Journal Bills
52185667 -> 85667   Loans Datasheet Employer
52185669 -> 85669   Position on Borrowers in Sacco
52185671 -> 85671   Savings Datasheet Employer
52185672 -> 85672   Delegate Loans Register
52185673 -> 85673   Cheque Print Imprest
52185674 -> 85674   Insurance Next of Kin
52185675 -> 85675   Loans Provisioning Summary
52185676 -> 85676   Member Loan Statement II
52185677 -> 85677   Loan Statement
52185678 -> 85678   Standing Orders Register
52185680 -> 85680   Treasury Coinage.
52185681 -> 85681   Process Cheques
52185682 -> 85682   Update Inward File Buffer
52185683 -> 85683   Cashier Withdrawal Slip
52185684 -> 85684   Cashier Deposit Slip
52185685 -> 85685   Cashier CHDeposit Slip
52185686 -> 85686   Legal Notifications
52185687 -> 85687   Cashier Transactions
52185688 -> 85688   prNSSF
52185689 -> 85689   CashierCredit Deposit Slip
52185690 -> 85690   Bankers Cheque Slip
52185691 -> 85691   prGrossNetPay
52185693 -> 85693   prPayrollSummary-List
52185694 -> 85694   Pension Summary
52185695 -> 85695   Employee Requisiton Report
52185696 -> 85696   Fixed Asset Transfer Report
52185697 -> 85697   Standing Order
52185698 -> 85698   Standing Order Register
52185699 -> 85699   Member Detailed Statement
52185700 -> 85700   Loan Approved Schedule
52185701 -> 85701   Loan Repayment Dues
52185702 -> 85702   Member Details Check Report
52185703 -> 85703   BBF Claim TAT Report
52185704 -> 85704   Admin Notificaitions
52185705 -> 85705   Transfer Net Pay To Fosa
52185706 -> 85706   Withdrawal Notices
52185707 -> 85707   User Posting Dates Update
52185708 -> 85708   Bank Acc. Recon 2015
52185709 -> 85709   Bank Acc. Recon Manual new
52185710 -> 85710   Clear Lien Process
52185711 -> 85711   Birthday Reminders
52185712 -> 85712   User Groups Permision Report
52185714 -> 85714   Sasra Loan Register
52185715 -> 85715   Sasra Deposit Accounts BOSA
52185716 -> 85716   Sasra Staff Access Granted
52185717 -> 85717   Sasra Staff Positions
52185718 -> 85718   Sasra Deposit Accounts Others
52185719 -> 85719   Unpaid Deposits Claims
52185720 -> 85720   Monthly Bill Summary
52185721 -> 85721   Loan Repayment Dues Summaries
52185722 -> 85722   ATM Link Report
52185723 -> 85723   Board Payment Voucher
52185724 -> 85724   M-Sacco Application Report
52185725 -> 85725   Actual Repayment Schedule
52185726 -> 85726   Resignation Slip
52185727 -> 85727   Loan Guarators Reports
52185728 -> 85728   Loan Guaranteed
52185729 -> 85729   Posted Salaries Report
52185730 -> 85730   Posted Checkoff Receipts
52185731 -> 85731   Delegates Payments Reports
52185732 -> 85732   Agent Transactions Report
52185733 -> 85733   Agent Tarriffs Report
52185734 -> 85734   Agent Applications Report
52185735 -> 85735   Anniversary Reminders
52185736 -> 85736   Unpaid Delegate Claims
52185737 -> 85737   Security Report
52185738 -> 85738   Dividend Register Summary
52185739 -> 85739   Loans Movement Report
52185740 -> 85740   SASRA Deposit Return
52185741 -> 85741   Members Summary Report
52185742 -> 85742   Loan SMS Notice
52185743 -> 85743   Dividend Register Filtered
52185744 -> 85744   Calculate Fixed Interest
52185745 -> 85745   Loan Appraisal Checkoff
52185746 -> 85746   Charge Monthly Fee
52185747 -> 85747   Loan Appraisal Bus-Special
52185748 -> 85748   Update Payroll Deductions
52185749 -> 85749   Delegate Payment Report
52185750 -> 85750   Employers Expected Due
52185751 -> 85751   Loan Bills
52185752 -> 85752   Savings Accounts Register
52185753 -> 85753   ATM Activation Report
52185754 -> 85754   Loan Attachment
52185755 -> 85755   Compute Daily Interest
52185756 -> 85756   Generate Monthly Interest
52185757 -> 85757   Premier Loan Report
52185758 -> 85758   Interest Due Period
52185759 -> 85759   Sales Agents Performance
52185760 -> 85760   Duplicate RTGS Transfer Lines
52185761 -> 85761   RTGS Report
52185762 -> 85762   Pending Insurance Claims
52185763 -> 85763   Closed Insurance Claims
52185768 -> 85768   Sink Fund Notice Report
52185769 -> 85769   Contract Status
52185770 -> 85770   Detailed Contract Report
52185772 -> 85772   Tenor Loan Register
52185773 -> 85773   Pending Withdrawal Notices
52185774 -> 85774   KYC Report
52185775 -> 85775   HR Loan Repayment Schedule
52185776 -> 85776   PR iTax Report
52185777 -> 85777   Helb Report
52185778 -> 85778   Members with Incomplete Data
52185779 -> 85779   Employer Data Sheet
52185780 -> 85780   Staff Claims Voucher
52185781 -> 85781   Receipt
52185782 -> 85782   Payment Voucher
52185783 -> 85783   Imprest Voucher
52185784 -> 85784   Datasheet
52185785 -> 85785   Store Requisition
52185786 -> 85786   Interbank Details
52185788 -> 85788   Daily Cashier Summary 2
52185791 -> 85791   Outstanding IOU Report
52185792 -> 85792   Cash Payment Vouchers
52185793 -> 85793   Secured Loans Report
52185794 -> 85794   Imprest Requisition Report
52185795 -> 85795   Leave Approvers Report
52185796 -> 85796   Employee Detailed Report
52185797 -> 85797   Update Central Payment
52185798 -> 85798   Bank Payments Report
52185800 -> 85800   Share Variation
52185802 -> 85802   Update Budget Dimensions
52185804 -> 85804   Modify Item Ledger
52185805 -> 85805   BOSA Combined Report
52185806 -> 85806   Adjust Bank Ledger To Open
52185808 -> 85808   Dividends Capitalization
52185809 -> 85809   Vendor Payment Advice
52185810 -> 85810   Surety Report
52185812 -> 85812   Perfection Template II
52185813 -> 85813   Salary increment
52185814 -> 85814   Execution Form
52185815 -> 85815   Item Availability Notification
52185816 -> 85816   Training needs
52185817 -> 85817   Monthly Cont.
52185818 -> 85818   Delegates Listing
52185819 -> 85819   Standing Order II
52185820 -> 85820   Salary Accounts List Report
52185821 -> 85821   RFQ Report
52185822 -> 85822   Transferred Share Capital Cert
52185823 -> 85823   Purchase Requisition
52185824 -> 85824   Bulk Account Refunds Report
52185825 -> 85825   Exit Clearance
52185827 -> 85827   Procurement Requisition
52185828 -> 85828   HR Training Appl list
52185829 -> 85829   Staff Training Request Form
52185830 -> 85830   Cheque Confirmation
52185831 -> 85831   Posted Cheque Confirmation
52185833 -> 85833   Surety Management Report
52185834 -> 85834   Avocate Cost Report
52185835 -> 85835   Case Cost
52185836 -> 85836   Advocate Report
52185837 -> 85837   Contract Report
52185838 -> 85838   Case Report
52185839 -> 85839   Case Status Report
52185840 -> 85840   HR Leave Balance
52185841 -> 85841   Partial Resignation Slip
52185842 -> 85842   Recover Overpaid Loans
52185843 -> 85843   Interest Calculation
52185844 -> 85844   Property Vacancy Schedule
52185845 -> 85845   Tenancy Schedule
52185846 -> 85846   Tenant Leases
52185847 -> 85847   Billing and Collection
52185848 -> 85848   Investor Invoice
52185849 -> 85849   Vendor History Report
52185851 -> 85851   Update Mismatched HR Loans
52185852 -> 85852   Staff On Leave
52185853 -> 85853   PR NSSF NEW
52185854 -> 85854   Savings Accounts List
52185855 -> 85855   Checkoff Trans Report
52185856 -> 85856   Tenant Invoices
52185857 -> 85857   Change member status deceased
52185858 -> 85858   Update Posted
52185859 -> 85859   Update Picked Mobile Loan
52185860 -> 85860   Reimburse Recalled Leave Days
52185861 -> 85861   PR Company FixedTC Totals
52185862 -> 85862   prGrossNetPay FxedTC
52185864 -> 85864   Loan Appraisal Haramb-Shamba
52185865 -> 85865   Salary Through Fosa Report
52185866 -> 85866   Dormant Savings Accounts
52185868 -> 85868   Update Can Gurantee Loan
52185869 -> 85869   Salary Agreement
52185870 -> 85870   Salary Agreement Report
52185872 -> 85872   Rent Escalation
52185873 -> 85873   Sky Stmt Loan Report B64.
52185874 -> 85874   Sky Stmt xlsx Report B64 B.
52185875 -> 85875   Sky Stmt xlsx Loan Report B64.
52185876 -> 85876   PR Individual Payslip b64
52185878 -> 85878   Mobile Loan Appraisal Analysis
52185879 -> 85879   BBF TAT
52185880 -> 85880   Dividend Slip B64
52185882 -> 85882   Update Virtual Members
52185883 -> 85883   Salary Agreement Counter
52185884 -> 85884   Member application Report
52185885 -> 85885   CRM Loan Guaranteed
52185886 -> 85886   Board Payment Voucher Report
52185887 -> 85887   Staff Payment Voucher Report
52185888 -> 85888   Delegate Meeting Report
52185889 -> 85889   Computer Register Asset
52185890 -> 85890   CRM Loan Guarators Reports
52185891 -> 85891   HR Employee List Report
52185892 -> 85892   Imprest Surrender Report
52185893 -> 85893   Un-Surrendered Imprests
52185894 -> 85894   Calculate Fixed Interest- CBS
52185895 -> 85895   Process Fixed Deposit
52185896 -> 85896   Fixed Deposit Receipt
52185897 -> 85897   Sink Fund Report
52185898 -> 85898   Staff Claims Report
52185899 -> 85899   Loan Product Summaries
52185900 -> 85900   BBF Loan Register
52185901 -> 85901   Update Status
52185902 -> 85902   Member Statement-Detailed
52185903 -> 85903   Account Statement
52185904 -> 85904   Loan Issued Summary
52185906 -> 85906   Risk Provisioning
52185907 -> 85907   Security Job Queue 
52185908 -> 85908   Members with Expected Reg Fee
52185909 -> 85909   Membership TAT Report
52185910 -> 85910   Net Salary Report
52185911 -> 85911   Msacco Application
52185912 -> 85912   Member Portfolio
52185913 -> 85913   Generate CRB Data
52185915 -> 85915   Member Guarantors Report
52185917 -> 85917   First Notice
52185918 -> 85918   Delegates Payment  List
52185919 -> 85919   Customer Numbers
52185920 -> 85920   Sink Fund Receipt Report
52185921 -> 85921   Detailed Payroll Transactions
52185922 -> 85922   Batch Loan Register
52185923 -> 85923   Clear Update Employer Code
52185926 -> 85926   Direct Debit Report
52185927 -> 85927   Loan Repayment Schedule-calc
52185928 -> 85928   Member Statement-H.Users
52185931 -> 85931   Summary Unlocated A/C
52185932 -> 85932   Deligates Registration
52185933 -> 85933   Member Withdrawal Notice
52185934 -> 85934   Item Report
52185935 -> 85935   Recovered Registration Fees
52185938 -> 85938   Update Blank Loanee Name
52185939 -> 85939   Employer Statement
52185940 -> 85940   Members Age
52185941 -> 85941   Over Recoveries Report
52185942 -> 85942   Update Lien
52185943 -> 85943   Sinkfund not paid
52185944 -> 85944   Loan Recovery Variance
52185945 -> 85945   Process Rejected Loans
52185946 -> 85946   Junior Saving Account Balances
52185947 -> 85947   Overdue Imprest Notification
52185948 -> 85948   Member W/T Beneficiary
52185949 -> 85949   Member W/T KIN
52185950 -> 85950   Modify NOK Marked Beneficiary
52185951 -> 85951   Assets Marked For Disposal
52185952 -> 85952   Insert SinkFund PF No
52185953 -> 85953   Insert Closure PF No
52185954 -> 85954   Insert Closure Notice PF No
52185955 -> 85955   NOK With Principle Mem ID No.
52185956 -> 85956   Update Loan Instalments
52185957 -> 85957   Loan Appraisal Haramb-Mortgage
52185958 -> 85958   Loan Movement Summary
52185959 -> 85959   Loans Movement Report II
52185960 -> 85960   Fixed Assets By Category
52185961 -> 85961   CheckOff Summary
52185962 -> 85962   CheckOff Summary Monthly
52185963 -> 85963   CheckOff Summary II
52185964 -> 85964   Fixed Asset Register
52185965 -> 85965   Group Members Report
52185966 -> 85966   Modify Self Guarantee Loans
52185968 -> 85968   Salary Not Through FOSA
52185969 -> 85969   Non Salaried Loans Granted
52185970 -> 85970   Claimed Branch Allocation
52185971 -> 85971   Overtime Hours Worked1
52185972 -> 85972   Msacco Loans Report
52185973 -> 85973   ATM Upload Report
52185974 -> 85974   prBoard Payslip
52185975 -> 85975   prBoard Payslip 2
52185976 -> 85976   prBoard Summary
52185977 -> 85977   Defaulter Notice-2
52185978 -> 85978   Defaulter Notice-3
52185979 -> 85979   ReceiptLIne Report
52185980 -> 85980   Loans Provisioning Summary1
52185981 -> 85981   Atm Card Report
52185982 -> 85982   UnClaimed Branch Allocation
52185983 -> 85983   Loans Cleared Early
52185984 -> 85984   Membership Closure Report
52185985 -> 85985   Defaulter Notice-1
52185986 -> 85986   Fixed Asset Movement Schedule
52185987 -> 85987   Term Loan-Offer Letter
52185988 -> 85988   Loan Interest  Register
52185989 -> 85989   Account Transfer Report
52185990 -> 85990   Fixed Deposit Register
52185991 -> 85991   Savings & Loans Listings
52185992 -> 85992   JV Report
52185993 -> 85993   Atm Cards Report
52185994 -> 85994   Delegates Loan Register New
52185995 -> 85995   Leased Assets & Obligations
52185996 -> 85996   FA Depreciation History
52185998 -> 85998   Benevolent Claim Slip
52185999 -> 85999   Global Variance Report
52186000 -> 86000   Anti-Money Laundering Report
52186001 -> 86001   Delegates Payment Voucher
52186002 -> 86002   Salary Agreement List
52186003 -> 86003   Membership Declaration
52186004 -> 86004   Sectoral Lending
52186006 -> 86006   Delegates Correspondence
52186007 -> 86007   General Purpose Update
52186008 -> 86008   Delegates Returns Report
52186009 -> 86009   Complaints and Suggestions
52186011 -> 86011   Dividend Checks
52186012 -> 86012   Pre Dividend Checks
52186013 -> 86013   NPL Per Product
52186014 -> 86014   Dividend Advance Checks
52186015 -> 86015   Categorised Complaints
52186016 -> 86016   Defaulted MB Appraisal
52186017 -> 86017   Insurance Valuation Report
52186018 -> 86018   Generate Bulk Refunds
52186019 -> 86019   Member Application
52186020 -> 86020   BOSA Accounts Fall-Off Report
52186021 -> 86021   Insider Lending Report
52186022 -> 86022   Duplicate Deduction Report
52186023 -> 86023   Recruited By Report
52186024 -> 86024   Leave Discrepancy Report
52186025 -> 86025   Employer Member Report
52186026 -> 86026   Employer Shares and Loans
52186027 -> 86027   Loan Arrears Report
52186028 -> 86028   Dormant Deposit Listing Report
52186029 -> 86029   Loan Variation Report
52186030 -> 86030   Disposal Requisition Report
52186031 -> 86031   Defaulted Fresh Loans
52186032 -> 86032   Recovered Fresh Loans
52186033 -> 86033   BBF - Insurance Claim Report
52186034 -> 86034   Staff Daily Transactions
52186035 -> 86035   CRB Daily Report
52186036 -> 86036   Reappotionment Report
52186037 -> 86037   Member Receipt Report
52186038 -> 86038   Surrendered Imprests Report
52186039 -> 86039   Employer Email Status
52186040 -> 86040   Employer Shares & Loans
52186041 -> 86041   Delegate Claims Report
52186042 -> 86042   Delegate PaySlip
52186043 -> 86043   Staff Member Balances
52186044 -> 86044   HrNextofKin
52186045 -> 86045   StaffPosition
52186046 -> 86046   TrainingAttendees
52186047 -> 86047   Employee Bonding
52186048 -> 86048   Overtime Claim Cost
52186049 -> 86049   SeparationTypes
52186050 -> 86050   EmployeesExit
52186051 -> 86051   Staff Welfare Claims
52186052 -> 86052   Employer Comparison Report
52186053 -> 86053   Deposits Arreas Report
52186054 -> 86054   Loan Fall Off
52186055 -> 86055   Petty Cash
52186056 -> 86056   Paid Dividends
52186057 -> 86057   Fixed Assets Report
52186058 -> 86058   G/l Budget Report
52186059 -> 86059   Discrepancies Report 
52186060 -> 86060   Withdrawal TAT Report
52186061 -> 86061   Share Capital fee
52186062 -> 86062   Purchase Order
52186063 -> 86063   BBF/Risk/entrance fees/Depo
52186064 -> 86064   Posted Invoices
52186065 -> 86065   Over/Under Recovery Loans Rep
52186066 -> 86066   Membership Closure TAT Report
52186067 -> 86067   CRB Daily Manual
52186068 -> 86068   Unrecov. Reg Fee/BBF/Risk/Shar
52186069 -> 86069   Unallocated Amounts Report
52186070 -> 86070   Expected Loan Repayment
52186071 -> 86071   Flag Email Reminder
52186072 -> 86072   Right To Use Assets
52186073 -> 86073   Membership Closure Summary
52186074 -> 86074   Employee Value Change
52186075 -> 86075   Transfered Fixed Assets
52186076 -> 86076   Conference Booking Calendar
52186077 -> 86077   Reversed Invoices & Receipts
52186078 -> 86078   Recovery Fresh Loans Summary
52186079 -> 86079   CRM Savings's Statement
52186080 -> 86080   CRM Loan Guaranteed Reports
52186081 -> 86081   Tenants Electricity Charges
52186082 -> 86082   CRM Member Loan Statement
52186083 -> 86083   CRM Checkoff Advice Variance
52186084 -> 86084   CRM Loan RePayment Schedule
52186085 -> 86085   Training Evaluation
52186087 -> 86087   Overdue Files Notification
52186088 -> 86088   Tenant Statement
52186089 -> 86089   Archived Files
52186090 -> 86090   Unreconcilled Transactions
52186091 -> 86091   Overdue Files
52186092 -> 86092   Bank Recon Custom
52186093 -> 86093   Bank Reconcilliation report
52186094 -> 86094   Custom Bank Detail Trial Bal.
52186095 -> 86095   Loan Offer Letter Buss Loans
52186096 -> 86096   Bank Transactions Aging report
52186097 -> 86097   Member Cards Awaiting Printing
52186098 -> 86098   Customer Statement1
52186099 -> 86099   Revenue Collection Report
52186100 -> 86100   File Movement Report
52186101 -> 86101   Files Due For Archiving
52186102 -> 86102   Loans TAT Report
52186103 -> 86103   CRM Dividend Slip
52186104 -> 86104   Self Service Slip
52186106 -> 86106   Unsurrendered Imprest Aging
52186107 -> 86107   Loans TAT
52186108 -> 86108    Loan Variation TAT
52186109 -> 86109   Deposit Variation 
52186110 -> 86110   Risk Claims Report
52186111 -> 86111   BBF Insurance
52186112 -> 86112   New Members Report
52186113 -> 86113   BBF Insurance TAT
52186114 -> 86114   Risk Claim TAT Report
52186115 -> 86115   Institutional Capital TAT
52186116 -> 86116   Members Without Loan Report
52186117 -> 86117   Guarantor Substitution TAT
52186118 -> 86118   Member Withdrawal TAT
52186119 -> 86119   Member Edit TAT Report
52186120 -> 86120   Petty Cash FOSA Report
52186121 -> 86121   CRM Member TAT Report 
52186122 -> 86122   Employer Allocation Report
52186123 -> 86123   Marketing Commission
52186124 -> 86124   Member Commission
52186125 -> 86125   Detailed Loan TAT Report
52186126 -> 86126   Amounts Received - Loans
52186127 -> 86127   Amounts Received - Deposit A/c
52186128 -> 86128   Amounts Received Summary - Dep
52186130 -> 86130   AML Report Transactions
52186131 -> 86131   AML First Transactions
52186132 -> 86132   Sub Accounts Commission
52186133 -> 86133   Generate Daily Interest (NEW)
52186134 -> 86134   Sales Invoice Printout
52186135 -> 86135   Shares Commission
52186136 -> 86136   Share Variation Commission
52186137 -> 86137   Change Paypoint Commission
52186138 -> 86138   Loans Daily Interest
52186139 -> 86139   Normal/Petty Payment Voucher
52186140 -> 86140   FOSA Loan Disbursement
52186141 -> 86141   FOSA Account Page List
52186142 -> 86142   Loan Arrears Report - Finance
52186143 -> 86143   Member Share By Category
52186144 -> 86144   Member Lifetime Value
52186145 -> 86145   Loan Products Report
52186146 -> 86146   Deposits Accumulated Over Time
52186147 -> 86147   Savings Products Report
52186148 -> 86148   FOSA Account Activation
52186149 -> 86149   All Loans Product
52186150 -> 86150   FOSA Insider Lending
52186151 -> 86151   Salary Accounts Report
52186152 -> 86152   FOSA Treasury Report
52186153 -> 86153   Ind Member Lifetime Value Rep
52186154 -> 86154   FOSA Treasury Controls
52186155 -> 86155   Fosa Overdrawn Accounts
52186156 -> 86156   Contract Templates
52186157 -> 86157   Finance Share Certificate
52186158 -> 86158   Legal Share Capital Register
52186159 -> 86159   Tenant Printout
52186160 -> 86160   MPESA Bank Bal Report
52186161 -> 86161   Detailed Daily Cashier
52186162 -> 86162   Loan Offer Letter
52186163 -> 86163   Custom Detail Trial Bal.
52186164 -> 86164   New Customer Aging Report
52186165 -> 86165   Loan Variance Report
52186166 -> 86166   Teller Specifications Report
52186167 -> 86167   Loan Collection Report
52186168 -> 86168   Create Member Files
52186169 -> 86169   Cashier Deposits Withdrawals
52186170 -> 86170   Goods Receive Note
52186171 -> 86171   Cashier Cheque Deposits
52186172 -> 86172   Sacco Cheque Register
52186173 -> 86173   FA Forecast Depreciation
52186174 -> 86174   Lease Job
52186176 -> 86176   Delete From PR Transactioncode
52186177 -> 86177   Fringe Benefit
52186178 -> 86178   MovementScheduleII
52186179 -> 86179   Pr Variance Report
52186180 -> 86180   Daily Transactions Report
52186181 -> 86181   Delegate Claims II
52186182 -> 86182   MoveShcedule
52186183 -> 86183   Mobile Banking Report
52186184 -> 86184   Reccurring FA Journals Report
52186185 -> 86185   Partial Closure Slip
52186186 -> 86186   Approved  Loans
52186187 -> 86187   Vendor Payments
52186188 -> 86188   LeaveCost to payroll
52186189 -> 86189   User Roles and Permissions
52186190 -> 86190   Loans Autorecovery
52186191 -> 86191   Loan Attachment II
52186192 -> 86192   Loan Reappotionment Report II
52186193 -> 86193   Loan Detachment II
52186194 -> 86194   Triggered Checkoff Advice
52186195 -> 86195   Employer Movement Report
52186196 -> 86196   Slary List Report
52186197 -> 86197   Investment Movement Report
52186198 -> 86198   Tenant Movement Report
52186199 -> 86199   Loan Monthly Receipt Report
52186200 -> 86200   Activate BOSA Accounts
52186201 -> 86201   Loan Excempted Charges
52186202 -> 86202   AutocreateProducts
52186203 -> 86203   MemberNoticeRemainingDYS
52186204 -> 86204   Loan Appraisal Hybrid
52186205 -> 86205   Appraisal Loan Report
52186206 -> 86206   Members With Pictures
52186207 -> 86207   Loan Insurance Report
52186208 -> 86208   ClearLoanBalless100
52186209 -> 86209   Eligibilty Check
52186210 -> 86210   Member Portal Dependancy App
52186211 -> 86211   Retirement Job Queue
52186212 -> 86212   Generate Bulk SMS Lines
52186213 -> 86213   Loans without STO
52186214 -> 86214   Payroll Variance Report
52186216 -> 86216   Business Loans TAT
52186217 -> 86217   Update Loan Repayment Mode
52186218 -> 86218   Calculate Depreciation Custom
52186219 -> 86219   Unallocated Distribution
52186220 -> 86220   Member Readmission TAT
52186221 -> 86221   UpdateDormantAccounts
52186222 -> 86222   User Matrix Report
52186223 -> 86223   Sync Member & Accounts
52186224 -> 86224   Generate Actual progression
52186225 -> 86225   Update Member Closure Date
52186226 -> 86226   Unblock / Block Div Adv
52186227 -> 86227   Batch Block
52186228 -> 86228   FD Interest Update
52186229 -> 86229   Update Guaranteed Amount
52186230 -> 86230   UpdateData
52186231 -> 86231   Total Loans Guaranteed Report
52186232 -> 86232   EX member Creditors
52186233 -> 86233   Update Employee Members
52186234 -> 86234   Clear Approved Entries
52186235 -> 86235   Refund Excess I to P
52186236 -> 86236   Recover Loans Below 100
52186237 -> 86237   Recover Arrears
52186238 -> 86238   Recover FOSA Arrears
52186241 -> 86241   End Year Interest Report
52186242 -> 86242   ReverseEntries
52186243 -> 86243   Dividend SMS
52186336 -> 86336   Total Expenditure
52186339 -> 86339   Dispatched Nominee Forms
52186341 -> 86341   InventoryStock
52186342 -> 86342   Individual Usage Report
52186343 -> 86343   Disposal Report
52186344 -> 86344   Shortlisted Candidates
52186370 -> 86370   Leave Costing
52186371 -> 86371   Purchase Requisition Form
52186378 -> 86378   Checkoff Report
52186391 -> 86391   Monthly Receipt 
52186392 -> 86392    Loan Monthly Receipt 
52186393 -> 86393   BBF_Risk_entr fees_Dep Falloff
52186394 -> 86394   Expected BOSA Contributions
52186395 -> 86395   Tenant Outstanding Balance
52186396 -> 86396   Tenant Income Earned
52186397 -> 86397   Tenant Receipt
52186398 -> 86398   Reg Fee Arrears
52186399 -> 86399   Invest Historical Comparison
52186400 -> 86400   EmployeeAppointment report
52186505 -> 86505   Loan Summary Register
52186506 -> 86506   Unit Loan Summary Register
52186507 -> 86507   Self Service Slip Portal
52186508 -> 86508   P9 Portal
52186509 -> 86509   Product Loan Summary Register
52186519 -> 86519   Loan Application Report
52186520 -> 86520   Mobile Loans Repayment Update
52186567 -> 86567   Fully Depreciated Assets
52186600 -> 86600   Department Targets Report
52186601 -> 86601   Employee Target Assignment Rpt
52186602 -> 86602   Individual Targets Report
52186603 -> 86603   Appraisal Summary Report
52186604 -> 86604   Appraisal Appeal Report
52186605 -> 86605   Perspective Analysis Report
52186719 -> 86719   Loan Appraisal Staff
52186730 -> 86730   Process Interest Calculation
52186731 -> 86731   Employer Member Register
52186732 -> 86732   Tenant Debtor Listing
52186733 -> 86733   RFQ Printout
52186734 -> 86734   Tenant Arrears Report
52186764 -> 86764   prP9A-test  new
52186788 -> 86788   Member Balance Register
52186789 -> 86789   FOSA Account Change Logs
52186790 -> 86790   Loan Detachment
52186791 -> 86791   CRB Monthly Report
52186792 -> 86792   Notices Report
52186793 -> 86793   Attachment Certtificate
52186794 -> 86794   Loan FallOff Report
52186795 -> 86795   Process FallOff
52186796 -> 86796   Second Notice
52186797 -> 86797   Guarantor Notice
52186798 -> 86798   Recovery Header II Update
52186800 -> 86800   Commercial Loan buyoffs
52186801 -> 86801   Customer Report
52186809 -> 86809   Loan Actual Payment Schedule
52186827 -> 86827   Investment Receipt
52186830 -> 86830   Posted Tenants Receipt
52186831 -> 86831   Shares, BBF & Risk Analysis
52186832 -> 86832   Tenant Listing
52186833 -> 86833   Waived Tenants
52186835 -> 86835   Restructured Loans report
52186836 -> 86836   Reversed Loans Report
52186837 -> 86837   Training Planner
52186839 -> 86839   Vacant Offices Report
52186840 -> 86840   AllTransactions
52186842 -> 86842   Overtime Needs Request
52186843 -> 86843   Separation dues
52186849 -> 86849   FA Period Depreciation Report
52186850 -> 86850   Loans Underway Report
52186856 -> 86856   Checkoff Advice Consolidated
52186857 -> 86857   Customer Summary Aging Report
52186870 -> 86870   UpdateSavings
52186880 -> 86880   All Investments Report
52186884 -> 86884   HremployeesJobQueues
52186971 -> 86971   ClearedUncleared Cheques
52186972 -> 86972   FlaggedDividendRegister
52186986 -> 86986   Tax Exemption Report
52187001 -> 87001   Society Active Vehicles
52187002 -> 87002   Society Vehicle Movement
52187003 -> 87003   Society Vehicle Request
52187004 -> 87004   Society Vehicle Fueling
52187005 -> 87005   Society Vehicle Repair
52187006 -> 87006   Society Vehicle Service
52187007 -> 87007   Insurance Contracts
52187008 -> 87008   Vehicle Depreciation
52187009 -> 87009   Dailly Billing Process
52187010 -> 87010   External Conf Hall and Mtng
52187011 -> 87011   Parking Space
52187012 -> 87012   Conf Hall & Meeting Booking St
52187013 -> 87013   Staff Holding Keys
52187014 -> 87014   Office Keys Movement
52187015 -> 87015   Mileage Per Driver
52187016 -> 87016   Member and loan Statement
52187017 -> 87017   Parking Report - External
52187022 -> 87022   Internal Conf Hall & Mtng Use
52187076 -> 87076   Registration Fee Recovery
52187315 -> 87315   MembAppReport
52187319 -> 87319   Lease Contract Report
52187320 -> 87320   PRSalaryAdvanceSchedule
52187321 -> 87321   Generate Loans
52187322 -> 87322   Savings Account Types Report
52187324 -> 87324   Loans Arrears HISTORICAL
52187326 -> 87326   FallOff SASRA and Insert
52187327 -> 87327   Process Promise Topay
52187331 -> 87331   Surety Instruction Template LO
52187332 -> 87332   Instruction Template - Surety
52187340 -> 87340   Appeals Report
52187341 -> 87341   Litigation Report
52187356 -> 87356   Delegate/Board Member Position
52187357 -> 87357   Daily Membership Report
52187358 -> 87358   Member Status
52187359 -> 87359   Member Appl Channels
52187360 -> 87360   Member's Statement
52187361 -> 87361   Member Appl. Pending Approval
52187363 -> 87363   Member Rejoining
52187364 -> 87364   Members Missing Photos
52187368 -> 87368   Treasury Report
52187369 -> 87369   Mileage Per Driver Report
52187370 -> 87370   Share Capital Certificate
52187371 -> 87371   Matured Investments
52187373 -> 87373   Daily Transaction Report
52187380 -> 87380   Promise To Pay Report
52187381 -> 87381   Tenant Aging Report
52187382 -> 87382   Investment and Interest Income
52187383 -> 87383   Prorated Invest Interest
52187384 -> 87384   Generate Selectively
52187385 -> 87385   Share Capital Register
52187386 -> 87386   Investment Movement Summary
52187387 -> 87387   Invest Accumulated Interest
52187388 -> 87388   Fosa Voucher Print
52187389 -> 87389   Generate Year Selectively
52187390 -> 87390   Instruction Template Ltg
52187391 -> 87391   Instruction Template - Perfc
52187392 -> 87392   Vehicle Accidents - Single
52187393 -> 87393   Dividend Provision
52187394 -> 87394   Leave types report
52187395 -> 87395   Discharge Template
52187396 -> 87396   Vehicle Accidents - Multiple
52187397 -> 87397   FA reg addition audit trail
52187398 -> 87398   Adjusted Fixed Assets
52187399 -> 87399   Disposal FA audit trail
52187400 -> 87400   Loan Disbursement Report
52187401 -> 87401   Member Deposits Report
52187402 -> 87402   Recovery Fresh Loans
52187403 -> 87403   Total Liabilities report
52187404 -> 87404   Rescheduled Loans report
52187405 -> 87405   Self Guaranteed Loans Report
52187406 -> 87406   Posted Loans Report
52187407 -> 87407   Bank Reconcilliation Report II
52187408 -> 87408   Loan TAT Report
52187409 -> 87409   Loans Recovery Per Month
52187410 -> 87410   Current Placed Investments
52187411 -> 87411   Board Payslip Report
52187415 -> 87415   Witheld Tax Obligations On PV
52187416 -> 87416   Share Capital Recovery
52187418 -> 87418   Share Capital Transfer
52187419 -> 87419   Deposit Listing Report
52187420 -> 87420   HR Loans Appraisal  Checkoff
52187421 -> 87421   Nominee Register
52187422 -> 87422   Disposed Fixed Assets
```

## Report Extension (1)

```text
52185423 -> 85423   Bank Acc. - DetailTrial BalEXT
```

## Codeunit (119)

```text
52185424 -> 85424   EventSubscribers
52185425 -> 85425   Customer Running balalnce
52185426 -> 85426   Document Attachment Events Sub
52185427 -> 85427   NCBA Integration
52185428 -> 85428   IPRS Integration
52185429 -> 85429   Members Portal Link
52185430 -> 85430   HR Codeunit2
52185431 -> 85431   PrPayroll Processing Casual
52185432 -> 85432   Holiday Adjustment Management
52185433 -> 85433   Get Local IP
52185434 -> 85434   Customer Management Portal Url
52185435 -> 85435   Custom Calculate Depreciation
52185436 -> 85436   Custom Calc. Normal Deprec.
52185437 -> 85437   Run EOD Reconciliation Report
52185438 -> 85438   HR Expiry & Retirement Notif
52185439 -> 85439   Sky Survey
52185440 -> 85440   Silent Reversal-Post
52185441 -> 85441   HR Leave Jnl.-Post
52185442 -> 85442   HR Leave Jnl.- Post Batch
52185443 -> 85443   HR Leave Jnl.- Check Line
52185444 -> 85444   HR Leave Jnl.- Post Line
52185445 -> 85445   HR Leave Jnl Management
52185446 -> 85446   HR Leave Year - Close
52185447 -> 85447   HR Make Leave Ledg. Entry
52185448 -> 85448   HR Appraisal Jnl.-Post Batch
52185449 -> 85449   HR Appraisal Jnl.-Check Line
52185450 -> 85450   HR Appraisal Jnl.-Post Line
52185451 -> 85451   HR Make Appraisal Ledg. Entry
52185452 -> 85452   HR Appraisal Jnl.-Post
52185453 -> 85453   HR Dates
52185454 -> 85454   HR Codeunit
52185455 -> 85455   Registration Process
52185456 -> 85456   Department Targets Management
52185457 -> 85457   Membership Closure Mgmt
52185458 -> 85458   HOD Management
52185459 -> 85459   HR Email Dispatcher
52185460 -> 85460   HR SMS Dispatcher
52185461 -> 85461   Journal Posting
52185462 -> 85462   Fingerprint Processing
52185463 -> 85463   Fingerprint Processing Fn
52185464 -> 85464   Global SMS Dispatcher
52185465 -> 85465   Global SMS Installer
52185466 -> 85466   SendSms
52185467 -> 85467   DVII
52185468 -> 85468   Global SMS Token Resolver
52185469 -> 85469   Gen. Jnl.-Post New
52185470 -> 85470   Periodic Activities
52185471 -> 85471   HR Dates 2
52185472 -> 85472   PR Payroll Processing
52185474 -> 85474   CalcBudget
52185475 -> 85475   Register Management
52185476 -> 85476   Doc-CancelMgt
52185478 -> 85478   BankAlertMgt FP
52185480 -> 85480   Budget Allocation FP
52185482 -> 85482   Posting Check FP
52185483 -> 85483   Budgetary Control
52185484 -> 85484   Loan Appraisal Codeunit
52185485 -> 85485   Journal Post Successful
52185486 -> 85486   User Setup Management BR
52185488 -> 85488   Payment Voucher Apply
52185489 -> 85489   Receipt Apply
52185490 -> 85490   Tax Calculation
52185495 -> 85495   Process Bank Acc. Rec Lines-2
52185496 -> 85496   DCS Management
52185497 -> 85497   DCS Integration Base
52185498 -> 85498   VB Management
52185499 -> 85499   Agency Standard Codeunit
52185500 -> 85500   Post Agent Transactions
52185503 -> 85503   Post bank
52185504 -> 85504   HR Codeunit3
52185505 -> 85505   Check Manual Nos
52185506 -> 85506   Global Functions
52185507 -> 85507   System Editss
52185975 -> 85975   Global Filter Engine
52185976 -> 85976   Global Token Engine
52185977 -> 85977   Global Bulk SMS Sender
52186420 -> 86420   52186420 NavigateExte
52186421 -> 86421   Credit and Savings Navigation
52186456 -> 86456   Sacco Transactions
52186458 -> 86458   Loans Process
52186460 -> 86460   Dividend Process
52186463 -> 86463   Custom Approvals Codeunit
52186500 -> 86500   CRM Integration
52186502 -> 86502   Sky Mobile Banking Integration
52186504 -> 86504   EDMS Integration
52186505 -> 86505   BC Portal
52186506 -> 86506   Sky Coop ATM Bridge
52186507 -> 86507   Members Portal Integration
52186508 -> 86508   Dividends Job Queue Manager
52186509 -> 86509   Dividend Job
52186510 -> 86510   CRM Functions
52186511 -> 86511   CRB TransUnion CreditScore API
52186512 -> 86512   Sky M-Banking Transactions
52186513 -> 86513   Mwalimu Smart Functions
52186514 -> 86514   EDMS Functions
52186516 -> 86516   Sky Coop ATM Transactions
52186518 -> 86518   Loan Listing Job Queue Manager
52186519 -> 86519   Loan Listing Job
52186520 -> 86520   Loan FallOff Job Queue Manager
52186521 -> 86521   Loan FallOff Job
52186522 -> 86522   Deposit List Job Queue Manager
52186523 -> 86523   Deposit Listing Job
52186524 -> 86524   Member List Job Queue Manager
52186525 -> 86525   Member Listing Job
52186526 -> 86526   Loan Ageing Job Queue Manager
52186527 -> 86527   Loan Ageing Job
52186528 -> 86528   BBF/Nominee Job Queue Manager
52186529 -> 86529   BBF/Nominee Job
52186561 -> 86561   CRB Metropol API
52186599 -> 86599   Base API
52187101 -> 87101   Sky Send Email
52187200 -> 87200   DataTransfer
52187321 -> 87321   CustomPostCU
52187324 -> 87324   ActualLoanSchedule
52187325 -> 87325   Bulk Processing
52187332 -> 87332   MySubscribers
52187334 -> 87334   Purchase Req To Quote
52187335 -> 87335   Reversal Posting
52187339 -> 87339   CustomCuesCodeunit
```

## Query (42)

```text
52185423 -> 85423   MembersQry
52185424 -> 85424   Next Of Kin
52185425 -> 85425   savings accounts
52185426 -> 85426   Online Users
52185427 -> 85427   Product Types
52185428 -> 85428   LoansQRY
52185430 -> 85430   Members Listing
52185431 -> 85431   Online Loan Guarantors
52185432 -> 85432   Dividend Instructions
52185433 -> 85433   Meeting Attendees
52185434 -> 85434   Salary Lines
52185435 -> 85435   Special Requests
52185436 -> 85436   MemberSegment
52185437 -> 85437   DailyMember
52185438 -> 85438   EmployerCRM
52185439 -> 85439   SavingsAccountsCRM
52185440 -> 85440   LoansCRM
52185441 -> 85441   GuarantorCRM
52185442 -> 85442   ObjHREmployees
52185443 -> 85443   ObjHRLeave
52185444 -> 85444   Delegate Meeting Minutes
52185445 -> 85445   ObjHrLeaveTypes
52185446 -> 85446   StandingOrders
52185447 -> 85447   Standing Order Lines
52185448 -> 85448   Dividends Progression
52185449 -> 85449   Online Transactions
52185450 -> 85450   Employers
52185451 -> 85451   Responsility Centre
52185452 -> 85452   DelegateMembers
52185453 -> 85453   Delegate Meeting Atendants
52185454 -> 85454   Delegates Min. Header
52185455 -> 85455   Bids
52185456 -> 85456   Market Shares
52185458 -> 85458   Meeting Minutes
52185459 -> 85459   Collateral List
52185460 -> 85460   MembersQ
52185461 -> 85461   StandingOrdersQ
52185463 -> 85463   Members Without Loans
52186500 -> 86500   Loan Guarantor Substitution
52186501 -> 86501   Share Transfer Application
52186502 -> 86502   CRM Product Variations API
52186503 -> 86503   CRM Members Marketing API
```

## XmlPort (157)

```text
52185424 -> 85424   Fixed Assets Transfer Import
52185425 -> 85425   Receipt 
52185426 -> 85426   Data Export
52185427 -> 85427   Import Paybill
52185428 -> 85428   Dividend Status
52185429 -> 85429   Import Salaries ID
52185430 -> 85430   Loan Account Import
52185431 -> 85431   Product Types
52185432 -> 85432   Member Loans
52185433 -> 85433   Export GL Entries
52185434 -> 85434   Dividend Pay
52185435 -> 85435   General SMS Lines
52185436 -> 85436   Import Bank Rec Diffrences
52185437 -> 85437   Jobs Update
52185438 -> 85438   Employees Jobs
52185439 -> 85439   Sto
52185440 -> 85440   Account Signatories
52185441 -> 85441   Securities register
52185442 -> 85442   Postal
52185443 -> 85443   FOSA PV Lines ID
52185444 -> 85444   Members_Group
52185445 -> 85445   Chart Of Accounts
52185446 -> 85446   Depre Book
52185447 -> 85447   Segments
52185448 -> 85448   Item Import
52185449 -> 85449   savings2
52185450 -> 85450   Import Savings
52185451 -> 85451   Dividends p
52185452 -> 85452   Loans
52185453 -> 85453   Import Credit Accounta
52185454 -> 85454   Export Repayments
52185455 -> 85455   Accounts Imports-
52185457 -> 85457   Savings Account Export
52185458 -> 85458   Credit Accounts
52185459 -> 85459   FA JOURNAL
52185460 -> 85460   JOURNAL
52185461 -> 85461   Credit_accounts
52185462 -> 85462   Credit_accounts__
52185463 -> 85463   Genbatches
52185464 -> 85464   STO LINES
52185465 -> 85465   ITEM QTY
52185466 -> 85466   Signatories
52185467 -> 85467   Delegate Grp
52185468 -> 85468   Delegate Trariff
52185469 -> 85469   Delegate Officials
52185470 -> 85470   Account Flags
52185471 -> 85471   DATE DATA
52185472 -> 85472   Import employees
52185473 -> 85473   Import jobs
52185475 -> 85475   Import employeenxt  of kin
52185476 -> 85476   Import committee members
52185477 -> 85477   Import leave balance
52185478 -> 85478   Group Account Sig
52185479 -> 85479   Recruited By
52185480 -> 85480   ACCOUNT
52185481 -> 85481   MembUpdate
52185482 -> 85482   Group Dele
52185483 -> 85483   guarantors
52185484 -> 85484   delegates ap
52185485 -> 85485   FA Journals
52185486 -> 85486   vendors
52185487 -> 85487   Update-
52185488 -> 85488   lien Placed
52185489 -> 85489   Investment Header
52185490 -> 85490   Investment Lines
52185491 -> 85491    Next of Kinup
52185492 -> 85492   LoansUp migration
52185494 -> 85494   Export Unpay Cheques
52185495 -> 85495   Import Default Cheques
52185496 -> 85496   Import Salaries
52185497 -> 85497   Inward File Import
52185498 -> 85498   Monthly Advice New Loans
52185499 -> 85499   Checkoff Buffer
52185500 -> 85500   Import Telephone Nos
52185501 -> 85501   Electronic Fund Transfer
52185502 -> 85502   Loans CRB
52185503 -> 85503   Loans Gurarantors- CRB
52185504 -> 85504   Export Cheque Book Application
52185505 -> 85505   Import Fixed Asset
52185506 -> 85506   Import employee transactions1
52185507 -> 85507   Dividend Progression
52185508 -> 85508    Next of Kin
52185509 -> 85509   JOURNAL DEPOSIT
52185510 -> 85510   CustomerImport
52185511 -> 85511   Import New Members
52185512 -> 85512   Transaction Log-Finance
52185513 -> 85513   Change Log Enteies
52185515 -> 85515   Import Emails Update
52185516 -> 85516   Export Guarantors
52185517 -> 85517   Loans Open Bal
52185518 -> 85518   Savings Register
52185519 -> 85519   Member Register
52185520 -> 85520   Import User Station
52185521 -> 85521   Import Retired Delegated
52185522 -> 85522   Import New Delegated
52185523 -> 85523   Update Employer Codes
52185524 -> 85524   Update Savings A/C Names(TOTO)
52185525 -> 85525   Update Savings A/C DOB(TOTO)
52185526 -> 85526   Import Journal Two
52185527 -> 85527   Update Loan ACC/RepaymentMtd
52185528 -> 85528   Update Member Status
52185529 -> 85529   Update Member PF Number
52185530 -> 85530   Update Savings PF Number
52185531 -> 85531   Update Member Details
52185532 -> 85532   Update Computer Asset Register
52185533 -> 85533   Update Savings to Frozen
52185534 -> 85534   Update Emp Ln No
52185535 -> 85535   Worker Impoter
52185536 -> 85536   Import Member From Legacy
52185537 -> 85537   Import Contracts Information
52185538 -> 85538   Import Expired Transactions
52185539 -> 85539   M-PESA Manul Upload
52185540 -> 85540   SavingsAccts
52185541 -> 85541   Loans migration
52185542 -> 85542   Member
52185543 -> 85543   Creditaccount
52185544 -> 85544   standing order
52185545 -> 85545   standingorderlines
52185546 -> 85546   VendorImport
52185547 -> 85547   Fixed Asset
52185548 -> 85548   Fixed Asset Dpr Book
52185549 -> 85549   PRTrans
52185550 -> 85550   Job Application
52185551 -> 85551   Savings Account
52185552 -> 85552   earningsdeductions
52185553 -> 85553   DailyInterest
52185554 -> 85554   Savings BP
52185555 -> 85555   Loans BP
52185556 -> 85556   Lumpsum BP
52185557 -> 85557   Inter Account
52185558 -> 85558   BankImport
52185559 -> 85559   Reccuring Fixed Assets Journal
52185560 -> 85560   Employee Upload
52185561 -> 85561   FDcontract
52185562 -> 85562   Dividend
52185563 -> 85563   Postedsalary
52185564 -> 85564   Attachement lines
52185565 -> 85565   Attachement Header
52185566 -> 85566   Loans Daily Interest
52185567 -> 85567   Member Upload Records
52185568 -> 85568   Alerts Loan Lines
52185569 -> 85569   CompanyVehiclesImport
52185570 -> 85570   FilesTableImport
52185571 -> 85571   FDInterestBUfferImport
52185572 -> 85572   DelegatesImports
52185573 -> 85573   Asset Disposal Xml 
52185574 -> 85574   Bank Deposits Import
52185575 -> 85575   phoneNumberImport
52185576 -> 85576   Import Old Div
52185577 -> 85577   Import Saving Monthly Interest
52185600 -> 85600   Upload Savings Records
52185970 -> 85970   FOSA PV Lines
52185999 -> 85999   Import Salaries P
52187038 -> 87038   Refund_Account_ Transfer
52187417 -> 87417   ATM Inventory Xml
52187420 -> 87420   My Savings Accounts
52187421 -> 87421   Mkey Lines
```

## Enum (66)

```text
52185423 -> 85423   Customer Types
52185424 -> 85424   Gender
52185425 -> 85425   Marital Status
52185426 -> 85426   Terms Of Employment
52185427 -> 85427   Recruited By
52185428 -> 85428   Member Status
52185429 -> 85429   Account Creation Method
52185430 -> 85430   Sub Module
52185431 -> 85431   Member Status Sub Flags
52185432 -> 85432   Identification Type
52185433 -> 85433   Type of Application
52185434 -> 85434   Workflow Status Main Flags
52185435 -> 85435   Accounts Category
52185436 -> 85436   Business Type
52185437 -> 85437   Product Categories
52185438 -> 85438   Transaction Types
52185439 -> 85439   Account Category
52185440 -> 85440   Member Classes
52185441 -> 85441   SMS Source
52185442 -> 85442   Funds Witheld Types
52185443 -> 85443   Budget Commitment Doc Type
52185444 -> 85444   CF Station Actions
52185445 -> 85445   Vendor Type
52185446 -> 85446   Digital Signature Name
52185447 -> 85447   Digital Signature Process
52185448 -> 85448   Responsibility Center Enum
52185449 -> 85449   Fosa Transaction Types
52185450 -> 85450   Staff Category
52185451 -> 85451   SLA Origination Type
52185452 -> 85452   Leave Type Enum
52185453 -> 85453   Bulk Errors Process
52185454 -> 85454   Special Transactions
52185455 -> 85455   File Types
52185456 -> 85456   Payment Mode
52185457 -> 85457   Savings Account Status
52185458 -> 85458   Auto Openning Account Status
52185459 -> 85459   Loan Guarantor Types Enum
52185460 -> 85460   Source Unit
52185461 -> 85461   Loan Product Charge Types
52185462 -> 85462   Loan Month
52185463 -> 85463   Salary Type
52185464 -> 85464   Member Form Types
52185465 -> 85465   Commission Types
52185466 -> 85466   Sky Survey Triggers
52185467 -> 85467   Survey Status
52185468 -> 85468   HR Email Event
52185469 -> 85469   SMS Module
52185470 -> 85470   SMS Token Category
52185700 -> 85700   Perfection Stages
52185701 -> 85701   NotificationEmailSMS
52185970 -> 85970   SMS Filter Operator
52186500 -> 86500   Salary Income Types
52186502 -> 86502   Sky M-Banking Trans Types
52186503 -> 86503   M-Smart Documents
52186504 -> 86504   EDMS File Types
52186506 -> 86506   ATM Service Prov. Resp. Codes
52186507 -> 86507   ATM Transaction Types
52186508 -> 86508   Saccolink Transaction Types
52186514 -> 86514   EDMS Data Classes
52186517 -> 86517   CRM Originations
52186561 -> 86561   CRB Metropol Report Types
52186562 -> 86562   CRB Metropol Report Reasons
52186563 -> 86563   CRB Metropol Identity Types
52187007 -> 87007   Loan Recovery Mode
52187421 -> 87421   Competences
52187422 -> 87422   Loan Sasra categories
```

## Enum Extension (10)

```text
52185423 -> 85423   Gen. Journal Account Type Ext
52185424 -> 85424   Column Layout Type Ext
52185425 -> 85425   Reversal Entry Type Ext
52185426 -> 85426   Attachment Document Type
52185427 -> 85427   Cust Apply CalcType Enum ext
52185428 -> 85428   Gen. Journal source Type Ext
52185429 -> 85429   FA Depr. Method Internal EXT
52185430 -> 85430   FA Depreciation Method EXT
52185442 -> 85442   DocumentType
52185462 -> 85462   HR SMS Source Ext
```

## Unchanged (already in range)

```text
Codeunit        50110 -> 50110   EmailCodeunit
Enum Extension  50101 -> 50101   Approval status enumext
Enum Extension  50102 -> 50102   App document type enum ext
Report          50101 -> 50101   Send SMS to Member
Report          50110 -> 50110   Sendingemails
```

## Table-extension field IDs

Fields added to base tables must also sit inside the app range, so these moved by the same rule:

```text
52186830 -> 86830   "Cash Book Balance"; Decimal   (Extensions\Table\52186425BankAccountStatement.TableExt.al)
52185423 -> 85423   "Account Category"; Enum "G/L Account Category"   (Extensions\Table\Tab-Ext52185429.DimensionCodeBufferExt.al)
52185424 -> 85424   "Account Sub Category"; Text[80]   (Extensions\Table\Tab-Ext52185429.DimensionCodeBufferExt.al)
```

## Word layouts

Word layouts store the report ID in their XML namespace (`urn:microsoft-dynamics-nav/reports/<Name>/<ID>/`). These were updated:

```text
52186156 -> 86156   Layout\Contract Templates.docx
52187395 -> 87395   Layout\Discharge Template.docx
52185443 -> 85443   Layout\DPA Contract.docx
52185814 -> 85814   Layout\Execution Form.docx
52186157 -> 86157   Layout\Finance Share Certificate.docx
52187391 -> 87391   Layout\Instruction Template - Perfc.docx
52187390 -> 87390   Layout\Instruction Template Ltg.docx
52187332 -> 87332   Layout\Instruction Template Surety.docx
52187319 -> 87319   Layout\Lease Contract Report.docx
52186095 -> 86095   Layout\Loan Offer Letter Buss Loans.docx
52185436 -> 85436   Layout\NDA Contract.docx
52185812 -> 85812   Layout\Perfection Template II.docx
52185599 -> 85599   Layout\prPaySlip2Local.docx
52187370 -> 87370   Layout\Share Capital Certificate.docx
52187331 -> 87331   Layout\Surety Instruction Template LO.docx
52185822 -> 85822   Layout\Transferred Share Capital.docx
```

## Deliberately not changed

- **Comments and commented-out code** (`//` and `/* */`, including 565 fully commented-out files). These still show old IDs.
- **Names and captions that contain a number**, e.g. table `"52187008 Employer Product Attr"`, page `"52186719 Employer Product Attr"`. These are object names, not IDs.
- **Field IDs in custom tables** (e.g. `field(50100; ...)`). These are not object IDs.
- **File names.**
