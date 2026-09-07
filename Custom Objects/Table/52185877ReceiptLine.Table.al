table 52185877 "Receipt Line"
{
    DrillDownPageID = "Receipts Line";
    LookupPageID = "Receipts Line";

    fields
    {
        field(1; No; Code[20])
        {
            NotBlank = false;
            TableRelation = "Receipts Header"."No.";
        }
        field(2; Date; Date)
        {
            CalcFormula = Lookup("Receipts Header".Date WHERE("No." = FIELD(No)));
            FieldClass = FlowField;
        }
        field(3; Type; Code[20])
        {
            TableRelation = "Receipts and Payment Types".Code WHERE(Type = FILTER(Claim | Receipt),
                                                                     Blocked = CONST(false));

            trigger OnValidate()
            begin
                "Account No." := '';
                "Account Name" := '';
                Remarks := '';
                RecPayTypes.Reset;
                RecPayTypes.SetRange(RecPayTypes.Code, Type);
                RecPayTypes.SetFilter(RecPayTypes.Type, '%1|%2', RecPayTypes.Type::Receipt,
                RecPayTypes.Type::Claim);
                if RecPayTypes.Find('-') then begin
                    "Account Type" := RecPayTypes."Account Type";
                    Rec.Validate("Account Type");
                    "Transaction Name" := RecPayTypes.Description;
                    Grouping := RecPayTypes."Default Grouping";
                    Remarks := RecPayTypes."Transation Remarks";
                    "Customer Payment On Account" := RecPayTypes."Customer Payment On Account";

                    if RecPayTypes."Account Type" = RecPayTypes."Account Type"::"G/L Account" then begin
                        if "Account No." <> '' then
                            RecPayTypes.TestField(RecPayTypes."G/L Account");
                        "Account No." := RecPayTypes."G/L Account";
                        if "Account No." <> '' then
                            Validate("Account No.");
                    end;
                    if (RecPayTypes."Withholding Tax Chargeable" = RecPayTypes."Withholding Tax Chargeable"::Yes) then begin
                        "Withholding Tax Code" := RecPayTypes."Withholding Tax Code";
                        rec.validate("Withholding Tax Code");
                    end
                    else begin
                        "Withholding Tax Code" := '';
                        "W/Tax Rate" := 0;
                    end;


                end;

                //Check if the batch account has been inserted it the "Customer Payment On Account" is true
                RecPayTypes.Reset;
                RecPayTypes.SetRange(RecPayTypes.Code, Type);
                RecPayTypes.SetRange(RecPayTypes.Type, RecPayTypes.Type::Receipt);
                /*
                IF RecPayTypes.FIND('-') THEN
                  BEGIN
                    //check if the receipt type has Customer Payment On Account as True
                      IF RecPayTypes."Customer Payment On Account"=TRUE THEN
                        BEGIN
                          //check if the Receivable Batch Account is entered
                          SRSetup.GET();
                          SRSetup.TESTFIELD(SRSetup."Receivable Batch Account");
                        END;
                
                  END;
                  */

                RHead.Reset;
                RHead.SetRange(RHead."No.", No);
                if RHead.FindFirst then begin
                    "Global Dimension 1 Code" := RHead."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := RHead."Shortcut Dimension 2 Code";
                    "Dimension Set ID" := RHead."Dimension Set ID";
                    "Group Code" := RHead."Group Code";
                    // "Account Name" := RHead."Received From";

                end;


                RHead.Reset;
                RHead.SetRange(RHead."No.", No);
                RHead.SetFilter("Insurance Claim no", '<>%1', '');
                if RHead.FindFirst then begin
                    "Global Dimension 1 Code" := RHead."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := RHead."Shortcut Dimension 2 Code";
                    "Dimension Set ID" := RHead."Dimension Set ID";
                    "Group Code" := RHead."Group Code";

                    "Cheque/Deposit Slip Date" := Today;
                    "Cheque/Deposit Slip No" := RHead."CIC Claim No(External)";
                    "Pay Mode" := "Pay Mode"::EFT;
                end;

            end;
        }
        field(4; "Pay Mode"; Option)
        {
            OptionMembers = " ",Cash,Cheque,EFT,"Deposit Slip","Banker's Cheque",RTGS,STO,Custom3;

            trigger OnValidate()
            begin
                GenLedgerSetup.Reset;
                GenLedgerSetup.Get();

                if "Pay Mode" = "Pay Mode"::"Deposit Slip" then begin
                    "Bank Account" := GenLedgerSetup."Default Bank Deposit Slip A/C";
                end;
            end;
        }
        field(5; "Cheque/Deposit Slip No"; Code[20])
        {

            trigger OnValidate()
            begin
                // CheckSlipDetails();
            end;
        }
        field(6; "Cheque/Deposit Slip Date"; Date)
        {

            trigger OnValidate()
            begin
                /*
                GenLedgerSetup.GET;
                IF CALCDATE(GenLedgerSetup."Cheque Reject Period","Cheque/Deposit Slip Date")<=TODAY THEN
                  BEGIN
                    ERROR('The cheque date is not within the allowed range.');
                  END;
                
                CheckSlipDetails();
                 */
                if "Cheque/Deposit Slip Date" > Today then
                    Error('The cheque date cannot be in the future');

            end;
        }
        field(7; "Cheque/Deposit Slip Type"; Option)
        {
            OptionMembers = " "," Local","Up Country";
        }
        field(8; "Bank Code"; Code[20])
        {
            TableRelation = "Bank Code Structure".Code;
            trigger OnValidate()
            var
                BankAcc: Record "Bank Code Structure";
            begin
                if BankAcc.get("Bank Code")
                then
                    "Bank Name" := BankAcc.Name;
            end;
        }
        field(9; "Received From"; Text[100])
        {
        }
        field(10; "On Behalf Of"; Text[100])
        {
        }
        field(11; Cashier; Code[50])
        {
        }
        field(12; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            Editable = false;
            trigger OnValidate()
            var
                RecLine: record "Receipt Line";
                RecHeader: record "Receipts Header";
            begin
                // IF RecHeader.get(Rec.No) then begin
                //     RecLine.reset();
                //     RecLine.SetRange(No, RecHeader."No.");
                //     RecLine.SetRange("Account Type", RecLine."Account Type"::Customer);
                //     IF RecLine.findset then
                //         If RecLine.count > 1 then ERROR('You have already Selected a customer');

                // end;
            end;
        }
        field(13; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Direct Posting" = CONST(true),
                                                                                          "Expense Code" = FIELD(Grouping))
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer WHERE("Customer Posting Group" = FIELD(Grouping))
            ELSE
            IF ("Account Type" = CONST(Credit)) "Credit Accounts" WHERE("Group Account No" = FIELD("Group Code"))
            ELSE
            IF ("Account Type" = CONST(Savings)) "Savings Accounts"
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor WHERE("Vendor Posting Group" = FIELD(Grouping))
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account" WHERE("Bank Acc. Posting Group" = FIELD(Grouping))
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Account Type" = CONST("IC Partner")) "IC Partner";

            trigger OnValidate()
            begin
                Rec.Validate("Account Type");
                "Account Name" := '';

                if "Account Type" in ["Account Type"::"G/L Account", "Account Type"::Customer,
                   "Account Type"::Vendor, "Account Type"::"IC Partner", "Account Type"::Savings,
                   "Account Type"::Credit] then
                    case "Account Type" of
                        "Account Type"::"G/L Account":
                            begin
                                GLAcc.Get("Account No.");
                                "Account Name" := GLAcc.Name;
                                "Global Dimension 1 Code" := GLAcc."Global Dimension 1 Code";

                                "VAT Bus. Posting Group" := GLAcc."VAT Bus. Posting Group";
                                "VAT Prod. Posting Group" := GLAcc."VAT Prod. Posting Group";
                                "Gen. Posting Type" := GLAcc."Gen. Posting Type";
                                "Gen. Bus. Posting Group" := GLAcc."Gen. Bus. Posting Group";
                                "Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
                                VATSetup.Reset;
                                VATSetup.SetRange(VATSetup."VAT Bus. Posting Group", "VAT Bus. Posting Group");
                                VATSetup.SetRange(VATSetup."VAT Prod. Posting Group", "VAT Prod. Posting Group");
                                if VATSetup.Find('-') then begin
                                    "VAT %" := VATSetup."VAT %";
                                end;
                            end;
                        "Account Type"::Customer:
                            begin
                                Cust.Get("Account No.");
                                "Account Name" := Cust.Name;
                                if "Global Dimension 1 Code" = '' then begin
                                    "Global Dimension 1 Code" := Cust."Global Dimension 1 Code";
                                end;
                            end;
                        "Account Type"::Vendor:
                            begin
                                Vend.Get("Account No.");
                                "Account Name" := Vend.Name;
                                if "Global Dimension 1 Code" = '' then begin
                                    "Global Dimension 1 Code" := Vend."Global Dimension 1 Code";
                                end;
                            end;
                        "Account Type"::"Bank Account":
                            begin
                                BankAcc.Get("Account No.");
                                "Account Name" := BankAcc.Name;
                                if "Global Dimension 1 Code" = '' then begin
                                    "Global Dimension 1 Code" := BankAcc."Global Dimension 1 Code";
                                end;
                            end;
                        "Account Type"::"Fixed Asset":
                            begin
                                FA.Get("Account No.");
                                "Account Name" := FA.Description;
                                "Global Dimension 1 Code" := FA."Global Dimension 1 Code";
                            end;
                        "Account Type"::"IC Partner":
                            begin
                                ICPartner.Reset;
                                ICPartner.Get("Account No.");
                                "Account Name" := ICPartner.Name;
                            end;

                        //
                        "Account Type"::Savings:
                            begin
                                SavingsAcc.Get("Account No.");
                                "Account Name" := SavingsAcc."Product Name";
                                if "Global Dimension 1 Code" = '' then begin
                                    "Global Dimension 1 Code" := SavingsAcc."Global Dimension 1 Code";
                                end;
                            end;

                        "Account Type"::Credit:
                            begin
                                CreditAcc.Get("Account No.");
                                "Account Name" := CreditAcc."Product Name";
                                if "Global Dimension 1 Code" = '' then begin
                                    "Global Dimension 1 Code" := CreditAcc."Global Dimension 1 Code";
                                end;
                            end;
                    //

                    end;
                /*
                {Check if the global dimension 1 code has een selected by the user}
                IF ("Global Dimension 1 Code"='') AND ("Account Type"<>"Account Type"::"G/L Account")THEN
                  BEGIN
                    ERROR('Please ensure that the Function code is selected');
                  END;
                */

                // CreateDim(
                //   DimMgt.TypeToTableID1("Account Type"), "Account No.");

                /*
                CreateDim(
                  DimMgt.TypeToTableID1("Account Type"),"Account No.",
                  DimMgt.TypeToTableID1("Bal. Account Type"),"Bal. Account No.",
                  DATABASE::Job,"Job No.",
                  DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
                  DATABASE::Campaign,"Campaign No.");
                 */

                // RHead.Reset;
                // RHead.SetRange(RHead."No.", No);
                // RHead.SetFilter("Member No", '<>%1', '');
                // if RHead.FindFirst then begin
                //     "Account Name" := RHead."Received From";
                //     "Transaction Name" := RHead."Received From";
                // end;

            end;
        }
        field(14; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(15; "Account Name"; Text[150])
        {
        }
        field(16; Posted; Boolean)
        {
        }
        field(17; "Date Posted"; Date)
        {
        }
        field(18; "Time Posted"; Time)
        {
        }
        field(19; "Posted By"; Code[50])
        {
        }
        field(20; Amount; Decimal)
        {
            trigger OnValidate()
            begin

                "VAT Amount" := (Amount * "VAT %") / 100;
                "VAT Amount" := Round("VAT Amount", 0.05, '=');
                "Total Amount" := Amount + "VAT Amount";
                "Total Amount" := Amount;
                if Amount < 0 then
                    Error('The amount cannot be less than 0');
                if rec."Loan No." <> '' then begin
                    Loans.Get(rec."Loan No.");
                    Loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Daily Interest", Loans."Total Balance");
                    case
                        rec."Transaction Type" of
                        rec."Transaction Type"::Armotised:
                            if rec.Amount > (Loans."Daily Interest" + Loans."Total Balance") then
                                error('The amount cannot be greater than the total loan balance');
                        rec."Transaction Type"::Repayment:
                            if rec.Amount > Loans."Outstanding Balance" then
                                error('The amount cannot be greater than the total loan balance');
                        rec."Transaction Type"::"Interest Paid":
                            if rec.Amount > Loans."Outstanding Interest" then
                                error('The amount cannot be greater than the total outstanding ');
                        else
                            Message('Please ensure you have selected the transaction type when dealing with loans');

                            error('Please ensure you have selected the transaction type');

                    end;
                end;
                if "W/Tax Rate" > 0 then begin
                    "Withholding Tax Amount" := (Amount * 100) / (100 - "W/Tax Rate");
                    "Total Amount Inc Tax W/held" := Amount + "Withholding Tax Amount";
                end;
            end;
        }
        field(21; Remarks; Text[250])
        {
        }
        field(22; "Transaction Name"; Text[100])
        {
        }
        field(23; "Branch Code"; Code[20])
        {
        }
        field(24; "Agent Code"; Code[20])
        {
        }
        field(25; Grouping; Code[20])
        {
            TableRelation = "Customer Posting Group".Code;
        }
        field(26; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));

            trigger OnValidate()
            begin

            end;
        }
        field(27; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(28; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(29; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(30; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(31; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";

            trigger OnValidate()
            begin
                if "Account Type" in ["Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"Bank Account"] then
                    TestField("VAT Bus. Posting Group", '');
                Validate("VAT Prod. Posting Group");
            end;
        }
        field(32; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";

            trigger OnValidate()
            begin
                if "Account Type" in ["Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"Bank Account"] then
                    TestField("VAT Prod. Posting Group", '');

                "VAT %" := 0;
                "VAT Calculation Type" := "VAT Calculation Type"::"Normal VAT";
                if "Gen. Posting Type" <> "Gen. Posting Type"::" " then begin
                    if not VATPostingSetup.Get("VAT Bus. Posting Group", "VAT Prod. Posting Group") then
                        VATPostingSetup.Init;
                    "VAT Calculation Type" := VATPostingSetup."VAT Calculation Type";
                    case "VAT Calculation Type" of
                        "VAT Calculation Type"::"Normal VAT":
                            "VAT %" := VATPostingSetup."VAT %";
                        "VAT Calculation Type"::"Full VAT":
                            case "Gen. Posting Type" of
                                "Gen. Posting Type"::Sale:
                                    begin
                                        VATPostingSetup.TestField("Sales VAT Account");
                                        TestField("Account No.", VATPostingSetup."Sales VAT Account");
                                    end;
                                "Gen. Posting Type"::Purchase:
                                    begin
                                        VATPostingSetup.TestField("Purchase VAT Account");
                                        TestField("Account No.", VATPostingSetup."Purchase VAT Account");
                                    end;
                            end;
                    end;
                end;
                Validate("VAT %");
            end;
        }
        field(33; "Gen. Posting Type"; Enum "General Posting Type")
        {
            Caption = 'Gen. Posting Type';
            // OptionCaption = ' ,Purchase,Sale,Settlement';
            // OptionMembers = " ",Purchase,Sale,Settlement;

            trigger OnValidate()
            begin
                if "Account Type" in ["Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"Bank Account"] then
                    TestField("Gen. Posting Type", "Gen. Posting Type"::" ");
                if ("Gen. Posting Type" = "Gen. Posting Type"::Settlement) and (CurrFieldNo <> 0) then
                    Error(Text001, "Gen. Posting Type");

                if "Gen. Posting Type" <> "General Posting Type"::" " then
                    Validate("VAT Prod. Posting Group");
            end;
        }
        field(34; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";

            trigger OnValidate()
            begin

                if "Account Type" in ["Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"Bank Account"] then
                    TestField("Gen. Bus. Posting Group", '');
                if xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" then
                    if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp, "Gen. Bus. Posting Group") then
                        Validate("VAT Bus. Posting Group", GenBusPostingGrp."Def. VAT Bus. Posting Group");
            end;
        }
        field(35; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate()
            begin

                if "Account Type" in ["Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"Bank Account"] then
                    TestField("Gen. Prod. Posting Group", '');
                if xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" then
                    if GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp, "Gen. Prod. Posting Group") then
                        Validate("VAT Prod. Posting Group", GenProdPostingGrp."Def. VAT Prod. Posting Group");
            end;
        }
        field(36; "VAT Calculation Type"; Enum "Tax Calculation Type")
        {
            Caption = 'VAT Calculation Type';
            Editable = false;
            // OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            // OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(37; "VAT Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Amount';
        }
        field(38; "Total Amount"; Decimal)
        {
            Editable = false;
        }
        field(39; "User ID"; Code[50])
        {
        }
        field(40; "Apply to"; Code[20])
        {
        }
        field(41; "Apply to ID"; Code[20])
        {
            Editable = true;
        }
        field(42; "Dest Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(43; "Dest Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(44; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(45; "Print No."; Integer)
        {
        }
        field(46; Status; Option)
        {
            OptionMembers = " ",Normal,"Post Dated",Posted;
        }
        field(47; "Deposit Slip Time"; Time)
        {

            trigger OnValidate()
            begin
                // CheckSlipDetails();
            end;
        }
        field(48; "Teller ID"; Code[50])
        {

            trigger OnValidate()
            begin
                // CheckSlipDetails();
            end;
        }
        field(49; "Customer Payment On Account"; Boolean)
        {
        }
        field(50; Select; Boolean)
        {
        }
        field(51; "Batch Posted"; Boolean)
        {
        }
        field(52; "Transaction No."; Code[20])
        {
        }
        field(53; "Cheque/Deposit Slip Bank"; Code[20])
        {
            TableRelation = "Payment Line Temp";
        }
        field(54; "Bank Account"; Code[30])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(55; Confirmed; Boolean)
        {
        }
        field(56; Reconciled; Boolean)
        {
        }
        field(57; "Orig. Cashier"; Code[50])
        {
            CalcFormula = Lookup("Receipts Header".Cashier WHERE("No." = FIELD(No)));
            FieldClass = FlowField;
        }
        field(58; Cancelled; Boolean)
        {
        }
        field(59; "Cancelled By"; Code[50])
        {
        }
        field(60; "Cancelled Date"; Date)
        {
        }
        field(61; "Cancelled Time"; Time)
        {
        }
        field(62; "Post Dated"; Boolean)
        {
        }
        field(63; "Cheque Retrieved"; Boolean)
        {
        }
        field(64; "Register Number"; Integer)
        {
        }
        field(65; "From Entry No"; Integer)
        {
        }
        field(66; "To Entry No"; Integer)
        {
        }
        field(67; "Batch Posted UserID"; Code[50])
        {
        }
        field(68; "BD Register Number"; Integer)
        {
        }
        field(69; "BD From Number"; Integer)
        {
        }
        field(70; "BD To Number"; Integer)
        {
        }
        field(71; "Reversal By"; Code[50])
        {
        }
        field(72; "Reversal Date"; Date)
        {
        }
        field(73; "Reversal Time"; Time)
        {
        }
        field(74; "Reversal Register No."; Integer)
        {
        }
        field(75; "Reversal From Entry No."; Integer)
        {
        }
        field(76; "Reversal To Entry No."; Integer)
        {
        }
        field(77; Reversed; Boolean)
        {
        }
        field(85; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(86; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';

            trigger OnLookup()
            var
                CustLedgEntry: Record "Cust. Ledger Entry";
                BilToCustNo: Code[20];
                OK: Boolean;
                Text000: Label 'You must specify %1 or %2.';
            begin
                //CODEUNIT.RUN(CODEUNIT::"Receipt Apply",Rec);
                if (Rec."Account Type" <> Rec."Account Type"::Customer) and (Rec."Account Type" <> Rec."Account Type"::Vendor) then
                    Error('You cannot apply to %1', "Account Type");

                with Rec do begin
                    Amount := 0;
                    Validate(Amount);
                    BilToCustNo := Rec."Account No.";
                    CustLedgEntry.SetCurrentKey("Customer No.", Open);
                    CustLedgEntry.SetRange("Customer No.", BilToCustNo);
                    CustLedgEntry.SetRange(Open, true);
                    if "Applies-to ID" = '' then
                        "Applies-to ID" := No;
                    if "Applies-to ID" = '' then
                        Error(
                          Text000,
                          FieldCaption(No), FieldCaption("Applies-to ID"));
                    ApplyCustEntries.SetReceipts(Rec, CustLedgEntry, Rec.FieldNo("Applies-to ID"));
                    ApplyCustEntries.SetRecord(CustLedgEntry);
                    ApplyCustEntries.SetTableView(CustLedgEntry);
                    ApplyCustEntries.LookupMode(true);
                    OK := ApplyCustEntries.RunModal = ACTION::LookupOK;
                    Clear(ApplyCustEntries);
                    if not OK then
                        exit;
                    CustLedgEntry.Reset;
                    CustLedgEntry.SetCurrentKey("Customer No.", Open);
                    CustLedgEntry.SetRange("Customer No.", BilToCustNo);
                    CustLedgEntry.SetRange(Open, true);
                    CustLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                    if CustLedgEntry.Find('-') then begin
                        "Applies-to Doc. Type" := 0;
                        "Applies-to Doc. No." := '';
                    end else
                        "Applies-to ID" := '';

                end;
                //Calculate Total Amount
                CustLedgEntry.Reset;
                CustLedgEntry.SetCurrentKey("Customer No.", Open, "Applies-to ID");
                CustLedgEntry.SetRange("Customer No.", BilToCustNo);
                CustLedgEntry.SetRange(Open, true);
                CustLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                if CustLedgEntry.Find('-') then begin
                    CustLedgEntry.CalcSums(CustLedgEntry."Amount to Apply");
                    Amount := Abs(CustLedgEntry."Amount to Apply");
                    Validate(Amount);
                end;
            end;

            trigger OnValidate()
            begin

                if ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and (xRec."Applies-to Doc. No." <> '') and
                   ("Applies-to Doc. No." <> '')
                then begin
                    SetAmountToApply("Applies-to Doc. No.", "Account No.");
                    SetAmountToApply(xRec."Applies-to Doc. No.", "Account No.");
                end else
                    if ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and (xRec."Applies-to Doc. No." = '') then
                        SetAmountToApply("Applies-to Doc. No.", "Account No.")
                    else
                        if ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and ("Applies-to Doc. No." = '') then
                            SetAmountToApply(xRec."Applies-to Doc. No.", "Account No.");
            end;
        }
        field(87; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';

            trigger OnValidate()
            var
                TempCustLedgEntry: Record "Cust. Ledger Entry";
            begin
                if ("Applies-to ID" <> xRec."Applies-to ID") and (xRec."Applies-to ID" <> '') then begin
                    CustLedgEntry.SetCurrentKey("Customer No.", Open);
                    CustLedgEntry.SetRange("Customer No.", "Account No.");
                    CustLedgEntry.SetRange(Open, true);
                    CustLedgEntry.SetRange("Applies-to ID", xRec."Applies-to ID");
                    if CustLedgEntry.FindFirst then
                        CustEntrySetApplID.SetApplId(CustLedgEntry, TempCustLedgEntry, '');
                    CustLedgEntry.Reset;
                end;
            end;
        }
        field(88; "Grant No"; Code[20])
        {
        }
        field(89; "Installment Number"; Integer)
        {
        }
        field(90; "Next Installment Date"; Date)
        {
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ;
            end;
        }
        field(483; "Group Code"; Code[20])
        {
            Description = '//Added by Kigen--Lookup to members -- To gather for Micro Credit Groups to filter its members';
            TableRelation = Members."No." WHERE("Account Type" = FILTER(<> "Single Member Account"));
        }
        field(50000; Donor; Code[30])
        {
        }
        field(39005480; "Loan No."; Code[20])
        {
            TableRelation = Loans."Loan No." WHERE("Loan Account" = FIELD("Account No."), "Total Balance" = filter(> 0));
            trigger OnValidate()
            begin
                if "Loan No." <> '' then begin
                    //  rec.TestField("Transaction Type");
                    Loans.Get("Loan No.");
                    Loans.calcfields("Outstanding Balance", "Outstanding Interest", "Daily Interest", Loans."Total Balance");
                    "Loan Oustanding Principal" := Loans."Outstanding Balance";
                    "Loan Outstanding Interest" := Loans."Outstanding Interest";
                    "Total Outstanding Loan" := Loans."Total Balance";
                    "Daily Interest" := Loans."Daily Interest";
                    "Amount Payable" := Loans.Repayment;

                    if rec."Transaction Type" = rec."Transaction Type"::Armotised then
                        rec.Amount := Loans."Daily Interest" + Loans."Total Balance";

                    Rec.Validate(Amount);
                end;
            end;
        }
        field(39005481; "Transaction Type"; Enum "Transaction Types")
        {
            valuesallowed = " ", Repayment, "Interest Paid", Armotised;
            trigger OnValidate()
            begin
                rec.validate("Loan No.");
                rec.Validate(Amount);
            end;

        }
        field(39005482; "Loan Oustanding Principal"; Decimal)
        {
        }
        field(39005483; "Loan Outstanding Interest"; Decimal)
        {
        }
        field(39005484; "Total Outstanding Loan"; Decimal)
        {
            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(39005485; "Description"; text[100])
        {
        }
        field(39005486; "Daily Interest"; Decimal)
        {
        }
        field(39005487; "Clear Loan"; Boolean)
        { }
        field(39005488; "Withholding Tax Amount"; Decimal)
        {
        }
        field(39005489; "Withholding Tax Code"; code[20])
        {
            trigger OnValidate()
            begin
                if TariffCode.Get("Withholding Tax Code") then
                    "W/Tax Rate" := TariffCode.Percentage
                else
                    "W/Tax Rate" := 0;
            end;
        }
        field(39005490; "W/Tax Rate"; Decimal)
        {
        }
        field(39005491; "Total Amount Inc Tax W/held"; Decimal)
        {
        }
        field(39005492; "Bank Name"; Text[100])
        {
        }
        field(39005493; "Amount Payable"; Decimal)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Line No.", No)
        {
            Clustered = true;
            SumIndexFields = Amount, "Total Amount";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Posted = true then
            Error('The transaction has already been posted and therefore cannot be modified.');
    end;

    trigger OnInsert()
    begin
        RHead.Reset;
        RHead.SetRange(RHead."No.", No);
        if RHead.FindFirst then begin
            RHead.TestField("Responsibility Center");
            "Global Dimension 1 Code" := RHead."Global Dimension 1 Code";
            "Shortcut Dimension 2 Code" := RHead."Shortcut Dimension 2 Code";
            "Dimension Set ID" := RHead."Dimension Set ID";
            Description := RHead.Dim4;
            "Cheque/Deposit Slip No" := Rhead."Cheque No.";
            //"Cheque/Deposit Slip Date" := Rhead.Posting
        end;
    end;

    trigger OnModify()
    begin

        RHead.Reset;
        RHead.SetRange(RHead."No.", No);
        if RHead.FindFirst then begin
            "Global Dimension 1 Code" := RHead."Global Dimension 1 Code";
            "Shortcut Dimension 2 Code" := RHead."Shortcut Dimension 2 Code";
            //    "Dimension Set ID":=RHead."Dimension Set ID";
            if RHead.Posted then
                Error('The transaction has already been posted and therefore cannot be modified.');
        end;

        /* IF (Posted=TRUE) AND ("Customer Payment On Account"=FALSE)  THEN
         ERROR('The transaction has already been posted and therefore cannot be modified.');
         IF (Posted=TRUE) AND ("Customer Payment On Account"=TRUE)  AND ("Batch Posted"=TRUE) THEN
         ERROR('The transaction has already been posted and therefore cannot be modified.');*/

    end;

    trigger OnRename()
    begin
        if Posted = true then
            Error('The transaction has already been posted and therefore cannot be modified.');
    end;

    var
        GLAcc: Record "G/L Account";
        Cust: Record Customer;
        Vend: Record Vendor;
        FA: Record "Fixed Asset";
        BankAcc: Record "Bank Account";
        SavingsAcc: Record "Savings Accounts";
        CreditAcc: Record "Credit Accounts";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        GenLedgerSetup: Record "Cash Office Setup";
        RecPayTypes: Record "Receipts and Payment Types";
        VATPostingSetup: Record "VAT Posting Setup";
        Text001: Label 'The %1 option can only be used internally in the system.';
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        GenProdPostingGrp: Record "Gen. Product Posting Group";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        Cust2: Record Customer;
        Vend2: Record Vendor;
        BankAcc2: Record "Bank Account";
        BankAcc3: Record "Bank Account";
        Text002: Label 'LCY';
        VATSetup: Record "VAT Posting Setup";
        RecLine: Record "Receipt Line";
        SRSetup: Record "Sales & Receivables Setup";
        ICPartner: Record "IC Partner";
        RHead: Record "Receipts Header";
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustEntrySetApplID: Codeunit "Cust. Entry-SetAppl.ID";
        ApplyCustEntries: Page "Apply Customer Entries";
        DimMgt: Codeunit DimensionManagement;
        Loans: record Loans;
        TariffCode: Record "Tariff Code s";

    local procedure SetCurrencyCode(AccType2: Option "G/L Account",Customer,Vendor,"Bank Account"; AccNo2: Code[20]): Boolean
    begin
        "Currency Code" := '';
        if AccNo2 <> '' then
            case AccType2 of
                AccType2::Customer:
                    if Cust2.Get(AccNo2) then
                        "Currency Code" := Cust2."Currency Code";
                AccType2::Vendor:
                    if Vend2.Get(AccNo2) then
                        "Currency Code" := Vend2."Currency Code";
                AccType2::"Bank Account":
                    if BankAcc2.Get(AccNo2) then
                        "Currency Code" := BankAcc2."Currency Code";
            end;
        exit("Currency Code" <> '');
    end;

    local procedure GetCurrency()
    begin
    end;

    // [Scope('OnPrem')]
    procedure GetShowCurrencyCode(CurrencyCode: Code[10]): Code[10]
    begin
        if CurrencyCode <> '' then
            exit(CurrencyCode)
        else
            exit(Text002);
    end;

    // [Scope('OnPrem')]
    procedure CheckSlipDetails()
    var
        IsExistent: Boolean;
    begin
        //this function checks the details on the deposit slip to ensure no double presentation of slips
        //the checks will be the slip date,slip no,slip time and teller and the account

        IsExistent := false;

        case "Pay Mode" of
            "Pay Mode"::"Deposit Slip", "Pay Mode"::Cheque:
                begin
                    //reset the variable for holding the records
                    RecLine.Reset;
                    //RecLine.SETRANGE(RecLine."Account Type","Account Type");
                    //RecLine.SETRANGE(RecLine."Account No.","Account No.");
                    RecLine.SetRange(RecLine."Pay Mode", "Pay Mode");
                    RecLine.SetRange(RecLine."Cheque/Deposit Slip Type", "Cheque/Deposit Slip Type");
                    RecLine.SetRange(RecLine."Cheque/Deposit Slip No", "Cheque/Deposit Slip No");
                    RecLine.SetRange(RecLine."Cheque/Deposit Slip Date", "Cheque/Deposit Slip Date");
                    RecLine.SetRange(RecLine."Deposit Slip Time", "Deposit Slip Time");
                    RecLine.SetRange(RecLine."Teller ID", "Teller ID");
                    //check if there is a record with the same details
                    if RecLine.Find('-') then begin
                        repeat
                            if (RecLine."Line No." <> "Line No.") then begin
                                IsExistent := true;
                            end;
                        until RecLine.Next = 0;
                    end;
                end;
        end;
        //ask for user confirmation is the IsExistent
        if IsExistent then begin
            if Confirm('Bank Deposit Slip(s) with the same details exist. Continue?', false) = false then begin
                Error('Operation Cancelled by User Interrupt');
            end;
        end;
    end;

    // [Scope('OnPrem')]
    procedure SetAmountToApply(AppliesToDocNo: Code[20]; CustomerNo: Code[20])
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgEntry.SetCurrentKey("Document No.");
        CustLedgEntry.SetRange("Document No.", AppliesToDocNo);
        CustLedgEntry.SetRange("Customer No.", CustomerNo);
        CustLedgEntry.SetRange(Open, true);
        if CustLedgEntry.FindFirst then begin
            if CustLedgEntry."Amount to Apply" = 0 then begin
                CustLedgEntry.CalcFields("Remaining Amount");
                CustLedgEntry."Amount to Apply" := CustLedgEntry."Remaining Amount";
            end else
                CustLedgEntry."Amount to Apply" := 0;
            CustLedgEntry."Accepted Payment Tolerance" := 0;
            CustLedgEntry."Accepted Pmt. Disc. Tolerance" := false;
            CODEUNIT.Run(CODEUNIT::"Cust. Entry-Edit", CustLedgEntry);
        end;
    end;

    // [Scope('OnPrem')]
    procedure ShowDimensions()
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', 'Receipt', "Line No."));
        //VerifyItemLineDim;
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    // [Scope('OnPrem')]
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    // [Scope('OnPrem')]
    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);

    end;

    // [Scope('OnPrem')]
    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    // [Scope('OnPrem')]
    procedure CreateDim(Type1: Integer; No1: Code[20])
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        OldDimSetID: Integer;
    begin
        SourceCodeSetup.Get;
        TableID[1] := Type1;
        No[1] := No1;
        /*
        TableID[2] := Type2;
        No[2] := No2;
        TableID[3] := Type3;
        No[3] := No3;
        TableID[4] := Type4;
        No[4] := No4;
        */
        "Global Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        OldDimSetID := "Dimension Set ID";

    end;

}

