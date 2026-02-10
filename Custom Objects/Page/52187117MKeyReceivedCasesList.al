page 52187117 "MKey Received Cases"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "MKey Forwarding";;
    CardPageId = "MKey Page";
    Editable = false;
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
                field("Inserted At";Rec."Inserted At")
                {
                    
                }
                field("Sent At";Rec."Sent At")
                {

                }
                field("Sent By";Rec."Sent By")
                {
                    
                }
                field(Status;Rec.Status)
                {

                }
                field("Case Closed";Rec."Case Closed")
                {

                }
                 field("Case Closed At";Rec."Case Closed At")
                {

                }
                field("Case Closed By";Rec."Case Closed By")
                {
                    
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
            Rec.SetFilter("Current Departmrnt",UserSetup."Responsibility Centre");
        end else
            Error('You must be set up in user setup');
    end;
}
