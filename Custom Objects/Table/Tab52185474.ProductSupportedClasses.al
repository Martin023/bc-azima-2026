table 52185474 "Product Supported Classes"
{
    Caption = 'Product Supported Classes';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Product ID"; Code[20])
        {
            Caption = 'Product ID';
            TableRelation = "Product Factory"."Product ID";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Class Category"; /*Enum "Member Classes"*/ Code[10])
        {
            // Caption = 'Class Category';
            // trigger OnValidate()
            // var
            //     ExistingClass: Record "Product Supported Classes";
            // begin
            //     ExistingClass.SetRange("Product ID", Rec."Product ID");
            //     ExistingClass.SetRange("Class Category", Rec."Class Category");
            //     if not ExistingClass.IsEmpty() then
            //         Error('Class category %1 has already been added.', Rec."Class Category");
            // end;

            TableRelation = "Member Classes"."No.";
            trigger OnValidate()
            var
                myInt: Integer;
                ExistingClass: Record "Product Supported Classes";
            begin
                if "Class Category" = '' then begin
                    Error(FieldEmptyError);
                end;

                ExistingClass.SetRange("Product ID", Rec."Product ID");
                ExistingClass.SetRange("Class Category", Rec."Class Category");
                ExistingClass.SetFilter("Line No.", '<>%1', Rec."Line No.");
                if not ExistingClass.IsEmpty() then begin
                    Error('Class category %1 has already been added.', Rec."Class Category");
                end;
            end;
        }
        field(4; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(5; "Created On"; DateTime)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Modified On"; DateTime)
        {
            Caption = 'Modified On';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Product ID", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        Rec."Created By" := UserId;
        Rec."Created On" := CurrentDateTime();
        Rec."Modified By" := UserId;
        Rec."Modified On" := CurrentDateTime();
        CheckIfProductIsOpen();
    end;

    trigger OnModify()
    begin
        Rec."Modified By" := UserId;
        Rec."Modified On" := CurrentDateTime();
        CheckIfProductIsOpen();
    end;

    trigger OnDelete()
    begin
        CheckIfProductIsOpen();
    end;

    local procedure CheckIfProductIsOpen()
    var
        ProductFactory: Record "Product Factory";
    begin
        if ProductFactory.Get(Rec."Product ID") then begin
            if ProductFactory.Status <> ProductFactory.Status::Open then
                Error('Changes are not allowed because Product %1 status is %2 (Must be Open).', Rec."Product ID", ProductFactory.Status);
        end;
    end;

    var
        FieldEmptyError: Label 'This field can not be empty';
}