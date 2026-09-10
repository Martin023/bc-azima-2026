table 52185956 "Global SMS Token Registry"
{
    Caption = 'Global SMS Token Registry';
    DataClassification = SystemMetadata;
    LookupPageId = "Global SMS Token List";
    DrillDownPageId = "Global SMS Token List";

    fields
    {
        field(1; Token; Code[50])
        {
            Caption = 'Token';
            DataClassification = SystemMetadata;
            NotBlank = true;

            trigger OnValidate()
            var
                TokenText: Text;
            begin
                // ENFORCE SQUARE BRACKET FORMAT
                TokenText := Token;
                if not TokenText.StartsWith('[') then
                    TokenText := '[' + TokenText;
                if not TokenText.EndsWith(']') then
                    TokenText := TokenText + ']';

                // CONVERT TO UPPERCASE
                Token := CopyStr(UpperCase(TokenText), 1, MaxStrLen(Token));
            end;
        }

        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
            NotBlank = true;
        }

        field(3; Category; Enum "SMS Token Category")
        {
            Caption = 'Category';
            DataClassification = SystemMetadata;
        }

        field(4; "Data Type"; Option)
        {
            Caption = 'Data Type';
            OptionMembers = Text,Decimal,Date,DateTime,Boolean;
            OptionCaption = 'Text,Decimal,Date,DateTime,Boolean';
            DataClassification = SystemMetadata;
        }

        field(5; "Sample Value"; Text[100])
        {
            Caption = 'Sample Value';
            DataClassification = SystemMetadata;
        }

        field(6; "System Defined"; Boolean)
        {
            Caption = 'System Defined';
            DataClassification = SystemMetadata;
            Editable = false;
        }

        field(7; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = SystemMetadata;
            Editable = false;
        }

        field(8; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = SystemMetadata;
            Editable = false;
        }

        field(9; "Last Modified By"; Code[50])
        {
            Caption = 'Last Modified By';
            DataClassification = SystemMetadata;
            Editable = false;
        }

        field(10; "Last Modified Date"; DateTime)
        {
            Caption = 'Last Modified Date';
            DataClassification = SystemMetadata;
            Editable = false;
        }

        field(11; "Usage Count"; Integer)
        {
            Caption = 'Usage Count';
            FieldClass = FlowField;
            CalcFormula = count("SMS Template Token Usage" where(Token = field(Token)));
            Editable = false;
        }
    }

    keys
    {
        key(PK; Token)
        {
            Clustered = true;
        }
        key(Category; Category)
        {
        }
    }

    trigger OnInsert()
    begin
        "Created By" := CopyStr(UserId(), 1, MaxStrLen("Created By"));
        "Created Date" := CurrentDateTime();
        "Last Modified By" := "Created By";
        "Last Modified Date" := "Created Date";
    end;

    trigger OnModify()
    begin
        "Last Modified By" := CopyStr(UserId(), 1, MaxStrLen("Last Modified By"));
        "Last Modified Date" := CurrentDateTime();
    end;

    trigger OnDelete()
    var
        TokenUsage: Record "SMS Template Token Usage";
        ConfirmDeletionLbl: Label 'This token is used in %1 message template(s). Delete anyway?';
    begin
        // PREVENT DELETION IF TOKEN IS IN USE
        CalcFields("Usage Count");
        if "Usage Count" > 0 then
            if not Confirm(ConfirmDeletionLbl, false, "Usage Count") then
                Error('');

        // DELETE USAGE RECORDS
        TokenUsage.SetRange(Token, Token);
        TokenUsage.DeleteAll(true);
    end;
}
