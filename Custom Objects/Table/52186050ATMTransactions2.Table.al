table 52186050 "ATM Transactions 2"
{

    fields
    {
        field(1; ID; Integer)
        {
        }
        field(2; "Account No"; Code[16])
        {
        }
        field(3; "Processing Code"; Text[6])
        {
        }
        field(4; "Transaction Amount"; Text[12])
        {
        }
        field(5; "Cardholder Billing"; Text[12])
        {
        }
        field(6; "Transmission Date Time"; Text[10])
        {
        }
        field(7; "Conversion Rate"; Text[8])
        {
        }
        field(8; "System Trace Audit No"; Text[6])
        {
        }
        field(9; "Date Time - Local"; Text[12])
        {
        }
        field(10; "Expiry Date"; Text[4])
        {
        }
        field(11; "POS Entry Mode"; Text[12])
        {
        }
        field(12; "Function Code"; Text[3])
        {
        }
        field(13; "POS Capture Code"; Text[4])
        {
        }
        field(14; "Transaction Fee"; Text[6])
        {
        }
        field(15; "Settlement Fee"; Text[3])
        {
        }
        field(16; "Settlement Processing Fee"; Text[250])
        {
        }
        field(17; "Acquiring Institution ID Code"; Text[250])
        {
        }
        field(18; "Forwarding Institution ID Code"; Text[250])
        {
        }
        field(19; "Transaction 2 Data"; Text[250])
        {
        }
        field(20; "Retrieval Reference No"; Text[12])
        {
        }
        field(21; "Authorisation ID Response"; Text[6])
        {
        }
        field(22; "Response Code"; Text[3])
        {
        }
        field(23; "Card Acceptor Terminal ID"; Text[8])
        {
        }
        field(24; "Card Acceptor ID Code"; Text[15])
        {
        }
        field(25; "Card Acceptor Name/Location"; Text[250])
        {
        }
        field(26; "Additional Data - Private"; Text[250])
        {
        }
        field(27; "Transaction Currency Code"; Text[3])
        {
        }
        field(28; "Settlement Curreny Code"; Text[3])
        {
        }
        field(29; "Cardholder Billing Cur Code"; Text[3])
        {
        }
        field(30; "Response Indicator"; Text[250])
        {
        }
        field(31; "Service Indicator"; Text[250])
        {
        }
        field(32; "Replacement Amounts"; Text[250])
        {
        }
        field(33; "Receiving Institution ID Code"; Text[250])
        {
        }
        field(34; "Account Identification 2"; Text[250])
        {
        }
        field(35; Status; Option)
        {
            OptionMembers = Sent,Failed;
        }
        field(36; "Transaction Type"; Option)
        {
            OptionCaption = 'Balance Enquiry,Mini Statement,Cash Withdrawal - Coop ATM,Cash Withdrawal - VISA ATM,Reversal,Utility Payment,POS - Normal Purchase,M-PESA Withdrawal,Airtime Purchase,POS - School Payment,POS - Purchase With Cash Back,POS - Cash Deposit,POS - Benefit Cash Withdrawal,POS - Cash Deposit to Card,POS - M Banking,POS - Cash Withdrawal,MINIMUM BALANCE';
            OptionMembers = "Balance Enquiry","Mini Statement","Cash Withdrawal - Coop ATM","Cash Withdrawal - VISA ATM",Reversal,"Utility Payment","POS - Normal Purchase","M-PESA Withdrawal","Airtime Purchase","POS - School Payment","POS - Purchase With Cash Back","POS - Cash Deposit","POS - Benefit Cash Withdrawal","POS - Cash Deposit to Card","POS - M Banking","POS - Cash Withdrawal","MINIMUM BALANCE";
        }
        field(37; "Bitmap - Hexadecimal"; Text[32])
        {
        }
        field(38; "Bitmap - Binary"; Text[128])
        {
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

