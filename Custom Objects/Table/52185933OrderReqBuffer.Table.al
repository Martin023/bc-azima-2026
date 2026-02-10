table 52185933 "Order/Req Buffer"
{

    fields
    {
        field(1; RequisitionNo; Code[20])
        {
        }
        field(2; TotalsOnOrder; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Line Amount" WHERE("Requisition No" = FIELD(RequisitionNo),
                                                                   "Line No." = FIELD("Requisition Line No.")));
            FieldClass = FlowField;
        }
        field(3; TotalonReq; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Line Amount" WHERE("Document No." = FIELD(RequisitionNo),
                                                                   "Line No." = FIELD("Requisition Line No.")));
            FieldClass = FlowField;
        }
        field(4; UserID; Code[20])
        {
        }
        field(5; OrderNo; Code[20])
        {
        }
        field(6; TotalsOnArchiveOrder; Decimal)
        {
            CalcFormula = Sum("Purchase Line Archive"."Line Amount" WHERE("Line No." = FIELD("Requisition Line No.")));
            FieldClass = FlowField;
        }
        field(7; "Requisition Line No."; Integer)
        {
        }
    }

    keys
    {
        key(Key1; RequisitionNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

