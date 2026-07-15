table 52185776 "Cashier Transactions"
{
    DrillDownPageID = "Posted Cashier Transactions";
    LookupPageID = "Posted Cashier Transactions";

    fields
    {
        field(1; No; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin

                if No <> xRec.No then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."Cashier Transaction Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Account No"; Code[20])
        {
            TableRelation = IF ("Account Type" = CONST(Account), type = filter(<> lien)) "Savings Accounts"."No." where("Product Type" = filter('191|192|193|194|195|198'), Status = filter(<> Closed))//filter('191|192|193|194|195|198'), Status = filter(<> Closed))
            ELSE
            IF ("Account Type" = CONST(Account), type = filter(lien)) "Savings Accounts"."No." where(Status = filter(<> Closed), "Product Type" = filter('191|195')) else
            IF ("Account Type" = CONST(MPESA)) "Bank Account"."No." WHERE("Bank Type" = filter("Mobile Money"), "Global Dimension 1 Code" = field("Global Dimension 1 Code"));

            trigger OnValidate()
            begin
                ATMLinkingApplications.Reset;
                ATMLinkingApplications.SetRange("Account No", "Account No");
                ATMLinkingApplications.SetRange("Card Issued", false);
                if ATMLinkingApplications.Find('-') then begin
                    if ATMLinkingApplications."ATM Application No." <> '' then
                        Message('The ATM card is ready for collection');
                end;
                Amount := 0;
                "Available Balance" := 0;


                Account.Reset;
                if Account.Get("Account No") then begin
                    if (Account.Status <> Account.Status::New) and (Account.Status <> Account.Status::Active) and (Account.Status <> Account.Status::Dormant) then
                        Error(Text0001);
                    Account.CalcFields(Account.Balance);
                    "Account Name" := Account.Name;
                    Remarks := Account.Name;
                    "Account Status" := Account.Status;
                    // Payee := Account.Name;
                    "Product Type" := Account."Product Type";
                    "Currency Code" := Account."Currency Code";
                    "ID No" := Account."ID No.";
                    "Member No." := Account."Member No.";
                    "Book Balance" := Account.Balance;
                    "Signing Instructions" := Account."Signing Instructions";
                    "Product Category" := Account."Product Category";
                    "Employer Code" := Account."Employer Code";
                    "Phone No" := Account."Transactional Mobile No";
                end;

                if "Account Type" = "Account Type"::MPESA then begin
                    BankAccount.Reset;
                    BankAccount.SetRange("No.", "Account No");
                    if BankAccount.FindFirst() then begin
                        BankAccount.CalcFields(BankAccount.Balance, BankAccount."Balance (LCY)");
                        "MPESA Float Balance" := BankAccount.Balance;
                    end;
                end;
                CalcAvailableBal;
                Validate("Member No.");
            end;
        }
        field(3; "Account Name"; Text[50])
        {
        }
        field(4; "Transaction Type"; Code[20])
        {
            TableRelation = "Transaction Types".Code WHERE("Product Type" = FIELD("Product Type"),
                                                            Category = CONST(Cashier));

            trigger OnValidate()
            var
                TransTypes: Enum "Fosa Transaction Types";
            begin

                if TransactionTypes.Get(rec."Transaction Type") then begin
                    "Transaction Description" := TransactionTypes.Description;
                    Validate(Rec.type, TransactionTypes.Type);
                end;
                Amount := 0;

                //Check if member has picture and Signature

                if Type = Type::"Cash Withdrawal" then begin
                    if Members.Get("Member No.") then begin
                        if Members."Account Type" = Members."Account Type"::"Single Member Account" then begin
                            ImageData.Reset;
                            ImageData.SetRange(ImageData."Member No", "Member No.");
                            if ImageData.Find('-') then begin
                                ImageData.CalcFields(ImageData.Picture, ImageData.Signature);
                                if not ImageData.Picture.HasValue then
                                    Error('Kindly capture the member photo before proceeding');
                                if not ImageData.Signature.HasValue then
                                    Error('Kindly Signature sample of the member before proceeding');
                            end else begin
                                Error('Kindly capture the member photo & Signature before proceeding');
                            end;
                        end;
                    end;
                end;



                if Type = Type::"Cheque Deposit" then begin

                    BUserSetup.Reset;
                    BUserSetup.SetRange(BUserSetup.UserID, UserId);
                    if BUserSetup.Find('-') then begin
                        BUserSetup.TestField("Cheque Clearance Account");
                        "Bank Account" := BUserSetup."Cheque Clearance Account";
                    end;
                end;

                CalcAvailableBal;
            end;
        }
        field(5; Amount; Decimal)
        {

            trigger OnValidate()
            var
                SavAcc: Record "Savings Accounts";
                SavLedgEntry: record "Savings Ledger Entry";
                TransType: Record "Transaction Types";
                TotalTransactions: Decimal;
            begin
                if Amount < 0 then
                    Error('Amount cannot be less than zero');

                GeneralSetUp.Get;

                if rec.type = rec.type::"Bankers Cheque" then begin
                    if Amount > GeneralSetUp."Bankers Cheque Limit" then
                        Error(Txt001, GeneralSetUp."Bankers Cheque Limit");
                end;
                CalcAvailableBal;
                TransType.Get(rec."Transaction Type");
                if (Amount > TransType."Upper Limit") and (TransType."Upper Limit" <> 0) then
                    Error('Amount cannot exceed allowed limit of %1.', TransType."Upper Limit");

                if TransType.Type = TransType.Type::"Cash Deposit" then begin
                    SavAcc.Reset();
                    SavAcc.SetRange("Member No.", rec."Member No.");
                    if SavAcc.FindFirst() then begin
                        repeat
                            SavLedgEntry.Reset();
                            SavLedgEntry.SetRange("Customer No.", SavAcc."No.");
                            SavLedgEntry.SetRange("Posting Date", Today);
                            if SavLedgEntry.FindFirst() then begin
                                repeat
                                    TotalTransactions += SavLedgEntry.Amount
                                until SavLedgEntry.Next() = 0;
                            end;
                        until SavAcc.Next() = 0;
                        TotalTransactions -= rec.Amount;
                        if TotalTransactions <= -1000000 then begin
                            TotalTransactions *= -1;
                            Message('This member will have transacted over a million today %1', TotalTransactions);
                        end;
                    end;
                    BUserSetup.Get(Cashier);
                    BankAccount.Get(BUserSetup."Default  Bank");
                    BankAccount.CalcFields("Balance (LCY)");
                    if BankAccount."Balance (LCY)" >= BUserSetup."Maximum Withholding" then begin
                        //TODOMIM
                        Message('You need to Return money to treasury because you have exceeded the Max Withholding!')
                    end else
                        if BankAccount."Balance (LCY)" <= 0 then begin
                            if (Type <> type::"Cash Deposit") and (Type <> Type::"Cheque Deposit") and (Type <> Type::"Credit Receipt") then
                                Error('You need to request money from treasury first before proceeding!');
                        end;


                end;
                if TransType.Get(Rec."Transaction Type") then begin
                    if (TransType.Type <> TransType.Type::"Cash Deposit") and (TransType.Type <> TransType.Type::"Cheque Deposit") and (TransType.Type <> TransType.Type::"Credit Receipt") and (TransType.Type <> TransType.Type::"Bankers Cheque") and (TransType.Type <> TransType.Type::"Cancel Bankers Cheque") then begin

                        //T0DO -Check clearing bank balance
                        // if TransType.Type = TransType.Type::"Bankers Cheque" then begin
                        //     BankAccount.Get(BUserSetup."Bankers Cheque Account");
                        //     BankAccount.CalcFields("Balance (LCY)");
                        //     if BankAccount."Balance (LCY)" < rec.Amount then begin
                        //         Error('Transaction Denied: Insufficient funds in till. Current balance is %1', BankAccount."Balance (LCY)");
                        //     end;
                        // end
                        // else begin
                        BUserSetup.Get(Cashier);
                        BankAccount.Get(BUserSetup."Default  Bank");
                        BankAccount.CalcFields("Balance (LCY)");
                        if BankAccount."Balance (LCY)" < rec.Amount then begin
                            Error('Transaction Denied: Insufficient funds in till. Current balance is %1', BankAccount."Balance (LCY)");
                        end;
                        // end;

                    end;
                end;
            end;

        }
        field(6; Cashier; Code[50])
        {
            Editable = false;
        }
        field(7; "Transaction Date"; Date)
        {
            Editable = false;
        }
        field(8; "Transaction Time"; Time)
        {
            Editable = false;
        }
        field(9; Posted; Boolean)
        {
        }
        field(10; "No. Series"; Code[20])
        {
            Editable = false;
            TableRelation = "No. Series";
        }
        field(11; "Product Type"; Code[20])
        {
            TableRelation = "Product Factory"."Product ID" WHERE("Product Class Type" = CONST(Savings));
        }
        field(12; "Cheque Type"; Code[20])
        {
            TableRelation = "Cheque Types";

            trigger OnValidate()
            begin
                TestField(Amount);
                if ChequeTypes.Get("Cheque Type") then begin
                    //Added by ckigen
                    if (ChequeTypes."Cheque Limit" <> 0) and (Amount > ChequeTypes."Cheque Limit") then
                        Error(Text0003, ChequeTypes."Cheque Limit");
                    //Remarks:=ChequeTypes.Description;
                    CDays := ChequeTypes."Clearing  Days";

                    EMaturity := "Transaction Date";
                    if i < CDays then begin
                        repeat
                            EMaturity := CalcDate('1D', EMaturity);
                            if (Date2DWY(EMaturity, 1) <> 6) and (Date2DWY(EMaturity, 1) <> 7) then
                                i := i + 1;

                        until i = CDays;
                    end;

                    "Expected Maturity Date" := EMaturity;

                    if ChequeTypes."Clearing  Days" = 0 then
                        "Cheque Status" := "Cheque Status"::Honoured
                    else
                        "Cheque Status" := "Cheque Status"::Pending;

                end;
            end;
        }
        field(13; "Cheque No"; Code[6])
        {

            trigger OnValidate()
            begin
                CashierTransactions.Reset;
                CashierTransactions.SetRange("Account No", "Account No");
                CashierTransactions.SetRange("Bank Account", "Bank Account");
                CashierTransactions.SetRange("Cheque No", "Cheque No");
                if CashierTransactions.Find('-') then begin
                    Error('The cheque No. %1 has already been posted to %2 on %3', CashierTransactions."Cheque No", CashierTransactions."Account No", CashierTransactions."Transaction Date");
                end;
            end;
        }
        field(14; "Cheque Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Cheque Date" > Today then
                    Error('Post dating not allowed');
                CashOfficeSetup.Get;
                if "Cheque Date" < CalcDate('-' + Format(CashOfficeSetup."Cheque Reject Period"), Today) then
                    Error(Text0002);
            end;
        }
        field(15; Payee; Text[100])
        {
        }
        field(16; Remarks; Text[100])
        {
        }
        field(17; Type; Enum "Fosa Transaction Types")
        {
            trigger OnValidate()
            var
                BankersCheque: Record "Bankers Cheques Register";
            begin
                if Rec.type = rec.type::"Bankers Cheque" then begin
                    BankersCheque.reset;
                    BankersCheque.SetCurrentKey("Cheque No.");
                    BankersCheque.SetAscending("Cheque No.", true);
                    BankersCheque.SetRange(Status, BankersCheque.Status::Pending);
                    BankersCheque.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code"); // <-- add this
                    if BankersCheque.FindFirst() then
                        rec."Bankers Cheque No" := BankersCheque."Cheque No."
                    else
                        Error('No pending Bankers Cheque found for your branch. Kindly generate a new one.');
                end else
                    rec."Bankers Cheque No" := '';
            end;
        }
        field(18; "Transaction Description"; Text[100])
        {
        }
        field(19; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Cleared';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Cleared;
        }
        field(20; "Date Posted"; Date)
        {
        }
        field(21; "Time Posted"; Time)
        {
        }
        field(22; "Posted By"; Code[50])
        {
        }
        field(23; "Expected Maturity Date"; Date)
        {
        }
        field(24; "Currency Code"; Code[20])
        {
            TableRelation = Currency;
        }
        field(25; "Post Dated"; Boolean)
        {
        }
        field(26; "Book Balance"; Decimal)
        {
            Editable = false;
        }
        field(27; Overdraft; Boolean)
        {
        }
        field(28; "Protected Account"; Boolean)
        {
        }
        field(29; "Member No."; Code[20])
        {
            trigger OnValidate()
            var
                SavAcc: Record "Savings Accounts";
                SavLedgEntry: record "Savings Ledger Entry";
                TotalTransactions: Decimal;
                CT: Record "Cashier Transactions";
            begin
                SavAcc.Reset();
                SavAcc.SetRange("Member No.", rec."Member No.");
                if SavAcc.FindFirst() then begin
                    repeat
                        SavLedgEntry.Reset();
                        SavLedgEntry.SetRange("Customer No.", SavAcc."No.");
                        SavLedgEntry.SetRange("Posting Date", Today);
                        if SavLedgEntry.FindFirst() then
                            repeat
                                TotalTransactions += SavLedgEntry."Amount (LCY)"
                            until SavLedgEntry.next() = 0
                    until SavAcc.Next() = 0;
                    if TotalTransactions <= -1000000 then begin
                        TotalTransactions *= -1;
                        Message('This member has transacted over a million today %1', TotalTransactions);
                    end;

                end;
                //System should notify teller if a member has multiple times in other branches.
                CT.Reset();
                CT.SetRange("Member No.", rec."Member No.");
                CT.SetRange("Transaction Date", Today);
                CT.SetRange(Posted, true);
                CT.SetFilter("Global Dimension 1 Code", '<>%1', rec."Global Dimension 1 Code");
                if CT.FindSet() then begin
                    repeat
                        CT.calcFields("Branch Name");
                        Message(
                              'This member has done other transactions today in another branch. Transaction Type: %1, Amount: %2, Branch: %3',
                              Format(CT.Type),
                              CT.Amount,
                              CT."Branch Name"
                              );
                    until CT.Next() = 0;
                end;

            end;
        }
        field(30; "Banked By"; Code[50])
        {
        }
        field(31; "Date Banked"; Date)
        {
        }
        field(32; "Time Banked"; Time)
        {
        }
        field(33; "Cleared By"; Code[50])
        {
        }
        field(34; "Date Cleared"; Date)
        {
        }
        field(35; "Time Cleared"; Time)
        {
        }
        field(36; "ID No"; Code[20])
        {
        }
        field(37; "Bank Account"; Code[20])
        {
            TableRelation = "Bank Account" WHERE("Bank Type" = CONST(Normal),
                                                  Blocked = CONST(false));

            trigger OnValidate()
            begin
                Validate("Cheque No");
                if BankAccount.Get("Bank Account") then
                    "Cheque Issueing Bank" := BankAccount.Name;
            end;
        }
        field(38; Printed; Boolean)
        {
        }
        field(39; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(40; "Available Balance"; Decimal)
        {
        }
        field(41; "Attempted Self Transaction"; Boolean)
        {
        }
        field(42; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility CenterBR";
        }
        field(43; "Change Log"; Integer)
        {
        }
        field(44; "Cheque Status"; Option)
        {
            OptionCaption = 'Pending,Stopped,Bounced,Honoured,Cleared';
            OptionMembers = Pending,Stopped,Bounced,Honoured,Cleared;
        }
        field(45; "Bankers Cheque No"; Code[6])
        {
            TableRelation = IF (Type = CONST("Bankers Cheque")) "Bankers Cheques Register"."Cheque No." WHERE(
                        Status = FILTER(Pending),
                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code")
                    )
            else
            IF (Type = CONST("Cancel Bankers Cheque")) "Bankers Cheques Register"."Cheque No." WHERE(
                        Status = FILTER(Approved),
                        "Member No" = FIELD("Member No."),
                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code")
                    );

            trigger OnValidate()
            var
                BankersChequesReg: Record "Bankers Cheques Register";
            begin
                if rec.Type = rec.Type::"Cancel Bankers Cheque" then begin
                    BankersChequesReg.Reset();
                    BankersChequesReg.SetRange("Cheque No.", rec."Bankers Cheque No");
                    if BankersChequesReg.FindFirst() then begin
                        rec.Payee := BankersChequesReg.Payee;
                        rec.Amount := BankersChequesReg.Amount;
                    end;
                end;
            end;
        }
        field(46; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                Dimension.Reset();
                Dimension.SetRange(Code, rec."Global Dimension 1 Code");
                if Dimension.FindFirst() then begin
                    Rec."Branch Name" := Dimension.Name;
                end;
            end;
        }
        field(47; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(48; "Allocated Amount"; Decimal)
        {
            CalcFormula = Sum("Cashier Transaction Lines".Amount WHERE("Transaction No" = FIELD(No)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "FingerPrint Verified"; Boolean)
        {
            Editable = false;
        }
        field(50002; SystemGeneratedGuid; Guid)
        {
        }
        field(50003; Select; Boolean)
        {
        }
        field(50004; "Discounting Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Cheque Status" <> "Cheque Status"::Pending then
                    Error('You can only discount a pending cheque');

                if "Discounting Amount" < 0 then
                    Error('Amount must be greater than zero');


                ProdF.Reset;
                ProdF.SetRange(ProdF."Type of Discounting", ProdF."Type of Discounting"::"Cheque Discounting");
                ProdF.SetRange(ProdF."Product Class Type", ProdF."Product Class Type"::Loan);
                if ProdF.Find('-') then begin
                    ProdF.TestField(ProdF."Discounting %");
                    ProdF.TestField(ProdF."Interest Rate (Min.)");
                    ProdF.TestField(ProdF."Maximum Loan Amount");

                    if "Discounting Amount" > ProdF."Maximum Loan Amount" then
                        Error('The amount cannot be more than %1', ProdF."Maximum Loan Amount");
                end else
                    Error('Discounting loan product not found.');


                if (Amount * ProdF."Discounting %" / 100) < ("Discounted Amount" + "Discounting Amount") then
                    Error('You can only discount upto %1.', (Amount * ProdF."Discounting %" / 100) - "Discounted Amount");
            end;
        }
        field(50005; "Discounted Amount"; Decimal)
        {
        }
        field(50006; "Expiry Date"; Date)
        {
        }
        field(50007; "Signing Instructions"; Text[30])
        {
        }
        field(50008; "Till Name"; Code[50])
        {
            Editable = false;
        }
        field(50009; "Product Category"; enum "Product Categories")
        {

        }
        field(50010; "Till Code"; Code[20])
        {
        }
        field(50011; "New Account Balance"; Decimal)
        {
        }
        field(50012; "Employer Code"; Code[20])
        {
        }
        field(50013; Dublicate; Boolean)
        {
        }
        field(50014; "Cheque Issueing Bank"; Text[100])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Bank Account".Name where("No." = field("Bank Account")));
        }
        field(50015; "Account Type"; Option)
        {
            OptionCaption = 'Account,MPESA';
            OptionMembers = Account,MPESA;
            // ValuesAllowed = Account;
            trigger OnValidate()
            begin
                //TESTFIELD(Status,Status::Open);
                //CLEARALL();
                "Account No" := '';
                "Member No." := '';
                "Account Name" := '';
                Amount := 0;
                "Transaction Type" := '';
                //Type:=Type::" ";
                "ID No" := '';
                "Book Balance" := 0;
                "Available Balance" := 0;
                "New Account Balance" := 0;
                Remarks := '';
                "Signing Instructions" := '';
                "Cheque Date" := 0D;
                "Cheque No" := '';
                "Product Type" := '';
                "Project Member" := '';
                "Project Vendor" := '';
                
                "Charge Amount" := 0;
                "Excise Duty Amount" := 0;
                "SMS Charge Amount" := 0;
                "SMS Excise Duty" := 0;

                if "Account Type" = "Account Type"::MPESA then begin
                    BUserSetup.Reset;
                    BUserSetup.SetRange(BUserSetup.UserID, UserId);
                    if BUserSetup.Find('-') then begin
                        "Till Code" := BUserSetup."Default  Bank";
                        bankacc.Reset;
                        bankacc.SetRange("No.", BUserSetup."Default  Bank");
                        if bankacc.Find('-') then begin
                            bankacc.CalcFields(bankacc.Balance, bankacc."Balance (LCY)");
                            "Account No" := bankacc."No.";
                            "Till Name" := PadStr(BUserSetup."Default  Bank" + ' ' + bankacc.Name, 50);
                            if bankacc."Balance (LCY)" <= bankacc."Replenishment Balance" then begin
                                Message('Your cash balance has reached the replenishment level. Please request replenishment from treasury.');
                            end;
                        end;
                    end;
                end;
            end;
        }
        field(50016; "Project Member"; Code[20])
        {
            TableRelation = Members."No.";

            trigger OnValidate()
            begin
                if Members.Get("Project Member") then begin
                    "Account Name" := Members.Name;
                    "ID No" := Members."Primary Identification";
                    "Member No." := "Project Member";

                end;
            end;
        }
        field(50017; "Project Vendor"; Code[20])
        {
            TableRelation = Vendor."No." WHERE("Vendor Type" = CONST("Asset Finance"));
        }
        field(50018; "Blockage Reason"; Option)
        {
            OptionCaption = ' ,Recover Loan,Share Boost,Commercial Bridging,Others';
            OptionMembers = " ","Recover Loan","Share Boost","Commercial Bridging",Others;
        }
        field(50019; "Other Reason"; Text[50])
        {

        }
        field(50020; "Mpesa Reference"; Code[10])
        {
            trigger OnValidate()
            
            begin
                ValidateMpesaReference("Mpesa Reference");
            end;
        }
        field(50021; Source; Text[100])
        {
        }
        field(50022; Purpose; Text[100])
        {
        }
        field(50023; "Branch Name"; Text[100])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name where("Code" = field("Global Dimension 1 Code")));
        }
        field(50024; "Account Status"; Enum "Savings Account status")//Option)
        {
            // OptionCaption = ' ,New,Active,Dormant,Frozen,Withdrawal Application,Withdrawn,Deceased,Defaulter,Closed';
            // OptionMembers = " ",New,Active,Dormant,Frozen,"Withdrawal Application",Withdrawn,Deceased,Defaulter,Closed;
            //TableRelation = "Savings Accounts" where("No." = field("Account No"));
        }
        field(50025; "Cashier Till Balance"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Ledger Entry"."Amount (LCY)" WHERE("Bank Account No." = field("Till Code")));
        }
        field(50026; "Phone No"; Code[20])
        {
            Editable = false;
        }
        field(50027; "Reference Name"; Text[100])
        {
        
        }
        field(50028; "MPESA Float Balance"; Decimal)
        {
        }
        field(50029; "Bank Code"; code[20])
        {
            TableRelation = "PR Bank Accounts"."Bank Code";
            trigger OnValidate()
            var
                BankAcc: Record "PR Bank Accounts";
            begin
                if BankAcc.Get(Rec."Bank Code") then
                    Rec."Bank Name" := BankAcc."Bank Name"
                else
                    Rec."Bank Name" := '';
            end;
        }
        field(50030; "Bank Name"; Text[100])
        {
            Editable = false;
        }
        field(50031; "Charge Amount"; Decimal)
        {
            Editable = false;
            Description = 'Base withdrawal fee exclusive of excise and SMS';
        }
        field(50032; "Excise Duty Amount"; Decimal)
        {
            Editable = false;
            Description = 'Excise Duty charged on the base withdrawal fee';
        }
        field(50033; "SMS Charge Amount"; Decimal)
        {
            Editable = false;
            Description = 'SMS Charge segregated from base charge';
        }
        field(50034; "SMS Excise Duty"; Decimal)
        {
            Editable = false;
            Description = 'Excise Duty charged specifically on the SMS Fee';
        }
        field(50035; "Approved By"; Code[50])
        {
            Editable = false;
        }
        field(50036; "Payer"; Code[100])
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
        key(Key2; "Account No", "Posted", Type, "Cheque Status")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Error('You cannot delete this transaction');
    end;



    trigger OnInsert()
    begin
        TillNo := Temp."Default  Bank";
        MemberNo := Temp."Member No.";
        Excess := Temp."Excess Account";
        Shortage := Temp."Shortage Account";
        Jtemplate := Temp."Cashier Journal Template";
        Jbatch := Temp."Cashier Journal Batch";

        // Temp.Get(UserId);
        // if Jtemplate = '' then begin
        //     Error('Ensure the Cashier journal Template is set up in Banking User Setup');
        // end;
        // if Jbatch = '' then begin
        //     Error('Ensure the Cashier journal Batch is set up in Banking User Setup');
        // end;
        // if TillNo = '' then begin
        //     Error('Ensure the Default Bank is set up in Banking User Setup');
        // end;

        // if MemberNo = '' then begin
        //     Error('Ensure the Cashier Member no is set up in Banking User Setup');
        // end;

        // if Shortage = '' then begin
        //     Error('Ensure the Cashier Shortage Account is set up in Banking User Setup');
        // end;

        // if Excess = '' then begin
        //     Error('Ensure the Cashier Excess Account iis set up in Banking User Setup');
        // end;


        if No = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Cashier Transaction Nos.");
            No := NoSeriesMgt.GetNextNo(NoSetup."Cashier Transaction Nos.");
            // NoSeriesMgt.InitSeries(NoSetup."Cashier Transaction Nos.", xRec."No. Series", 0D, No, "No. Series");
        end;

        Cashier := UpperCase(UserId);
        "Transaction Date" := Today;
        "Transaction Time" := Time;


        BUserSetup.Reset;
        BUserSetup.SetRange(BUserSetup.UserID, UserId);
        if BUserSetup.Find('-') then begin
            "Till Code" := BUserSetup."Default  Bank";
            bankacc.Reset;
            bankacc.SetRange("No.", BUserSetup."Default  Bank");
            bankacc.calcfields(bankacc."Balance (LCY)");
            if bankacc.Find('-') then begin
                "Till Code" := BUserSetup."Default  Bank";
                "Till Name" := PadStr(BUserSetup."Default  Bank" + ' ' + bankacc.Name, 50);
            end;
        end;

        Dimension.Reset();
        Dimension.SetRange(Code, rec."Global Dimension 1 Code");
        if Dimension.FindFirst() then begin
            Rec."Branch Name" := Dimension.Name;
        end;

        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UserId);
        if UserSetup.Find('-') then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");


            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
        end;

    end;

    trigger OnModify()
    begin
        /*IF Posted=FALSE THEN BEGIN
        IF Status<>Status::"Pending Approval" THEN BEGIN
        IF Cashier<>USERID THEN
        ERROR('You cannot modify a transaction being processed by user %1',Cashier);
        END;
        END;
        */

    end;

    var
        Dimension: Record "Dimension Value";
        NoSetup: Record "Banking No Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        Account: Record "Savings Accounts";
        TransactionTypes: Record "Transaction Types";
        Text0001: Label 'The account is not active and therefore cannot be transacted upon.';
        ChequeTypes: Record "Cheque Types";
        CDays: Integer;
        EMaturity: Date;
        i: Integer;
        BNK: Code[120];
        UserSetup: Record "User Setup";
        TCharges: Decimal;
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        Trans: Record "Cashier Transactions";
        TChargeAmount: Decimal;
        GenSetup: Record "General Set-Up";
        AccountTypes: Record "Product Factory";
        TransType: Record "Transaction Types";
        BUserSetup: Record "Banking User Template";
        ProdF: Record "Product Factory";
        bankacc: Record "Bank Account";
        CashOfficeSetup: Record "Cash Office Setup";
        Text0002: Label 'The cheque has expired';
        Text0003: Label 'The cheque limit should not exceed the cheque amount limit of %1';
        BankAccount: Record "Bank Account";
        CashierTransactions: Record "Cashier Transactions";
        ATMLinkingApplications: Record "ATM Linking Applications";
        ImageData: Record "Image Data";
        Members: Record Members;
        GeneralSetUp: Record "General Set-Up";
        Txt001: Label 'Amount should not exceed the cheque amount limit of %1 in the General Set up.';
        Text0005: Label 'Ensure the Cashier Shortage Account is set up in Banking User Setup';
        Text0006: Label 'Ensure the Cashier Excess Account iis set up in Banking User Setup';
        Excess: Code[20];
        Shortage: Code[20];
        TillNo: Code[20];
        MemberNo: Code[20];
        Temp: Record "Banking User Template";
        Text0004: Label 'Ensure the Cashier Member no is set up in Banking User Setup';
        Jtemplate: Code[20];
        Jbatch: Code[20];

    local procedure CalcAvailableBal()
    var
        TCharges: Decimal;
        AvailableBalance: Decimal;
        MinBalance: Decimal;
        Account: Record "Savings Accounts";
        ProdType: Record "Product Factory";
    begin

        CalcCharges;


        "Available Balance" := 0;
        MinBalance := 0;

        if Account.Get("Account No") then begin
            Account.CalcFields("Coop Transactions", Account.Balance, Account."Uncleared Cheques", Account."Authorised Over Draft", Account."Lien Placed", "ATM Transactions");

            ProdType.Reset;
            ProdType.SetRange(ProdType."Product ID", "Product Type");
            if ProdType.Find('-') then begin
                MinBalance := ProdType."Minimum Balance";

                "Available Balance" := (Account.Balance + Account."Authorised Over Draft") - (Account."Coop Transactions" + MinBalance + Account."Uncleared Cheques" + TChargeAmount + Account."Lien Placed" + Account."ATM Transactions");

                if Type = Type::"Cash Withdrawal" then
                    "New Account Balance" := "Available Balance" - Amount
                else
                    if (Type = Type::"Cash Deposit") or (Type = Type::"Cheque Deposit") then
                        "New Account Balance" := "Available Balance" + Amount
                    else
                        if Type = Type::"Bankers Cheque" then
                            "New Account Balance" := "Available Balance" - Amount
            end;
        end;
    end;

    local procedure CalcCharges()
    var
        IsSMS: Boolean;
    begin

        GenSetup.Get;

        TChargeAmount := 0;
        
        "Charge Amount" := 0;
        "Excise Duty Amount" := 0;
        "SMS Charge Amount" := 0;
        "SMS Excise Duty" := 0;

        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type", "Transaction Type");
        if TransactionCharges.Find('-') then begin
            repeat

                ChargeAmount := 0;
                IsSMS := false;
                
                // Identify if the loop has encountered the SMS Charge dynamically 
                if (StrPos(UpperCase(TransactionCharges.Description), 'SMS') > 0) or 
                   (StrPos(UpperCase(TransactionCharges."Charge Code"), 'SMS') > 0) then
                    IsSMS := true;

                if (TransactionCharges."Transaction Charge Category" = TransactionCharges."Transaction Charge Category"::Normal) or
                (TransactionCharges."Transaction Charge Category" = TransactionCharges."Transaction Charge Category"::"Stamp Duty") then begin


                    if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::"% of Amount" = true then
                        ChargeAmount := (Amount * TransactionCharges."Percentage of Amount") * 0.01
                    else
                        ChargeAmount := TransactionCharges."Charge Amount";

                    if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::Staggered then begin

                        TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                        TariffDetails.Reset;
                        TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                        if TariffDetails.Find('-') then begin
                            repeat
                                if (Amount >= TariffDetails."Lower Limit") and (Amount <= TariffDetails."Upper Limit") then begin
                                    if TariffDetails."Use Percentage" = true then begin
                                        ChargeAmount := Amount * TariffDetails.Percentage * 0.01;
                                    end else begin
                                        ChargeAmount := TariffDetails."Charge Amount";
                                    end;
                                end;
                            until TariffDetails.Next = 0;
                        end;
                    end;


                    // Segregate the SMS Charge vs the Base Withdrawal Fee
                    if IsSMS then begin
                        "SMS Charge Amount" += ChargeAmount;
                        
                        if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."Transaction Charge Category"::"Stamp Duty") and (TransactionCharges."Recover Excise Duty") then
                            "SMS Excise Duty" += (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;
                    end else begin
                        "Charge Amount" += ChargeAmount;
                        
                        if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."Transaction Charge Category"::"Stamp Duty") and (TransactionCharges."Recover Excise Duty") then
                            "Excise Duty Amount" += (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;
                    end;

                    TChargeAmount := TChargeAmount + ChargeAmount;

                    if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."Transaction Charge Category"::"Stamp Duty") and (TransactionCharges."Recover Excise Duty") then begin
                        // Global system Excise Duty
                        TChargeAmount := TChargeAmount + (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;
                        ;
                    end;
                end;
            until TransactionCharges.Next = 0;
        end;



        //Charge withdrawal Frequency
        if Type = Type::"Cash Withdrawal" then begin
            if Account.Get("Account No") then begin
                if AccountTypes.Get(Account."Product Type") then begin
                    if Account."Last Withdrawal Date" <> 0D then begin
                        if CalcDate(AccountTypes."Withdrawal Interval", Account."Last Withdrawal Date") > Today then begin
                            //IF CALCDATE(AccountTypes."Withdrawal Interval",Account."Last Withdrawal Date") <= CALCDATE('1D',TODAY) THEN BEGIN



                            TransactionCharges.Reset;
                            TransactionCharges.SetRange(TransactionCharges."Transaction Type", "Transaction Type");
                            if TransactionCharges.Find('-') then begin
                                repeat

                                    IsSMS := false;
                                    if (StrPos(UpperCase(TransactionCharges.Description), 'SMS') > 0) or 
                                       (StrPos(UpperCase(TransactionCharges."Charge Code"), 'SMS') > 0) then
                                        IsSMS := true;

                                    if (TransactionCharges."Transaction Charge Category" = TransactionCharges."Transaction Charge Category"::"Withdrawal Frequency") then begin



                                        ChargeAmount := 0;
                                        if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::"% of Amount" = true then
                                            ChargeAmount := (Amount * TransactionCharges."Percentage of Amount") * 0.01
                                        else
                                            ChargeAmount := TransactionCharges."Charge Amount";

                                        if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::Staggered then begin

                                            TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                                            TariffDetails.Reset;
                                            TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                            if TariffDetails.Find('-') then begin
                                                repeat
                                                    if (Amount >= TariffDetails."Lower Limit") and (Amount <= TariffDetails."Upper Limit") then begin
                                                        if TariffDetails."Use Percentage" = true then begin
                                                            ChargeAmount := Amount * TariffDetails.Percentage * 0.01;
                                                        end else begin
                                                            ChargeAmount := TariffDetails."Charge Amount";
                                                        end;
                                                    end;
                                                until TariffDetails.Next = 0;
                                            end;
                                        end;


                                        // Segregate frequency penalty from SMS noise
                                        if IsSMS then begin
                                            "SMS Charge Amount" += ChargeAmount;
                                            if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."Transaction Charge Category"::"Stamp Duty") and (TransactionCharges."Recover Excise Duty") then
                                                "SMS Excise Duty" += (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;
                                        end else begin
                                            "Charge Amount" += ChargeAmount;
                                            if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."Transaction Charge Category"::"Stamp Duty") and (TransactionCharges."Recover Excise Duty") then
                                                "Excise Duty Amount" += (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;
                                        end;

                                        TChargeAmount := TChargeAmount + ChargeAmount;


                                        if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."Transaction Charge Category"::"Stamp Duty") and (TransactionCharges."Recover Excise Duty") then begin

                                            //Excise Duty


                                            TChargeAmount := TChargeAmount + (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;
                                        end;
                                    end;
                                until TransactionCharges.Next = 0;
                            end;

                        end;


                    end;
                end;
            end;
        end;
        //Charge withdrawal Frequency



        //Penalty of maximum amount on transaction
        if Type = Type::"Cash Withdrawal" then begin
            if TransType.Get("Transaction Type") then begin

                Trans.Reset;
                Trans.SetRange(Trans."Transaction Date", Today);
                Trans.SetRange(Trans."Account No", "Account No");
                Trans.SetRange(Posted, true);
                Trans.SetRange(Trans.Type, Trans.Type::"Cash Withdrawal");
                if Trans.FindSet then begin
                    Trans.CalcSums(Trans.Amount);


                end;
            end;

            if Trans.Amount > TransType."Upper Limit" then begin


                //Charges
                TCharges := 0;

                TransactionCharges.Reset;
                TransactionCharges.SetRange(TransactionCharges."Transaction Type", "Transaction Type");
                if TransactionCharges.Find('-') then begin
                    repeat

                        IsSMS := false;
                        if (StrPos(UpperCase(TransactionCharges.Description), 'SMS') > 0) or 
                           (StrPos(UpperCase(TransactionCharges."Charge Code"), 'SMS') > 0) then
                            IsSMS := true;

                        if (TransactionCharges."Transaction Charge Category" = TransactionCharges."Transaction Charge Category"::"Withdrawn Amount") then begin
                        

                            ChargeAmount := 0;
                            if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::"% of Amount" = true then
                                ChargeAmount := (Amount * TransactionCharges."Percentage of Amount") * 0.01
                            else
                                ChargeAmount := TransactionCharges."Charge Amount";

                            if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::Staggered then begin

                                TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                                TariffDetails.Reset;
                                TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                if TariffDetails.Find('-') then begin
                                    repeat
                                        if (Amount >= TariffDetails."Lower Limit") and (Amount <= TariffDetails."Upper Limit") then begin
                                            if TariffDetails."Use Percentage" = true then begin
                                                ChargeAmount := Amount * TariffDetails.Percentage * 0.01;
                                            end else begin
                                                ChargeAmount := TariffDetails."Charge Amount";
                                            end;
                                        end;
                                    until TariffDetails.Next = 0;
                                end;
                            end;

                            // Adding the penalty charges securely separated from SMS
                            if IsSMS then begin
                                "SMS Charge Amount" += ChargeAmount;
                                if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."Transaction Charge Category"::"Stamp Duty") and (TransactionCharges."Recover Excise Duty") then
                                    "SMS Excise Duty" += (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;
                            end else begin
                                "Charge Amount" += ChargeAmount;
                                if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."Transaction Charge Category"::"Stamp Duty") and (TransactionCharges."Recover Excise Duty") then
                                    "Excise Duty Amount" += (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;
                            end;

                            TChargeAmount := TChargeAmount + ChargeAmount;

                            if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."Transaction Charge Category"::"Stamp Duty") and (TransactionCharges."Recover Excise Duty") then begin

                        
                                TChargeAmount := TChargeAmount + (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;
                            end;
                        end;
                    until TransactionCharges.Next = 0;
                end;
            end;
        end;

        //Penalty of maximum amount on transaction
    end;

    local procedure ValidateMpesaReference(MpesaRef: Code[10])
    var 
         CT: record "Cashier Transactions";
         MpesaRefCode : Code[10];          
    begin
        clear(MpesaRefCode);

        MpesaRefCode := UpperCase(DelChr(MpesaRef, '<>', ' '));

        if StrLen(MpesaRefCode) <> 10 then
        Error('M-Pesa reference must be exactly 10 characters long.');

        if "Account Type" = "Account Type"::MPESA then begin
            CT.Reset();
            CT.SetRange("Mpesa Reference", MpesaRefCode);
            CT.setfilter(No, '<>%1', Rec.No);
            if CT.FindFirst() then
                Error('MPESA Reference Code %1 already exists for transaction No. %2', MpesaRefCode, CT.No);
        end;
    end;
    
    local procedure CLEARALL()
    begin
        "Account No" := '';
        "Member No." := '';
        "Account Name" := '';
        Amount := 0;
        "Transaction Type" := '';
        //Type:=Type::" ";
        "ID No" := '';
        "Book Balance" := 0;
        "Available Balance" := 0;
        "New Account Balance" := 0;
        Remarks := '';
        "Signing Instructions" := '';
        "Cheque Date" := 0D;
        "Cheque No" := '';
        "Product Type" := '';
        
        "Charge Amount" := 0;
        "Excise Duty Amount" := 0;
        "SMS Charge Amount" := 0;
        "SMS Excise Duty" := 0;
    end;
}

