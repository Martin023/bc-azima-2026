table 52185429 "Procurement Cue Table"
{
    Caption = 'Procurement Cue Table';
    //FieldClass = FlowField;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';

        }
        field(13; "Store Requisitions"; Integer)
        {
            Caption = 'Requests For Quotations';
            CalcFormula = Count("Store Requistion Header");
            FieldClass = FlowField;
        }

        field(12; "Pending Payment"; Integer)
        {
            Caption = 'Pending Payment';
            CalcFormula = Count("Purchase Quote Header" WHERE(Status = FILTER("Pending Prepayment")));
            FieldClass = FlowField;
        }

        field(4; "Purchase Invoices"; Integer)
        {
            Caption = 'Purchase Invoices';
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST(Invoice)));
            FieldClass = FlowField;
        }
        field(5; "Purchase Credit Memos"; Integer)
        {
            Caption = 'Purchase Credit Memos';
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST("Credit Memo")));
            FieldClass = FlowField;
        }
        field(6; "Sales Invoice"; Integer)
        {
            Caption = 'Sales Invoice';
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST(Invoice)));
            FieldClass = FlowField;
        }
        field(7; "Transfer Orders"; Integer)
        {
            Caption = 'Transfer Orders';
            CalcFormula = Count("Transfer Header" WHERE(Status = FILTER(Released)));
            FieldClass = FlowField;
        }
        field(8; "Purchase Quotes"; Integer)
        {
            Caption = 'Purchase Quotes';
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST(Quote)));
            FieldClass = FlowField;
        }
        field(9; "Employee Requisition"; Integer)
        {
            Caption = 'Approved Employee Requisitions';
            CalcFormula = Count("HR Employee Requisitions" where("Approval Status" = const(Approved)));
            FieldClass = FlowField;
        }
        field(10; "Nonstock Items"; Integer)
        {
            Caption = 'Nonstock Items';
            CalcFormula = Count("Nonstock Item");
            FieldClass = FlowField;
        }
        field(11; "Stock Keeping Units"; Integer)
        {
            Caption = 'Stock Keeping Units';
            CalcFormula = Count("Stockkeeping Unit");
            FieldClass = FlowField;
        }
        field(14; "Purchase Orders"; Integer)
        {
            Caption = 'Purchase Orders';
            CalcFormula = Count("Purchase Header" where("Document Type" = const(Order)));
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(PrimaryKey; "Primary Key")
        {
            Clustered = true;
        }
    }
}
