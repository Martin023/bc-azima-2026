table 52185903 "User Document Cancellation"
{

    fields
    {
        field(1; "Document Area"; Option)
        {
            NotBlank = true;
            OptionMembers = " ",Purchase,Sale,Transfers;
        }
        field(2; "Document Type"; Option)
        {
            NotBlank = true;
            OptionMembers = " ","Order",Invoice,"Cash Sale","Credit Memo","Return Order","Transfer Order";
        }
    }

    keys
    {
        key(Key1; "Document Area", "Document Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

