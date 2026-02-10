page 52186569 "HR Activity Participants SF"
{
    Caption = 'Activity Participants';
    PageType = ListPart;
    SaveValues = true;
    SourceTable = "HR Activity Participants";
    ApplicationArea = Basic;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field(Notified; Rec.Notified)
                {
                    ApplicationArea = Basic;
                }
                field(Participant; Rec.Participant)
                {
                    ApplicationArea = Basic;
                }
                field("Participant Name"; Rec."Participant Name")
                {
                    ApplicationArea = Basic;
                }
                field("Participant E-Mail"; Rec."Participant E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field("Participant Role"; Rec."Participant Role")
                {
                    ApplicationArea = Basic;
                }
                field(Contribution; Rec.Contribution)
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

