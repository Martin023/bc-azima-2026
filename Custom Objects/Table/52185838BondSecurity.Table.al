table 52185838 "Bond Security"
{

    fields
    {
        field(1; "Bond No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Bond."Bond No.";
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; Type; Option)
        {
            NotBlank = true;
            OptionCaption = ' ,Cash Cover,Title Deed,Log Book,Bank Guarantee,Shares Certificate,Other';
            OptionMembers = " ","Cash Cover","Title Deed","Log Book","Bank Guarantee","Shares Certificate",Other;
        }
        field(4; "Security Details"; Text[150])
        {
        }
        field(5; Remarks; Text[250])
        {
        }
        field(7; Value; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                if Type = Type::"Cash Cover" then "Guarantee Value" := Value;
            end;
        }
        field(8; "Guarantee Value"; Decimal)
        {
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1; "Bond No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        // TestHeaderOpen;
    end;

    trigger OnInsert()
    begin
        // TestHeaderOpen;
    end;

    trigger OnModify()
    begin
        // TestHeaderOpen;
    end;

    trigger OnRename()
    begin
        // TestHeaderOpen;
    end;

    var
        Bond: Record Bond;

    [Scope('OnPrem')]
    procedure TestHeaderOpen()
    begin
        Bond.Get("Bond No.");
        Bond.TestField("Bond Status", Bond."Bond Status"::Open);
    end;
}

