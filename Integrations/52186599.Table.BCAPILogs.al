table 52186599 "BC API Logs"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; ID; BigInteger)
        {
            AutoIncrement = true;
        }
        field(2; "Vendor Name"; Text[50])
        {

        }
        field(3; "Request URL"; Text[250])
        {

        }
        field(4; "Request Headers"; Text[2048])
        {

        }
        field(5; "Request Data"; Text[2048])
        {

        }
        field(6; "Response Status Code"; Text[100])
        {

        }
        field(7; "Response Headers"; Text[2048])
        {

        }
        field(8; "Response Data"; Text[2048])
        {

        }
        field(9; "Miscellaneous"; Text[2048])
        {

        }

        field(1000; "Large Text"; Blob)
        {
            Caption = 'Large Text';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
    }

}