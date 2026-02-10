table 52185931 "Purchase Committments"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = false;
        }
        field(2; Date; Date)
        {
        }
        field(3; "Posting Date"; Date)
        {
        }
        field(4; "Document Type"; Option)
        {
            OptionMembers = LPO,Requisition,Imprest,"Payment Voucher",PettyCash,PurchInvoice;
        }
        field(5; "Document No."; Code[20])
        {
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; "Month Budget"; Decimal)
        {
        }
        field(8; "Month Actual"; Decimal)
        {
        }
        field(9; Committed; Boolean)
        {
        }
        field(10; "Committed By"; Code[20])
        {
        }
        field(11; "Committed Date"; Date)
        {
        }
        field(12; "Committed Time"; Time)
        {
        }
        field(13; "Committed Machine"; Text[100])
        {
        }
        field(14; Cancelled; Boolean)
        {
        }
        field(15; "Cancelled By"; Code[20])
        {
        }
        field(16; "Cancelled Date"; Date)
        {
        }
        field(17; "Cancelled Time"; Time)
        {
        }
        field(18; "Cancelled Machine"; Text[100])
        {
        }
        field(19; "Shortcut Dimension 1 Code"; Code[20])
        {
        }
        field(20; "Shortcut Dimension 2 Code"; Code[20])
        {
        }
        field(21; "Shortcut Dimension 3 Code"; Code[20])
        {
        }
        field(22; "Shortcut Dimension 4 Code"; Code[20])
        {
        }
        field(23; "G/L Account No."; Code[20])
        {
        }
        field(24; Budget; Code[20])
        {
        }
        field(25; "Vendor/Cust No."; Code[20])
        {
        }
        field(26; Type; Option)
        {
            OptionMembers = " ",Vendor,Customer;
        }
        field(27; "Document Line No."; Integer)
        {
        }
        field(28; Quantity; Decimal)
        {
        }
        field(29; "Item No."; Code[10])
        {
        }
        field(30; Posted; Boolean)
        {
            Description = 'Has the entry been posted to the ledger??or for RFQ if it has been converted into an quote the order';
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
        key(Key2; Budget, "Item No.", Date, "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", Posted)
        {
            SumIndexFields = Quantity;
        }
    }

    fieldgroups
    {
    }
}

