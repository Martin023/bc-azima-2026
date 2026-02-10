page 52186167 "Agent Error Messages"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Agent Error Messages";
    ApplicationArea = Basic, Suite;
    //UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'General';
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Agent Code"; Rec."Agent Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(DateTime; Rec.DateTime)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Agent Name"; Rec.AgentApp.Name)
                // {
                // }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        if AgentApp.Get(rec."Agent Code") then;
    end;

    var
        AgentApp: Record "Agent Applications..";
}

