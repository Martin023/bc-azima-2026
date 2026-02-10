table 52186196 "Board members"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'Document No';
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."Board PVs No.");
                    "No. Series" := '';
                end;
            end;
        }

        field(3; "Member No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Delegate Officials"."Member Number" where(Status = filter(Approved), Retired = const(false), "Board Member" = const(true));
            trigger OnValidate()
            var
                myInt: Integer;
                DelOff: Record "Delegate Officials";
                BoardLine: Record "Board Payroll Deductions";
                PRboards: Record "PR Board Transactions";
            begin
                Rec."Board Retainer" := 0;
                PRboards.Reset();
                PRboards.SetRange(PRboards."No.", Rec."No.");
                if PRboards.FindFirst() then
                    PRboards.DeleteAll();
                BoardLine.Reset();
                BoardLine.SetRange(BoardLine."Document No", Rec."No.");
                if BoardLine.FindFirst() then
                    BoardLine.DeleteAll();
                DelOff.Reset();
                DelOff.SetRange("Member Number", Rec."Member No.");
                if DelOff.FindFirst() then begin
                    Rec."Job Title" := DelOff.Position;
                    rec."Board Member" := DelOff."Board Member";
                    members.reset();
                    members.SetRange("No.", Rec."Member No.");
                    if members.find('-') then begin
                        Rec."P.I.N" := members."P.I.N Number";
                        Rec."Member Name" := members.Name;
                        Rec."Global Dimension 1 Code" := members."Global Dimension 1 Code";
                        Rec."Global Dimension 2 Code" := members."Global Dimension 2 Code";
                        Rec."Bank Account Number" := members."Bank Account No.";
                        Rec.Mail := members."E-Mail";
                        Rec."National ID" := members."Primary Identification";

                    end;
                end;
            end;
        }
        field(2; "Member Name"; Text[30])
        {


        }

        field(6; "Job Title"; Text[50])
        {
        }
        field(21; "Social Security No."; Text[30])
        {
        }
        field(25; "Country Code"; Code[10])
        {
            TableRelation = "Country/Region".Code;
        }
        field(31; "Member Status"; Option)
        {
            OptionMembers = Active,Inactive,Terminated;
            Editable = false;

            trigger OnValidate()
            begin


            end;
        }
        field(32; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
            Editable = false;
        }
        field(78; Posted; Boolean)

        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(69; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Editable = false;

            trigger OnValidate()
            begin

            end;
        }
        field(70; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            Editable = false;

            trigger OnValidate()
            begin

            end;
        }
        field(41; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }

        field(43; "Project Filter"; Code[10])
        {
            FieldClass = FlowFilter;

        }
        field(47; "Employee No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Employee;
        }
        field(50000; "Pays SSF?"; Boolean)
        {
        }
        field(50001; "Pays tax?"; Boolean)
        {
        }
        field(50002; "Section/Location"; Code[10])
        {

            trigger OnValidate()
            begin

            end;
        }
        field(50003; "Basic Pay"; Decimal)
        {

            trigger OnValidate()
            begin
                // Get first open pay period
                PayPeriod.Reset;
                PayPeriod.SetRange(PayPeriod.Closed, false);
                if PayPeriod.Find('-') then
                    CurrentMonth := PayPeriod."Date Opened";


            end;
        }
        field(50004; "Salary Type"; Code[10])
        {
        }
        field(50005; "Paid Overtime?"; Boolean)
        {
        }
        field(50006; "Tax Relief"; Boolean)
        {
        }
        field(50007; "Overtime taxed"; Boolean)
        {
        }
        field(50008; "Agency Car"; Boolean)
        {
        }
        field(50009; "Housed by Employer"; Boolean)
        {
        }
        field(50010; "Employee's Bank"; Code[10])
        {

            trigger OnValidate()
            begin



            end;
        }
        field(50011; "Paying Bank Code"; Code[10])
        {
            TableRelation = "Bank Account";
        }

        field(50014; "Employee Type"; Code[10])
        {

        }

        field(50017; Payment; Code[10])
        {
            TableRelation = "prBoard Earnings";
        }
        field(50018; Deduction; Code[10])
        {
            TableRelation = "prBoard Deductions";
        }
        field(50019; "Posting Group"; Code[10])
        {
            NotBlank = true;
            TableRelation = "prEmployee Posting Group";
        }

        field(50021; "Bank Account Number"; Code[20])
        {
        }

        field(50023; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "PR Payroll Periods";
        }
        field(50024; "Opening SSF"; Decimal)
        {
        }
        field(50025; "Opening PAYE"; Decimal)
        {
        }

        field(50028; "Opening Employer SSF"; Decimal)
        {
        }
        field(50030; "Tax Relief Amount"; Decimal)
        {
        }
        field(50031; "P.I.N"; Code[20])
        {
            Editable = false;
        }
        field(50032; "Passport No."; Code[20])
        {
        }

        field(50037; "N.H.I.F No"; Code[20])
        {
        }
        field(50038; "Hourly Rate"; Decimal)
        {
        }
        field(50039; "Daily Rate"; Decimal)
        {
        }
        field(50040; "Pays N.H.I.F"; Boolean)
        {
        }
        field(50041; "Last Modified By"; Code[20])
        {
            Editable = false;
        }
        field(50042; "Gross Cash"; Decimal)
        {
        }
        field(50043; "Debtor Code"; Code[10])
        {
            TableRelation = Customer;
        }

        field(50046; "Pay Mode"; Option)
        {
            OptionMembers = Bank,Cash,Cheque,"Bank Transfer";
        }
        field(50047; Housing; Option)
        {
            OptionMembers = Agricultural,Directors,Ordinary;
        }

        field(50050; "Home Ownership Status"; Option)
        {
            OptionMembers = "None","Owner Occupier","Home Savings";
        }
        field(50052; "National ID"; Code[20])
        {
            Editable = false;
        }
        field(50053; "House Rent"; Decimal)
        {
        }
        field(50054; "Employer Rent"; Boolean)
        {
        }
        field(50055; "Total Quarters"; Decimal)
        {
        }

        field(50058; PensionNo; Code[10])
        {
        }
        field(50059; "Salary Scheme Category"; Code[20])
        {
            TableRelation = "prBoard Category";
        }
        field(50060; "Salary Steps"; Code[20])
        {
            TableRelation = "prBoard Salary Steps"."Step Code" WHERE("Category code" = FIELD("Salary Scheme Category"),
                                                                      Level = FIELD(Level));

            trigger OnValidate()
            begin
                if Employee.Get("No.") then
                    if "Member Status" = "Member Status"::Active then begin
                        // populate the basic salary based on the steps
                        if SalaryStep.Get("Salary Steps", SalaryStep.Level::"Level 1", "Salary Scheme Category") then begin
                            "Basic Pay" := SalaryStep."Basic amount";
                            "Gross pay" := SalaryStep."Gross pay";
                        end;
                        // Get first open pay period
                        PayPeriod.Reset;
                        PayPeriod.SetRange(PayPeriod.Closed, false);
                        if PayPeriod.Find('-') then
                            CurrentMonth := PayPeriod."Date Opened";
                    end else
                        Error('Employee not active');

            end;
        }
        field(50061; Level; Option)
        {
            OptionMembers = "Level 1","Level 2";
        }

        field(50066; "House allowance"; Decimal)
        {
        }
        field(50067; Overtime; Decimal)
        {
        }
        field(50068; Absence; Decimal)
        {
        }
        field(50069; "Other allowances"; Decimal)
        {
        }
        field(50070; "Total earnings"; Decimal)
        {
            //TableRelation="prBoard Deductions";
            FieldClass = FlowField;
            CalcFormula = Sum("PR Board Transactions".Amount WHERE("No." = field("No.")));
        }
        field(50071; PAYE; Decimal)
        {
        }
        field(50072; NHIF; Decimal)
        {
        }
        field(50073; NSSF; Decimal)
        {
        }

        field(50075; Loans; Decimal)
        {
        }
        field(50076; COOP; Decimal)
        {
        }
        field(50077; "Other deductions"; Decimal)
        {
        }
        field(50079; "Net pay"; Decimal)
        {
        }
        field(50080; "Advance Code Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "prBoard Deductions".Code;
        }
        field(50081; "Gross pay"; Decimal)
        {
        }
        field(50083; "Account Group"; Code[20])
        {
        }
        field(50084; "Payslip Message"; Text[100])
        {
        }
        field(50085; "Actual Basic Salary"; Decimal)
        {
        }
        field(50086; "Days Worked"; Integer)
        {

            trigger OnValidate()
            begin
                if "Days Worked" <> 0 then begin
                    if "Actual Basic Salary" <> 0 then begin
                        BasicPay := ("Actual Basic Salary" / 30) * "Days Worked";
                        "Basic Pay" := BasicPay;
                        Modify;
                        Validate("Basic Pay")
                    end;
                end;
            end;
        }

        field(50088; "Low Interest Benefits"; Decimal)
        {
        }
        field(50089; "Terminal Dues Code"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "prBoard Earnings".Code;
        }
        field(50090; Pensionable; Boolean)
        {
        }
        field(50091; "Account Type"; Code[20])
        {
        }
        field(50092; "Specify Tax Band"; Boolean)
        {
        }
        field(50093; "Tax Percentage"; Decimal)
        {
        }
        field(50094; "Board Member"; Boolean)
        {
            Editable = false;
        }
        field(50095; "Inactive Date"; Date)
        {
        }

        field(50100; Mail; Text[100])
        {
        }
        field(50101; "Suspend Pay"; Boolean)
        {
        }
        field(50102; "No. Series"; code[30])
        {
        }
        field(20; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Board Retainer"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
                Genset: Record "General Set-Up";
                PrBoard: Record "PR Board Transactions";
                prBoa: Decimal;
            begin
                Genset.Get();
                PrBoard.Reset();
                PrBoard.SetRange("No.", Rec."No.");
                PrBoard.SetRange(Taxable, true);
                if PrBoard.FindFirst() then begin
                    PrBoard.CalcSums(PrBoard.Amount);
                    prBoa := PrBoard.Amount;
                end;
                Rec."Withholding Tax Amount" := (Rec."Board Retainer" + prBoa) * Genset."Withholding %" * 0.01;

            end;
        }
        field(26; "Withholding Tax Amount"; Decimal)
        {
            Editable = false;
        }
        field(27; Date; date)
        {
            Caption = 'Date';
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(481;Committed;Boolean)
        {
            Description = 'Defines whether the record is committed for budget';
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
        if "No." = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Board PVs No.");
            NoSeriesMgt.InitSeries(NoSetup."Board PVs No.", xRec."No.", 0D, "No.", "No. Series");
        end;

    end;

    var
        Emp: Record "HR Employees";
        SalaryStep: Record "prBoard Salary Steps";
        PayPeriod: Record "PR Payroll Periods";
        CurrentMonth: Date;
        AssMatrix: Record "PR Period Transactions";
        Earn: Record "prBoard Earnings";
        Netpay: Decimal;
        EmployeeLegderEntry: RecordID;
        Employee: Record "Board members";
        "HR Setup": Record "HR Setup";
        LoadEarnings: Record "prBoard Earnings";
        LoadDeductions: Record "prBoard Deductions";
        BasicPay: Decimal;
        ActualBasicPay: Decimal;
        Ded: Record "prBoard Deductions";
        Amount: Decimal;
        NoSetup: Record "Cash Office Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        members: Record Members;
        ProductFactory: Record "Product Factory";
        Loans: Record Loans;
        SavingsAccount: Record "Savings Accounts";
        SavLedEntries: Record "Savings Ledger Entry";
        CredLedEntries: Record "Credit Ledger Entry";
        prorata: Record "Member Prorata_Contractual Dep";
}

