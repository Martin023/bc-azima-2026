page 52186625 "HR Interns List"
{
    CardPageID = "HR Interns Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Interns";
    UsageCategory = Lists;
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = Basic;
                }
                field(Sex; Rec.Sex)
                {
                    ApplicationArea = Basic;
                }
                field(Institution; Rec.Institution)
                {
                    ApplicationArea = Basic;
                }
                field("Course Undertaken"; Rec."Course Undertaken")
                {
                    ApplicationArea = Basic;
                }
                field(Specialization; Rec.Specialization)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Status"; Rec."Posting Status")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleText;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control16; Notes)
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        StyleText := HRCodeunit.fn_SetStyle(Format(Rec."Posting Status"));
    end;

    var
        StyleText: Text;
        HRCodeunit: Codeunit "HR Codeunit2";
}

