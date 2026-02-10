table 52185806 "Main Treasury Account"
{

    fields
    {
        field(1; No; Code[30])
        {
        }
        field(2; "Treasury Name"; Text[100])
        {
        }
        field(3; "Bank Balances"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry"."Amount (LCY)" WHERE("Bank Type" = CONST(Normal)));
            FieldClass = FlowField;
        }
        field(4; "Till Balances"; Decimal)
        {
            CalcFormula = - Sum("Bank Account Ledger Entry"."Amount (LCY)" WHERE("Bank Type" = CONST(Cashier)));
            FieldClass = FlowField;
        }
        field(5; "Vault Balances"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry"."Amount (LCY)" WHERE("Bank Type" = CONST(Treasury)));
            FieldClass = FlowField;
        }
        field(6; Total; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry"."Amount (LCY)");
            FieldClass = FlowField;
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
}

