table 52185924 "Payment Line Staff"
{

    fields
    {
        field(1; "Document No"; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Payment Types"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Staff Allowance Setup".Code;

            trigger OnValidate()
            begin
                "Exempt Amount" := 0;
                AllowanceSetUp.Reset;
                AllowanceSetUp.SetRange(AllowanceSetUp.Code, Rec."Payment Types");
                if AllowanceSetUp.Find('-') then begin
                    Description := AllowanceSetUp.Description;
                    "G/L Account No." := AllowanceSetUp."Allowance GL";
                    "Exempt Amount" := AllowanceSetUp."Exempt Amount";
                end;
                Validate(Amount);
                //getDestinationRateAndAmounts;
            end;
        }
        field(3; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Repayment,Deposits Contribution,Rejoining Fee,Registration Fee,Insurance Contribution,Shares Capital,Investment,Un-allocated Funds';
            OptionMembers = " ",Repayment,"Deposits Contribution","Rejoining Fee","Registration Fee","Insurance Contribution","Shares Capital",Investment,"Un-allocated Funds";
        }
        field(4; "Loan No."; Code[20])
        {
        }
        field(5; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                AllowanceSetUp.Reset;
                AllowanceSetUp.SetRange(AllowanceSetUp.Code, "Payment Types");
                if AllowanceSetUp.FindFirst then begin
                    "W/Tax Amount" := AllowanceSetUp."Tax %" / 100 * (Amount - AllowanceSetUp."Exempt Amount" * "No of Days");
                    "Net Amount" := Amount - "W/Tax Amount";
                    "Tax Account" := AllowanceSetUp."Tax GL";
                end;
            end;
        }
        field(6; "W/Tax Amount"; Decimal)
        {
            Editable = false;
        }
        field(7; "Net Amount"; Decimal)
        {
            Editable = false;
        }
        field(8; "Amount Balance"; Decimal)
        {
            Enabled = false;
        }
        field(9; "Interest Balance"; Decimal)
        {
            Enabled = false;
        }
        field(10; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin

                //"Dimension Set ID" := DimMgt.GetDimSetFilter(1,"Shortcut Dimension 1 Code","Dimension Set ID");
            end;
        }
        field(11; Description; Text[50])
        {
        }
        field(12; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin

                //"Dimension Set ID" := DimMgt.GetDimSetFilter(2,"Shortcut Dimension 2 Code","Dimension Set ID");
            end;
        }
        field(13; "G/L Account No."; Code[20])
        {
            TableRelation = "G/L Account"."No." WHERE("Direct Posting" = CONST(true));

            trigger OnValidate()
            begin
                GLAccount.Get("G/L Account No.");
                "Budgetary Control A/C" := GLAccount."Budget Controlled";
            end;
        }
        field(14; "Member No."; Code[20])
        {
            TableRelation = "Staff Members"."Member No." WHERE(Status = CONST(Active));

            trigger OnValidate()
            begin

                "Staff Allowance Grade" := '';
                "Exempt Amount" := 0;
                if Cust.Get("Member No.") then begin
                    "Member Name" := Cust.Name;
                end;

                if StaffMembers.Get("Member No.") then begin
                    "Staff Allowance Grade" := StaffMembers."Allowance Grade";

                end;
                SavingsAccounts.Reset;
                SavingsAccounts.SetRange(SavingsAccounts."Member No.", "Member No."); //*****
                SavingsAccounts.SetRange("Loan Disbursement Account", true);
                if SavingsAccounts.FindSet then
                    "Savings Account" := SavingsAccounts."No.";
                //////getDestinationRateAndAmounts();



                Member.Reset;
                Member.SetRange(Member."No.", "Member No.");
                if Member.Find('-') then begin
                    "Shortcut Dimension 1 Code" := Member."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := Member."Global Dimension 2 Code";

                end
            end;
        }
        field(15; "Member Name"; Text[30])
        {
        }
        field(16; "Savings Account"; Code[20])
        {
            Description = 'FOSA';
            TableRelation = "Savings Accounts"."No." WHERE("Member No." = FIELD("Member No."),
                                                            "Product Category" = CONST(" "));

            trigger OnValidate()
            begin
                /*PaymentLineBoard.RESET;
                PaymentLineBoard.SETRANGE("Document No","Document No");
                PaymentLineBoard.SETRANGE("Savings Account","Savings Account");
                IF PaymentLineBoard.FIND('-') THEN BEGIN
                  IF PaymentLineBoard.COUNT>1 THEN
                  ERROR('Account already added');
                  END;*/

            end;
        }
        field(17; "Perdiem Amount"; Decimal)
        {
        }
        field(18; "External DOC No"; Code[35])
        {
        }
        field(19; "SMS Sent"; Boolean)
        {
        }
        field(20; Committed; Boolean)
        {
        }
        field(21; "Budgetary Control A/C"; Boolean)
        {
        }
        field(90; "Employee Job Group"; Code[10])
        {
            Editable = false;
        }
        field(91; "Daily Rate(Amount)"; Decimal)
        {
        }
        field(480; "Dimension Set ID"; Integer)
        {
        }
        field(481; "Destination Code"; Code[20])
        {
            TableRelation = "Travel Destination"."Destination Code";

            trigger OnValidate()
            begin
                //////getDestinationRateAndAmounts();
            end;
        }
        field(482; "No of Days"; Decimal)
        {

            trigger OnValidate()
            begin
                //////getDestinationRateAndAmounts();
            end;
        }
        field(483; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(484; "Staff No."; Code[20])
        {
        }
        field(485; "Tax Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(486; "Transaction Code"; Code[10])
        {
            TableRelation = "Transaction Type".Code;
        }
        field(487; "Staff Allowance Grade"; Code[10])
        {
            Editable = false;
            TableRelation = "Staff Allowance Grades";
        }
        field(488; "Exempt Amount"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Document No", "Line No")
        {
            Clustered = true;
        }
        key(Key2; "Document No", "Member No.")
        {
            SumIndexFields = Amount, "Net Amount";
        }
    }

    fieldgroups
    {
    }

    var
        Loans: Record Loans;
        Cust: Record Members;
        ReceiptsPayments: Record "Staff Allowance Lines";
        RecTypes: Record "Staff Allowance Lines";
        SavingsAccounts: Record "Savings Accounts";
        TariffCodes: Record "Tariff Code s";
        DimMgt: Codeunit DimensionManagement;
        GLAccount: Record "G/L Account";
        Member: Record Members;
        HREmp: Record "HR Employees";
        TravelDestination: Record "Travel Destination";
        PaymentLineBoard: Record "Payment Line Staff";
        StaffMembers: Record "Staff Members";
        AllowanceSetUp: Record "Staff Allowance Setup";

    [Scope('OnPrem')]
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    [Scope('OnPrem')]
    procedure getDestinationRateAndAmounts()
    var
        Members: Record Members;
        HREmployees: Record "HR Employees";
        EmpGrade: Code[20];
        objDestRateEntry: Record "Destination Rate Entry";
    begin
        //Reset the brare fields
        "Daily Rate(Amount)" := 0;
        Amount := 0;


        if Members.Get("Member No.") then begin
            "Staff No." := Members."Payroll/Staff No.";
            //Get the Emp No
            HREmployees.Reset;
            HREmployees.SetRange(HREmployees."No.", Members."Payroll/Staff No.");
            if HREmployees.Find('-') then begin
                EmpGrade := HREmployees.Grade;
            end else begin
                EmpGrade := 'DIRECTORS';
            end;
            objDestRateEntry.Reset;
            objDestRateEntry.SetRange(objDestRateEntry."Employee Job Group", EmpGrade);
            objDestRateEntry.SetRange(objDestRateEntry."Destination Code", "Destination Code");
            objDestRateEntry.SetRange(objDestRateEntry."Advance Code", "Payment Types");
            if objDestRateEntry.Find('-') then begin

                "Daily Rate(Amount)" := objDestRateEntry."Daily Rate (Amount)";
                Validate(Amount, objDestRateEntry."Daily Rate (Amount)" * "No of Days");
            end;
        end
        else begin
            "Daily Rate(Amount)" := RecTypes."Allowance Amount";
            Amount := "Daily Rate(Amount)" * "No of Days";
            "Exempt Amount" := RecTypes."Exempt Amount";
        end;
    end;
}

