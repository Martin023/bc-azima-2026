table 52187026 "ATM Inventory"
{
    Caption = 'ATM Inventory';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Atm Inventory List";

    fields
    {
        field(1; "Card Number"; Code[50])
        {
            Caption = 'Card Number';
            // Editable = false;
        }
        field(2; "Account No."; Code[50])
        {
            Caption = 'Account No.';
            TableRelation = "Savings Accounts"."No." where("Product Type" = filter('191'));

            trigger OnValidate()
            begin
                if FosaAcc.get(rec."Account No.") then begin
                    if Member.get(FosaAcc."Member No.") then begin
                        "Member Name" := Member.Name;
                        "ID No." := Member."Primary Identification";
                        if FosaAcc."Transactional Mobile No" <> '' then
                            "Phone No." := FosaAcc."Transactional Mobile No"
                        else
                            "Phone No." := Member."Phone No.";
                        rec."Global Dimension 1 Code" := Member."Global Dimension 1 Code";
                        rec."Global Dimension 2 Code" := Member."Global Dimension 2 Code";
                    end
                    else begin
                        "Member Name" := '';
                        "ID No." := '';
                        "Phone No." := '';
                        rec."Global Dimension 1 Code" := '';
                        rec."Global Dimension 2 Code" := '';
                    end;

                end else begin
                    "Member Name" := '';
                    "ID No." := '';
                    "Phone No." := '';
                    rec."Global Dimension 1 Code" := '';
                    rec."Global Dimension 2 Code" := '';
                end;
            end;
        }
        field(3; "Member Name"; Text[50])
        {
            Caption = 'Member Name';
            // Editable = false;
        }
        field(4; "ID No."; Code[10])
        {
            Caption = 'ID No.';
            // Editable = false;
        }
        field(7; "Date Of Dispatch"; Date)
        {
            Caption = 'Date Of Dispatch';
            // Editable = false;
        }
        field(8; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
            Editable = true;
        }
        field(9; "Phone No."; Code[20])
        {
            Caption = 'Phone No.';
            // Editable = false;
        }
        field(10; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(11; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

        }
        field(12; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionMembers = "Open","In Transit","Pending","Linked","Delinked","Blocked","Discarded","Returned";
        }
        field(13; "To Branch"; Boolean)
        {
            Caption = 'To Branch';
            // Editable = true;
        }

        field(14; "No."; Integer)
        {
            Caption = 'No.';
            // Editable = false;
            AutoIncrement = true;
        }
        field(15; "Dispatch Header No."; Code[20])
        {
            Caption = 'Dispatch Header No.';
            // Editable = false;
        }
        field(16; Received; Boolean)
        {
            Caption = 'Received';
            // Editable = true;
        }
        field(17; "To HQ"; Boolean)
        {
            Caption = 'To HQ';
            // Editable = true;
        }
        field(18; Discarded; Boolean)
        {
            Caption = 'Discarded';
            // Editable = true;
        }
        field(19; "Reference No"; Code[100])
        {

        }
        field(20; "ATM Appl. No"; code[100])
        {
            TableRelation = "ATM Applications"."No." where(Status = filter(Approved), "ATM Charges Applied" = filter(false), "Account No" = field("Account No."));
        }

    }
    keys
    {
        key(Key1; "Account No.", "Reference No")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
        fieldgroup(DropDown; "Account No.", "Member Name", "Card Number", "ID No.")
        {

        }

    }

    trigger ondelete()
    begin
        if rec.Status <> rec.Status::Open then
            Message('You cannot delete an ATM Card that is not open.');

        ATMCardStore.reset;
        ATMCardStore.setrange("Card Number", rec."Card Number");
        if ATMCardStore.findfirst then
            if rec."Reference No" <> '' then
                Error('You cannot delete an ATM Card that is in the ATM Card Storage.');
    end;

    trigger OnInsert()
    begin
        if rec."Reference No" = '' then
            Message('You must enter a Reference No. when inserting a new ATM Card.');
    end;

    var
        Member: record Members;
        FosaAcc: record "Savings Accounts";
        ATMCardStore: record "ATM Card Storage";
}


