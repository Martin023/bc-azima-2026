page 52185488 "Mortgage Card"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Sky Mortgage";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Session ID"; Rec."Session ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Age Group"; Rec."Age Group")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Source Of Income"; Rec."Source Of Income")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Gross Monthly Income"; Rec."Gross Monthly Income")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("County Of Residence"; Rec."County Of Residence")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Actioned; Rec.Actioned)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Entry Time"; Rec."Entry Time")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Entry Date"; Rec."Entry Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Actioned By"; Rec."Actioned By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Actioned"; Rec."Date Actioned")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Time Actioned"; Rec."Time Actioned")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Mark As Actioned")
            {
                ApplicationArea = Basic, Suite;
                Image = Apply;
                Promoted = true;
                Visible = MarkAsActioned;

                trigger OnAction()
                begin
                    Rec.Actioned := true;
                    Rec."Actioned By" := UserId;
                    Rec."Date Actioned" := Today;
                    Rec."Time Actioned" := Time;
                    Rec.Modify;
                    Message('Entry Marked as actioned!');
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

