page 52185936 "HR Email Template List"
{
    Caption = 'HR Email Templates';
    PageType = List;
    SourceTable = "HR Email Template";
    CardPageID = "HR Email Template Card";
    ApplicationArea = Basic;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Event Code"; Rec."Event Code")
                {
                    ApplicationArea = Basic;
                }
                field("Recipient Role"; Rec."Recipient Role")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Subject; Rec.Subject)
                {
                    ApplicationArea = Basic;
                }
                field(Enabled; Rec.Enabled)
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = Rec.Enabled;
                }
                field("CC Email"; Rec."CC Email")
                {
                    ApplicationArea = Basic;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = Basic;
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Show Enabled")
            {
                ApplicationArea = Basic;
                Caption = 'Enabled Only';
                Image = FilterLines;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.SetRange(Enabled, true);
                    CurrPage.Update(false);
                end;
            }
            action("Show All")
            {
                ApplicationArea = Basic;
                Caption = 'All';
                Image = ClearFilter;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.SetRange(Enabled);
                    CurrPage.Update(false);
                end;
            }
        }
    }
}
