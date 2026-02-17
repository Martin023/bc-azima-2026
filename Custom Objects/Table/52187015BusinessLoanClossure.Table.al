table 52187015 "Business Loan Clossure"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            SQLDataType = Varchar;
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SeriesSetup.Get;
                    NoSeriesMgt.TestManual(SeriesSetup."Business Loan Acc App");
                    "No. Series" := '';
                end;
            end;
        }

        field(2; "CRM Application No."; Code[50])
        {

        }

        field(3; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }

        field(4; "Clossure Type"; Option)
        {
            OptionMembers = " ","Individual Group Exit","Individual Clossure","Group Clossure","Group Transfer";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Member No." <> '' then
                    Validate("Member No.");

            end;
        }
        field(5; Description; Text[100])
        {

        }
        field(6; "Member No."; Code[20])
        {
            TableRelation = if ("Clossure Type" = const("Group Clossure")) Members WHERE("Account Type" = filter("Group Account")) else
            Members where("Has Joined Business Loans" = const(true));

            trigger OnValidate()
            var
                LoanNumbers: Text;
            begin
                AccountClosureLine.reset;
                AccountClosureLine.SetRange(AccountClosureLine."No.", Rec."No.");
                AccountClosureLine.deleteall;

                CalcFields("FOSA Account No", "BOSA Account No", Name, "Identification Type", Identification, Address, "Date of Birth", "Employer Code", "Employer Name", Name);
                "Outstanding Loan Balance" := 0;
                "Outstanding Loan Interest" := 0;
                LoanTotal := 0;
                IntTotal := 0;
                TotalSaving := 0;
                "Net Balances" := 0;
                "Total Shares" := 0;
                "Outstanding Loan Balance" := 0;
                "Outstanding Loan Interest" := 0;
                "Total Liabilities" := 0;
                TotalLiabilities := 0;
                GIntTotal := 0;
                GLoanTotal := 0;
                NetBalances := 0;
                GTotalSaving := 0;
                //Savings
                if "Clossure Type" <> "Clossure Type"::"Group Clossure" then begin
                    if "Clossure Type" = "Clossure Type"::"Group Transfer" then begin
                        if Members.Get("Member No.") then begin
                            Loans.Reset();
                            Loans.SetRange("Member No.", Members."No.");
                            Loans.SetFilter("Outstanding Balance", '>0');
                            Loans.SetRange("Source Unit", Loans."Source Unit"::"BUSINESS LOANS");
                            if Loans.Find('-') then begin
                                repeat
                                    LoanNumbers += Loans."Loan No." + ', ';
                                until Loans.Next() = 0;
                            end;

                            Message('Member has active loans LNOs: %1', LoanNumbers);

                            LoanGuarantors.Reset();
                            LoanGuarantors.SetRange(LoanGuarantors."Member No", "Member No.");
                            LoanGuarantors.SetRange("Guarantor Type", LoanGuarantors."Guarantor Type"::Guarantor);
                            LoanGuarantors.SetRange(Substituted, false);
                            IF LoanGuarantors.Find('-') then begin
                                repeat
                                    IF LoansII.Get(LoanGuarantors."Loan No") THEN BEGIN
                                        if ProductFactories.Get(LoansII."Loan Product Type") then begin
                                            if ProductFactories."Source Unit" = Pfactory."Source Unit"::"BUSINESS LOANS" then begin
                                                LoansII.CalcFields(LoansII."Outstanding Balance");
                                                IF LoansII."Outstanding Balance" > 0 THEN BEGIN
                                                    LoansG += 1;
                                                end;
                                            end;
                                        end;
                                    end;
                                until LoanGuarantors.NEXT = 0;
                            end;

                            if LoansG > 0 then
                                Message('Member is Guaranteeing %1 Active Business Loans', LoansG);
                        end;
                    end else begin
                        if mem.get("Member No.") then begin
                            "Group Account No." := mem."Group Account No.";
                            SavingsAccounts.Reset;
                            SavingsAccounts.SetRange(SavingsAccounts."Member No.", "Member No.");
                            SavingsAccounts.SetFilter("Product Category", '<>%1&<>%2&<>%3&<>%4', SavingsAccounts."Product Category"::"Entrance Fee", SavingsAccounts."Product Category"::"Benevolent (BBF)", SavingsAccounts."Product Category"::"Share Capital", SavingsAccounts."Product Category"::"Transfered Share Capital");
                            if SavingsAccounts.Find('-') then begin
                                repeat
                                    ProductFactory.Get(SavingsAccounts."Product Type");
                                    if ProductFactory."Source Unit" = ProductFactory."Source Unit"::"BUSINESS LOANS" then begin
                                        TotalSaving += SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.");
                                    end;
                                until SavingsAccounts.Next = 0;
                            end;


                            "Total Shares" := TotalSaving;
                            //Loans 
                            Loans.Reset;
                            Loans.SetRange(Loans."Member No.", "Member No.");
                            Loans.SetRange(Loans.Posted, true);
                            Loans.SetFilter(Loans."Total Loan Balance", '>0');
                            if Loans.Find('-') then begin
                                repeat
                                    Pfactory.Get(Loans."Loan Product Type");
                                    if Pfactory."Source Unit" = Pfactory."Source Unit"::"BUSINESS LOANS" then begin
                                        Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest", "Total Loan Balance", "Daily Interest");
                                        IntTotal := IntTotal + (Loans."Outstanding Interest" + Loans."Daily Interest");
                                        LoanTotal := LoanTotal + Loans."Outstanding Balance";
                                    end;
                                until Loans.Next = 0;
                            end;

                            //LoanGuar
                            LoansG := 0;
                            LoanGuarantors.RESET;
                            LoanGuarantors.SETRANGE(LoanGuarantors."Member No", "Member No.");
                            LoanGuarantors.SetRange("Guarantor Type", LoanGuarantors."Guarantor Type"::Guarantor);
                            LoanGuarantors.SetRange(Substituted, false);
                            IF LoanGuarantors.FIND('-') THEN BEGIN
                                REPEAT
                                    IF LoansII.GET(LoanGuarantors."Loan No") THEN BEGIN
                                        if ProductFactories.Get(LoansII."Loan Product Type") then begin
                                            if ProductFactories."Source Unit" = Pfactory."Source Unit"::"BUSINESS LOANS" then begin
                                                LoansII.CALCFIELDS(LoansII."Outstanding Balance");
                                                IF LoansII."Outstanding Balance" > 0 THEN BEGIN
                                                    LoansG += 1;
                                                end;
                                            END;
                                        end;
                                    END;
                                UNTIL LoanGuarantors.NEXT = 0;

                                IF LoansG > 0 THEN
                                    ERROR('Member is Guaranteeing %1 Active Business Loans', LoansG);
                            END;
                            //Loan Guar
                            "Outstanding Loan Balance" := LoanTotal;
                            "Outstanding Loan Interest" := IntTotal;
                            "Total Liabilities" := "Outstanding Loan Balance" + "Outstanding Loan Interest";

                            "Net Balances" := "Total Shares" - "Total Liabilities";
                        end;
                    end;
                end;
                if "Clossure Type" = "Clossure Type"::"Group Clossure" then begin
                    GMembers.reset;
                    GMembers.SetRange("Group Account No.", "Member No.");
                    if GMembers.Find('-') then begin
                        repeat
                            SavingsAccounts.Reset;
                            SavingsAccounts.SetRange(SavingsAccounts."Member No.", GMembers."No.");
                            SavingsAccounts.SetFilter("Product Category", '<>%1&<>%2&<>%3&<>%4', SavingsAccounts."Product Category"::"Entrance Fee", SavingsAccounts."Product Category"::"Benevolent (BBF)", SavingsAccounts."Product Category"::"Share Capital", SavingsAccounts."Product Category"::"Transfered Share Capital");
                            if SavingsAccounts.Find('-') then begin
                                repeat
                                    ProductFactory.Get(SavingsAccounts."Product Type");
                                    if ProductFactory."Loan Disbursement Account" = true then
                                        FOSAACCOUNT := SavingsAccounts."No.";
                                    if ProductFactory."Source Unit" = ProductFactory."Source Unit"::"BUSINESS LOANS" then begin
                                        GTotalSaving += SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.");
                                    end;
                                until SavingsAccounts.Next = 0;
                            end;
                            //Loans 
                            Loans.Reset;
                            Loans.SetRange(Loans."Member No.", GMembers."No.");
                            Loans.SetRange(Loans.Posted, true);
                            Loans.SetFilter(Loans."Total Loan Balance", '>0');
                            if Loans.Find('-') then begin
                                repeat
                                    Pfactory.Get(Loans."Loan Product Type");
                                    if Pfactory."Source Unit" = Pfactory."Source Unit"::"BUSINESS LOANS" then begin
                                        Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest", "Total Loan Balance", "Daily Interest");
                                        GIntTotal := GIntTotal + (Loans."Outstanding Interest" + Loans."Daily Interest");
                                        GLoanTotal := GLoanTotal + Loans."Outstanding Balance";
                                    end;
                                until Loans.Next = 0;
                            end;
                            TotalLiabilities := GIntTotal + GLoanTotal;

                            NetBalances := GTotalSaving - TotalLiabilities;

                            AccountClosureLine.Init;
                            AccountClosureLine."Account No." := FOSAACCOUNT;
                            AccountClosureLine."Member No." := GMembers."No.";
                            AccountClosureLine."Total Loan Balance" := GLoanTotal;
                            AccountClosureLine."Interest Loan Balance" := GIntTotal;
                            AccountClosureLine."Savings Balance" := GTotalSaving;
                            AccountClosureLine."Net Refundable" := NetBalances;
                            AccountClosureLine.Insert();
                        until GMembers.Next = 0;

                    end;
                end;


            end;
        }

        field(7; "FOSA Account No"; Code[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Savings Accounts"."No." where("Product Category" = const("FOSA Account"), "Member No." = field("Member No.")));
        }

        field(8; "BOSA Account No"; Code[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Savings Accounts"."No." where("Product Category" = const("BOSA Deposits"), "Member No." = field("Member No.")));
        }

        field(9; Name; Text[80])
        {
            Caption = 'Name';

            FieldClass = FlowField;
            CalcFormula = lookup(Members.Name where("No." = field("Member No.")));

            Editable = false;
        }

        field(10; "Payroll/Staff No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members."Payroll/Staff No." where("No." = field("Member No.")));

            Editable = false;
        }

        field(11; "Identification Type"; Enum "Identification Type")
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members."Primary Identification Type" where("No." = field("Member No.")));

        }

        field(12; Identification; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members."Primary Identification" where("No." = field("Member No.")));
        }

        field(13; Address; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members."Current Address" where("No." = field("Member No.")));
        }

        field(14; "Date of Birth"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members."Date of Birth" where("No." = field("Member No.")));
        }

        field(15; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility CenterBR";
            Editable = false;
        }
        field(16; "Employer Code"; Code[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members."Employer Code" where("No." = field("Member No.")));
        }

        field(17; "Employer Name"; Code[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Employer Code")));
        }
        field(18; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

        }
        field(19; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }

        field(20; Remarks; text[100])
        {

        }
        field(21; "Calculate Net Bal"; Boolean)
        {

        }
        field(22; "WSF Balances"; Decimal)
        {

        }
        field(23; "Business Loan Shares"; Decimal)
        {

        }

        field(24; "BOSA Shares"; Decimal)
        {

        }

        field(25; "Total Shares"; Decimal)
        {

        }

        field(26; "Outstanding Loan Balance"; Decimal)
        {

        }

        field(27; "Outstanding Loan Interest"; Decimal)
        {

        }

        field(28; "Total Liabilities"; Decimal)
        {

        }

        field(29; "Net Balances"; Decimal)
        {

        }

        field(30; Status; Enum "Workflow Status Main Flags")
        {

        }

        field(31; "Created At"; DateTime)
        {

        }

        field(32; "Created By"; Code[50])
        {

        }

        field(33; "Posted At"; DateTime)
        {

        }

        field(34; "Posted By"; Code[50])
        {

        }

        field(35; Posted; Boolean)
        {
            editable = false;
        }

        field(36; "Group Account No."; Code[20])
        {

            TableRelation = Members WHERE("Account Type" = filter("Group Account"));

            trigger OnValidate()
            begin
            end;
        }
        field(37; "Transaction Type"; Code[20])
        {
            TableRelation = "Transaction Types".Code WHERE(Type = CONST("Account Closure"));

            trigger OnValidate()
            begin
            end;
        }
        field(38; "New Group No."; Code[20])
        {
            TableRelation = Members."No." where("Account Type" = filter("Group Account"));

            trigger OnValidate()
            begin
                if Members.Get("Member No.") then begin
                    if Members."Group Account No." = "New Group No." then
                        Error('New group number can not be the same as the current members group');
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Business Loan Account Closure");
            "No." := NoSeriesMgt.GetNextNo(SeriesSetup."Business Loan Account Closure");
            // NoSeriesMgt.InitSeries(SeriesSetup."Business Loan Account Closure", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Created At" := CurrentDateTime;
        "Created By" := UserId;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
        end;
    end;

    var
        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        ProductFactory: Record "Product Factory";
        GeneralSetUp: Record "General Set-Up";
        UserSetup: Record "User Setup";
        SavingsAccounts: Record "Savings Accounts";
        AccountExistsError: Label 'Applicant already has a similar Account No.%1 Name %2 .';
        CountryRegion: Record "Country/Region";
        AccountApplication: Record "Savings Account Application";
        Loans: Record Loans;
        LoanTotal: Decimal;
        IntTotal: Decimal;
        Pfactory: Record "Product Factory";
        BBF: Decimal;
        AccountClosureFee: Decimal;
        Amount: array[2] of Integer;
        TransactionCharges: Record "Transaction Charges";
        TariffDetails: Record "Tiered Charges Lines";
        TotalSaving: Decimal;
        AccountClosureLine: Record "Account Closure Line";
        GMembers: Record Members;
        TotalLiabilities: Decimal;
        GIntTotal: Decimal;
        GLoanTotal: Decimal;
        NetBalances: Decimal;
        GTotalSaving: Decimal;
        FOSAACCOUNT: Code[20];
        LoansG: Integer;
        LoanGuarantors: Record "Loan Guarantors and Security";
        LoansII: Record Loans;
        ProductFactories: Record "Product Factory";
        mem: Record Members;
        Members: Record Members;
}

