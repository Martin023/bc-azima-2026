table 52185730 "Savings Accounts"
{
    Caption = 'Savings Accounts';
    DataCaptionFields = "No.", Name;
    DrillDownPageID = "Savings Accounts";
    LookupPageID = "Savings Accounts";
    Permissions = TableData "Cust. Ledger Entry" = r;

    fields
    {
        field(1; "No."; Code[100])
        {
            Caption = 'No.';
            SQLDataType = Varchar;

            trigger OnValidate()
            begin
                //IF "Customer Type"="Customer Type"::Member THEN BEGIN
                if "No." <> xRec."No." then begin
                    //SalesSetup.GET;
                    // NoSeriesMgt.TestManual(SalesSetup."Members Nos");
                    //"No. Series" := '';
                end;
                //END;



                //Prevent Changing once entries exist
                //TestNoEntriesExist(FieldCaption("No."), "No.");
            end;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';

            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Name)) or ("Search Name" = '') then
                    "Search Name" := UpperCase(Name);
                /*
              StatusPermissions.RESET;
              StatusPermissions.SETRANGE(StatusPermissions."User ID",USERID);
              StatusPermissions.SETRANGE(StatusPermissions."Function",StatusPermissions."Function"::NameEdit);
              IF StatusPermissions.FIND('-') = FALSE THEN
              ERROR('You do not have permissions to edit the name.');
                  */

            end;
        }
        field(3; "Search Name"; Code[50])
        {
            Caption = 'Search Name';
        }
        field(4; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(5; "Current Address"; Text[50])
        {
            Caption = 'Address';
        }
        field(6; City; Text[30])
        {
            Caption = 'City';

            trigger OnLookup()
            begin
                //PostCode.LookUpCity(City,"Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidateCity(City,"Post Code");
            end;
        }
        field(7; Contact; Text[50])
        {
            Caption = 'Contact';

            trigger OnValidate()
            begin
                //IF RMSetup.GET THEN
                //  IF RMSetup."Bus. Rel. Code for Customers" <> '' THEN
                //    IF (xRec.Contact = '') AND (xRec."Primary Contact No." = '') THEN BEGIN
                //      MODIFY;
                //      UpdateContFromCust.OnModify(Rec);
                //      UpdateContFromCust.InsertNewContactPerson(Rec,FALSE);
                //      MODIFY(TRUE);
                //    END
            end;
        }
        field(8; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            CharAllowed = '0123456789';
            ExtendedDatatype = PhoneNo;
        }
        field(9; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,Blocked);
            end;
        }
        field(10; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Last Date Modified");
            end;
        }
        field(11; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group';
            TableRelation = "Customer Posting Group";

            trigger OnValidate()
            begin
                //TestNoEntriesExist(FieldCaption("No."), "No.");
            end;
        }
        field(12; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(13; "Recruited By"; Code[10])
        {

        }
        field(14; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(15; Comment; Boolean)
        {
            CalcFormula = Exist("Comment Line" WHERE("Table Name" = CONST(Customer),
                                                      "No." = FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; Blocked; Option)
        {
            Caption = 'Blocked';
            OptionCaption = ' ,Credit,Debit,All';
            OptionMembers = " ",Credit,Debit,All;
        }
        field(17; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(18; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(19; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(20; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(21; Balance; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Savings Ledger Entry".Amount WHERE("Customer No." = FIELD("No."),
                                                                            "Posting Date" = FIELD("Date Filter")));
            Caption = 'Balance';
            FieldClass = FlowField;
        }
        field(22; "Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Savings Ledger Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                            "Posting Date" = FIELD("Date Filter")));
            Caption = 'Balance (LCY)';
            FieldClass = FlowField;
        }
        field(23; "Net Change"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Savings Ledger Entry".Amount WHERE("Customer No." = FIELD("No."),
                                                                    "Posting Date" = FIELD("Date Filter")));
            Caption = 'Net Change';
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "Net Change (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Savings Ledger Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                            "Posting Date" = FIELD("Date Filter")));
            Caption = 'Net Change (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(25; "Balance Due"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No." = FIELD("No."),
                                                                         "Posting Date" = FIELD(UPPERLIMIT("Date Filter")),
                                                                         "Initial Entry Due Date" = FIELD("Date Filter"),
                                                                         "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                         "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Balance Due';
            Editable = false;
            FieldClass = FlowField;
        }
        field(26; "Balance Due (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Posting Date" = FIELD(UPPERLIMIT("Date Filter")),
                                                                                 "Initial Entry Due Date" = FIELD("Date Filter"),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Balance Due (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; Picture; Integer)
        {
            // Caption = 'Picture';
            // SubType = Bitmap;
        }
        field(28; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code"
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                //PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(29; County; Text[30])
        {
            Caption = 'County';
            TableRelation = "Segment/County/Dividend/Signat".Code WHERE(Type = CONST(County));
        }
        field(30; "Debit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Savings Ledger Entry"."Debit Amount" WHERE("Customer No." = FIELD("No."),
                                                                           "Posting Date" = FIELD("Date Filter")));
            Caption = 'Debit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; "Credit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Savings Ledger Entry"."Credit Amount" WHERE("Customer No." = FIELD("No."),
                                                                            "Posting Date" = FIELD("Date Filter")));
            Caption = 'Credit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(32; "Debit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Savings Ledger Entry"."Debit Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Currency Code." = FIELD("Currency Code"),
                                                                                 "Document No." = FIELD("Document No. Filter")));
            Caption = 'Debit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33; "Credit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Savings Ledger Entry"."Credit Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                                  "Document No." = FIELD("Document No. Filter"),
                                                                                  "Currency Code." = FIELD("Currency Code")));
            Caption = 'Credit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(34; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(35; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(36; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(37; "Currency Filter"; Code[10])
        {
            Caption = 'Currency Filter';
            FieldClass = FlowFilter;
            TableRelation = Currency;
        }
        field(38; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility CenterBR";
        }
        field(39; "Base Calendar Code"; Code[10])
        {
            Caption = 'Base Calendar Code';
            TableRelation = "Base Calendar";
        }
        field(40; Status; Enum "Savings Account Status")
        {
            // OptionCaption = ' ,New,Active,Dormant,Frozen,Withdrawal Application,Withdrawn,Deceased,Defaulter,Closed';
            // OptionMembers = " ",New,Active,Dormant,Frozen,"Withdrawal Application",Withdrawn,Deceased,Defaulter,Closed;

            trigger OnValidate()
            var
                ProdFact: Record "Product Factory";
                TransCharges: Record "Transaction Charges";
            begin
                // rec.Reset();
                // rec.SetRange("No.", xRec."No.");
                // rec.SetRange("Product Category", ProdFact."Product Category"::"FOSA Account");
                // rec.SetRange(Status, xRec.Status::Dormant);
                // rec.SetRange(Status, rec.Status::Active);
                if (xRec.Status = Status::Dormant) and (Rec.Status = Status::Active) then
                    Message('You have to charge activation fee.');

            end;
        }
        field(41; "Employer Code"; Code[50])
        {
            FieldClass = Normal;
            TableRelation = Customer WHERE("Account Type" = CONST(employer));
        }
        field(42; "Date of Birth"; Date)
        {

            trigger OnValidate()
            begin
                if "Date of Birth" > Today then
                    Error('Date of birth cannot be greater than today');


                /*Account.GET("No.");
                IF Account."Product Category"<>Account."Product Category"::"Junior Savings" THEN
                IF CALCDATE('18Y',"Date of Birth")>=TODAY THEN
                 ERROR('Birth certificate indicates this member is a minor');*/

            end;
        }
        field(43; "Wholesale/Retail"; Option)
        {
            OptionMembers = " ",Wholesale,Retail;
        }
        field(44; "Home Address"; Text[50])
        {
        }
        field(45; "Payroll/Staff No."; Code[20])
        {
        }
        field(46; "ID No."; Code[20])
        {

            trigger OnValidate()
            begin
                "ID No." := DelChr("ID No.", '=', 'A|B|C|D|E|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|.|,|!|@|#|$|%|^|&|*|(|)|[|]|{|}|/|\|"|;|:|<|>|?');
            end;
        }
        field(47; "Mobile Phone No"; Code[50])
        {
            CharAllowed = '0123456789';

            trigger OnValidate()
            begin
                //TESTFIELD("Country/Region Code");
            end;
        }
        field(48; "Marital Status"; Enum "Marital Status")
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members."Marital Status" where("No." = field("Member No.")));
        }
        field(49; Signature; integer)
        {
            Caption = 'Signature';
            // SubType = Bitmap;
        }
        field(50; "Passport No."; Code[50])
        {
        }
        field(51; Gender; enum Gender)
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Gender where("No." = FIELD("Member No.")));
        }
        field(52; "Monthly Contribution"; Decimal)
        {

            trigger OnValidate()
            begin
                // if ("Product Category" = "Product Category"::"BOSA Deposits") or ("Product Category" = "Product Category"::"Benevolent (BBF)") or
                //   ("Product Category" = "product category"::"Entrance Fee") then
                //     PeriodicAcc.EmplyerSavingAdvice(Rec, xRec."Monthly Contribution", "Monthly Contribution");
                // if xrec."Monthly Contribution" <> Rec."Monthly Contribution" then begin
                //     if not LogMonthlyContributionChange(rec, rec."Monthly Contribution", xRec."Monthly Contribution") then
                //         Error('Monthly Contribution Change Log could not be created');
                // end;
            end;
        }
        field(53; "Outstanding Interest"; Decimal)
        {
            Description = 'Check Flow field';
            FieldClass = Normal;
        }
        field(54; "Account Category"; Option)
        {
            OptionCaption = 'Member, Staff Account,Board Members,Delegates';
            OptionMembers = Member," Staff Account","Board Members",Delegates;
        }
        field(55; "Type Of Organisation"; Option)
        {
            OptionCaption = ' ,Club,Association,Partnership,Investment,Merry go round,Other,Group';
            OptionMembers = " ",Club,Association,Partnership,Investment,"Merry go round",Other,Group;
        }
        field(56; "Mobile No."; Code[20])
        {
        }
        field(57; "Group Account No"; Code[20])
        {
            Description = 'Check Relation';
            FieldClass = FlowField;
            CalcFormula = lookup(Members."Group Account No." where("No." = field("Member No.")));

        }
        field(58; Membership; Option)
        {
            OptionCaption = ' ,Ordinary,Preferential';
            OptionMembers = " ",Ordinary,Preferential;
        }
        field(59; "Group Account"; Boolean)
        {
        }
        field(60; "Product Type"; Code[20])
        {
            TableRelation = "Product Factory"."Product ID";
        }
        field(61; "Member No."; Code[20])
        {
            TableRelation = Members;
        }
        field(62; "Product Name"; Text[50])
        {
        }
        field(63; "Can Guarantee Loan"; Boolean)
        {
        }
        field(64; "Loan Disbursement Account"; Boolean)
        {
        }
        field(65; "Loan Security Inclination"; Option)
        {
            OptionCaption = ' ,Short Loan Security,Long Term Loan Security,Share Capital';
            OptionMembers = " ","Short Term Loan Security","Long Term Loan Security","Share Capital";
        }
        field(66; "ATM Transactions"; Decimal)
        {
            // CalcFormula = Sum("ATM Transactions".Amount WHERE("Account No" = FIELD("No."),
            //                                                    Posted = FILTER(false)));
            CalcFormula = Sum(
                "Sky M-Banking Trans. Buffer"."Signed Amount" WHERE(
                    Posted = FILTER(false),
                    "Savings Account" = FIELD("No.")
                )
            );
            FieldClass = FlowField;
            Caption = 'M-Banking Transactions';
        }
        field(67; "Fixed Deposit Status"; Option)
        {
            OptionCaption = ' ,Active,Matured,Closed,Not Matured';
            OptionMembers = " ",Active,Matured,Closed,"Not Matured";
        }
        field(68; "Relates to Business/Group"; Boolean)
        {
        }
        field(69; "Company Registration No."; Code[20])
        {
        }
        field(70; "Birth Certificate No."; Code[20])
        {
        }
        field(71; "ATM No."; Code[20])
        {
        }
        field(72; "Created By"; Code[50])
        {
        }
        field(73; "Registration Date"; Date)
        {
        }

        field(75; "Authorised Over Draft"; Decimal)
        {
            CalcFormula = Sum("Over Draft Authorisation"."Approved Amount" WHERE("Account No." = FIELD("No."),
                                                                                  Posted = CONST(true),
                                                                                  Expired = CONST(false)));
            FieldClass = FlowField;
        }
        field(76; "Uncleared Cheques"; Decimal)
        {
            CalcFormula = Sum("Cashier Transactions".Amount WHERE("Account No" = FIELD("No."),
                                                                   Posted = CONST(true),
                                                                   Type = FILTER("Cheque Deposit" | "Credit Cheque"),
                                                                   "Cheque Status" = CONST(Pending)));
            FieldClass = FlowField;
        }
        field(77; "Fixed Deposit Type"; Code[20])
        {
            Description = 'LookUp to Fixed Deposit Type Table';
            TableRelation = "Fixed Deposit Type";

            trigger OnValidate()
            begin
                TestField("Registration Date");
                if FixedDepositType.Get("Fixed Deposit Type") then
                    "FD Maturity Date" := CalcDate(FixedDepositType.Duration, "Registration Date");
                "FD Duration" := FixedDepositType.Duration;
            end;
        }
        field(78; "FD Maturity Date"; Date)
        {
        }
        field(79; "Product Category"; enum "Product Categories")
        {
        }
        field(80; "Neg. Interest Rate"; Decimal)
        {

            trigger OnValidate()
            begin
                CalcFields("Balance (LCY)", Balance);
                FDCalcRules.Reset;
                FDCalcRules.SetRange(Code, "Fixed Deposit Type");
                if FDCalcRules.Find('-') then begin
                    repeat
                        if FDCalcRules."Allowed Margin" <> 0 then begin
                            if (Balance >= FDCalcRules."Minimum Amount") and (Balance <= FDCalcRules."Maximum Amount") then
                                if ("Neg. Interest Rate" > (FDCalcRules."Interest Rate" + FDCalcRules."Allowed Margin")) or
                                   ("Neg. Interest Rate" < (FDCalcRules."Interest Rate" - FDCalcRules."Allowed Margin")) then
                                    Error('The negotiated rate must be within the allowed margin of %1', FDCalcRules."Allowed Margin");
                        end;
                    until
                    FDCalcRules.Next = 0;
                end;
            end;
        }
        field(81; "FD Duration"; DateFormula)
        {

            trigger OnValidate()
            begin

                "FD Maturity Date" := CalcDate("FD Duration", "Registration Date");
            end;
        }
        field(82; "FD Maturity Instructions"; Option)
        {
            OptionCaption = ' ,Transfer all to Savings,Renew Principal,Renew Principal & Interest';
            OptionMembers = " ","Transfer all to Savings","Renew Principal","Renew Principal & Interest";
        }
        field(83; "Fixed Deposit cert. no"; Code[30])
        {
            Description = 'Capture FxD certificate Number';
        }
        field(84; "Fixed Deposit Amount"; Decimal)
        {
        }
        field(85; "Savings Account No."; Code[20])
        {
            Description = 'LookUp to Savings Account Table';
            TableRelation = "Savings Accounts" WHERE("Member No." = FIELD("Member No."));
        }
        field(86; "Transactional Mobile No"; Text[30])
        {
        }
        field(87; "Virtual Member"; Boolean)
        {
        }
        field(89; "Single Party/Multiple/Business"; Option)
        {
            OptionCaption = 'Single,Multiple,Business';
            OptionMembers = Single,Multiple,Business;
        }
        field(90; "Parent Account No."; Code[20])
        {
            Description = 'LookUp to Member Table';
            TableRelation = Members;
        }
        field(91; "Last Withdrawal Date"; Date)
        {
        }
        field(92; "Member Category"; Code[10])
        {
            TableRelation = "Member Classes";
        }
        field(93; "Recruited by Type"; Enum "Recruited By")
        {

        }
        field(94; "Recovery Priority"; Integer)
        {
        }
        field(95; "Current Capital"; Decimal)
        {

        }
        field(96; "No. of Employees"; Integer)
        {

        }
        field(97; "Annual Turnover"; Decimal)
        {

        }
        field(98; "Business Location"; Code[50])
        {

        }
        field(99; "Type of Business"; Enum "Business Type")
        {

        }
        field(100; "One Month Installment"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("One Month Installment".Total where("Member No." = field("Member No."), "Account No." = field("No."), "Funds Status" = const(WithHeld)));
        }
        // field(50003; "Status Change Statistics"; Integer)
        // {
        //     CalcFormula = Count("Reactivate/Deactivate Header" WHERE("Account Type" = CONST(Savings),
        //                                                               "Account No." = FIELD("No."),
        //                                                               Status = CONST(Processed)));
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        field(50004; "Relationship Manager"; Code[10])
        {
            TableRelation = "HR Employees" WHERE(Status = FILTER(Active));
        }
        field(50006; "Signing Instructions"; Text[30])
        {
        }
        field(50007; "Send Statement Freq."; DateFormula)
        {

            trigger OnValidate()
            begin
                "Last Statement Date" := CalcDate("Send Statement Freq.", Today);
            end;
        }
        field(50008; "Last Statement Date"; Date)
        {
        }
        field(50009; "Interest Earned"; Decimal)
        {
            CalcFormula = Sum("Savings Interest Buffer"."Interest Amount" WHERE("Account No" = FIELD("No."), posted = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; "Untranfered Interest"; Decimal)
        {
            CalcFormula = Sum("Interest Buffer"."Interest Amount" WHERE("Account No" = FIELD("No."),
                                                                         Transferred = CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011; "Lien Placed"; Decimal)
        {
            CalcFormula = Sum("Cashier Transactions".Amount WHERE("Account No" = FIELD("No."),
                                                                   Posted = CONST(true),
                                                                   Type = FILTER(Lien),
                                                                   "Cheque Status" = CONST(Pending)));
            FieldClass = FlowField;
        }
        field(50012; "Mobile Loan Blocked"; Boolean)
        {
            Editable = true;
        }
        field(50013; "Mobile Loan Date  Blocked"; Date)
        {
            Editable = false;
        }
        field(50014; "Mobile Loan Un Blocked By"; Text[50])
        {
            Editable = false;
        }
        field(50015; "Date Billed"; Date)
        {
            CalcFormula = Min("Savings Ledger Entry"."Posting Date" WHERE("Customer No." = FIELD("No."),
                                                                           Amount = FILTER(< 0)));
            FieldClass = FlowField;
        }
        field(50016; "Mobile Loan Blocked By"; Text[30])
        {
            Editable = false;
        }
        field(50017; "Rejoin Bil Date"; Date)
        {
            CalcFormula = Min("Savings Ledger Entry"."Posting Date" WHERE("Customer No." = FIELD("No."),
                                                                           Amount = FILTER(< 1000)));
            FieldClass = FlowField;
        }


        field(50018; "Salary Received"; Decimal)
        {
            CalcFormula = Sum("Salary Lines".Amount WHERE("Account No." = FIELD("No."),
                                                                            "Posting Date" = FIELD("Date Filter"), Posted = filter(true), "Income Type" = filter(Salary | Pension)));
            Caption = 'Salary Received';
            Editable = false;
            FieldClass = FlowField;
        }
        field(39004241; "Last Transaction Date"; Date)
        {
            CalcFormula = Max("Savings Ledger Entry"."Posting Date" WHERE("Customer No." = FIELD("No."),
            Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(240; "Last Entry"; Integer)
        {
            CalcFormula = Max("Savings Ledger Entry"."Entry No." WHERE("Customer No." = FIELD("No."),
            Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(241; "Last Transacted Amount"; Decimal)
        {
            CalcFormula = Max("Savings Ledger Entry".Amount WHERE("Customer No." = FIELD("No."),
            Reversed = const(false), "Entry No." = field("Last Entry")));
            FieldClass = FlowField;
        }
        field(39004242; Classification; Option)
        {
            OptionCaption = ' ,Good Standing,Bad Standing';
            OptionMembers = " ","Good Standing","Bad Standing";
        }
        field(39004243; Hide; Boolean)
        {
        }
        field(39004244; "Document No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(39004245; "FD Date Renewed"; Date)
        {
        }
        field(39004247; "Old Member No."; Code[20])
        {
        }
        field(39004248; "Associated Member No."; Code[20])
        {
        }
        field(39004249; "Enable Sweeping"; Boolean)
        {
        }
        field(39004250; "External Account No"; Code[50])
        {

            trigger OnValidate()
            begin
                if StrLen("External Account No") > 14 then
                    Error('Invalid Bank Account No. Please enter a bank account with less than 15 digits.');
            end;
        }
        field(39004251; "Bank Code"; Code[20])
        {
            TableRelation = "Bank Code Structure".Code;
        }
        field(39004252; "Amount to Transfer"; Decimal)
        {
        }
        field(39004253; "Savings Interest Earned"; Decimal)
        {
            CalcFormula = Sum("Savings Interest Buffer"."Interest Amount" WHERE("Account No" = FIELD("No."),
                                                                                 Posted = FILTER(false),
                                                                                 "Interest Date" = FIELD("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(39004254; "Employer Account No"; Code[20])
        {
        }
        field(39004255; "Old Account No"; Code[20])
        {
        }
        field(39004256; "Status Change Reason"; Text[80])
        {
        }
        field(39004257; DummyBlocked; Boolean)
        {
        }
        field(39004258; "Salary Through FOSA"; Boolean)
        {
        }
        field(39004259; "Employer Balance"; Decimal)
        {
        }
        field(39004260; "Agency Withdrawals"; Decimal)
        {
        }
        field(39004261; yed; Decimal)
        {
        }
        field(39004262; "Business Account Code"; Text[50])
        {
        }
        field(39004263; "Coop Transactions"; Decimal)
        {
            // CalcFormula = Sum("Coop ATM Transaction"."Total Account Debit" WHERE("Member Account" = FIELD("No."),
            //                                                                       Posted = CONST(false)));
            CalcFormula = Sum(
                "Sky ATM Transactions Buffer"."Signed Amount"
                WHERE(
                    Posted = const(false),
                    "Member Savings Account" = Field("No.")));
            FieldClass = FlowField;
            Caption = 'ATM Transactions';
        }
        field(101; "Deposit Type"; Option)
        {
            OptionMembers = ,,Self,Transferred;
            OptionCaption = ',,Self,Transferred';
            trigger OnValidate()
            begin
                if rec."Product Category" = Rec."Product Category"::"Share Capital" then begin
                    "Deposit Type" := rec."Deposit Type";
                end;
            end;
        }
        field(102; "ATM Cards"; Integer)
        {
            CalcFormula = Count("ATM Card Storage" where("Account No." = field("No.")));
            FieldClass = FlowField;
        }
        field(103; "Category"; Enum "Accounts Category")
        {
            CalcFormula = Lookup("Product Factory".Category WHERE("Product ID" = FIELD("Product Type")));
            FieldClass = FlowField;
        }

        field(104; "Blocked Buffer"; Option)
        {
            Caption = 'Blocked Buffer';
            OptionCaption = ' ,Credit,Debit,All';
            OptionMembers = " ",Credit,Debit,All;
            Editable = false;
        }
        field(105; "Source Unit"; Enum "Source Unit")
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Product Factory"."Source Unit" where("Product ID" = field("Product Type")));
            // OptionMembers = "",FOSA,BOSA,"BUSINESS LOANS","HR LOANS";
        }
        field(106; "Last ov int Charged Date"; Date)
        {
            Caption = 'Last OV Interest Charged Date';
            Description = 'Last Overdrawn Interest Charged Date';
        }
        field(107; "Prorata"; Decimal)
        {
            //AutoFormatExpression = '1,KSh ';
            AutoFormatType = 10;
            Caption = 'Prorata';
            FieldClass = Normal;
        }
        field(108; "SASRA Savings Category"; Option)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Product Factory"."SASRA Savings Category" where("Product ID" = field("Product Type")));
            OptionMembers = " ","Savings","Non Withdrawable","Term";
            Caption = 'Channels Internal Transfer Options';
        }
        field(109; "Account Profile"; Option)
        {
            OptionMembers = "Normal Member","High Profile","Politically Exposed";
            Fieldclass = flowfield;
            CalcFormula = lookup(Members."Account Profile" where("No." = field("Member No.")));
        }
        field(110; "Can Be Closed"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Product Factory"."Can Be Closed" where("Product ID" = field("Product Type")));
            // CalcFormula = last
        }
        field(111; "Member Status"; enum "Member Status")
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Status where("No." = field("Member No.")));

        }
        field(112; "Member Sub Status"; enum "Member Status Sub Flags")
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Subflag where("No." = field("Member No.")));

        }
        field(113; "Sort Order"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Product Factory"."Sort Order" where("Product ID" = field("Product Type")));
        }

        field(114; "ATM Withdrawal Limit"; Decimal)
        {
            Caption = 'ATM Withdrawal Limit Value (Per Transaction)';
            trigger OnValidate()
            begin
                if "ATM Withdrawal Limit" <= 0 then begin
                    Error('Value must be greater than 0');
                end;
                if "ATM Daily Withdrawals Limit" <> 0 then begin
                    if "ATM Withdrawal Limit" > "ATM Daily Withdrawals Limit" then begin
                        Error('Withdrawal limit value may NOT be greater than the daily withdrawals limit value');
                    end;
                end;
            end;
        }
        field(115; "ATM Daily Withdrawals Limit"; Decimal)
        {
            Caption = 'ATM Daily Withdrawals Limit Value';
            trigger OnValidate()
            begin
                if "ATM Daily Withdrawals Limit" <= 0 then begin
                    Error('Value must be greater than 0');
                end;
                if "ATM Withdrawal Limit" <> 0 then begin
                    if "ATM Daily Withdrawals Limit" < "ATM Withdrawal Limit" then begin
                        Error('Daily withdrawal limit value may NOT be lesser than the transaction withdrawal limit value');
                    end;
                end;
            end;
        }
        field(116; "Mobile Withdrawal Limit"; Decimal)
        {
            Caption = 'Mobile Banking Withdrawal Limit Value (Per Transaction)';
            trigger OnValidate()
            begin
                if "Mobile Withdrawal Limit" <= 0 then begin
                    Error('Value must be greater than 0');
                end;
                if "Mobile Daily Withdrawal Limit" <> 0 then begin
                    if "Mobile Withdrawal Limit" > "Mobile Daily Withdrawal Limit" then begin
                        Error('Withdrawal limit value may NOT be greater than the daily withdrawals limit value');
                    end;
                end;
            end;
        }
        field(117; "Mobile Daily Withdrawal Limit"; Decimal)
        {
            Caption = 'Mobile Banking Daily Withdrawal Limit';
            trigger OnValidate()
            begin
                if "Mobile Daily Withdrawal Limit" <= 0 then begin
                    Error('Value must be greater than 0');
                end;
                if "Mobile Withdrawal Limit" <> 0 then begin
                    if "Mobile Daily Withdrawal Limit" < "Mobile Withdrawal Limit" then begin
                        Error('Daily Withdrawal limit value may NOT be lesser than the Withdrawals limit value');
                    end;
                end;
            end;
        }
        field(118; "Last Dormancy SMS Date"; Date)
        {
            Caption = 'Last Dormancy SMS Date';
        }
        field(119; "Change Log Entries"; Integer)
        {
            Caption = 'Change Log Entries';
            FieldClass = FlowField;
            CalcFormula = count("Change Log Entry" where("Primary Key Field 1 Value" = field("No.")));
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Search Name")
        {
        }
        key(Key3; Name)
        {
        }
        key(Key4; Contact)
        {
        }
        key(Key5; "Global Dimension 1 Code")
        {
        }
        key(Key6; "Phone No.")
        {
        }
        key(Key7; "Member No.")
        {
        }
        key(Key8; "Payroll/Staff No.")
        {
        }
        key(Key9; "ID No.")
        {
        }
        key(key10; "Product Type", "No.")
        { }
        key(key11; "Member No.", "Product Type")
        {
            SumIndexFields = "Monthly Contribution";
        }
        // Secondary keys for non-primary fields
        key(IdxOldAccountNo; "Old Account No")
        {
            Clustered = false;
        }

        key(IdxStatus; "Status")
        {
            Clustered = false;
        }

        key(IdxBlocked; "Blocked")
        {
            Clustered = false;
        }

        key(IdxProductType; "Product Type")
        {
            Clustered = false;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Name, "Product Name", Balance, "ID No.", "Member No.", "Payroll/Staff No.")
        {
        }
    }

    trigger OnDelete()
    var
        CampaignTargetGr: Record "Campaign Target Group";
        ContactBusRel: Record "Contact Business Relation";
        Job: Record Job;
        // CreditCards: Record "DO Payment Credit Card";
        CampaignTargetGrMgmt: Codeunit "Campaign Target Group Mgt";
        StdCustSalesCode: Record "Standard Customer Sales Code";
    begin

        DimMgt.DeleteDefaultDim(DATABASE::Customer, "No.");


        // if Status = Status::Active then
        //     Error('Dear' + UserId + 'You are not Allowed to Delete this Account');

        // if Status = Status::Closed then
        //     Error('Dear' + UserId + 'You are not Allowed to Delete this Account');

        // if Status = Status::Defaulter then
        //     Error('Dear' + UserId + 'You are not Allowed to Delete this Account');

        // if Status = Status::Deceased then
        //     Error('Dear' + UserId + 'You are not Allowed to Delete this Account');

        // if Status = Status::Dormant then
        //     Error('Dear' + UserId + 'You are not Allowed to Delete this Account');

        // if Status = Status::Frozen then
        //     Error('Dear' + UserId + 'You are not Allowed to Delete this Account');

        // if Status = Status::New then
        //     Error('Dear' + UserId + 'You are not Allowed to Delete this Account');

        // if Status = Status::"Withdrawal Application" then
        //     Error('Dear' + UserId + 'You are not Allowed to Delete this Account');
        // if Status = Status::" " then
        //     Error('Dear' + UserId + 'You are not Allowed to Delete this Account');


        //MobSalesmgt.CustOnDelete(Rec);

        //CALCFIELDS("Group Account");
        //IF "Group Account">0 THEN
        //ERROR(Text001);
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            // SalesSetup.GET;
            // SalesSetup.TESTFIELD(SalesSetup."Members Nos");
            // NoSeriesMgt.InitSeries(SalesSetup."Members Nos",xRec."No. Series",0D,"No.","No. Series");
        end;
        //   "Last Date Modified" := Today;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;

        if (Name <> xRec.Name) or
           ("Search Name" <> xRec."Search Name") or
           ("Name 2" <> xRec."Name 2") or
           ("Current Address" <> xRec."Current Address") or
           (City <> xRec.City) or
           (Contact <> xRec.Contact) or
           ("Global Dimension 1 Code" <> xRec."Global Dimension 1 Code") or
           ("Global Dimension 2 Code" <> xRec."Global Dimension 2 Code") or
           (Comment <> xRec.Comment) or
           ("Balance (LCY)" <> xRec."Balance (LCY)") or
           ("Net Change (LCY)" <> xRec."Net Change (LCY)") or
           (County <> xRec.County) or
           ("No. Series" <> xRec."No. Series") or
           //("Fax No." <> xRec."Fax No.") OR
           //("Telex Answer Back" <> xRec."Telex Answer Back") OR
           //("VAT Registration No." <> xRec."VAT Registration No.") OR
           ("Post Code" <> xRec."Post Code") or
           (County <> xRec.County) or
           ("E-Mail" <> xRec."E-Mail") or
           //("Home Page" <> xRec."Home Page") OR
           ("Phone No." <> xRec."Phone No.")
        then begin
            Modify;
            //UpdateContFromCust.OnModify(Rec);
        end;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := TODAY;
    end;


    var
        Text000: Label 'You cannot delete %1 %2 because there is at least one outstanding Sales %3 for this customer.';
        Text002: Label 'Do you wish to create a contact for %1 %2?';
        CommentLine: Record "Comment Line";
        SalesOrderLine: Record "Sales Line";
        CustBankAcc: Record "Customer Bank Account";
        ShipToAddr: Record "Ship-to Address";
        PostCode: Record "Post Code";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        ShippingAgentService: Record "Shipping Agent Services";
        //ItemCrossReference: Record "Item Cross Reference";
        RMSetup: Record "Marketing Setup";
        //SalesPrice: Record "Sales Price";
        //SalesLineDisc: Record "Sales Line Discount";
        SalesPrepmtPct: Record "Sales Prepayment %";
        ServContract: Record "Service Contract Header";
        ServHeader: Record "Service Header";
        ServiceItem: Record "Service Item";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        MoveEntries: Codeunit MoveEntries;
        UpdateContFromCust: Codeunit "CustCont-Update";
        DimMgt: Codeunit DimensionManagement;
        InsertFromContact: Boolean;
        Text003: Label 'Contact %1 %2 is not related to customer %3 %4.';
        Text004: Label 'post';
        Text005: Label 'create';
        Text006: Label 'You cannot %1 this type of document when Customer %2 is blocked with type %3';
        Text007: Label 'You cannot delete %1 %2 because there is at least one not cancelled Service Contract for this customer.';
        Text008: Label 'Deleting the %1 %2 will cause the %3 to be deleted for the associated Service Items. Do you want to continue?';
        Text009: Label 'Cannot delete customer.';
        Text010: Label 'The %1 %2 has been assigned to %3 %4.\The same %1 cannot be entered on more than one %3. Enter another code.';
        Text011: Label 'Reconciling IC transactions may be difficult if you change IC Partner Code because this %1 has ledger entries in a fiscal year that has not yet been closed.\ Do you still want to change the IC Partner Code?';
        Text012: Label 'You cannot change the contents of the %1 field because this %2 has one or more open ledger entries.';
        Text013: Label 'You cannot delete %1 %2 because there is at least one outstanding Service %3 for this customer.';
        Text014: Label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        Text015: Label 'You cannot delete %1 %2 because there is at least one %3 associated to this customer.';
        Loans: Record Loans;
        MinShares: Decimal;
        Cust: Record "Savings Accounts";
        Vend: Record Vendor;
        CustFosa: Code[20];
        Vend2: Record Vendor;
        FOSAAccount: Record Vendor;
        Text001: Label 'You cannot delete %1 %2 because there is at least one transaction %3 for this customer.';
        IntRate: Decimal;
        DocNo: Code[10];
        PDate: Date;
        IntBufferNo: Integer;
        MidMonthFactor: Decimal;
        DaysInMonth: Integer;
        StartDate: Date;
        IntDays: Integer;
        AsAt: Date;
        MinBal: Boolean;
        AccruedInt: Decimal;
        RIntDays: Integer;
        Bal: Decimal;
        Rate: Decimal;
        "Sacco Account": Record "Savings Accounts";
        ProductFactory: Record "Product Factory";
        Account: Record "Savings Accounts";
        Text016: Label 'You cannot Modify %1 %2 because there is at least one transaction %3 for this Member.';
        FixedDepositType: Record "Fixed Deposit Type";
        PeriodicAcc: Codeunit "Periodic Activities";
        FDCalcRules: Record "FD Interest Calculation Rules";

    // [Scope('OnPrem')]
    procedure TestNoEntriesExist(CurrentFieldName: Text[100]; GLNO: Code[20])
    var
        MemberLedgEntry: Record "Savings Ledger Entry";
    begin
        //To prevent change of field
        /*MemberLedgEntry.SETCURRENTKEY(MemberLedgEntry."Customer No.");
        MemberLedgEntry.SETRANGE(MemberLedgEntry."Customer No.","No.");
        IF MemberLedgEntry.FIND('-') THEN
          ERROR(
          Text016,
           CurrentFieldName,"No.",Name);
           */

    end;

    // [Scope('OnPrem')]
    procedure AssistEdit(OldCust: Record "Savings Accounts"): Boolean
    var
        Cust: Record "Savings Accounts";
    begin
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::Customer, "No.", FieldNumber, ShortcutDimCode);
        Modify;
    end;

    // [Scope('OnPrem')]
    procedure ShowContact()
    var
        ContBusRel: Record "Contact Business Relation";
        Cont: Record Contact;
    begin
        if "No." = '' then
            exit;

        ContBusRel.SetCurrentKey("Link to Table", "No.");
        ContBusRel.SetRange("Link to Table", ContBusRel."Link to Table"::Customer);
        ContBusRel.SetRange("No.", "No.");
        if not ContBusRel.FindFirst then begin
            if not Confirm(Text002, false, TableCaption, "No.") then
                exit;
            //UpdateContFromCust.InsertNewContact(Rec,FALSE);
            ContBusRel.FindFirst;
        end;
        Commit;

        Cont.SetCurrentKey("Company Name", "Company No.", Type, Name);
        Cont.SetRange("Company No.", ContBusRel."Contact No.");
        PAGE.Run(PAGE::"Contact List", Cont);
    end;

    // [Scope('OnPrem')]
    procedure SetInsertFromContact(FromContact: Boolean)
    begin
        InsertFromContact := FromContact;
    end;

    // [Scope('OnPrem')]
    procedure CheckBlockedCustOnDocs(Cust2: Record "Savings Accounts"; DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; Shipment: Boolean; Transaction: Boolean)
    begin
        /*WITH Cust2 DO BEGIN
         IF ((Blocked = Blocked::All) OR
            ((Blocked = Blocked::Invoice) AND (DocType IN [DocType::Quote,DocType::Order,DocType::Invoice,DocType::"Blanket Order"])) OR
            ((Blocked = Blocked::Ship) AND (DocType IN [DocType::Quote,DocType::Order,DocType::"Blanket Order"]) AND
             NOT Transaction)) OR
              ((Blocked = Blocked::Ship) AND (DocType IN [DocType::Quote,DocType::Order,DocType::Invoice,DocType::"Blanket Order"]) AND
              Shipment AND Transaction)) THEN
            CustBlockedErrorMessage(Cust2,Transaction);
        END;*/

    end;

    // [Scope('OnPrem')]
    procedure CheckBlockedCustOnJnls(Cust2: Record "Savings Accounts"; DocType: Enum "Gen. Journal Document Type"; Transaction: Boolean)
    begin
        with Cust2 do begin
            if (Blocked = Blocked::All) or
               ((Blocked = Blocked::Debit) and (DocType in [DocType::Invoice, DocType::" "]))
            then
                CustBlockedErrorMessage(Cust2, Transaction)
        end;
    end;

    // [Scope('OnPrem')]
    procedure CustBlockedErrorMessage(Cust2: Record "Savings Accounts"; Transaction: Boolean)
    var
        "Action": Text[30];
    begin
        if Transaction then
            Action := Text004
        else
            Action := Text005;
        Error(Text006, Action, Cust2."No.", Cust2.Blocked);
    end;

    // [Scope('OnPrem')]
    procedure DisplayMap()
    var
        MapPoint: Record "Online Map Setup";
        MapMgt: Codeunit "Online Map Management";
    begin
        if MapPoint.FindFirst then
            MapMgt.MakeSelection(DATABASE::Customer, GetPosition)
        else
            Message(Text014);
    end;

    // [Scope('OnPrem')]
    procedure GetTotalAmountLCY(): Decimal
    begin
        ///CALCFIELDS("Balance (LCY)","Outstanding Orders (LCY)","Shipped Not Invoiced (LCY)","Outstanding Invoices (LCY)",
        // "Outstanding Serv. Orders (LCY)","Serv Shipped Not Invoiced(LCY)","Outstanding Serv.Invoices(LCY)");

        //EXIT(GetTotalAmountLCYCommon);
    end;

    // [Scope('OnPrem')]
    procedure GetTotalAmountLCYUI(): Decimal
    begin
        //SETAUTOCALCFIELDS("Balance (LCY)","Outstanding Orders (LCY)","Shipped Not Invoiced (LCY)","Outstanding Invoices (LCY)",
        //"Outstanding Serv. Orders (LCY)","Serv Shipped Not Invoiced(LCY)","Outstanding Serv.Invoices(LCY)");

        //EXIT(GetTotalAmountLCYCommon);
    end;

    local procedure GetTotalAmountLCYCommon(): Decimal
    var
        SalesLine: Record "Sales Line";
        ServiceLine: Record "Service Line";
        SalesOutstandingAmountFromShipment: Decimal;
        ServOutstandingAmountFromShipment: Decimal;
        InvoicedPrepmtAmountLCY: Decimal;
    begin
        //SalesOutstandingAmountFromShipment := SalesLine.OutstandingInvoiceAmountFromShipment("No.");
        //ServOutstandingAmountFromShipment := ServiceLine.OutstandingInvoiceAmountFromShipment("No.");
        //InvoicedPrepmtAmountLCY := GetInvoicedPrepmtAmountLCY;

        //EXIT("Balance (LCY)" + "Outstanding Orders (LCY)" + "Shipped Not Invoiced (LCY)" + "Outstanding Invoices (LCY)" +
        //"Outstanding Serv. Orders (LCY)" + "Serv Shipped Not Invoiced(LCY)" + "Outstanding Serv.Invoices(LCY)" -
        // SalesOutstandingAmountFromShipment - ServOutstandingAmountFromShipment - InvoicedPrepmtAmountLCY);
    end;

    // [Scope('OnPrem')]
    procedure GetSalesLCY(): Decimal
    var
        CustomerSalesYTD: Record Customer;
        AccountingPeriod: Record "Accounting Period";
        StartDate: Date;
        EndDate: Date;
    begin
        //StartDate := AccountingPeriod.GetFiscalYearStartDate(WORKDATE);
        //EndDate := AccountingPeriod.GetFiscalYearEndDate(WORKDATE);
        //CustomerSalesYTD := Rec;
        //CustomerSalesYTD."SECURITYFILTERING"("SECURITYFILTERING");
        //CustomerSalesYTD.SETRANGE("Date Filter",StartDate,EndDate);
        //CustomerSalesYTD.CALCFIELDS("Sales (LCY)");
        //EXIT(CustomerSalesYTD."Sales (LCY)");
    end;

    // [Scope('OnPrem')]
    procedure CalcAvailableCredit(): Decimal
    begin
        exit(CalcAvailableCreditCommon(false));
    end;

    // [Scope('OnPrem')]
    procedure CalcAvailableCreditUI(): Decimal
    begin
        exit(CalcAvailableCreditCommon(true));
    end;

    local procedure CalcAvailableCreditCommon(CalledFromUI: Boolean): Decimal
    begin
        //IF "Credit Limit (LCY)" = 0 THEN
        // EXIT(0);
        //IF CalledFromUI THEN
        // EXIT("Credit Limit (LCY)" - GetTotalAmountLCYUI);
        //EXIT("Credit Limit (LCY)" - GetTotalAmountLCY);
    end;

    // [Scope('OnPrem')]
    procedure CalcOverdueBalance() OverDueBalance: Decimal
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        CustLedgEntryRemainAmtQuery: Query "Cust. Ledg. Entry Remain. Amt.";
    begin
        CustLedgEntryRemainAmtQuery.SetRange(Customer_No, "No.");
        CustLedgEntryRemainAmtQuery.SetRange(IsOpen, true);
        CustLedgEntryRemainAmtQuery.SetFilter(Due_Date, '<%1', WorkDate);
        CustLedgEntryRemainAmtQuery.Open;

        if CustLedgEntryRemainAmtQuery.Read then
            OverDueBalance := CustLedgEntryRemainAmtQuery.Sum_Remaining_Amt_LCY;
    end;

    // [Scope('OnPrem')]
    procedure GetLegalEntityType(): Text
    begin
        //EXIT(FORMAT("Partner Type"));
    end;

    // [Scope('OnPrem')]
    procedure GetLegalEntityTypeLbl(): Text
    begin
        //EXIT(FIELDCAPTION("Partner Type"));
    end;

    // [Scope('OnPrem')]
    procedure SetStyle(): Text
    begin
        // if CalcAvailableCredit < 0 then
        //     exit('Unfavorable');
        // exit('');
    end;

    // [Scope('OnPrem')]
    procedure HasValidDDMandate(Date: Date): Boolean
    var
        SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
    begin
        exit(SEPADirectDebitMandate.GetDefaultMandate("No.", Date) <> '');
    end;

    // [Scope('OnPrem')]
    procedure GetInvoicedPrepmtAmountLCY(): Decimal
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetCurrentKey("Document Type", "Bill-to Customer No.");
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange("Bill-to Customer No.", "No.");
        SalesLine.CalcSums("Prepmt. Amount Inv. (LCY)", "Prepmt. VAT Amount Inv. (LCY)");
        exit(SalesLine."Prepmt. Amount Inv. (LCY)" + SalesLine."Prepmt. VAT Amount Inv. (LCY)");
    end;

    // [Scope('OnPrem')]
    procedure CalcCreditLimitLCYExpendedPct(): Decimal
    begin
        //IF "Credit Limit (LCY)" = 0 THEN
        // EXIT(0);

        //IF "Balance (LCY)" / "Credit Limit (LCY)" < 0 THEN
        // EXIT(0);

        //IF "Balance (LCY)" / "Credit Limit (LCY)" > 1 THEN
        // EXIT(10000);

        //EXIT(ROUND("Balance (LCY)" / "Credit Limit (LCY)" * 10000,1));
    end;

    // [Scope('OnPrem')]
    procedure CreateAndShowNewInvoice()
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
        SalesHeader.SetRange("Sell-to Customer No.", "No.");
        SalesHeader.Insert(true);
        Commit;
        // PAGE.RunModal(PAGE::Page1304, SalesHeader)
    end;

    // [Scope('OnPrem')]
    procedure CreateAndShowNewCreditMemo()
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader."Document Type" := SalesHeader."Document Type"::"Credit Memo";
        SalesHeader.SetRange("Sell-to Customer No.", "No.");
        SalesHeader.Insert(true);
        Commit;
        // PAGE.RunModal(PAGE::Page1319, SalesHeader)
    end;

    // [Scope('OnPrem')]
    procedure CreateAndShowNewQuote()
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader."Document Type" := SalesHeader."Document Type"::Quote;
        SalesHeader.SetRange("Sell-to Customer No.", "No.");
        SalesHeader.Insert(true);
        Commit;
        // PAGE.RunModal(PAGE::Page1324, SalesHeader)
    end;

    local procedure UpdatePaymentTolerance(UseDialog: Boolean)
    begin
        //IF "Block Payment Tolerance" THEN BEGIN
        //IF UseDialog THEN
        // IF NOT CONFIRM(RemovePaymentRoleranceQst,FALSE) THEN
        //  EXIT;
        //PaymentToleranceMgt.DelTolCustLedgEntry(Rec);
        //END ELSE BEGIN
        // IF UseDialog THEN
        //  IF NOT CONFIRM(AllowPaymentToleranceQst,FALSE) THEN
        //   EXIT;
        //PaymentToleranceMgt.CalcTolCustLedgEntry(Rec);
        //END;
    end;

    // [Scope('OnPrem')]
    procedure GetBillToCustomerNo(): Code[20]
    begin
        //IF "Bill-to Customer No." <> '' THEN
        // EXIT("Bill-to Customer No.");
        //EXIT("No.");
    end;

    // [Scope('OnPrem')]
    procedure GetSMSFieldName(SavingsAccounts: Record "Savings Accounts") RetunField: Text[20]
    var
        SMSCodes: Record "SMS Codes";
        TableName: Text;
        i: Integer;
        FieldName: array[5] of Text;
    begin
        TableName := SavingsAccounts.TableName;

        i := 1;
        SMSCodes.Reset;
        SMSCodes.SetRange(SMSCodes."Table Name", TableName);
        if SMSCodes.Find('-') then begin
            repeat
                SMSCodes.CalcFields(SMSCodes."Field Name");
                FieldName[i] := SMSCodes."Field Name";
                i += i;
            until SMSCodes.Next = 0;
            RetunField := Format(FieldName[1]) + '[' + Format(FieldName[2]) + '[' + Format(FieldName[3]) + '[' + Format(FieldName[4]) + '[' + Format(FieldName[5]);
        end;
    end;

    // [Scope('OnPrem')]
    procedure GetSMSCode(SavingsAccounts: Record "Savings Accounts"; FieldName: Text) "code": Text[20]
    var
        TableName: Text;
        SMSCodes: Record "SMS Codes";
    begin
        TableName := SavingsAccounts.TableName;

        SMSCodes.Reset;
        SMSCodes.SetRange(SMSCodes."Table Name", TableName);
        SMSCodes.SetRange(SMSCodes."Field Name", FieldName);
        if SMSCodes.Find('-') then begin
            code := SMSCodes.Code;
        end;
    end;

    // [Scope('OnPrem')]
    procedure GetSMSFormat() StringCode: Text[130]
    var
        SMSSetup: Record "SMS Setup";
        SMSSeries: Record "SMS Series";
        TextBody: Text;
        String: Text;
    begin
        SMSSetup.Get;

        SMSSetup.TestField(SMSSetup."Member Creation");
        //Get the sms format
        SMSSeries.Reset;
        SMSSeries.SetRange(SMSSeries.Code, SMSSetup."Member Creation");
        if SMSSeries.Find('-') then begin
            TextBody := SMSSeries."Message Body";
            //StringCode:=PeriodicAcc.Token(TextBody,'[');
            StringCode := PeriodicAcc.Token(TextBody, '[]');
        end;
    end;

    // [Scope('OnPrem')]
    procedure GetAcualSMSFormat() TextBody: Text[130]
    var
        SMSSetup: Record "SMS Setup";
        SMSSeries: Record "SMS Series";
        String: Text;
    begin
        SMSSetup.Get;

        SMSSetup.TestField(SMSSetup."Member Creation");
        //Get the sms format
        SMSSeries.Reset;
        SMSSeries.SetRange(SMSSeries.Code, SMSSetup."Member Creation");
        if SMSSeries.Find('-') then begin
            TextBody := SMSSeries."Message Body";
            //StringCode:=PeriodicAcc.Token(TextBody,'[');
            //StringCode:=PeriodicAcc.Token(TextBody,'[]');
        end;
    end;

    procedure GetAvailableBalance(Account: Text[30]) AccountBal: Decimal
    var
        savAccList: Record "Savings Accounts";
        periodicActivities: Codeunit "Periodic Activities";
        AccountTypes: Record "Product Factory";
        MNo: Code[20];
        minBal: Decimal;
    begin
        AccountBal := 0;
        savAccList.Reset;
        savAccList.SetRange("No.", Account);
        if savAccList.Find('-') then begin

            savAccList.CalcFields("Balance (LCY)", "Uncleared Cheques", "ATM Transactions", "Lien Placed", "Authorised Over Draft", "Coop Transactions", "One Month Installment");
            if AccountTypes.Get(savAccList."Product Type") then begin
                minBal := 0;
                if AccountTypes."Product Category" = AccountTypes."product category"::" " then
                    minBal := AccountTypes."Minimum Balance";
                if AccountTypes."Loan Disbursement Account" then
                    minBal := AccountTypes."Minimum Balance";
                if (AccountTypes.Status <> AccountTypes.Status::Active) and (AccountTypes."Xrec Minimum Balance" > 0) then
                    minBal := AccountTypes."Xrec Minimum Balance";

                AccountBal := (savAccList."Balance (LCY)" + savAccList."Authorised Over Draft")
                              - minBal
                              - savAccList."Coop Transactions"
                              - savAccList."Uncleared Cheques"
                              - savAccList."Lien Placed"
                              - savAccList."ATM Transactions"
                              - savAccList."One Month Installment";

            end;
        end;
        exit(AccountBal);
    end;


}

