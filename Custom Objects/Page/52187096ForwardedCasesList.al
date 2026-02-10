page 52187096 "Forwarded Cases"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "DMU Case Forwarding";
    CardPageId = "DMU CF Page";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    SourceTableView = where("Originating Status" = filter(<>New));
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = false;
                }
                field("Send/Forward to"; Rec."Send/Forward to")
                {

                }

                field("Open Issues"; Rec."Open Issues")
                {
                    Editable = false;
                }
                field("Originating Department"; Rec."Originating Department")
                {
                    Editable = false;
                }
                field("Current Departmrnt"; Rec."Current Departmrnt")
                {
                    Editable = false;
                }
                field("Originating Status"; Rec."Originating Status")
                {
                    Editable = false;
                }
                field("Recepient Status"; Rec."Recepient Status")
                {
                    Editable = false;
                }
                field("Viewed By Recepient";Rec."Viewed By Recepient")
                {
                    Editable = false;
                }
                
            }
        }
    }

    trigger OnOpenPage()
    var
    UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then begin
            UserSetup.TestField("Responsibility Centre");
            Rec.SetFilter("Originating Department",UserSetup."Responsibility Centre");
        end else
            Error('You must be set up in user setup');
    end;
}
