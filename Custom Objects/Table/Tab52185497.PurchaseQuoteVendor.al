table 52185497 "Purchase Quote Vendor"
{
    Caption = 'Purchase Quote Vendor';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Enum "Purchase Document Type")
        {
            Caption = 'Document Type';
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(3; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor."No.";
        }
        field(4; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
        }
        field(5; "Email Sent"; Boolean)
        {
            Caption = 'Email Sent';
        }
        field(6; "Date Sent"; Date)
        {
            Caption = 'Date Sent';
        }
    }

    keys
    {
        key(PK; "Document Type", "Document No.", "Vendor No.") { Clustered = true; }
    }

    trigger OnDelete()
    begin
        if "Email Sent" then
            Error('This vendor line cannot be deleted because the RFQ email has already been sent.');
    end;

}
