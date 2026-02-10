page 52186493 "HR Training Bonding Cond. List"
{
    Caption = 'HR Training Bonding Conditions List';
    PageType = List;
    SourceTable = "HR Training Bonding Conditions";

    ApplicationArea = Basic;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Condition Type"; Rec."Condition Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        HRTrainingNeeds.Reset;
                        if HRTrainingNeeds.Get(Rec."Training Bonding Code") then begin
                            HRTrainingNeeds.TestField(HRTrainingNeeds."Allow Early Exit if Bonded?", true);
                        end;
                    end;
                }
                field("Condition Description"; Rec."Condition Description")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control8; Outlook)
            {
                ApplicationArea = Basic;
            }
            systempart(Control9; Notes)
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
    }

    var
        HRTrainingNeeds: Record "HR Training Needs";
}

