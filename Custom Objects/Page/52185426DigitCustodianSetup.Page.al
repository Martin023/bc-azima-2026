page 52185426 "Digit Custodian Setup"
{
    PageType = List;
    SourceTable = "Digit Custodian Setup";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Department; Rec.Department)
                {

                }
                field("Sub Module"; Rec."Sub Module")
                {

                }
                field("Responsible Officer Code"; Rec."Responsible Officer Code")
                {
                    ApplicationArea = All;
                    TableRelation = "User Setup"."User ID";
                }

                field("Supervisor Officer Code"; Rec."Supervisor Officer Code")
                {
                    ApplicationArea = All;
                    TableRelation = "User Setup"."User ID";
                }

                field("Digit Custodian"; Rec."Digit Custodian")
                {
                    ApplicationArea = All;
                }

                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Activate)
            {
                PromotedCategory = Process;
                Promoted = true;
                Image = ActivateDiscounts;
                trigger OnAction()
                begin
                    if not Confirm('Are you sure you want to activate this entry, note this action can oly be reversed by system edits') then exit;
                    Rec.Active := true;
                    Rec.Sealed := true;
                    Rec.Modify();
                    Message('Activated successfully');
                end;

            }

            action(Modify)
            {
                ApplicationArea = All;
            }

            action(Delete)
            {
                ApplicationArea = All;
            }
        }
    }

}
