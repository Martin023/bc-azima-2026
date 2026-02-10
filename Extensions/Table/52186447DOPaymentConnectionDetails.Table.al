#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 52186447 "DO Payment Connection Details"
{
    Caption = 'DO Payment Connection Details';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; UserName; Blob)
        {
            Caption = 'UserName';
        }
        field(3; Password; Blob)
        {
            Caption = 'Password';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
    //DOEncryptionMgt: Codeunit 824;


    procedure SetPasswordData(Value: Text[1024])
    var
        DataStream: OutStream;
        DataText: BigText;
    begin
        Clear(Password);
        //DataText.AddText(DOEncryptionMgt.Encrypt(Value));
        Password.CreateOutstream(DataStream);
        DataText.Write(DataStream);
    end;


    procedure GetPasswordData() Value: Text[1024]
    var
        DataStream: InStream;
        DataText: BigText;
    begin
        Value := '';
        CalcFields(Password);
        if Password.Hasvalue then begin
            Password.CreateInstream(DataStream);
            DataText.Read(DataStream);
            DataText.GetSubText(Value, 1);
        end;
        //exit(DOEncryptionMgt.Decrypt(Value));
    end;
}
