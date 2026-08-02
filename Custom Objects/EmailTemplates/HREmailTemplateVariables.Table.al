table 52185902 "HR Email Template Variables"
{
    Caption = 'HR Email Template Variables';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Event Code"; Code[50])
        {
            Caption = 'Event Code';
            NotBlank = true;
        }
        field(2; "Token"; Code[50])
        {
            Caption = 'Token';
            NotBlank = true;
            // EXACT STRING USED IN EMAIL BODY E.G. [EMPLOYEE_NAME]
        }
        field(3; "Variable Name"; Text[100])
        {
            Caption = 'Variable Name';
            // HUMAN LABEL E.G. Employee Name
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
            // WHAT VALUE THIS TOKEN WILL CONTAIN AT SEND TIME
        }
        field(5; "System Defined"; Boolean)
        {
            Caption = 'System Defined';
            Editable = false;
            // TRUE = SEEDED BY SYSTEM, CANNOT BE DELETED OR MODIFIED
        }
        field(6; "Source Table No."; Integer)
        {
            Caption = 'Source Table';
            // TABLE ID FOR USER-ADDED CATEGORY B TOKENS
            // E.G. 52185532 = HR Leave Application
            // BLANK FOR SYSTEM-DEFINED TOKENS (CATEGORY A — VALUE COMES FROM CALLING CODE)

            trigger OnValidate()
            var
                RecRef: RecordRef;
                AllObj: Record AllObj;
            begin
                "Source Field No." := 0;
                "Source Table Name" := '';
                if "Source Table No." <> 0 then begin
                    AllObj.Reset();
                    AllObj.SetRange("Object Type", AllObj."Object Type"::Table);
                    AllObj.SetRange("Object ID", "Source Table No.");
                    if AllObj.FindFirst() then
                        "Source Table Name" := AllObj."Object Name";
                end;
            end;
        }
        field(7; "Source Table Name"; Text[100])
        {
            Caption = 'Source Table Name';
            Editable = false;
        }
        field(8; "Source Field No."; Integer)
        {
            Caption = 'Source Field';
            // FIELD NUMBER WITHIN THE SOURCE TABLE TO READ AT SEND TIME
            // BLANK FOR SYSTEM-DEFINED TOKENS

            trigger OnValidate()
            var
                FieldRec: Record Field;
            begin
                "Source Field Name" := '';
                if ("Source Table No." <> 0) and ("Source Field No." <> 0) then begin
                    FieldRec.Reset();
                    FieldRec.SetRange(TableNo, "Source Table No.");
                    FieldRec.SetRange("No.", "Source Field No.");
                    if FieldRec.FindFirst() then begin
                        "Source Field Name" := FieldRec.FieldName;
                        // AUTO-GENERATE TOKEN FROM FIELD NAME IF TOKEN IS BLANK
                        if Token = '' then
                            Token := '[' + UpperCase(DelChr(FieldRec.FieldName, '=', ' .-/')) + ']';
                        // AUTO-POPULATE VARIABLE NAME IF BLANK
                        if "Variable Name" = '' then
                            "Variable Name" := FieldRec.FieldName;
                    end;
                end;
            end;
        }
        field(9; "Source Field Name"; Text[100])
        {
            Caption = 'Source Field Name';
            Editable = false;
        }
        field(10; "Sort Order"; Integer)
        {
            Caption = 'Sort Order';
            // CONTROLS DISPLAY ORDER IN THE SUBPART — SYSTEM ROWS FIRST
        }
    }

    keys
    {
        key(Key1; "Event Code", Token)
        {
            Clustered = true;
        }
        key(Key2; "Event Code", "System Defined", "Sort Order")
        {
        }
    }

    trigger OnDelete()
    begin
        // SYSTEM-DEFINED TOKENS CANNOT BE DELETED — DISPATCHER RELIES ON THEM
        if "System Defined" then
            Error('CANNOT DELETE SYSTEM-DEFINED TOKEN [%1]. THIS TOKEN IS REQUIRED BY THE EMAIL DISPATCHER.', Token);
    end;
}
