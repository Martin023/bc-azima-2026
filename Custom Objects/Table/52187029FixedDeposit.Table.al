table 52187029 "Fixed Deposit Contract"
{
    DrillDownPageId = "Fixed Deposit Contract List";
    LookupPageId = "Fixed Deposit Contract list";
    Caption = 'Fixed/Call Deposit Contract';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
            SQLDataType = Varchar;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SeriesSetup.Get;
                    NoSeriesMgt.TestManual(SeriesSetup."Fixed Deposit Contract");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';

        }

        field(3; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,Blocked);
            end;
        }
        field(4; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Last Date Modified");
            end;
        }

        field(5; "Recruited By"; Code[10])
        {
            Caption = 'Salesperson Code';
            Description = 'LookUp to Salesperson/Purchaser Table';
            TableRelation = "Salesperson/Purchaser";
        }

        field(6; Comment; Boolean)
        {
            CalcFormula = Exist("Comment Line" WHERE("Table Name" = CONST(Customer),
                                                      "No." = FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }

        field(7; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(8; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(9; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(10; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }


        field(11; "Member No."; Code[20])
        {
            TableRelation = Members;

            trigger OnValidate()
            begin
                // MultipleAccountCreation;
                // "Application Date" := Today;

                if Cust.Get("Member No.") then begin
                    "Payroll/Staff No." := Cust."Payroll/Staff No.";
                    Name := Cust.Name;
                    "ID No." := Cust."Primary Identification";
                    "Global Dimension 1 Code" := Cust."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := Cust."Global Dimension 2 Code";

                end;
            end;
        }

        field(12; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }

        field(13; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility CenterBR";
        }

        field(14; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending,Approved,Rejected,Created';
            OptionMembers = Open,Pending,Approved,Rejected,Created;
            trigger Onvalidate()
            begin
                if Rec."Neg. Interest Rate" > 0 then begin
                    if not Confirm('Are you sure you want to change the interest?') then exit
                end else
                    Message('Interest changed!');
            end;
        }

        field(15; "Payroll/Staff No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "Payroll/Staff No." <> '' then begin
                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange(SavingsAccounts."Payroll/Staff No.", "Payroll/Staff No.");
                    if SavingsAccounts.FindFirst then
                        Error(AccountExistsError, SavingsAccounts."No.", SavingsAccounts.Name);
                end;
            end;
        }
        field(16; "ID No."; Code[11])
        {

            trigger OnValidate()
            begin
                "ID No." := DelChr("ID No.", '=', 'A|B|C|D|E|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|.|,|!|@|#|$|%|^|&|*|(|)|[|]|{|}|/|\|"|;|:|<|>|?');
                // FieldLength("ID No.", 10);

                if "ID No." <> '' then begin
                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange(SavingsAccounts."ID No.", "ID No.");
                    if SavingsAccounts.FindFirst then
                        Error(AccountExistsError, SavingsAccounts."No.", SavingsAccounts.Name);
                end;
            end;
        }

        field(17; "Product Type"; Code[20])
        {
            Description = 'LookUp into Product Factory Table';
            TableRelation = "Product Factory" WHERE("Product Class Type" = CONST(Savings), "Product Category" = const("Fixed Deposit"),
                                                     Status = CONST(Active));

            trigger OnValidate()
            var
                ProductApplicationDocuments: Record "Product Documents";
                ApplicationDocuments: Record "Application Documents";
                ProdFact: Record "Product Factory";
            begin
                // MultipleAccountCreation;
                ProdFact.Get(rec."Product Type");
                rec."Product Name" := ProdFact."Product Description";
                // "Application Date" := Today;
            end;
        }
        field(18; "Product Name"; Text[50])
        {
            Editable = false;
        }

        field(19; "Fixed Deposit Status"; Option)
        {
            OptionCaption = ' ,Active,Matured,Closed,Not Matured,Terminated';
            OptionMembers = " ",Active,Matured,Closed,"Not Matured",Terminated;
            Editable = false;
        }

        field(20; "Created By"; Code[50])
        {
            Editable = false;
        }

        field(21; "Registration Date"; Date)
        {
        }
        field(22; "FD Marked for Closure"; Boolean)
        {
        }
        field(23; "Expected Maturity Date"; Date)
        {
        }
        field(24; "FOSA Main Account No."; Code[20])
        {
            Description = 'LookUp to Savings Account Table';
            TableRelation = "Savings Accounts" WHERE("Member No." = FIELD("Member No."),
                                                      "Product Category" = FILTER("FOSA Account" | Savcol));
        }
        field(25; "Fixed Deposit Account No."; Code[20])
        {
            Description = 'LookUp to Member Table';
            TableRelation = "Savings Accounts" WHERE("Member No." = FIELD("Member No."),
                                                      "Product Category" = FILTER("Fixed Deposit"));
        }
        field(26; "Fixed Deposit Type"; Code[20])
        {
            Description = 'LookUp to Fixed Deposit Type Table';
            TableRelation = "Fixed Deposit Type" WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                FixedDepositType: Record "Fixed Deposit Type";
                FDCalculation: Record "FD Interest Calculation Rules";
                FDSetup: Record "Fixed Deposit Type";
            begin
                TestField("Application Date");
                if FixedDepositType.Get("Fixed Deposit Type") then begin
                    "FD Maturity Date" := CalcDate(FixedDepositType.Duration, "Application Date");
                    "FD Duration" := FixedDepositType.Duration;
                    "Product Category" := "Product Category"::"Fixed Deposit";
                    Message('The FD number of days is - %1', Abs("FD Maturity Date" - "Application Date"));

                    FDSetup.Reset();
                    FDSetup.SetRange(FDSetup.Code, rec."Fixed Deposit Type");
                    if FDSetup.Find('-') then begin
                        FDCalculation.Reset();
                        FDCalculation.SetRange(Code, FDSetup.Code);
                        if FDCalculation.FindFirst() then begin
                            //repeat
                            case
                                Rec."Fixed Deposit Amount" of
                                FDCalculation."Minimum Amount" .. FDCalculation."Maximum Amount":
                                    rec."Interest Rate" := FDCalculation."Interest Rate";
                            end;
                            //until FDCalculation.Next() = 0;
                        end;
                    end;
                end
            end;
        }
        field(27; "FD Maturity Date"; Date)
        {
        }


        field(28; "Neg. Interest Rate"; Decimal)
        {

            trigger OnValidate()
            begin
                FDCalcRules.Reset;
                FDCalcRules.SetRange(Code, "Fixed Deposit Type");
                if FDCalcRules.Find('-') then begin
                    repeat
                        if FDCalcRules."Allowed Margin" <> 0 then begin
                            if ("Fixed Deposit Amount" >= FDCalcRules."Minimum Amount") and ("Fixed Deposit Amount" <= FDCalcRules."Maximum Amount") then
                                if ("Neg. Interest Rate" > (FDCalcRules."Interest Rate" + FDCalcRules."Allowed Margin")) or
                                   ("Neg. Interest Rate" < (FDCalcRules."Interest Rate" - FDCalcRules."Allowed Margin")) then
                                    Error('The negotiated rate must be within the allowed margin of %1', FDCalcRules."Allowed Margin");
                        end;
                    until
                    FDCalcRules.Next = 0;
                end;

                if rec."Neg. Interest Rate" > 0 then
                    Message('By inserting this field, it will be used as the new interest rate.');
            end;
        }
        field(29; "FD Duration"; DateFormula)
        {

            trigger OnValidate()
            begin
                "FD Maturity Date" := CalcDate("FD Duration", "Application Date");
            end;
        }
        field(30; "FD Maturity Instructions"; Option)
        {
            OptionCaption = ' ,Transfer all to Savings,Renew Principal,Renew Principal & Interest';
            OptionMembers = " ","Transfer all to Savings","Renew Principal","Renew Principal & Interest";
        }
        field(31; "Fixed Deposit cert. no"; Code[30])
        {
            Description = 'Capture FxD certificate Number';
        }

        field(32; "Application Date"; Date)
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "Application Date" > Today then
                    Error(DateofBirthError);
            end;
        }

        field(33; Source; Option)
        {
            Description = 'Used to identify origin of Member Application [CRM, Navision, Web]';
            OptionCaption = ' ,Navision,CRM,Web';
            OptionMembers = " ",Navision,CRM,Web;
        }
        field(34; "Fixed Deposit Amount"; Decimal)
        {
            trigger OnValidate()
            var
                SavingsAccounts: Record "Savings Accounts";
                FDSetup: Record "Fixed Deposit Type";
                IntRate: Decimal;
                IntEarned: Decimal;
                NoOfDays: Integer;
            begin

                rec.validate("Fixed Deposit Type");
                NoOfDays := 0;
                NoOfDays := Abs(Rec."FD Maturity Date" - Rec."Application Date");
                SavingsAccounts.get("FOSA Main Account No.");
                SavingsAccounts.CalcFields("Balance (LCY)");
                if SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.") < rec."Fixed Deposit Amount" then
                    Error('There is no enough balance in the account for the Fixed Deposit Contract.');

                FDSetup.Reset();
                FDSetup.SetRange(FDSetup.Code, rec."Fixed Deposit Type");
                if FDSetup.Find('-') then begin
                    if "Fixed Deposit Amount" < FDSetup."Allowed Minimum Amount" then
                        Error('The Deposit Amount is less than the Allowed Minimum Amount.');

                    rec."Forecasted Interest" := Rec."Fixed Deposit Amount" * (rec."Interest Rate" / 100) * (NoOfDays / 365);

                end else
                    Error('Fixed Deposit Setup missing.');

            end;

        }

        field(35; "Recruited by Type"; enum "Recruited By")
        {

        }
        field(36; "Relationship Manager"; Code[10])
        {
            TableRelation = "HR Employees" WHERE(Status = FILTER(Active));
        }
        field(37; "Balance"; Decimal)
        {
            CalcFormula = - Sum("Savings Ledger Entry".Amount WHERE("Fixed Deposit Contract" = FIELD("No."), "Customer No." = field("Fixed Deposit Account No."),
                                                                  "Posting Date" = FIELD("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(38; "Product Category"; enum "Product Categories")
        {
        }
        field(39; "Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Savings Ledger Entry"."Amount (LCY)" WHERE("Fixed Deposit Contract" = FIELD("No."), "Customer No." = field("Fixed Deposit Account No."),
                                                                            "Posting Date" = FIELD("Date Filter")));
            Caption = 'Balance (LCY)';
            FieldClass = FlowField;
            Editable = false;
        }
        field(40; Blocked; Option)
        {
            Caption = 'Blocked';
            OptionCaption = ' ,Credit,Debit,All';
            OptionMembers = " ",Credit,Debit,All;
        }
        field(41; "Untranfered Interest"; Decimal)
        {
            CalcFormula = Sum("Interest Buffer"."Interest Amount" WHERE("Account No" = FIELD("No."),
                                                                         Transferred = CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(42; "Transactional Mobile No"; Text[30])
        {
        }
        field(43; "FD Date Renewed"; Date)
        {
        }
        field(44; Processed; Boolean)
        {
        }
        field(45; "Forecasted Interest"; Decimal)
        {

        }
        field(46; "Interest Rate"; Decimal)
        {
            Caption = 'Interest Rate';
            Editable = false;
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

        // AccountApplication.Reset;
        // AccountApplication.SetFilter(Status, '%1', AccountApplication.Status::Open);
        // AccountApplication.SetRange("Created By", UserId);
        // if AccountApplication.Find('-') then begin
        //     if AccountApplication.Count > 2 then
        //         Error('Kindly use the open document first for you to create a new one');
        // end;



        if "No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Fixed Deposit Contract");
            "No." := NoSeriesMgt.GetNextNo(SeriesSetup."Fixed Deposit Contract");
            // NoSeriesMgt.InitSeries(SeriesSetup."Fixed Deposit Contract", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Application Date" := Today;
        "Created By" := UserId;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
        end;
    end;


    trigger OnModify()
    begin
        "Last Date Modified" := Today;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;//
    end;

    var
        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        Cust: Record Members;
        ProductFactory: Record "Product Factory";
        ImageData: Record "Image Data";
        ParentEdit: Boolean;
        TypeHide: Boolean;
        FXDDetailsVisible: Boolean;
        JuniourAccVisible: Boolean;
        FixedDepositType: Record "Fixed Deposit Type";
        GeneralSetUp: Record "General Set-Up";
        UserSetup: Record "User Setup";
        SavingsAccounts: Record "Savings Accounts";
        DateofBirthError: Label 'Date cannot be greater than today.';
        AccountExistsError: Label 'Applicant already has a similar Account No.%1 Name %2 .';
        CountryRegion: Record "Country/Region";
        PostCode: Record "Post Code";
        FDCalcRules: Record "FD Interest Calculation Rules";
        MemberClass: Record "Member Classes";
        SavingsAccount: Record "Savings Accounts";
        CRMApplication: Record "CRM Application";
        Sav: Record "Savings Accounts";
        AccountApplication: Record "Savings Account Application";

    [Scope('OnPrem')]
    procedure MultipleAccountCreation()
    var
        AllowMultipleAcntError: Label 'Applicant already has %1, Kindly ensure this product allows multiple account creations to proceed.';
    begin
        SavingsAccounts.Reset;
        SavingsAccounts.SetRange(SavingsAccounts."Member No.", "Member No.");
        SavingsAccounts.SetRange(SavingsAccounts."Product Type", "Product Type");
        if SavingsAccounts.Find('-') then begin
            if ProductFactory.Get("Product Type") then begin
                if not ProductFactory."Allow Multiple Accounts" then
                    if SavingsAccounts.Count >= 1 then
                        Error(AllowMultipleAcntError, SavingsAccounts."Product Name");
                //MESSAGE(FORMAT(SavingsAccounts.COUNT));
            end;
        end;
    end;

    // [Scope('OnPrem')]
    procedure FieldLength(VarVariant: Text; FldLength: Integer): Text
    var
        FieldLengthError: Label 'Field cannot be more than %1 Characters.';
    begin
        if StrLen(VarVariant) > FldLength then
            Error(FieldLengthError, FldLength);
    end;
}

