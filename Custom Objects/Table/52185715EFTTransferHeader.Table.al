table 52185715 "RTGS Transfer Header"
{
    LookupPageID = "RTGS Transfer List";
    DrillDownPageId = "RTGS Transfer List";

    fields
    {
        field(1; "No."; Code[10])
        {
            Editable = false;

            trigger OnValidate()
            begin
                //*
                if "No." <> xRec."No." then begin
                    SeriesSetup.Get();
                    NoSeriesMgt.TestManual(SeriesSetup."RTGS Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Date Entered"; Date)
        {
            Editable = false;
        }
        field(3; "Time Entered"; Time)
        {
            Editable = false;
        }
        field(5; "No. Series"; Code[10])
        {
            Editable = false;
        }
        field(6; "Account Type"; Enum "Gen. Journal Account Type")
        {
            // OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Savings,Credit';
            // OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Savings,Credit;
        }
        field(7; "Account No."; Code[20])
        {
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor
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
                BankAccount: Record "Bank Account";
            begin
                //*
                case "Account Type" of
                    "Account Type"::"Bank Account":
                        begin
                            if BankAccount.Get("Account No.") then
                                "Account Name" := BankAccount.Name;
                        end;
                end;
            end;
        }
        field(8; "Account Name"; Text[100])
        {
            Editable = false;
        }
        field(9; Remarks; Text[50])
        {
        }
        field(11; "Record Total"; Decimal)
        {
            CalcFormula = Sum("RTGS Transfer Lines".Amount WHERE("Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Record Count"; Integer)
        {
            CalcFormula = Count("RTGS Transfer Lines" WHERE("Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Document Type"; Option)
        {
            OptionCaption = 'Cash Deposit,Cash Withdrawal,Credit Receipt,Credit Cheque,Bankers Cheque,Cheque Deposit,Cheque Withdrawal,Salary Processing,Electronic Fund Transfer,RTGS';
            OptionMembers = "Cash Deposit","Cash Withdrawal","Credit Receipt","Credit Cheque","Bankers Cheque","Cheque Deposit","Cheque Withdrawal","Salary Processing","Electronic Fund Transfer",RTGS;

            trigger OnValidate()
            begin
                "Transaction Type" := '';
            end;
        }
        field(14; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(20; "Created By"; Code[60])
        {
            Editable = false;
        }
        field(21; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Open,Pending,Rejected,Approved,Transferred';
            OptionMembers = Open,Pending,Rejected,Approved,Transferred;
        }
        field(22; "Start Date"; Date)
        {
        }
        field(23; "End Date"; Date)
        {
        }
        field(24; "Date Transferred"; Date)
        {
            Editable = false;
        }
        field(25; "Time Transferred"; Time)
        {
            Editable = false;
        }
        field(26; "Transferred By"; Code[60])
        {
        }
        field(27; "Salary Processing No."; Code[20])
        {
        }
        field(28; "Salary Options"; Option)
        {
            OptionMembers = "Add To Existing","Replace Lines";
        }
        field(29; "Transaction Type"; Code[20])
        {
            TableRelation = IF ("Document Type" = CONST(RTGS)) "Transaction Types".Code WHERE(Type = CONST(RTGS))
            ELSE
            IF ("Document Type" = CONST(RTGS)) "Transaction Types".Code WHERE(Type = CONST(RTGS));

            trigger OnValidate()
            begin
                getCharges;
            end;
        }
        field(30; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(31; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(32; "Responsibility Centre"; Code[20])
        {
            Description = 'LookUp to Responsibility Center BR';
            Editable = false;
            TableRelation = "Responsibility Center";
        }
        field(33; "Standing Order RTGS Done"; Boolean)
        {
        }
        field(34; "Document No. Filter"; Code[250])
        {
            FieldClass = FlowFilter;
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
        //*
        if "No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."RTGS Nos.");
            "No." := NoSeriesMgt.GetNextNo(SeriesSetup."RTGS Nos.");
            // NoSeriesMgt.InitSeries(SeriesSetup."RTGS Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        //*
        "Date Entered" := Today;
        "Time Entered" := Time;
        "Created By" := UserId;
        UserSetup.Get(UserId);
        "Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        "Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        "Responsibility Centre" := UserSetup."Responsibility Centre";
    end;

    var
        SeriesSetup: Record "Banking No Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        Accounts: Record Vendor;
        Members: Record Vendor;
        AccountHolders: Record Vendor;
        Banks: Record "Bank Account";
        BanksList: Record "Loan Disbursement Header";
        RTGSDetails: Record "RTGS Transfer Lines";
        RTGSHeader: Record "RTGS Transfer Header";
        TransType: Record "Transaction Types";
        TransactionCharges: Record "Transaction Charges";
        TariffDetails: Record "Tiered Charges Lines";
        SAccount: Record "Savings Accounts";
        AvailableBal: Decimal;
        SCharge: Decimal;
        TCharge: Decimal;
        UserSetup: Record "User Setup";

    //[Scope('OnPrem')]
    procedure getCharges()
    var
        Text001: Label 'Account %1 has insufficient funds to enable successful transaction.';
    begin

        //*
        TCharge := 0;
        RTGSDetails.Reset;
        RTGSDetails.SetRange(RTGSDetails."Document No.", "No.");
        RTGSDetails.SetRange(RTGSDetails."Don't Charge", false);
        if RTGSDetails.Find('-') then begin
            repeat
                TransactionCharges.Reset;
                TransactionCharges.SetRange(TransactionCharges."Transaction Type", "Transaction Type");
                if TransactionCharges.Find('-') then begin
                    SCharge := 0;
                    repeat
                        if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::"% of Amount" then
                            SCharge := (RTGSDetails.Amount * TransactionCharges."Percentage of Amount") * 0.01
                        else
                            SCharge := TransactionCharges."Charge Amount";

                        if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::Staggered then begin
                            TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                            TariffDetails.Reset;
                            TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                            if TariffDetails.Find('-') then begin
                                repeat
                                    if (RTGSDetails.Amount >= TariffDetails."Lower Limit") and (RTGSDetails.Amount <= TariffDetails."Upper Limit") then begin
                                        if TariffDetails."Use Percentage" then
                                            SCharge := RTGSDetails.Amount * TariffDetails.Percentage * 0.01
                                        else
                                            SCharge := TariffDetails."Charge Amount";
                                    end;
                                until TariffDetails.Next = 0;
                            end;
                        end;
                        TCharge += SCharge;
                    until TransactionCharges.Next = 0;
                end;

                RTGSDetails."Charge Amount" := TCharge;
                //*
                AvailableBal := 0;
                if SAccount.Get(RTGSDetails."Account No.") then begin
                    SAccount.CalcFields(SAccount."Balance (LCY)");
                    AvailableBal := SAccount."Balance (LCY)" - (SAccount."Monthly Contribution" + RTGSDetails."Charge Amount");
                    if AvailableBal < RTGSDetails.Amount then
                        Error(Text001, RTGSDetails."Account No." + ' :-' + RTGSDetails."Account Name");
                end;

                RTGSDetails.Modify
          until RTGSDetails.Next = 0;
        end;
    end;
}

