table 52186811 "Exit Clearance"
{
    Caption = 'Exit Clearance';
    

    fields
    {

        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = "HR Employees"."No.";
        }
        field(2; "Misc. Article Code"; Code[10])
        {
            Caption = 'Misc. Article Code';
            NotBlank = true;
            TableRelation = "Misc. Article";

            trigger OnValidate()
            begin
                MiscArticle.Get("Misc. Article Code");
                Description := MiscArticle.Description;
            end;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(5; "From Date"; Date)
        {
            Caption = 'From Date';
        }
        field(6; "To Date"; Date)
        {
            Caption = 'To Date';
        }
        field(7; "In Use"; Boolean)
        {
            Caption = 'In Use';
        }
        field(8; Comment; Boolean)
        {
            CalcFormula = Exist("Human Resource Comment Line" where("Table Name" = const("Misc. Article Information"),
                                                                     "No." = field("Employee No."),
                                                                     "Alternative Address Code" = field("Misc. Article Code"),
                                                                     "Table Line No." = field("Line No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Serial No."; Text[50])
        {
            Caption = 'Serial No.';
        }
        field(10;"Exit Interview No";Code[20])
        {

        }
    }

    keys
    {
        key(Key1; "Employee No.", "Misc. Article Code", "Line No.","Exit Interview No")
        {
            Clustered = true;
        }
        key(Key2; "Line No.")
        {
        }
    }
    var
     MiscArticle: Record "Misc. Article";
}
