table 52186279 "Mobile Deposits Keywords Setup"
{
    Caption = 'Mobile Deposits Keywords Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Keyword; Code[50])
        {
            Caption = 'Keyword';
        }
        field(2; "Product Code"; Code[10])
        {
            Caption = 'Product Code';
            TableRelation = "Product Factory"."Product ID";
            trigger OnValidate()
            var
                PFac: Record "Product Factory";
            begin
                if PFac.Get("Product Code") then begin
                    "Product Description" := PFac."Product Description";
                    "Product Class Type" := PFac."Product Class Type";
                end;
            end;
        }
        field(3; "Product Description"; Text[100])
        {
            Caption = 'Product Description';
            Editable = false;
        }
        field(4; "Product Class Type"; Option)
        {
            Caption = 'Product Description';
            OptionCaption = ' ,Loan,Savings';
            OptionMembers = " ",Loan,Savings;
            Editable = false;
        }
        field(5; "Member Identifier Type"; enum "Identification Type")
        {
            Caption = 'Member Identifier Type';
        }
        field(6; "Member Identifier Position"; Option)
        {
            Caption = 'Member Identifier Position';
            OptionMembers = Suffix,Prefix;
            OptionCaption = 'Suffix (Ends with),Prefix (Starts with)';
        }
        field(7; "Created By"; Text[50])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(8; "Updated By"; Text[50])
        {
            Caption = 'Updated By';
            Editable = false;
        }
    }
    keys
    {
        key(PK; Keyword)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        myInt: Integer;
    begin
        TestField(Keyword);
        TestField("Product Code");
        TestField("Member Identifier Type");
        // TestField("Member Identifier Position");

        "Created By" := UserId;
        "Updated By" := UserId;
    end;

    trigger OnModify()
    var
        myInt: Integer;
    begin
        TestField(Keyword);
        TestField("Product Code");
        TestField("Member Identifier Type");
        // TestField("Member Identifier Position");

        "Created By" := UserId;
        "Updated By" := UserId;
    end;

}
