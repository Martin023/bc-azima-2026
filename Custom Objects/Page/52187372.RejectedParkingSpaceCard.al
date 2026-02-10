page 52187372 "Rejected Parking Space - Card"
{
    ApplicationArea = All;
    Caption = 'Rejected Parking Space - Card';
    PageType = Card;
    SourceTable = "Parking Space";
    DeleteAllowed = False;
    Editable = False;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE(Status = CONST(Rejected)); 
    
    
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Client";Rec."Client")
                {
                    ToolTip = 'Specifies the value of the Client field.';
                    trigger OnValidate()
                    begin
                        //if Rec.Client = Rec.Client::"Internal-Staff" then

                    end;    
                }
                field("Available Parking Slots"; Rec."Available Parking Slots")
                {
                    ToolTip = 'Specifies the value of the Available Parking Slots field.';
                }
                field("Parking Area Allocated"; Rec."Parking Area Allocated")
                {
                    ToolTip = 'Specifies the value of the Parking Area Allocated  field.';
                }
                field("Parking Slot Number Allocated"; Rec."Parking Slot Number Allocated")
                {
                    ToolTip = 'Specifies the value of the Parking Slot Number Allocated field.';
                }
            }

            group("Staff Parking Details")
            {
                field("Staff No."; Rec."Staff No.")
                {
                    ToolTip = 'Specifies the value of the Staff No. field.';
                }
                field("Staff Full Name"; Rec."Staff Full Name")
                {
                    ToolTip = 'Specifies the value of the Staff Full Name field.';
                }
                field("Staff Department"; Rec."Staff Department")
                {
                    ToolTip = 'Specifies the value of the Staff Department field.';
                }
                field("Staff Telephone Number"; Rec."Staff Telephone Number")
                {
                    ToolTip = 'Specifies the value of the Staff Telephone Number field.';
                }

            }
            group("External Client")
            {
                field("Expected Payment amounts"; Rec."Expected Payment amounts")
                {
                    ToolTip = 'Specifies the value of the Expected Payment amounts field.';
                }
                field("Expected Pyament Date"; Rec."Expected Pyament Date")
                {
                    ToolTip = 'Specifies the value of the Expected Pyament Date field.';
                }
                field("External Client Details"; Rec."External Client Details")
                {
                    ToolTip = 'Specifies the value of the External Client Details field.';
                }
                field("Last Payment Amount"; Rec."Last Payment Amount")
                {
                    ToolTip = 'Specifies the value of the Last Payment Amount field.';
                }
                field("Last Payment Date"; Rec."Last Payment Date")
                {
                    ToolTip = 'Specifies the value of the Last Payment Date field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field("Responsibility Center"; Rec."Responsibility Centre")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field("Captured By"; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
                // field("Tenant Payment Schedule"; Rec."Tenant Payment Schedule")
                // {
                //     ToolTip = 'Specifies the value of the Tenant Payment Schedule field.';
                // }
            }
        }
        

    }
    actions
    {
        area(Creation)
        {
            action("Send for Approval")
            {
                ApplicationArea = All;
                Caption = 'Send for Approval';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //Image = Send;
                trigger OnAction()
                begin
                    //Rec.Status := Rec.Status::Application;
                    //Rec."Approval Status" := Rec."Approval Status"::Pending;
                    // Rec."Approval Date" := CURRENTDATETIME;
                    // Rec."Approval By" := USERID;
                    // Rec."Approval Comments" := 'Pending';
                    // Rec.MODIFY(true);
                    MESSAGE('Record Sent for Approval');
                end;
            }
            action("Decline")
            {
                ApplicationArea = All;
                Caption = 'Decline';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //Image = Decline;
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Rejected;
                    // Rec."Approval Status" := Rec."Approval Status"::Declined;
                    // Rec."Approval Date" := CURRENTDATETIME;
                    // Rec."Approval By" := USERID;
                    // Rec."Approval Comments" := 'Declined';
                    // Rec.MODIFY(true);
                    MESSAGE('Record Declined');
                end;
            }
            action("Defer")
            {
                ApplicationArea = All;
                Caption = 'Defer';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //Image = Defer;
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Deffered;
                    // Rec."Approval Status" := Rec."Approval Status"::Deferred;
                    // Rec."Approval Date" := CURRENTDATETIME;
                    // Rec."Approval By" := USERID;
                    // Rec."Approval Comments" := 'Deferred';
                    // Rec.MODIFY(true);
                    MESSAGE('Record Deferred');
                end;
            }
            action(Cancel)
            {
                ApplicationArea = All;
                Caption = 'Cancel';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Cancel;
                trigger OnAction()
                begin
                    //Rec.Status := Rec.Status::Closed;
                    // Rec."Approval Status" := Rec."Approval Status"::Cancelled;
                    // Rec."Approval Date" := CURRENTDATETIME;
                    // Rec."Approval By" := USERID;
                    // Rec."Approval Comments" := 'Cancelled';
                    // Rec.MODIFY(true);
                    MESSAGE('Record Cancelled');
                end;
            }
            action("Close Parking Booking")
            {
                ApplicationArea = All;
                Caption = 'Close Parking Booking';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Close;
                trigger OnAction()
                begin
                    //Rec.Status := Rec.Status::Closed;
                    // Rec."Approval Status" := Rec."Approval Status"::Closed;
                    // Rec."Approval Date" := CURRENTDATETIME;
                    // Rec."Approval By" := USERID;
                    // Rec."Approval Comments" := 'Closed';
                    // Rec.MODIFY(true);
                    MESSAGE('Record Closed');
                end;
            }
        }
    }
    var
    VarVariant: Variant;
    UserSetup: Record "User Setup";
            
    trigger OnOpenPage()
    begin
            if UserSetup.Get('-') then begin 
            Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            Rec."Responsibility Centre" := UserSetup."Responsibility Centre";
            Rec."Created By" := UserId;
            Rec.Modify;
        end;
    end;   
}

