page 52185712 "Product Factory"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Activities, ,Category7_caption,Category8_caption,Category9_caption,Approvals';
    SourceTable = "Product Factory";
    Caption = 'Product Setups';
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = CurrPageEditable;
                field("Product ID"; Rec."Product ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Description"; Rec."Product Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Class Type"; Rec."Product Class Type")
                {
                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    var
                    begin
                        DocumentControl;
                    end;
                }

                field("Min. Customer Age"; Rec."Min. Customer Age")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Max. Member Age"; Rec."Max. Member Age")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Interest Rate (Min.)"; Rec."Interest Rate (Min.)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Rate (Max.)"; Rec."Interest Rate (Max.)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Dormancy Alert Period"; Rec."Dormancy Alert Period")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Dormancy Period"; Rec."Dormancy Period")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product SLA"; Rec."Product SLA")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = true;
                }
                field("Account No. Prefix"; Rec."Account No. Prefix")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    ShowMandatory = true;
                }
                field("Requires Suffix"; Rec."Requires Suffix")
                {

                }
                field("Account No. Suffix"; Rec."Account No. Suffix")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Statement Charge"; Rec."Statement Charge")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Certified Statement Charge"; Rec."Certified Statement Charge")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Closure Fee"; Rec."Closure Fee")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    begin
                        DocumentControl;
                    end;
                }
                field("Recovery Priority"; Rec."Recovery Priority")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Disbursement Priority"; Rec."Disbursement Priority")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Search Code"; Rec."Search Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sort Order"; Rec."Sort Order")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Variation Allowed"; Rec."Variation Allowed")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Source Unit"; Rec."Source Unit")
                {
                    ApplicationArea = Basic, Suite;
                    // OptionCaption = ' ,FOSA,BOSA,BUSINESS LOANS,HR LOANS';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Income Type"; Rec."Salary Income Types")
                {
                    Caption = 'Income Type';
                }

                field("Last Updated By"; Rec."Last Updated By")
                {
                    Editable = false;
                }
                field("Approved By"; Rec."Approved By")
                {
                    Editable = false;

                }


            }
            group(Finance)
            {
                Caption = 'Finance';
                Visible = FinancialsVisible;
                Editable = CurrPageEditable;
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Posting Group"; Rec."Product Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan  Account [G/L]"; Rec."Loan  Account [G/L]")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Interest Account [G/L]"; Rec."Loan Interest Account [G/L]")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Receivable Account[G/L]"; Rec."Loan Receivable Account[G/L]")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Suspend Interest Account [G/L]"; Rec."Suspend Interest Account [G/L]")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Bill Account"; Rec."Bill Account")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Visible = false;
                // }
                // field("Billed Account"; Rec."Billed Account")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Visible = false;
                // }
                field("Penalty Due Account"; Rec."Penalty Paid Account")
                {
                    Caption = 'Penalty Due Account';
                    ApplicationArea = Basic, Suite;
                }
                field("Penalty Income Account"; Rec."Penalty Income Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Appraisal Income Acc."; Rec."Loan Appraisal Income Acc.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Accrue Monthly"; Rec."Accrue Monthly")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Monthly Charges"; Rec."Monthly Charges")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Accrual Fee Acc. (Income)"; Rec."Accrual Fee Acc. (Income)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Target; Rec.Target)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Saving Product")
            {
                Caption = 'Saving Product';
                Visible = SavingsProductVisible;
                Editable = CurrPageEditable;
                field("Loan Disbursement Account"; Rec."Loan Disbursement Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Category"; Rec."Product Category")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Auto Open Account"; Rec."Auto Open Account")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Auto Open Member Account';
                }
                field("Auto Open Group Account"; Rec."Auto Open Group Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Auto Openning Account Status"; Rec."Auto Openning Account Status")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Security Inclination"; Rec."Loan Security Inclination")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Allow Multiple Accounts"; Rec."Allow Multiple Accounts")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Minimum Contribution"; Rec."Minimum Contribution")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Minimum Balance"; Rec."Minimum Balance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Xrec Minimum Balance"; Rec."Xrec Minimum Balance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Notice; Rec.Notice)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Withdrawal Interval"; Rec."Withdrawal Interval")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Maximum No. of Withdrawal"; Rec."Maximum No. of Withdrawal")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Earns Interest"; Rec."Earns Interest")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Calc Min Balance"; Rec."Interest Calc Min Balance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Expense Account"; Rec."Interest Expense Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Payable Account"; Rec."Interest Payable Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Dividend Calc. Method"; Rec."Dividend Calc. Method")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Dividends Incentives"; Rec."Dividends Incentives")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Dividends Incentives G\L"; Rec."Dividends Incentives G\L")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Withholding Tax Account"; Rec."Withholding Tax Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("WithHolding Tax"; Rec."WithHolding Tax")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Allow Over Draft"; Rec."Allow Over Draft")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Credit Limit(Overdraft)"; Rec."Credit Limit(Overdraft)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Automatic Overdraft"; Rec."Automatic Overdraft")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Over Draft Interest %"; Rec."Over Draft Interest %")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Over Draft Interest Account"; Rec."Over Draft Interest Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Allow Multiple Over Draft"; Rec."Allow Multiple Over Draft")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Savings Duration"; Rec."Savings Duration")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Savings Withdrawal penalty"; Rec."Savings Withdrawal penalty")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Allow Send Email"; Rec."Allow Send Email")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Category"; Rec."Member Category")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Applicable To member category';
                }
                field("Can Guarantee Loan"; Rec."Can Guarantee Loan")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Creation Method"; Rec."Account Creation Method")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No. Serries"; Rec."Account No. Serries")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Can Recover Loan"; Rec."Can Recover Loan")
                {

                }
                field("Exclude From Closure"; Rec."Exclude From Closure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Exclude From Closure field.';
                }
                field("Allowed Transaction"; Rec."Allowed Transaction")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("SASRA Savings Category"; Rec."SASRA Savings Category")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Can Be Closed"; Rec."Can Be Closed")
                {

                }

                field("Account Group"; Rec."Account Group")
                {
                    ApplicationArea = Basic, Suite;
                }

                group("Account Transfer Charges:")
                {
                    field("Account Transfer Charge Period"; Rec."Account Transfer Charge Period")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("Account Transfer Charges"; Rec."Account Transfer Charges")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                }

            }
            group("Credit Product")
            {
                Caption = 'Credit Product';
                Visible = CreditProductVisible;
                Editable = CurrPageEditable;

                field("Charge 1 month Interest"; Rec."Charge 1 month Interest")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("One Month Interest G/L"; Rec."One Month Interest G/L")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Security"; Rec."Loan Security")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Loan Term"; Rec."Loan Term Type")
                {
                    ApplicationArea = Basic, Suite;

                }

                field("Maximum Guarantors"; Rec."Maximum Guarantors")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Minimum Guarantors"; Rec."Minimum Guarantors")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Minimum Guarantors on Max Amt"; Rec."Minimum Guarantors on Max Amt")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Max Amt on Guarantors"; Rec."Max Amt on Guarantors")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Min. Re-application Period"; Rec."Min. Re-application Period")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("FosaLoan Multiplier"; Rec."FosaLoan Multiplier")
                {
                    ApplicationArea = all;
                }
                field("Minimum Loan Amount"; Rec."Minimum Loan Amount")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Maximum Loan Amount"; Rec."Maximum Loan Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Prefferential Default installm"; Rec."Prefferential Default installm")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Appraisal Parameter Type"; Rec."Appraisal Parameter Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Ordinary Default Intallments"; Rec."Ordinary Default Intallments")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Repay Mode"; Rec."Repay Mode")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Does not Require Batching"; Rec."Does not Require Batching")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Grace Period - Interest"; Rec."Grace Period - Interest")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Grace Period - Principle"; Rec."Grace Period - Principle")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Installment Repayment Interval"; Rec."Installment Repayment Interval")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Compute Interest Due on Postin"; Rec."Compute Interest Due on Postin")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Guarantor Loan"; Rec."Guarantor Loan")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Compute Bills on Posting"; Rec."Compute Bills on Posting")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Visible = false;
                // }
                // field("Fixed Loan Term"; Rec."Fixed Loan Term")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Visible = false;
                // }
                field("Ordinary Deposits Multiplier"; Rec."Ordinary Deposits Multiplier")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Subsequent Multiplier"; Rec."Subsequent Multiplier")
                {
                    ApplicationArea = all;
                }
                field("Preferential Dep. Multiplier"; Rec."Preferential Dep. Multiplier")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Span"; Rec."Loan Span")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Group"; Rec."Loan Group")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Gender; Rec."Gender")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Minimum Application Period"; Rec."Minimum Application Period")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Exempt From Fosa Minimum"; Rec."Exempt From Fosa Minimum")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Staff Loan Exemption"; Rec."Staff Loan Exempption")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Nature of Loan Type"; Rec."Nature of Loan Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Type of Discounting"; Rec."Type of Discounting")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Discounting %"; Rec."Discounting %")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Computation %"; Rec."Computation %")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("No. Of Months for Appr. Saving"; Rec."No. Of Months for Appr. Saving")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Requires Salary Processing"; Rec."Requires Salary Processing")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Net Salary Multiplier %"; Rec."Net Salary Multiplier %")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("No. of Salary Times"; Rec."No. of Salary Times")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Salary Period"; Rec."Salary Period")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Least Sal Rate %"; Rec."Least Sal Rate %")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Appraisal - Omit Deductions"; Rec."Appraisal - Omit Deductions")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Maximum Deposit Contribution"; Rec."Maximum Deposit Contribution")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Minimum Deposit Tiered"; Rec."Minimum Deposit Tiered")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Prorata Deposit Tiered';
                }
                field("Minimum Deposit Tiered Code"; Rec."Minimum Deposit Tiered Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Prorata Deposit Contribution';
                }
                field("Loan Prorata Factor"; Rec."Loan Prorata Factor")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Loan Prorata Factor';
                }
                field("Loan Exclusive Factor"; Rec."Loan Exclusive Factor")
                {
                    ApplicationArea = all;
                    Caption = 'Loan Excussive Factor';
                }
                field("Minimum Dep. Contribution %"; Rec."Minimum Dep. Contribution %")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Minimum Deposit Balance"; Rec."Minimum Deposit Balance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Maximum Deposit Boost %"; Rec."Maximum Deposit Boost %")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Source of Funds"; Rec."Source of Funds")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Visible = false;
                // }
                // field("Source Of Funds No."; Rec."Source Of Funds No.")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Visible = false;
                // }
                field("Minimum Deposit Contribution"; Rec."Minimum Deposit Contribution")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("No Interest Bills"; Rec."No Interest Bills")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Visible = false;
                // }
                // field("No Principle Bills"; Rec."No Principle Bills")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Visible = false;
                // }
                // field("View Online"; Rec."View Online")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Allow Multiple Running Loans"; Rec."Allow Multiple Running Loans")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Mobile Loan"; Rec."Mobile Loan")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field(AvailableOnMobile; Rec.AvailableOnMobile)
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Pension Loan"; Rec."Pension Loan")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Mortgage Loan"; Rec."Mortgage Loan")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = true;
                }
                field("Loan Refinancing"; Rec."Loan Refinancing")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                // field("Shamba Loan"; Rec."Shamba Loan")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Visible = false;
                // }
                // field("Maximum Loan Amount(Mobile)"; Rec."Maximum Loan Amount(Mobile)")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Visible = false;
                // }
                field("Loan Disbt Account Code"; Rec."Loan Disbt Account Code")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Loan Appraisal Account Code"; Rec."Loan Appraisal Account Code")
                {

                    ApplicationArea = Basic, Suite;
                }
                field("Deafulter Loan Product"; Rec."Deafulter Loan Product")
                {

                    ApplicationArea = Basic, Suite;
                }
                field("Recovery Creteria"; Rec."Recovery Creteria")
                {

                }
                field("Recovery Product"; Rec."Recovery Product")
                {
                    ToolTip = 'This is the product that is going to be used for reappotionment';
                }
                field("Allow Deposit Boost"; Rec."Allow Deposit Boost")
                {
                    ApplicationArea = all;
                }
                field("Secured Loan"; Rec."Secured Loan")
                {
                    ApplicationArea = all;
                }
                field("CRB Product Type"; Rec."CRB Product Type")
                {
                    ApplicationArea = all;
                }
                field("Restrict to Emp. Code"; Rec."Restrict to Emp. Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Recovered Upfront"; Rec."Interest Recovered Upfront")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Upfront Interest Rate"; Rec."Upfront Interest Rate")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Auto Send SMS Alerts"; Rec."Auto Send SMS Alerts")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Available To Member"; Rec."Available To Member")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Salary Loans"; Rec."Salary Loans")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Mobile Loan Net %"; Rec."Mobile Loan Net %")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Min. Net after Topup"; Rec."Min. Net after Topup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Min. Net after Topup';
                }
                field("Mobile Loan Req. Guar."; Rec."Mobile Loan Req. Guar.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Mobile Installments Type"; Rec."Mobile Installments Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Min. Mobile Installments"; Rec."Min. Mobile Installments")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Max. Mobile Installments"; Rec."Max. Mobile Installments")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Minimum Guarantor Deposits"; Rec."Minimum Guarantor Deposits")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shows Mobile Qualification"; Rec."Shows Mobile Qualification")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("MLoan Appraisal Start Point"; Rec."MLoan Appraisal Start Point")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("MLoan Appraisal Increment"; Rec."MLoan Appraisal Increment")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Requires Branch"; Rec."Requires Branch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Requires Payslip PIN"; Rec."Requires Payslip PIN")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Requires TnC"; Rec."Requires TnC")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Requires Purpose"; Rec."Requires Purpose")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Nos"; Rec."Loan Nos")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Control100000001; Rec."Min. Net after Topup")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sky Income From Sacco Interest"; Rec."Sky Income From Sacco Interest")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Mobile Min. Loan Amount"; Rec."Mobile Min. Loan Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Mobile Max. Loan Amount"; Rec."Mobile Max. Loan Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Mobile Min. Guarantors"; Rec."Mobile Min. Guarantors")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Mobile Max. Guarantors"; Rec."Mobile Max. Guarantors")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Portal Viewable"; Rec."Portal Viewable")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Portal Order"; Rec."Portal Order")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Dividend Advance Year"; Rec."Dividend Advance Year")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Staff Lending")
            {
                Caption = 'Staff Lending';
                Visible = CreditProductVisible;
                Editable = CurrPageEditable;
                field("Require Deposits"; Rec."Require Deposits")
                {

                }
                field("Minimum Service"; Rec."Minimum Service")
                {

                }
                field("Security Muliplier"; Rec."Security Muliplier")
                {

                }
                field("Staff Salary Multiplier"; Rec."Staff Salary Multiplier")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Purpose"; Rec."Loan Purpose")
                {
                    ApplicationArea = all;

                }
                field("Puporse Description"; Rec."Puporse Description")

                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Is a Car Loan"; Rec."Is a Car Loan")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies if it is a car loan';
                }
                field("Is a Construction Loan"; Rec."Is a Construction Loan")
                {

                }

                field("Max Second-Hand Period"; Rec."Max Second-Hand Period")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the expiry period of the  car from manufacture date';
                }
                field("Minimum Security Amount"; Rec."Minimum Security Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the minimum  amount to attached security';
                }

            }
            group("Agency Banking")
            {
                Caption = 'Agency Banking';
                Editable = CurrPageEditable;
                Visible = SavingsProductVisible;
                field("Agency Charge Acc"; Rec."Agency Charge Acc")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Sky Mbanking")
            {
                Caption = 'Sky Mbanking';
                Visible = true;
                Editable = CurrPageEditable;
                field("USSD Product Name"; Rec."USSD Product Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Is USSD Product"; Rec."Is USSD Product")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = Basic, Suite;
                }
                group(Channels)
                {
                    Caption = 'Sky Channels';
                    field("Channels Ext. Transfer Options"; Rec."Channels Ext. Transfer Options")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("Channels Int. Transfer Options"; Rec."Channels Int. Transfer Options")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                }
                // group("Sky Savings")
                // {
                //     Caption = 'Sky Savings';
                //     field("Mobile Transaction"; Rec."Mobile Transaction")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Savings Type"; Rec."Savings Type")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Bussiness Acc Prefix"; Rec."Bussiness Acc Prefix")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Business Acc Surfix"; Rec."Business Acc Surfix")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Minimum Amt B/s Accnt"; Rec."Minimum Amt B/s Accnt")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                // }
                // group("Dividend Advance Limit Period")
                // {
                //     Caption = 'Dividend Advance Limit Period';
                //     field("DAdvance Limit Period"; Rec."DAdvance Limit Period")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                // }
                // group("Sky Credit")
                // {
                //     Caption = 'Sky Credit';
                //     field("Restrict to Emp. Code"; Rec."Restrict to Emp. Code")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Interest Recovered Upfront"; Rec."Interest Recovered Upfront")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Auto Send SMS Alerts"; Rec."Auto Send SMS Alerts")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Available To Member"; Rec."Available To Member")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Salary Loans"; Rec."Salary Loans")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Mobile Loan Net %"; Rec."Mobile Loan Net %")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Min. Net after Topup"; Rec."Min. Net after Topup")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Min. Net after Topup';
                //     }
                //     field("Mobile Loan Req. Guar."; Rec."Mobile Loan Req. Guar.")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Mobile Installments Type"; Rec."Mobile Installments Type")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Min. Mobile Installments"; Rec."Min. Mobile Installments")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Max. Mobile Installments"; Rec."Max. Mobile Installments")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Minimum Guarantor Deposits"; Rec."Minimum Guarantor Deposits")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Shows Mobile Qualification"; Rec."Shows Mobile Qualification")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("MLoan Appraisal Start Point"; Rec."MLoan Appraisal Start Point")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("MLoan Appraisal Increment"; Rec."MLoan Appraisal Increment")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Requires Branch"; Rec."Requires Branch")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Requires Payslip PIN"; Rec."Requires Payslip PIN")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Requires TnC"; Rec."Requires TnC")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Requires Purpose"; Rec."Requires Purpose")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Loan Nos"; Rec."Loan Nos")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field(Control100000001; Rec."Min. Net after Topup")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Sky Income From Sacco Interest"; Rec."Sky Income From Sacco Interest")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Mobile Min. Loan Amount"; Rec."Mobile Min. Loan Amount")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Mobile Max. Loan Amount"; Rec."Mobile Max. Loan Amount")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Mobile Min. Guarantors"; Rec."Mobile Min. Guarantors")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Mobile Max. Guarantors"; Rec."Mobile Max. Guarantors")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Portal Viewable"; Rec."Portal Viewable")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Portal Order"; Rec."Portal Order")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }
                //     field("Dividend Advance Year"; Rec."Dividend Advance Year")
                //     {
                //         ApplicationArea = Basic, Suite;
                //     }

                // }
            }

            group(MembersPortal)
            {
                Caption = 'Members Portal Setup';
                Visible = true;
                Editable = CurrPageEditable;

                field("Is CRM Product"; Rec."Is CRM Product")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Available on Members Portal';
                }
                field("Portal Autoposting Allowed"; Rec."Portal Autoposting Allowed")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Autopost after guarantors approval?';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Action79)
            {
                action("Product Charges")
                {
                    ApplicationArea = Basic, Suite;
                    Image = SetupPayment;
                    Enabled = CreditProductVisible;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Product Charges";
                    RunPageLink = "Product Code" = FIELD("Product ID");
                }
                action("Product Supported Classes")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Supported Member Classes';
                    Image = SetupPayment;
                    Enabled = CreditProductVisible;

                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    RunObject = Page "Product Supported Classes List";
                    RunPageLink = "Product ID" = field("Product ID");
                }
                action("Blocked Employers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Blocked Employers';
                    Image = CustomerBlocked;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    RunObject = Page "Blocked Employers List";
                    RunPageLink = "Product ID" = field("Product ID");
                }
                action("Monthly Contribution Changes")
                {
                    ApplicationArea = Basic, Suite;
                    Image = CashFlow;
                    Enabled = not CreditProductVisible;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Monthly Contrib Logs";
                    RunPageLink = "Product ID" = FIELD("Product ID");
                }
                // action("Appraisal Parameters")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Image = Evaluate;
                //     Enabled = CreditProductVisible;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     RunObject = Page "DCS Product Parameter Matrix";
                //     RunPageLink = "Loan Product Code" = FIELD("Product ID");
                // }
                action("Other Appraisal Products")
                {
                    ApplicationArea = Basic, Suite;
                    Image = SetupPayment;
                    Enabled = CreditProductVisible;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Other Appraisal Products";
                    RunPageLink = "Product ID" = FIELD("Product ID");
                }
                action("Related Product")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Relatives;
                    Enabled = CreditProductVisible;
                    Promoted = true;
                    RunObject = Page "Related Product List";
                    RunPageLink = "Product Code" = FIELD("Product ID");
                }
                action("Loans to Bridge")
                {
                    ApplicationArea = Basic, Suite;
                    Image = DeleteExpiredComponents;
                    Enabled = CreditProductVisible;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Loan Products To Bridge";
                    RunPageLink = "Product Code" = FIELD("Product ID");
                }
                action("Employer Product Attributes")
                {
                    ApplicationArea = Basic, Suite;
                    Image = EmployeeAgreement;
                    Enabled = CreditProductVisible;
                    Promoted = true;
                    RunObject = Page "52186719 Employer Product Attr";
                    RunPageLink = "Product ID" = FIELD("Product ID");
                }
                action("Target Employers")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Loaners;
                    Promoted = true;
                    Enabled = CreditProductVisible;
                    RunObject = Page "Target Employers";
                    RunPageLink = "Product ID" = FIELD("Product ID");
                }
                action("Loan Product Availability")
                {
                    ApplicationArea = Basic, Suite;
                    Image = SetupPayment;
                    Enabled = CreditProductVisible;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Product Availability";
                    RunPageLink = "Loan Product Code" = FIELD("Product ID");
                }
            }
        }

        area(navigation)
        {
            action("Product Application Document")
            {
                ApplicationArea = Basic, Suite;
                Image = Documents;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Product Document";
                RunPageLink = "Product ID" = FIELD("Product ID");
            }
            action(Commentss)
            {
                ApplicationArea = Basic, Suite;
                Image = ViewComments;
                Promoted = true;
                Caption = 'Comment';
                PromotedCategory = Category4;

                RunObject = page "Comments List";
                RunPageLink = "Header No." = field("Product ID");
                RunPageView = where(Types = CONST(comment));
            }
            // action("Mobile Loan Installments")
            // {
            //     ApplicationArea = Basic, Suite;
            //     RunObject = Page "Mobile Loan Installments";
            //     RunPageLink = Product = FIELD("Product ID");
            // }

            action("Send A&pproval Request")
            {

                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    CustomApprovals: Codeunit "Custom Approvals Codeunit";
                begin

                    if Rec."Product Class Type" =
                         Rec."Product Class Type"::Savings then begin
                        Rec.TestField("Product ID");
                        Rec.TestField("Product Description");
                        //Rec.TestField("Interest Rate (Min.)");

                        if rec."Requires Suffix" then
                            Rec.TestField("Account No. Prefix");
                        //Rec.TestField("Account No. Suffix");
                        Rec.TestField("Product Posting Group");
                    end;
                    if Rec."Product Class Type" = Rec."Product Class Type"::Loan then begin
                        Rec.TestField("Product ID");
                        Rec.TestField("Product Description");
                        rec.TestField("Min. Customer Age");
                        if not Rec."Guarantor Loan" then
                            Rec.TestField("Interest Rate (Min.)");

                        if Rec."Requires Suffix" then
                            Rec.TestField("Account No. Prefix");

                        Rec.TestField("Loan  Account [G/L]");
                        Rec.TestField("Loan Interest Account [G/L]");
                        Rec.TestField("Loan Receivable Account[G/L]");
                        Rec.TestField("Product Posting Group");

                        if Rec."Charge 1 month Interest" then
                            rec.TestField("One Month Interest G/L");
                    end;
                    if Rec.Status = Rec.Status::Active then begin
                        Error('This product  has been Approved');
                    end
                    else
                        if Rec.Status = Rec.Status::Pending then begin
                            Error('This Product is Pending approval');
                        end
                        else
                            VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }
            action("Cancel Approval Re&quest")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    CustomApprovals: Codeunit "Custom Approvals Codeunit";
                begin
                    VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                var
                    //ApprovalEntries: Page "Approval Entries";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }
            action(ReOpen)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Re Open';
                Promoted = true;
                PromotedCategory = Category4;
                Image = OpenWorksheet;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";

                begin
                    VarVariant := Rec;
                    if not confirm('Are you sure you want to reopen this document?') then exit;
                    Rec."Approved By" := '';
                    Rec."Last Updated By" := UserId;
                    Rec.Status := Rec.Status::Open;
                    Rec."Xrec Minimum Balance" := Rec."Minimum Balance";
                    rec.modify;
                    ApprovalsMgmt.DeleteApprovalEntries(Rec.RecordId);
                    Message('The document have been opened successfully.');
                end;
            }

            action(Block)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Block';
                Promoted = true;
                PromotedCategory = Category4;
                Image = StopPayment;

                trigger OnAction()
                var

                begin
                    VarVariant := Rec;
                    if not confirm('Are you sure you want to block this product?') then exit;
                    Rec."Approved By" := '';
                    Rec."Last Updated By" := UserId;
                    Rec.Status := Rec.Status::Blocked;
                    rec.modify;
                    Message('The document have been blocked successfully.');
                end;
            }

        }
    }


    trigger OnAfterGetCurrRecord()
    begin
        DocumentControl;
    end;

    trigger OnAfterGetRecord()
    begin
        DocumentControl;
    end;

    trigger OnOpenPage()

    var
        SavingsAccounts: Record "Savings Accounts";
        ProductFactory: Record "Product Factory";
    begin
        if ProductFactory.status = ProductFactory.Status::Active then
            Editable := false;

        ProductFactory.Reset();
        ProductFactory.SetRange("Product Class Type", ProductFactory."Product Class Type"::Savings);
        if ProductFactory.FindFirst() then begin
            repeat
                SavingsAccounts.Reset();
                SavingsAccounts.SetRange("Product Type", ProductFactory."Product ID");
                if SavingsAccounts.FindFirst() then begin
                    SavingsAccounts."Customer Posting Group" := ProductFactory."Product Posting Group";
                    SavingsAccounts."Product Category" := ProductFactory."Product Category";
                    SavingsAccounts."Product Name" := ProductFactory."Product Description";
                    SavingsAccounts.Modify();
                end;
            until ProductFactory.Next() = 0;
        end;
    end;

    var
        FinancialsVisible: Boolean;
        SavingsProductVisible: Boolean;
        CreditProductVisible: Boolean;
        DocumentEdit: Boolean;
        InterestEdit: Boolean;
        UserSetup: Record "User Setup";
        VarVariant: Variant;
        CurrPageEditable: Boolean;

    //[Scope('OnPrem')]
    procedure DocumentControl()
    begin
        FinancialsVisible := true;

        if Rec."Product Class Type" = Rec."Product Class Type"::" " then begin
            FinancialsVisible := false;
            SavingsProductVisible := false;
            CreditProductVisible := false;
            InterestEdit := false;
        end;

        if Rec."Product Class Type" = Rec."Product Class Type"::Loan then begin
            InterestEdit := true;
            CreditProductVisible := true;
        end else begin
            InterestEdit := false;
            CreditProductVisible := false;
        end;

        if Rec."Product Class Type" = Rec."Product Class Type"::Savings then begin
            InterestEdit := false;
            SavingsProductVisible := true;
        end else begin
            InterestEdit := true;
            SavingsProductVisible := false;
        end;
        if Rec.Status <> Rec.Status::Open then begin
            CurrPageEditable := false;
        end else
            CurrPageEditable := true;


    end;
}
