page 52186351 "File Tracker Card"
{
    //DeleteAllowed = false;
    //InsertAllowed = false;
    PageType = Card;
    SourceTable = "File Tracker";
    PromotedActionCategories = 'Home,Process,Report,Request,Issuing';

    layout
    {
        area(content)
        {
            group("File Request")
            {
                Editable = CurrPageEditable;
                Visible = RequestTabeditable;
                field("File Request Number"; Rec."File Request Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Request Number"; Rec."Request Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("File Type"; Rec."File Type")
                {
                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    var
                    begin
                        DocumentControl();
                    end;
                }
                field("File Number"; Rec."File Number")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'File/Member No.';
                    // Enabled = fieldeditable;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Member Name"; Rec."Member Name")
                {
                    Caption = 'Name';
                    Editable = MeminfoEdit;
                    ApplicationArea = Basic, Suite;
                }
                field("Folio Number"; Rec."Folio Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("File Request Remarks"; Rec."File Request Remarks")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field(Narration; Rec.Narration)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Other  Doc  No"; Rec."Other  Doc  No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = MeminfoEdit;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = MeminfoEdit;
                }
                field("File Requested By"; Rec."File Requested By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Requesting Department"; Rec."Responsibility Centre")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Defines the destination responsibility Center';
                    //Editable = false;
                }
                field("File Request Date"; Rec."File Request Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("File Request Status"; Rec."File Request Status")
                {
                    Editable = false;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        //Different Tabs Visibilit and therefore editability for different statuses
                        if Rec."File Request Status" = Rec."File Request Status"::Open then begin
                            RequestTabeditable := true;
                            TrackerTabEditable := false;
                            CurrPageEditable := true;
                            FileDetailsVisible := false;
                        end;
                        if Rec."File Request Status" = Rec."File Request Status"::Requested then begin
                            RequestTabeditable := true;
                            TrackerTabEditable := true;
                            CurrPageEditable := false;
                            FileDetailsVisible := true;
                        end;
                        if Rec."File Request Status" = Rec."File Request Status"::Issued then begin
                            RequestTabeditable := true;
                            TrackerTabEditable := true;
                            CurrPageEditable := false;
                            FileDetailsVisible := true;
                        end;
                        if Rec."File Request Status" = Rec."File Request Status"::Received then begin
                            RequestTabeditable := true;
                            TrackerTabEditable := true;
                            CurrPageEditable := false;
                            FileDetailsVisible := true;
                        end;
                        if Rec."File Request Status" = Rec."File Request Status"::Closed then begin
                            RequestTabeditable := true;
                            TrackerTabEditable := true;
                            CurrPageEditable := true;
                            FileDetailsVisible := true;
                        end;
                    end;
                }
                field("File Issued"; Rec."File Issued")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Overdue; Rec.Overdue)
                {
                    //Editable = false;

                    trigger OnValidate()
                    var
                        MyNotification: Notification;
                    begin
                        if Rec.Overdue = true then begin
                            MyNotification.Message := 'This File Request is Overdue, you may recall it.';
                            MyNotification.Scope := NotificationScope::LocalScope;
                            MyNotification.Send();
                        end;
                    end;
                }
                field("Date Closed"; Rec."Date Closed")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Date Overdue"; Rec."Date Overdue")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
            group("File Tracking")
            {
                Editable = CurrPageEditable;
                //Visible = TrackerTabEditable;
                Visible = false;
                // field("Request Number"; Rec."Request Number")
                // {
                //     ApplicationArea = Basic, Suite;

                // }
                // field("File Type"; Rec."File Type")
                // {
                //     ApplicationArea = Basic, Suite;
                //     trigger OnValidate()
                //     var
                //     begin
                //         DocumentControl();
                //     end;
                // }
                field("File Request No."; Rec."File Request No.")
                {

                }
                // field("File Number"; Rec."File Number")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'File/Member No.';
                //     Enabled = fieldeditable;

                //     trigger OnValidate()
                //     begin
                //         CurrPage.Update;
                //     end;
                // }
                // field("Member Name"; Rec."Member Name")
                // {
                //     Caption = 'Name';
                //     Editable = MeminfoEdit;
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Folio Number"; Rec."Folio Number")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("File Movement Remarks"; Rec."File Movement Remarks")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                // field(Narration; Rec.Narration)
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Other  Doc  No"; Rec."Other  Doc  No")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Action"; Rec.Action)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Office Name"; Rec."Office Name")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                // field(Overdue; Rec.Overdue)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Visible = false;
                // }
                // field("ID No."; Rec."ID No.")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = MeminfoEdit;
                // }
                // field("Loan No"; Rec."Loan No")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Visible = false;
                // }
                // field("Staff No"; Rec."Staff No")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = MeminfoEdit;
                // }
                field("File Created By"; Rec."File Created By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("File Creation Date"; Rec."File Creation Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Status"; Rec."Member Status")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Create; Rec.Create)
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("File Issued"; Rec."File Issued")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
            }
            group("File Details")
            {
                Editable = CurrPageEditable;
                Visible = TrackerTabEditable;

                field("Volume Entry No."; Rec."Volume Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("File No."; Rec."File No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("File Volume No."; Rec."File Volume No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("File Folio Number"; Rec."Folio Number")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Folio No.';
                }
                field("File Status"; Rec."File Status")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Building; Rec.Building)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Floor No."; Rec."Floor No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Town; Rec.Town)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
            group(Location)
            {
                Editable = CurrPageEditable;
                Visible = TrackerTabEditable;
                field("Move to"; Rec."Move to")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = TRUE;// MVEditable;
                }
                field("Sent To"; Rec."Sent To")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = TRUE;
                }
                field("Current Responsibility Centre"; Rec."Current Responsibility Centre")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Defines the current responsibility Center';
                    Editable = false;
                }
                field("Responsibility Centre"; Rec."Responsibility Centre")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Defines the destination responsibility Center';
                    Editable = false;
                }

                field("File MVT User ID"; Rec."File MVT User ID")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("File MVT Time"; Rec."File MVT Time")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Current File Location"; Rec."Current File Location")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("File MVT Date"; Rec."File MVT Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("File received date"; Rec."File received date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("File received Time"; Rec."File received Time")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("File Received by"; Rec."File Received by")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("File Received"; Rec."File Received")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                // field(Status; Rec.Status)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                // }

                field("File Recalled"; Rec."File Recalled")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = false;
                }

                field("File  Forwarded"; Rec."File  Forwarded")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
            group("To Archives")
            {
                Visible = TrackerTabEditable;
                field("Return To Archive"; Rec."Return To Archive")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Return Date"; Rec."Return Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Returned By"; Rec."Returned By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }


            }
            part(Control1102755015; "File Locations")
            {
                SubPageLink = "Member No." = FIELD("File Number");
                ApplicationArea = Basic, Suite;
                Visible = TrackerTabEditable;
                // Editable = CurrPageEditable;
                // Visible = TrackerTabEditable;
            }
        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")//"Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = Const(52186080), "No." = field("File Request Number");//52186080
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(SendRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Request File';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = true;// RejextedDoc;
                trigger OnAction()
                begin
                    Rec.TestField(status, Rec."File Request Status"::Open);

                    if not confirm('Are you sure you want to request file?') then exit;
                    Rec."File Request Status" := Rec."File Request Status"::Requested;
                    //Rec.Status := Rec.Status::"Being Processed";
                    Rec."File Request Date" := today;
                    Rec."File Request Time" := time;
                    Rec."File Request User ID" := UserId;
                    Rec.Modify();
                    Message('File Requested.');
                end;
            }

            action("Recall File")
            {
                ApplicationArea = Basic, Suite;
                Image = VoidCheck;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = true;

                trigger OnAction()
                begin
                    Rec.TestField(Overdue, true);
                    if Rec."File Request Status" = Rec."File Request Status"::Open then
                        error('This action is not applicable to open documents.');
                    if Rec.Overdue = false then Error('This action is only applicable to overdue files.');
                    if not Confirm('Are you sure you want to recall this request?') then exit;
                    begin
                        FileLocation.RESET;
                        FileLocation.SetRange("Member No.", Rec."File Number");
                        if FileLocation.FindFirst() then begin
                            //UserSetup.GET(UserId);
                            UserSetup.Get(FileLocation."USER ID");
                            msg := 'Dear ' + UserSetup."Full Name" + ',<br><br>' + 'This is to inform you that the file request for ' + Rec."File Number" + 'which you requested on the '
                            + FORMAT(Rec."File Request Date") + ' ' + 'is overdue. Please take necessary action to avail it back to Records Department.<br><br>Regards,<br>Records Department.';
                            EmailManager.Create(UserSetup."E-Mail", 'Contract Execution', msg, true);
                            Email.Send(EmailManager, Enum::"Email Scenario"::Default);
                            Message('Email Sent Successfully');
                        end;
                    end;
                    Rec."File Request Status" := Rec."File Request Status"::Open;
                    Rec.Modify;
                    Message('Request opened scuccessfully.');
                end;
            }
            action("Issues Files")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Issue File';
                Promoted = true;
                PromotedCategory = Category5;
                Visible = RejextedDoc;

                trigger OnAction()
                begin
                    Rec.TestField("File Request Status", Rec."File Request Status"::Requested);
                    Rec.TestField("Volume Entry No.");
                    Rec.TestField("Move to");
                    //if Rec.Create = false then Error(ErrorFileNotCreated);
                    if Rec."File Issued" = true then Error(AlreadyIssued);


                    UserStations.Reset;
                    UserStations.SetRange(UserStations."User Id", UserId);
                    if UserStations.Find('-') then
                        if UserStations."Can Issue" = false then
                            Error(OnlyUsersError);

                    // Rec.TestField("Sent To");
                    // Rec.TestField("Folio Number");
                    // Rec.TestField(Narration);
                    // Rec.TestField("File Movement Remarks");

                    //MESSAGE(SureIssue,Rec."Member Name");
                    if Confirm(SureIssue) = true then begin
                        Rec."File MVT User ID" := UserId;
                        Rec."File MVT Time" := Time;
                        Rec."File MVT Date" := Today;
                        Rec.Action := Rec.Action::Issued;
                        Rec."File Issued" := true;
                        Rec."File Request Status" := Rec."File Request Status"::Issued;
                    end;


                    //get the location of the issurer
                    UserStations.Reset;
                    UserStations.SetRange(UserStations."User Id", Rec."File MVT User ID");
                    if UserStations.Find('-') then begin
                        CurrMoveTo := UserStations."Station Code";
                        CurrLocation := UserStations."Station Name";
                        RespCentre := UserStations."Responsibility Center";
                    end;

                    FileRequest.Reset();
                    FileRequest.SetRange("Request Number", Rec."File Request No.");
                    if FileRequest.Find('-') then begin
                        FileRequest.Status := FileRequest.Status::Closed;
                        FileRequest."File Issued" := true;
                        FileRequest.Modify()
                    end;

                    //create a record in file movement location
                    ApprovalsSetup.Reset;
                    ApprovalsSetup.SetRange(ApprovalsSetup."Station Code", Rec."Move to");
                    if ApprovalsSetup.Find('-') then begin
                        FileMovementTracker.Reset;
                        FileMovementTracker.SetCurrentKey("Entry No.");
                        if FileMovementTracker.Find('+') then
                            EntryNo := FileMovementTracker."Entry No." + 1;
                        FileMovementTracker.Init;
                        FileMovementTracker."Entry No." := EntryNo;
                        FileMovementTracker."Member No." := Rec."File Number";
                        FileMovementTracker."Section Code" := CurrMoveTo/*"Move to"*/;
                        FileMovementTracker."Current Location" := false;
                        FileMovementTracker."Station Name" := CurrLocation/*"Sent To"*/;
                        FileMovementTracker.Station := ApprovalsSetup."Station Code";
                        FileMovementTracker."Responsibility Centre" := RespCentre;
                        FileMovementTracker."Responsibility Centre" := ApprovalsSetup."Responsibility Centre";
                        FileMovementTracker."Date/Time In" := CreateDateTime(Today, Time);
                        FileMovementTracker."USER ID" := UserId;
                        FileMovementTracker.Remarks := Format(Rec."File Movement Remarks");
                        FileMovementTracker.Status := Rec.Status;
                        FileMovementTracker."Current Location" := true;
                        //FileMovementTracker."Date/Time Out":=CURRENTDATETIME;
                        FileMovementTracker.Folio := Rec."Folio Number";
                        FileMovementTracker.Narration := Rec.Narration;
                        FileMovementTracker."Issued To" := Rec."Sent To";
                        FileMovementTracker.Insert(true);
                        Rec."Current Responsibility Centre" := ApprovalsSetup."Responsibility Centre";
                        Rec.modify;


                        FileVolumes.RESET;
                        FileVolumes.SETRANGE("Volume Entry No.", Rec."Volume Entry No.");
                        if FileVolumes.Find('-') then begin
                            FileVolumes."Volume Status" := FileVolumes."Volume Status"::Issued;
                            FileVolumes.MODIFY;
                        end
                    end;
                end;
            }
            separator(Action1000000032)
            {
            }
            action("File  Received")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Receive File';
                Image = Receipt;
                Promoted = true;
                PromotedCategory = Category5;
                Visible = RejextedDoc;

                trigger OnAction()
                begin
                    Rec.TestField("Sent To");
                    if Rec."File Received" = true then Error(AlreadyReceived, Rec."File Received by");

                    //error if one not in department sent to and tries to receive
                    UserStations.Reset;
                    UserStations.SetRange(UserStations."User Id", UserId);
                    if UserStations.Find('-') then
                        if UserStations."Station Code" <> Rec."Move to" then
                            Error(NotAllowedReceive, Rec."Sent To");


                    //Rec.TestField("File Movement Remarks");
                    Rec.Action := Rec.Action::Received;
                    Rec."File Request Status" := Rec."File Request Status"::Received;

                    if Confirm(SureRecieve) = false then
                        exit;
                    FileMovementTracker.Reset;
                    FileMovementTracker.SetRange(FileMovementTracker."Member No.", Rec."File Number");
                    if FileMovementTracker.Find('-') then begin
                        repeat
                            FileMovementTracker."Current Location" := false;
                            //FileMovementTracker.Status:=FileMovementTracker.Status::Forwarded;

                            FileMovementTracker.Modify;
                        until FileMovementTracker.Next = 0;
                    end;

                    //Modify date out
                    FileMovementTracker.Reset;
                    FileMovementTracker.SetRange("Member No.", Rec."File Number");
                    if FileMovementTracker.Find('+') then begin
                        FileMovementTracker."Date/Time Out" := CurrentDateTime;
                        FileMovementTracker.Status := FileMovementTracker.Status::Forwarded;
                        FileMovementTracker.Modify;
                    end;

                    ApprovalsSetup.Reset;
                    ApprovalsSetup.SetRange(ApprovalsSetup."Station Code", Rec."Move to");
                    if ApprovalsSetup.Find('-') then begin
                        FileMovementTracker.Reset;
                        FileMovementTracker.SetCurrentKey("Entry No.");
                        if FileMovementTracker.Find('+') then
                            EntryNo := FileMovementTracker."Entry No." + 1;
                        FileMovementTracker.Init;
                        FileMovementTracker."Entry No." := EntryNo;
                        FileMovementTracker."Member No." := Rec."File Number";
                        FileMovementTracker."Section Code" := Rec."Move to";
                        FileMovementTracker."Current Location" := false;
                        FileMovementTracker."Station Name" := Rec."Sent To";
                        FileMovementTracker.Station := ApprovalsSetup."Station Code";
                        FileMovementTracker."Date/Time In" := CreateDateTime(Today, Time);
                        FileMovementTracker."USER ID" := UserId;
                        FileMovementTracker.Remarks := Format(Rec."File Movement Remarks");
                        FileMovementTracker.Status := FileMovementTracker.Status::"Being Processed";
                        FileMovementTracker."Current Location" := true;
                        //FileMovementTracker."Date/Time Out":=CURRENTDATETIME;
                        FileMovementTracker.Folio := Rec."Folio Number";
                        FileMovementTracker.Narration := Rec.Narration;
                        FileMovementTracker.Insert(true);

                    end;

                    Rec."File received date" := Today;
                    Rec."File received Time" := Time;
                    Rec."File Received by" := UserId;
                    Rec."File Received" := true;
                    Rec."Folio Number" := '';
                    Rec.Narration := '';
                    Rec."File Movement Remarks" := '';
                    Rec."Move to" := '';
                    Rec."Sent To" := '';
                    Rec."File MVT User ID" := UserId;
                    Rec."File  Forwarded" := false;
                    UserStations.Reset;
                    UserStations.SetRange(UserStations."User Id", UserId);
                    if UserStations.Find('-') then begin
                        Rec."Responsibility Centre" := UserStations."Responsibility Center";
                        Rec."Current Responsibility Centre" := UserStations."Responsibility Center";
                    end;

                    CurrPage.Update;
                end;
            }
            action("File Received Back")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Receive File Back';
                Image = Receipt;
                Promoted = true;
                PromotedCategory = Category5;
                Visible = RejextedDoc;

                trigger OnAction()
                begin
                    Rec.TestField("Sent To");
                    if Rec."File Request Status" <> Rec."File Request Status"::"Closed" then begin
                        //     if Rec."File Received" = true then Error(AlreadyReceived, Rec."File Received by");
                        // end
                        // else begin
                        //error if one not in department sent to and tries to receive
                        UserStations.Reset;
                        UserStations.SetRange(UserStations."User Id", UserId);
                        if UserStations.Find('-') then
                            if UserStations."Station Code" <> Rec."Move to" then
                                Error(NotAllowedReceive, Rec."Sent To");


                        //Rec.TestField("File Movement Remarks");
                        Rec.Action := Rec.Action::Received;
                        Rec."File Request Status" := Rec."File Request Status"::Received;

                        if Confirm(SureRecieve) = false then
                            exit;
                        FileMovementTracker.Reset;
                        FileMovementTracker.SetRange(FileMovementTracker."Member No.", Rec."File Number");
                        if FileMovementTracker.Find('-') then begin
                            repeat
                                FileMovementTracker."Current Location" := false;
                                //FileMovementTracker.Status:=FileMovementTracker.Status::Forwarded;

                                FileMovementTracker.Modify;
                            until FileMovementTracker.Next = 0;
                        end;

                        //Modify date out
                        FileMovementTracker.Reset;
                        FileMovementTracker.SetRange("Member No.", Rec."File Number");
                        if FileMovementTracker.Find('+') then begin
                            FileMovementTracker."Date/Time Out" := CurrentDateTime;
                            FileMovementTracker.Status := FileMovementTracker.Status::Forwarded;
                            FileMovementTracker.Modify;
                        end;

                        ApprovalsSetup.Reset;
                        ApprovalsSetup.SetRange(ApprovalsSetup."Station Code", Rec."Move to");
                        if ApprovalsSetup.Find('-') then begin
                            FileMovementTracker.Reset;
                            FileMovementTracker.SetCurrentKey("Entry No.");
                            if FileMovementTracker.Find('+') then
                                EntryNo := FileMovementTracker."Entry No." + 1;
                            FileMovementTracker.Init;
                            FileMovementTracker."Entry No." := EntryNo;
                            FileMovementTracker."Member No." := Rec."File Number";
                            FileMovementTracker."Section Code" := Rec."Move to";
                            FileMovementTracker."Current Location" := false;
                            FileMovementTracker."Station Name" := Rec."Sent To";
                            FileMovementTracker.Station := ApprovalsSetup."Station Code";
                            FileMovementTracker."Date/Time In" := CreateDateTime(Today, Time);
                            FileMovementTracker."USER ID" := UserId;
                            FileMovementTracker.Remarks := Format(Rec."File Movement Remarks");
                            FileMovementTracker.Status := FileMovementTracker.Status::"Being Processed";
                            FileMovementTracker."Current Location" := true;
                            //FileMovementTracker."Date/Time Out":=CURRENTDATETIME;
                            FileMovementTracker.Folio := Rec."Folio Number";
                            FileMovementTracker.Narration := Rec.Narration;
                            FileMovementTracker.Insert(true);

                        end;

                        Rec."File received date" := Today;
                        Rec."File received Time" := Time;
                        Rec."File Received by" := UserId;
                        Rec."File Received" := true;
                        Rec."Folio Number" := '';
                        Rec.Narration := '';
                        Rec."File Movement Remarks" := '';
                        Rec."Move to" := '';
                        Rec."Sent To" := '';
                        Rec."File MVT User ID" := UserId;
                        Rec."File  Forwarded" := false;
                        UserStations.Reset;
                        UserStations.SetRange(UserStations."User Id", UserId);
                        if UserStations.Find('-') then begin
                            Rec."Responsibility Centre" := UserStations."Responsibility Center";
                            Rec."Current Responsibility Centre" := UserStations."Responsibility Center";
                        end;

                        CurrPage.Update;
                    end;
                end;
            }
            separator(Action1000000030)
            {
            }
            // action("Recall File")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = VoidCheck;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     Visible = false;

            //     trigger OnAction()
            //     begin
            //         /*IF  "File Received" =TRUE THEN BEGIN
            //          ERROR('YOU CANNOT RECALL RECEIVED FILE');
            //          END;

            //         TESTFIELD("File Movement Remarks");

            //         "File received date":=TODAY;
            //         "File received Time":=TIME;
            //         "File Received by":=USERID;
            //         "File Recalled":= TRUE;
            //         Action:=Action::"Open ";
            //         */

            //     end;
            // }
            separator(Action1000000028)
            {
            }
            action(Forward)
            {
                ApplicationArea = Basic, Suite;
                Image = SendEmailPDF;
                Promoted = true;
                PromotedCategory = Category5;
                Visible = RejextedDoc;

                trigger OnAction()
                begin
                    /*IF "File Received by" <> USERID THEN BEGIN
                    ERROR('You are not Allowed to forward  this file only '+Rec."File Received by"+ ' can  forward  the file');
                    END;*/
                    //TESTFIELD("Move to");
                    if Rec."File  Forwarded" = true then Error(AlreadyForwarded, Rec."Sent To");

                    if Rec."File Received" = true then begin
                        UserStations.Reset;
                        UserStations.SetRange(UserStations."User Id", Rec."File Received by");
                        if UserStations.Find('-') then begin
                            UserStationCode := UserStations."Station Code";
                            UserStationName := UserStations."Station Name";
                            RespCentre := UserStations."Responsibility Center";
                        end;

                        UserStations.Reset;
                        UserStations.SetRange(UserStations."User Id", UserId);
                        if UserStations.Find('-') then
                            if UserStations."Station Code" <> UserStationCode then
                                Error(ForwardError, UserStationName);
                    end;

                    Rec.TestField("File received date");
                    Rec.TestField("File received Time");
                    Rec.TestField("File Received by");
                    Rec.TestField("Folio Number");
                    Rec.TestField("Move to");
                    Rec.TestField("File Movement Remarks");
                    Rec.TestField(Narration);
                    Rec.Status := Rec.Status::Processed;


                    if Confirm(ConfirmForward) = false then
                        exit
                    else begin

                        Rec."File received date" := Today;
                        Rec."File received Time" := Time;
                        Rec."File Received by" := UserId;
                        Rec.Action := Rec.Action::Forwarded;

                        Rec."Request Number" := Rec."Request Number";
                        Rec."File Number" := Rec."File Number";
                        Rec."Folio Number" := Rec."Folio Number";
                        Rec."File MVT User ID" := Rec."Sent To";
                        Rec."Loan No" := Rec."Loan No";
                        Rec."Other  Doc  No" := Rec."Other  Doc  No";
                        Rec."File MVT Date" := Rec."File MVT Date";
                        Rec."File MVT Time" := Rec."File MVT Time";
                        Rec."File received date" := 0D;
                        Rec."File received Time" := 0T;
                        Rec."File Received by" := '';
                        Rec."File Received" := false;
                        Rec."File  Forwarded" := true;
                        ApprovalsSetup.Reset;
                        ApprovalsSetup.SetRange(ApprovalsSetup."Station Code", Rec."Move to");
                        if ApprovalsSetup.Find('-') then begin
                            rec."Responsibility Centre" := ApprovalsSetup."Responsibility Centre";
                            Rec."Current Responsibility Centre" := ApprovalsSetup."Responsibility Centre";
                        end;
                        Rec."File MVT User ID" := Rec."File Received by";
                        Rec.Action := Rec.Action;
                        Rec.Action := Rec.Action::Forwarded;
                        Rec.Modify;

                        Rec."File MVT User ID" := UserId;
                        Rec."File MVT Time" := Time;
                        Rec."File MVT Date" := Today;
                        Rec.Action := Rec.Action::Forwarded;

                        FileMovementTracker.Reset;
                        FileMovementTracker.SetRange(FileMovementTracker."Member No.", Rec."File Number");
                        if FileMovementTracker.Find('-') then begin
                            repeat
                                FileMovementTracker."Current Location" := false;
                                FileMovementTracker.Modify;
                            until FileMovementTracker.Next = 0;
                        end;

                        ApprovalsSetup.Reset;
                        ApprovalsSetup.SetRange(ApprovalsSetup."Station Code", Rec."Move to");
                        if ApprovalsSetup.Find('-') then begin
                            FileMovementTracker.Reset;
                            FileMovementTracker.SetCurrentKey("Entry No.");
                            if FileMovementTracker.Find('+') then
                                EntryNo := FileMovementTracker."Entry No." + 1;
                            FileMovementTracker.Init;
                            FileMovementTracker."Entry No." := EntryNo;
                            FileMovementTracker."Member No." := Rec."File Number";
                            FileMovementTracker."Section Code" := Rec."Move to";
                            FileMovementTracker."Current Location" := false;
                            FileMovementTracker."Station Name" := Rec."Sent To";
                            FileMovementTracker.Station := ApprovalsSetup."Station Code";
                            FileMovementTracker."Date/Time In" := CreateDateTime(Today, Time);
                            FileMovementTracker."USER ID" := UserId;
                            FileMovementTracker.Remarks := Format(Rec."File Movement Remarks");
                            FileMovementTracker.Status := FileMovementTracker.Status::Forwarded;
                            FileMovementTracker."Current Location" := true;
                            //FileMovementTracker."Date/Time Out":=CURRENTDATETIME;
                            FileMovementTracker.Folio := Rec."Folio Number";
                            FileMovementTracker.Narration := Rec.Narration;
                            FileMovementTracker."Responsibility Centre" := ApprovalsSetup."Responsibility Centre";
                            FileMovementTracker.Insert(true);

                        end;
                        Message(ForwadMessage, Rec."Sent To");
                        Rec."File  Forwarded" := true;
                        CurrPage.Update;
                    end;

                    CurrPage.Close;

                end;
            }
            action("Close Request")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Close Request';
                Image = Close;
                Promoted = true;
                PromotedCategory = Category5;
                Visible = RejextedDoc;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Rec.TestField(Rec."Move to");
                    Rec.TestField(Rec."Sent To");

                    if Confirm('Do you Want to Close this Request?') = false then
                        exit
                    else begin

                        FileLocation.RESET;
                        FileLocation.SetRange("Member No.", Rec."File Number");
                        if FileLocation.FindFirst() then begin
                            if FileLocation."Section Code" <> Rec."Sent To" then
                                Error('You Can Only Return This File to: %1', FileLocation."Section Code");
                        end
                        else begin
                            ApprovalsSetup.Reset;
                            ApprovalsSetup.SetRange(ApprovalsSetup."Station Code", Rec."Move to");
                            if ApprovalsSetup.Find('-') then begin
                                FileMovementTracker.Reset;
                                FileMovementTracker.SetCurrentKey("Entry No.");
                                if FileMovementTracker.Find('+') then
                                    EntryNo := FileMovementTracker."Entry No." + 1;
                                FileMovementTracker.Init;
                                FileMovementTracker."Entry No." := EntryNo;
                                FileMovementTracker."Member No." := Rec."File Number";
                                FileMovementTracker."Section Code" := Rec."Move to";
                                FileMovementTracker."Current Location" := false;
                                FileMovementTracker."Station Name" := Rec."Sent To";
                                FileMovementTracker.Station := ApprovalsSetup."Station Code";
                                FileMovementTracker."Date/Time In" := CreateDateTime(Today, Time);
                                FileMovementTracker."USER ID" := UserId;
                                FileMovementTracker.Remarks := Format(Rec."File Movement Remarks");
                                FileMovementTracker.Status := FileMovementTracker.Status::Forwarded;
                                FileMovementTracker."Current Location" := true;
                                //FileMovementTracker."Date/Time Out":=CURRENTDATETIME;
                                FileMovementTracker.Folio := Rec."Folio Number";
                                FileMovementTracker.Narration := Rec.Narration;
                                FileMovementTracker."Responsibility Centre" := ApprovalsSetup."Responsibility Centre";
                                FileMovementTracker.Insert(true);

                            end;
                            Message(ForwadMessage, Rec."Sent To");
                            Rec."File  Forwarded" := true;
                            CurrPage.Update;
                        end;

                        CurrPage.Close;

                    end;

                    FileVolumes.RESET;
                    FileVolumes.SETRANGE("Volume Entry No.", Rec."Volume Entry No.");
                    if FileVolumes.Find('-') then begin
                        FileVolumes."Volume Status" := FileVolumes."Volume Status"::"In Custody";
                        FileVolumes.MODIFY;
                    end;

                    Rec."File Request Status" := Rec."File Request Status"::Closed;
                    Rec."Date Closed" := Today;
                    Rec.Modify;
                    Message('Request Closed Successfully.');
                end;
                //end;
            }

            action(Archive)
            {
                ApplicationArea = Basic, Suite;
                Image = SendEmailPDF;
                Promoted = true;
                PromotedCategory = Process;
                //Visible = RejextedDoc;
                Visible = false;

                trigger OnAction()
                begin

                    if not confirm('Are you sure you want to archive this document?') then exit;
                    Rec.Status := Rec.Status::Archived;
                    Rec.Modify();
                    Message('File Archived.');
                end;

            }
            action(RetrieveArchive)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Retrieve from Archives';
                Image = ReopenCancelled;
                Promoted = true;
                PromotedCategory = Process;
                Visible = RecallVisible;

                trigger OnAction()
                begin

                    Rec.TestField(Status, Rec.Status::Archived);
                    if not confirm('Are you sure you want to retrieve this document?') then exit;

                    UserStations.Reset;
                    UserStations.SetRange(UserStations."User Id", UserId);
                    if UserStations.Find('-') then begin
                        Rec."Move to" := UserStations."Station Code";
                        Rec."Sent To" := UserStations."Station Code";
                        Rec.Status := Rec.Status::"Being Processed";
                        Rec."Responsibility Centre" := UserStations."Responsibility Center";
                        Rec."Current Responsibility Centre" := UserStations."Responsibility Center";
                        Rec.Modify();
                        Message('File Retrieved Sucessfully.');
                    end;

                end;


            }
            separator(Action3)
            {
            }
            action("New File")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Create New File';
                Image = New;
                Promoted = true;
                PromotedCategory = Process;
                //Visible = RejextedDoc;
                Visible = false;

                trigger OnAction()
                begin
                    if Rec.Create = true then
                        Error(AlreadyCreated, Rec."File Created By");

                    //Check if user is in Registry
                    UserStations.Reset;
                    UserStations.SetRange(UserStations."User Id", UserId);
                    if UserStations.Find('-') then begin
                        if UserStations."Can Create New" = false then
                            Error(UserPermision);


                        if Confirm(CreateFile) = false then exit;
                        Rec."File MVT User ID" := UserId;
                        Rec."File Creation Date" := Today;
                        Rec."File Created By" := UserId;
                        Rec.Create := true;
                        Rec."Current Responsibility Centre" := UserStations."Responsibility Center";
                        Rec."Responsibility Centre" := UserStations."Responsibility Center";
                        Rec.modify;
                        CurrPage.Update;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        DocumentControl;
        //File number not editable
        if Rec."File MVT User ID" <> '' then
            fieldeditable := false;
        if Rec."File MVT User ID" = '' then
            fieldeditable := true;

        //move to not editable if user not in same Dpt

        UserStations.Reset;
        UserStations.SetRange("User Id", Rec."File MVT User ID");
        if UserStations.FindFirst then begin
            MvtUserStationName := UserStations."Station Name";
        end;

        UserStations.Reset;
        UserStations.SetRange("User Id", UserId);
        if UserStations.FindFirst then begin
            if UserStations."Station Name" <> MvtUserStationName then
                MVEditable := false
            else
                if UserStations."Station Name" = MvtUserStationName then
                    MVEditable := true;
        end;

        /*IF Rec."File MVT User ID"<>USERID THEN
          MVEditable:=FALSE;
        IF Rec."File MVT User ID"=USERID THEN
          MVEditable:=TRUE;
        IF Rec."File Received"=TRUE THEN
          MVEditable:=FALSE*/

    end;

    trigger OnAfterGetRecord()
    begin

        /*IF "File MVT User ID"='' THEN
          fieldeditable:=TRUE;*/
        DocumentControl();

    end;

    trigger OnOpenPage()
    begin
        DocumentControl;
        //IF "File MVT Date"<>0D THEN CurrPage.EDITABLE:=FALSE;
        /*IF Rec."File MVT User ID"<>'' THEN
          fieldeditable:=FALSE;
        IF Rec."File MVT User ID"='' THEN
          fieldeditable:=TRUE;*/


    end;

    procedure DocumentControl()
    begin
        RequestTabeditable := false;
        TrackerTabEditable := false;
        FileDetailsVisible := false;
        // if Rec."File Request Status" = Rec."File Request Status"::Open then begin
        //     RequestTabeditable := true;
        //     TrackerTabEditable := false;
        // end;
        // if Rec."File Request Status" = Rec."File Request Status"::Requested then begin
        //     RequestTabeditable := true;
        //     TrackerTabEditable := false;
        // end;
        if Rec."File Request Status" = Rec."File Request Status"::Open then begin
            RequestTabeditable := true;
            TrackerTabEditable := false;
            CurrPageEditable := true;
            FileDetailsVisible := false;
        end;
        if Rec."File Request Status" = Rec."File Request Status"::Requested then begin
            RequestTabeditable := true;
            TrackerTabEditable := true;
            CurrPageEditable := false;
            FileDetailsVisible := true;
        end;
        if Rec."File Request Status" = Rec."File Request Status"::Issued then begin
            RequestTabeditable := true;
            TrackerTabEditable := true;
            CurrPageEditable := false;
            FileDetailsVisible := true;
        end;
        if Rec."File Request Status" = Rec."File Request Status"::Received then begin
            RequestTabeditable := true;
            TrackerTabEditable := true;
            CurrPageEditable := false;
            FileDetailsVisible := true;
        end;
        if Rec."File Request Status" = Rec."File Request Status"::Closed then begin
            RequestTabeditable := true;
            TrackerTabEditable := true;
            CurrPageEditable := true;
            FileDetailsVisible := true;
        end;

        if Rec.Status = Rec.Status::Archived then begin
            CurrPageEditable := false;
            RejextedDoc := false;
            RecallVisible := true;
        end else begin
            CurrPageEditable := true;
            RejextedDoc := true;
            RecallVisible := false;
        end;
        if Rec."File Type" = Rec."File Type"::"Member File" then
            MeminfoEdit := false else
            MeminfoEdit := true;
    end;

    var
        RequestTabeditable: Boolean;
        TrackerTabEditable: Boolean;
        FileMovementTracker: Record "File Location";
        ApprovalsSetup: Record "File Stations";
        RecallVisible: boolean;
        CurrPageEditable: Boolean;
        Showlist: Record "File Tracker";
        EntryNo: Integer;
        UserStations: Record "User Stations";
        MeminfoEdit: Boolean;
        FileRequest: record "File Requests";
        fieldeditable: Boolean;
        FileAlreadyIssued: Label 'File has Already been issued to %1';
        SureIssue: Label 'Are you sure you want to issue file';
        NotAllowedReceive: Label 'You are not allowed to receive files sent to %1 Section';
        SureRecieve: Label 'Are you sure you want to receive this file?';
        ErrorForward: Label 'This file is in %1 and can only be forwarded by %2 users';

        MVEditable: Boolean;
        AlreadyCreated: Label 'File already created by %1';
        UserPermision: Label 'Only users with Create New permission can Create a new file';
        CreateFile: Label 'Are you sure you want to create the new file';
        ErrorFileNotCreated: Label 'File is not Created';
        CurrMoveTo: Code[10];
        CurrLocation: Text;
        RespCentre: Text;
        DateOut: DateTime;
        UserStationCode: Code[10];
        UserStationName: Text;
        MvtUserStationName: Text;
        AlreadyIssued: Label 'File Already Issued';
        OnlyUsersError: Label 'Only users in Registry can Issue a file';
        AlreadyReceived: Label 'File ALready Received by %1';
        AlreadyForwarded: Label 'File Has already been Forwaded to %1';
        ForwardError: Label 'File can only be forwarded by users in %1';
        ConfirmForward: Label 'Are you sure you want to forward the file to the selected section?';
        ForwadMessage: Label 'File has been fowarded to %1';
        RejextedDoc: Boolean;
        FileVolumes: Record "File Volumes";
        FileDetailsVisible: Boolean;
        FileLocation: Record "File Location";
        FileDueDate: Date;
        usermail: Text;
        username: text;
        EmailManager: Codeunit "Email Message";
        Email: Codeunit Email;
        UserSetup: Record "User Setup";
        msg: Text;
}

