table 52185992 "Temp Budget Alloc G/L"
{

    fields
    {
        field(1; Name; Code[20])
        {
            Caption = 'Name';
            Editable = false;
            NotBlank = true;
            TableRelation = "G/L Budget Name".Name;
        }
        field(2; Description; Text[80])
        {
            CalcFormula = Lookup("G/L Budget Name".Description WHERE(Name = FIELD(Name)));
            Caption = 'Description';
            FieldClass = FlowField;
        }
        field(3; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(4; "Budget Dimension 1 Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(1);
            Caption = 'Budget Dimension 1 Code';
            TableRelation = "Dimension Value".Code;
        }
        field(5; "Budget Dimension 2 Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(2);
            Caption = 'Budget Dimension 2 Code';
            TableRelation = "Dimension Value".Code;
        }
        field(6; "Budget Dimension 3 Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(3);
            Caption = 'Budget Dimension 3 Code';
            TableRelation = "Dimension Value".Code;
        }
        field(7; "Budget Dimension 4 Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(4);
            Caption = 'Budget Dimension 4 Code';
            TableRelation = "Dimension Value".Code;
        }
        field(8; "Budget Dimension 5 Code"; Code[20])
        {
            Caption = 'Budget Dimension 5 Code';
            TableRelation = "Dimension Value".Code;
        }
        field(9; "Budget Dimension 6 Code"; Code[20])
        {
            Caption = 'Budget Dimension 6 Code';
            TableRelation = "Dimension Value".Code;
        }
        field(10; "Start Date"; Date)
        {
        }
        field(11; "Period Type"; Option)
        {
            OptionMembers = Daily,Weekly,Monthly,Quarterly,Annually;
        }
        field(12; "End Date"; Date)
        {
        }
        field(13; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(14; Amount; Decimal)
        {
        }
        field(15; Overwrite; Boolean)
        {
        }
        field(16; "Business Unit"; Code[20])
        {
            TableRelation = "Business Unit".Code;
        }
        field(17; "User ID"; Code[20])
        {
        }
        field(18; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(19; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                /*
                IF "Global Dimension 1 Code" = '' THEN
                  EXIT;
                //GetGLSetup;
                ValidateDimValue(GLSetup."Global Dimension 1 Code","Global Dimension 1 Code");
                */

            end;
        }
        field(20; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                /*
                IF "Global Dimension 2 Code" = '' THEN
                  EXIT;
                //GetGLSetup;
                ValidateDimValue(GLSetup."Global Dimension 2 Code","Global Dimension 2 Code");
                */

            end;
        }
        field(21; Processed; Boolean)
        {
        }
        field(22; "Analysis Area"; Option)
        {
            OptionMembers = Sales,Purchases;
        }
        field(23; "Type of Entry"; Option)
        {
            NotBlank = true;
            OptionMembers = " ",Debit,Credit;
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        GLBudgetName: Record "G/L Budget Name";
        Text000: Label 'The dimension value %1 has not been set up for dimension %2.';
        Text001: Label '1,5,,Budget Dimension 1 Code';
        Text002: Label '1,5,,Budget Dimension 2 Code';
        Text003: Label '1,5,,Budget Dimension 3 Code';

    [Scope('OnPrem')]
    procedure GetCaptionClass(BudgetDimType: Integer): Text[250]
    begin
        if GLBudgetName.Get(Name) then begin
            case BudgetDimType of
                1:
                    begin
                        if GLBudgetName."Budget Dimension 1 Code" <> '' then
                            exit('1,5,' + GLBudgetName."Budget Dimension 1 Code");
                        exit(Text001);
                    end;
                2:
                    begin
                        if GLBudgetName."Budget Dimension 2 Code" <> '' then
                            exit('1,5,' + GLBudgetName."Budget Dimension 2 Code");
                        exit(Text002);
                    end;
                3:
                    begin
                        if GLBudgetName."Budget Dimension 3 Code" <> '' then
                            exit('1,5,' + GLBudgetName."Budget Dimension 3 Code");
                        exit(Text003);
                    end;
                4:
                    begin
                        if GLBudgetName."Budget Dimension 4 Code" <> '' then
                            exit('1,5,' + GLBudgetName."Budget Dimension 4 Code");
                        exit(Text003);
                    end;

            end;
        end;
    end;
}

