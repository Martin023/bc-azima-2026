table 52186266 "Asset Movement Schedule Table"
{
    Caption = 'Asset Movement Schedule Table';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            AutoIncrement = true;
        }
        field(2; "Fixed Asset No."; Code[50])
        {
            Caption = 'Fixed Asset No.';
            TableRelation = "Fixed Asset"."No.";
            
        }
        field(3; "Acquisition Cost Balance BF"; Decimal)
        {
            Caption = 'Balance BF';
            FIELDCLASS = FlowField;
            CalcFormula = SUM("FA Ledger Entry".Amount where("FA Posting Type" = const("Acquisition Cost"), 
            "FA Posting Category" = const(" "), 
            "FA Posting Date" = field("Start Date")));
        }
        field(4; "Depreciation Bal BF"; Decimal) 
        {

        }
        field(5; "Asset Additions";  Decimal)
        {

        }
        field(6; "Acquisition Disposed Assets"; Decimal)
        {

        }
        field(7; "Depreciation Within The Period"; Decimal)
        {
            
        }
        field(8; "Depreciation Disposed Assets"; Decimal)
        {

        }
        field(9; "Start Date Filter"; Text[50])
        {

        }
        field(10; "End Date Filter"; Text[50])
        {

        }
        field(11; "Period Between Filter"; Text[50])
        {

        }
        field(12; "Start Date"; Date)
        {

        }
        field(13; "End Date"; Date)
        {

        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
