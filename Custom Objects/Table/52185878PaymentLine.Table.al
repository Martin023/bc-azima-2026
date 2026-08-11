table 52185878 "Payment Line"
{
    DrillDownPageID = "Payment Lines";
    LookupPageID = "Payment Lines";

    fields
    {
        field(1; No; Code[20])
        {
            NotBlank = true;
        }
        field(2; Date; Date)
        {
        }
        field(3; Type; Code[20])
        {
            NotBlank = true;
            TableRelation = "Receipts and Payment Types".Code WHERE(Type = FILTER(Payment),
                                                                     Blocked = CONST(false));

            trigger OnValidate()
            var
                TarrifCode: Record "Tariff Code s";
            begin

                "Account No." := '';
                "Account Name" := '';
                Remarks := '';
                Amount := 0;

                RecPayTypes.Reset;
                RecPayTypes.SetRange(RecPayTypes.Code, Type);
                RecPayTypes.SetRange(RecPayTypes.Type, RecPayTypes.Type::Payment);

                if RecPayTypes.Find('-') then begin
                    Grouping := RecPayTypes."Default Grouping";
                    "Require Surrender" := RecPayTypes."Pending Voucher";
                    "Payment Reference" := RecPayTypes."Payment Reference";
                    "Budgetary Control A/C" := RecPayTypes."Direct Expense";
                    "VAT Deductible" := RecPayTypes."VAT Deductible";

                    if RecPayTypes."VAT Chargeable" = RecPayTypes."VAT Chargeable"::Yes then begin
                        "VAT Code" := RecPayTypes."VAT Code";
                        if TarrifCode.Get("VAT Code") then
                            "VAT Rate" := TarrifCode.Percentage;
                    end;
                    if RecPayTypes."Withholding Tax Chargeable" = RecPayTypes."Withholding Tax Chargeable"::Yes then begin
                        "Withholding Tax Code" := RecPayTypes."Withholding Tax Code";
                        if TarrifCode.Get("Withholding Tax Code") then
                            "W/Tax Rate" := TarrifCode.Percentage;
                    end;


                    if RecPayTypes."VAT Chargeable" = RecPayTypes."VAT Chargeable"::Yes then begin
                        "VAT Withholding Code" := RecPayTypes."VAT Withholding Code";
                        if TarrifCode.Get("VAT Withholding Code") then
                            "VAT Withholding Rate" := TarrifCode.Percentage;
                    end;


                    if RecPayTypes."Calculate Retention" = RecPayTypes."Calculate Retention"::Yes then begin
                        "Retention Code" := RecPayTypes."Retention Code";
                        if TarrifCode.Get("Retention Code") then
                            "Retention Rate" := TarrifCode.Percentage;
                    end;
                end;

                if RecPayTypes.Find('-') then begin
                    "Account Type" := RecPayTypes."Account Type";
                    Validate("Account Type");
                    "Transaction Name" := RecPayTypes.Description;
                    "Budgetary Control A/C" := RecPayTypes."Direct Expense";
                    if RecPayTypes."Account Type" = RecPayTypes."Account Type"::"G/L Account" then begin
                        if RecPayTypes."G/L Account" <> '' then
                            RecPayTypes.TestField(RecPayTypes."G/L Account");
                        "Account No." := RecPayTypes."G/L Account";
                        Validate("Account No.");
                    end;
                    //Banks
                    if RecPayTypes."Account Type" = RecPayTypes."Account Type"::"Bank Account" then begin
                        "Account No." := RecPayTypes."Bank Account";
                        Validate("Account No.");
                    end;
                end;

                PHead.Reset;
                PHead.SetRange(PHead."No.", No);
                if PHead.FindFirst then begin
                    Date := PHead.Date;
                    PHead.TestField("Responsibility Center");
                    "Global Dimension 1 Code" := PHead."Global Dimension 1 Code";
                    //"Global Dimension 2 Code" := PHead."Global Dimension 2 Code";
                    "Shortcut Dimension 2 Code" := PHead."Shortcut Dimension 2 Code";
                    //"Shortcut Dimension 3 Code":=PHead."Shortcut Dimension 3 Code";
                    //"Shortcut Dimension 4 Code":=PHead."Shortcut Dimension 4 Code";
                    "Dimension Set ID" := PHead."Dimension Set ID";
                    "Currency Code" := PHead."Currency Code";
                    "Currency Factor" := PHead."Currency Factor";
                    "Payment Type" := PHead."Payment Type";
                end;
            end;
        }
        field(4; "Pay Mode"; Option)
        {
            OptionMembers = " ",Cash,Cheque,EFT,"Custom 2","Custom 3","Custom 4","Custom 5";
        }
        field(5; "Cheque No"; Code[20])
        {
        }
        field(6; "Cheque Date"; Date)
        {
        }

        field(666; "Document Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Cust: Record Members;
                Vend: Record Vendor;
            begin
            end;
        }
        field(7; "Cheque Type"; Code[20])
        {
        }
        field(8; "Bank Code"; Code[20])
        {
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
            // OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Savings,Credit';
            // OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Savings,Credit;

            trigger OnValidate()
            var
                PayLines: Record "Payment Line";
            begin
                /*
                   PayLines.RESET;
                   PayLines.SETRANGE(PayLines."Account Type",PayLines."Account Type"::Vendor);
                   PayLines.SETRANGE(PayLines.No,No);
                   IF PayLines.FIND('-') THEN
                      ERROR('There is already another existing Payment to a Vendor in this document');
                
                   PayLines.RESET;
                   PayLines.SETRANGE(PayLines."Account Type",PayLines."Account Type"::Customer);
                   PayLines.SETRANGE(PayLines.No,No);
                   IF PayLines.FIND('-') THEN
                      ERROR('There is already another existing Payment to a Customer in this document');
                
                   IF ("Account Type"= "Account Type"::Vendor) OR  ("Account Type"= "Account Type"::Customer) THEN  BEGIN
                      IF PayLinesExist THEN
                      ERROR('There is already another existing Line for this document');
                   END;
                */

            end;
        }
        field(13; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Direct Posting" = CONST(true),
                                                                                          "Account Type" = CONST(Posting),
                                                                                          Blocked = CONST(false),
                                                                                          "Expense Code" = FIELD(Grouping))
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer// WHERE("Customer Posting Group" = FIELD(Grouping))
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor WHERE("Vendor Posting Group" = FIELD(Grouping))
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Account Type" = CONST("IC Partner")) "IC Partner"
            ELSE
            IF ("Account Type" = CONST(Savings)) "Savings Accounts"
            ELSE
            IF ("Account Type" = CONST(Credit)) "Credit Accounts";

            trigger OnValidate()
            var
                Text0001: Label 'The Account number CANNOT be the same as the Paying Bank Account No.';
            begin
                PH.Reset;
                PH.Get(No);
                "Account Name" := '';
                RecPayTypes.Reset;
                RecPayTypes.SetRange(RecPayTypes.Code, Type);
                RecPayTypes.SetRange(RecPayTypes.Type, RecPayTypes.Type::Payment);

                if "Account Type" in ["Account Type"::"G/L Account", "Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"IC Partner",
                "Account Type"::"Bank Account", "Account Type"::Savings, "Account Type"::Credit]
                then
                    case "Account Type" of
                        "Account Type"::"G/L Account":
                            begin
                                if "Account No." <> '' then
                                    GLAcc.Get("Account No.");
                                "Account Name" := GLAcc.Name;
                                PH.TestField("Global Dimension 1 Code");
                                PH.TestField("Shortcut Dimension 2 Code");
                                //"Global Dimension 1 Code":='';
                                //"Shortcut Dimension 2 Code":='';
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
                                Vend.calcfields("Balance (LCY)");
                                if Vend."Balance (LCY)" <= 0 then
                                    Error('The Vendor Account has a credit/no outstanding balance of ' + FORMAT(Vend."Balance (LCY)") +
                                          ' Please confirm the Payment Account before proceeding');

                                "Account Name" := Vend.Name;
                                if "Global Dimension 1 Code" = '' then begin
                                    "Global Dimension 1 Code" := Vend."Global Dimension 1 Code";
                                end;
                                if PH.Payee = '' then begin
                                    PH.Payee := "Account Name";
                                    PH."Vendor KRA PIN" := Vend."KRA Pin No.";
                                    PH."Vendor Contacts" := Vend.Contact;
                                    PH.Modify;
                                end;
                                if PH."On Behalf Of" = '' then begin
                                    PH."On Behalf Of" := "Account Name";
                                    PH.Modify;
                                end;
                            end;
                        "Account Type"::"Bank Account":
                            begin
                                if BankAcc.Get("Account No.") then
                                    "Account Name" := BankAcc.Name;
                                PH.TestField("Paying Bank Account");
                                if PH."Paying Bank Account" = "Account No." then
                                    Error(Text0001);
                                if "Global Dimension 1 Code" = '' then begin
                                    "Global Dimension 1 Code" := BankAcc."Global Dimension 1 Code";
                                end;
                            end;
                        "Account Type"::"IC Partner":
                            begin
                                ICPartner.Reset;
                                ICPartner.Get("Account No.");
                                "Account Name" := ICPartner.Name;
                            end;
                        "Account Type"::Savings:
                            begin
                                SavingsAccounts.Get("Account No.");
                                "Account Name" := SavingsAccounts.Name;
                            end;
                        "Account Type"::Credit:
                            begin
                                CreditAccounts.Get("Account No.");
                                "Account Name" := CreditAccounts.Name;
                            end;
                    end;

                //Set the application to Invoice if Account type is vendor
                if "Account Type" = "Account Type"::Vendor then begin
                    "Applies-to Doc. Type" := "Applies-to Doc. Type"::Invoice;
                end;

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
                CalculateTax();
            end;
        }
        field(21; Remarks; Text[250])
        {
        }
        field(22; "Transaction Name"; Text[100])
        {
        }
        field(23; "VAT Code"; Code[20])
        {
            TableRelation = "Tariff Code s".Code WHERE(Type = CONST(VAT));

            trigger OnValidate()
            begin
                if TariffCode.Get("VAT Code") then
                    "VAT Rate" := TariffCode.Percentage
                else
                    "VAT Rate" := 0;
                rec.Validate(Amount);
                // CalculateTax();
            end;
        }
        field(24; "Withholding Tax Code"; Code[20])
        {
            TableRelation = "Tariff Code s".Code WHERE(Type = CONST("W/Tax"));

            trigger OnValidate()
            begin
                if TariffCode.Get("Withholding Tax Code") then
                    "W/Tax Rate" := TariffCode.Percentage
                else
                    "W/Tax Rate" := 0;

                rec.Validate(Amount);

                // CalculateTax();
                // MESSAGE(FORMAT("VAT Withholding Amount"));
                // MESSAGE(FORMAT("Net Amount"));
            end;
        }
        field(25; "VAT Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                //Should not be entered until VAT Code is entered
                /*
                TESTFIELD("VAT Code");
                "Net Amount":=Amount-("VAT Withholding Amount"+"Withholding Tax Amount");
                 VALIDATE("Net Amount");
              */

            end;
        }
        field(26; "Withholding Tax Amount"; Decimal)
        {

            trigger OnLookup()
            begin
                PHead.Reset;
                PHead.SetRange(PHead."No.", No);
                if PHead.FindFirst then begin
                    if (PHead.Status = PHead.Status::Approved) or (PHead.Status = PHead.Status::Posted) or
                     (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled) then
                        Error('You Cannot modify documents that are approved/posted/Send for Approval');
                end;
            end;

            trigger OnValidate()
            begin
                //Should not be entered until W/Tax code is entered
                TestField("Withholding Tax Code");
                PHead.Reset;
                PHead.SetRange(PHead."No.", No);
                if PHead.FindFirst then begin
                    if (PHead.Status = PHead.Status::Approved) or (PHead.Status = PHead.Status::Posted) or
                     (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled) then
                        Error('You Cannot modify documents that are approved/posted/Send for Approval');
                end;
                /*
                  "Net Amount":=Amount-("Withholding Tax Amount"+"VAT Withholding Amount");
                   VALIDATE("Net Amount");
                */

            end;
        }
        field(27; "Net Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                //MESSAGE('"Currency Factor"::'+ FORMAT("Currency Factor"));
                if "Currency Factor" <> 0 then
                    "NetAmount LCY" := "Net Amount" / "Currency Factor"
                else
                    "NetAmount LCY" := "Net Amount";
            end;
        }
        field(28; "Paying Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(29; Payee; Text[100])
        {
        }
        field(30; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));

            trigger OnValidate()
            begin

                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 1);
                DimVal.SetRange(DimVal.Code, "Global Dimension 1 Code");
                if DimVal.Find('-') then
                    "Function Name" := DimVal.Name;


                //"Dimension Set ID" := DimMgt.GetDimSetFilter();
            end;
        }
        field(31; "Branch Code"; Code[20])
        {
            Description = 'NOt in use please us the shortcut dimension 2 below';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin

                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Branch Code");
                if DimVal.Find('-') then
                    "Budget Center Name" := DimVal.Name;

                // ValidateShortcutDimCode(2, "Branch Code");
                //s"Dimension Set ID" := DimMgt.GetDimSetFilter(2,"Shortcut Dimension 2 Code","Dimension Set ID");
            end;
        }
        field(32; "PO/INV No"; Code[20])
        {
        }
        field(33; "Bank Account No"; Code[20])
        {
        }
        field(34; "Cashier Bank Account"; Code[20])
        {
        }
        field(35; Status; Option)
        {
            OptionMembers = Pending,"1st Approval","2nd Approval","Cheque Printing",Posted,Cancelled,Checking,VoteBook;
        }
        field(36; Select; Boolean)
        {
        }
        field(37; Grouping; Code[20])
        {
            TableRelation = IF ("Account Type" = CONST(Vendor)) "Vendor Posting Group".Code
            ELSE
            IF ("Account Type" = CONST("G/L Account")) "Expense Code".Code
            ELSE
            IF ("Account Type" = CONST(Customer)) "Customer Posting Group".Code;
        }
        field(38; "Payment Type"; Option)
        {
            OptionMembers = Normal,"Petty Cash";
        }
        field(39; "Bank Type"; Option)
        {
            OptionMembers = Normal,"Petty Cash";
        }
        field(40; "PV Type"; Option)
        {
            OptionMembers = Normal,Other;
        }
        field(41; "Apply to"; Code[20])
        {
            TableRelation = "Vendor Ledger Entry"."Vendor No." WHERE("Vendor No." = FIELD("Account No."));
        }
        field(42; "Apply to ID"; Code[20])
        {
        }
        field(43; "No of Units"; Decimal)
        {
        }
        field(44; "Surrender Date"; Date)
        {
        }
        field(45; Surrendered; Boolean)
        {
        }
        field(46; "Surrender Doc. No"; Code[20])
        {
        }
        field(47; "Vote Book"; Code[10])
        {
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                /*
                          IF Amount<=0 THEN
                        ERROR('Please enter the Amount');
                
                       //Confirm the Amount to be issued doesnot exceed the budget and amount Committed
                        EVALUATE(CurrMonth,FORMAT(DATE2DMY(Date,2)));
                        EVALUATE(CurrYR,FORMAT(DATE2DMY(Date,3)));
                        EVALUATE(BudgetDate,FORMAT('01'+'/'+CurrMonth+'/'+CurrYR));
                
                          //Get the last day of the month
                
                          LastDay:=CALCDATE('1M', BudgetDate);
                          LastDay:=CALCDATE('-1D',LastDay);
                
                
                        //Get Budget for the G/L
                      IF GenLedSetup.GET THEN BEGIN
                        GLAccount.SETFILTER(GLAccount."Budget Filter",GenLedSetup."Current Budget");
                        GLAccount.SETRANGE(GLAccount."No.","Vote Book");
                        GLAccount.CALCFIELDS(GLAccount."Budgeted Amount",GLAccount."Net Change");
                        {Get the exact Monthly Budget}
                        //Start from first date of the budget.//BudgetDate
                        GLAccount.SETRANGE(GLAccount."Date Filter",GenLedSetup."Current Budget Start Date",LastDay);
                
                        IF GLAccount.FIND('-') THEN BEGIN
                         GLAccount.CALCFIELDS(GLAccount."Budgeted Amount",GLAccount."Net Change");
                         MonthBudget:=GLAccount."Budgeted Amount";
                         Expenses:=GLAccount."Net Change";
                         BudgetAvailable:=GLAccount."Budgeted Amount"-GLAccount."Net Change";
                         "Total Allocation":=MonthBudget;
                         "Total Expenditure":=Expenses;
                         END;
                
                
                     END;
                
                     CommitmentEntries.RESET;
                     CommitmentEntries.SETCURRENTKEY(CommitmentEntries.Account);
                     CommitmentEntries.SETRANGE(CommitmentEntries.Account,"Vote Book");
                     CommitmentEntries.SETRANGE(CommitmentEntries."Commitment Date",GenLedSetup."Current Budget Start Date",LastDay);
                     CommitmentEntries.CALCSUMS(CommitmentEntries."Committed Amount");
                     CommittedAmount:=CommitmentEntries."Committed Amount";
                
                     "Total Commitments":=CommittedAmount;
                     Balance:=BudgetAvailable-CommittedAmount;
                     "Balance Less this Entry":=BudgetAvailable-CommittedAmount-Amount;
                     MODIFY;
                     {
                     IF CommittedAmount+Amount>BudgetAvailable THEN
                        ERROR('%1,%2,%3,%4','You have Exceeded Budget for G/L Account No',"Vote Book",'by',
                        ABS(BudgetAvailable-(CommittedAmount+Amount)));
                      }
                     //End of Confirming whether Budget Allows Posting
                */

            end;
        }
        field(48; "Total Allocation"; Decimal)
        {
        }
        field(49; "Total Expenditure"; Decimal)
        {
        }
        field(50; "Total Commitments"; Decimal)
        {
        }
        field(51; Balance; Decimal)
        {
        }
        field(52; "Balance Less this Entry"; Decimal)
        {
        }
        field(53; "Applicant Designation"; Text[100])
        {
        }
        field(54; "Petty Cash"; Boolean)
        {
        }
        field(55; "Supplier Invoice No."; Code[30])
        {
        }
        field(56; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Branch Code");
                if DimVal.Find('-') then
                    "Budget Center Name" := DimVal.Name;



                //"Dimension Set ID" := DimMgt.GetDimSetFilter(2,"Shortcut Dimension 2 Code","Dimension Set ID");
            end;
        }
        field(57; "Imprest Request No"; Code[20])
        {

            trigger OnValidate()
            begin

                /*
                          TotAmt:=0;
                     //On Delete/Change of Request No. then Clear from Imprest Details
                     IF ("Imprest Request No"='') OR ("Imprest Request No"<>xRec."Imprest Request No") THEN
                        LoadImprestDetails.RESET;
                        LoadImprestDetails.SETRANGE(LoadImprestDetails.No,No);
                        IF LoadImprestDetails.FIND('-') THEN BEGIN
                           LoadImprestDetails.DELETEALL;
                           Amount:=TotAmt;
                           "Net Amount":=Amount;
                           MODIFY;
                
                        END;
                     //New Imprest Details
                     ImprestReqDet.RESET;
                     ImprestReqDet.SETRANGE(ImprestReqDet.No,"Imprest Request No");
                     IF ImprestReqDet.FIND('-') THEN BEGIN
                     REPEAT
                         LoadImprestDetails.INIT;
                         LoadImprestDetails.No:=No;
                         LoadImprestDetails.Date:=ImprestReqDet."Account No:";
                         LoadImprestDetails.Type:=ImprestReqDet."Account Name";
                         LoadImprestDetails."Pay Mode":=ImprestReqDet.Amount;
                         LoadImprestDetails."Cheque No":=ImprestReqDet."Due Date";
                         LoadImprestDetails."Cheque Date":=ImprestReqDet."Imprest Holder";
                         LoadImprestDetails.INSERT;
                         TotAmt:=TotAmt+ImprestReqDet.Amount;
                     UNTIL ImprestReqDet.NEXT=0;
                         Amount:=TotAmt;
                         "Account No.":=ImprestReqDet."Imprest Holder";
                         "Net Amount":=Amount;
                         MODIFY;
                     END;
                {
                       //ImprestDetForm.GETRECORD(LoadImprestDetails);
                }
                      */

            end;
        }
        field(58; "Batched Imprest Tot"; Decimal)
        {
            FieldClass = Normal;
        }
        field(59; "Function Name"; Text[100])
        {
        }
        field(60; "Budget Center Name"; Text[100])
        {
        }
        field(61; "Farmer Purchase No"; Code[20])
        {
        }
        field(62; "Transporter Ananlysis No"; Code[20])
        {
        }
        field(63; "User ID"; Code[20])
        {
            // TableRelation = Table2000000002.Field1;
        }
        field(64; "Journal Template"; Code[20])
        {
        }
        field(65; "Journal Batch"; Code[20])
        {
        }
        field(66; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(67; "Require Surrender"; Boolean)
        {
            Editable = false;
        }
        field(68; "Commited Ammount"; Decimal)
        {
            FieldClass = FlowFilter;
            // TableRelation = Table50019.Field4;
        }
        field(69; "Select to Surrender"; Boolean)
        {
        }
        field(71; "Payment Reference"; Option)
        {
            OptionMembers = Normal,"Farmer Purchase";
        }
        field(72; "ID Number"; Code[8])
        {
        }
        field(73; "VAT Rate"; Decimal)
        {

            trigger OnValidate()
            begin
                /*"VAT Amount":=(Amount * 100);
                "VAT Amount":=Amount-("VAT Amount"/(100 + "VAT Rate"));*/

            end;
        }
        field(74; "Amount With VAT"; Decimal)
        {
        }
        field(75; "Currency Code"; Code[20])
        {
        }
        field(76; "Exchange Rate"; Decimal)
        {
        }
        field(77; "Currency Reciprical"; Decimal)
        {
        }
        field(78; "VAT Prod. Posting Group"; Code[20])
        {
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "VAT Product Posting Group".Code;
        }
        field(79; "Budgetary Control A/C"; Boolean)
        {
        }
        field(83; Committed; Boolean)
        {
        }
        field(84; "Currency Factor"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Currency Factor" <> 0 then
                    "NetAmount LCY" := "Net Amount" / "Currency Factor"
                else
                    "NetAmount LCY" := "Net Amount";
            end;
        }
        field(85; "NetAmount LCY"; Decimal)
        {
        }
        field(86; "Applies-to Doc. Type"; Enum "Gen. Journal Document Type")
        {
            /*  Caption = 'Applies-to Doc. Type';
             // OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
              // OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;

              trigger OnLookup()
              begin
                  PHead.Reset;
                  PHead.SetRange(PHead."No.", No);
                  if PHead.FindFirst then begin
                      if (PHead.Status = PHead.Status::Approved) or (PHead.Status = PHead.Status::Posted) or
                       (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled) then
                          Error('You Cannot modify documents that are approved/posted/Send for Approval');
                  end;
              end;

              trigger OnValidate()
              begin
                  PHead.Reset;
                  PHead.SetRange(PHead."No.", No);
                  if PHead.FindFirst then begin
                      if (PHead.Status = PHead.Status::Approved) or (PHead.Status = PHead.Status::Posted) or
                       (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled) then
                          Error('You Cannot modify documents that are approved/posted/Send for Approval');
                  end;
              end;
              */
            Caption = 'Applies-to Doc. Type';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Applies-to Doc. Type" <> xRec."Applies-to Doc. Type" then
                    Validate("Applies-to Doc. No.", '');
            end;
        }
        field(87; "Applies-to Doc. No."; Code[50])
        {
            Caption = 'Applies-to Doc. No.';
            DataClassification = ToBeClassified;

            trigger OnLookup()
            var
                PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
                AccType: Enum "Gen. Journal Account Type";

                AccNo: Code[20];
            begin
                xRec.Amount := Amount;
                //xRec."Currency Code" := "Currency Code";
                xRec.Date := Date;

                //GetAccTypeAndNo(Rec,AccType,AccNo);
                AccType := "Account Type";
                AccNo := "Account No.";

                Clear(CustLedgEntry);
                Clear(VendLedgEntry);

                case AccType of
                    Acctype::Customer:
                        LookUpAppliesToDocCust(AccNo);
                    Acctype::Vendor:
                        LookUpAppliesToDocVend(AccNo);
                //Acctype::Employee:
                //   LookUpAppliesToDocEmpl(AccNo);
                end;

                //SetJournalLineFieldsFromApplication;

                ////if xRec.Amount <> 0 then
                //if not PaymentToleranceMgt.PmtTolDocumentLine(Rec) then
                //  exit;

                if "Applies-to Doc. Type" = "applies-to doc. type"::Invoice then
                    UpdateAppliesToInvoiceID;
            end;

            trigger OnValidate()
            var
                CustLedgEntry: Record "Cust. Ledger Entry";
                VendLedgEntry: Record "Vendor Ledger Entry";
                TempGenJnlLine: Record "Payment Line" temporary;
            begin
                if "Applies-to Doc. No." <> xRec."Applies-to Doc. No." then
                    ClearCustVendApplnEntry;

                if ("Applies-to Doc. No." = '') and (xRec."Applies-to Doc. No." <> '') then begin
                    // PaymentToleranceMgt.DocumentLineDelPmtTolApllnDocNo(Rec, xRec."Applies-to Doc. No.");

                    TempGenJnlLine := Rec;

                    case TempGenJnlLine."Account Type" of
                        TempGenJnlLine."account type"::Customer:
                            begin
                                CustLedgEntry.SetCurrentkey("Document No.");
                                CustLedgEntry.SetRange("Document No.", xRec."Applies-to Doc. No.");
                                // if not (xRec."Applies-to Doc. Type" = "document type"::" ") then
                                // CustLedgEntry.SetRange("Document Type", xRec."Applies-to Doc. Type");
                                CustLedgEntry.SetRange("Customer No.", TempGenJnlLine."Account No.");
                                CustLedgEntry.SetRange(Open, true);
                                if CustLedgEntry.FindFirst then begin
                                    if CustLedgEntry."Amount to Apply" <> 0 then begin
                                        CustLedgEntry."Amount to Apply" := 0;
                                        Codeunit.Run(Codeunit::"Cust. Entry-Edit", CustLedgEntry);
                                    end;
                                    //"Exported to Payment File" := CustLedgEntry."Exported to Payment File";
                                    //"Applies-to Ext. Doc. No." := '';
                                end;
                            end;
                        TempGenJnlLine."account type"::Vendor:
                            begin
                                VendLedgEntry.SetCurrentkey("Document No.");
                                VendLedgEntry.SetRange("Document No.", xRec."Applies-to Doc. No.");
                                // if not (xRec."Applies-to Doc. Type" = "document type"::" ") then
                                //    VendLedgEntry.SetRange("Document Type", xRec."Applies-to Doc. Type");
                                VendLedgEntry.SetRange("Vendor No.", TempGenJnlLine."Account No.");
                                VendLedgEntry.SetRange(Open, true);
                                if VendLedgEntry.FindFirst then begin
                                    if VendLedgEntry."Amount to Apply" <> 0 then begin
                                        VendLedgEntry."Amount to Apply" := 0;
                                        Codeunit.Run(Codeunit::"Vend. Entry-Edit", VendLedgEntry);
                                    end;
                                    //"Exported to Payment File" := VendLedgEntry."Exported to Payment File";
                                end;
                                //"Applies-to Ext. Doc. No." := '';
                            end;
                        TempGenJnlLine."account type"::Employee:
                            begin
                                EmplLedgEntry.SetCurrentkey("Document No.");
                                EmplLedgEntry.SetRange("Document No.", xRec."Applies-to Doc. No.");
                                // if not (xRec."Applies-to Doc. Type" = "document type"::" ") then
                                //     EmplLedgEntry.SetRange("Document Type", xRec."Applies-to Doc. Type");
                                EmplLedgEntry.SetRange("Employee No.", TempGenJnlLine."Account No.");
                                EmplLedgEntry.SetRange(Open, true);
                                if EmplLedgEntry.FindFirst then begin
                                    if EmplLedgEntry."Amount to Apply" <> 0 then begin
                                        EmplLedgEntry."Amount to Apply" := 0;
                                        Codeunit.Run(Codeunit::"Empl. Entry-Edit", EmplLedgEntry);
                                    end;
                                    //"Exported to Payment File" := EmplLedgEntry."Exported to Payment File";
                                end;
                            end;
                    end;
                end;

                if ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and (Amount <> 0) then begin
                    //if xRec."Applies-to Doc. No." <> '' then
                    // PaymentToleranceMgt.DocumentLineDelPmtTolApllnDocNo(Rec, xRec."Applies-to Doc. No.");
                    SetApplyToAmount;
                    //PaymentToleranceMgt.PmtTolGenJnl(Rec);
                    xRec.ClearAppliedGenJnlLine;
                end;

                case "Account Type" of
                    "account type"::Customer:
                        GetCustLedgerEntry;
                    "account type"::Vendor:
                        GetVendLedgerEntry;
                    "account type"::Employee:
                        GetEmplLedgerEntry;
                end;

                ValidateApplyRequirements(Rec);
                //SetJournalLineFieldsFromApplication;

                if "Applies-to Doc. Type" = "applies-to doc. type"::Invoice then
                    UpdateAppliesToInvoiceID;
            end;

            /*
            Caption = 'Applies-to Doc. No.';
            trigger OnLookup()
            var
                VendLedgEntry: Record "Vendor Ledger Entry";
                PayToVendorNo: Code[20];
                OK: Boolean;
                Text000: Label 'You must specify %1 or %2.';
            begin
                //CODEUNIT.RUN(CODEUNIT::"Payment Voucher Apply",Rec);
                PHead.Reset;
                PHead.SetRange(PHead."No.", No);
                if PHead.FindFirst then begin
                    if (PHead.Status = PHead.Status::Approved) or (PHead.Status = PHead.Status::Posted) or
                     (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled) then
                        Error('You Cannot modify documents that are approved/posted/Send for Approval');
                end;
                if (Rec."Account Type" <> Rec."Account Type"::Customer) and (Rec."Account Type" <> Rec."Account Type"::Vendor) then
                    Error('You cannot apply to %1', "Account Type");

                with Rec do begin
                    Amount := 0;
                    Validate(Amount);
                    PayToVendorNo := "Account No.";
                    VendLedgEntry.SetCurrentKey("Vendor No.", Open);
                    VendLedgEntry.SetRange("Vendor No.", PayToVendorNo);
                    VendLedgEntry.SetRange(Open, true);
                    VendLedgEntry.SetRange("Document Type", VendLedgEntry."Document Type"::Invoice);
                    if "Applies-to ID" = '' then
                        "Applies-to ID" := No;
                    if "Applies-to ID" = '' then
                        Error(
                          Text000,
                          FieldCaption(No), FieldCaption("Applies-to ID"));
                    // ApplyVendEntries."SetPVLine-Delete"(PVLine,PVLine.FIELDNO("Applies-to ID"));
                    ApplyVendEntries.SetPVLine(Rec, VendLedgEntry, Rec.FieldNo("Applies-to ID"));
                    ApplyVendEntries.SetRecord(VendLedgEntry);
                    ApplyVendEntries.SetTableView(VendLedgEntry);
                    ApplyVendEntries.LookupMode(true);
                    OK := ApplyVendEntries.RunModal = ACTION::LookupOK;
                    Clear(ApplyVendEntries);
                    if not OK then
                        exit;
                    VendLedgEntry.Reset;
                    VendLedgEntry.SetCurrentKey("Vendor No.", Open);
                    VendLedgEntry.SetRange("Vendor No.", PayToVendorNo);
                    VendLedgEntry.SetRange(Open, true);
                    VendLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                    if VendLedgEntry.Find('-') then begin
                        "Applies-to Doc. Type" := "Applies-to Doc. Type"::" ";
                        "Applies-to Doc. No." := '';
                    end else
                        "Applies-to ID" := '';
                    Rec.Modify(true);
                end;

                //Calculate  Total To Apply
                VendLedgEntry.Reset;
                VendLedgEntry.SetCurrentKey("Vendor No.", Open, "Applies-to ID");
                VendLedgEntry.SetRange("Vendor No.", PayToVendorNo);
                VendLedgEntry.SetRange(Open, true);
                VendLedgEntry.Setrange("Document Type", VendLedgEntry."Document Type"::Invoice);
                VendLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                if VendLedgEntry.Find('-') then begin
                    VendLedgEntry.CalcFields("Remaining Amount");
                    VendLedgEntry.CalcSums("Amount to Apply");
                    Amount := Abs(VendLedgEntry."Amount to Apply");
                    if VendLedgEntry."Remaining Amount" <> 0 then
                        Amount := Abs(VendLedgEntry."Remaining Amount");

                    "Applies-to Doc. No." := VendLedgEntry."Document No.";
                    Validate(Amount);
                    rec.modify(true);
                end;
            end;

            trigger OnValidate()
            begin
                // IF "Applies-to Doc. No." <> '' THEN
                // TESTFIELD("Bal. Account No.",'');

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

                PHead.Reset;
                PHead.SetRange(PHead."No.", No);
                if PHead.FindFirst then begin
                    if (PHead.Status = PHead.Status::Approved) or (PHead.Status = PHead.Status::Posted) or
                     (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled) then
                        Error('You Cannot modify documents that are approved/posted/Send for Approval');
                end;
            end;
            */
        }
        field(587; "Applies-to Doc. No.XXX"; Code[20])
        {
        }
        field(88; "Applies-to ID"; Code[100])
        {
            Caption = 'Applies-to ID';

            trigger OnLookup()
            begin
                PHead.Reset;
                PHead.SetRange(PHead."No.", No);
                if PHead.FindFirst then begin
                    if (PHead.Status = PHead.Status::Approved) or (PHead.Status = PHead.Status::Posted) or
                     (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled) then
                        Error('You Cannot modify documents that are approved/posted/Send for Approval');
                end;
            end;

            trigger OnValidate()
            var
                TempVendLedgEntry: Record "Vendor Ledger Entry";
            begin
                //IF "Applies-to ID" <> '' THEN
                //  TESTFIELD("Bal. Account No.",'');
                PHead.Reset;
                PHead.SetRange(PHead."No.", No);
                if PHead.FindFirst then begin
                    if (PHead.Status = PHead.Status::Approved) or (PHead.Status = PHead.Status::Posted) or
                     (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled) then
                        Error('You Cannot modify documents that are approved/posted/Send for Approval');
                end;

                if ("Applies-to ID" <> xRec."Applies-to ID") and (xRec."Applies-to ID" <> '') then begin
                    VendLedgEntry.SetCurrentKey("Vendor No.", Open);
                    VendLedgEntry.SetRange("Vendor No.", "Account No.");
                    VendLedgEntry.SetRange(Open, true);
                    VendLedgEntry.SetRange("Applies-to ID", xRec."Applies-to ID");
                    if VendLedgEntry.FindFirst then
                        VendEntrySetApplID.SetApplId(VendLedgEntry, TempVendLedgEntry, '');

                    VendLedgEntry.Reset;
                end;
            end;
        }
        field(90; "Retention Code"; Code[20])
        {
            TableRelation = "Tariff Code s".Code WHERE(Type = CONST(Retention));

            trigger OnValidate()
            begin

                if TariffCode.Get("Retention Code") then
                    "Retention Rate" := TariffCode.Percentage

                else
                    "Retention Rate" := 0;

                // CalculateTax();
            end;
        }
        field(91; "Retention  Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                //"Retention Amount":=TariffCode.Ammount
                //CalculateTax();
            end;
        }
        field(92; "Retention Rate"; Decimal)
        {
        }
        field(93; "W/Tax Rate"; Decimal)
        {
        }
        field(94; "Vendor Bank Account"; Code[20])
        {
            TableRelation = IF ("Account Type" = CONST(Vendor)) "Vendor Bank Account".Code WHERE("Vendor No." = FIELD("Account No."));

            trigger OnLookup()
            begin
                PHead.Reset;
                PHead.SetRange(PHead."No.", No);
                if PHead.FindFirst then begin
                    if (PHead.Status = PHead.Status::Approved) or (PHead.Status = PHead.Status::Posted) or
                     (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled) then
                        Error('You Cannot modify documents that are approved/posted/Send for Approval');
                end;
            end;

            trigger OnValidate()
            begin
                PHead.Reset;
                PHead.SetRange(PHead."No.", No);
                if PHead.FindFirst then begin
                    if (PHead.Status = PHead.Status::Approved) or (PHead.Status = PHead.Status::Posted) or
                     (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled) then
                        Error('You Cannot modify documents that are approved/posted/Send for Approval');
                end;
            end;
        }
        field(95; "Trip No"; Code[20])
        {
        }
        field(96; "Driver No"; Code[20])
        {
        }
        field(97; "Loan No"; Integer)
        {
        }
        field(98; "Grant No"; Code[20])
        {

            trigger OnValidate()
            begin
                /*
                job.RESET;
                IF job.GET("Grant No") THEN
                "Account Type":="Account Type"::Customer;
                //"Account No.":=job."Bill-to Partner No.";
                //VALIDATE("Account No.");
                //"Account Name":=job.Description;
                */

            end;
        }
        field(99; "Grant Phase"; Code[10])
        {
            TableRelation = Denominations;
        }
        field(100; "Installment No"; Integer)
        {
        }
        field(101; "Job-Planning Line No"; Integer)
        {
            TableRelation = "Inward file Buffer"."Clearing System" WHERE("Serial No" = FIELD("Grant No"));
        }
        field(102; "Job No."; Code[10])
        {
            TableRelation = Job."No.";

            trigger OnValidate()
            begin
                // CheckWipAccount;
            end;
        }
        field(103; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."));

            trigger OnValidate()
            begin
                /*
                IF "Job Task No." <> xRec."Job Task No." THEN
                  VALIDATE("Job Planning Line No.",0);
                IF "Job Task No." = '' THEN BEGIN
                  "Job Quantity" := 0;
                  "Job Currency Factor" := 0;
                  "Job Currency Code" := '';
                  "Job Unit Price" := 0;
                  "Job Total Price" := 0;
                  "Job Line Amount" := 0;
                  "Job Line Discount Amount" := 0;
                  "Job Unit Cost" := 0;
                  "Job Total Cost" := 0;
                  "Job Line Discount %" := 0;
                
                  "Job Unit Price (LCY)" := 0;
                  "Job Total Price (LCY)" := 0;
                  "Job Line Amount (LCY)" := 0;
                  "Job Line Disc. Amount (LCY)" := 0;
                  "Job Unit Cost (LCY)" := 0;
                  "Job Total Cost (LCY)" := 0;
                  EXIT;
                END;
                
                IF JobTaskIsSet THEN BEGIN
                  CreateTempJobJnlLine;
                  UpdatePricesFromJobJnlLine;
                END;
                */

            end;
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
        field(50000; "Property Code"; Code[30])
        {
            //TableRelation = Table39006123.Field1;
        }
        field(50001; "Transaction Code"; Code[30])
        {
            //TableRelation = Table39006120.Field1;
        }
        field(50002; "Entry Type[Income/Expense]"; Option)
        {
            OptionCaption = ' ,Income,Expense';
            OptionMembers = " ",Income,Expense;
        }
        field(50003; "Asset No"; Code[10])
        {
            TableRelation = "Fixed Asset"."No.";
        }
        field(56000; "Invoice No."; Code[50])
        {
            // TableRelation = "Vendor Ledger Entry"."Document No." WHERE(Open = CONST(true),
            //                                                             "Document Type" = CONST(Invoice),
            //                                                             "Vendor No." = FIELD("Account No."));

            trigger OnValidate()
            var
                PostedPurchInv: record "Purch. Inv. Header";
            begin
                VendLedger.Reset;
                VendLedger.SetRange(VendLedger."Document No.", "Invoice No.");
                VendLedger.SetRange(VendLedger."Vendor No.", "Account No.");
                VendLedger.SetRange(VendLedger."Document Type", VendLedger."Document Type"::Invoice);
                if VendLedger.FindFirst then begin
                    VendLedger.CalcFields("Remaining Amount");
                    Amount := -VendLedger."Remaining Amount";
                    "Due Date" := VendLedger."Due Date";
                    "Invoice No." := VendLedger."External Document No.";
                end;

                if strlen(rec."Invoice No.") < 20 then begin
                    PostedPurchInv.RESET;
                    PostedPurchInv.SETRANGE(PostedPurchInv."No.", "Invoice No.");
                    IF PostedPurchInv.FindFirst() then
                        "Invoice Date" := PostedPurchInv."Posting Date";
                end;

            end;
        }
        field(56001; "Due Date"; Date)
        {
        }
        field(56002; "VAT Withholding Amount"; Decimal)
        {
        }
        field(56003; "VAT Withholding Code"; Code[10])
        {
            TableRelation = "Tariff Code s".Code WHERE(Type = CONST(VAT));

            trigger OnValidate()
            begin
                if TariffCode.Get("VAT Withholding Code") then
                    "VAT Withholding Rate" := TariffCode.Percentage
                else
                    "VAT Withholding Rate" := 0;

                CalculateTax();
            end;
        }
        field(56004; "VAT Withholding Rate"; Decimal)
        {
        }
        field(56005; "VAT Deductible"; Boolean)
        {
        }
        field(56006; "Vend Ledger Entry No"; Integer)
        {
        }
        field(56015; "Contract No"; Code[50])
        {
        }
        field(56016; "Running Balance"; Decimal)
        {
        }
        field(56017; "Applies-to Invoice Id"; Guid)
        {

        }
        field(56018; "Invoice Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Line No.", No, Type)
        {
            Clustered = true;
            SumIndexFields = Amount, "VAT Amount", "Withholding Tax Amount", "Net Amount", "NetAmount LCY", "Retention  Amount";
        }
    }

    fieldgroups
    {
    }
    procedure AutoPopulateTheVendorKRAinHeader()
    begin
        PaymentHeader.reset();
        if PaymentHeader.get(Rec.No) then begin
            if Rec."Account Type" = rec."Account Type"::Vendor then begin
                Vendors.RESET;
                if Vendors.GET(rec."Account No.") then begin
                    PaymentHeader."Vendor KRA PIN" := Vendors."KRA Pin No.";
                    PaymentHeader."Vendor Contacts" := Vendors."Mobile Phone No.";
                    paymentHeader.MODIFY;
                end;
            end;
        end;
    end;



    trigger OnDelete()
    begin
        PHead.Reset;
        PHead.SetRange(PHead."No.", No);
        if PHead.FindFirst then begin
            if
            (PHead.Status = PHead.Status::Approved) or
             (PHead.Status = PHead.Status::Posted) or
            (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled) then
                Error('You Cannot Delete this record its already approved/posted/Send for Approval');
        end;
        TestField(Committed, false);
    end;

    trigger OnInsert()
    begin

        if No = '' then begin
            GenLedgerSetup.Get;
            GenLedgerSetup.TestField(GenLedgerSetup."Normal Payments No");
            No := NoSeriesMgt.GetNextNo(GenLedgerSetup."Normal Payments No");
            // NoSeriesMgt.InitSeries(GenLedgerSetup."Normal Payments No", xRec."No. Series", 0D, No, "No. Series");
        end;
        PHead.Reset;
        PHead.SetRange(PHead."No.", No);
        if PHead.FindFirst then begin
            Date := PHead.Date;
            PHead.TestField("Responsibility Center");
            Validate("Global Dimension 1 Code", PHead."Global Dimension 1 Code");
            Validate("Shortcut Dimension 2 Code", PHead."Shortcut Dimension 2 Code");
            //VALIDATE("Shortcut Dimension 3 Code",PHead."Shortcut Dimension 3 Code");
            //VALIDATE("Shortcut Dimension 4 Code",PHead."Shortcut Dimension 4 Code");
            "Dimension Set ID" := PHead."Dimension Set ID";
            "Currency Code" := PHead."Currency Code";
            "Currency Factor" := PHead."Currency Factor";
            "Payment Type" := PHead."Payment Type";
        end;

        //
        PHead.Reset;
        PHead.SetRange(PHead."No.", No);
        if PHead.FindFirst then begin
            if
            //  (PHead.Status=PHead.Status::Approved)
            (PHead.Status = PHead.Status::Posted) or
             (PHead.Status = PHead.Status::"Pending Approval") or (PHead.Status = PHead.Status::Cancelled) then
                Error('You Cannot modify documents that are approved/posted/Send for Approval');
        end;
        TestField(Committed, false);
    end;

    trigger OnModify()
    begin
        /*
        PHead.RESET;
        PHead.SETRANGE(PHead."No.",No);
         IF PHead.FINDFIRST THEN BEGIN
            IF (PHead.Status=PHead.Status::Approved) OR (PHead.Status=PHead.Status::Posted) OR
             (PHead.Status=PHead.Status::"Pending Approval") THEN
               ERROR('You Cannot modify documents that are approved/posted/Send for Approval');
         END;
         */
        //TestField(Committed, false);
        if Rec.Committed then
            Error('You Cannot modify documents that budget has been commited. Please cancel the commitment before proceeding');

    end;

    var
        PH: Record "Payments Header";
        BSetup: Record "Farmer Purchase Broker Setup";
        VLedgEntry: Record "Vendor Ledger Entry";
        ICPartner: Record "IC Partner";
        FPurch: Record "Purch. Inv. Header";
        GLAcc: Record "G/L Account";
        Cust: Record Customer;
        Vend: Record Vendor;
        FA: Record "Fixed Asset";
        BankAcc: Record "Bank Account";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        GenLedgerSetup: Record "Cash Office Setup";
        RecPayTypes: Record "Receipts and Payment Types";
        CashierLinks: Record "Cash Office User Template";
        GLAccount: Record "G/L Account";
        EntryNo: Integer;
        SingleMonth: Boolean;
        DateFrom: Date;
        DateTo: Date;
        Budget: Decimal;
        CurrMonth: Code[10];
        CurrYR: Code[10];
        BudgDate: Text[30];
        BudgetDate: Date;
        YrBudget: Decimal;
        BudgetDateTo: Date;
        BudgetAvailable: Decimal;
        GenLedSetup: Record "Cash Office Setup";
        "Total Budget": Decimal;
        MonthBudget: Decimal;
        Expenses: Decimal;
        Header: Text[250];
        "Date From": Text[30];
        "Date To": Text[30];
        LastDay: Date;
        ImprestReqDet: Record "Imprest Details-User";
        // LoadImprestDetails: Record "Cash Payment Line";
        TotAmt: Decimal;
        DimVal: Record "Dimension Value";
        PHead: Record "Payments Header";
        VendLedgEntry: Record "Vendor Ledger Entry";
        CustLedgEntry: Record "Cust. Ledger Entry";
        FOSAPV: record "FOSA Payments Header";
        CustEntrySetApplID: Codeunit "Cust. Entry-SetAppl.ID";
        VendEntrySetApplID: Codeunit "Vend. Entry-SetAppl.ID";
        EmplEntrySetApplID: Codeunit "Empl. Entry-SetAppl.ID";
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        GenJnILine: Record "Gen. Journal Line";
        ApplyVendEntries: Page "Apply Vendor Entries";
        TariffCode: Record "Tariff Code s";
        DimMgt: Codeunit DimensionManagement;
        VendLedger: Record "Vendor Ledger Entry";
        SavingsAccounts: Record "Savings Accounts";
        CreditAccounts: Record "Credit Accounts";
        "Retention Amount": Record "Tariff Code s";
        PaymentHeader: Record "Payments Header";
        Vendors: Record Vendor;
        EmplLedgEntry: Record "Employee Ledger Entry";
        Text015: label 'You are not allowed to apply and post an entry to an entry with an earlier posting date.\\Instead, post %1 %2 and then apply it to %3 %4.';
        NotExistErr: Label 'Document number %1 does not exist or is already closed.', Comment = '%1=Document number';


    // [Scope('OnPrem')]
    procedure SetAmountToApply(AppliesToDocNo: Code[20]; VendorNo: Code[20])
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
    begin
        VendLedgEntry.SetCurrentKey("Document No.");
        VendLedgEntry.SetRange("Document No.", AppliesToDocNo);
        VendLedgEntry.SetRange("Vendor No.", VendorNo);
        VendLedgEntry.SetRange(Open, true);
        if VendLedgEntry.FindFirst then begin
            if VendLedgEntry."Amount to Apply" = 0 then begin
                VendLedgEntry.CalcFields("Remaining Amount");
                VendLedgEntry."Amount to Apply" := VendLedgEntry."Remaining Amount";
            end else
                VendLedgEntry."Amount to Apply" := 0;
            VendLedgEntry."Accepted Payment Tolerance" := 0;
            VendLedgEntry."Accepted Pmt. Disc. Tolerance" := false;
            CODEUNIT.Run(CODEUNIT::"Vend. Entry-Edit", VendLedgEntry);
        end;
    end;


    procedure CalculateTax()
    var
        CalculationType: Option VAT,"W/Tax",Retention,"W/VAT";
        TaxCalc: Codeunit "Tax Calculation";
        TotalTax: Decimal;
    begin
        "VAT Amount" := 0;
        "Withholding Tax Amount" := 0;
        "Retention  Amount" := 0;
        TotalTax := 0;
        "Net Amount" := 0;
        "VAT Withholding Amount" := 0;
        if Amount <> 0 then begin
            if "VAT Rate" <> 0 then begin
                //IF "VAT Deductible" = "VAT Deductible"::"1" THEN
                "VAT Amount" := Round(TaxCalc.CalculateTax(Rec, CalculationType::VAT), 0.01, '>');
                //ELSE "VAT Amount" := 0;
                TotalTax := Round(TotalTax + "VAT Amount", 0.01, '>')
            end;

            if "W/Tax Rate" <> 0 then begin
                "Withholding Tax Amount" := Round(TaxCalc.CalculateTax(Rec, CalculationType::"W/Tax"), 0.01, '>');
                TotalTax := Round(TotalTax + "Withholding Tax Amount", 0.01, '>')
            end;

            if "Retention Rate" <> 0 then begin
                "Retention  Amount" := Round(TaxCalc.CalculateTax(Rec, CalculationType::Retention), 1, '=');
                TotalTax := Round(TotalTax + "Retention  Amount", 1, '=')
            end;

            if "VAT Withholding Rate" <> 0 then begin
                "VAT Withholding Amount" := Round(TaxCalc.CalculateTax(Rec, CalculationType::"W/VAT"), 1, '>');
                TotalTax := Round(TotalTax + "VAT Withholding Amount", 1, '>');
            end;

        end;

        if "VAT Deductible" = true then
            "Net Amount" := Round(Amount - TotalTax, 0.01, '>')
        else
            //"Net Amount" := Round(Amount - TotalTax + "VAT Amount", 0.01, '>');
            "Net Amount" := Round((Amount - ("VAT Withholding Amount" + "Retention  Amount" + "Withholding Tax Amount")));

        Validate("Net Amount");
    end;

    procedure PayLinesExist(): Boolean
    var
        PayLine: Record "Payment Line";
    begin
        PayLine.Reset;
        PayLine.SetRange(No, No);
        exit(PayLine.FindFirst);
    end;

    // [Scope('OnPrem')]
    procedure ShowDimensions()
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', 'Payment', "Line No."));
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
    procedure CheckWipAccount()
    var
        FAWIPJob: Record Job;
        FAWIPJobPostingGrp: Record "Job Posting Group";
    begin
        FAWIPJob.Get("Job No.");
        FAWIPJobPostingGrp.Get(FAWIPJob."Job Posting Group");
        TestField("Account Type", "Account Type"::"G/L Account");
        if "Account No." <> FAWIPJobPostingGrp."WIP Costs Account" then
            Error('Insert the right WIP Account %1', FAWIPJobPostingGrp."WIP Costs Account");
    end;

    // [Scope('OnPrem')]
    procedure CalculateBudgetaryPaneMgt()
    var
        BudgetaryControl: Codeunit "Budgetary Control";
        PaymentsHeader: Record "Payments Header";
        TextResult: Text;
        i: Integer;
        ExtractedResult: array[5] of Text;
    begin
        // PaymentsHeader.Get(No);
        // TextResult := BudgetaryControl.CheckPayments(PaymentsHeader);
        // for i := 0 to 10 do begin
        //     ExtractedResult[i] := Token(TextResult, '|');
        // end
    end;

    // [Scope('OnPrem')]
    procedure Token(var Text: Text; Separator: Text) Token: Text[250]
    var
        Pos: Integer;
    begin
        Pos := StrPos(Text, Separator);
        if Pos > 0 then begin
            Token := CopyStr(Text, 1, Pos - 1);
            if Pos + 1 <= StrLen(Text) then
                Text := CopyStr(Text, Pos + 1)
            else
                Text := '';
        end else begin
            Token := Text;
            Text := '';
        end;
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeLookupAppliesToDocNo(var PaymentLine: Record "Payment Line"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetAccTypeAndNo(PayLine2: Record "Payment Line"; var AccType: Enum "Gen. Journal Account Type"; var AccNo: Code[20]; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnLookUpAppliesToDocCustOnAfterSetFilters(var CustLedgerEntry: Record "Cust. Ledger Entry"; var PayLine: Record "Payment Line"; AccNo: Code[20])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeRunApplyCustEntriesPageLookupOk(var GenJournalLine: Record "Gen. Journal Line"; var CustLedgEntry: Record "Cust. Ledger Entry"; AccNo: Code[20]; var Result: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeLookUpAppliesToDocCust(var PayLine: record "Payment Line"; AccNo: Code[20]; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnLookUpAppliesToDocCustOnAfterApplyCustEntriesGetRecord(var PayLine: Record "Payment Line"; CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnLookUpAppliesToDocCustOnAfterUpdateDocumentTypeAndAppliesTo(var PayLine: Record "Payment Line"; CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterUpdateDocumentTypeAndAppliesToFields(var PayLine: Record "Payment Line"; DocType: Integer; DocNo: Code[20])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnLookUpAppliesToDocVendOnAfterSetFilters(var VendorLedgerEntry: Record "Vendor Ledger Entry"; var PayLine: Record "Payment Line"; AccNo: Code[20])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeLookUpAppliesToDocVend(var PayLine: Record "Payment Line"; AccNo: Code[20]; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnLookUpAppliesToDocVendOnAfterApplyVendEntriesGetRecord(var PaymentLines: record "Payment Line"; PayLine: Record "Payment Line"; GenJnlApply: Codeunit "Gen. Jnl.-Apply"; PaymentToleranceMgt: Codeunit "Payment Tolerance Management"; VendLedgEntry: Record "Vendor Ledger Entry"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnLookupAppliestoDocNoOnAfterSetJournalLineFieldsFromApplication(var PayLine: Record "Payment Line")
    begin
    end;


    procedure UpdateAppliesToInvoiceID()
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        if "Applies-to Doc. Type" <> "applies-to doc. type"::Invoice then
            exit;

        if "Applies-to Doc. No." = '' then begin
            Clear("Applies-to Invoice Id");
            exit;
        end;

        if not SalesInvoiceHeader.Get("Applies-to Doc. No.") then
            exit;

        //"Applies-to Invoice Id" := SalesInvoiceHeader.Id;
    end;

    procedure UpdateAppliesToInvoiceIDII()
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        SalesInvoiceAggregator: Codeunit "Sales Invoice Aggregator";
        PurchInvAggregator: Codeunit "Purch. Inv. Aggregator";
    begin
        if "Applies-to Doc. Type" <> "Applies-to Doc. Type"::Invoice then
            exit;

        if "Applies-to Doc. No." = '' then begin
            Clear(rec."Applies-to ID");
            exit;
        end;

        case "Account Type" of
            "Account Type"::Customer:
                begin
                    if not SalesInvoiceHeader.Get("Applies-to Doc. No.") then
                        exit;

                    "Applies-to Invoice Id" := SalesInvoiceAggregator.GetSalesInvoiceHeaderId(SalesInvoiceHeader);
                end;
            "Account Type"::Vendor:
                begin
                    if not PurchInvHeader.Get("Applies-to Doc. No.") then
                        exit;

                    "Applies-to Invoice Id" := PurchInvAggregator.GetPurchaseInvoiceHeaderId(PurchInvHeader);
                end;
        end;
    end;

    /*
        procedure LookUpAppliesToDocVend(AccNo: Code[20])
        var
            ApplyVendEntries: Page "Apply Vendor Entries";
            IsHandled: Boolean;
        begin
            IsHandled := false;
            OnBeforeLookUpAppliesToDocVend(Rec, AccNo, IsHandled);
            if IsHandled then
                exit;

            Clear(VendLedgEntry);
            VendLedgEntry.SetCurrentKey("Vendor No.", Open, Positive, "Due Date");
            if AccNo <> '' then
                VendLedgEntry.SetRange("Vendor No.", AccNo);
            VendLedgEntry.SetRange(Open, true);
            if "Applies-to Doc. No." <> '' then begin
                VendLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
                VendLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
                if VendLedgEntry.IsEmpty() then begin
                    VendLedgEntry.SetRange("Document Type");
                    VendLedgEntry.SetRange("Document No.");
                end;
            end;
            if "Applies-to ID" <> '' then begin
                VendLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                if VendLedgEntry.IsEmpty() then
                    VendLedgEntry.SetRange("Applies-to ID");
            end;
            if "Applies-to Doc. Type" <> "Applies-to Doc. Type"::" " then begin
                VendLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
                if VendLedgEntry.IsEmpty() then
                    VendLedgEntry.SetRange("Document Type");
            end;
            if "Applies-to Doc. No." <> '' then begin
                VendLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
                if VendLedgEntry.IsEmpty() then
                    VendLedgEntry.SetRange("Document No.");
            end;
            if Amount <> 0 then begin
                VendLedgEntry.SetRange(Positive, Amount < 0);
                if VendLedgEntry.IsEmpty() then;
                VendLedgEntry.SetRange(Positive);
            end;
            OnLookUpAppliesToDocVendOnAfterSetFilters(VendLedgEntry, Rec, AccNo);

            // if RunApplyVendEntriesPageLookupOk(ApplyVendEntries, AccNo) then begin
            //     IsHandled := false;
            //     OnLookUpAppliesToDocVendOnAfterApplyVendEntriesGetRecord(Rec, PayLine, GenJnlApply, PaymentToleranceMgt, VendLedgEntry, IsHandled);
            //     if IsHandled then
            //         exit;

            //     SetAmountWithVendLedgEntry();
            //     UpdateDocumentTypeAndAppliesTo(VendLedgEntry."Document Type", VendLedgEntry."Document No.");
            //     OnLookUpAppliesToDocVendOnAfterUpdateDocumentTypeAndAppliesTo(Rec, VendLedgEntry);
            // end;

            // OnAfterLookUpAppliesToDocVend(Rec, VendLedgEntry, CustLedgEntry, ApplyVendEntries);
        end;
        */

    // local procedure RunApplyVendEntriesPageLookupOk(var ApplyVendEntries: Page "Apply Vendor Entries"; AccNo: Code[20]) Result: Boolean
    // var
    //     IsHandled: Boolean;
    // begin
    //     IsHandled := false;
    //     OnBeforeRunApplyVendEntriesPageLookupOk(Rec, VendLedgEntry, AccNo, Result, IsHandled);
    //     if IsHandled then
    //         exit(Result);

    //     ApplyVendEntries.SetGenJnlLine(Rec, GenJnlLine.FieldNo("Applies-to Doc. No."));
    //     ApplyVendEntries.SetTableView(VendLedgEntry);
    //     ApplyVendEntries.SetRecord(VendLedgEntry);
    //     ApplyVendEntries.LookupMode(true);
    //     if ApplyVendEntries.RunModal() = ACTION::LookupOK then begin
    //         ApplyVendEntries.GetRecord(VendLedgEntry);
    //         exit(true);
    //     end;

    //     exit(false);
    // end;
    procedure LookUpAppliesToDocVend(AccNo: Code[20])
    var
        ApplyVendEntries: Page "Apply Vendor Entries - New";
    begin
        Clear(VendLedgEntry);
        VendLedgEntry.SetCurrentkey("Vendor No.", Open, Positive, "Due Date");
        if AccNo <> '' then
            VendLedgEntry.SetRange("Vendor No.", AccNo);
        VendLedgEntry.SetRange(Open, true);
        if "Applies-to Doc. No." <> '' then begin
            VendLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
            VendLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
            if VendLedgEntry.IsEmpty then begin
                VendLedgEntry.SetRange("Document Type");
                VendLedgEntry.SetRange("Document No.");
            end;
        end;
        if "Applies-to ID" <> '' then begin
            VendLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
            if VendLedgEntry.IsEmpty then
                VendLedgEntry.SetRange("Applies-to ID");
        end;
        if "Applies-to Doc. Type" <> "applies-to doc. type"::" " then begin
            VendLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
            if VendLedgEntry.IsEmpty then
                VendLedgEntry.SetRange("Document Type");
        end;
        if "Applies-to Doc. No." <> '' then begin
            VendLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
            if VendLedgEntry.IsEmpty then
                VendLedgEntry.SetRange("Document No.");
        end;
        if Amount <> 0 then begin
            VendLedgEntry.SetRange(Positive, Amount < 0);
            if VendLedgEntry.IsEmpty then;
            VendLedgEntry.SetRange(Positive);
        end;
        //ApplyVendEntries.SetDocumentLine(Rec, GenJnlLine.FieldNo("Applies-to Doc. No."));
        ApplyVendEntries.SetTableview(VendLedgEntry);
        ApplyVendEntries.SetRecord(VendLedgEntry);
        ApplyVendEntries.LookupMode(true);
        if ApplyVendEntries.RunModal = Action::LookupOK then begin
            ApplyVendEntries.GetRecord(VendLedgEntry);
            if AccNo = '' then begin
                AccNo := VendLedgEntry."Vendor No.";
                Validate("Account No.", AccNo);
            end;
            SetAmountWithVendLedgEntry;
            "Applies-to Doc. Type" := VendLedgEntry."Document Type";
            "Applies-to Doc. No." := VendLedgEntry."Document No.";
            if VendLedgEntry."External Document No." = '' then VendLedgEntry."External Document No." := VendLedgEntry."Document No.";
            "Invoice No." := VendLedgEntry."Document No.";
            validate("Invoice No.");
            "Applies-to ID" := '';
        end;
    end;

    local procedure SetAmountWithVendLedgEntry()
    begin
        //IF "Currency Code" <> VendLedgEntry."Currency Code" THEN
        //CheckModifyCurrencyCode("Account Type"::Vendor,VendLedgEntry."Currency Code");

        if Amount = 0 then begin
            VendLedgEntry.CalcFields("Remaining Amount");
            //SetAmountWithRemaining(
            //PaymentToleranceMgt.CheckCalcPmtDiscDocumentLineVend(Rec, VendLedgEntry, 0, false),
            //VendLedgEntry."Amount to Apply", VendLedgEntry."Remaining Amount", VendLedgEntry."Remaining Pmt. Disc. Possible");
            Amount := abs(VendLedgEntry."Remaining Amount");
            Validate(Amount);
        end;
    end;

    procedure LookUpAppliesToDocCust(AccNo: Code[20])
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeLookUpAppliesToDocCust(Rec, AccNo, IsHandled);
        if IsHandled then
            exit;

        Clear(CustLedgEntry);
        CustLedgEntry.SetCurrentKey("Customer No.", Open, Positive, "Due Date");
        if AccNo <> '' then
            CustLedgEntry.SetRange("Customer No.", AccNo);
        CustLedgEntry.SetRange(Open, true);
        if "Applies-to Doc. No." <> '' then begin
            CustLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
            CustLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
            if CustLedgEntry.IsEmpty() then begin
                CustLedgEntry.SetRange("Document Type");
                CustLedgEntry.SetRange("Document No.");
            end;
        end;
        if "Applies-to ID" <> '' then begin
            CustLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
            if CustLedgEntry.IsEmpty() then
                CustLedgEntry.SetRange("Applies-to ID");
        end;
        if "Applies-to Doc. Type" <> "Applies-to Doc. Type"::" " then begin
            CustLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
            if CustLedgEntry.IsEmpty() then
                CustLedgEntry.SetRange("Document Type");
        end;
        if Amount <> 0 then begin
            CustLedgEntry.SetRange(Positive, Amount < 0);
            if CustLedgEntry.IsEmpty() then
                CustLedgEntry.SetRange(Positive);
        end;
        OnLookUpAppliesToDocCustOnAfterSetFilters(CustLedgEntry, Rec, AccNo);

        // If RunApplyCustEntriesPageLookupOk(AccNo) then begin
        //     OnLookUpAppliesToDocCustOnAfterApplyCustEntriesGetRecord(Rec, CustLedgEntry);
        //     if AccNo = '' then begin
        //         AccNo := CustLedgEntry."Customer No.";
        //         Validate("Account No.", AccNo);
        //     end;
        //     SetAmountWithCustLedgEntry();
        //     UpdateDocumentTypeAndAppliesTo(CustLedgEntry."Document Type", CustLedgEntry."Document No.");
        //     OnLookUpAppliesToDocCustOnAfterUpdateDocumentTypeAndAppliesTo(Rec, CustLedgEntry);
        // end;
    end;


    // local procedure UpdateDocumentTypeAndAppliesTo(DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20])
    // begin
    //     "Applies-to Doc. Type" := DocType;
    //     "Applies-to Doc. No." := DocNo;
    //     "Applies-to ID" := '';

    //     OnAfterUpdateDocumentTypeAndAppliesToFields(Rec, DocType.AsInteger(), DocNo);

    //     if not ("Account Type" in ["Account Type"::Customer, "Account Type"::Vendor]) then
    //         exit;

    //     case "Applies-to Doc. Type" of
    //         "Applies-to Doc. Type"::Payment:
    //             "Document Type" := "Document Type"::Invoice;
    //         rec.lies -to Doc.Type "::"Credit Memo":
    //             "Document Type" := "Document Type"::Refund;
    //         "Applies-to Doc. Type"::Invoice,
    //         "Applies-to Doc. Type"::Refund:
    //             "Document Type" := "Document Type"::Payment;
    //     end;
    // end;

    // local procedure RunApplyCustEntriesPageLookupOk(AccNo: Code[20]) Result: Boolean
    // var
    //     ApplyCustEntries: Page "Apply Customer Entries";
    //     IsHandled: Boolean;
    // begin
    //     IsHandled := false;
    //     OnBeforeRunApplyCustEntriesPageLookupOk(Rec, CustLedgEntry, AccNo, Result, IsHandled);
    //     if IsHandled then
    //         exit(Result);

    //     ApplyCustEntries.SetGenJnlLine(Rec, GenJnlLine.FieldNo("Applies-to Doc. No."));
    //     ApplyCustEntries.SetTableView(CustLedgEntry);
    //     ApplyCustEntries.SetRecord(CustLedgEntry);
    //     ApplyCustEntries.LookupMode(true);
    //     if ApplyCustEntries.RunModal() = ACTION::LookupOK then begin
    //         ApplyCustEntries.GetRecord(CustLedgEntry);
    //         exit(true);
    //     end;

    //     exit(false);
    // end;

    procedure GetAccTypeAndNo(PayLine2: Record "Payment Line"; var AccType: Enum "Gen. Journal Account Type"; var AccNo: Code[20])
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeGetAccTypeAndNo(PayLine2, AccType, AccNo, IsHandled);
        if IsHandled then
            exit;

        AccType := PayLine2."Account Type";
        AccNo := PayLine2."Account No.";
    end;

    local procedure RunApplyVendEntriesPageLookupOk(var ApplyVendEntries: Page "Apply Vendor Entries"; AccNo: Code[20]) Result: Boolean
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforeRunApplyVendEntriesPageLookupOk(Rec, VendLedgEntry, AccNo, Result, IsHandled);
        // if IsHandled then
        //     exit(Result);

        // ApplyVendEntries.SetGenJnlLine(Rec, GenJnlLine.FieldNo("Applies-to Doc. No."));
        // ApplyVendEntries.SetTableView(VendLedgEntry);
        // ApplyVendEntries.SetRecord(VendLedgEntry);
        // ApplyVendEntries.LookupMode(true);
        // if ApplyVendEntries.RunModal() = ACTION::LookupOK then begin
        //     ApplyVendEntries.GetRecord(VendLedgEntry);
        //     exit(true);
        // end;

        exit(false);
    end;

    procedure GetCustLedgerEntry()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;

        if ("Account Type" = "Account Type"::Customer) and ("Account No." = '') and
           ("Applies-to Doc. No." <> '')
        then begin
            CustLedgEntry.Reset();
            CustLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
            CustLedgEntry.SetRange(Open, true);
            if not CustLedgEntry.FindFirst() then
                Error(NotExistErr, "Applies-to Doc. No.");

            Validate("Account No.", CustLedgEntry."Customer No.");

            if Amount = 0 then begin
                CustLedgEntry.CalcFields("Remaining Amount");

                if Today <= CustLedgEntry."Pmt. Discount Date" then
                    Amount := -(CustLedgEntry."Remaining Amount" - CustLedgEntry."Remaining Pmt. Disc. Possible")
                else
                    SetAppliesToFields(
                      CustLedgEntry."Document Type", CustLedgEntry."Document No.", CustLedgEntry."External Document No.");

                Validate(Amount);
            end;
        end;
    end;

    procedure GetEmplLedgerEntry()
    begin
        if ("Account Type" = "account type"::Employee) and ("Account No." = '') and
           ("Applies-to Doc. No." <> '') and (Amount = 0)
        then begin
            EmplLedgEntry.Reset;
            EmplLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
            EmplLedgEntry.SetRange(Open, true);
            if not EmplLedgEntry.FindFirst then
                Error(NotExistErr, "Applies-to Doc. No.");

            Validate("Account No.", EmplLedgEntry."Employee No.");
            EmplLedgEntry.CalcFields("Remaining Amount");

            Amount := -EmplLedgEntry."Remaining Amount";

            //  SetAppliesToFields(EmplLedgEntry."Document Type", EmplLedgEntry."Document No.", '');

            Validate(Amount);
        end;
    end;

    procedure GetVendLedgerEntry()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if ("Account Type" = "Account Type"::Vendor) and ("Account No." = '') and
           ("Applies-to Doc. No." <> '')
        then begin
            VendLedgEntry.Reset();
            VendLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
            VendLedgEntry.SetRange(Open, true);
            if not VendLedgEntry.FindFirst() then
                Error(NotExistErr, "Applies-to Doc. No.");

            Validate("Account No.", VendLedgEntry."Vendor No.");
            // OnGetVendLedgerEntryOnAfterAssignVendorNo(Rec, VendLedgEntry);
            if VendLedgEntry."External Document No." = '' then VendLedgEntry."External Document No." := VendLedgEntry."Document No.";

            if Amount = 0 then begin
                VendLedgEntry.CalcFields("Remaining Amount");

                if Today <= VendLedgEntry."Pmt. Discount Date" then
                    Amount := -(VendLedgEntry."Remaining Amount" - VendLedgEntry."Remaining Pmt. Disc. Possible")
                else
                    Amount := -VendLedgEntry."Remaining Amount";


                SetAppliesToFields(
                  VendLedgEntry."Document Type", VendLedgEntry."Document No.", VendLedgEntry."External Document No.");
                Validate(Amount);

                //  OnAfterGetVendLedgerEntry(Rec, VendLedgEntry);
            end;
        end;
    end;

    local procedure SetAppliesToFields(DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20]; ExtDocNo: Code[35])
    begin
        //UpdateDocumentTypeAndAppliesTo(DocType, DocNo);

        // if ("Applies-to Doc. Type" = "Applies-to Doc. Type"::Invoice) and ("Document Type" = "Document Type"::Payment) then
        //    "Applies-to Ext. Doc. No." := ExtDocNo;
    end;


    procedure SetJournalLineFieldsFromApplication()
    var
        AccType: Enum "Gen. Journal Account Type";
        AccNo: Code[20];
    begin
        GetAccTypeAndNo(Rec, AccType, AccNo);
        case AccType of
            AccType::Customer:
                if "Applies-to Doc. No." <> '' then
                    if FindFirstCustLedgEntryWithAppliesToDocNo(AccNo, "Applies-to Doc. No.") then begin
                        // "Applies-to Ext. Doc. No." := CustLedgEntry."External Document No.";
                    end;
            AccType::Vendor:
                if "Applies-to Doc. No." <> '' then
                    if FindFirstVendLedgEntryWithAppliesToDocNo(AccNo, "Applies-to Doc. No.") then begin
                        // "Applies-to Ext. Doc. No." := VendLedgEntry."External Document No.";
                    end;
        end;

    end;

    local procedure FindFirstCustLedgEntryWithAppliesToIDII(AccNo: Code[20]; AppliesToID: Code[50]): Boolean
    begin
        CustLedgEntry.Reset();
        CustLedgEntry.SetCurrentKey("Customer No.", "Applies-to ID", Open);
        CustLedgEntry.SetRange("Customer No.", AccNo);
        CustLedgEntry.SetRange("Applies-to ID", AppliesToID);
        CustLedgEntry.SetRange(Open, true);
        exit(CustLedgEntry.FindFirst());
    end;

    local procedure FindFirstCustLedgEntryWithAppliesToDocNoII(AccNo: Code[20]; AppliestoDocNo: Code[20]): Boolean
    begin
        CustLedgEntry.Reset();
        CustLedgEntry.SetCurrentKey("Document No.");
        CustLedgEntry.SetRange("Document No.", AppliestoDocNo);
        CustLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
        CustLedgEntry.SetRange("Customer No.", AccNo);
        CustLedgEntry.SetRange(Open, true);
        exit(CustLedgEntry.FindFirst());
    end;

    local procedure FindFirstVendLedgEntryWithAppliesToIDII(AccNo: Code[20]; AppliesToID: Code[50]): Boolean
    begin
        VendLedgEntry.Reset();
        VendLedgEntry.SetCurrentKey("Vendor No.", "Applies-to ID", Open);
        VendLedgEntry.SetRange("Vendor No.", AccNo);
        VendLedgEntry.SetRange("Applies-to ID", AppliesToID);
        VendLedgEntry.SetRange(Open, true);
        exit(VendLedgEntry.FindFirst());
    end;

    local procedure FindFirstVendLedgEntryWithAppliesToDocNoII(AccNo: Code[20]; AppliestoDocNo: Code[20]): Boolean
    begin
        VendLedgEntry.Reset();
        VendLedgEntry.SetCurrentKey("Document No.");
        VendLedgEntry.SetRange("Document No.", AppliestoDocNo);
        VendLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
        VendLedgEntry.SetRange("Vendor No.", AccNo);
        VendLedgEntry.SetRange(Open, true);
        exit(VendLedgEntry.FindFirst());
    end;

    procedure ClearCustVendApplnEntry()
    var
        TempCustLedgEntry: Record "Cust. Ledger Entry" temporary;
        TempVendLedgEntry: Record "Vendor Ledger Entry" temporary;
        TempEmplLedgEntry: Record "Employee Ledger Entry" temporary;
        AccType: Enum "Gen. Journal Account Type";
        AccNo: Code[20];
    begin
        AccType := "Account Type";
        AccNo := "Account No.";

        case AccType of
            Acctype::Customer:
                if xRec."Applies-to ID" <> '' then begin
                    if FindFirstCustLedgEntryWithAppliesToID(AccNo, xRec."Applies-to ID") then begin
                        ClearCustApplnEntryFields;
                        TempCustLedgEntry.DeleteAll;
                        CustEntrySetApplID.SetApplId(CustLedgEntry, TempCustLedgEntry, '');
                    end
                end else
                    if xRec."Applies-to Doc. No." <> '' then
                        if FindFirstCustLedgEntryWithAppliesToDocNo(AccNo, xRec."Applies-to Doc. No.") then begin
                            ClearCustApplnEntryFields;
                            Codeunit.Run(Codeunit::"Cust. Entry-Edit", CustLedgEntry);
                        end;
            Acctype::Vendor:
                if xRec."Applies-to ID" <> '' then begin
                    if FindFirstVendLedgEntryWithAppliesToID(AccNo, xRec."Applies-to ID") then begin
                        ClearVendApplnEntryFields;
                        TempVendLedgEntry.DeleteAll;
                        VendEntrySetApplID.SetApplId(VendLedgEntry, TempVendLedgEntry, '');
                    end
                end else
                    if xRec."Applies-to Doc. No." <> '' then
                        if FindFirstVendLedgEntryWithAppliesToDocNo(AccNo, xRec."Applies-to Doc. No.") then begin
                            ClearVendApplnEntryFields;
                            Codeunit.Run(Codeunit::"Vend. Entry-Edit", VendLedgEntry);
                        end;
            Acctype::Employee:
                if xRec."Applies-to ID" <> '' then begin
                    if FindFirstEmplLedgEntryWithAppliesToID(AccNo, xRec."Applies-to ID") then begin
                        ClearEmplApplnEntryFields;
                        TempEmplLedgEntry.DeleteAll;
                        EmplEntrySetApplID.SetApplId(EmplLedgEntry, TempEmplLedgEntry, '');
                    end
                end else
                    if xRec."Applies-to Doc. No." <> '' then
                        if FindFirstEmplLedgEntryWithAppliesToDocNo(AccNo, xRec."Applies-to Doc. No.") then begin
                            ClearEmplApplnEntryFields;
                            Codeunit.Run(Codeunit::"Empl. Entry-Edit", EmplLedgEntry);
                        end;
        end;
    end;

    local procedure ClearCustApplnEntryFields()
    begin
        CustLedgEntry."Accepted Pmt. Disc. Tolerance" := false;
        CustLedgEntry."Accepted Payment Tolerance" := 0;
        CustLedgEntry."Amount to Apply" := 0;
    end;

    local procedure ClearVendApplnEntryFields()
    begin
        VendLedgEntry."Accepted Pmt. Disc. Tolerance" := false;
        VendLedgEntry."Accepted Payment Tolerance" := 0;
        VendLedgEntry."Amount to Apply" := 0;
    end;

    local procedure ClearEmplApplnEntryFields()
    begin
        EmplLedgEntry."Amount to Apply" := 0;
    end;

    local procedure FindFirstCustLedgEntryWithAppliesToID(AccNo: Code[20]; AppliesToID: Code[50]): Boolean
    begin
        CustLedgEntry.Reset;
        CustLedgEntry.SetCurrentkey("Customer No.", "Applies-to ID", Open);
        CustLedgEntry.SetRange("Customer No.", AccNo);
        CustLedgEntry.SetRange("Applies-to ID", AppliesToID);
        CustLedgEntry.SetRange(Open, true);
        exit(CustLedgEntry.FindFirst)
    end;

    local procedure FindFirstCustLedgEntryWithAppliesToDocNo(AccNo: Code[20]; AppliestoDocNo: Code[20]): Boolean
    begin
        CustLedgEntry.Reset;
        CustLedgEntry.SetCurrentkey("Document No.");
        CustLedgEntry.SetRange("Document No.", AppliestoDocNo);
        CustLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
        CustLedgEntry.SetRange("Customer No.", AccNo);
        CustLedgEntry.SetRange(Open, true);
        exit(CustLedgEntry.FindFirst)
    end;

    local procedure FindFirstVendLedgEntryWithAppliesToID(AccNo: Code[20]; AppliesToID: Code[50]): Boolean
    begin
        VendLedgEntry.Reset;
        VendLedgEntry.SetCurrentkey("Vendor No.", "Applies-to ID", Open);
        VendLedgEntry.SetRange("Vendor No.", AccNo);
        VendLedgEntry.SetRange("Applies-to ID", AppliesToID);
        VendLedgEntry.SetRange(Open, true);
        exit(VendLedgEntry.FindFirst)
    end;

    local procedure FindFirstVendLedgEntryWithAppliesToDocNo(AccNo: Code[20]; AppliestoDocNo: Code[20]): Boolean
    begin
        VendLedgEntry.Reset;
        VendLedgEntry.SetCurrentkey("Document No.");
        VendLedgEntry.SetRange("Document No.", AppliestoDocNo);
        VendLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
        VendLedgEntry.SetRange("Vendor No.", AccNo);
        VendLedgEntry.SetRange(Open, true);
        exit(VendLedgEntry.FindFirst)
    end;

    local procedure FindFirstEmplLedgEntryWithAppliesToID(AccNo: Code[20]; AppliesToID: Code[50]): Boolean
    begin
        EmplLedgEntry.Reset;
        EmplLedgEntry.SetCurrentkey("Employee No.", "Applies-to ID", Open);
        EmplLedgEntry.SetRange("Employee No.", AccNo);
        EmplLedgEntry.SetRange("Applies-to ID", AppliesToID);
        EmplLedgEntry.SetRange(Open, true);
        exit(EmplLedgEntry.FindFirst)
    end;

    local procedure FindFirstEmplLedgEntryWithAppliesToDocNo(AccNo: Code[20]; AppliestoDocNo: Code[20]): Boolean
    begin
        EmplLedgEntry.Reset;
        EmplLedgEntry.SetCurrentkey("Document No.");
        EmplLedgEntry.SetRange("Document No.", AppliestoDocNo);
        EmplLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
        EmplLedgEntry.SetRange("Employee No.", AccNo);
        EmplLedgEntry.SetRange(Open, true);
        exit(EmplLedgEntry.FindFirst)
    end;

    procedure SetApplyToAmount()
    begin
        case "Account Type" of
            "account type"::Customer:
                begin
                    CustLedgEntry.SetCurrentkey("Document No.");
                    CustLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
                    CustLedgEntry.SetRange("Customer No.", "Account No.");
                    CustLedgEntry.SetRange(Open, true);
                    if CustLedgEntry.Find('-') then
                        if CustLedgEntry."Amount to Apply" = 0 then begin
                            CustLedgEntry.CalcFields("Remaining Amount");
                            CustLedgEntry."Amount to Apply" := CustLedgEntry."Remaining Amount";
                            Codeunit.Run(Codeunit::"Cust. Entry-Edit", CustLedgEntry);
                        end;
                end;
            "account type"::Vendor:
                begin
                    VendLedgEntry.SetCurrentkey("Document No.");
                    VendLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
                    VendLedgEntry.SetRange("Vendor No.", "Account No.");
                    VendLedgEntry.SetRange(Open, true);
                    if VendLedgEntry.Find('-') then
                        if VendLedgEntry."Amount to Apply" = 0 then begin
                            VendLedgEntry.CalcFields("Remaining Amount");
                            VendLedgEntry."Amount to Apply" := VendLedgEntry."Remaining Amount";
                            Codeunit.Run(Codeunit::"Vend. Entry-Edit", VendLedgEntry);
                        end;
                end;
            "account type"::Employee:
                begin
                    EmplLedgEntry.SetCurrentkey("Document No.");
                    EmplLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
                    EmplLedgEntry.SetRange("Employee No.", "Account No.");
                    EmplLedgEntry.SetRange(Open, true);
                    if EmplLedgEntry.Find('-') then
                        if EmplLedgEntry."Amount to Apply" = 0 then begin
                            EmplLedgEntry.CalcFields("Remaining Amount");
                            EmplLedgEntry."Amount to Apply" := EmplLedgEntry."Remaining Amount";
                            Codeunit.Run(Codeunit::"Empl. Entry-Edit", EmplLedgEntry);
                        end;
                end;
        end;
    end;

    procedure ClearAppliedGenJnlLine()
    var
        GenJournalLine: Record "Payment Line";
    begin
        if "Applies-to Doc. No." = '' then
            exit;
        GenJournalLine.SetRange(No, No);
        GenJournalLine.SetFilter("Line No.", '<>%1', "Line No.");
        //GenJournalLine.SetRange("Document Type", "Applies-to Doc. Type");
        GenJournalLine.SetRange("Applies-to Doc. No.", "Applies-to Doc. No.");
        GenJournalLine.ModifyAll("Account No.", '');
    end;

    procedure ValidateApplyRequirements(TempGenJnlLine: Record "Payment Line" temporary)
    begin


        case TempGenJnlLine."Account Type" of
            TempGenJnlLine."account type"::Customer:
                if TempGenJnlLine."Applies-to ID" <> '' then begin
                    CustLedgEntry.SetCurrentkey("Customer No.", "Applies-to ID", Open);
                    CustLedgEntry.SetRange("Customer No.", TempGenJnlLine."Account No.");
                    CustLedgEntry.SetRange("Applies-to ID", TempGenJnlLine."Applies-to ID");
                    CustLedgEntry.SetRange(Open, true);
                    if CustLedgEntry.Find('-') then
                        repeat
                            if TempGenJnlLine.Date < CustLedgEntry."Posting Date" then
                                Error(
                                  Text015, TempGenJnlLine."Document Type", TempGenJnlLine.No,
                                  CustLedgEntry."Document Type", CustLedgEntry."Document No.");
                        until CustLedgEntry.Next = 0;
                end else
                    if TempGenJnlLine."Applies-to Doc. No." <> '' then begin
                        CustLedgEntry.SetCurrentkey("Document No.");
                        CustLedgEntry.SetRange("Document No.", TempGenJnlLine."Applies-to Doc. No.");
                        if TempGenJnlLine."Applies-to Doc. Type" <> TempGenJnlLine."applies-to doc. type"::" " then
                            CustLedgEntry.SetRange("Document Type", TempGenJnlLine."Applies-to Doc. Type");
                        CustLedgEntry.SetRange("Customer No.", TempGenJnlLine."Account No.");
                        CustLedgEntry.SetRange(Open, true);
                        if CustLedgEntry.Find('-') then
                            if TempGenJnlLine.Date < CustLedgEntry."Posting Date" then
                                Error(
                                  Text015, TempGenJnlLine."Document Type", TempGenJnlLine.No,
                                  CustLedgEntry."Document Type", CustLedgEntry."Document No.");
                    end;
            TempGenJnlLine."account type"::Vendor:
                if TempGenJnlLine."Applies-to ID" <> '' then begin
                    VendLedgEntry.SetCurrentkey("Vendor No.", "Applies-to ID", Open);
                    VendLedgEntry.SetRange("Vendor No.", TempGenJnlLine."Account No.");
                    VendLedgEntry.SetRange("Applies-to ID", TempGenJnlLine."Applies-to ID");
                    VendLedgEntry.SetRange(Open, true);
                    repeat
                        if TempGenJnlLine.Date < VendLedgEntry."Posting Date" then
                            Error(
                              Text015, TempGenJnlLine."Document Type", TempGenJnlLine.No,
                              VendLedgEntry."Document Type", VendLedgEntry."Document No.");
                    until VendLedgEntry.Next = 0;
                    if VendLedgEntry.Find('-') then
                        ;
                end else
                    if TempGenJnlLine."Applies-to Doc. No." <> '' then begin
                        VendLedgEntry.SetCurrentkey("Document No.");
                        VendLedgEntry.SetRange("Document No.", TempGenJnlLine."Applies-to Doc. No.");
                        if TempGenJnlLine."Applies-to Doc. Type" <> TempGenJnlLine."applies-to doc. type"::" " then
                            VendLedgEntry.SetRange("Document Type", TempGenJnlLine."Applies-to Doc. Type");
                        VendLedgEntry.SetRange("Vendor No.", TempGenJnlLine."Account No.");
                        VendLedgEntry.SetRange(Open, true);
                        if VendLedgEntry.Find('-') then
                            if TempGenJnlLine.Date < VendLedgEntry."Posting Date" then
                                Error(
                                  Text015, TempGenJnlLine."Document Type", TempGenJnlLine.No,
                                  VendLedgEntry."Document Type", VendLedgEntry."Document No.");
                    end;
            TempGenJnlLine."account type"::Employee:
                if TempGenJnlLine."Applies-to ID" <> '' then begin
                    EmplLedgEntry.SetCurrentkey("Employee No.", "Applies-to ID", Open);
                    EmplLedgEntry.SetRange("Employee No.", TempGenJnlLine."Account No.");
                    EmplLedgEntry.SetRange("Applies-to ID", TempGenJnlLine."Applies-to ID");
                    EmplLedgEntry.SetRange(Open, true);
                    repeat
                        if TempGenJnlLine.Date < EmplLedgEntry."Posting Date" then
                            Error(
                              Text015, TempGenJnlLine."Document Type", TempGenJnlLine.No,
                              EmplLedgEntry."Document Type", EmplLedgEntry."Document No.");
                    until EmplLedgEntry.Next = 0;
                    if EmplLedgEntry.Find('-') then
                        ;
                end else
                    if TempGenJnlLine."Applies-to Doc. No." <> '' then begin
                        EmplLedgEntry.SetCurrentkey("Document No.");
                        EmplLedgEntry.SetRange("Document No.", TempGenJnlLine."Applies-to Doc. No.");
                        if TempGenJnlLine."Applies-to Doc. Type" <> EmplLedgEntry."applies-to doc. type"::" " then
                            EmplLedgEntry.SetRange("Document Type", TempGenJnlLine."Applies-to Doc. Type");
                        EmplLedgEntry.SetRange("Employee No.", TempGenJnlLine."Account No.");
                        EmplLedgEntry.SetRange(Open, true);
                        if EmplLedgEntry.Find('-') then
                            if TempGenJnlLine.Date < EmplLedgEntry."Posting Date" then
                                Error(
                                  Text015, TempGenJnlLine."Document Type", TempGenJnlLine.No,
                                  EmplLedgEntry."Document Type", EmplLedgEntry."Document No.");
                    end;
        end;
    end;

}

