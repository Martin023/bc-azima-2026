table 52185690 "Product Factory"
{
    DrillDownPageID = "Product Factory List";
    LookupPageID = "Product Factory List";
    fields
    {
        field(1; "Product ID"; Code[10])
        {
        }
        field(2; "Product Description"; Text[100])
        {
        }
        field(3; "Product Class Type"; Option)
        {
            Description = 'Whether Loan Accounts or Operational accounts';
            OptionCaption = ' ,Loan,Savings';
            OptionMembers = " ",Loan,Savings;
        }
        field(4; "Interest Rate (Min.)"; Decimal)
        {
        }
        field(5; "Interest Rate (Max.)"; Decimal)
        {
        }
        field(6; "Installment Repayment Interval"; DateFormula)
        {
        }
        field(7; Status; Option)
        {
            OptionCaption = 'Open,Pending,Active,Blocked,Rejected';
            OptionMembers = Open,Pending,Active,Blocked,Rejected;
            editable = false;

            trigger OnValidate()
            begin
                if (Rec.Status = Status::Rejected) then
                    GlobalFunctions.CommentsManagement(Rec."Product ID");
                case Status of
                    Status::Active:
                        begin

                            case "Product Class Type" of
                                "Product Class Type"::Savings:
                                    begin
                                        TestField("Product ID");
                                        TestField("Product Description");
                                        //TestField("Interest Rate (Min.)");
                                        TestField("Account No. Prefix");
                                        //TestField("Account No. Suffix");
                                        TestField("Product Posting Group");
                                    end;

                                "Product Class Type"::Loan:
                                    begin
                                        TestField("Product ID");
                                        TestField("Product Description");
                                        TestField("Interest Rate (Min.)");
                                        TestField("Account No. Prefix");

                                        TestField("Loan  Account [G/L]");
                                        TestField("Loan Interest Account [G/L]");
                                        TestField("Loan Receivable Account[G/L]");
                                        TestField("Product Posting Group");

                                        /*TESTFIELD(); TESTFIELD(); TESTFIELD(); TESTFIELD(); TESTFIELD(); TESTFIELD();*/
                                    end;
                            end;


                        end;
                end;

            end;
        }
        field(8; Currency; Code[10])
        {
            TableRelation = Currency.Code;
        }
        field(9; "Fixed Loan Term"; Boolean)
        {
        }
        field(10; "Withdrawal Interval"; DateFormula)
        {
            Description = 'Daily,Weekly,Monthly,Quoterly,Yearly';
        }
        field(11; "Maximum No. of Withdrawal"; Integer)
        {
        }
        field(12; "Product Ownership"; Option)
        {
            OptionCaption = 'Individual,Joint,Group/Business,Corporate';
            OptionMembers = Individual,Joint,"Group/Business",Corporate;
        }
        field(13; "Min. Customer Age"; DateFormula)
        {
        }
        field(14; "Max.Customer Age"; DateFormula)
        {
        }
        field(15; "Credit Limit(Overdraft)"; Decimal)
        {
        }
        field(16; "Minimum Balance"; Decimal)
        {
            Description = 'Operational deposit and withdrawable accounts- formely FOSA';

            trigger OnValidate()
            begin
                if "Minimum Balance" < 0 then
                    Error('Minimum balance cannot be less than zero');

            end;
        }
        field(17; "Automatic Overdraft"; Boolean)
        {
            Description = 'Current & Savings account';
        }
        field(18; "Customer Segment"; Code[30])
        {
            Description = 'Lookup to the Customer Segmentation';
        }
        field(19; "Minimum Contribution"; Decimal)
        {
            Description = 'FDR Account';
        }
        field(20; "Product Insured"; Boolean)
        {
        }
        field(21; "Account Minimum Balance[%]"; Decimal)
        {
        }
        field(22; "Loan  Account [G/L]"; Code[15])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(23; "Loan Interest Account [G/L]"; Code[15])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(24; "Loan Receivable Account[G/L]"; Code[15])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(25; "Use Cycle"; Boolean)
        {
        }
        field(26; "Grace Period - Interest"; DateFormula)
        {
        }
        field(27; "Product Posting Group"; Code[10])
        {
            Description = 'LookUp to Customer Posting Group';
            TableRelation = "Customer Posting Group";
        }
        field(28; "Closure Fee"; Code[10])
        {
            Description = 'Savings products';
            TableRelation = "Transaction Types".Code WHERE(Type = CONST("Member Withdrawal"));
        }
        field(29; "Dormancy Period"; DateFormula)
        {
            Description = 'Account no transactions';
        }
        field(30; "Account No. Prefix"; Code[4])
        {

            trigger OnValidate()
            var
                ProdFac: record "Product Factory";
            begin
                // Ensure no duplicate accounts
                ProdFac.Reset();
                ProdFac.SetLoadFields("Product ID", "Account No. Prefix");
                Prodfac.setfilter("Account No. Prefix", '<>%1', '');
                ProdFac.setfilter("Product ID", '<>%1', Rec."Product ID");
                ProdFac.SetRange("Requires Suffix", false);
                if ProdFac.FindFirst() then
                    repeat
                        if Rec."Account No. Prefix" = ProdFac."Account No. Prefix" then
                            Error('Account No. Prefix has already been used for product %1', ProdFac."Product ID");
                    until ProdFac.Next() = 0;
            end;
        }
        field(31; "Maximum Guarantors"; Integer)
        {
        }
        field(32; "Minimum Guarantors"; Integer)
        {
        }
        field(33; "Min. Re-application Period"; DateFormula)
        {
        }
        field(34; "Minimum Loan Amount"; Decimal)
        {
        }
        field(35; "Maximum Loan Amount"; Decimal)
        {
        }
        field(36; "Product Category"; Enum "Product Categories")
        {
            Description = 'Option to help identify type of savings accounts';
        }
        field(37; "Interest Calculation Method"; Option)
        {
            OptionCaption = 'Amortised,Reducing Balance,Straight Line,Reducing Flat';
            OptionMembers = Amortised,"Reducing Balance","Straight Line","Reducing Flat";
        }
        field(38; "Prefferential Default installm"; Integer)
        {
        }
        field(39; "Ordinary Default Intallments"; Integer)
        {
        }
        field(40; "Can Guarantee Loan"; Boolean)
        {
        }
        field(41; "Loan Disbursement Account"; Boolean)
        {
        }
        field(42; "Charge Closure Before Maturity"; Decimal)
        {
        }
        field(43; "Earns Interest"; Boolean)
        {
        }
        field(44; "Interest Expense Account"; Code[15])
        {
            TableRelation = "G/L Account";
        }
        field(45; "Interest Payable Account"; Code[15])
        {
            TableRelation = "G/L Account";
        }
        field(46; "External EFT Charges"; Decimal)
        {
        }
        field(47; "Interest Calc Min Balance"; Decimal)
        {
        }
        field(48; "Charge 1 month Interest"; Boolean)
        {
            Caption = 'Charge 1 month INT on Topup';

            trigger OnValidate()
            begin
                if "Charge 1 month Interest" then
                    rec.TestField("One Month Interest G/L");
            end;
        }
        field(49; "One Month Interest G/L"; Code[15])
        {
            Caption = 'One Month Interest Charge G/L';
            TableRelation = "G/L Account"."No.";
        }
        field(50; "Exclude One Month Interest"; Boolean)
        {
            //OptionMembers = "No Penalty","Principal in Arrears","Principal in Arrears+Interest in Arrears","Principal in Arrears+Interest in Arrears+Penalty in Arrears";
        }
        field(51; "Penalty Paid Account"; Code[15])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(52; "Ordinary Deposits Multiplier"; Decimal)
        {
        }
        field(53; "Dep. Multiplier On Collateral"; Decimal)
        {
        }
        field(54; "Allow Multiple Running Loans"; Boolean)
        {
        }
        field(55; "Loan Security Inclination"; Option)
        {
            OptionCaption = ' ,Short Loan Security,Long Term Loan Security';
            OptionMembers = " ","Short Term Loan Security","Long Term Loan Security";
        }
        field(56; "Loan Span"; Option)
        {
            OptionCaption = ' ,Minor,Major';
            OptionMembers = " ","Minor","Major";
        }
        field(57; "Recovery Priority"; Integer)
        {

            trigger OnValidate()
            begin
                SavingsAccounts.Reset;
                SavingsAccounts.SetRange(SavingsAccounts."Product Type", "Product ID");
                if SavingsAccounts.Find('-') then begin
                    repeat
                        SavingsAccounts."Recovery Priority" := "Recovery Priority";
                        SavingsAccounts.Modify;
                    until SavingsAccounts.Next = 0;
                end;

                Loans.Reset;
                Loans.SetRange(Loans."Loan Product Type", "Product ID");
                if Loans.Find('-') then begin
                    repeat
                        Loans."Recovery Priority" := "Recovery Priority";
                        Loans.Modify;
                    until Loans.Next = 0;
                end;
            end;
        }
        field(58; "Membership Type"; Option)
        {
            OptionCaption = ',Ordinary,Preferential';
            OptionMembers = ,Ordinary,Preferential;
        }
        field(59; "Repay Mode"; Enum "Loan Recovery Mode")
        {
            // OptionCaption = ' ,Checkoff,Salary,Dividend,Fixed Deposit,Internal STO, External STO,D Allowance';
            //OptionMembers = " ",Checkoff,Salary,Dividend,"Fixed Deposit","Internal STO"," External STO","D Allowance";
        }
        field(60; "Compute Interest Due on Postin"; Option)
        {
            OptionCaption = ' ,Full Interest,Pro-rata,Full Period Interest';
            OptionMembers = " ","Full Interest","Pro-rata","Full Period Interest";
        }
        field(61; "Withholding Tax Account"; Code[15])
        {
            TableRelation = "G/L Account";
        }
        field(62; "WithHolding Tax"; Decimal)
        {
        }
        field(63; "Bill Account"; Code[20])
        {
            TableRelation = "G/L Account"."No." WHERE("Direct Posting" = CONST(false));
        }
        field(64; "Billed Account"; Code[20])
        {
            TableRelation = "G/L Account"."No." WHERE("Direct Posting" = CONST(true));
        }
        field(65; "Auto Open Account"; Boolean)
        {
        }
        field(66; "Dividend Calc. Method"; Option)
        {
            OptionCaption = ' ,Flat Rate,Prorated';
            OptionMembers = " ","Flat Rate",Prorated;
        }
        field(67; "Allow Over Draft"; Boolean)
        {
        }
        field(68; "Over Draft Interest %"; Decimal)
        {
        }
        field(69; "Over Draft Interest Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(70; "Allow Multiple Over Draft"; Boolean)
        {
        }
        field(71; "Search Code"; Code[20])
        {
        }
        field(72; "Allow Multiple Accounts"; Boolean)
        {
        }
        field(73; "Maximum Deposit Contribution"; Decimal)
        {
        }
        field(74; "Minimum Deposit Balance"; Decimal)
        {
        }
        field(75; "Type of Discounting"; Option)
        {
            OptionCaption = ' ,Loan Discounting,Invoice Discounting,Cheque Discounting,Dividend Discounting';
            OptionMembers = " ","Loan Discounting","Invoice Discounting","Cheque Discounting","Dividend Discounting";
        }
        field(76; "Suspend Interest Account [G/L]"; Code[15])
        {
            TableRelation = "G/L Account"."No." WHERE("Direct Posting" = FILTER(true));
        }
        field(77; "Repayment Frequency"; Option)
        {
            OptionCaption = 'Daily,Weekly,Monthly,Quarterly,Yearly';
            OptionMembers = Daily,Weekly,Monthly,Quarterly,Yearly;
        }
        field(78; "Grace Period - Principle"; DateFormula)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GeneralSetup.get();
                if Format((GeneralSetup."Max. Loan Grace Period")) <> '' then begin
                    if CalcDate("Grace Period - Principle", Today) > CalcDate(GeneralSetup."Max. Loan Grace Period", Today) then
                        Error('Maximum allowable grace period exceeded, the maximum is %1 ', GeneralSetup."Max. Loan Grace Period");
                end;
            end;
        }
        field(79; "Nature of Loan Type"; Option)
        {
            OptionMembers = " ",Normal,Defaulter,"Bridging Loan","Karibu Loan","Commercial Bridging","Emergency Loan";
            OptionCaption = ' ,Normal,Defaulter,Bridging Loan,Karibu Loan,Commercial Bridging,Emergency Loan';
        }
        field(80; "Account No. Suffix"; Code[5])
        {
        }
        field(81; "No. Of Months for Appr. Saving"; Integer)
        {
        }
        field(82; "Loan Appraisal Income Acc."; Code[20])
        {
            TableRelation = "G/L Account"."No." WHERE("Direct Posting" = FILTER(true));
        }
        field(83; "Minimum Deposit Contribution"; Decimal)
        {
        }
        field(84; "Savings Duration"; DateFormula)
        {
        }
        field(85; "Savings Withdrawal penalty"; Decimal)
        {
        }
        field(86; "Savings Penalty Account"; Code[20])
        {
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                //TestNoEntriesExist(FIELDCAPTION("Savings Penalty Account"),"Savings Penalty Account")
            end;
        }
        field(89; "Member Category"; Code[10])
        {
            //TableRelation = Table39004278;
        }
        field(90; "Mortgage Loan"; Boolean)
        {
        }
        field(91; "Agency Charge Acc"; Boolean)
        {
        }
        field(92; "Loan Disbt Account Code"; Code[30])
        {
            TableRelation = "Product Factory"."Product ID" where("Product Class Type" = filter(Savings));
        }
        field(93; "Loan Appraisal Account Code"; Code[30])
        {
            TableRelation = "Product Factory"."Product ID" where("Product Class Type" = filter(Savings));
        }
        field(110; "Source Unit"; Enum "Source Unit")
        {
            // OptionCaption = ' ,FOSA,BOSA,BUSINESS LOANS,HR LOANS';
            // OptionMembers = "",FOSA,BOSA,"BUSINESS LOANS","HR LOANS";
        }
        field(111; "Maximum Deposit Boost %"; Decimal)
        {
            Caption = 'Maximum Deposit Boosting %';
        }
        field(112; "Minimum Application Period"; DateFormula)
        {
            Caption = 'Minimum Application Period';
        }
        field(113; Gender; Enum Gender)
        {
            // OptionMembers = " ",Male,Female;
            // OptionCaption = ' ,Male,Female';
        }
        field(114; "Can Recover Loan"; Boolean)
        {
        }
        field(116; "Xrec Minimum Balance"; Decimal)
        {
            Editable = false;
            Caption = 'Prev. Minimum Balance.';
            Description = 'Captures the immediate miminum balance before the change';
        }
        field(117; "Loan Term Type"; Option)
        {
            OptionCaption = ' ,Short Term,Long Term,';
            OptionMembers = " ","Short Term","Long Term";
            Caption = 'Loan Term Type';
        }
        field(50000; "Disbursement Priority"; Integer)
        {

            trigger OnValidate()
            begin
                /*    Loans.Reset;
                    Loans.SetRange(Loans."Loan Product Type", "Product ID");
                    if Loans.Find('-') then begin
                        repeat
                            Loans."Recovery Priority" := "Recovery Priority";
                            Loans.Modify;
                        until Loans.Next = 0;
                    end;
                    */
            end;
        }
        field(50004; "Maximum Loan Amount(Mobile)"; Decimal)
        {
        }
        field(50005; "Statement E-Mail Freq."; DateFormula)
        {
        }
        field(50006; "Discounting %"; Decimal)
        {
        }
        field(50007; "Computation %"; Decimal)
        {
        }
        field(50008; "Statement Charge"; Code[10])
        {
            TableRelation = "Transaction Types".Code WHERE(Type = CONST(Statement));
        }
        field(50009; "Certified Statement Charge"; Code[10])
        {
            TableRelation = "Transaction Types".Code WHERE(Type = CONST(Statement));
        }
        field(50050; "Mobile Transaction"; Option)
        {
            OptionMembers = " ","Deposits Only","Withdrawals Only","Deposits & Withdrawals";
        }
        field(50051; "Mobile Loan Net %"; Decimal)
        {
        }
        field(50052; "USSD Product Name"; Text[50])
        {
            Description = ' USSD Product Name';
        }
        field(50152; "Is USSD Product"; Boolean)
        {
        }
        field(50053; "Savings Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Withdrawable,"Non-Withdrawable","Retained Shares",Term;
        }
        field(50054; "Restrict to Emp. Code"; Code[20])
        {
            TableRelation = Customer;
        }
        field(50055; "Interest Recovered Upfront"; Boolean)
        {
        }
        field(50056; "Auto Send SMS Alerts"; Boolean)
        {
        }
        field(50086; "Available To Member"; Code[20])
        {
            //TableRelation = Table39004255;
        }
        field(50087; "Salary Loans"; Boolean)
        {
        }
        field(50088; "Mobile Loan Req. Guar."; Boolean)
        {
        }
        field(50089; "Mobile Installments Type"; Option)
        {
            OptionMembers = "None",Input,Preset;
        }
        field(50090; "Min. Mobile Installments"; Integer)
        {
        }
        field(50091; "Max. Mobile Installments"; Integer)
        {
        }
        field(50092; "Minimum Guarantor Deposits"; Decimal)
        {
        }
        field(50093; "Requires TnC"; Boolean)
        {
        }
        field(50094; "Shows Mobile Qualification"; Boolean)
        {
        }
        field(50095; "MLoan Appraisal Start Point"; Decimal)
        {
        }
        field(50096; "MLoan Appraisal Increment"; Decimal)
        {
        }
        field(50097; "Requires Payslip PIN"; Boolean)
        {
        }
        field(50098; Category; Enum "Accounts Category")
        {

        }
        field(50099; "Sort Order"; Integer)
        {
            Caption = 'Visibility Sort Order';
            Description = 'The order in which the product is displayed to the member';
        }
        field(50100; "Requires Branch"; Boolean)
        {
        }
        field(50101; "Requires Purpose"; Boolean)
        {
        }
        field(50102; "Loan Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50103; "Min. Net after Topup"; Decimal)
        {
        }
        field(50104; "Sky Income From Sacco Interest"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(50105; "Mobile Min. Loan Amount"; Decimal)
        {
        }
        field(50106; "Mobile Max. Loan Amount"; Decimal)
        {
        }
        field(50107; "Mobile Min. Guarantors"; Integer)
        {
        }
        field(50108; "Mobile Max. Guarantors"; Integer)
        {
        }
        field(501109; "Deafulter Loan Product"; Code[20])
        {
            TableRelation = "Product Factory"."Product ID" WHERE("Product Class Type" = FILTER(Loan),
                                                       "Nature of Loan Type" = CONST(Defaulter));
        }

        field(510; "Penalty Income Account"; Code[15])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(511; "Last Updated By"; Code[50])
        {
            TableRelation = "User Setup";
            Caption = 'Approval Request By';
            Editable = false;
        }
        field(512; "Approved By"; Code[50])
        {
            TableRelation = "User Setup";
            Editable = false;
        }

        field(610; "Loan Prorata Factor"; Code[20])
        {
            TableRelation = "Tiered Charges Header".Code;
            Caption = 'Loan Prorata Factor';

            trigger OnValidate()
            begin
                // if "Minimum Deposit Tiered" = false then
                //    Error('Code must not be specified')
            end;
        }
        field(611; "CRB Product Type"; Code[50])
        {
            TableRelation = "Tiered Charges Header".Code;

            trigger OnValidate()
            begin

            end;
        }
        field(39004241; Notice; DateFormula)
        {
        }
        field(39004242; "Allow Mobile Applications"; Boolean)
        {
        }
        field(39004243; "Allow Self Guarantee"; Boolean)
        {
        }
        field(39004244; "No. of Salary Times"; Integer)
        {
        }
        field(39004245; "Salary Period"; DateFormula)
        {
        }
        field(39004248; "Minimum Dep. Contribution %"; Decimal)
        {
            MaxValue = 100;
            MinValue = 0;
        }
        field(39004249; "Source of Funds"; Option)
        {
            OptionMembers = "Internal Fund","External Fund";
        }
        field(39004250; "Source Of Funds No."; Code[20])
        {
            TableRelation = Vendor."No." WHERE("Vendor Type" = CONST("Source of Funds"));
        }
        field(39004251; "Max. Member Age"; DateFormula)
        {
        }
        field(39004252; "Net Salary Multiplier %"; Decimal)
        {
            MaxValue = 100;
            MinValue = 1;
        }
        field(39004253; "Appraisal Parameter Type"; Option)
        {
            OptionMembers = "Check Off",Salary,"Corporate or Business","Staff Loans";
        }
        field(39004254; "Minimum Guarantors on Max Amt"; Integer)
        {
        }
        field(39004255; "Max Amt on Guarantors"; Decimal)
        {
        }
        field(39004256; "View Online"; Boolean)
        {
        }
        field(39004257; "Requires Salary Processing"; Boolean)
        {
        }
        field(39004258; "Mobile Loan"; Boolean)
        {
        }
        field(39004259; "Does not Require Batching"; Boolean)
        {
        }
        field(39004260; "Minimum Deposit Tiered"; Boolean)
        {
            Caption = 'Prorata Deposit Tiered';
        }
        field(39004261; "Minimum Deposit Tiered Code"; Code[20])
        {
            TableRelation = "Tiered Charges Header".Code;
            Caption = 'Prorata Deposit Contribution';

            trigger OnValidate()
            begin
                if "Minimum Deposit Tiered" = false then
                    Error('Code must not be specified')
            end;
        }


        field(39004262; Target; Decimal)
        {
        }
        field(39004263; "Accrual Fee Acc. (Income)"; Code[20])
        {
            TableRelation = "G/L Account"."No." WHERE("Direct Posting" = FILTER(true),
                                                       "Income/Balance" = CONST("Income Statement"));
        }
        field(39004264; "Accrue Monthly"; Boolean)
        {
        }
        field(39004265; "Monthly Charges"; Decimal)
        {
        }
        field(39004266; "Service Tarrif Percentage"; Decimal)
        {
        }
        field(39004267; "No. of Gura. Salary Times"; Integer)
        {
        }
        field(39004268; "No Interest Bills"; Boolean)
        {
        }
        field(39004269; "No Principle Bills"; Boolean)
        {
        }
        field(39004270; "Compute Bills on Posting"; Option)
        {
            OptionCaption = ' No Bill,Full Amount,One Installment';
            OptionMembers = " No Bill","Full Amount","One Installment";

            trigger OnValidate()
            begin
                if "Compute Bills on Posting" = "Compute Bills on Posting"::"Full Amount" then
                    "No Principle Bills" := true;
            end;
        }
        field(39004271; AvailableOnMobile; Boolean)
        {
        }
        field(39004272; "Allowed Transaction"; Option)
        {
            OptionCaption = 'Withdraw Only,Deposit Only,Withdraw & Deposit,No Transactions';
            OptionMembers = "Withdraw Only","Deposit Only","Withdraw & Deposit","No Transactions";
        }
        field(39004273; "Allow Send Email"; Boolean)
        {
        }
        field(39004274; "Shamba Loan"; Boolean)
        {
        }
        field(39004275; "DAdvance Limit Period"; Date)
        {
        }
        field(39004276; "Portal Viewable"; Boolean)
        {
        }
        field(39004277; "Portal Order"; Integer)
        {
        }
        field(39004278; "Dividend Advance Year"; Integer)
        {
        }
        field(39004279; "Bussiness Acc Prefix"; Code[1])
        {
        }
        field(39004280; "Business Acc Surfix"; Code[1])
        {
        }
        field(39004281; "Minimum Amt B/s Accnt"; Decimal)
        {
        }
        field(39004282; "Account Creation Method"; Enum "Account Creation Method")
        {

        }
        field(710; "Variation Allowed"; Boolean)
        {

        }
        field(711; "Minimum Service"; DateFormula)
        {

        }
        field(712; "Staff Salary Multiplier"; Decimal)
        {

        }
        field(713; "Require Deposits"; Boolean)
        {

        }
        field(714; "Security Muliplier"; Decimal)
        {

        }
        field(715; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin

            end;
        }
        field(716; "Account No. Serries"; Code[20])
        {
            Caption = 'Account No. Serries';

            trigger OnValidate()
            begin
                if "Account Creation Method" <> "Account Creation Method"::"Savings Collection" then
                    Error('This is only applicable to Savings Collection Accounts.');
            end;

        }
        field(717; "FosaLoan Multiplier"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(718; "Recovery Creteria"; Option)
        {
            OptionMembers = " ","Guarantors and Shares","Guarantors Only","Shares Only";
        }
        field(719; "Recovery Product"; Code[30])
        {
            TableRelation = "Product Factory"."Product ID" where("Product Class Type" = const(Savings));
            Description = 'This is the product that is going to be used for reappotionment';
        }

        field(721; "Loan Exclusive Factor"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Tiered Charges Header".Code;
            Caption = 'Loan Exclussive Factor';
        }
        field(722; "Subsequent Multiplier"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(723; "Exclude From Closure"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(800; "Is CRM Product"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Available on Members Portal';
        }
        field(801; "Allow Deposit Boost"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(802; "Salary Income Types"; Enum "Salary Income Types")
        {
            DataClassification = ToBeClassified;
        }
        field(803; "Loan Purpose"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loan Purpose".Code;
            trigger OnValidate()
            var
                myInt: Integer;
                Purpose: Record "Loan Purpose";
            begin
                if Purpose.Get("Loan Purpose") then
                    "Puporse Description" := Purpose.Description;
            end;
        }
        field(804; "Puporse Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(805; "Max Second-Hand Period"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(806; "Is a Car Loan"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(807; "Minimum Security Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(808; "Requires Suffix"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(809; "Secured Loan"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(1000; "Channels Ext. Transfer Options"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "None","Deposit Only","Withdrawals Only","All - Deposit + Withdrawal";
            Caption = 'Channels External Transfer Options';
        }
        field(1001; "Channels Int. Transfer Options"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "None","Deposit Only","Withdrawals Only","All - Deposit + Withdrawal";
            Caption = 'Channels Internal Transfer Options';
        }
        field(1002; "SASRA Savings Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Savings","Non Withdrawable","Term";
        }
        field(10018; "Dividends Incentives"; Code[10])
        {
            TableRelation = "Transaction Types" WHERE(Type = CONST("Dividends Capt. Incentives"));
        }
        field(10019; "Dividends Incentives G\L"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(10020; "Loan Refinancing"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10021; "Product SLA"; Duration)
        {
            DataClassification = ToBeClassified;
        }
        field(10022; "Can Be Closed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10023; "Is a Construction Loan"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10024; "Loan Group"; Option)
        {
            OptionMembers = Normal,"Group Loan";
            OptionCaption = 'Normal,Group Loan';
            DataClassification = ToBeClassified;
        }
        field(10025; "Auto Openning Account Status"; Enum "Savings Account Status")
        {
            // OptionCaption = ' ,New,Active,Dormant,Frozen,Withdrawal Application,Withdrawn,Deceased,Defaulter,Closed';
            // OptionMembers = " ",New,Active,Dormant,Frozen,"Withdrawal Application",Withdrawn,Deceased,Defaulter,Closed;
        }

        field(10026; "Account Group"; Option)
        {
            OptionMembers = " ","Single Account","Group Account";
            OptionCaption = ' ,Single Account,Group Account';
        }
        field(10027; "Loan Security"; Option)
        {
            OptionMembers = " ","Guarantors and Collateral","Guarantors Only","Collateral Only","Fixed Deposit Only";
            OptionCaption = ' ,All,Guarantors Only,Collateral Only,Fixed Deposit Only';
        }
        field(10028; "Auto Open Group Account"; Boolean)
        {
        }

        field(10029; "Appraisal - Omit Deductions"; Boolean)
        {
            Caption = 'Skip Deductions during appraisal?';
        }
        field(10030; "Account Transfer Charges"; code[100])
        {
            Caption = 'Account Transfer Charges';
            TableRelation = "Transaction Types" where("Product Type" = field("Product ID"));
        }
        field(10031; "Account Transfer Charge Period"; DateFormula)
        {
            Caption = 'Account Transfer Charge Period';
        }
        field(10032; "Upfront Interest Rate"; Decimal)
        {
        }

        field(10033; "Least Sal Rate %"; Decimal)
        {
            Caption = 'Least Salary Rate Percentage';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Rec."Least Sal Rate %" > 100 then begin
                    Error('Maximum Value allowed is 100');
                end;
                if Rec."Least Sal Rate %" <= 0 then begin
                    Error('Minimum Value allowed is 0');
                end;
            end;
        }

        field(10034; "Portal Autoposting Allowed"; Boolean)
        {
        }
        field(10035; "Guarantor Loan"; Boolean)
        {
        }
        field(10036; "Exempt From Fosa Minimum"; Boolean)
        {
        }
        field(10037; "Staff Loan Exempption"; Boolean)
        {
        }
        field(10038; "Pension Loan"; Boolean)
        {
        }
        field(10039; "Dormancy Alert Period"; DateFormula)
        {
            Description = 'Account no transactions';
        }
        field(10040; "IsAvailableInMonth"; Boolean)
        {
            Caption = 'Is Available In Month';
        }
        field(10041; "Deposit Qualifier %"; Decimal)
        {
            MaxValue = 100;
            MinValue = 1;
        }
        field(10042; "Use Contribution Qualification"; Boolean)
        {
            Caption = 'Use Contribution Qualification';
            DataClassification = CustomerContent;
        }
        field(10043; "Use Salary Average"; Boolean)
        {
            Caption = 'Use Salary Average';
            DataClassification = CustomerContent;
        }
        field(10044; "Emergency Loan"; Boolean)
        {
            Caption = 'Emergency Loan';
            DataClassification = CustomerContent;
        }
        field(10045; "Over The Counter Transaction"; Boolean)
        {
            Caption = 'Over The Counter Transaction';
        }
        field(10046; "Allow Topup"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Product ID")
        {
            Clustered = true;
        }
        key(Key2; "Product Class Type")
        {
        }

        // Secondary keys for non-primary fields
        key(IdxStatus; "Status")
        {
            Clustered = false;
        }

        key(IdxMobileLoan; "Mobile Loan")
        {
            Clustered = false;
        }

        key(IdxProductCategory; "Product Category")
        {
            Clustered = false;
        }

        key(IdxAutoOpenAccount; "Auto Open Account")
        {
            Clustered = false;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Product ID", "Product Description")
        {
        }
    }
    trigger OnModify()
    var
        myInt: Integer;
    begin

    end;

    var
        SavingsAccounts: Record "Savings Accounts";
        Loans: Record Loans;
        GeneralSetup: Record "General Set-Up";
        GlobalFunctions: Codeunit "Global Functions";


    // [Scope('OnPrem')]
    procedure GetReceivablesAccount(ProductCode: Code[20]; TransactionType: enum "Transaction Types"): Code[20]
    var
        LoanProductCharges: Record "Loan Product Charges";
    begin
        Get(ProductCode);
        if (TransactionType = TransactionType::Loan) or (TransactionType = TransactionType::Repayment) then begin
            exit("Loan  Account [G/L]");
        end
        else
            if (TransactionType = TransactionType::"Interest Due") or (TransactionType = TransactionType::"Interest Paid") then begin
                exit("Loan Receivable Account[G/L]");
            end
            else
                if TransactionType = TransactionType::Bills then begin
                    exit("Bill Account");
                end
                else
                    if TransactionType = TransactionType::Appraisal then begin
                        LoanProductCharges.Reset;
                        LoanProductCharges.SetRange(LoanProductCharges."Product Code", "Product ID");
                        LoanProductCharges.SetRange(LoanProductCharges.Prorate, LoanProductCharges.Prorate::Appraisal);
                        if LoanProductCharges.Find('-') then begin
                            exit(LoanProductCharges."Charges G_L Account");
                        end;
                    end;
    end;

    procedure GetRiskBBfArrears(SavAccNo: code[50]): Decimal
    var
        SavAcc: Record "Savings Accounts";
        ProductFactory: Record "Product Factory";
        MonthlyContrib: Record "Monthly Contrib Logs";
        Members: record Members;
        NumOfMnths: Integer;
        StartDate: date;
        EndDate: Date;
    //ExpectedContrbArrears: List of [Decimal];
    begin
        // Clear(ExpectedContrbArrears);
        EndDate := Today;
        SavAcc.reset;
        SavAcc.SetRange("No.", SavAccNo);
        if SavAcc.find('-') then begin
            Members.Get(SavAcc."Member No.");
            if Members."Contribution Effective Date" <> 0D then begin
                if Date2DMY(Members."Contribution Effective Date", 3) >= 2024 then
                    startdate := Members."Contribution Effective Date"
                else begin
                    startdate := 20240101D;//CalcDate('<CY>', Today);
                end;
            end
            else
                startdate := 20240101D;//CalcDate('<CY>', Today);

            if Members.Status = Members.Status::"Closed" then begin
                if Members."Closure Date" <> 0D then begin
                    if Date2DMY(Members."Closure Date", 3) >= 2024 then
                        EndDate := Members."Closure Date"
                    else
                        exit(0);
                end
                else
                    exit(0);
            end;

            SavAcc.setfilter("Date Filter", '%1..%2', startdate, Today);
            SavAcc.CalcFields("Balance (LCY)");

            //NumOfMnths := Round((EndDate - StartDate) / 30, 1, '>');
            // ExpectedContrbArrears.Add((SavAcc."Monthly Contribution" * NumOfMnths) - SavAcc."Balance (LCY)");
            // ExpectedContrbArrears.Add(SavAcc."Monthly Contribution");

            exit((GetProductContribution(SavAcc."Product Type", StartDate, EndDate)) - SavAcc."Balance (LCY)");


        end
        else
            exit(0);
    end;


    // procedure GetExpectedBBFInPeriod(SavAccNo: code[50]; StartDate: Date; EndDate: Date): Decimal
    // var
    //     Members: record Members;
    //     SavAcc: record "Savings Accounts";
    //     StartDateII: Date;
    //     NoOfMonths: Integer;
    // begin
    //     //if SStartDate
    //     SavAcc.get(SavAccNo);
    //     if Members.get(SavAcc."Member No.") then begin
    //         if Members."Contribution Effective Date" <> 0D then begin
    //             if Date2DMY(Members."Contribution Effective Date", 3) >= 2024 then
    //                 StartDateII := Members."Contribution Effective Date"
    //             else
    //                 StartDateII := 20240101D;//CalcDate('<CY>', Today);
    //         end
    //         else begin
    //             StartDateII := 20240101D;
    //         end;
    //         // if Members."Closure Date" <> 0D then begin
    //         //     if (Members."Closure Date" < EndDate) and (EndDate > StartDate) then
    //         //         EndDate := Members."Closure Date";
    //         // end;
    //     end
    //     else
    //         StartDateII := 20240101D;

    //     if Startdate < StartDateII then StartDate := StartDateII;
    //     if EndDate < StartDate then EndDate := StartDate;

    //     if EndDate - Startdate = 0 then
    //         exit(0)
    //     else begin
    //         // NoOfMonths := Round((EndDate - StartDate) / 30, 1, '<');
    //         // Exit(SavAcc."Monthly Contribution" * NoOfMonths);
    //         exit(GetProductContribution(SavAcc."Product Type", StartDate, EndDate));
    //     end;
    // end;

    procedure GetProductContribution(ProdID: Code[20]; StartDate: Date; EndDate: Date): decimal
    var
        ProductFactory: Record "Product Factory";
        ContribLogs: Record "Monthly Contrib Logs";
        ContribB4Change: Decimal;
        ContribAfterChange: Decimal;
        TotalContributions: List of [Decimal];
        i: integer;
        turn: Integer;
    begin
        ContribB4Change := 0;
        Clear(TotalContributions);
        ProductFactory.reset();
        ProductFactory.setrange("Product ID", ProdID);
        if ProductFactory.FindFirst() then begin
            ContribLogs.reset();
            ContribLogs.SetCurrentKey("Effective Date");
            ContribLogs.SetAscending("Effective Date", true);
            ContribLogs.setrange("Product ID", ProdID);
            if ContribLogs.FindFirst() then begin
                turn := 0;
                repeat
                    if ContribLogs."End Date" = 0D then
                        ContribLogs."End Date" := Today;
                    // Beofre the change
                    if (StartDate < ContribLogs."Effective Date") and (turn = 0) then begin
                        TotalContributions.Add(ProductFactory."Minimum Contribution" * Round((ContribLogs."Effective Date" - StartDate) / 30, 1, '<'));
                        //TotalContributions
                        //After the change
                        // if enddate > ContribLogs."End Date" then begin
                        //     TotalContributions.Add(ContribLogs."Monthly Contribution" * Round((ContribLogs."End Date" - ContribLogs."Effective Date") / 30, 1, '<'));
                        // end
                        // else begin
                        TotalContributions.Add(ContribLogs."Monthly Contribution" * Round((EndDate - ContribLogs."Effective Date") / 30, 1, '<'));
                        // end;
                    end;
                    // else begin
                    //     if (StartDate in [ContribLogs."Effective Date" .. ContribLogs."End Date"]) then begin
                    //         if EndDate > ContribLogs."End Date" then begin
                    //             TotalContributions.Add(ContribLogs."Monthly Contribution" * Round((ContribLogs."End Date" - StartDate) / 30, 1, '<'));
                    //             StartDate := calcdate('1D', ContribLogs."End Date");
                    //         end
                    //         else begin
                    //             TotalContributions.Add(ContribLogs."Monthly Contribution" * Round((EndDate - StartDate) / 30, 1, '<'));
                    //         end;
                    //         TotalContributions.Add(ContribLogs."Monthly Contribution" * Round((EndDate - StartDate) / 30, 1, '<'));
                    //     end;
                    // end;
                    turn += 1;

                until ContribLogs.Next() = 0;

                for i := 1 to TotalContributions.Count do begin
                    ContribB4Change += TotalContributions.get(i);
                end;
            end
            else
                ContribB4Change := ProductFactory."Minimum Contribution" * Round((EndDate - StartDate) / 30, 1, '<');
        end;
        exit(ContribB4Change);
    end;

    procedure GetMonthlyContrib(ProdID: Code[20]; EndDate: Date): Decimal
    var
        ProductFactory: Record "Product Factory";
        ContribLogs: Record "Monthly Contrib Logs";
    begin
        ProductFactory.reset();
        ProductFactory.setrange("Product ID", ProdID);
        if ProductFactory.FindFirst() then begin
            ContribLogs.reset();
            ContribLogs.SetCurrentKey("Effective Date");
            ContribLogs.SetAscending("Effective Date", true);
            ContribLogs.setrange("Product ID", ProdID);
            if ContribLogs.FindFirst() then begin
                repeat
                    if ContribLogs."End Date" = 0D then
                        ContribLogs."End Date" := Today;
                    if Enddate in [ContribLogs."Effective Date" .. ContribLogs."End Date"] then
                        exit(ContribLogs."Monthly Contribution")
                until ContribLogs.next = 0;
            end
            else
                exit(ProductFactory."Minimum Contribution")
        end;
    end;
}

