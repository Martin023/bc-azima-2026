table 52185665 "HR SMS CC Recipient Buffer"
{
    Caption = 'HR SMS CC Recipient Buffer';
    TableType = Temporary;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            AutoIncrement = true;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "HR Employees"."No." WHERE(Status = CONST(Active));

            trigger OnValidate()
            var
                HREmp: Record "HR Employees";
            begin
                if "Employee No." = '' then begin
                    Name := '';
                    "Phone No." := '';
                    "User ID" := '';
                    exit;
                end;

                if HREmp.Get("Employee No.") then begin
                    // AUTO-POPULATE NAME FROM HR EMPLOYEES
                    Name := HREmp."First Name";
                    if HREmp."Middle Name" <> '' then
                        Name := Name + ' ' + HREmp."Middle Name";
                    if HREmp."Last Name" <> '' then
                        Name := Name + ' ' + HREmp."Last Name";
                    Name := DelChr(Name, '<>', ' '); // TRIM SPACES

                    // AUTO-POPULATE PHONE - PRIORITY: Cell > Cellular > Work > Home
                    "Phone No." := HREmp."Cell Phone Number";
                    if "Phone No." = '' then
                        "Phone No." := HREmp."Cellular Phone Number";
                    if "Phone No." = '' then
                        "Phone No." := HREmp."Work Phone Number";
                    if "Phone No." = '' then
                        "Phone No." := HREmp."Home Phone Number";

                    // AUTO-POPULATE USER ID
                    "User ID" := HREmp."User ID";
                end;
            end;
        }
        field(3; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            var
                HREmp: Record "HR Employees";
            begin
                if "User ID" = '' then begin
                    if "Employee No." = '' then begin
                        Name := '';
                        "Phone No." := '';
                    end;
                    exit;
                end;

                // FIND EMPLOYEE BY USER ID
                HREmp.Reset();
                HREmp.SetRange("User ID", "User ID");
                if HREmp.FindFirst() then begin
                    "Employee No." := HREmp."No.";

                    // AUTO-POPULATE NAME
                    Name := HREmp."First Name";
                    if HREmp."Middle Name" <> '' then
                        Name := Name + ' ' + HREmp."Middle Name";
                    if HREmp."Last Name" <> '' then
                        Name := Name + ' ' + HREmp."Last Name";
                    Name := DelChr(Name, '<>', ' ');

                    // AUTO-POPULATE PHONE
                    "Phone No." := HREmp."Cell Phone Number";
                    if "Phone No." = '' then
                        "Phone No." := HREmp."Cellular Phone Number";
                    if "Phone No." = '' then
                        "Phone No." := HREmp."Work Phone Number";
                    if "Phone No." = '' then
                        "Phone No." := HREmp."Home Phone Number";
                end;
            end;
        }
        field(4; Name; Text[100])
        {
            Caption = 'Recipient Name';
            ToolTip = 'Name used in the SMS message. Editable - you can customize it (e.g., "Jane", "HR Manager", "CEO").';
        }
        field(5; "Phone No."; Text[20])
        {
            Caption = 'Phone Number';
            ToolTip = 'Phone number for this recipient. Editable - you can override the employee phone number.';
        }
        field(6; Salutation; Text[50])
        {
            Caption = 'Salutation';
            InitValue = 'Dear';
            ToolTip = 'Salutation prefix (e.g., "Dear", "Mr.", "Ms.", "Dr."). Used with [CC_RECIPIENT_SALUTATION] token.';
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
    }

    procedure LoadFromJSON(JSONText: Text)
    var
        JSONArray: JsonArray;
        JSONToken: JsonToken;
        JSONObject: JsonObject;
        LineNo: Integer;
    begin
        // CLEAR EXISTING BUFFER
        Rec.Reset();
        Rec.DeleteAll();

        if JSONText = '' then
            exit;

        // PARSE JSON ARRAY
        if not JSONArray.ReadFrom(JSONText) then
            exit;

        LineNo := 10000;
        foreach JSONToken in JSONArray do begin
            if JSONToken.IsObject() then begin
                JSONObject := JSONToken.AsObject();

                Rec.Init();
                Rec."Line No." := LineNo;
                Rec."Employee No." := GetJSONValue(JSONObject, 'EmployeeNo');
                Rec."User ID" := GetJSONValue(JSONObject, 'UserID');
                Rec.Name := GetJSONValue(JSONObject, 'Name');
                Rec."Phone No." := GetJSONValue(JSONObject, 'Phone');
                Rec.Salutation := GetJSONValue(JSONObject, 'Salutation');
                if Rec.Salutation = '' then
                    Rec.Salutation := 'Dear';
                Rec.Insert();

                LineNo += 10000;
            end;
        end;
    end;

    procedure SaveToJSON(): Text
    var
        JSONArray: JsonArray;
        JSONObject: JsonObject;
        JSONText: Text;
    begin
        Rec.Reset();
        if not Rec.FindSet() then
            exit('');

        repeat
            Clear(JSONObject);
            JSONObject.Add('EmployeeNo', Rec."Employee No.");
            JSONObject.Add('UserID', Rec."User ID");
            JSONObject.Add('Name', Rec.Name);
            JSONObject.Add('Phone', Rec."Phone No.");
            JSONObject.Add('Salutation', Rec.Salutation);
            JSONArray.Add(JSONObject);
        until Rec.Next() = 0;

        JSONArray.WriteTo(JSONText);
        exit(JSONText);
    end;

    local procedure GetJSONValue(JSONObject: JsonObject; KeyName: Text): Text
    var
        JSONToken: JsonToken;
    begin
        if JSONObject.Get(KeyName, JSONToken) then
            exit(JSONToken.AsValue().AsText());
        exit('');
    end;
}
