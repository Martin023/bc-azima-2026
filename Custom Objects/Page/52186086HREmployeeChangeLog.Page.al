page 52186086 "HR Employee Change Log"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Employee Change Log";
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = Basic;
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = Basic;
                }
                field("Date Modified"; Rec."Date Modified")
                {
                    ApplicationArea = Basic;
                }
                field("Time Modified"; Rec."Time Modified")
                {
                    ApplicationArea = Basic;
                }
                field("Modified by"; Rec."Modified by")
                {
                    ApplicationArea = Basic;
                }
                field("Field Changed"; Rec."Field Changed")
                {
                    ApplicationArea = Basic;
                }
                field("Old Value"; Rec."Old Value")
                {
                    ApplicationArea = Basic;
                }
                field("New Value"; Rec."New Value")
                {
                    ApplicationArea = Basic;
                }
                field("Reason for Change"; Rec."Reason for Change")
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

