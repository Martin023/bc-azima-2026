table 52185783 "Salary Header"
{
    DrillDownPageID = "Salary Lists";
    LookupPageID = "Salary Lists";

    fields
    {
        field(1; No; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                // if No <> xRec.No then begin
                //     NoSetup.Get();
                //     NoSeriesMgt.TestManual(NoSetup."Salary Nos.");
                //     "No. Series" := '';
                // end;
            end;
        }
        field(2; "No. Series"; Code[20])
        {
        }
        field(3; Posted; Boolean)
        {
            Editable = false;
        }
        field(6; "Posted By"; Code[50])
        {
            Editable = false;
        }
        field(7; "Date Entered"; Date)
        {
        }
        field(9; "Entered By"; Text[50])
        {
        }
        field(10; Remarks; Text[500])
        {
        }
        field(19; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(20; "Time Entered"; Time)
        {
        }
        field(21; "Posting date"; Date)
        {
            //Editable = false;

            trigger OnValidate()
            var
                Salines: record "Salary Lines";
            begin
                Salines.Reset;
                Salines.SetRange("Salary Header No.", rec.No);
                if Salines.Findset then begin
                    repeat
                        Salines."Posting Date" := rec."Posting date";
                    until Salines.Next = 0;
                end;
            end;
        }
        field(22; "Account Type"; Enum "Gen. Journal Account Type")
        {
            // OptionCaption = 'G/L Account,Customer/Employer,Vendor,Bank Account,Fixed Asset';
            // OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
            ValuesAllowed = "G/L Account", Customer;
        }
        field(23; "Account No"; Code[30])
        {
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account" where("Direct Posting" = const(true), "Income/Balance" = const("Balance Sheet"))
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer WHERE("Account Type" = filter(employer))
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset";

            trigger OnValidate()
            begin

                if "Account Type" = "Account Type"::Customer then begin
                    cust.Reset;
                    cust.SetRange(cust."No.", "Account No");
                    if cust.Find('-') then begin
                        "Account Name" := cust.Name;
                    end;
                end;

                if "Account Type" = "Account Type"::"G/L Account" then begin
                    "GL Account".Reset;
                    "GL Account".SetRange("GL Account"."No.", "Account No");
                    if "GL Account".Find('-') then begin
                        "Account Name" := "GL Account".Name;
                    end;
                end;

                if "Account Type" = "Account Type"::"Bank Account" then begin
                    BANKACC.Reset;
                    BANKACC.SetRange(BANKACC."No.", "Account No");
                    if BANKACC.Find('-') then begin
                        "Account Name" := BANKACC.Name;

                    end;
                end;
            end;
        }
        field(24; "Document No"; Code[20])
        {
        }
        field(25; Amount; Decimal)
        {
        }
        field(26; "Scheduled Amount"; Decimal)
        {
            CalcFormula = Sum("Salary Lines".Amount WHERE("Salary Header No." = FIELD(No)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; "Total Count"; Integer)
        {
            CalcFormula = Count("Salary Lines" WHERE("Salary Header No." = FIELD(No)));
            FieldClass = FlowField;
        }
        field(37; "Total Posted Count"; Integer)
        {
            CalcFormula = Count("Salary Lines" WHERE("Salary Header No." = FIELD(No), Posted = const(true)));
            FieldClass = FlowField;
        }
        field(28; "Account Name"; Text[50])
        {
            Editable = false;
        }
        field(29; "Employer Code"; Code[30])
        {
            Caption = 'Workstation';
            TableRelation = Customer."No." where("Account Type" = const("Employer Code"));

            trigger OnValidate()
            var
                Customer: Record Customer;
            begin

                Customer.Reset;
                Customer.SetRange(Customer."No.", "Employer Code");
                if Customer.Find('-') then begin
                    "Employer Name" := Customer.Name;
                end;

            end;
        }
        field(30; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;

            trigger OnValidate()
            var
                RegistrationMngt: Codeunit "Registration Process";
                GlobalFunctions: Codeunit "Global Functions";
            begin
                // if (Rec.Status = Status::Rejected) then
                //     GlobalFunctions.CommentsManagement(Rec.No);
            end;
        }
        field(31; "Income Type"; Enum "Salary Income Types")
        {
            Caption = 'Income Type';
            InitValue = " ";
        }
        field(32; "Transaction Type"; Code[20])
        {
            TableRelation = "Transaction Types".Code WHERE(Type = CONST("Salary Processing"));

            trigger OnValidate()
            var
                TransTypes: Record "Transaction Types";
            begin
                "Document No" := No;
                if TransTypes.get("Transaction Type") then begin
                    "Donnot Recover" := TransTypes."Exclude Salary Loan Deductions";
                    "Deposit Deduction" := TransTypes."Sal. Deposit Deduction";
                    "Income Type" := TransTypes."Salary Income Type";
                    "Donot Recover STO" := TransTypes."Exclude STO Deductions";
                    rec.Modify()
                end;
            end;
        }
        field(33; Validated; Boolean)
        {
        }
        field(34; "Mutiple Salaries Checked"; Boolean)
        {
        }
        field(35; "Last Loan Issue Date"; Date)
        {
        }
        field(36; "Donnot Recover"; Boolean)
        {
            Caption = 'Exclude Salary Deduction.';
            Editable = false;
        }
        field(38; Month; Option)
        {
            OptionCaption = ' ,January,February,March,April,May,June,July,August,September,October,November,December';
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
        }
        field(39; Year; Option)
        {
            OptionCaption = ' ,2023,2024,2025,2026,2027,2028,2029,2030,2031,2032,2033,2034,2035';
            OptionMembers = " ","2023","2024","2025","2026","2027","2028","2029","2030","2031","2032","2033","2034","2035";
        }
        field(40; "Employer Name"; Text[100])
        {
            Caption = 'Name';
        }
        field(41; "Start Date"; Date)
        {
            trigger OnValidate()
            begin
                "End Date" := CalcDate('<CM>', "Start Date");
                rec.Remarks := Format("End Date", 0, '<Month Text>') + ' - ' + Format(Date2DMY("End Date", 3))
                               + ' ' + Format(Rec."Income Type");
            end;
        }
        field(42; "End Date"; Date)
        {
        }
        field(69; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin

            end;
        }
        field(70; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin

            end;
        }
        field(73; "Responsibility Centre"; Code[20])
        {
            Description = 'LookUp to Responsibility Center BR';
            TableRelation = "Responsibility Center";
        }
        field(74; "SMS Charge"; Code[20])
        {
            TableRelation = "Transaction Types".Code WHERE(Type = CONST("SMS Charge"));
            trigger OnValidate()
            begin
                "Document No" := No;
            end;
        }
        field(76; "Deposit Deduction"; Decimal)
        {
        }
        field(77; "SMS Sent"; Boolean)
        {
            Editable = false;
        }
        field(78; "Donot Recover STO"; Boolean)
        {
            Editable = false;
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

    trigger OnInsert()
    begin
        if No = '' then begin
            NoSetup.Get();
            if Rec."Income Type" = Rec."Income Type"::SAYE then begin
                NoSetup.TestField(NoSetup."Refunds No.");
                No := NoSeriesMgt.GetNextNo(NoSetup."Refunds No.");
                // NoSeriesMgt.InitSeries(NoSetup."Refunds No.", xRec."No. Series", 0D, No, "No. Series");
            end
            else begin
                NoSetup.TestField(NoSetup."Salary Nos.");
                No := NoSeriesMgt.GetNextNo(NoSetup."Salary Nos.");
                // NoSeriesMgt.InitSeries(NoSetup."Salary Nos.", xRec."No. Series", 0D, No, "No. Series");
            end;
        end;

        // if No = '' then begin
        //     NoSetup.Get();
        //     NoSetup.TestField(NoSetup."Salary Nos.");
        //     NoSeriesMgt.InitSeries(NoSetup."Salary Nos.", xRec."No. Series", 0D, No, "No. Series");
        // end;

        "Entered By" := UpperCase(UserId);
        "Date Entered" := Today;
        "Time Entered" := Time;
        "Posting date" := Today;
        if UserSetup.Get(UpperCase(UserId)) then begin
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Centre" := UserSetup."Responsibility Centre";
        end;
        "Document No" := No;
    end;

    var
        NoSetup: Record "Banking No Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        "GL Account": Record "G/L Account";
        BANKACC: Record "Bank Account";
        cust: Record Customer;
        UserSetup: Record "User Setup";
}

