table 52185526 "HR Individual Target Line"
{

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Appraisal No"; Code[50])
        {
            TableRelation = "HR Individual Targets Header"."Appraisal No";
        }
        field(3; "Perspective Code"; Integer)
        {
            TableRelation = "HR Perspectives Setup"."Perspective No";

            trigger OnValidate()
            begin
                CalcFields("Perspective Description");
            end;
        }
        field(4; "Perspective Description"; Text[250])
        {
            CalcFormula = Lookup("HR Perspectives Setup".Description WHERE("Perspective No" = FIELD("Perspective Code")));
            FieldClass = FlowField;
        }
        field(5; "Targeted Score"; Decimal)
        {

            trigger OnValidate()
            begin
                "Unachieved Targets" := "Targeted Score" - "Achieved Score";
                Change := "Targeted Score" - Baseline;
            end;
        }
        field(7; "Achieved Score"; Decimal)
        {

            trigger OnValidate()
            begin
                "Unachieved Targets" := "Targeted Score" - "Achieved Score";
                if ("Targeted Score" <> 0) and ("Achieved Score" <> 0) then
                    Score := "Achieved Score" / "Targeted Score" * 100
            end;
        }
        field(8; "Unachieved Targets"; Decimal)
        {
        }
        field(9; "Appraisee Comments"; Text[250])
        {
        }
        field(10; Objective; Text[250])
        {
        }
        field(11; "Company Target"; Code[50])
        {
            //FIELD CAN BE USED TO LINK INDIVIDUAL TARGETS TO EITHER COMPANY TARGETS (52185516) OR DEPARTMENT TARGETS (52185474)
        }
        field(12; "Start Date"; Date)
        {
        }
        field(13; "End Date"; Date)
        {
        }
        field(14; "Self Rating"; Decimal)
        {
            MaxValue = 5;
        }
        field(15; "Supervisor Rating"; Decimal)
        {
            MaxValue = 5;
        }
        field(16; "Agreed Rating"; Decimal)
        {
            MaxValue = 5;

            trigger OnValidate()
            begin
                //SCORES NOW CALCULATED DYNAMICALLY VIA PERSPECTIVES
            end;
        }
        field(17; "Appraisal Period"; Code[20])
        {
        }
        field(18; "Appraisal Cycle Stage"; Option)
        {
            CalcFormula = Lookup("HR Individual Targets Header"."Appraisal Cycle Stage" WHERE("Appraisal No" = FIELD("Appraisal No")));
            FieldClass = FlowField;
            OptionCaption = 'Target Setting,Evaluation Review,Year-End Review';
            OptionMembers = "Target Setting","Evaluation Review","Year-End Review";
        }
        field(19; Status; Option)
        {
            CalcFormula = Lookup("HR Individual Targets Header".Status WHERE("Appraisal No" = FIELD("Appraisal No")));
            FieldClass = FlowField;
            OptionCaption = 'Open,Pending Approval,Discussed,Approved,Posted';
            OptionMembers = Open,"Pending Approval",Discussed,Approved,Posted;
        }
        field(20; "Appraiser Comments"; Text[250])
        {
        }
        field(21; "Review Line Reference"; Text[30])
        {
        }
        field(22; Score; Decimal)
        {
        }
        field(23; test; Text[30])
        {
        }
        field(24; Strategy; Text[250])
        {
        }
        field(25; Measures; Text[250])
        {
        }
        field(26; Baseline; Decimal)
        {
        }
        field(27; Change; Decimal)
        {
        }
        field(28; "Agreed Mid Year Rating"; Decimal)
        {
        }
        field(29; "Agreed End Year Rating"; Decimal)
        {

            trigger OnValidate()
            begin
                //"Agreed Rating":="Quarter 1"+"Agreed Mid Year Rating"+"Quarter 3"+"Agreed End Year Rating";
                "Agreed Rating" := "Agreed End Year Rating";
            end;
        }
        field(30; "Mid Year Self Rating"; Decimal)
        {
        }
        field(31; "Mid Year Supervisor Rating"; Decimal)
        {
        }
        field(32; "Quarter 1"; Decimal)
        {
        }
        field(33; "Quarter 3"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Line No", "Appraisal No", "Perspective Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        BSCHead: Record "HR Individual Targets Header";
}

