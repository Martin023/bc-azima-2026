namespace AZIMA.AZIMA;

page 52185437 "IT System Setup List"
{
    ApplicationArea = All;
    Caption = 'IT System Setup';
    PageType = List;
    SourceTable = "IT System Setup";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("System Code"; Rec."System Code")
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }

                field("Requires ICT Approval"; Rec."Requires ICT Approval")
                {
                    ApplicationArea = All;
                }

                field("Requires Admin Approval"; Rec."Requires Admin Approval")
                {
                    ApplicationArea = All;
                }

                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
