page 52185491 "Sky Insurance Card"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Sky Insurance";
    // UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = Basic;
                }
                field("Session ID"; Rec."Session ID")
                {
                    ApplicationArea = Basic;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = Basic;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = Basic;
                }
                field("Entry Time"; Rec."Entry Time")
                {
                    ApplicationArea = Basic;
                }
                field("Entry Date"; Rec."Entry Date")
                {
                    ApplicationArea = Basic;
                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic;
                }
                field(Actioned; Rec.Actioned)
                {
                    ApplicationArea = Basic;
                }
                field("Actioned By"; Rec."Actioned By")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Mark as Actioned")
            {
                ApplicationArea = Basic;
                Image = Apply;
                Promoted = true;
                Visible = MarkAsActioned;

                trigger OnAction()
                begin
                    Rec.Actioned := true;
                    Rec."Actioned By" := UserId;
                    Rec.Modify;

                    Message('Record Marked as Actioned');
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Actioned then
            MarkAsActioned := true;
    end;

    var
        MarkAsActioned: Boolean;
}

