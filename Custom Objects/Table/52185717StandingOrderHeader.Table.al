table 52185717 "Standing Order Header"
{
    DrillDownPageID = "Standing Order List";
    LookupPageID = "Standing Order List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SeriesSetup.Get();
                    NoSeriesMgt.TestManual(SeriesSetup."Standing Order Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Application Date"; Date)
        {
            Editable = false;
        }
        field(3; "No. Series"; Code[10])
        {
            Editable = false;
        }
        field(4; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Open,Pending,Approved,Rejected,Stopped,Cancelled';
            OptionMembers = Open,Pending,Approved,Rejected,Stopped,Cancelled;

            trigger OnValidate()
            begin
                CalcFields("Allocated Amount");
                if "Allocated Amount" <> Amount then Error(AmountError);
            end;
        }
        field(5; "Transaction Branch"; Code[10])
        {
        }
        field(6; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center";
        }
        field(7; "Source Account Type"; Enum "Gen. Journal Account Type")
        {
            // OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee,Savings,Credit';
            // OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Savings,Credit;
        }
        field(8; "Source Account No."; Code[20])
        {
            TableRelation = IF ("Source Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Source Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Source Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Source Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Source Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Source Account Type" = CONST("IC Partner")) "IC Partner"
            ELSE
            IF ("Source Account Type" = CONST(Savings)) "Savings Accounts" WHERE("Source Unit" = filter(FOSA), "Product Category" = filter(<> "Fixed Deposit"))
            ELSE
            IF ("Source Account Type" = CONST(Credit)) "Credit Accounts";


            trigger OnValidate()
            begin

                if Account.Get("Source Account No.") then begin
                    "Payroll/Staff No." := Account."Payroll/Staff No.";
                    "Source Account Name" := Account.Name;
                    "Member No." := Account."Member No.";
                    "ID Number" := Account."ID No.";
                end;
            end;
        }
        field(9; "Source Account Name"; Text[80])
        {
            Editable = false;
        }
        field(10; "Member No."; Code[10])
        {
            Editable = false;
        }
        field(11; "ID Number"; Code[20])
        {
            Editable = false;
        }
        field(12; "Payroll/Staff No."; Code[20])
        {
            Editable = false;
        }
        field(13; Description; Text[50])
        {
            Description = 'LookUp to Standing Orders Description Table';
        }
        field(14; Amount; Decimal)
        {
        }
        field(15; "Allocated Amount"; Decimal)
        {
            CalcFormula = Sum("Standing Order Lines".Amount WHERE("Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; Balance; Decimal)
        {
            Editable = false;
        }
        field(20; "Standing Order Type"; Option)
        {
            OptionCaption = 'Internal,External,Pensioner';
            OptionMembers = Internal,External,Pensioner;

            trigger OnValidate()
            begin
                if "Standing Order Type" = "Standing Order Type"::Pensioner then
                    Priority := 1
                else
                    if "Standing Order Type" = "Standing Order Type"::Internal then
                        Priority := 2
                    else
                        if "Standing Order Type" = "Standing Order Type"::External then
                            Priority := 3;
            end;
        }
        field(21; "Allow Partial Deduction"; Boolean)
        {
            InitValue = true;

            trigger OnValidate()
            begin
                STOLines.Reset;
                STOLines.SetRange("Document No.", "No.");
                STOLines.SetRange(STOLines."Destination Account Type", STOLines."Destination Account Type"::"G/L Account");
                if STOLines.Find('-') then begin

                    if STOLines."Destination Account Type" = STOLines."Destination Account Type"::"G/L Account" then
                        Error('An external standing order cannot be partially deducted');
                end;
            end;
        }
        field(22; "None Salary"; Boolean)
        {
            Enabled = false;
        }
        field(23; "Income Type"; Option)
        {
            Editable = false;
            OptionCaption = 'Salary,Direct Debit,SAYE,Periodic,Pension';
            OptionMembers = Salary,"Direct Debit",SAYE,Periodic,Pension;
            ValuesAllowed = Salary, Periodic, pension;

            trigger OnValidate()
            begin
                if "Income Type" = Rec."Income Type"::Periodic then
                    "Next Run Date" := 0D;
            end;
        }
        field(24; Type; Option)
        {
            OptionCaption = ' ,Fixed,Sweep';
            OptionMembers = " ","Fixed",Sweep;

            trigger OnValidate()
            begin
                StndingOrders.Reset;
                StndingOrders.SetRange(StndingOrders."Source Account No.", "Source Account No.");
                StndingOrders.SetRange(StndingOrders.Status, StndingOrders.Status::Approved);
                StndingOrders.SetRange(StndingOrders.Type, Type);
                if StndingOrders.Find('-') then begin
                    Error('This member has another standing order of Type %1', StndingOrders.Type);
                end;

                if Type = Type::Sweep then
                    Amount := 0;
            end;
        }
        field(25; Priority; Decimal)
        {
        }
        field(26; "Effective/Start Date"; Date)
        {

            trigger OnValidate()
            begin
                IF "Effective/Start Date" < TODAY THEN
                    ERROR('Date must be in Today or in future');
                //IF "Income Type" <> Rec."Income Type"::Periodic THEN
                "Next Run Date" := "Effective/Start Date"; //
                //Below is the former value of the 'Next Run Date' field 
                //CALCDATE("Frequency (Months)", "Effective/Start Date");
            end;
        }
        field(27; "Frequency (Months)"; DateFormula)
        {

            trigger OnValidate()
            begin
                /*EVALUATE(DurationInteger,FORMAT("Duration (Months)"));
                EVALUATE(FrequencyInteger,FORMAT("Frequency (Months)"));
                IF DurationInteger < FrequencyInteger THEN
                  ERROR(DurationError);*/


                Evaluate(FrequencyText, Format("Frequency (Months)"));
                FrequencyText := DelChr(Format(FrequencyText), '=', '-|+|');
                Evaluate("Frequency (Months)", FrequencyText);

                if "Income Type" <> Rec."Income Type"::Periodic then
                    "Next Run Date" := CalcDate("Frequency (Months)", "Effective/Start Date");

            end;
        }
        field(28; "Duration (Months)"; DateFormula)
        {

            trigger OnValidate()
            begin
                TestField("Effective/Start Date");
                TestField("Frequency (Months)");
                TestField("Duration (Months)");

                /*EVALUATE(DurationInteger,FORMAT("Duration (Months)"));
                EVALUATE(FrequencyInteger,FORMAT("Frequency (Months)"));
                IF DurationInteger < FrequencyInteger THEN
                  ERROR(DurationError);*/

                Evaluate(DurationText, Format("Duration (Months)"));
                DurationText := DelChr(Format(DurationText), '=', '-|+|');
                Evaluate("Duration (Months)", DurationText);

                "End Date" := CalcDate("Duration (Months)", "Effective/Start Date");

            end;
        }
        field(29; "End Date"; Date)
        {
            Editable = true;
        }
        field(30; Effected; Boolean)
        {
            Editable = false;
        }
        field(31; Unsuccessfull; Boolean)
        {
            Editable = false;
        }
        field(32; "Next Run Date"; Date)
        {
        }
        field(33; "Auto Process"; Boolean)
        {
        }
        field(34; "Date Reset"; Date)
        {
            Editable = false;
        }
        field(35; Invalid; Boolean)
        {
        }
        field(36; Unrecovered; Boolean)
        {
        }
        field(37; "Created By"; Code[50])
        {
        }
        field(38; "Bank Code"; Code[10])
        {
            TableRelation = "Bank Code Structure".Code;

            trigger OnValidate()
            begin
                //*
                BankCodes.Reset;
                BankCodes.SetRange(BankCodes.Code, "Bank Code");
                if BankCodes.Find('-') then
                    "Bank Name" := BankCodes.Name;

                //*
                if "Bank Code" = '' then begin
                    "Branch Code" := '';
                    "Bank Name" := '';
                    "Bank Account No." := '';
                end;
            end;
        }
        field(39; "Branch Code"; Code[10])
        {
            TableRelation = "Bank Code Structure".Code WHERE(Code = FIELD("Bank Code"));
        }
        field(40; "Bank Name"; Text[100])
        {
            Editable = false;
        }
        field(41; "Bank Account No."; Code[15])
        {

            trigger OnValidate()
            begin
                if StrLen("Bank Account No.") <> 13 then begin
                    Error('Invalid Bank account No. Please enter the correct Bank Account No.');
                end;
            end;
        }
        field(42; "Transfered to EFT"; Boolean)
        {
            Description = 'Help Identify eft that has External transfer during eft processing';
        }
        field(43; "Transaction Type"; Code[20])
        {
            TableRelation = "Transaction Types".Code WHERE(Type = CONST("Standing Order"));
        }
        field(44; "Activity Code"; Code[30])
        {
        }
        field(45; "Global Dimension 1 Code"; Code[15])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(46; "Global Dimension 2 Code"; Code[15])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(47; "Stopped By"; Text[50])
        {
            Editable = false;
        }
        field(48; "Date Stopped"; Date)
        {
        }
        field(49; "Target Amount"; Decimal)
        {

        }
        field(450; "Target Amount Balance"; Decimal)
        {

            CalcFormula = Sum("Standing Order Register"."Amount Deducted" WHERE("Document No." = FIELD("No."),
                                                                            "Source Account No." = FIELD("Source Account No."),
                                                                            "Deduction Status" = filter("Partial Deduction" | Successful)));
            FieldClass = FlowField;
            trigger OnValidate()
            var
                STOHeader: Record "Standing Order Header";
            begin
                if rec."Target Amount Balance" = 0 then
                    STOHeader.Status := STOHeader.Status::Stopped;
                STOHeader.Modify(true);
                Message('Target amount is met you can now stop the Standing Order!!');
            end;
        }
        field(451; "Contributed Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Standing Order Register"."Amount Deducted" WHERE("Document No." = FIELD("No."),
                                                                            "Source Account No." = FIELD("Source Account No."),
                                                                            "Deduction Status" = filter("Partial Deduction" | Successful)));
        }

        field(1000; "Source Application"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "BC","Member Portal","Mobile Banking";
        }
        field(452; "Product Type"; Code[20])
        {
            fieldClass = FlowField;
            CalcFormula = Lookup("Savings Accounts"."Product Type" WHERE("No." = FIELD("Source Account No.")));
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }

        // Secondary keys for non-primary fields
        key(IdxSourceAccountNo; "Source Account No.")
        {
            Clustered = false;
        }

        key(IdxStatus; "Status")
        {
            Clustered = false;
        }

        // Composite keys for efficient queries involving multiple fields
        key(IdxSourceAccountNoStatus; "Source Account No.", "Status")
        {
            Clustered = false;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Standing Order Nos.");
            "No." := NoSeriesMgt.GetNextNo(SeriesSetup."Standing Order Nos.");
            // NoSeriesMgt.InitSeries(SeriesSetup."Standing Order Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Application Date" := Today;
        "Created By" := UserId;

        UserSetUp.Reset;
        UserSetUp.SetRange(UserSetUp."User ID", UserId);
        if UserSetUp.Find('-') then begin
            UserSetUp.TestField(UserSetUp."Global Dimension 1 Code");
            UserSetUp.TestField(UserSetUp."Global Dimension 2 Code");

            "Global Dimension 1 Code" := UserSetUp."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetUp."Global Dimension 2 Code";
            "Income Type" := Rec."Income Type"::Salary;
        end;
    end;


    var
        SeriesSetup: Record "Banking No Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        StndingOrders: Record "Standing Order Header";
        Account: Record "Savings Accounts";
        BankAcc: Record "Bank Account";
        Cust: Record "Credit Accounts";
        BankCodes: Record "Bank Code Structure";
        FrequencyText: Text;
        DurationText: Text;
        DurationError: Label 'Duration cannot be less than Frequency';
        FrequencyInteger: Integer;
        DurationInteger: Integer;
        STOLines: Record "Standing Order Lines";
        UserSetUp: Record "User Setup";
        AmountError: Label 'Allocated amount and amount are not the same.';
}

