table 52186063 "Delegate Members"
{


    fields
    {
        field(1; "Code"; Code[50])
        {
            Description = 'Lookup to Delegate groups';
            Editable = false;
            TableRelation = "Delegate Region".Code;
        }
        field(2; "Delegate MNO."; Code[50])
        {
            Description = 'Lookup to Member table';
            TableRelation = Members."No.";

            trigger OnValidate()
            begin
                /*GeneralSetUp.GET();
                VALIDATE (Position);
                IF Members.GET("Delegate MNO.") THEN
                  BEGIN
                    IF (CALCDATE(GeneralSetUp."Min.Delegate Membership Period",Members."Registration Date"))>TODAY THEN
                      ERROR(ErrMemb,GeneralSetUp."Min.Delegate Membership Period");
                    "Delegate Name":=Members.Name;
                    END;
                    */

            end;
        }
        field(3; "Delegate Name"; Text[100])
        {
            Editable = false;
        }
        field(4; Position; Code[50])
        {
            Description = 'Position';
            TableRelation = "Salutation Tittles".Code WHERE(Type = CONST(Position));

        }
        field(5; "Job Tittle"; Code[50])
        {
            Description = 'Job Tittle';
            TableRelation = "Salutation Tittles".Code WHERE(Type = CONST(Tittle));
        }
        field(6; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending,Approved';
            OptionMembers = Open,Pending,Approved;
        }
        field(7; Retired; Boolean)
        {
            Editable = false;
        }
        field(8; "Retire Date"; Date)
        {
            Editable = false;
        }
        field(10; "Service Period"; Text[30])
        {
            Editable = false;
        }
        field(11; "Retired By"; Code[50])
        {
            Editable = false;
        }
        field(12; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(19; "Reason for retirement"; Option)
        {
            OptionCaption = ',Death,Transfer,Resignation,Election,Impeachment';
            OptionMembers = ,Death,Transfer,Resignation,Election,Impeachment;
        }
        field(20; "Electoral Zone"; Code[50])
        {
            Description = 'lookup Electrol Zones/Area Svr Center (52018626) (Type=FILTER(Electral Zone))';
            TableRelation = "Electrol Zones/Area Svr Center".Code WHERE(Type = FILTER("Electral Zone"));
        }
        field(21; "Electoral Zone Name"; Text[100])
        {
            Editable = false;
        }
        field(22; "Appointment Date"; Date)
        {
        }
        field(23; "Expiry Date"; Date)
        {
        }
        field(24; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(25; "Global Dimension 1 Name"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Global Dimension 1 Code Name';
            Editable = false;
        }
        field(38; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(39; "Global Dimension 2 Name"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Global Dimension 2 Code Name';
            Editable = false;
        }
        field(26; "ID No."; Code[20])
        {
        }
        field(27; Type; Option)
        {
            OptionCaption = 'Normal,ADM';
            OptionMembers = Normal,ADM;
        }
        field(28; "Delegate Code"; Code[20])
        {
        }
        // field(29; "Region Names"; Decimal)
        // {
        //     CalcFormula = Count ("Delegate Region" WHERE (Code = FIELD (Code)));
        //     FieldClass = FlowField;
        // }
        field(30; "Attended AGM"; Boolean)
        {
            Editable = false;
        }
        field(31; "Attendee No"; Code[20])
        {
            Editable = false;
        }
        field(32; "Attendee Name"; Text[50])
        {
            Editable = false;
        }
        field(33; Paid; Boolean)
        {
            Editable = false;
        }
        field(34; "Registered By"; Text[50])
        {
            Editable = false;
        }
        field(35; "Reinstatement Date"; Date)
        {
        }
        field(36; "Retirement Date"; Date)
        {
        }
        field(37; "Election Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Code", "Delegate MNO.", "Entry No", "Retire Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(Groups; "Delegate MNO.", "Delegate Name", Position)
        {
        }
    }

    var
        Members: Record Members;
        ErrPosition: Label 'You cannot have the same position of %1 within the same group';
        GeneralSetUp: Record "General Set-Up";
        ErrMemb: Label 'This member has not met minimum membership period of %1';
}

