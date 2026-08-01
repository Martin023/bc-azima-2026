table 52185929 "HR SMS Template Variables"
{
    Caption = 'HR SMS Template Variables';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Event Code"; Code[50])
        {
            Caption = 'Event Code';
            NotBlank = true;
        }
        field(2; Token; Code[50])
        {
            Caption = 'Token';
            NotBlank = true;
            // EXACT STRING USED IN MESSAGE BODY E.G. [EMPLOYEE_NAME]
        }
        field(3; "Variable Name"; Text[100])
        {
            Caption = 'Variable Name';
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(5; "System Defined"; Boolean)
        {
            Caption = 'System Defined';
            Editable = false;
            // TRUE = SEEDED BY SYSTEM, CANNOT BE DELETED
        }
        field(6; "Sort Order"; Integer)
        {
            Caption = 'Sort Order';
        }
    }

    keys
    {
        key(Key1; "Event Code", Token)
        {
            Clustered = true;
        }
        key(Key2; "Event Code", "System Defined", "Sort Order")
        {
        }
    }

    trigger OnDelete()
    begin
        if "System Defined" then
            Error('CANNOT DELETE SYSTEM-DEFINED TOKEN [%1]. REQUIRED BY THE SMS DISPATCHER.', Token);
    end;
}
