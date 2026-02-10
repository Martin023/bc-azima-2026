page 52187316 "Edits Helper"
{
    Editable = false;
    PageType = List;
    SourceTable = "Edits Helper";

    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Edits Header No."; Rec."Edits Header No.")
                {
                    Editable = false;
                }
                field("Record No."; Rec."Record No.")
                {
                    Editable = false;
                }
                field("Workflow Status"; Rec."Workflow Status")
                {
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action("Open This Edit")
            {
                ApplicationArea = Basic, Suite;
                Image = OpenWorksheet;
                Promoted = true;

                trigger OnAction()
                var
                begin
                    if SystemEdits.Get(Rec."Edits Header No.") then
                        Page.Run(52187081, SystemEdits);
                end;
            }

            action("Open Edit Card")
            {
                ApplicationArea = Basic, Suite;
                Image = Process;
                Promoted = true;


                trigger OnAction()
                var
                begin
                    if SystemEdits.Get(Rec."Edits Header No.") then
                        Page.Run(52187317, SystemEdits);
                end;

            }

        }
    }

    trigger OnOpenPage()
    begin

    end;

    trigger OnAfterGetRecord()
    begin
    end;

    procedure GetSystemEdits()
    begin
        SystemEdits.Get(Rec."Edits Header No.");
    end;

    var
        SystemEdits: Record "System Edits";
        SystemEditsFilters: Record "System Edits Filters";
        Members: Record Members;
        RecRef: RecordRef;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        SystemEditsCodeunit: Codeunit "System Editss";
        GlobalFunctions: Codeunit "Global Functions";
        SystemEditsCard: Page "System Edits Card";


}

