#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186410 tableextension52186410 extends "Company Information"
{
    fields
    {
        field(50000; "Company TIN"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Company Watermark2"; Blob)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50002; "PIN No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; Mission; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Receipt Statement"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Use Sales Agents"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Accrue Registration Fee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Sacco Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "ED Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "CEO"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Bank 1"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Bank Branch"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Bank A/C No."; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Bank 2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Bank Branch 2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Bank A/C No. 2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Business Loans Officer"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Director"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "ISO Certification"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Website"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Mwalimu Seal"; BLOB)
        {
            Caption = 'Mwalimu Seal';
            SubType = Bitmap;

            trigger OnValidate()
            begin
                PictureUpdated := true;
            end;
        }
        field(50021; "Mwalimu Seal - 2"; BLOB)
        {
            Caption = 'Mwalimu Seal - 2';
            SubType = Bitmap;

            trigger OnValidate()
            begin
                PictureUpdated := true;
            end;
        }
        field(50022; "Legal Officer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Legal Officer Title"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "KRA PIN"; CODE[11])
        {
        }
        field(50025; "NHIF"; code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "NSSF"; code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "HELB"; code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Legal Officer Signature"; BLOB)
        {
            SubType = Bitmap;

            trigger OnValidate()
            begin
                PictureUpdated := true;
            end;
        }
        field(50029; "CEO Signature"; BLOB)
        {
            SubType = Bitmap;
            trigger OnValidate()
            begin
                PictureUpdated := true;
            end;
        }
        field(50030; "Director Signature"; BLOB)
        {
            SubType = Bitmap;
            trigger OnValidate()
            begin
                PictureUpdated := true;
            end;
        }
        field(50031; "Chairman"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50032; "Chairman Signature"; BLOB)
        {
            SubType = Bitmap;
            trigger OnValidate()
            begin
                PictureUpdated := true;
            end;
        }
        field(50033; Secretary; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "Secretary Signature"; BLOB)
        {
            SubType = Bitmap;
            trigger OnValidate()
            begin
                PictureUpdated := true;
            end;
        }
        field(50035; Treasurer; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "Treasurer Signature"; BLOB)
        {
            SubType = Bitmap;
            trigger OnValidate()
            begin
                PictureUpdated := true;
            end;
        }
        field(50037; "Building Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Legal Manager Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50039; "Legal Manager Title"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50040; "Legal Manager Signature"; BLOB)
        {
            SubType = Bitmap;
            trigger OnValidate()
            begin
                PictureUpdated := true;
            end;
        }
        field(50041; "Members Portal Link"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50042; "Customer Management Portal Url"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }
    var
        PictureUpdated: Boolean;
}
