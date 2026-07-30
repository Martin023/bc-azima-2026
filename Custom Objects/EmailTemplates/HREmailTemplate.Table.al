table 52185897 "HR Email Template"
{
    Caption = 'HR Email Template';
    DataClassification = CustomerContent;
    DrillDownPageId = "HR Email Template List";
    LookupPageId = "HR Email Template List";

    fields
    {
        field(1; "Event Code"; Code[50])
        {
            Caption = 'Event Code';
            NotBlank = true;
        }
        field(2; "Recipient Role"; Option)
        {
            Caption = 'Recipient Role';
            OptionCaption = 'Applicant,Reliever,Supervisor,HOD,CEO,Custom';
            OptionMembers = Applicant,Reliever,Supervisor,HOD,CEO,Custom;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(4; Subject; Text[250])
        {
            Caption = 'Subject';
        }
        field(5; Body; Blob)
        {
            Caption = 'Body';
        }
        field(6; Enabled; Boolean)
        {
            Caption = 'Enabled';
            InitValue = true;
        }
        field(7; "CC Email"; Text[100])
        {
            Caption = 'CC Email';
        }
        field(8; "Created By"; Code[100])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(9; "Created Date"; Date)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(10; "Modified By"; Code[100])
        {
            Caption = 'Modified By';
            Editable = false;
        }
        field(11; "Modified Date"; Date)
        {
            Caption = 'Modified Date';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Event Code", "Recipient Role")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created Date" := Today;
    end;

    trigger OnModify()
    begin
        "Modified By" := UserId;
        "Modified Date" := Today;
    end;

    procedure GetBody(): Text
    var
        BodyInStream: InStream;
        BodyText: Text;
    begin
        CalcFields(Body);
        if not Body.HasValue then
            exit('');
        Body.CreateInStream(BodyInStream, TextEncoding::UTF8);
        BodyInStream.ReadText(BodyText);
        exit(BodyText);
    end;

    procedure SetBody(BodyText: Text)
    var
        BodyOutStream: OutStream;
    begin
        Body.CreateOutStream(BodyOutStream, TextEncoding::UTF8);
        BodyOutStream.WriteText(BodyText);
    end;
}
