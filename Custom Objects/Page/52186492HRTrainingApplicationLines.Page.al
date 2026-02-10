page 52186492 "HR Training Application Lines"
{
    AutoSplitKey = false;
    Caption = 'HR Training Participants';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "HR Training App Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type;Rec.Type)
                {
                    ApplicationArea=basic;
                    
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                   
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Objectives; Rec.Objectives)
                {
                    ApplicationArea = Basic;
                }
                field("Participant Email"; Rec."Participant Email")
                {
                    ApplicationArea = Basic;
                }
                field(Notified; Rec.Notified)
                {
                    ApplicationArea = Basic;
                }
                field("On Leave";Rec."On Leave")
                {

                }
                field(Remarks;Rec.Remarks)
                {
                    
                }
                
            }
        }
    }

    actions
    {
    }

    var
        HREmployees: Record "HR Employees";
        HRTrainingAppHeader: Record "HR Training App Header";
        HRTrainingAppLines: Record "HR Training App Lines";
}

