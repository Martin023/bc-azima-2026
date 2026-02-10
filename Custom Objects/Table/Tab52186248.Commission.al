table 52186248 Commission
{
    Caption = 'Commission';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; MemberID; Code[20])
        {
            Caption = 'MemberID';
            TableRelation = Members."No." where(status=filter(active));
            DataClassification = ToBeClassified;
        }
        field(3; "Count"; Integer)
        {
            Caption = 'Count';
            DataClassification = ToBeClassified;
        }
        field(4; CommissionAmount; Decimal)
        {
            Caption = 'CommissionAmount';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
}
