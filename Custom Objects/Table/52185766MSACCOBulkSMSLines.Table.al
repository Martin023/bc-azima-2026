table 52185766 "Bulk SMS Lines"
{
    DrillDownPageId = "Bulk SMS Lines Part";

    fields
    {
        field(1; No; Code[20])
        {
            NotBlank = true;
            TableRelation = "Bulk SMS Header".No;
        }
        field(2; "Code"; Code[20])
        {
            NotBlank = true;
            Caption = 'Phone No';
            trigger OnValidate()
            begin
                "Code" := DELCHR("Code", '=', 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz');
            end;
        }
        field(3; Description; Text[200])
        {
        }
        field(4; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(5; Sent; Boolean)
        {
            Caption = 'Sent';
            Editable = false;
        }
        field(6; "Member No"; Code[20])
        {
            Caption = 'Member No';
            TableRelation = Members."No." where(Status = filter(<> Deceased));

            trigger OnValidate()
            begin
                Members.Reset();
                if Members.get(rec."Member No") then begin
                    rec.Code := Members."Phone No.";
                    //rec.Code := Members."Mobile Phone No";
                    rec.Description := Members."Name";
                end else
                    Message('The Member %1 ,Does not have a valid phone no. Ensure to capture a valid Phone no. before sending the SMS', "Member No")
            end;
        }
        field(7; "Text Message"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Deduction Status"; Option)
        {
            OptionMembers = Successfull,"Partial Deduction",Failed;

        }
        Field(9; "Sto Number"; code[50])
        {

        }
    }

    keys
    {
        key(Key1; No, "Code", Description, "Member No", "Sto Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    var
        Members: record Members;
        SendSms: Codeunit SendSms;
}
