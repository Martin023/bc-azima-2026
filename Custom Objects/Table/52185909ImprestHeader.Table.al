table 52185909 "Imprest Header"
{
    DrillDownPageID = "Imprest Vouchers List";
    LookupPageID = "Imprest Vouchers List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Description = 'Stores the reference of the payment voucher in the database';
            NotBlank = false;
        }
        field(2; Date; Date)
        {
            Description = 'Stores the date when the payment voucher was inserted into the system';

            trigger OnValidate()
            begin
                // if ImpLinesExist then begin
                //     Error('You first need to delete the existing imprest lines before changing the Currency Code'
                //     );
                // end;

                if "Currency Code" = xRec."Currency Code" then
                    //UpdateCurrencyFactor;

                if "Currency Code" <> xRec."Currency Code" then begin
                        //UpdateCurrencyFactor;
                        //RecreatePurchLines(FIELDCAPTION("Currency Code"));
                        // end else
                        //     if "Currency Code" <> '' then
                        //UpdateCurrencyFactor;

                        // UpdateHeaderToLine;
                    end;
            end;
        }
        field(3; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(4; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = true;
            Enabled = true;
            TableRelation = Currency;

            trigger OnValidate()
            begin
                // if ImpLinesExist then begin
                //     Error('You first need to delete the existing imprest lines before changing the Currency Code'
                //     );
                // end;

                // if "Currency Code" = xRec."Currency Code" then
                //UpdateCurrencyFactor;

                if "Currency Code" <> xRec."Currency Code" then begin
                    //UpdateCurrencyFactor;
                    //RecreatePurchLines(FIELDCAPTION("Currency Code"));
                    // end else
                    //     if "Currency Code" <> '' then
                    //UpdateCurrencyFactor;
                end;
                // UpdateHeaderToLine;
            end;
        }
        field(9; Payee; Text[100])
        {
            Description = 'Stores the name of the person who received the money';
        }
        field(10; "On Behalf Of"; Text[100])
        {
            Description = 'Stores the name of the person on whose behalf the payment voucher was taken';
        }
        field(11; Cashier; Code[50])
        {
            Description = 'Stores the identifier of the cashier in the database';
            TableRelation = "User Setup"."User ID";
            Editable = false;
        }
        field(16; Posted; Boolean)
        {
            Description = 'Stores whether the payment voucher is posted or not';
        }
        field(17; "Date Posted"; Date)
        {
            Description = 'Stores the date when the payment voucher was posted';
        }
        field(18; "Time Posted"; Time)
        {
            Description = 'Stores the time when the payment voucher was posted';
        }
        field(19; "Posted By"; Code[50])
        {
            Description = 'Stores the name of the person who posted the payment voucher';
        }
        field(20; "Total Payment Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Line".Amount WHERE(No = FIELD("No.")));
            Description = 'Stores the amount of the payment voucher';
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; "Paying Bank Account"; Code[20])
        {
            Description = 'Stores the name of the paying bank account in the database';
            TableRelation = "Bank Account"."No." WHERE("Currency Code" = FIELD("Currency Code"), "Bank Type" = const(Cashier));

            trigger OnValidate()
            begin
                BankAcc.Reset;
                "Bank Name" := '';
                if BankAcc.Get("Paying Bank Account") then begin
                    "Bank Name" := BankAcc.Name;
                    if BankAcc."Bank Type" <> BankAcc."Bank Type"::Cashier then
                        Error('The bank type should be Cashier');
                end;
            end;
        }
        field(30; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 1);
                DimVal.SetRange(DimVal.Code, "Global Dimension 1 Code");
                if DimVal.Find('-') then
                    "Function Name" := DimVal.Name;

                // UpdateHeaderToLine;
                // 
            end;
        }
        field(35; Status; Option)
        {
            Description = 'Stores the status of the record in the database';
            OptionMembers = Pending,"1st Approval","2nd Approval","Cheque Printing",Posted,Cancelled,Checking,VoteBook,"Pending Approval",Approved;
            trigger OnValidate()
            var
                GlobalFunctions: Codeunit "Global Functions";

            begin
                // if (Rec.Status = Status::Cancelled) or (Rec.Status = Status::Approved) then
                //     GlobalFunctions.CommentsManagement(Rec."No.");
            end;
        }
        field(38; "Payment Type"; Option)
        {
            OptionMembers = Imprest;
        }
        field(45; "Bankers Cheque No"; Code[6])
        {
            Editable = true;
            TableRelation = "Bankers Cheques Register"."Cheque No." WHERE("Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"),
                                                                           "Global Dimension 2 Code" = FIELD("Shortcut Dimension 2 Code"),
                                                                           Status = FILTER(Pending));

            trigger OnValidate()
            begin
                if "Pay Mode" = "Pay Mode"::Cheque then
                    "Cheque No." := "Bankers Cheque No" else
                    "Cheque No." := "No.";
            end;
        }
        field(56; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 2 Code");
                if DimVal.Find('-') then
                    "Budget Center Name" := DimVal.Name;

                // UpdateHeaderToLine;
                // 
            end;
        }
        field(57; "Function Name"; Text[100])
        {
            Description = 'Stores the name of the function in the database';
        }
        field(58; "Budget Center Name"; Text[100])
        {
            Description = 'Stores the name of the budget center in the database';
        }
        field(59; "Bank Name"; Text[100])
        {
            Description = 'Stores the description of the paying bank account in the database';
        }
        field(60; "No. Series"; Code[20])
        {
            Description = 'Stores the number series in the database';
        }
        field(61; Select; Boolean)
        {
            Description = 'Enables the user to select a particular record';
        }
        field(62; "Total VAT Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Line"."VAT Amount" WHERE(No = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(63; "Total Witholding Tax Amount"; Decimal)
        {
            CalcFormula = Sum("Payment Line"."Withholding Tax Amount" WHERE(No = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(64; "Total Net Amount"; Decimal)
        {
            CalcFormula = Sum("Imprest Lines".Amount WHERE(No = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(65; "Current Status"; Code[20])
        {
            Description = 'Stores the current status of the payment voucher in the database';
        }
        field(66; "Cheque No."; Code[20])
        {

            trigger OnValidate()
            begin
                "Cheque No." := "Bankers Cheque No";
            end;
        }
        field(67; "Pay Mode"; Option)
        {
            OptionMembers = " ",Cash,Cheque,EFT,"Letter of Credit",Mpesa,"Custom 4","Custom 5";
            Editable = true;

            trigger OnValidate()
            begin
                if "Pay Mode" = "Pay Mode"::Cheque then
                    "Cheque No." := "Bankers Cheque No" else
                    "Cheque No." := "No.";
            end;
        }
        field(68; "Payment Release Date"; Date)
        {

            trigger OnValidate()
            begin

                //Changed to ensure Release date is not less than the Date entered
                if "Payment Release Date" < Date then
                    Error('The Payment Release Date cannot be lesser than the Document Date');
            end;
        }
        field(69; "No. Printed"; Integer)
        {
        }
        field(70; "VAT Base Amount"; Decimal)
        {
        }
        field(71; "Exchange Rate"; Decimal)
        {
        }
        field(72; "Currency Reciprical"; Decimal)
        {
        }
        field(73; "Current Source A/C Bal."; Decimal)
        {
        }
        field(74; "Cancellation Remarks"; Text[250])
        {
        }
        field(75; "Register Number"; Integer)
        {
        }
        field(76; "From Entry No."; Integer)
        {
        }
        field(77; "To Entry No."; Integer)
        {
        }
        field(78; "Invoice Currency Code"; Code[10])
        {
            Caption = 'Invoice Currency Code';
            Editable = true;
            TableRelation = Currency;
        }
        field(79; "Total Net Amount LCY"; Decimal)
        {
            CalcFormula = Sum("Imprest Lines"."Amount LCY" WHERE(No = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(80; "Document Type"; Enum "Approval Document Type")
        {
            //OptionMembers = "Payment Voucher","Petty Cash";
            ValuesAllowed = "Payment Voucher", "Petty Cash";
        }
        field(81; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Description = 'Stores the reference of the Third global dimension in the database';

            trigger OnLookup()
            begin
                // 
                Validate("Shortcut Dimension 3 Code");
            end;

            trigger OnValidate()
            begin
                DimVal.Reset;
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 3 Code");
                if DimVal.Find('-') then
                    Dim3 := DimVal.Name;

                // UpdateHeaderToLine;
            end;
        }
        field(82; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            Description = 'Stores the reference of the Third global dimension in the database';

            trigger OnLookup()
            begin
                // 
                Validate("Shortcut Dimension 4 Code");
            end;

            trigger OnValidate()
            begin
                DimVal.Reset;
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 4 Code");
                if DimVal.Find('-') then
                    Dim4 := DimVal.Name;

                // UpdateHeaderToLine;
            end;
        }
        field(83; Dim3; Text[250])
        {
        }
        field(84; Dim4; Text[250])
        {
        }
        field(85; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility CenterBR";

            trigger OnValidate()
            begin

                TestField(Status, Status::Pending);
                if not UserMgt.CheckRespCenter(1, "Shortcut Dimension 3 Code") then
                    Error(
                      Text001,
                      RespCenter.TableCaption, UserMgt.GetPurchasesFilter);
                /*
               "Location Code" := UserMgt.GetLocation(1,'',"Responsibility Center");
               IF "Location Code" = '' THEN BEGIN
                 IF InvtSetup.GET THEN
                   "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
               END ELSE BEGIN
                 IF Location.GET("Location Code") THEN;
                 "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
               END;

               UpdateShipToAddress;
                  */
                /*
             CreateDim(
               DATABASE::"Responsibility Center","Responsibility Center",
               DATABASE::Vendor,"Pay-to Vendor No.",
               DATABASE::"Salesperson/Purchaser","Purchaser Code",
               DATABASE::Campaign,"Campaign No.");

             IF xRec."Responsibility Center" <> "Responsibility Center" THEN BEGIN
               RecreatePurchLines(FIELDCAPTION("Responsibility Center"));
               "Assigned User ID" := '';
             END;
               */

            end;
        }
        field(86; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            Editable = false;
            // OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            // OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(87; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            Editable = true;
            TableRelation = IF ("Account Type" = CONST(Customer)) Customer where("Account Type" = const("Staff Imprest"));

            trigger OnValidate()
            begin
                Cust.Reset;
                if Cust.Get("Account No.") then begin
                    Cust.TestField("Gen. Bus. Posting Group");
                    Cust.TestField(Blocked, Cust.Blocked::" ");
                    Payee := Cust.Name;
                    "On Behalf Of" := Cust.Name;

                    //Check CreditLimit Here In cases where you have a credit limit set for employees
                    if Cust."Credit Limit (LCY)" <> 0 then begin
                        Cust.CalcFields(Cust."Balance (LCY)");
                        if Cust."Balance (LCY)" > Cust."Credit Limit (LCY)" then
                            Error('The allowable unaccounted balance of %1 has been exceeded', Cust."Credit Limit (LCY)");
                    end;
                    Cust.CalcFields("Balance (LCY)");
                    "Outstanding Imprest" := Cust."Balance (LCY)";
                    if Cust."Balance (LCY)" > 0 then begin
                        if not Confirm
                        ('This member already has a imprest balance due of %1. This will be sent to the Head Of Finance for approval, Do you wish to continue?', false, Cust."Balance (LCY)") then
                            error('Member has a pending imprest balance');
                    end;


                    if cust."Account Type" = cust."Account Type"::"Staff Imprest" then begin
                        HrEmployees.reset;
                        HrEmployees.SetRange("User ID", UserId);
                        if HrEmployees.Find('-') then begin
                            "PF/Staff No" := HrEmployees."No.";
                            "Recommender ID" := HrEmployees."Supervisor Code";
                        end;
                    end;
                end;


            end;
        }
        field(88; "Surrender Status"; Option)
        {
            OptionMembers = " ",Full,Partial;
        }
        field(89; Purpose; Text[250])
        {
        }
        field(90; "Employee Job Group"; Code[10])
        {
            Editable = false;
            TableRelation = "Employee Statistics Group";
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin

            end;
        }
        field(50000; Requisition; Code[20])
        {
            TableRelation = "Purchase Header"."No.";
        }
        field(5000; "PF/Staff No"; code[20])
        {
            Caption = 'PF/Staff No';
            Editable = false;
            TableRelation = "HR Employees"."No.";
        }
        field(50001; "Approved By"; code[50])
        {
            Caption = 'Approved By';
            Editable = false;
        }
        field(50002; "Recommender ID"; Code[50])
        {
            Caption = 'Recommender/HOD';
            Editable = false;
        }
        field(50003; "Outstanding Imprest"; Decimal)
        {
            Editable = false;
        }
        field(50004; "Purpose 2"; Code[20])
        {
            Caption = 'Imprest Holder';
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

    trigger OnDelete()
    begin
        if (Status = Status::Approved) or (Status = Status::Posted) or (Status = Status::"Pending Approval") then
            Error('You Cannot Delete this record its status is not Pending');
    end;

    trigger OnInsert()
    var
        Customer: Record Customer;
        i: Integer;
        OPenrecords: code[250];
        CashierTrans: record "Imprest Header";
    begin
        if "No." = '' then begin
            GenLedgerSetup.Get;
            if "Payment Type" = "Payment Type"::Imprest then begin
                GenLedgerSetup.TestField(GenLedgerSetup."Imprest Req No");
                "No." := NoSeriesMgt.GetNextNo(GenLedgerSetup."Imprest Req No");
                // NoSeriesMgt.InitSeries(GenLedgerSetup."Imprest Req No", xRec."No. Series", 0D, "No.", "No. Series");
            end
        end;


        // UserTemplate.Reset;
        // UserTemplate.SetRange(UserTemplate.UserID, UserId);
        // if UserTemplate.FindFirst then begin
        //     "Paying Bank Account" := UserTemplate."Default Payment Bank";
        //     Validate("Paying Bank Account");
        // end;

        i := 0;
        CashierTrans.RESET;
        CashierTrans.SETRANGE(Cashier, USERID);
        CashierTrans.SETFILTER(Posted, '%1', FALSE);
        CashierTrans.SetFilter(Status, '<>%1', Status::Cancelled);
        IF CashierTrans.FIND('-') THEN BEGIN
            REPEAT
                i += 1;
                OPenrecords := CashierTrans."No.";
            UNTIL CashierTrans.NEXT = 0;
        END;

        // IF i > 1 THEN ERROR('You are not allowed to open multiple applications.Complete %1 first.', OPenrecords);


        //Date := Today;
        Cashier := UserId;
        Validate(Cashier);

        UserSetup.Reset;
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.Find('-') then
            "Responsibility Center" := UserSetup."Responsibility Centre";
        //"Global Dimension 1 Code" := 'FINANCE';

        //
        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Imprest Account");
            "Account Type" := "Account Type"::Customer;
            "Account No." := UserSetup."Imprest Account";
            //Validate("Account No.");
        end else
            Error('User must be setup under User Setup and their respective Account Entered');

        Customer.Reset;
        Customer.SetRange("No.", Rec."Account No.");
        Customer.SetRange("Account Type", Customer."Account Type"::"Staff Imprest");
        if Customer.Find('-') then begin
            Rec.CalcFields("Total Net Amount");
            if Customer."Credit Limit (LCY)" = 0
              then
                Message('Imprest Credit Limit is zero.');
        end;
        Date := Today;
    end;

    trigger OnModify()
    begin
        //if rec.Posted then Error('You cannot post a posted Imprest transaction');
    end;

    var
        CStatus: Code[20];
        PVUsers: Record "W/P Budget Buffer";
        UserTemplate: Record "Cash Office User Template";
        GLAcc: Record "G/L Account";
        Cust: Record Customer;
        Vend: Record Vendor;
        FA: Record "Fixed Asset";
        BankAcc: Record "Bank Account";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        GenLedgerSetup: Record "Cash Office Setup";
        RecPayTypes: Record "Receipts and Payment Types";
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
        GenLedSetup: Record "General Ledger Setup";
        "Total Budget": Decimal;
        CommittedAmount: Decimal;
        MonthBudget: Decimal;
        Expenses: Decimal;
        Header: Text[250];
        "Date From": Text[30];
        "Date To": Text[30];
        LastDay: Date;
        TotAmt: Decimal;
        DimVal: Record "Dimension Value";
        RespCenter: Record "Responsibility CenterBR";
        UserMgt: Codeunit "User Setup Management BR";
        Text001: Label 'Your identification is set up to process from %1 %2 only.';
        Pline: Record "Imprest Lines";
        CurrExchRate: Record "Currency Exchange Rate";
        ImpLines: Record "Imprest Lines";
        UserSetup: Record "User Setup";
        DImMgt: Codeunit DimensionManagement;
        HrEmployees: Record "HR Employees";


    procedure UpdateHeaderToLine()
    var
        PayLine: Record "Imprest Lines";
    begin
        PayLine.Reset;
        PayLine.SetRange(PayLine.No, "No.");
        if PayLine.Find('-') then begin
            repeat
                PayLine."Imprest Holder" := "Account No.";
                PayLine."Global Dimension 1 Code" := "Global Dimension 1 Code";
                PayLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                PayLine."Dimension Set ID" := "Dimension Set ID";
                PayLine."Currency Code" := "Currency Code";
                PayLine."Currency Factor" := "Currency Factor";
                PayLine.Validate("Currency Factor");
                PayLine.Modify;
            until PayLine.Next = 0;
        end;
    end;

    local procedure UpdateCurrencyFactor()
    var
        CurrencyDate: Date;
    begin
        if "Currency Code" <> '' then begin
            CurrencyDate := Date;
            "Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, "Currency Code");
        end else
            "Currency Factor" := 0;
    end;

    //  [Scope('OnPrem')]
    procedure ImpLinesExist(): Boolean
    begin
        ImpLines.Reset;
        ImpLines.SetRange(No, "No.");
        exit(ImpLines.FindFirst);
    end;

    // [Scope('OnPrem')]
    procedure ShowDimensions()
    begin
        "Dimension Set ID" :=
          DImMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', 'Imprest', "No."));
        //VerifyItemLineDim;
        DImMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    // [Scope('OnPrem')]
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DImMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    //  [Scope('OnPrem')]
    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DImMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
    end;

    // [Scope('OnPrem')]
    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DImMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;
}

