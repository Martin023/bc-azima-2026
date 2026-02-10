table 52186322 "Mobile Guarantors Setup"
{

    fields
    {
        field(1; "Product Code"; Code[30])
        {
            TableRelation = "Product Factory"."Product ID" WHERE(AvailableOnMobile = CONST(true),
                                                                  "Mobile Loan Req. Guar." = CONST(true));
        }
        field(2; "Lower Limit"; Decimal)
        {
        }
        field(3; "Upper Limit"; Decimal)
        {
        }
        field(4; "No. of Guarantors"; Integer)
        {
        }
        field(5; "Product Name"; Text[100])
        {
            CalcFormula = Lookup("Product Factory"."Product Description" WHERE("Product ID" = FIELD("Product Code")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Product Code", "Lower Limit", "Upper Limit")
        {
            Clustered = true;
        }
        key(Key2; "No. of Guarantors")
        {
        }
    }

    fieldgroups
    {
    }
}

