table 52185695 "Savings Account Registration"
{
    LookupPageID = "Savings Account Registration";
    DrillDownPageID = "Savings Account Registration";

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Product Type"; Code[10])
        {
            Description = 'LookUp to Product Factory';
            TableRelation = "Product Factory" WHERE("Product Class Type" = CONST(Savings),
                                                     Status = CONST(Active),
                                                     "Product Category" = FILTER(<> "Fixed Deposit"));

            trigger OnValidate()
            begin
                if ProductFactory.Get("Product Type") then begin
                    "Product Name" := ProductFactory."Product Description";
                    // "Monthly Contribution":=ProductFactory."Minimum Contribution";
                    "Product Category" := ProductFactory."Product Category";
                    "Default Account" := ProductFactory."Loan Disbursement Account";
                    ProductDocuments.Reset;
                    ProductDocuments.SetRange("Product ID", "Product Type");
                    if ProductDocuments.Find('-') then begin
                        repeat
                            ApplicationDocuments.Reset;
                            if ApplicationDocuments.Find('-') then
                                EntryNo := ApplicationDocuments."Entry No." + 1
                            else
                                EntryNo := 1;

                            ApplicationDocuments.Reset;
                            ApplicationDocuments.SetRange("Document No.", ProductDocuments."Document No.");
                            ApplicationDocuments.SetRange("Reference No.", "No.");
                            if not ApplicationDocuments.Find('-') then begin

                                ApplicationDocuments.Init;
                                ApplicationDocuments."Entry No." := EntryNo;
                                ApplicationDocuments."Product ID" := ProductDocuments."Product ID";
                                ApplicationDocuments.Description := ProductDocuments.Description;
                                ApplicationDocuments."Reference No." := "No.";
                                ApplicationDocuments."Document No." := ProductDocuments."Document No.";
                                ApplicationDocuments."Product Name" := ProductFactory."Product Description";
                                ApplicationDocuments.Insert;
                            end;
                        until ProductDocuments.Next = 0;
                    end;
                end;
            end;
        }
        field(3; "Product Name"; Text[100])
        {
        }
        field(4; "Monthly Contribution"; Decimal)
        {

            trigger OnValidate()
            begin
                ProductFactory.Get("Product Type");
                if "Monthly Contribution" < ProductFactory."Minimum Contribution" then
                    Error('The minimum contribution should not be less than %1', ProductFactory."Minimum Contribution");
            end;
        }
        field(5; "Product Category"; Enum "Product Categories")
        {

        }
        field(6; "Default Account"; Boolean)
        {

        }
    }

    keys
    {
        key(Key1; "No.", "Product Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ProductFactory: Record "Product Factory";
        ProductDocuments: Record "Product Documents";
        ApplicationDocuments: Record "Application Documents";
        EntryNo: Integer;
}

