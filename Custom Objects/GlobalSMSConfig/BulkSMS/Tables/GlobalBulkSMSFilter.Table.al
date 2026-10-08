table 52185647 "Global Bulk SMS Filter"
{
    Caption = 'Global Bulk SMS Filter';
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

        field(3; "Filter Source"; Option)
        {
            Caption = 'Filter Source';
            DataClassification = CustomerContent;
            OptionMembers = " ",Member,"Savings Account",Loan;
            OptionCaption = ' ,Member,Savings Account,Loan';

            trigger OnValidate()
            begin
                case "Filter Source" of
                    "Filter Source"::" ":
                        "Source Table ID" := 0;
                    "Filter Source"::Member:
                        "Source Table ID" := Database::Members;
                    "Filter Source"::"Savings Account":
                        "Source Table ID" := Database::"Savings Accounts";
                    "Filter Source"::Loan:
                        "Source Table ID" := Database::Loans;
                end;

                "Field Name" := '';
                "Field Caption" := '';
                "Filter Value 1" := '';
                "Filter Value 2" := '';
                UpdateDescription();
            end;
        }

        field(4; "Source Table ID"; Integer)
        {
            Caption = 'Source Table ID';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Source Table ID" <= 0 then
                    Error('Source Table ID must be greater than zero.');

                "Field Name" := '';
                "Field Caption" := '';
                UpdateDescription();
            end;
        }

        field(5; "Field Name"; Text[100])
        {
            Caption = 'Field Name';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                RecRef: RecordRef;
                FldRef: FieldRef;
                i: Integer;
                Found: Boolean;
            begin
                if "Field Name" = '' then begin
                    "Field Caption" := '';
                    UpdateDescription();
                    exit;
                end;

                if "Source Table ID" = 0 then
                    Error('Source Table ID must be specified before selecting a field.');

                RecRef.Open("Source Table ID");
                Found := false;

                for i := 1 to RecRef.FieldCount() do begin
                    FldRef := RecRef.FieldIndex(i);
                    if UpperCase(FldRef.Name) = UpperCase("Field Name") then begin
                        "Field Caption" := FldRef.Caption;
                        Found := true;
                        break;
                    end;
                end;

                RecRef.Close();

                if not Found then
                    Error('Field %1 does not exist in table %2.', "Field Name", "Source Table ID");

                UpdateDescription();
            end;
        }

        field(6; "Field Caption"; Text[100])
        {
            Caption = 'Field Caption';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(7; "Filter Operator"; Enum "SMS Filter Operator")
        {
            Caption = 'Filter Operator';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateDescription();
            end;
        }

        field(8; "Filter Value 1"; Text[250])
        {
            Caption = 'Filter Value 1';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateDescription();
            end;
        }

        field(9; "Filter Value 2"; Text[250])
        {
            Caption = 'Filter Value 2';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Filter Operator" <> "Filter Operator"::Range then
                    if "Filter Value 2" <> '' then
                        Error('Filter Value 2 is only used with Range operator.');

                UpdateDescription();
            end;
        }

        field(10; "Logical Operator"; Option)
        {
            Caption = 'Logical Operator';
            DataClassification = CustomerContent;
            OptionMembers = "AND","OR";
            OptionCaption = 'AND,OR';
            InitValue = "AND";

            trigger OnValidate()
            begin
                UpdateDescription();
            end;
        }

        field(11; Enabled; Boolean)
        {
            Caption = 'Enabled';
            DataClassification = CustomerContent;
            InitValue = true;

            trigger OnValidate()
            begin
                UpdateDescription();
            end;
        }

        field(12; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Campaign No.", "Line No.")
        {
            Clustered = true;
        }
        key(Source; "Filter Source", Enabled)
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
        // Validation will happen when Generate Recipients is clicked
        UpdateDescription();
    end;

    trigger OnModify()
    var
        Header: Record "Global Bulk SMS Header";
    begin
        Header.Reset();
        Header.SetRange("Campaign No.", "Campaign No.");
        if Header.FindFirst() then
            Header.CheckEditAllowed();
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

    procedure GetFilterExpression(): Text
    var
        FilterExpr: Text;
    begin
        if not Enabled then
            exit('');

        if ("Field Name" = '') or ("Filter Value 1" = '') then
            exit('');

        case "Filter Operator" of
            "Filter Operator"::Equal:
                FilterExpr := "Filter Value 1";
            "Filter Operator"::NotEqual:
                FilterExpr := '<>' + "Filter Value 1";
            "Filter Operator"::GreaterThan:
                FilterExpr := '>' + "Filter Value 1";
            "Filter Operator"::LessThan:
                FilterExpr := '<' + "Filter Value 1";
            "Filter Operator"::GreaterOrEqual:
                FilterExpr := '>=' + "Filter Value 1";
            "Filter Operator"::LessOrEqual:
                FilterExpr := '<=' + "Filter Value 1";
            "Filter Operator"::Range:
                begin
                    if "Filter Value 2" = '' then
                        Error('Filter Value 2 is required for Range operator on line %1.', "Line No.");
                    FilterExpr := "Filter Value 1" + '..' + "Filter Value 2";
                end;
            "Filter Operator"::Contains:
                FilterExpr := '@*' + "Filter Value 1" + '*';
            "Filter Operator"::StartsWith:
                FilterExpr := '@' + "Filter Value 1" + '*';
            "Filter Operator"::Blank:
                FilterExpr := '=''''';
            "Filter Operator"::NotBlank:
                FilterExpr := '<>''''';
        end;

        exit(FilterExpr);
    end;

    local procedure UpdateDescription()
    var
        Desc: Text;
        OperatorText: Text;
    begin
        if not Enabled then begin
            Description := '(DISABLED)';
            exit;
        end;

        if ("Field Caption" = '') or ("Filter Value 1" = '') then begin
            Description := '(INCOMPLETE)';
            exit;
        end;

        case "Filter Operator" of
            "Filter Operator"::Equal:
                OperatorText := '=';
            "Filter Operator"::NotEqual:
                OperatorText := '<>';
            "Filter Operator"::GreaterThan:
                OperatorText := '>';
            "Filter Operator"::LessThan:
                OperatorText := '<';
            "Filter Operator"::GreaterOrEqual:
                OperatorText := '>=';
            "Filter Operator"::LessOrEqual:
                OperatorText := '<=';
            "Filter Operator"::Range:
                OperatorText := 'BETWEEN';
            "Filter Operator"::Contains:
                OperatorText := 'CONTAINS';
            "Filter Operator"::StartsWith:
                OperatorText := 'STARTS WITH';
            "Filter Operator"::Blank:
                OperatorText := 'IS BLANK';
            "Filter Operator"::NotBlank:
                OperatorText := 'IS NOT BLANK';
        end;

        Desc := "Field Caption" + ' ' + OperatorText;

        if not ("Filter Operator" in ["Filter Operator"::Blank, "Filter Operator"::NotBlank]) then
            Desc := Desc + ' ' + "Filter Value 1";

        if "Filter Operator" = "Filter Operator"::Range then
            if "Filter Value 2" <> '' then
                Desc := Desc + ' AND ' + "Filter Value 2";

        Description := CopyStr(Desc, 1, MaxStrLen(Description));
    end;

    procedure ValidateFilterValue(TableID: Integer; FieldName: Text; FilterValue: Text): Boolean
    var
        RecRef: RecordRef;
        FldRef: FieldRef;
        i: Integer;
        Found: Boolean;
    begin
        if (TableID = 0) or (FieldName = '') or (FilterValue = '') then
            exit(false);

        RecRef.Open(TableID);
        Found := false;

        for i := 1 to RecRef.FieldCount() do begin
            FldRef := RecRef.FieldIndex(i);
            if UpperCase(FldRef.Name) = UpperCase(FieldName) then begin
                Found := true;
                FldRef.SetFilter(FilterValue);
                break;
            end;
        end;

        RecRef.Close();
        exit(Found);
    end;
}
