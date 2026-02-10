table 52186111 "Virtual Registrations"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "ID/Passport"; Text[30])
        {
        }
        field(4; "Full Names"; Text[100])
        {
        }
        field(5; "Mpesa Names"; Text[50])
        {
        }
        field(6; Gender; Option)
        {
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(8; "IPRS Date Of Birth"; Date)
        {
        }
        field(9; Msisdn; Text[30])
        {
        }
        field(10; Citizenship; Text[30])
        {
        }
        field(11; Comments; Text[200])
        {
        }
        field(12; "Mpesa Names Matched"; Boolean)
        {
        }
        field(13; "Application Date"; Date)
        {
        }
        field(14; IsVirtual; Boolean)
        {
            InitValue = true;

            trigger OnValidate()
            begin
                /*IF ("Date Of Birth Matched"=TRUE) AND ("Mpesa Names Matched"=TRUE) THEN
                  IsVirtual:=TRUE
                
                ELSE IsVirtual:=FALSE;*/

            end;
        }
        field(15; MyPicture; BLOB)
        {
            SubType = Bitmap;
        }
        field(16; Remarks; Text[200])
        {
        }
        field(17; "First Name"; Text[50])
        {
        }
        field(18; "Second Name"; Text[50])
        {
        }
        field(19; "Last Name"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "ID/Passport")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        Customer: Record Customer;
        GrowerData: Record "Savings Account Application";
    begin
    end;
}

