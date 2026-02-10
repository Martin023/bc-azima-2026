table 52186222 "File Locations"
{
    Caption = 'File Locations';
    DataClassification = ToBeClassified;
    DrillDownPageId = "File Locations List";
    LookupPageId = "File Locations List";


    fields
    {
        field(1; Location; Text[100])
        {
            Caption = 'Location';
            TableRelation = "Segment/County/Dividend/Signat".Code WHERE(Type = CONST("File Location"));
            trigger OnValidate()
            begin
                FileLocation.Reset;
                FileLocation.SetRange(FileLocation.Code, Location);
                if FileLocation.Find('-') then
                    Location := FileLocation.Description;
            end;
        }
        field(2; Building; Text[100])
        {
            Caption = 'Building';
            TableRelation = "Fixed Asset" WHERE("FA Class Code" = FILTER('Building'));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FA.Reset;
                FA.SetRange(FA."No.", Building);
                if FA.Find('-') then
                    Building := FA.Description;
            end;
        }
        field(3; Town; Text[100])
        {
            Caption = 'Town';
        }
        field(4; Floor; Text[100])
        {
            Caption = 'Floor';
            TableRelation = Floor."Floor Code";
        }
        field(5; "Location Entry"; Integer)
        {
            Caption = 'Floor Location';
            AutoIncrement = True;
        }
    }
    keys
    {
        // key(PK; Location, Building)
        // {
        //     Clustered = true;
        // }
        key(PK; "Location Entry")
        {
            Clustered = true;
        }
    }
    var
        FileLocation: Record "Segment/County/Dividend/Signat";
        FA: Record "Fixed Asset";
}
