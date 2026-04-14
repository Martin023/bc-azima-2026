table 52187028 "Alerts Loan Lines"
{
    Caption = 'Alerts Loan Lines';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Alerts Loan Lines";

    fields
    {
        field(1; "Header No."; Code[50])
        {
            Editable = false;
        }
        field(2; "Loan No."; Code[50])
        {
            TableRelation = Loans."Loan No.";
            trigger OnValidate()
            var
                myInt: Integer;
                Customer: Record "Detailed Cust. Ledg. Entry";
            begin
                if Loans.Get("Loan No.") then begin
                    if Members.Get(Loans."Member No.") then begin
                        "Member No." := Members."No.";
                        Validate("Member No.");
                    end;
                    Loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Days In Arrears", "Installments FallOff", "Amount In Arreas SASRA");
                    "Interest Balance" := Loans."Outstanding Interest";
                    "Principle Balance" := Loans."Outstanding Balance";
                    "Outstanding Balance" := "Interest Balance" + "Principle Balance";
                    "Days In Arrears" := Loans."Days In Arrears";
                    "Installments FallOff" := Loans."Installments FallOff";
                    "Amount in Arrears" := Loans."Amount In Arreas SASRA";
                    "Process Case" := true;
                end;

                CalcFields("Loan Product Type", "Loan Product Type Name");

                if "System Generated" then Error('You cannot edit this value since thi entry is system generated');
            end;
        }
        field(3; "Interest Balance"; Decimal)
        {

        }
        field(4; "Principle Balance"; Decimal)
        {

        }
        field(5; "Outstanding Balance"; Decimal)
        {

        }
        field(6; "Days In Arrears"; Decimal)
        {

        }
        field(7; "Member No."; Code[30])
        {
            TableRelation = Members."No.";
            Editable = false;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                CalcFields("Member Name");
            end;
        }
        field(8; "Member Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Name where("No." = field("Member No.")));
            Editable = false;
        }
        field(9; "Installments FallOff"; Decimal)
        {

        }
        field(10; Period; date)
        {
            TableRelation = "Interest Due Period"."Interest Due Date";
        }
        field(11; "Period Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Interest Due Period".Name where("Interest Due Date" = field(Period)));
        }
        field(12; "System Generated"; Boolean)
        {
            Editable = false;
        }
        field(13; "Process Case"; Boolean)
        {

        }

        field(15; "Mark For Attachment"; Boolean)
        {

        }
        field(16; "Mark CRB Listing"; Boolean)
        {

        }
        field(17; "Create Attachment Header"; Boolean)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Rec."Create Attachment Header" then
                    if not Rec."Mark For Attachment" then Error('You can not create an attachment for a case that is not valid for attachment');
            end;
        }
        field(18; "Loan Product Type"; Code[50])
        {
            TableRelation = "Product Factory"."Product ID";
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Loans."Loan Product Type" where("Loan No." = field("Loan No.")));
        }
        field(19; "Loan Product Type Name"; Text[100])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Loans."Loan Product Type Name" where("Loan No." = field("Loan No.")));

        }
        field(20; Status; enum "Workflow Status Main Flags")
        {
            FieldClass = FlowField;
            CalcFormula = lookup("SMS Alerts Header".Status where("No." = field("Header No.")));
            Editable = false;
        }
        field(21; "Notice Type"; Option)
        {
            OptionMembers = " ","1st & 2nd Notice","Arrears Alert","CRB Notice","CRB Listing";

            FieldClass = FlowField;
            CalcFormula = lookup("SMS Alerts Header"."Notice Type" where("No." = field("Header No.")));
            Editable = false;
        }
        field(22; "Source Unit"; Enum "Source Unit")
        {
            // OptionCaption = ' ,FOSA,BOSA,BUSINESS LOANS,HR LOANS';
            // OptionMembers = "",FOSA,BOSA,"BUSINESS LOANS","HR LOANS";
            FieldClass = FlowField;
            CalcFormula = lookup(Loans."Source Unit" where("Loan No." = field("Loan No.")));

        }
        field(23; "Mobile Loan"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Loans."Mobile Loan" where("Loan No." = field("Loan No.")));

        }
        field(24; "Amount in Arrears"; Decimal)
        {

        }
    }
    keys
    {
        key(Key1; "Header No.", "Loan No.")
        {

        }
    }

    trigger OnDelete()
    var
        myInt: Integer;
    begin
        if "System Generated" then
            Error('You can not delete this entry because its system generated');
    end;



    trigger OnInsert()
    var
        myInt: Integer;
    begin
        "Process Case" := true;
    end;

    var
        Loans: Record Loans;
        Members: Record Members;

}
