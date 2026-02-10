enum 52186507 "ATM Transaction Types"
{
    value(0; " ") {
        Caption = 'Other ATM Transaction';
    }
    value(1; "ATM Balance") {
        Caption = 'ATM Balance Enquiry';
    }
    value(2; "ATM Withdrawal") {}
    value(3; "ATM Ministatement") {}
    value(13; "ATM Utility") {
        Caption = 'ATM Utility';
    }
    value(4; "POS Balance") {
        Caption = 'POS Balance Enquiry';
    }
    value(5; "POS Withdrawal") {}
    value(6; "POS Deposit") {} //
    value(7; "POS Ministatement") {}
    value(12; "POS Utility") {
        Caption = 'POS Utility';
    }
    value(8; "VISA ATM Balance") {
        Caption = 'VISA ATM Balance Enquiry';
    }
    value(9; "VISA ATM Withdrawal") {}
    value(10; "VISA ATM Ministatement") {}
    value(11; "VISA Purchase") {}
}

enum 52186508 "Saccolink Transaction Types"
{
    value(0001; "M-PESA B2C"){}
    value(0004; "KPLC postpaid"){} //
    value(0005; "KPLC prepaid"){} //
    value(0006; "DSTV"){} //
    value(0007; "ZUKU"){} //
    value(0008; "Safaricom Airtime purchase"){} //
    value(0009; "PesaLink"){}
    value(0010; "POS Cash deposit"){} //
    value(0011; "Cash Withdrawal"){} //
    value(0012; "Cardless ATM withdrawal"){}
    value(0013; "Safaricom C2B"){} //
    value(0014; "Mini Statement Sacco direct"){} //
    value(0015; "Airtel Airtime purchase"){} //
    value(0016; "Balance Enquiry_Sacco_Direct"){} //
    value(0017; "Nairobi water bill payment"){} // MNS
    value(0018; "Bank Account to sacco account"){} //
    value(0019; "Sacco account to bank account"){}
    value(0020; "Airtel B2C"){}
    value(0021; "TELKOM B2C"){}
    value(0022; "Sacco account to Virtual Card"){}
    value(0023; "Virtual card to SACCO"){} //
    value(0024; "Sacco to other Sacco"){}
    value(0025; "Other sacco to Sacco"){}
    value(0026; "Telkom C2B"){} //
    value(0027; "VISA purchases"){} //
    // Request should have same message_id as original transaction
    value(1420; "Reversal"){}
}