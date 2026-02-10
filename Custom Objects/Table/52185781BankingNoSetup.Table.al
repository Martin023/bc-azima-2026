table 52185781 "Banking No Setup"
{
    DrillDownPageId = "Banking No Setup";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "Cashier Transaction Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(3; "Treasury & Teller Trans Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(4; "Standing Order Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(5; "RTGS Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(6; "Salary Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(7; "Standing Order Reg. Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(8; "Cheque Receipts Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(9; "Cheque Application Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(10; "Bankers Cheque Application Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(11; "Overdraft Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(12; "M-SACCO Application Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(13; "M-SACCO Change Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(14; "Change M-SACCO PIN Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(15; "BULK SMS Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(16; "Account Transfer Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(17; "ATM Application Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(18; "FOSA Interest Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(19; "Investment Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(20; "Standing Order Control Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(21; "ATM Linking Application Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(22; "Online Transactions"; Code[10])
        {
        }
        field(23; "Document Apprvls."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(24; "EFT Line Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(25; "Delegate Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(26; "Delegate Sub Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(27; "Delegate Application Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(28; "Delegate Payment Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(29; "Delegate Minutes Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(30; "Account Closure"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(31; "Delega Change"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(32; "Agency Update Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(33; "Dispatch ATM Header No."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(34; "Refunds No."; Code[10])
        {
            Caption = 'Refund between A/Cs.';
            TableRelation = "No. Series";
        }
        field(35; "Investment Interest Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(36; "Account Activation"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(37; "BOSA Account Activation"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(38; "Treasury Control No."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(39; "Loan Refund No."; Code[10])
        {
            Caption = 'Loan Clearance No.';
            TableRelation = "No. Series";
        }
        field(40; "ATM Repin"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(41; "ATM Return No."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(42; "Mobile Banking No."; Code[10])
        {
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

