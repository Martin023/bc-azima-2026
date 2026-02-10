table 52185726 "Application Documents"
{
    LookupPageID = "Application Documents";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Document Type"; Option)
        {
            OptionCaption = ' ,Savings,Loans';
            OptionMembers = " ",Savings,Loans;
        }
        field(3; "Document No."; Code[10])
        {
            TableRelation = "Application Document Setup";

            trigger OnValidate()
            var
                ApplicationDocumentSetup: Record "Application Document Setup";
            begin
                if ApplicationDocumentSetup.Get("Document No.") then begin
                    "Document Type" := ApplicationDocumentSetup."Document Type";
                    Description := ApplicationDocumentSetup.Description;
                    "Single Party/Multiple" := ApplicationDocumentSetup."Single Party/Multiple";
                end;
            end;
        }
        field(4; Description; Text[250])
        {
            Editable = false;
        }
        field(5; "Single Party/Multiple"; Option)
        {
            OptionCaption = 'Single,Multiple,Business';
            OptionMembers = Single,Multiple,Business;
        }
        field(6; "Reference No."; Code[20])
        {
        }
        field(7; "Product ID"; Code[20])
        {
            Editable = false;
            TableRelation = "Product Factory";
        }
        field(8; "Product Name"; Text[100])
        {
            Editable = false;
        }
        field(12; Provided; Option)
        {
            OptionCaption = ' ,No,Yes';
            OptionMembers = " ",No,Yes;

            trigger OnValidate()
            begin
                "Last Date Modified" := Today;
                "Last Modified By" := UserId;
            end;
        }
        field(13; "Last Modified By"; Code[50])
        {
            Editable = false;
        }
        field(14; "Last Date Modified"; Date)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Reference No.", "Product ID", "Document No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

