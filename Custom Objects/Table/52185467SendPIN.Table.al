table 52185467 "Send PIN"
{

    fields
    {
        field(1; "Mobile No."; Code[20])
        {
        }
        field(2; "Account No."; Code[20])
        {
        }
        field(3; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(4; Sent; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Mobile No.", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Mobile No." := '+' + "Mobile No.";
        /*
        SavingsAccounts.RESET;
        SavingsAccounts.SETRANGE("Transactional Mobile No","Mobile No.");
        IF "Account No." <> '' THEN
            SavingsAccounts.SETRANGE("No.","Account No.");
        IF SavingsAccounts.FINDFIRST THEN BEGIN
        
        
            Auth.RESET;
            //Auth.SETRANGE("Account No.",SavingsAccounts."No.");
            Auth.SETRANGE("Mobile No.",SavingsAccounts."Transactional Mobile No");
            IF NOT Auth.FINDFIRST THEN BEGIN
        
                Auth.INIT;
                Auth."Mobile No." := SavingsAccounts."Transactional Mobile No";
                Auth."Account No." := SavingsAccounts."No.";
                Auth."User Status" := Auth."User Status"::Active;
                Auth.INSERT;
                SkyMbanking.GenerateNewPin(COPYSTR(SavingsAccounts."Transactional Mobile No",2,12));
            END;
        
        END;
        */

    end;

    var
        Auth: Record "Sky USSD Auth";
        SavingsAccounts: Record "Savings Accounts";
        // SkyMbanking: Codeunit "Sky Mbanking";
}

