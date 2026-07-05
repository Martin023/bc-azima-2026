table 52185564 "Mobile Loan Exceptions"
{
    Caption = 'Mobile Loan Exceptions';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            TableRelation = Members."No.";

            trigger OnValidate()
            var
                Members: Record Members;
            begin
                if "Member No." <> '' then begin
                    Members.Get("Member No.");
                    Members.CalcFields("Employer Name");

                    Rec."Member Name" := Members.Name;
                    Rec.Employer := Members."Employer Code";
                    Rec."Employer Name" := Members."Employer Name";
                end else begin
                    Rec."Member Name" := '';
                    Rec.Employer := '';
                    Rec."Employer Name" := '';
                end;
            end;
        }
        field(2; "Product ID"; Code[20])
        {
            Caption = 'Loan Product';
            TableRelation = "Product Factory"."Product ID" where("Mobile Loan" = const(true));

            trigger OnValidate()
            var
                ProductFactory: Record "Product Factory";
            begin
                if "Product ID" <> '' then
                    ProductFactory.Get("Product ID");
            end;
        }
        field(3; "Member Name"; Text[100])
        {
            Caption = 'Member Name';
            Editable = false;
        }
        field(4; Employer; Code[100])
        {
            Caption = 'Employer';
            Editable = false;
        }
        field(5; "Employer Name"; Text[100])
        {
            Caption = 'Employer Name';
            Editable = false;
        }
        field(6; "Product Name"; Text[100])
        {
            Caption = 'Loan Product Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Product Factory"."Product Description" where("Product ID" = field("Product ID")));
        }
        field(7; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Active,Inactive;
            OptionCaption = 'Active,Inactive';
            InitValue = Active;
        }
        // field(8; Remarks; Text[100])
        // {
        //     Caption = 'Remarks';
        // }
        field(9; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(10; "Created On"; DateTime)
        {
            Caption = 'Created On';
            Editable = false;
        }
        field(11; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            Editable = false;
        }
        field(12; "Modified On"; DateTime)
        {
            Caption = 'Modified On';
            Editable = false;
        }
        field(13; "Disabled On"; DateTime)
        {
            Caption = 'Disabled On';
            Editable = false;
        }
        field(14; "Disabled By"; Code[50])
        {
            Caption = 'Disabled By';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Member No.", "Product ID")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created On" := CurrentDateTime;
        "Modified By" := UserId;
        "Modified On" := CurrentDateTime;
    end;

    trigger OnModify()
    begin
        "Modified By" := UserId;
        "Modified On" := CurrentDateTime;

        if (Rec.Status <> Rec.Status::Active) and (xRec.Status = xRec.Status::Active) then begin
            "Disabled By" := UserId;
            "Disabled On" := CurrentDateTime;
        end;
    end;

    trigger OnDelete()
    begin
        Error('Deletion is not allowed. Set the Status to Inactive to disable this exception.');
    end;
}