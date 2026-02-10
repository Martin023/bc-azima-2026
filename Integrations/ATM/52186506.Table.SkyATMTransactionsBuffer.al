table 52186506 "Sky ATM Transactions Buffer"
{
    DataClassification = AccountData;
    LookupPageId = "Sky ATM Transactions Buffer";
    DrillDownPageId = "Sky ATM Transactions Buffer";

    DataCaptionFields = "Document No.", "Transaction Type";

    fields
    {
        field(1; "No."; BigInteger)
        {
            AutoIncrement = True;
            Editable = false;
        }
        field(2; "Service Name"; Text[50])
        {
            Caption = 'Service Name';
            Editable = false;
        }
        field(3; "Message ID"; Text[50])
        {
            Caption = 'Message ID';
            Editable = false;
        }
        field(4; "Transaction Date Time"; DateTime)
        {
            Caption = 'Transaction Date Time';
            Editable = false;
        }
        field(5; "Terminal ID"; Text[50])
        {
            Caption = 'Terminal ID';
            Editable = false;
        }
        field(6; "Channel"; Text[50])
        {
            Caption = 'Channel';
            Editable = false;
        }
        field(7; "Credit Account"; Text[50])
        {
            Caption = 'SACCO Bank Account Number';
            Description = 'Specifies the organization’s account number with the Service Provider.This is a bank account number';
            Editable = false;
        }
        field(8; "Debit Account"; Text[50])
        {
            Caption = 'SACCO Member Identifier Number';
            Description = 'Specifies the unique identifier for the organization’s customer who is transacting.';
            Editable = false;
        }
        field(9; "Institution Code"; Text[50])
        {
            Caption = 'SACCO Code';
            Editable = false;
        }
        field(10; "Institution Name"; Text[150])
        {
            Caption = 'SACCO Name';
            Editable = false;
        }
        field(11; "Charge Amount"; Decimal)
        {
            Caption = 'Transaction Charge Amount';
            Editable = false;
        }
        field(12; "Charge Currency"; Text[5])
        {
            Caption = 'Transaction Charge Currency';
            Editable = false;
        }
        field(13; "Fee Amount"; Decimal)
        {
            Caption = 'Transaction Fee';
            Editable = false;
        }
        field(14; "Fee Currency"; Text[5])
        {
            Caption = 'Transaction Fee Currency';
            Editable = false;
        }
        field(15; "Transaction Narration"; Text[250])
        {
            Caption = 'Transaction Narration';
            Editable = false;
        }
        field(16; "Additional Info"; Text[1000])
        {
            Caption = 'Additional Info';
            Editable = false;
        }
        field(17; "Connection Mode"; Text[50])
        {
            Caption = 'Connection Mode';
            Editable = false;
        }
        field(18; "Original Message ID"; Text[50])
        {
            Caption = 'Original Message ID';
            Editable = false;
        }
        field(19; "Amount"; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
        }
        field(20; "Currency"; Text[5])
        {
            Caption = 'Amount Currency';
            Editable = false;
        }
        field(21; "Transaction Type"; Enum "ATM Transaction Types")
        {
            Caption = 'Transaction Type';
            Editable = false;
        }
        field(22; "Mobile Number"; Text[15])
        {
            Caption = 'Member Mobile Number';
            Editable = false;
        }

        field(23; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(24; "Posted By"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; "Posting Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(27; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(28; "Reversed By"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(29; "Reversed Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(30; "Reversed Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50; "Transaction ID"; Text[50])
        {
            Caption = 'Transaction ID/Reference';
            Editable = false;
        }
        field(51; "API Request ID"; Text[50])
        {
            Caption = 'API Request ID/Reference';
            Editable = false;
        }
        field(52; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(53; "Transaction Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(54; "Member Savings Account"; code[100])
        {
            Caption = 'Member Savings Account';
            Description = 'Member Savings Account';
            TableRelation = "Savings Accounts"."No.";
            Editable = false;
        }
        field(540; "Member Savings Account Name"; code[100])
        {
            Caption = 'Member Savings Account Name';
            Description = 'Member Savings Account Name';
            CalcFormula = lookup("Savings Accounts".name where("No." = field("Member Savings Account")));
            FieldClass = FlowField;
        }
        field(55; "Is Coop Reversal"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(56; "Posting Remarks"; Text[100])
        {
            Caption = 'Posting Remarks';
            Editable = false;
        }

        field(60; "Device Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "ATM","POS","VISA";
        }
        field(61; "Saccolink Transaction Type"; Enum "Saccolink Transaction Types")
        {
            Caption = 'Saccolink Transaction Type';
            Editable = false;
        }
        field(62; "Signed Amount"; Decimal)
        {
            Caption = 'Signed Amount';
            Editable = false;
        }
        field(100; "Try Posting Count"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(101; "Location"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(102; "Document No."; Text[50])
        {
            Caption = 'Document No.';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Unique; "Message ID")
        {
            // Unique = True;
            Clustered = false;
        }
        key(Key1; Posted, "Member Savings Account")
        {
            SumIndexFields = "Signed Amount";
        }
        key(Key2; "Member Savings Account", "Transaction Date", "Transaction Type")
        {
            SumIndexFields = "Signed Amount";
        }
        // Define non-primary key indexes
        key(IdxPosted; "Posted")
        {
            Clustered = false;
        }
        key(IdxIsCoopReversal; "Is Coop Reversal")
        {
            Clustered = false;
        }
        key(IdxTransactionType; "Transaction Type")
        {
            Clustered = false;
        }
        key(IdxOriginalMessageID; "Original Message ID")
        {
            Clustered = false;
        }
        key(IdxReversed; "Reversed")
        {
            Clustered = false;
        }
        key(IdxTransactionDateTime; "Transaction Date Time")
        {
            Clustered = false;
        }
        key(IdxLocation; "Location")
        {
            Clustered = false;
        }
    }

    trigger OnInsert()
    var
        GlobalFunctions: Codeunit "Global Functions";
        TerminalType: Text;
    begin
        "Transaction ID" := GlobalFunctions.CleanGuid;

        TerminalType := CopyStr("Terminal ID", 1, 3).ToUpper();
        case TerminalType of
            'ATM':
                begin
                    "Device Transaction Type" := "Device Transaction Type"::ATM;
                end;
            'POS':
                begin
                    "Device Transaction Type" := "Device Transaction Type"::POS;
                end;
            else begin
                TerminalType := CopyStr(Channel, 1, 3).ToUpper();
                case TerminalType of
                    'ATM':
                        begin
                            "Device Transaction Type" := "Device Transaction Type"::ATM;
                        end;
                    'POS':
                        begin
                            "Device Transaction Type" := "Device Transaction Type"::POS;
                        end;
                    else begin
                        "Device Transaction Type" := "Device Transaction Type"::VISA;
                    end;
                end;
            end;
        end;

        // Transaction type and narrations
        case "Device Transaction Type" of
            "Device Transaction Type"::ATM:
                begin
                    if "Saccolink Transaction Type" = "Saccolink Transaction Type"::"Balance Enquiry_Sacco_Direct" then begin
                        "Transaction Type" := "Transaction Type"::"ATM Balance";
                        "Transaction Narration" := 'ATM Bal Enq';
                    end else
                        if ("Saccolink Transaction Type" = "Saccolink Transaction Type"::"Cash Withdrawal") or
                        ("Saccolink Transaction Type" = "Saccolink Transaction Type"::"Cardless ATM withdrawal") then begin
                            "Transaction Type" := "Transaction Type"::"ATM Withdrawal";
                            "Transaction Narration" := 'ATM Cash W\d';
                        end else
                            if "Saccolink Transaction Type" = "Saccolink Transaction Type"::"Mini Statement Sacco direct" then begin
                                "Transaction Type" := "Transaction Type"::"ATM Ministatement";
                                "Transaction Narration" := 'ATM Statement';
                            end else begin
                                case "Saccolink Transaction Type" of
                                    "Saccolink Transaction Type"::"KPLC prepaid",
                                    "Saccolink Transaction Type"::"KPLC postpaid",
                                    "Saccolink Transaction Type"::DSTV,
                                    "Saccolink Transaction Type"::ZUKU,
                                    "Saccolink Transaction Type"::"Safaricom Airtime purchase",
                                    "Saccolink Transaction Type"::"Airtel Airtime purchase",
                                    "Saccolink Transaction Type"::"Nairobi water bill payment":
                                        begin
                                            "Transaction Type" := "Transaction Type"::"ATM Utility";
                                            "Transaction Narration" := 'ATM Utility';
                                        end;
                                    else
                                        "Transaction Type" := "Transaction Type"::" ";
                                        "Transaction Narration" := 'Other ATM transaction';
                                end;
                            end;
                end;
            "Device Transaction Type"::POS:
                begin
                    if "Saccolink Transaction Type" = "Saccolink Transaction Type"::"Balance Enquiry_Sacco_Direct" then begin
                        "Transaction Type" := "Transaction Type"::"POS Balance";
                        "Transaction Narration" := 'POS Bal Enq';
                    end else
                        if ("Saccolink Transaction Type" = "Saccolink Transaction Type"::"Cash Withdrawal") OR
                        ("Saccolink Transaction Type" = "Saccolink Transaction Type"::"Cardless ATM withdrawal") then begin
                            "Transaction Type" := "Transaction Type"::"POS Withdrawal";
                            "Transaction Narration" := 'POS Cash W\d';
                        end else
                            if "Saccolink Transaction Type" = "Saccolink Transaction Type"::"Mini Statement Sacco direct" then begin
                                "Transaction Type" := "Transaction Type"::"POS Ministatement";
                                "Transaction Narration" := 'POS Statement';
                            end else
                                if "Saccolink Transaction Type" = "Saccolink Transaction Type"::"POS Cash deposit" then begin
                                    "Transaction Type" := "Transaction Type"::"POS Deposit";
                                    "Transaction Narration" := 'POS Cash Dep';
                                end else
                                    if "Saccolink Transaction Type" = "Saccolink Transaction Type"::"VISA purchases" then begin
                                        "Transaction Type" := "Transaction Type"::"VISA Purchase";
                                        "Transaction Narration" := 'POS Purchase';
                                    end else begin

                                        case "Saccolink Transaction Type" of
                                            "Saccolink Transaction Type"::"KPLC prepaid",
                                            "Saccolink Transaction Type"::"KPLC postpaid",
                                            "Saccolink Transaction Type"::DSTV,
                                            "Saccolink Transaction Type"::ZUKU,
                                            "Saccolink Transaction Type"::"Safaricom Airtime purchase",
                                            "Saccolink Transaction Type"::"Airtel Airtime purchase",
                                            "Saccolink Transaction Type"::"Nairobi water bill payment":
                                                begin
                                                    "Transaction Type" := "Transaction Type"::"ATM Utility";
                                                    "Transaction Narration" := 'POS Utility';
                                                end;
                                            else
                                                "Transaction Type" := "Transaction Type"::" ";
                                                "Transaction Narration" := 'Other POS transaction';
                                        end;

                                    end;
                end;
            "Device Transaction Type"::VISA:
                begin
                    if "Saccolink Transaction Type" = "Saccolink Transaction Type"::"Balance Enquiry_Sacco_Direct" then begin
                        "Transaction Type" := "Transaction Type"::"VISA ATM Balance";
                        "Transaction Narration" := 'VISA Bal Enq';
                    end else
                        if ("Saccolink Transaction Type" = "Saccolink Transaction Type"::"Cash Withdrawal") or
                        ("Saccolink Transaction Type" = "Saccolink Transaction Type"::"Cardless ATM withdrawal") then begin
                            "Transaction Type" := "Transaction Type"::"VISA ATM Withdrawal";
                            "Transaction Narration" := 'VISA Cash W\d';
                        end else
                            if "Saccolink Transaction Type" = "Saccolink Transaction Type"::"Mini Statement Sacco direct" then begin
                                "Transaction Type" := "Transaction Type"::"VISA ATM Ministatement";
                                "Transaction Narration" := 'VISA Statement';
                            end else if "Saccolink Transaction Type" = "Saccolink Transaction Type"::"VISA purchases" then begin
                                "Transaction Type" := "Transaction Type"::"VISA Purchase";
                                "Transaction Narration" := 'VISA Purchase';
                            end else begin
                                case "Saccolink Transaction Type" of
                                    "Saccolink Transaction Type"::"KPLC prepaid",
                                    "Saccolink Transaction Type"::"KPLC postpaid",
                                    "Saccolink Transaction Type"::DSTV,
                                    "Saccolink Transaction Type"::ZUKU,
                                    "Saccolink Transaction Type"::"Safaricom Airtime purchase",
                                    "Saccolink Transaction Type"::"Airtel Airtime purchase",
                                    "Saccolink Transaction Type"::"Nairobi water bill payment":
                                        begin
                                            "Transaction Type" := "Transaction Type"::"ATM Utility";
                                            "Transaction Narration" := 'VISA Utility';
                                        end;
                                    else
                                        "Transaction Type" := "Transaction Type"::" ";
                                        "Transaction Narration" := 'Other VISA transaction';
                                end;
                            end;
                end;
        end;

        if ("Original Message ID" <> '') and ("Saccolink Transaction Type" = "Saccolink Transaction Type"::Reversal) then begin
            "Is Coop Reversal" := true;
        end else begin
            "Is Coop Reversal" := false;
        end;

        CalculateSignedAmount();

        // Format location data
        Location := GlobalFunctions.RemoveExtraWhiteSpaces(Location);
        if Location <> '' then begin
            "Transaction Narration" := "Transaction Narration" + ' ' + Location;
        end;

        "Document No." := "Message ID".Split('_').Get(1);
    end;

    trigger OnDelete()
    begin
        Error('Deletion of records is NOT allowed on this table');
    end;

    procedure GetCoopReference(OriginalText: Text) NewText: Text;
    var
        Position: Integer;
    begin
        // OriginalText := '423607681935_CS_POSTFUNDS';

        // Find the position of the underscore
        Position := StrPos(OriginalText, '_');

        if Position > 0 then
            // Extract the part of the string before the underscore
            NewText := CopyStr(OriginalText, 1, Position - 1)
        else
            // If no underscore is found, use the original text
            NewText := OriginalText;

        exit(NewText);
    end;

    local procedure CalculateSignedAmount()
    var
        SkyATMTransactions: Codeunit "Sky Coop ATM Transactions";
        TotalCharge: Decimal;
    begin
        if "Saccolink Transaction Type" <> "Saccolink Transaction Type"::Reversal then begin
            "Signed Amount" := "Charge Amount";

            // Charges if any
            TotalCharge := SkyATMTransactions.GetTransChargesPreview(
                "Charge Amount",
                "Terminal ID",
                Channel,
                "Saccolink Transaction Type".AsInteger
            );

            case "Transaction Type" of
                "Transaction Type"::"POS Deposit":
                    begin
                        "Signed Amount" := 0;
                    end;
                else
                    "Signed Amount" += TotalCharge;
            end;
        end;
    end;
}