table 52185682 "Checkoff  Receipt Transactions"
{
    DrillDownPageID = "Checkoff Receipt Trans List";
    LookupPageID = "Checkoff Receipt Trans List";

    fields
    {
        field(1; No; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin

                if No <> xRec.No then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(GenLedgerSetup."Receipts No");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Account No"; Code[20])
        {
            TableRelation = Customer WHERE("Account Type" = CONST(Employer));

            trigger OnValidate()
            begin
                BosaReceiptLines.Reset;
                BosaReceiptLines.SetRange(BosaReceiptLines."Transaction No", No);
                if BosaReceiptLines.FindFirst then Error('Kindly delete the allocated amounts before changing the Member No.');

                Amount := 0;
                "Available Balance" := 0;
                "Remaining Amount" := 0;

                Account.Reset;
                if Account.Get("Account No") then begin
                    /*IF (Account.Status<>Account.Status::New) AND (Account.Status<>Account.Status::Active) AND (Account.Status<>Account.Status::Dormant) THEN
                    ERROR(Text0001);*/
                    "Account Name" := Account.Name;
                    Payee := Account.Name;
                    Remarks := "Account Name";
                    "Currency Code" := Account."Currency Code";
                    "ID No" := Account."Primary Identification";
                    "Member No." := Account."No.";
                end;

                //Type:=Type::"2;




                //CalcAvailableBal;

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
            begin

                if TransactionTypes.Get("Transaction Type") then begin
                    "Transaction Description" := TransactionTypes.Description;
                    Type := TransactionTypes.Type;

                end;


                if Type = Type::"Credit Cheque" then begin

                    BUserSetup.Reset;
                    BUserSetup.SetRange(BUserSetup.UserID, UserId);
                    if BUserSetup.Find('-') then begin

                        "Employer No" := BUserSetup."Cheque Clearance Account";
                    end;
                end;

                //CalcAvailableBal;
            end;
        }
        field(5; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                if Amount < 0 then Error('Amount cannot be less than zero');

                CalcAvailableBal;
                CalcFields("Allocated Amount");
                "Remaining Amount" := Amount - "Allocated Amount";
            end;
        }
        field(6; Cashier; Code[50])
        {
            Editable = false;
        }
        field(7; "Transaction Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Transaction Date" > Today then Error('System does not allow post-dated transactions');
                if Type = Type::"Credit Cheque" then "Cheque Date" := "Transaction Date";
            end;
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

                if ChequeTypes.Get("Cheque Type") then begin
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
        }
        field(14; "Cheque Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Cheque Date" > Today then
                    Error('Post dating not allowed');
            end;
        }
        field(15; Payee; Text[100])
        {
        }
        field(16; Remarks; Text[50])
        {
        }
        field(17; Type; Enum "Fosa Transaction Types")//Option)
        {
            // OptionCaption = 'Credit Receipt,Credit Cheque';
            // OptionMembers = "Credit Receipt","Credit Cheque";

            trigger OnValidate()
            begin
                "Employer No" := '';
                if Type = Type::"Credit Cheque" then begin

                    BUserSetup.Reset;
                    BUserSetup.SetRange(BUserSetup.UserID, UserId);
                    if BUserSetup.Find('-') then begin

                        "Employer No" := BUserSetup."Cheque Clearance Account";
                    end;
                end;
            end;
        }
        field(18; "Transaction Description"; Text[50])
        {
        }
        field(19; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Posted';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Posted;
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
        field(37; "Employer No"; Code[20])
        {
            TableRelation = Customer WHERE("Account Type" = CONST(Employer));

            trigger OnValidate()
            begin
                if Customer.Get("Employer No") then begin
                    "Employer  Account Name" := Customer.Name;
                end;

                if "Posting Period" <> 0D then
                    Validate("Posting Period");
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
            OptionCaption = 'Pending,Stopped,Bounced,Honoured';
            OptionMembers = Pending,Stopped,Bounced,Honoured;
        }
        field(45; "Bankers Cheque No"; Code[6])
        {
            TableRelation = "Bankers Cheques Register"."Cheque No." WHERE(Status = FILTER(Pending),
                                                                           "Global Dimension 2 Code" = FIELD("Global Dimension 2 Code"));
        }
        field(46; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(47; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(48; "Allocated Amount"; Decimal)
        {
            CalcFormula = Sum("Checkoff  Receipt Trans Lines".Amount WHERE("Transaction No" = FIELD(No)));
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup()
            begin
                //hhujkhkhjk
            end;
        }
        field(49; "Posting Period"; Date)
        {
            TableRelation = "Interest Due Period"."Interest Due Date";

            trigger OnValidate()
            begin

                TestField("Employer No");

                // "Document No" := "Employer No" + '_' + Format(DetermineMonth(Date2DMY("Posting Period", 2))) + '/' + Format(Date2DMY("Posting Period", 3)) + ' REMIT';

                Remarks := "Document No";
            end;
        }
        field(50; "Document No"; Code[50])
        {
            Editable = false;
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
        field(50009; "Product Category"; Option)
        {
            OptionCaption = ' ,Share Capital,Deposit Contribution,Fixed Deposit,Junior Savings,Registration Fee';
            OptionMembers = " ","Share Capital","Deposit Contribution","Fixed Deposit","Junior Savings","Registration Fee";
        }
        field(50010; "Till Code"; Code[20])
        {
        }
        field(50011; "Cheque Clearing Bank"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(50012; "Remaining Amount"; Decimal)
        {
            Editable = false;
        }
        field(50013; "Employer  Account Name"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
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
        GenLedgerSetup.Get();
        if No = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Cashier Transaction Nos.");
            No := NoSeriesMgt.GetNextNo(NoSetup."Cashier Transaction Nos.");
            // NoSeriesMgt.InitSeries(GenLedgerSetup."Receipts No", xRec."No. Series", 0D, No, "No. Series");

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
            if bankacc.Find('-') then begin
                "Till Name" := PadStr(BUserSetup."Default  Bank" + ' ' + bankacc.Name, 50)

            end;
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
        if Posted = true then
            Error('You cannot modify a POSTED transaction');

        if Status <> Status::Open then Error('You cannot modify a transaction that is not open');
        //PN

        if UpperCase(Cashier) <> UpperCase(UserId) then
            Error('You cannot modify a transaction you did not open');
    end;

    var
        NoSetup: Record "Banking No Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        Account: Record Members;
        TransactionTypes: Record "Transaction Types";
        Text0001: Label 'The account is not active and therefore cannot be transacted upon.';
        ChequeTypes: Record "Cheque Types";
        CDays: Integer;
        EMaturity: Date;
        i: Integer;
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
        RemainingAmount: Decimal;
        BosaReceiptLines: Record "Checkoff  Receipt Trans Lines";
        Customer: Record Customer;
        GenLedgerSetup: Record "Cash Office Setup";

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
            Account.CalcFields(Account.Balance, Account."Uncleared Cheques", Account."Authorised Over Draft", Account."Lien Placed");

            ProdType.Reset;
            ProdType.SetRange(ProdType."Product ID", "Product Type");
            if ProdType.Find('-') then begin
                MinBalance := ProdType."Minimum Balance";

                "Available Balance" := (Account.Balance + Account."Authorised Over Draft") - (MinBalance + Account."Uncleared Cheques" + TChargeAmount + Account."Lien Placed");

            end;
        end;
    end;

    local procedure CalcCharges()
    begin

        GenSetup.Get;

        TChargeAmount := 0;



        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type", "Transaction Type");
        if TransactionCharges.Find('-') then begin
            repeat

                ChargeAmount := 0;

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


                    TChargeAmount := TChargeAmount + ChargeAmount;

                    if TransactionCharges."Transaction Charge Category" <> TransactionCharges."Transaction Charge Category"::"Stamp Duty" then begin

                        //Excise Duty

                        TChargeAmount := TChargeAmount + (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;
                        ;
                    end;
                end;
            until TransactionCharges.Next = 0;
        end;


        /*
        //Charge withdrawal Frequency
        IF Type =Type::"Cash Withdrawal" THEN BEGIN
        IF Account.GET("Account No") THEN BEGIN
        IF AccountTypes.GET(Account."Product Type") THEN BEGIN
        IF Account."Last Withdrawal Date" <> 0D THEN BEGIN
        IF CALCDATE(AccountTypes."Withdrawal Interval",Account."Last Withdrawal Date") > TODAY THEN BEGIN
        //IF CALCDATE(AccountTypes."Withdrawal Interval",Account."Last Withdrawal Date") <= CALCDATE('1D',TODAY) THEN BEGIN
        
        
        
        TransactionCharges.RESET;
        TransactionCharges.SETRANGE(TransactionCharges."Transaction Type","Transaction Type");
        IF TransactionCharges.FIND('-') THEN BEGIN
        REPEAT
        
        IF (TransactionCharges."Transaction Charge Category"=TransactionCharges."Transaction Charge Category"::"Withdrawal Frequency") THEN BEGIN
        
        
        
        ChargeAmount:=0;
        IF TransactionCharges."Charge Type"=TransactionCharges."Charge Type"::"% of Amount" = TRUE THEN
        ChargeAmount:=(Amount*TransactionCharges."Percentage of Amount")*0.01
        ELSE ChargeAmount:=TransactionCharges."Charge Amount";
        
        IF TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::Staggered THEN BEGIN
        
        TransactionCharges.TESTFIELD(TransactionCharges."Staggered Charge Code");
        
        TariffDetails.RESET;
        TariffDetails.SETRANGE(TariffDetails.Code,TransactionCharges."Staggered Charge Code");
        IF TariffDetails.FIND('-') THEN BEGIN
        REPEAT
        IF (Amount >= TariffDetails."Lower Limit") AND (Amount <= TariffDetails."Upper Limit") THEN BEGIN
        IF TariffDetails."Use Percentage"=TRUE THEN BEGIN
          ChargeAmount:=Amount*TariffDetails.Percentage*0.01;
        END ELSE BEGIN
        ChargeAmount := TariffDetails."Charge Amount";
        END;
        END;
        UNTIL TariffDetails.NEXT =0;
        END;
        END;
        
        
        TChargeAmount:=TChargeAmount+ChargeAmount;
        
        
        IF TransactionCharges."Transaction Charge Category"<>TransactionCharges."Transaction Charge Category"::"Stamp Duty" THEN BEGIN
        
        //Excise Duty
        
        
        TChargeAmount:=TChargeAmount+(ChargeAmount*GenSetup."Excise Duty (%)")*0.01;
        END;
        END;
        UNTIL TransactionCharges.NEXT = 0;
        END;
        
        END;
        
        
        END;
        END;
        END;
        END;
        //Charge withdrawal Frequency
        
        
        
        //Penalty of maximum amount on transaction
        IF Type =Type::"Cash Withdrawal" THEN BEGIN
        IF TransType.GET("Transaction Type") THEN BEGIN
        
        Trans.RESET;
        Trans.SETRANGE(Trans."Transaction Date",TODAY);
        Trans.SETRANGE(Trans."Account No","Account No");
        Trans.SETRANGE(Posted,TRUE);
        Trans.SETRANGE(Trans.Type,Trans.Type::"Cash Withdrawal");
        IF Trans.FINDSET THEN BEGIN
          Trans.CALCSUMS(Trans.Amount);
        
        
        END;
        END;
        
        IF Trans.Amount>TransType."Upper Limit" THEN BEGIN
        
        
        //Charges
        TCharges:=0;
        
        TransactionCharges.RESET;
        TransactionCharges.SETRANGE(TransactionCharges."Transaction Type","Transaction Type");
        IF TransactionCharges.FIND('-') THEN BEGIN
        REPEAT
        
        IF (TransactionCharges."Transaction Charge Category"=TransactionCharges."Transaction Charge Category"::"Withdrawn Amount") THEN BEGIN
        
        
        
        ChargeAmount:=0;
        IF TransactionCharges."Charge Type"=TransactionCharges."Charge Type"::"% of Amount" = TRUE THEN
        ChargeAmount:=(Amount*TransactionCharges."Percentage of Amount")*0.01
        ELSE ChargeAmount:=TransactionCharges."Charge Amount";
        
        IF TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::Staggered THEN BEGIN
        
        TransactionCharges.TESTFIELD(TransactionCharges."Staggered Charge Code");
        
        TariffDetails.RESET;
        TariffDetails.SETRANGE(TariffDetails.Code,TransactionCharges."Staggered Charge Code");
        IF TariffDetails.FIND('-') THEN BEGIN
        REPEAT
        IF (Amount >= TariffDetails."Lower Limit") AND (Amount <= TariffDetails."Upper Limit") THEN BEGIN
        IF TariffDetails."Use Percentage"=TRUE THEN BEGIN
          ChargeAmount:=Amount*TariffDetails.Percentage*0.01;
        END ELSE BEGIN
        ChargeAmount := TariffDetails."Charge Amount";
        END;
        END;
        UNTIL TariffDetails.NEXT =0;
        END;
        END;
        
        TChargeAmount:=TChargeAmount+ChargeAmount;
        
        IF TransactionCharges."Transaction Charge Category"<>TransactionCharges."Transaction Charge Category"::"Stamp Duty" THEN BEGIN
        
        //Excise Duty
        
        TChargeAmount:=TChargeAmount+(ChargeAmount*GenSetup."Excise Duty (%)")*0.01;
        END;
        END;
        UNTIL TransactionCharges.NEXT = 0;
        END;
        END;
        END;
        
        //Penalty of maximum amount on transaction
        */

    end;

    [Scope('OnPrem')]
    procedure DetermineMonth(Month: Integer) StrMonth: Text[6]
    begin
        if Month = 1 then begin StrMonth := 'Jan' end;
        if Month = 2 then begin StrMonth := 'Feb' end;
        if Month = 3 then begin StrMonth := 'Mar' end;
        if Month = 4 then begin StrMonth := 'Apr' end;
        if Month = 5 then begin StrMonth := 'May' end;
        if Month = 6 then begin StrMonth := 'Jun' end;
        if Month = 7 then begin StrMonth := 'Jul' end;
        if Month = 8 then begin StrMonth := 'Aug' end;
        if Month = 9 then begin StrMonth := 'Sep' end;
        if Month = 10 then begin StrMonth := 'Oct' end;
        if Month = 11 then begin StrMonth := 'Nov' end;
        if Month = 12 then begin StrMonth := 'Dec' end;
    end;
}

