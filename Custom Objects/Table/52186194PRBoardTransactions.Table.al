table 52186194 "PR Board Transactions"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
            TableRelation = "Board members"."No.";
        }
        field(2; "Code"; Text[30])
        {
            Editable = true;

            TableRelation = "prBoard Earnings".Code;
            trigger OnValidate()
            var
                BoardDA: Record "prBoard Earnings";
                BoardPH: Record "Board members";
            begin
                BoardDA.Reset();
                BoardDA.SetRange(Code, Rec.Code);
                if BoardDA.FindFirst() then begin
                    Rec.Amount := BoardDA."Flat Amount";
                    Rec."Is Deduction" := BoardDA."Is Deduction";
                    Rec.Taxable := BoardDA.Taxable;
                end;
                GetPayPeriod;
                Date := PayStartDate;
                // "Pay Period":=PayPeriodText;
                Earn.Reset;
                Earn.SetRange(Earn.Code, Code);
                if Earn.Find('-') then begin
                    Name := Earn.Description;
                    "G/L Accounts" := Earn."G/L Account";
                end;
                BoardPH.Reset();
                BoardPH.SetRange("No.", Rec."No.");
                if BoardPH.FindFirst() then begin
                    "Global Dimension 1 Code" := BoardPH."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := BoardPH."Global Dimension 2 Code";
                end;
            end;
        }
        field(3; Description; Text[100])
        {
            Editable = true;
        }
        field(4; Amount; Decimal)
        {
            Editable = true;
        }
        field(5; Date; Date)
        {
            Editable = true;
            TableRelation = "PR Payroll Periods"."Date Opened";

            trigger OnValidate()
            begin
                PayPeriod.RESET;
                PayPeriod.SETRANGE(PayPeriod.Closed, FALSE);
                IF PayPeriod.FIND('-') THEN BEGIN
                    Refernce := PayPeriod."Period Name";
                    MODIFY;
                END;

            end;
        }
        field(6; "Line No"; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(7; Name; Text[50])
        {
            Editable = true;
        }
        field(8; Closed; Boolean)
        {
            Editable = false;
        }
        field(9; "Is Paye"; Boolean)
        {
            Editable = false;
        }
        field(10; "Is Net"; Boolean)
        {
            Editable = false;
        }
        field(11; Refernce; Text[30])
        {
            Editable = false;
        }
        field(12; "G/L Accounts"; Code[50])
        {
            Editable = false;
            TableRelation = "G/L Account"."No.";
        }
        field(13; Blocked; Boolean)
        {

            trigger OnValidate()
            begin
                if not Blocked then begin
                    if Confirm('Unblock this transaction [%1 - %2]', false, "No.", Date) = false then begin
                        Error('Aborted');
                    end else begin
                        Blocked := false;
                    end;
                end else begin
                    if Confirm('Block this transaction [%1 - %2]', false, "No.", Date) = false then begin
                        Error('Aborted');
                    end else begin
                        Blocked := true;
                    end;
                end;
            end;
        }
        field(14; "Is Deduction"; Boolean)
        {
            CalcFormula = Lookup("prBoard Earnings"."Is Deduction" WHERE(Code = FIELD(Code)));
            FieldClass = FlowField;
            Editable = false;
        }
        field(15; "Is Sal Advance"; Boolean)
        {
            CalcFormula = Lookup("prBoard Earnings"."Is Salary Advance" WHERE(Code = FIELD(Code)));
            FieldClass = FlowField;
        }
        field(16; Suspend; Boolean)
        {
        }
        field(17; "Deduction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Other Deductions",Loans;
        }
        field(18; Taxable; Boolean)
        {

            CalcFormula = Lookup("prBoard Earnings".Taxable WHERE(Code = FIELD(Code)));
            FieldClass = FlowField;
            Editable = false;
        }
        field(19; "Payment No."; Code[20])
        {
        }
        field(20; Committed; Boolean)
        {
        }
        field(21; "Dimension Set ID"; Integer)
        {

            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(22; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Editable = false;

            trigger OnValidate()
            begin

            end;
        }
        field(23; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            Editable = false;

            trigger OnValidate()
            begin

            end;
        }
    }

    keys
    {
        key(Key1; "Payment No.", "Line No", "No.", Date, "Code")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
        key(Key2; "Code")
        {
        }
        key(Key3; Date)
        {
        }
        key(Key4; "No.")
        {
            SumIndexFields = Amount;
        }
        key(Key5; Closed)
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    var
        Earn: Record "prBoard Earnings";
        PayPeriod: Record "PR Payroll Periods";
        PayStartDate: Date;
        PayPeriodText: Text[30];



    procedure GetPayPeriod()
    begin
        PayPeriod.SetRange(PayPeriod.Closed, false);
        if PayPeriod.Find('-') then
            PayStartDate := PayPeriod."Date Opened";
        PayPeriodText := PayPeriod."Period Name";
    end;
}

