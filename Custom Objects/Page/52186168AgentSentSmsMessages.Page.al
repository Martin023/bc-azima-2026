page 52186168 "Agent Sent Sms Messages"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Agent Sent Sms";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Agent Code"; Rec."Agent Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Agent Name"; AgentApplications."Name of the Proposed Agent")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(DateTime; Rec.DateTime)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Text Message"; Rec."Text Message")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Source Transaction"; Rec."Source Transaction")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        if AgentApplications.Get(rec."Agent Code") then;
    end;

    var
        AgentApplications: Record "Agent Applications";
}

