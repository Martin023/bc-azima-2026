table 52186117 "Product Factory Application"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SeriesSetup.Get;
                    NoSeriesMgt.TestManual(SeriesSetup."Product Factory");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Document Date"; Date)
        {
            Editable = false;
        }
        field(3; "Document Time"; Time)
        {
        }
        field(4; "Product ID"; Code[10])
        {
        }
        field(5; "Product Description"; Text[100])
        {
        }
        field(6; "Product Class Type"; Option)
        {
            Description = 'Whether Loan Accounts or Operational accounts';
            OptionCaption = ' ,Loan,Savings';
            OptionMembers = " ",Loan,Savings;
        }
        field(7; "No. Series"; Code[20])
        {
        }
        field(8; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending,Approved,Rejected,Converted';
            OptionMembers = Open,Pending,Approved,Rejected,Converted;
        }
        field(9; "Interest Rate (Min.)"; Decimal)
        {
        }
        field(10; "Interest Rate (Max.)"; Decimal)
        {
        }
        field(11; "Installment Repayment Interval"; DateFormula)
        {
        }
        field(12; Status1; Option)
        {
            OptionCaption = 'Open,Active,Blocked';
            OptionMembers = Open,Active,Blocked;
        }
        field(13; Currency; Code[10])
        {
            TableRelation = Currency.Code;
        }
        field(14; "Fixed Loan Term"; Boolean)
        {
        }
        field(15; "Withdrawal Interval"; DateFormula)
        {
            Description = 'Daily,Weekly,Monthly,Quoterly,Yearly';
        }
        field(16; "Maximum No. of Withdrawal"; Integer)
        {
        }
        field(17; "Product Ownership"; Option)
        {
            OptionCaption = 'Individual,Joint,Group/Business,Corporate';
            OptionMembers = Individual,Joint,"Group/Business",Corporate;
        }
        field(18; "Min. Customer Age"; DateFormula)
        {
        }
        field(19; "Max.Customer Age"; DateFormula)
        {
        }
        field(20; "Credit Limit(Overdraft)"; Decimal)
        {
        }
        field(21; "Minimum Balance"; Decimal)
        {
            Description = 'Operational deposit and withdrawable accounts- formely FOSA';

            trigger OnValidate()
            begin
                /*IF "Minimum Balance"<0 THEN
                  ERROR('Minimum balance cannot be less than zero');*/

            end;
        }
        field(22; "Automatic Overdraft"; Boolean)
        {
            Description = 'Current & Savings account';
        }
        field(23; "Customer Segment"; Code[30])
        {
            Description = 'Lookup to the Customer Segmentation';
        }
        field(24; "Minimum Contribution"; Decimal)
        {
            Description = 'FDR Account';
        }
        field(25; "Product Insured"; Boolean)
        {
        }
        field(26; "Account Minimum Balance[%]"; Decimal)
        {
        }
        field(27; "Loan  Account [G/L]"; Code[15])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(28; "Loan Interest Account [G/L]"; Code[15])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(29; "Loan Receivable Account[G/L]"; Code[15])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(30; "Use Cycle"; Boolean)
        {
        }
        field(31; "Grace Period - Interest"; DateFormula)
        {
        }
        field(32; "Product Posting Group"; Code[10])
        {
            Description = 'LookUp to Customer Posting Group';
            TableRelation = "Customer Posting Group";
        }
        field(33; "Closure Fee"; Code[10])
        {
            Description = 'Savings products';
            TableRelation = "Transaction Types".Code WHERE(Type = CONST("Member Withdrawal"));
        }
        field(34; "Dormancy Period"; DateFormula)
        {
            Description = 'Account no transactions';
        }
        field(35; "Account No. Prefix"; Code[4])
        {
        }
        field(36; "Maximum Guarantors"; Integer)
        {
        }
        field(37; "Minimum Guarantors"; Integer)
        {
        }
        field(38; "Min. Re-application Period"; DateFormula)
        {
        }
        field(39; "Minimum Loan Amount"; Decimal)
        {
        }
        field(40; "Maximum Loan Amount"; Decimal)
        {
        }
        field(41; "Product Category"; Enum "Product Categories")
        {
            Description = 'Option to help identify type of savings accounts';
            // OptionCaption = ' ,Share Capital,Deposit Contribution,Fixed Deposit,Junior Savings,Registration Fee';
            //OptionMembers = " ","Share Capital","Deposit Contribution","Fixed Deposit","Junior Savings","Registration Fee";
        }
        field(42; "Interest Calculation Method"; Option)
        {
            OptionCaption = 'Amortised,Reducing Balance,Straight Line,Constants';
            OptionMembers = Amortised,"Reducing Balance","Straight Line",Constants;
        }
        field(43; "Prefferential Default installm"; Integer)
        {
        }
        field(44; "Ordinary Default Intallments"; Integer)
        {
        }
        field(45; "Can Guarantee Loan"; Boolean)
        {
        }
        field(46; "Loan Disbursement Account"; Boolean)
        {
        }
        field(47; "Charge Closure Before Maturity"; Decimal)
        {
        }
        field(48; "Earns Interest"; Boolean)
        {
        }
        field(49; "Interest Expense Account"; Code[15])
        {
            TableRelation = "G/L Account";
        }
        field(50; "Interest Payable Account"; Code[15])
        {
            TableRelation = "G/L Account";
        }
        field(51; "External EFT Charges"; Decimal)
        {
        }
        field(52; "Interest Calc Min Balance"; Decimal)
        {
        }
        field(53; "Penalty Calculation Days"; DateFormula)
        {
        }
        field(54; "Penalty Percentage"; Decimal)
        {
        }
        field(55; "Penalty Calculation Method"; Option)
        {
            OptionMembers = "No Penalty","Principal in Arrears","Principal in Arrears+Interest in Arrears","Principal in Arrears+Interest in Arrears+Penalty in Arrears";
        }
        field(56; "Penalty Paid Account"; Code[15])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(57; "Ordinary Share Multiplier"; Integer)
        {
        }
        field(58; "Preferential Share Multiplier"; Integer)
        {
        }
        field(59; "Allow Multiple Running Loans"; Decimal)
        {
        }
        field(60; "Loan Security Inclination"; Option)
        {
            OptionCaption = ' ,Short Loan Security,Long Term Loan Security';
            OptionMembers = " ","Short Term Loan Security","Long Term Loan Security";
        }
        field(61; "Loan Span"; Option)
        {
            OptionCaption = ' ,Short Term,Long Term';
            OptionMembers = " ","Short Term","Long Term";
        }
        field(62; "Recovery Priority"; Integer)
        {
        }
        field(63; "Membership Type"; Option)
        {
            OptionCaption = ',Ordinary,Preferential';
            OptionMembers = ,Ordinary,Preferential;
        }
        field(64; "Repay Mode"; Enum "Loan Recovery Mode")
        {
            //OptionCaption = ' ,Checkoff,Salary,Dividend,Fixed Deposit';
            // OptionMembers = " ",Checkoff,Salary,Dividend,"Fixed Deposit";
        }
        field(65; "Compute Interest Due on Postin"; Option)
        {
            OptionCaption = ' ,Full Interest,Pro-rata';
            OptionMembers = " ","Full Interest","Pro-rata";
        }
        field(66; "Withholding Tax Account"; Code[15])
        {
            TableRelation = "G/L Account";
        }
        field(67; "WithHolding Tax"; Decimal)
        {
        }
        field(68; "Bill Account"; Code[20])
        {
            TableRelation = "G/L Account"."No." WHERE("Direct Posting" = CONST(false));
        }
        field(69; "Billed Account"; Code[20])
        {
            TableRelation = "G/L Account"."No." WHERE("Direct Posting" = CONST(true));
        }
        field(70; "Auto Open Account"; Boolean)
        {
        }
        field(71; "Dividend Calc. Method"; Option)
        {
            OptionCaption = ' ,Flat Rate,Prorated';
            OptionMembers = " ","Flat Rate",Prorated;
        }
        field(72; "Allow Over Draft"; Boolean)
        {
        }
        field(73; "Over Draft Interest %"; Decimal)
        {
        }
        field(74; "Over Draft Interest Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(75; "Allow Multiple Over Draft"; Boolean)
        {
        }
        field(76; "Search Code"; Code[20])
        {
        }
        field(77; "Allow Multiple Accounts"; Boolean)
        {
        }
        field(78; "Minimum Deposit Contribution"; Decimal)
        {
        }
        field(79; "Minimum Deposit Balance"; Decimal)
        {
        }
        field(80; "Type of Discounting"; Option)
        {
            OptionCaption = ' ,Loan Discounting,Invoice Discounting,Cheque Discounting';
            OptionMembers = " ","Loan Discounting","Invoice Discounting","Cheque Discounting";
        }
        field(81; "Suspend Interest Account [G/L]"; Code[15])
        {
            TableRelation = "G/L Account"."No." WHERE("Direct Posting" = FILTER(true));
        }
        field(82; "Repayment Frequency"; Option)
        {
            OptionCaption = 'Daily,Weekly,Monthly,Quarterly,Yearly';
            OptionMembers = Daily,Weekly,Monthly,Quarterly,Yearly;
        }
        field(83; "Grace Period - Principle"; DateFormula)
        {
        }
        field(84; "Nature of Loan Type"; Option)
        {
            OptionCaption = ' ,Normal,Defaulter';
            OptionMembers = " ",Normal,Defaulter;
        }
        field(85; "Account No. Suffix"; Code[4])
        {
        }
        field(86; "No. Of Months for Appr. Saving"; Integer)
        {
        }
        field(87; "Statement E-Mail Freq."; DateFormula)
        {
        }
        field(88; "Discounting %"; Decimal)
        {
        }
        field(89; "Computation %"; Decimal)
        {
        }
        field(90; "Statement Charge"; Code[10])
        {
            TableRelation = "Transaction Types".Code WHERE(Type = CONST(Statement));
        }
        field(91; Notice; DateFormula)
        {
        }
        field(92; "Allow Mobile Applications"; Boolean)
        {
        }
        field(93; "Allow Self Guarantee"; Boolean)
        {
        }
        field(94; "Max. Member Age"; DateFormula)
        {
        }
        field(96; "No. of Salary Times"; Integer)
        {
        }
        field(97; "Salary Period"; DateFormula)
        {
        }
        field(98; "Minimum Dep. Contribution %"; Decimal)
        {
            MaxValue = 100;
            MinValue = 1;
        }
        field(99; "Source of Funds"; Option)
        {
            OptionMembers = "Internal Fund","External Fund";
        }
        field(100; "Source Of Funds No."; Code[20])
        {
            TableRelation = Vendor."No." WHERE("Vendor Type" = CONST("Source of Funds"));
        }
        field(101; "Member Category"; Code[10])
        {
            TableRelation = "Member Classes";
        }
        field(102; "Dormancy Alert Period"; DateFormula)
        {
            Description = 'Account no transactions';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Product Factory");
            "No." := NoSeriesMgt.GetNextNo(SeriesSetup."Product Factory");
            // NoSeriesMgt.InitSeries(SeriesSetup."Product Factory", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        /*IF UserSet.GET(USERID) THEN BEGIN
        "Responsibility Center":=UserSet."Shortcut Dimension 3 Code";
        END;*/


        "Document Date" := Today;
        "Document Time" := Time;
        //"Created By":=USERID;

    end;

    var
        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        ProductFactory: Record "Product Factory";
}

