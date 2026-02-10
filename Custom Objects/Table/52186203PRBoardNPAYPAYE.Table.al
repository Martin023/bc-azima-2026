table 52186203 "PR Board NPAY & PAYE"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
            TableRelation = "Board members";
        }
        field(2; "Code"; Text[30])
        {
            Editable = false;
            TableRelation = "prBoard Earnings".Code;

            trigger OnValidate()
            begin

                //GetPayPeriod;
                Date := PayStartDate;
                // "Pay Period":=PayPeriodText;

                if Earn.Get(Code) then
                    Name := Earn.Description;
            end;
        }
        field(3; Description; Text[100])
        {
        }
        field(4; Amount; Decimal)
        {
            Editable = false;
        }
        field(5; Date; Date)
        {
            Editable = false;
            TableRelation = "PR Payroll Periods"."Date Opened";
        }
        field(6; "Line No"; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(7; Name; Text[50])
        {
            Editable = false;
        }
        field(8; Closed; Boolean)
        {
            CalcFormula = Lookup("PR Payroll Periods".Closed WHERE("Date Opened" = FIELD(Date)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Is Paye"; Boolean)
        {
            Editable = false;
        }
        field(10; "Is Net"; Boolean)
        {
            Editable = false;
        }
        field(11; Blocked; Boolean)
        {

            trigger OnValidate()
            begin
                if not Blocked then begin
                    if Confirm('Unblock this transaction [%1 - %2]', false, "No.", Date) = false then begin
                        Error('Aborted');
                    end else begin
                        Blocked := false;
                        PRBoardTrans.Reset;
                        PRBoardTrans.SetRange(PRBoardTrans."No.", "No.");
                        PRBoardTrans.SetRange(PRBoardTrans.Date, Date);
                        if PRBoardTrans.Find('-') then begin
                            repeat
                                PRBoardTrans.Blocked := false;
                                PRBoardTrans.Modify;
                            until PRBoardTrans.Next = 0;
                        end;
                    end;
                end else begin
                    if Confirm('Block this transaction [%1 - %2]', false, "No.", Date) = false then begin
                        Error('Aborted');
                    end else begin
                        Blocked := true;
                        PRBoardTrans.Reset;
                        PRBoardTrans.SetRange(PRBoardTrans."No.", "No.");
                        PRBoardTrans.SetRange(PRBoardTrans.Date, Date);
                        if PRBoardTrans.Find('-') then begin
                            repeat
                                PRBoardTrans.Blocked := true;
                                PRBoardTrans.Modify;
                            until PRBoardTrans.Next = 0;
                        end;
                    end;
                end;
            end;
        }
        field(12; "Group Order"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Line No", "No.", Date, "Code")
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
        key(Key5; Date, "No.", Blocked)
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
        PRBoardTrans: Record "PR Board Transactions";

    [Scope('OnPrem')]
    procedure GetPayPeriod()
    begin
        PayPeriod.SetRange(PayPeriod.Closed, false);
        if PayPeriod.Find('-') then
            PayStartDate := PayPeriod."Date Opened";
        PayPeriodText := PayPeriod."Period Name";
    end;

    [Scope('OnPrem')]
    procedure fnModifyPRBoardTransactions()
    begin
    end;
}

