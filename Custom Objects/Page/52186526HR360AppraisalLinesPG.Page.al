page 52186526 "HR 360 Appraisal Lines - PG"
{
    Caption = 'HR Appraisal Lines - Personal Goals/Objectives';
    PageType = ListPart;
    SourceTable = "HR Appraisal Lines";
    SourceTableView = WHERE("Categorize As" = CONST("Personal Goals/Objectives"));
    ApplicationArea = Basic;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sub Category"; Rec."Sub Category")
                {
                    ApplicationArea = Basic;
                }
                field("Perfomance Goals and Targets"; Rec."Perfomance Goals and Targets")
                {
                    ApplicationArea = Basic;
                    MultiLine=true;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Basic;
                }
                // field("Min. Target Score"; Rec."Min. Target Score")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Max Target Score"; Rec."Max Target Score")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Self Rating"; Rec."Self Rating")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Comments"; Rec."Employee Comments")
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor Rating"; Rec."Supervisor Rating")
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor Comments"; Rec."Supervisor Comments")
                {
                    ApplicationArea = Basic;
                }
                field("HOD Comments";Rec."HOD Comments")
                {
                    Caption='HOD Comments';
                }
                 field("HRM Comments";Rec."HRM Comments")
                {
                    
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Categorize As" := Rec."Categorize As"::"Personal Goals/Objectives";
        //Rec."Sub Category" := Rec."Sub Category"::"Personal Goals";
    end;
}

