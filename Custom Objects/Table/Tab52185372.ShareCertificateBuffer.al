table 52187369 "Share Certificate Buffer"
{
    Caption = 'Share Certificate Buffer';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"No.";Code[20])
        {
            Caption = 'No.';
        }
        field(7; "Member No."; Code[20])
        {
            Caption = 'Member No.';
        }
        field(2; "Member Name"; Text[50])
        {
            Caption = 'Member Name';
        }
        field(3; "No. of Shares"; Decimal)
        {
            Caption = 'No. of Shares ';
        }
        field(5; "Shares Recepient No"; Code[20])
        {
            Caption = 'Shares Recepient No';
            TableRelation = "Share Capital Transfer Lines"."Destination Member No";
            trigger OnValidate()
            begin 
                ShareCapTranferLines.Get();
                //ShareCapTranferLines.SetRange();
            end;
            
        }
        field(6; "Shares Recepient Name"; Text[20])
        {
            Caption = 'Shares Recepient Name';
        }
        field(4; "Transffered Shares"; Decimal)
        {
            Caption = 'Transffered Shares';
            
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    var
        ShareCapTranserBuffer: Record "Share Capital Transfer Buffer";
        ShareCapTranferLines: Record "Share Capital Transfer Lines";
}
