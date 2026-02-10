table 52185757 "M-SACCO Applications"
{
    // DrillDownPageID = "MBanking Applications List";
    // LookupPageID = "MBanking Applications List";

    fields
    {
        field(1; No; Code[30])
        {
        }
        field(2; "Date Entered"; Date)
        {
        }
        field(3; "Time Entered"; Time)
        {
        }
        field(4; "Entered By"; Code[40])
        {
        }
        field(5; "Document Serial No"; Text[50])
        {
        }
        field(6; "Document Date"; Date)
        {
        }
        field(7; "Customer ID No"; Code[50])
        {

            trigger OnValidate()
            begin
                "Customer ID No" := DelChr("Customer ID No", '=', 'A|B|C|D|E|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|.|,|!|@|#|$|%|^|&|*|(|)|[|]|{|}|/|\|"|;|:|<|>|?|+|-|_');

                // FieldLength("Customer ID No", 10);
            end;
        }
        field(8; "Customer Name"; Text[200])
        {

            trigger OnValidate()
            begin

                /*
                "Customer Name":=DELCHR("Customer Name",'=','0|1|2|3|4|5|6|7|8|9|,|!|@|#|$|%|^|&|*|(|)|[|]|{|}|/|\|"|;|:|<|>|?|-|+|_|~');
                //FieldLength("MPESA Mobile No",10);
                */

            end;
        }
        field(9; "MPESA Mobile No"; Text[50])
        {
            Editable = false;

            trigger OnValidate()
            begin

                /*
                
                "MPESA Mobile No":=DELCHR("MPESA Mobile No",'=','A|B|C|D|E|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|.|,|!|@|#|$|%|^|&|*|(|)|[|]|{|}|/|\|"|;|:|<|>|?|-');
                 FieldLength("MPESA Mobile No",13);
                */

            end;
        }
        field(10; "MPESA Corporate No"; Code[30])
        {
        }
        field(11; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(12; Comments; Text[200])
        {
        }
        field(13; "Rejection Reason"; Text[30])
        {
        }
        field(14; "Date Approved"; Date)
        {
        }
        field(15; "Time Approved"; Time)
        {
        }
        field(16; "Approved By"; Code[30])
        {
        }
        field(17; "Date Rejected"; Date)
        {
        }
        field(18; "Time Rejected"; Time)
        {
        }
        field(19; "Rejected By"; Code[30])
        {
        }
        field(20; "Sent To Server"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(21; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(22; "1st Approval By"; Code[30])
        {
        }
        field(23; "Date 1st Approval"; Date)
        {
        }
        field(24; "Time First Approval"; Time)
        {
        }
        field(25; "Withdrawal Limit Code"; Code[20])
        {
            TableRelation = "M-SACCO Withdrawal Limits".Code;

            trigger OnValidate()
            begin
                WithdrawLimit.Reset;
                WithdrawLimit.SetRange(WithdrawLimit.Code, "Withdrawal Limit Code");
                if WithdrawLimit.Find('-') then begin
                    WithdrawLimit.TestField(WithdrawLimit."Limit Amount");
                    "Withdrawal Limit Amount" := WithdrawLimit."Limit Amount";
                end;
            end;
        }
        field(26; "Withdrawal Limit Amount"; Decimal)
        {
        }
        field(27; "Application Type"; Option)
        {
            OptionMembers = Initial,Change;

            trigger OnValidate()
            begin
                "Document Serial No" := No;
                if "Application Type" = "Application Type"::Initial then begin
                    if "Application No" <> '' then begin
                        Error('Please ensure the application number field is blank if the application is not a change application.');
                    end;
                end;
                if "Application Type" = "Application Type"::Initial then
                    Comments := 'New App'
                else
                    if "Application Type" = "Application Type"::Change then
                        Comments := 'Change Mobile No';
            end;
        }
        field(28; "Application No"; Code[10])
        {
            TableRelation = "M-SACCO Applications".No WHERE(Status = CONST(Approved));

            trigger OnValidate()
            begin

                if "Application Type" <> "Application Type"::Change then begin
                    Error('The application must be a change application before selecting this option.');
                end;

                MPESAApp.Reset;
                MPESAApp.SetRange(MPESAApp.No, "Application No");
                if MPESAApp.Find('-') then begin
                    "Old Telephone No" := MPESAApp."MPESA Mobile No";
                    "Document Serial No" := MPESAApp."Document Serial No";
                    "Customer ID No" := MPESAApp."Customer ID No";
                    "Customer Name" := MPESAApp."Customer Name";
                    "Membership No" := MPESAApp."Membership No";
                    "MPESA Mobile No" := MPESAApp."MPESA Mobile No";

                end
                else begin

                    "Old Telephone No" := '';

                end;

                MPESAAppDetails.Reset;
                MPESAAppDetails.SetRange(MPESAAppDetails."Application No", No);
                if MPESAAppDetails.Find('-') then begin
                    repeat
                        MPESAAppDetails.Delete;
                    until MPESAAppDetails.Next = 0
                end;


                MPESAAppDetails.Reset;
                MPESAAppDetails.SetRange(MPESAAppDetails."Application No", "Application No");
                if MPESAAppDetails.Find('-') then begin
                    repeat

                        MPESAAppDet2.Reset;
                        MPESAAppDet2.Init;
                        MPESAAppDet2."Application No" := No;
                        MPESAAppDet2."Account Type" := MPESAAppDetails."Account Type";
                        MPESAAppDet2."Account No." := MPESAAppDetails."Account No.";
                        MPESAAppDet2.Description := MPESAAppDetails.Description;
                        MPESAAppDet2.Insert;

                    until MPESAAppDetails.Next = 0
                end;
            end;
        }
        field(29; Changed; Option)
        {
            OptionMembers = No,Yes;
        }
        field(30; "Date Changed"; Date)
        {
        }
        field(31; "Time Changed"; Time)
        {
        }
        field(32; "Changed By"; Code[30])
        {
        }
        field(33; "Old Telephone No"; Code[30])
        {
        }
        field(34; "I agree information is true"; Boolean)
        {
        }
        field(35; "App Status"; Option)
        {
            OptionMembers = Pending,"1st Approval",Approved,Rejected;
        }
        field(36; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility CenterBR";
        }
        field(37; "Virtual Registration"; Boolean)
        {
        }
        field(38; "Membership No"; Code[30])
        {
            TableRelation = "Savings Accounts"."Member No." WHERE("Loan Disbursement Account" = CONST(true));
        }
        field(39; "Account No"; Code[30])
        {
            TableRelation = "Savings Accounts"."No." WHERE("Loan Disbursement Account" = CONST(true));

            trigger OnValidate()
            begin

                SavingsAccount.Reset;
                SavingsAccount.SetRange(SavingsAccount."Product Type", '505');
                SavingsAccount.SetRange(SavingsAccount."No.", "Account No");
                if SavingsAccount.Find('-') then begin

                    Members.Reset;
                    Members.SetRange(Members."No.", SavingsAccount."Member No.");
                    if Members.Find('-') then begin

                        AppendMobile := Members."Phone No.";

                        Length := StrLen(AppendMobile);
                        if Length = 10 then begin
                            AppendMobile := '+254' + CopyStr(AppendMobile, 2, 9);
                        end
                        else begin
                            AppendMobile := '+254' + CopyStr(AppendMobile, 5, 12);
                        end;
                        "Customer ID No" := Members."Primary Identification";
                        "MPESA Mobile No" := AppendMobile;
                        "Customer Name" := SavingsAccount.Name;

                    end;


                    MPESAAppDet2.Reset;
                    MPESAAppDet2.SetRange(MPESAAppDet2."Application No", No);
                    if MPESAAppDet2.Find('-') then begin

                        //ERROR('FOUND');

                        MPESAAppDet2."Account Type" := MPESAAppDet2."Account Type";
                        MPESAAppDet2."Account No." := "Account No";
                        MPESAAppDet2.Description := "Customer Name";
                        MPESAAppDet2.Modify(true);

                    end

                    else begin

                        MPESAAppDet2.Init;
                        MPESAAppDet2."Application No" := No;
                        MPESAAppDet2."Account Type" := 1;
                        MPESAAppDet2."Account No." := "Account No";
                        MPESAAppDet2.Description := "Customer Name";
                        MPESAAppDet2.Insert;

                    end;

                end;
            end;
        }
        field(40; Delinked; Boolean)
        {
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

    trigger OnDelete()
    begin


        /*
        IF Status<>Status::Open THEN BEGIN
        ERROR('You cannot delete the MPESA transaction because it has already been sent for first approval.');
        END;
        */

    end;

    trigger OnInsert()
    begin

        if No = '' then begin
            NoSetup.Get;
            NoSetup.TestField(NoSetup."M-SACCO Application Nos");
            NoSeriesMgt.InitSeries(NoSetup."M-SACCO Application Nos", xRec."No. Series", 0D, No, "No. Series");
        end;


        "Entered By" := UserId;
        "Date Entered" := Today;
        "Time Entered" := Time;
        Validate("Application Type");
    end;

    var
        NoSetup: Record "Banking No Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        WithdrawLimit: Record "M-SACCO Withdrawal Limits";
        MPESAApp: Record "M-SACCO Applications";
        MPESAAppDetails: Record "M-SACCO Application Details";
        MPESAAppDet2: Record "M-SACCO Application Details";
        SavingsAccount: Record "Savings Accounts";
        AppendMobile: Text[30];
        Members: Record Members;
        Length: Integer;

    [Scope('OnPrem')]
    procedure FieldLength(VarVariant: Text; FldLength: Integer): Text
    var
        FieldLengthError: Label 'Field cannot be more than %1 Characters.';
    begin
        if StrLen(VarVariant) > FldLength then
            Error(FieldLengthError, FldLength);
    end;
}

