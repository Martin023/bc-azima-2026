table 52185904 "Document Cancellation Users"
{

    fields
    {
        field(1; "Document Area"; Option)
        {
            NotBlank = true;
            OptionMembers = ,Purchase,Sale,Transfers,"Funds Mgt";
        }
        field(2; "Document Type"; Option)
        {
            NotBlank = true;
            OptionMembers = ,"Order",Invoice,"Cash Sale","Credit Memo","Return Order","Transfer Order",Requisition;
        }
        field(3; UserID; Code[50])
        {
            Description = 'Stores the reference of the user in the database';
            NotBlank = true;

            trigger OnLookup()
            begin
                // LoginMgt.LookupUserID(UserID);
            end;

            trigger OnValidate()
            begin
                // LoginMgt.ValidateUserID(UserID);
            end;
        }
        field(4; Username; Text[30])
        {
            FieldClass = Normal;
        }
        field(5; "Notify/Can Cancel"; Option)
        {
            Description = 'Notify/Can Cancel';
            OptionMembers = Notify,"Can Cancel";
        }
    }

    keys
    {
        key(Key1; "Document Area", "Document Type", UserID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        User.Reset;
        User.SetRange(User."User Name", UserID);
        if User."Full Name" <> '' then
            Username := User."Full Name"
        else
            Username := User."User Name"
    end;

    var
        LoginMgt: Codeunit "User Management";
        User: Record User;
}

