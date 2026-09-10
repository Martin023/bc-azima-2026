table 52185954 "Global SMS Template"
{
    Caption = 'Global SMS Template';
    DataClassification = CustomerContent;
    LookupPageId = "Global SMS Template List";
    DrillDownPageId = "Global SMS Template List";

    fields
    {
        field(1; "Event Code"; Code[50])
        {
            Caption = 'Event Code';
            DataClassification = CustomerContent;
            NotBlank = true;

            trigger OnValidate()
            var
                EventCodeText: Text;
            begin
                // CONVERT TO UPPERCASE, REPLACE SPACES WITH UNDERSCORES
                EventCodeText := "Event Code";
                EventCodeText := EventCodeText.Replace(' ', '_');
                "Event Code" := CopyStr(UpperCase(EventCodeText), 1, MaxStrLen("Event Code"));
            end;
        }

        field(2; "Event Description"; Text[100])
        {
            Caption = 'Event Description';
            DataClassification = CustomerContent;
            NotBlank = true;
        }

        field(3; "Message Body"; Text[500])
        {
            Caption = 'Message Body';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                // AUTO-DETECT TOKENS AND UPDATE USAGE TABLE
                UpdateTokenUsage();
            end;
        }

        field(4; Enabled; Boolean)
        {
            Caption = 'Enabled';
            DataClassification = CustomerContent;
            InitValue = true;
        }

        field(5; "SMS Source"; Enum "SMS Source")
        {
            Caption = 'SMS Source';
            DataClassification = CustomerContent;
        }

        field(6; Module; Enum "SMS Module")
        {
            Caption = 'Module';
            DataClassification = CustomerContent;
        }

        field(7; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(8; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(9; "Last Modified By"; Code[50])
        {
            Caption = 'Last Modified By';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(10; "Last Modified Date"; DateTime)
        {
            Caption = 'Last Modified Date';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(11; "Token Count"; Integer)
        {
            Caption = 'Tokens Used';
            FieldClass = FlowField;
            CalcFormula = count("SMS Template Token Usage" where("Event Code" = field("Event Code")));
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Event Code")
        {
            Clustered = true;
        }
        key(Module; Module, Enabled)
        {
        }
    }

    trigger OnInsert()
    begin
        "Created By" := CopyStr(UserId(), 1, MaxStrLen("Created By"));
        "Created Date" := CurrentDateTime();
        "Last Modified By" := "Created By";
        "Last Modified Date" := "Created Date";

        UpdateTokenUsage();
    end;

    trigger OnModify()
    begin
        LogChange();
        "Last Modified By" := CopyStr(UserId(), 1, MaxStrLen("Last Modified By"));
        "Last Modified Date" := CurrentDateTime();
    end;

    trigger OnDelete()
    var
        TokenUsage: Record "SMS Template Token Usage";
    begin
        // DELETE TOKEN USAGE RECORDS
        TokenUsage.SetRange("Event Code", "Event Code");
        TokenUsage.DeleteAll(true);
    end;

    procedure UpdateTokenUsage()
    var
        TokenUsage: Record "SMS Template Token Usage";
        TokenRegistry: Record "Global SMS Token Registry";
        MessageText: Text;
        UpperMessageText: Text;
        UpperToken: Text;
    begin
        // CLEAR EXISTING USAGE RECORDS
        TokenUsage.SetRange("Event Code", "Event Code");
        TokenUsage.DeleteAll(true);

        // SCAN MESSAGE FOR TOKENS (CASE-INSENSITIVE)
        MessageText := "Message Body";
        UpperMessageText := UpperCase(MessageText);

        TokenRegistry.Reset();
        if TokenRegistry.FindSet() then
            repeat
                UpperToken := UpperCase(TokenRegistry.Token);

                if UpperMessageText.Contains(UpperToken) then begin
                    TokenUsage.Init();
                    TokenUsage."Event Code" := "Event Code";
                    TokenUsage.Token := TokenRegistry.Token;
                    TokenUsage."Auto Detected" := true;
                    if TokenUsage.Insert() then;
                end;
            until TokenRegistry.Next() = 0;
    end;

    local procedure LogChange()
    var
        History: Record "Global SMS Template History";
        OldRecord: Record "Global SMS Template";
    begin
        // LOG CHANGES TO AUDIT TRAIL
        if OldRecord.Get("Event Code") then begin
            if (OldRecord."Message Body" <> "Message Body") or
               (OldRecord.Enabled <> Enabled) then
            begin
                History.Init();
                History."Entry No." := 0;
                History."Event Code" := "Event Code";
                History."Modified By" := CopyStr(UserId(), 1, MaxStrLen(History."Modified By"));
                History."Modified Date" := CurrentDateTime();

                if OldRecord."Message Body" <> "Message Body" then begin
                    History.Action := History.Action::Modified;
                    History."Old Value" := OldRecord."Message Body";
                    History."New Value" := "Message Body";
                end else begin
                    if Enabled then
                        History.Action := History.Action::Enabled
                    else
                        History.Action := History.Action::Disabled;
                end;

                History.Insert(true);
            end;
        end;
    end;
}
