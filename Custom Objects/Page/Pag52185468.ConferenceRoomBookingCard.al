page 52185468 "Conference Room Booking Card"
{
    ApplicationArea = All;
    Caption = 'Conference Room Booking Card';
    PageType = Card;
    SourceTable = "Conference & Meeting Rooms-T";
    PromotedActionCategories = 'Home,New,Report,Process,Approval,Case Forwarding';

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = PageEditable;
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = false;
                }

                field("Type of Meeting"; Rec."Type of Meeting/Function")
                {
                    ToolTip = 'Specifies the value of the Type of Meeting/Function field.';
                    Editable = PageEditable;
                    trigger OnValidate()
                    begin
                        if Rec."Type of Meeting/Function" = Rec."Type of Meeting/Function"::"Internal" then begin
                            VisibleInternal := true;
                            VisibleExternal := false;
                        end;
                        if Rec."Type of Meeting/Function" = Rec."Type of Meeting/Function"::"External" then begin
                            VisibleInternal := false;
                            VisibleExternal := true;
                        end;
                    end;
                }
                field("Date of Meeting/Function"; Rec."Date of Meeting/Function")
                {
                    ToolTip = 'Specifies the value of the Date of Meeting/Function field.';
                    Caption = 'Start Date of Meeting/Function';
                }

                field("Event End Date"; Rec."Event End Date")
                {
                    ToolTip = 'Specifies the value of the Event End Date field.';
                    Caption = 'End Date of Meeting/Function';
                }
                field("Start Time of Meeting/Function"; Rec."Start Time of Meeting/Function")
                {
                    ToolTip = 'Specifies the value of the Start Time of Meeting/Function field.';
                }
                field("Duration of Meeting/Fucntion"; Rec."Duration of Meeting/Fucntion")
                {
                    ToolTip = 'Specifies the value of the Duration of Meeting/Fucntion field.';
                    Caption = 'Duration of Meeting/Function';
                }
                field("Meeting Room"; Rec."Meeting Room")
                {
                    Caption = 'Meeting Room Code';
                    ToolTip = 'Specifies the value of the Meeting Room field.';
                }
                field("Meeting Room Name"; Rec."Meeting Room Name")
                {
                    ToolTip = 'Specifies the value of the Meeting Room Name field.';
                    Editable = false;
                }
                field("No. of Attendees"; Rec."No. of Attendees")
                {
                    ToolTip = 'Specifies the value of the No. of Attendees field.';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount Inclusive of VAT';
                }
                field("Special Requirements"; Rec."Special Requirements")
                {
                    ToolTip = 'Specifies the value of the Special Requirements field.';
                }
                field("Status"; Rec.Status)
                {
                    Editable = False;
                }
                field("Booking Status"; Rec."Status of the Booking")
                {
                    Editable = False;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                    ToolTip = 'Specifies the value of the Department field.';
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
                field("Created at"; Rec."Created at")
                {
                    Editable = false;
                }
            }
            group("Internal Details")
            {
                Visible = VisibleInternal;
                Editable = PageEditable;

                field("Staff Requesting"; Rec."Staff Requesting")
                {
                    ToolTip = 'Specifies the value of the Staff Requesting field.';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ToolTip = 'Specifies the value of the Staff Name field.';
                    Editable = false;
                }
                FIELD(Department; Rec.Department)
                {
                }
            }
            group("External Details")
            {
                Visible = VisibleExternal;
                Editable = PageEditable;

                field("Client Name"; Rec."Department/Client/Company Name")
                {
                    Caption = 'Client Name';
                    ToolTip = 'Specifies the value of the Department/Client/Company Name field.';
                }
                field("Address"; Rec."Address")
                {
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field("Contact Person"; Rec."Contact Person")
                {
                    ToolTip = 'Specifies the value of the Contact Person field.';
                }
                field("Contact No."; Rec."Contact No.")
                {
                    ToolTip = 'Specifies the value of the Contact No. field.';

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
        area(creation)
        {
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()

                var
                    CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";

                begin
                    Rec.TestField("Date of Meeting/Function");
                    Rec.TestField("Type of Meeting/Function");
                    Rec.TestField("Meeting Room");
                    Rec.TestField("Start Time of Meeting/Function");
                    Rec.TestField("Duration of Meeting/Fucntion");
                    Rec.TestField("No. of Attendees");
                    Rec.TestField("Global Dimension 1 Code");
                    Rec.TestField("Global Dimension 2 Code");
                    Rec.TestField("Created By");

                    if Rec."Type of Meeting/Function" = Rec."Type of Meeting/Function"::"Internal" then begin
                        Rec.TestField("Staff Requesting");
                        Rec.TestField("Staff Name");
                    end
                    else
                        if Rec."Type of Meeting/Function" = Rec."Type of Meeting/Function"::"External" then begin
                            Rec.TestField("Department/Client/Company Name");
                            //Rec.TestField("Staff/client/company Details");
                            Rec.TestField("Address");
                            Rec.TestField("Contact Person");
                            Rec.TestField("Contact No.");
                            Rec.TestField(Amount);
                        end;

                    //Rec.TestField(Status, Rec.Status::Open);
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
                PromotedCategory = Category5;

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
            action("Re-Open Document")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category5;
                Image = ReOpen;

                trigger OnAction()
                begin

                    if not Confirm('Are you sure you want to re-open this document?') then exit;
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify;
                    Message('Document Reopened Sucessfully.');
                end;
            }
            action(Approve)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Rec.TestField(Status, Rec.Status::Pending);
                    //if Rec.Status = Rec.Status::Pending then begin
                    Rec.Status := Rec.Status::Approved;
                    Rec.Modify;
                    Message('Document Approved Successfully');
                end;
                //end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }
            action("Book Conference Room")
            {
                ApplicationArea = All;
                Caption = 'Allocate Room';
                Promoted = True;
                PromotedCategory = Category4;
                trigger OnAction()

                begin
                    //Rec.TestField(Status, Rec.Status::Approved);
                    Rec.TestField("Status of the Booking", Rec."Status of the Booking"::Open);

                    if Rec.Status = Rec.Status::Approved then
                        If Confirm('Are you sure you want to book this room?')
                        then Begin

                            Conferences.RESET();
                            Conferences.SetRange(Conferences."No.", Rec."Meeting Room");
                            if Conferences.Find('-') then begin
                                Conferences."Room Status" := Conferences."Room Status"::Booked;
                                Conferences.Modify();
                            end;
                            Rec."Status of the Booking" := Rec."Status of the Booking"::Accepted;
                            Rec.Modify();
                            Message('Conference Room Booking Successful!');

                            //Procedure InsertToPlanner();
                        end
                        else
                            Error('Conference Room 1% Not Available for booking!')
                end;
            }
            action(Close)
            {
                ApplicationArea = All;
                Caption = 'Close Booking';
                Image = Close;
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    Rec.TestField("Status of the Booking", Rec."Status of the Booking"::Accepted);
                    Rec.TestField("Date of Meeting/Function");

                    if Confirm('Are you sure you want to close this booking?') then
                        if Rec."Date of Meeting/Function" > Today then begin
                            Error('A future booking cannot be closed!')
                        end
                        else
                            if Rec."Status of the Booking" = Rec."Status of the Booking"::Closed then begin
                                Error('Booking already Closed');
                            end
                            else if Rec."Status of the Booking" = Rec."Status of the Booking"::Accepted then begin
                                Conferences.RESET();
                                Conferences.SetRange(Conferences."No.", Rec."Meeting Room");
                                if Conferences.Find('-') then begin
                                    Conferences."Room Status" := Conferences."Room Status"::Available;
                                    Conferences.Modify();
                                end;
                                Rec."Status of the Booking" := Rec."Status of the Booking"::Closed;
                                Message('Booking Closed!');
                                Rec.Modify();
                            end;
                end;
            }
            group("Document Forwarding")
            {
                action("Document Comments")
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category6;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("No.");
                    RunPageView = where(Types = CONST(comment));
                }
                action("Send Case")
                {
                    ApplicationArea = Basic, Suite;
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Category6;
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
                    PromotedCategory = Category6;

                    RunObject = page "CF Tracker List";
                    RunPageLink = "Header No." = field("No.");
                }
            }
        }
    }
    // trigger OnOpenPage()
    // begin
    //     PageControl();
    //     if Rec.Status = Rec.Status::Approved then
    //         CurrPage.editable := false;
    // end;
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        CurrPage.UPDATE;
        if Rec.Status = Rec.Status::Open then begin
            //CurrPage.Editable := true
            PageEditable := true;
            ForwardingEditable := false;
        end
        else begin
            //CurrPage.Editable := false;
            PageEditable := false;
            ForwardingEditable := true;
        end;
        PageControl();
    end;

    local procedure PageControl()
    begin
        VisibleExternal := false;
        VisibleInternal := false;

        if Rec."Type of Meeting/Function" = Rec."Type of Meeting/Function"::"Internal" then begin
            VisibleInternal := true;
            VisibleExternal := false;
        end;
        if Rec."Type of Meeting/Function" = Rec."Type of Meeting/Function"::"External" then begin
            VisibleInternal := false;
            VisibleExternal := true;
        end;
        if Rec."Type of Meeting/Function" = Rec."Type of Meeting/Function"::" " then begin
            VisibleInternal := false;
            VisibleExternal := false;
        end;
    end;

    procedure InsertToPlanner()
    var
        AdminBookingsPlanner: Record "Admin Bookings Planner";
    begin


    end;

    // trigger OnAfterGetRecord()
    // begin
    //     PageEditable := true;

    //     if Rec.Status <> Rec.Status::Open then
    //         PageEditable := true;
    //     ForwardingEditable := false;

    //     if Rec.Status = Rec.Status::Approved then
    //         PageEditable := false;
    //     ForwardingEditable := true;

    //     if Rec.Status = Rec.Status::Pending then
    //         PageEditable := true;
    //     ForwardingEditable := fALSE;
    // end;

    var
        VisibleInternal: Boolean;
        VisibleExternal: Boolean;
        UserSetup: Record "User Setup";
        PageEdit: Boolean;
        VarVariant: Variant;
        OpenApprovalEntriesExist: boolean;
        DocMustbePending: Label 'This application request must be Pending';
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        Conferences: Record "Conf & Meeting Rooms List";
        PageEditable: Boolean;
        CaseTracker: Record "CF Tracker";
        CFPage: Page "DMU CF Page";
        CFStations: Record "CF Station Actions";
        Comments: Record Comments;
        ForwardingEditable: Boolean;
}
