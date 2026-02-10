page 52186495 "HR Disciplinary Cases SF"
{
    PageType = ListPart;
    SourceTable = "HR Disciplinary Cases NCA";
    UsageCategory = Lists;
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Case Number"; Rec."Case Number")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Date of Complaint"; Rec."Date of Complaint")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date Of Occurance';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Selected; Rec.Selected)
                {
                    ApplicationArea = Basic;
                    Caption = 'Repeat';
                }
                field("Type Complaint"; Rec."Type Complaint")
                {
                    ApplicationArea = Basic;
                }
                field("Description of Complaint"; Rec."Description of Complaint")
                {
                    ApplicationArea = Basic;
                }
                field("Case Discussion"; Rec."Case Discussion")
                {
                    ApplicationArea = Basic;
                }
                field("Mode of Lodging the Complaint"; Rec."Mode of Lodging the Complaint")
                {
                    ApplicationArea = Basic;
                }
                field("Accused Employee"; Rec."Accused Employee")
                {
                    ApplicationArea = Basic;
                }
                field("Witness #1"; Rec."Witness #1")
                {
                    ApplicationArea = Basic;
                }
                field("Witness #2"; Rec."Witness #2")
                {
                    ApplicationArea = Basic;
                }
                field("Recommended Action"; Rec."Recommended Action")
                {
                    ApplicationArea = Basic;
                }
                field("Action Taken"; Rec."Action Taken")
                {
                    ApplicationArea = Basic;
                }
                field(Recomendations; Rec.Recomendations)
                {
                    ApplicationArea = Basic;
                }
                field("Disciplinary Remarks"; Rec."Disciplinary Remarks")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

