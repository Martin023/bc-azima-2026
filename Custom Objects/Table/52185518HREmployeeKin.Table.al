table 52185518 "HR Employee Kin"
{
    Caption = 'Employee Relative';

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Employees"."No.";
        }
        field(2; Relationship; Code[20])
        {
            NotBlank = true;
            TableRelation = "Relationship Types";
        }
        // field(3; SurName; Text[50])
        // {
        //     NotBlank = true;
        // }
        field(4; "Other Names"; Text[100])
        {
            NotBlank = true;
        }
      
        field(5; "ID No/Passport No"; Text[50])
        {
        }
        field(6; "Date Of Birth"; Date)
        {

        }
        field(7; Occupation; Text[100])
        {
        }
        field(8; Address; Text[250])
        {
        }
        field(9; "Office Tel No"; Text[100])
        {
        }
        field(10; "Home Tel No"; Text[50])
        {
        }
        field(12; Type; Option)
        {
            OptionMembers = "Next of Kin",Beneficiary;
        }
        field(13; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(14; Comment; Boolean)
        {
            CalcFormula = Exist("Human Resource Comment Line" WHERE("Table Name" = CONST("Employee Relative"),
                                                                     "No." = FIELD("Employee Code"),
                                                                     "Table Line No." = FIELD("Line No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50000; "E-mail"; Text[60])
        {
        }
       
        field(15;"Identification Type"; enum "Identification Type")
        {
            trigger OnValidate()
            var
                HREmployeeKinCheck: Record "HR Employee Kin";
                MyUniqueID: Text;
                IsUnique: Boolean;
            begin
                // GENERATE SYSTEM UID WHEN SELECTING SYSTEM UID TYPE
                if "Identification Type" = "Identification Type"::"System UID" then begin
                    // ONLY GENERATE IF ID NO/PASSPORT NO IS EMPTY (NEW RECORD OR SWITCHING TO SYSTEM UID)
                    if "ID No/Passport No" = '' then begin
                        IsUnique := false;
                        repeat
                            MyUniqueID := GenerateSystemUID(10);
                            HREmployeeKinCheck.Reset();
                            HREmployeeKinCheck.SetRange("ID No/Passport No", CopyStr(MyUniqueID, 1, MaxStrLen("ID No/Passport No")));
                            if HREmployeeKinCheck.IsEmpty() then
                                IsUnique := true;
                        until IsUnique;

                        "ID No/Passport No" := CopyStr(MyUniqueID, 1, MaxStrLen("ID No/Passport No"));
                    end;
                end else begin
                    // CLEAR ID NO/PASSPORT NO WHEN SWITCHING AWAY FROM SYSTEM UID
                    if xRec."Identification Type" = "Identification Type"::"System UID" then begin
                        "ID No/Passport No" := '';
                    end;
                end;
            end;
        }
         field(16; Identification; Code[30])
        {
            trigger OnValidate()
            begin
                // SKIP VALIDATION FOR SYSTEM UID (IT CONTAINS LETTERS AND NUMBERS)
                if "Identification Type" <> "Identification Type"::"System UID" then begin
                    Identification := DelChr(Identification, '=', 'A|B|C|D|E|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|.|,|!|@|#|$|%|^|&|*|(|)|[|]|{|}|/|\|"|;|:|<|>|?|+|-|_');
                end;
            end;
        }
                  field(39003953; "Medical Insurance No."; Code[20])
        {
            trigger OnValidate()
            begin
               
            end;
        }
    }

    keys
    {
        key(Key1; "Employee Code", Type, Relationship,"Other Names", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        HRCommentLine: Record "Human Resource Comment Line";
    begin
        HRCommentLine.SetRange("Table Name", HRCommentLine."Table Name"::"Employee Relative");
        HRCommentLine.SetRange("No.", "Employee Code");
        HRCommentLine.DeleteAll;
    end;

    local procedure GenerateSystemUID(Length: Integer): Text
    var
        AllowedChars: Text;
        ResultUID: Text;
        i: Integer;
    begin
        AllowedChars := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        for i := 1 to Length do
            ResultUID += CopyStr(AllowedChars, Random(StrLen(AllowedChars)), 1);

        exit(ResultUID);
    end;
}

