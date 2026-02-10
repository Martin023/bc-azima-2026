table 52186533 "M-Smart Loan Corrections"
{
    DataClassification = ToBeClassified;
    DrillDownPageID = "M-Smart Loan Corrections";
    LookupPageID = "M-Smart Loan Corrections";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Application No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Correction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","add_guarantor","guarantor_signature","add_document","reduce_amount","reduce_duration", "top_up_loan", "any_other_correction";
            OptionCaption = ',Add Guarantor,Guarantor Signature,Add Document,Reduce Loan Amount,Reduce Loan Installments,Top Up Loan,Any Other';

            trigger OnValidate()
            begin
                if "Correction Type" <> "Correction Type"::guarantor_signature then begin
                    "Guarantor Member No." := '';
                end;
            end;
        }
        field(4; "Guarantor Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loan Guarantors and Security"."Savings Account No./Member No."
            where(
                "Loan No" = field("Application No."),
                "Guarantor Type" = const(Guarantor)
                );
        }
        field(5; Remarks; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Is Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Created At"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Modified By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Modified At"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Application No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created At" := CurrentDateTime;

        Rec.TestField("Application No.");
        Rec.TestField("Correction Type");
        Rec.TestField(Remarks);

        if Rec."Correction Type" = Rec."Correction Type"::guarantor_signature then begin
            Rec.TestField("Guarantor Member No.");
        end;
    end;

    trigger OnModify()
    begin
        "Modified By" := UserId;
        "Modified At" := CurrentDateTime;
        Rec.TestField("Application No.");
        Rec.TestField("Correction Type");
        Rec.TestField(Remarks);

        if Rec."Correction Type" = Rec."Correction Type"::guarantor_signature then begin
            Rec.TestField("Guarantor Member No.");
        end;
    end;

    trigger OnDelete()
    var
        myInt: Integer;
    begin
        if Rec."Is Sent" then begin
            Error('Deletion of a correction already sent to Mwalimu Smart is NOT allowed!');
        end;
    end;
}