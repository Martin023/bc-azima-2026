table 52185805 "Branch Treasury Accounts"
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
            CalcFormula = Sum("Bank Account Ledger Entry"."Amount (LCY)" WHERE("Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"),
                                                                                "Bank Type" = FILTER(Normal)));
            FieldClass = FlowField;
        }
        field(4; "Till Balances"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry"."Amount (LCY)" WHERE("Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"),
                                                                                "Bank Type" = FILTER(Cashier)));
            FieldClass = FlowField;
        }
        field(5; "Vault Balance"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry"."Amount (LCY)" WHERE("Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"),
                                                                                "Bank Type" = FILTER(Treasury)));
            FieldClass = FlowField;
        }
        field(6; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin

            end;
        }
        field(7; Total; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry"."Amount (LCY)" WHERE("Global Dimension 2 Code" = FIELD("Global Dimension 2 Code")));
            FieldClass = FlowField;
        }
        field(8; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin

            end;
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

    var
        DimMgt: Codeunit DimensionManagement;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        //DimMgt.SaveDefaultDim(DATABASE::"G/L Account","No.",FieldNumber,ShortcutDimCode);
        //MODIFY;
    end;
}

