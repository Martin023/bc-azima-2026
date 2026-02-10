table 52185470 "Vehicle Types"
{
    Caption = 'Vehicle Types';
    DataClassification = ToBeClassified;
    LookupPageId = "Vehicle Types";
    DrillDownPageId = "Vehicle Types";

    fields
    {
        field(1; Type; Option)
        {
            OptionCaption = ' , Vehicle Make, Model, Type of Vehicle';
            OptionMembers = " ","Vehicle Make",Model,"Type of Vehicle";
        }
        field(2; "Code"; Code[30])
        {
        }
        field(3; Description; Text[50])
        {
        }
        field(4; "Market Ninch Details"; Text[80])
        {
        }
        field(5; County; Code[30])
        {
            TableRelation = "Segment/County/Dividend/Signat".Code WHERE(Type = CONST(County));
        }
    }

    keys
    {
        key(Key1; Type, "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description)
        {
        }
    }
}

