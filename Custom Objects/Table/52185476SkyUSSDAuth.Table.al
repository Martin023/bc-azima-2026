table 52185476 "Sky USSD Auth"
{

    fields
    {
        field(1; "Mobile No."; Code[30])
        {
        }
        field(2; "Account No."; Code[30])
        {

            trigger OnValidate()
            begin
                /*
                IF Vend.GET("Account No.") THEN BEGIN
                    Vend."Transactional Mobile No" := "Mobile No.";
                    Vend.MODIFY;
                END;
                
                Vend.RESET;
                Vend.SETRANGE("Transactional Mobile No","Mobile No.");
                Vend.SETFILTER("No.",'<>%1',"Account No.");
                IF Vend.FINDFIRST THEN
                    Vend.MODIFYALL("Transactional Mobile No",'');
                */

            end;
        }
        field(3; "PIN No."; Text[250])
        {
            Editable = true;
        }
        field(4; "Reset PIN"; Boolean)
        {

            trigger OnValidate()
            begin


                Vend.Get("Account No.");

                PINChangeLog.Init;
                PINChangeLog.Date := CurrentDateTime;
                PINChangeLog."Account No." := "Account No.";
                PINChangeLog."Account Name" := Vend.Name;
                PINChangeLog."Changed By" := UserId;
                PINChangeLog."Old Value" := Format(xRec."Reset PIN");
                PINChangeLog."New Value" := Format("Reset PIN");
                PINChangeLog."Field Modified" := 'Reset PIN';
                PINChangeLog.Insert;
            end;
        }
        field(5; "User Status"; Option)
        {
            OptionCaption = 'Active,Inactive, ';
            OptionMembers = Active,Inactive," ";

            trigger OnValidate()
            begin

                Vend.Get("Account No.");

                PINChangeLog.Init;
                PINChangeLog.Date := CurrentDateTime;
                PINChangeLog."Account No." := "Account No.";
                PINChangeLog."Account Name" := Vend.Name;
                PINChangeLog."Changed By" := UserId;
                PINChangeLog."Old Value" := Format(xRec."User Status");
                PINChangeLog."New Value" := Format("User Status");
                PINChangeLog."Field Modified" := 'User Status';
                PINChangeLog.Insert;
            end;
        }
        field(6; "Date Created"; Date)
        {
        }
        field(7; "Date Updated"; Date)
        {
        }
        field(8; "Initial PIN Sent"; Boolean)
        {
        }
        field(9; "Force PIN"; Boolean)
        {

            trigger OnValidate()
            begin

                "Reset PIN" := "Force PIN";

                Vend.Get("Account No.");

                PINChangeLog.Init;
                PINChangeLog.Date := CurrentDateTime;
                PINChangeLog."Account No." := "Account No.";
                PINChangeLog."Account Name" := Vend.Name;
                PINChangeLog."Changed By" := UserId;
                PINChangeLog."Old Value" := Format(xRec."Force PIN");
                PINChangeLog."New Value" := Format("Force PIN");
                PINChangeLog.Insert;
            end;
        }
        field(10; "Pin Sent"; Boolean)
        {
        }
        field(11; IMSI; Text[250])
        {

            trigger OnValidate()
            begin

                Vend.Get("Account No.");

                PINChangeLog.Init;
                PINChangeLog.Date := CurrentDateTime;
                PINChangeLog."Account No." := "Account No.";
                PINChangeLog."Account Name" := Vend.Name;
                PINChangeLog."Changed By" := UserId;
                PINChangeLog."Old Value" := Format(xRec.IMSI);
                PINChangeLog."New Value" := Format(IMSI);
                PINChangeLog."Field Modified" := 'IMSI';
                PINChangeLog.Insert;
            end;
        }
        field(12; IMEI; Text[250])
        {

            trigger OnValidate()
            begin

                Vend.Get("Account No.");

                PINChangeLog.Init;
                PINChangeLog.Date := CurrentDateTime;
                PINChangeLog."Account No." := "Account No.";
                PINChangeLog."Account Name" := Vend.Name;
                PINChangeLog."Changed By" := UserId;
                PINChangeLog."Old Value" := Format(xRec.IMEI);
                PINChangeLog."New Value" := Format(IMEI);
                PINChangeLog."Field Modified" := 'IMEI';
                PINChangeLog.Insert;
            end;
        }
        field(13; "Mobile App Activated"; Boolean)
        {
        }
        field(15; "Mobile App KYC Login Enabled"; Boolean)
        {
        }
        field(16; "PIN Encrypted"; Boolean)
        {
        }
        field(17; "Login Attempts Count"; Integer)
        {
        }
        field(18; "Login Attempts Tag"; Text[30])
        {
        }
        field(19; "Login Attempts Action"; Text[50])
        {
        }
        field(20; "Login Attempts Action Expiry"; DateTime)
        {
        }
        field(21; "OTP Attempts Count"; Integer)
        {
        }
        field(22; "OTP Attempts Tag"; Text[30])
        {
        }
        field(23; "OTP Attempts Action"; Text[50])
        {
        }
        field(24; "OTP Attempts Action Expiry"; DateTime)
        {
        }
        field(25; "Clear M-Banking Suspension"; Boolean)
        {

            trigger OnValidate()
            begin

                Vend.Get("Account No.");

                PINChangeLog.Init;
                PINChangeLog.Date := CurrentDateTime;
                PINChangeLog."Account No." := "Account No.";
                PINChangeLog."Account Name" := Vend.Name;
                PINChangeLog."Changed By" := UserId;
                PINChangeLog."Old Value" := Format(xRec."Clear M-Banking Suspension");
                PINChangeLog."New Value" := Format("Clear M-Banking Suspension");
                PINChangeLog."Field Modified" := 'Clear M-Banking Suspension';
                PINChangeLog.Insert;
            end;
        }
        field(26; "Pin Resent"; Boolean)
        {
        }
        field(27; "Charge Pin"; Boolean)
        {
        }
        field(28; "Login Attempts Count P"; Integer)
        {
        }
        field(29; "Login Attempts Tag P"; Text[30])
        {
        }
        field(30; "Login Attempts Action P"; Text[50])
        {
        }
        field(31; "Login Attempts Action Expiry P"; DateTime)
        {
        }
        field(32; "OTP Attempts Count P"; Integer)
        {
        }
        field(33; "OTP Attempts Tag P"; Text[30])
        {
        }
        field(34; "OTP Attempts Action P"; Text[50])
        {
        }
        field(35; "OTP Attempts Action Expiry P"; DateTime)
        {
        }
        field(36; Username; Text[50])
        {
        }
        field(37; Password; Text[250])
        {
        }
        field(38; "KYC Test"; Boolean)
        {
        }
        field(39; "Initial Password Changed"; Boolean)
        {
        }
        field(40; "Login Username Type"; Option)
        {
            OptionMembers = Phone,"E-Mail";
        }
        field(41; "Password Expiry Time"; DateTime)
        {
        }
    }

    keys
    {
        key(Key1; "Mobile No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PINChangeLog: Record "Sky PIN Change Log";
        Vend: Record "Savings Accounts";
}

