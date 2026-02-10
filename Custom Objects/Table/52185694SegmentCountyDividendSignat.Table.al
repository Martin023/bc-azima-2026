table 52185694 "Segment/County/Dividend/Signat"
{
    LookupPageID = 52185723;
    DrillDownPageId = 52185723;

    fields
    {
        field(1; Type; Option)
        {
            OptionCaption = ' ,Segment,County,Dividend Payment Type,Signatory Type,Sub-County,Province,Matter Code,Type of Court, Vehicle Make, Model, Type of Vehicle,Type of ADR,Charge Type, Contract Expectation, Insurance Covers, File Location';
            OptionMembers = " ",Segment,County,"Dividend Payment Type","Signatory Type","Sub-County",Province,"Matter Code","Type of Court", "Vehicle Make", Model, "Type of Vehicle", "Type of ADR", "Charge Type", "Contract Expectation", "Insurance Covers", "File Location";
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

