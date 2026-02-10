page 52187050 "Parking Space Card"
{
    ApplicationArea = All;
    Caption = 'Parking Management Card';
    PageType = Card;
    SourceTable = "Parking Space";
    PromotedActionCategories = 'Home,Creation,New,Process,Report,Approvals';

    layout
    {
        area(content)
        {
            group(General)
            {
                //Editable = RequestEditable;
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Client"; Rec."Client")
                {
                    ToolTip = 'Specifies the value of the Client field.';
                    trigger OnValidate()
                    begin
                        if Rec.Client = Rec.Client::"Internal(Staff)" then begin
                            VisibleInternal := true;
                            VisibleExternal := false;
                        end
                        else
                            if Rec.Client = Rec.Client::"External" then begin
                                VisibleExternal := true;
                                VisibleInternal := false;
                            end;
                    end;
                }
                field("Parking Area"; Rec."Parking Area")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Available Parking Slots"; Rec."Available Parking Slots")
                {
                    ToolTip = 'Specifies the value of the Available Parking Slots field.';

                }
                field("Parking Slot"; Rec."Parking Slot")
                {
                }
                // field("Parking Area Allocated"; Rec."Parking Area Allocated")
                // {
                //     ToolTip = 'Specifies the value of the Parking Area Allocated  field.';
                //     Editable = false;
                // }
                field("Parking Slot Number Allocated"; Rec."Parking Slot Number Allocated")
                {
                    ToolTip = 'Specifies the value of the Parking Slot Number Allocated field.';
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Centre")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                    Editable = false;
                }
                field("Created at"; Rec."Created at")
                {
                    ToolTip = 'Specifies the value of the Created at field.';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                }
                field("Booking Status"; Rec."Booking Status")
                {
                    ToolTip = 'Specifies the value of the Booking Status field.';
                    Editable = false;
                }
            }

            group("Staff Parking Details")
            {
                Visible = VisibleInternal;
                //Editable = PageEditable;
                field("Staff No."; Rec."Staff No.")
                {
                    Caption = 'Staff PF Number';
                    ToolTip = 'Specifies the value of the Staff No. field.';
                }
                field("Staff Full Name"; Rec."Staff Full Name")
                {
                    ToolTip = 'Specifies the value of the Staff Full Name field.';
                    Editable = false;
                }
                // field("Staff PF Number"; Rec."Staff PF Number")
                // {
                //     ToolTip = 'Specifies the value of the Staff PF Number field.';
                //     Editable = false;
                // }
                field("Staff Telephone Number"; Rec."Staff Telephone Number")
                {
                    ToolTip = 'Specifies the value of the Staff Telephone Number field.';
                    Editable = false;
                }
                field("Staff Department"; Rec."Staff Department")
                {
                    ToolTip = 'Specifies the value of the Staff Department field.';

                }
                field("Vehicle Registration No."; Rec."Vehicle Registration No.")
                {
                    ToolTip = 'Specifies the value of the Vehicle Registration No. field.';

                }
            }
            group("External Client Details")
            {
                Visible = VisibleExternal;
                //Editable = PageEditable;
                field("Client No."; Rec."External Client No.")
                {
                    ToolTip = 'Specifies the value of the External Client Number field.';
                }
                field("Client Details"; Rec."External Client Details")
                {
                    Caption = 'Client Name';
                    ToolTip = 'Specifies the value of the External Client Details field.';
                    Editable = false;
                }
                field("Client Registration Number"; Rec."Vehicle Registration No.")
                {
                    Caption = 'Car Registration Number';
                }
                field("Expected Payment amounts"; Rec."Expected Payment amounts")
                {
                    ToolTip = 'Specifies the value of the Expected Payment amounts field.';
                }
                field("Expected Payment Date"; Rec."Expected Pyament Date")
                {
                    Caption = 'Expected Payment Date';
                    ToolTip = 'Specifies the value of the Expected Pyament Date field.';
                }
                field("Last Payment Amount"; Rec."Last Payment Amount")
                {
                    ToolTip = 'Specifies the value of the Last Payment Amount field.';
                }
                field("Last Payment Date"; Rec."Last Payment Date")
                {
                    ToolTip = 'Specifies the value of the Last Payment Date field.';
                }
                field("Tenant Payment Schedules"; Rec."Tenant Payment Schedule")
                {
                    ToolTip = 'Specifies the value of the Tenant Payment Schedule field.';
                }
            }
            group("Realloaction")
            {
                Visible = ReallocationVisible;

                // field("New Parking Slot"; Rec."New Parking Slot")
                // {
                // }
                // field("New Parking Area Allocated"; Rec."New Parking Area Allocated")
                // {
                //     ToolTip = 'Specifies the value of the Parking Area Allocated  field.';
                //     Editable = false;
                // }
                // field("New Parking Slot Number Allocated"; Rec."New Parking Slot Number")
                // {
                //     ToolTip = 'Specifies the value of the Parking Slot Number Allocated field.';
                //     Editable = false;
                // }
                field("Reallocation Type"; Rec."Realloaction Options")
                {
                    ToolTip = 'Specifies the value of the Reallocation Type field.';
                }
                field("New Parking Area"; Rec."New Parking Area")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("No. of Available Parking Slots"; Rec."Available Parking Slots II")
                {
                    ToolTip = 'Specifies the value of the Available Parking Slots field.';
                    Editable = false;
                }
                field("New Parking Slot"; Rec."New Parking Slot")
                {
                }
                field("New Parking Slot Number Allocated"; Rec."New Parking Slot Number")
                {
                    ToolTip = 'Specifies the value of the Parking Slot Number Allocated field.';
                    Editable = false;
                }
                field("Registration Number"; Rec."New Vehicle Registration No.")
                {
                    Caption = 'Car Registration Number';
                }
                field("Reallocation Reasons"; Rec."Reallocation Reasons")
                {
                    ToolTip = 'Specifies the value of the Reallocation Reasons field.';
                    MultiLine = true;
                }
                field("Reallocated"; Rec."Realocated")
                {
                    Editable = false;
                }
            }
            group("Case Forwarding")
            {
                Editable = ForwardingEditable;
                field("Send/Forward to"; Rec."Send/Forward to")
                {

                }
                field("Originating Department"; Rec."Originating Department")
                {
                    Editable = false;
                }
                field("Current Departmrnt"; Rec."Current Department")
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
            action("Send for Approval")
            {
                ApplicationArea = All;
                Caption = 'Send for Approval';
                Enabled = NOT OpenApprovalEntriesExist;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                //Image = Send;
                trigger OnAction()

                var
                    CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    Rec.TestField(Status, Rec.Status::Open);

                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Enabled = OpenApprovalEntriesExist;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category6;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    if Rec.Status <> Rec.Status::Pending then
                        Error(DocMustbePending);

                    VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            action("Assign Parking")
            {
                ApplicationArea = All;
                Caption = 'Assign Parking';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    IF Confirm('Are you sure you want to Assign this Parking Booking?') then begin
                        ParkingLotSpaces.Reset();
                        ParkingLotSpaces.SetRange(ParkingLotSpaces.No, Rec."Parking Slot");
                        IF ParkingLotSpaces.Find('-') then begin
                            if ParkingLotSpaces."Parking Slot Status" = ParkingLotSpaces."Parking Slot Status"::Occupied then
                                Error('Parking Slot ' + Rec."Parking Slot" + ' is already Occupied. Reopen the card to assign available parking.');
                        end
                        else
                            ParkingLotSpaces."Parking Slot Status" := ParkingLotSpaces."Parking Slot Status"::Occupied;
                        Rec."Booking Status" := Rec."Booking Status"::Assigned;
                        ParkingLotSpaces.Modify();
                        Message('Parking Slot Assigned');
                    end
                    else
                        Error('Parking Slot ' + Rec."Parking Slot" + ' Not Found!');

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
                    Rec.TestField(Status, Rec.Status::Approved);
                    Rec.TestField("Booking Status", Rec."Booking Status"::Assigned);
                    //Rec.TestField(Rec.Realocated, false);
                    IF Confirm('Are you sure you want to close this Parking Booking?') then begin

                        ParkingLotSpaces.Reset();
                        ParkingLotSpaces.SetRange(ParkingLotSpaces.No, Rec."Parking Slot");
                        IF ParkingLotSpaces.Find('-') then
                            ParkingLotSpaces."Parking Slot Status" := ParkingLotSpaces."Parking Slot Status"::Available;
                        ParkingLotSpaces.Modify();
                    end;
                    if Rec.Realocated = true then begin
                        ParkingLotSpaces.Reset();
                        ParkingLotSpaces.SetRange(ParkingLotSpaces.No, Rec."New Parking Slot");
                        IF ParkingLotSpaces.Find('-') then
                            ParkingLotSpaces."Parking Slot Status" := ParkingLotSpaces."Parking Slot Status"::Available;
                        ParkingLotSpaces.Modify();
                    end;

                    Rec."Booking Status" := Rec."Booking Status"::Closed;
                    Rec.MODIFY(true);
                    MESSAGE('Booking Closed');
                end;
            }
            action("Update and Reallocation")
            {
                ApplicationArea = All;
                Caption = 'Update and Reallocation';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    if Rec."Realloaction Options" = Rec."Realloaction Options"::" " then
                        Error('Please select a Reallocation Type')
                    else
                        if Rec."Realloaction Options" = Rec."Realloaction Options"::"Change Parking Slot" then begin
                            Rec.TestField("New Parking Area");
                            Rec.TestField("Reallocation Reasons")
                        end
                        else
                            if Rec."Realloaction Options" = Rec."Realloaction Options"::"Change Vehicle" then begin
                                Rec.TestField("New Parking Slot");
                                Rec.TestField("Reallocation Reasons")
                            end
                            else
                                if Rec."Realloaction Options" = Rec."Realloaction Options"::"Change Both" then begin
                                    Rec.TestField("New Parking Area");
                                    Rec.TestField("New Parking Slot");
                                    Rec.TestField("New Vehicle Registration No.");
                                    Rec.TestField("Reallocation Reasons");
                                end;

                    IF Confirm('Are you sure you want to Update this Parking Booking?') then begin
                        Rec.TestField(Status, Rec.Status::Approved);


                        ParkingLotSpaces.Reset();
                        ParkingLotSpaces.SetRange(ParkingLotSpaces.No, Rec."New Parking Slot");
                        IF ParkingLotSpaces.Find('-') then
                            ParkingLotSpaces."Parking Slot Status" := ParkingLotSpaces."Parking Slot Status"::Occupied;
                        ParkingLotSpaces.Modify();
                        ParkingLotSpaces.Reset();
                        ParkingLotSpaces.SetRange(ParkingLotSpaces.No, Rec."Parking Slot");
                        IF ParkingLotSpaces.Find('-') then
                            ParkingLotSpaces."Parking Slot Status" := ParkingLotSpaces."Parking Slot Status"::Available;
                        ParkingLotSpaces.Modify();
                        Message('Old Parking Slot Now Available');
                    end;

                    Rec."Realocated" := true;
                    Rec.MODIFY(true);
                    MESSAGE('Parking Updated and Reallocated');
                end;
            }
            group("Document Forwarding")
            {
                action("Document Comments")
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("No.");
                    RunPageView = where(Types = CONST(comment));
                }
                action("Send Case")
                {
                    ApplicationArea = Basic, Suite;
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Category4;
                    // Visible = SendCaseVisible;

                    trigger OnAction()
                    var
                    begin
                        if Rec."Send/Forward to" = Rec."Current Department" then Error('You cannot send this document to %1 while its already in %1', Rec."Send/Forward to");
                        Comments.Reset();
                        Comments.SetRange("Header No.", Rec."No.");
                        if Comments.FindLast() then begin
                            if Comments."Commented By" <> UserId then Error('Kindly leave a comment');
                            if Comments.Comment = '' then Error('Kindly leave a comment');
                        end else
                            Error('Kindly add a comment');
                        if not Confirm('Are you sure you want to send this case?') then exit;
                        // Rec."Originator Status" := Rec."Originator Status"::Sent;
                        // Rec."Recepient Status" := Rec."Recepient Status"::New;
                        Rec."Current Department" := Rec."Send/Forward to";

                        // if (CurrentUsersDept <> Rec."Originating Department") and (Rec."Send/Forward to" = Rec."Originating Department") then begin
                        //     Rec."Originator Status" := Rec."Originator Status"::Returned;
                        //     Rec."Recepient Status" := Rec."Recepient Status"::Returned;
                        // end;
                        CFPage.InsertTracker(Rec."No.", Rec."Send/Forward to", true, UserId, CurrentDateTime);
                        Rec.Modify();
                        Message('Case sent successfully');
                    end;
                }
                action("Case Tracker")
                {
                    ApplicationArea = Basic, Suite;
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Category4;

                    RunObject = page "CF Tracker List";
                    RunPageLink = "Header No." = field("No.");
                }
            }

        }
    }

    trigger OnOpenPage()
    begin
        begin
            PageControl();
        end;
        if UserSetup.Get('-') then begin
            Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            Rec."Responsibility Centre" := UserSetup."Responsibility Centre";
            Rec."Created By" := UserId;
            Rec.Modify;
        end;
        Rec."Created at" := CURRENTDATETIME;
        Rec."Created By" := UserId;

        // if rec.Status=rec.Status::Approved then begin
        // CurrPage.Editable:=false;
        // end;
    end;

    // trigger OnAfterGetRecord()
    // begin
    //     if Rec.Status = Rec.Status::Open then
    //         PageEditable := true;
    //     ReallocationVisible := false;

    //     if Rec.Status = Rec.Status::Approved then
    //         PageEditable := false;
    //     ReallocationVisible := true;

    //     if Rec.Status = Rec.Status::Pending then
    //         PageEditable := true;
    //     ReallocationVisible := true;
    // end;

    procedure UpdatePageControls()
    begin
        if Rec.Status = Rec.Status::Open then begin
            RequestEditable := True;
            ReallocationVisible := False;
            PageEditable := True;
        end
        else begin
            if Rec.Status = Rec.Status::Pending then begin
                RequestEditable := True;
                ReallocationVisible := True;
            end
            else begin
                if Rec.Status = Rec.Status::Approved then begin
                    RequestEditable := False;
                    ReallocationVisible := True;
                end;
            end;
        end;
    end;

    local procedure PageControl();
    begin

        VisibleExternal := false;
        VisibleInternal := false;

        if Rec.Client = Rec.Client::"Internal(Staff)" then begin
            VisibleInternal := true;
            VisibleExternal := false;
        end;
        if Rec."Client" = Rec."Client"::"External" then begin
            VisibleInternal := false;
            VisibleExternal := true;
        end;
        if Rec."Client" = Rec."Client"::" " then begin
            VisibleInternal := false;
            VisibleExternal := false;
        end;


        ReallocationVisible := false;
        if Rec.Status = Rec.Status::Open then begin
            ReallocationVisible := false;
            ForwardingEditable := False;
        end;

        if Rec.Status = Rec.Status::Pending then begin
            ReallocationVisible := true;
            ForwardingEditable := false;
        end;
        if Rec.Status = Rec.Status::Approved then begin
            ReallocationVisible := true;
            ForwardingEditable := true;
        end;
    end;


    var
        VisibleInternal: Boolean;
        VisibleExternal: Boolean;
        ParkingLotSpaces: Record "Parking List Table";
        UserSetup: Record "User Setup";
        VarVariant: Variant;
        OpenApprovalEntriesExist: boolean;
        DocMustbePending: Label 'This application request must be Pending';
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        ReallocationVisible: Boolean;
        RequestEditable: Boolean;
        PageEditable: Boolean;
        ForwardingEditable: Boolean;

        CaseTracker: Record "CF Tracker";
        CFPage: Page "DMU CF Page";
        CFStations: Record "CF Station Actions";
        Comments: Record Comments;
}
