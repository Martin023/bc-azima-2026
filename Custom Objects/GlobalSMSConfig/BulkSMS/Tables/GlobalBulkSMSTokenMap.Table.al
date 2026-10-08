table 52185985 "Global Bulk SMS Token Map"
{
    Caption = 'Global Bulk SMS Token Map';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Campaign No."; Code[20])
        {
            Caption = 'Campaign No.';
            DataClassification = CustomerContent;
            TableRelation = "Global Bulk SMS Header"."Campaign No.";
        }

        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }

        field(3; "Token Code"; Code[50])
        {
            Caption = 'Token Code';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                TokenText: Text;
            begin
                if "Token Code" = '' then
                    Error('Token Code cannot be blank.');

                TokenText := "Token Code";

                if not TokenText.StartsWith('[') then
                    TokenText := '[' + TokenText;
                if not TokenText.EndsWith(']') then
                    TokenText := TokenText + ']';

                "Token Code" := CopyStr(UpperCase(TokenText), 1, MaxStrLen("Token Code"));

                CheckDuplicateToken();
            end;
        }

        field(4; "Token Description"; Text[100])
        {
            Caption = 'Token Description';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Token Description" = '' then
                    Error('Token Description cannot be blank.');
            end;
        }

        field(5; "Source Type"; Option)
        {
            Caption = 'Source Type';
            DataClassification = CustomerContent;
            OptionMembers = " ","Member Field","Savings Field","Loan Field",Calculated,FlowField;
            OptionCaption = ' ,Member Field,Savings Field,Loan Field,Calculated,FlowField';

            trigger OnValidate()
            begin
                case "Source Type" of
                    "Source Type"::" ":
                        "Source Table ID" := 0;
                    "Source Type"::"Member Field":
                        "Source Table ID" := Database::Members;
                    "Source Type"::"Savings Field":
                        "Source Table ID" := Database::"Savings Accounts";
                    "Source Type"::"Loan Field":
                        "Source Table ID" := Database::Loans;
                    "Source Type"::Calculated,
                    "Source Type"::FlowField:
                        if "Source Table ID" = 0 then
                            "Source Table ID" := Database::Members;
                end;

                "Source Field Name" := '';
                "Source Field Caption" := '';
                "Sample Value" := '';
            end;
        }

        field(6; "Source Table ID"; Integer)
        {
            Caption = 'Source Table ID';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Source Table ID" <= 0 then
                    Error('Source Table ID must be greater than zero.');

                "Source Field Name" := '';
                "Source Field Caption" := '';
            end;
        }

        field(7; "Source Field Name"; Text[100])
        {
            Caption = 'Source Field Name';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                RecRef: RecordRef;
                FldRef: FieldRef;
                i: Integer;
                Found: Boolean;
            begin
                if "Source Field Name" = '' then begin
                    "Source Field Caption" := '';
                    "Data Type" := "Data Type"::Text;
                    exit;
                end;

                if "Source Table ID" = 0 then
                    Error('Source Table ID must be specified before selecting a field.');

                RecRef.Open("Source Table ID");
                Found := false;

                for i := 1 to RecRef.FieldCount() do begin
                    FldRef := RecRef.FieldIndex(i);
                    if UpperCase(FldRef.Name) = UpperCase("Source Field Name") then begin
                        "Source Field Caption" := FldRef.Caption;
                        Found := true;

                        case FldRef.Type of
                            FieldType::Text,
                            FieldType::Code:
                                "Data Type" := "Data Type"::Text;
                            FieldType::Integer,
                            FieldType::Decimal,
                            FieldType::BigInteger:
                                "Data Type" := "Data Type"::Decimal;
                            FieldType::Date:
                                "Data Type" := "Data Type"::Date;
                            FieldType::DateTime:
                                "Data Type" := "Data Type"::DateTime;
                            FieldType::Boolean:
                                "Data Type" := "Data Type"::Boolean;
                            else
                                "Data Type" := "Data Type"::Text;
                        end;

                        break;
                    end;
                end;

                RecRef.Close();

                if not Found then
                    Error('Field %1 does not exist in table %2.', "Source Field Name", "Source Table ID");
            end;
        }

        field(8; "Source Field Caption"; Text[100])
        {
            Caption = 'Source Field Caption';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(9; "Calculation Type"; Option)
        {
            Caption = 'Calculation Type';
            DataClassification = CustomerContent;
            OptionMembers = None,Sum,Count,Average,Max,Min;
            OptionCaption = 'None,Sum,Count,Average,Max,Min';
            InitValue = None;

            trigger OnValidate()
            begin
                if "Source Type" <> "Source Type"::Calculated then
                    if "Calculation Type" <> "Calculation Type"::None then
                        Error('Calculation Type can only be set for Calculated source type.');

                if "Calculation Type" in ["Calculation Type"::Sum, "Calculation Type"::Average] then
                    if "Data Type" <> "Data Type"::Decimal then
                        Error('Sum and Average calculations require Decimal data type.');
            end;
        }

        field(10; "Filter Expression"; Text[250])
        {
            Caption = 'Filter Expression';
            DataClassification = CustomerContent;
        }

        field(11; "Data Type"; Option)
        {
            Caption = 'Data Type';
            DataClassification = CustomerContent;
            OptionMembers = Text,Decimal,Date,DateTime,Boolean,Integer;
            OptionCaption = 'Text,Decimal,Date,DateTime,Boolean,Integer';
            InitValue = Text;
        }

        field(12; "Format String"; Text[50])
        {
            Caption = 'Format String';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Format String" <> '' then
                    if not ("Data Type" in ["Data Type"::Decimal, "Data Type"::Date, "Data Type"::DateTime, "Data Type"::Integer]) then
                        Error('Format String is only applicable for Decimal, Date, DateTime, and Integer data types.');
            end;
        }

        field(13; "Sample Value"; Text[100])
        {
            Caption = 'Sample Value';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Campaign No.", "Line No.")
        {
            Clustered = true;
        }
        key(Token; "Campaign No.", "Token Code")
        {
        }
        key(SourceType; "Source Type", "Source Table ID")
        {
        }
    }

    trigger OnInsert()
    var
        Header: Record "Global Bulk SMS Header";
    begin
        if not Header.Get("Campaign No.") then
            Error('Campaign %1 does not exist.', "Campaign No.");

        Header.CheckEditAllowed();

        // Don't validate on insert - allow incomplete records to be saved as draft
        // Validation will happen when Test Token or Preview Messages is clicked
        if "Token Code" <> '' then
            CheckDuplicateToken();
    end;

    trigger OnModify()
    var
        Header: Record "Global Bulk SMS Header";
    begin
        Header.Reset();
        Header.SetRange("Campaign No.", "Campaign No.");
        if Header.FindFirst() then
            Header.CheckEditAllowed();

        CheckDuplicateToken();
    end;

    trigger OnDelete()
    var
        Header: Record "Global Bulk SMS Header";
    begin
        Header.Reset();
        Header.SetRange("Campaign No.", "Campaign No.");
        if Header.FindFirst() then
            Header.CheckEditAllowed();
    end;

    local procedure CheckDuplicateToken()
    var
        ExistingToken: Record "Global Bulk SMS Token Map";
    begin
        if "Token Code" = '' then
            exit;

        ExistingToken.SetRange("Campaign No.", "Campaign No.");
        ExistingToken.SetRange("Token Code", "Token Code");
        ExistingToken.SetFilter("Line No.", '<>%1', "Line No.");

        if not ExistingToken.IsEmpty() then
            Error('Token %1 already exists in this campaign.', "Token Code");
    end;

    procedure GetFieldValue(MemberNo: Code[20]): Text
    var
        RecRef: RecordRef;
        FldRef: FieldRef;
        Member: Record Members;
        SavingsAccount: Record "Savings Accounts";
        Loan: Record Loans;
        i: Integer;
        Found: Boolean;
        FieldValue: Text;
    begin
        if MemberNo = '' then
            Error('Member No. cannot be blank when resolving token %1.', "Token Code");

        if not Member.Get(MemberNo) then
            Error('Member %1 does not exist.', MemberNo);

        if "Source Type" = "Source Type"::Calculated then
            exit(Format(CalculateValue(MemberNo)));

        case "Source Type" of
            "Source Type"::"Member Field":
                RecRef.GetTable(Member);
            "Source Type"::"Savings Field":
                begin
                    SavingsAccount.SetRange("Member No.", MemberNo);
                    if "Filter Expression" <> '' then
                        SavingsAccount.SetFilter("No.", "Filter Expression");

                    if not SavingsAccount.FindFirst() then
                        exit('');

                    RecRef.GetTable(SavingsAccount);
                end;
            "Source Type"::"Loan Field":
                begin
                    Loan.SetRange("Member No.", MemberNo);
                    if "Filter Expression" <> '' then
                        Loan.SetFilter("Loan No.", "Filter Expression");

                    if not Loan.FindFirst() then
                        exit('');

                    RecRef.GetTable(Loan);
                end;
        end;

        Found := false;
        for i := 1 to RecRef.FieldCount() do begin
            FldRef := RecRef.FieldIndex(i);
            if UpperCase(FldRef.Name) = UpperCase("Source Field Name") then begin
                Found := true;

                if FldRef.Class = FieldClass::FlowField then
                    FldRef.CalcField();

                FieldValue := Format(FldRef.Value);
                break;
            end;
        end;

        RecRef.Close();

        if not Found then
            Error('Field %1 not found in table %2 for token %3.', "Source Field Name", "Source Table ID", "Token Code");

        exit(FormatValue(FieldValue));
    end;

    local procedure CalculateValue(MemberNo: Code[20]): Decimal
    var
        RecRef: RecordRef;
        FldRef: FieldRef;
        Member: Record Members;
        TempSavingsAcc: Record "Savings Accounts";
        TempLoan: Record Loans;
        ResultValue: Decimal;
        RecordCount: Integer;
        i: Integer;
    begin
        if not Member.Get(MemberNo) then
            Error('Member %1 does not exist.', MemberNo);

        if "Calculation Type" = "Calculation Type"::None then
            Error('Calculation Type must be specified for calculated token %1.', "Token Code");

        if "Source Field Name" = '' then
            if not ("Calculation Type" = "Calculation Type"::Count) then
                Error('Source Field Name is required for %1 calculation in token %2.', "Calculation Type", "Token Code");

        RecRef.Open("Source Table ID");

        case "Source Table ID" of
            Database::"Savings Accounts":
                RecRef.Field(TempSavingsAcc.FieldNo("Member No.")).SetRange(MemberNo);
            Database::Loans:
                RecRef.Field(TempLoan.FieldNo("Member No.")).SetRange(MemberNo);
        end;

        if "Filter Expression" <> '' then begin
            if "Source Field Name" <> '' then begin
                for i := 1 to RecRef.FieldCount() do begin
                    FldRef := RecRef.FieldIndex(i);
                    if UpperCase(FldRef.Name) = UpperCase("Source Field Name") then begin
                        FldRef.SetFilter("Filter Expression");
                        break;
                    end;
                end;
            end;
        end;

        RecordCount := RecRef.Count();

        case "Calculation Type" of
            "Calculation Type"::Count:
                ResultValue := RecordCount;
            "Calculation Type"::Sum,
            "Calculation Type"::Average,
            "Calculation Type"::Max,
            "Calculation Type"::Min:
                begin
                    if RecordCount = 0 then
                        exit(0);

                    if not RecRef.FindSet() then
                        exit(0);

                    repeat
                        for i := 1 to RecRef.FieldCount() do begin
                            FldRef := RecRef.FieldIndex(i);
                            if UpperCase(FldRef.Name) = UpperCase("Source Field Name") then begin
                                if FldRef.Class = FieldClass::FlowField then
                                    FldRef.CalcField();

                                case "Calculation Type" of
                                    "Calculation Type"::Sum,
                                    "Calculation Type"::Average:
                                        ResultValue += GetDecimalFromFieldRef(FldRef);
                                    "Calculation Type"::Max:
                                        if GetDecimalFromFieldRef(FldRef) > ResultValue then
                                            ResultValue := GetDecimalFromFieldRef(FldRef);
                                    "Calculation Type"::Min:
                                        if (ResultValue = 0) or (GetDecimalFromFieldRef(FldRef) < ResultValue) then
                                            ResultValue := GetDecimalFromFieldRef(FldRef);
                                end;
                                break;
                            end;
                        end;
                    until RecRef.Next() = 0;

                    if "Calculation Type" = "Calculation Type"::Average then
                        if RecordCount > 0 then
                            ResultValue := ResultValue / RecordCount;
                end;
        end;

        RecRef.Close();
        exit(ResultValue);
    end;

    local procedure GetDecimalFromFieldRef(FldRef: FieldRef): Decimal
    var
        DecimalValue: Decimal;
    begin
        if Evaluate(DecimalValue, Format(FldRef.Value)) then
            exit(DecimalValue);
        exit(0);
    end;

    local procedure FormatValue(Value: Text): Text
    var
        DecimalValue: Decimal;
        DateValue: Date;
        DateTimeValue: DateTime;
        IntegerValue: Integer;
    begin
        if Value = '' then
            exit('');

        if "Format String" = '' then
            exit(Value);

        case "Data Type" of
            "Data Type"::Decimal:
                if Evaluate(DecimalValue, Value) then
                    exit(Format(DecimalValue, 0, "Format String"));
            "Data Type"::Date:
                if Evaluate(DateValue, Value) then
                    exit(Format(DateValue, 0, "Format String"));
            "Data Type"::DateTime:
                if Evaluate(DateTimeValue, Value) then
                    exit(Format(DateTimeValue, 0, "Format String"));
            "Data Type"::Integer:
                if Evaluate(IntegerValue, Value) then
                    exit(Format(IntegerValue, 0, "Format String"));
        end;

        exit(Value);
    end;

    procedure TestTokenValue(TestMemberNo: Code[20]): Text
    var
        TestValue: Text;
    begin
        if TestMemberNo = '' then
            Error('Test Member No. cannot be blank.');

        TestValue := GetFieldValue(TestMemberNo);

        "Sample Value" := CopyStr(TestValue, 1, MaxStrLen("Sample Value"));
        Modify(true);

        exit(TestValue);
    end;
}
