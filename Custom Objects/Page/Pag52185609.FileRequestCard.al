namespace MNSProjectMwanga.MNSProjectMwanga;
using Microsoft.Foundation.Attachment;

page 52185609 "File Request Card"
{
    Caption = 'File Request Card';
    PageType = Card;
    SourceTable = "File Requests";
    PromotedActionCategories = 'Home,Process';

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = CurrPageEditable;
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
                field(Overdue; Rec.Overdue)
                {
                    Editable = false;

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
            }
            group(Location)
            {
                Editable = CurrPageEditable;
                Visible = false;

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

                field("File MVT User ID"; Rec."File Request User ID")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("File MVT Time"; Rec."File Request Time")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Current File Location"; Rec."Current File Location")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("File MVT Date"; Rec."File Request Date")
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
            part(Control1102755015; "File Locations")
            {
                SubPageLink = "Member No." = FIELD("File Number");
                ApplicationArea = Basic, Suite;
                Visible = false;
            }

        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = Const(52185814), "No." = field("Request Number");
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
                PromotedCategory = Process;
                Visible = true;// RejextedDoc;
                trigger OnAction()
                begin
                    Rec.TestField(status, Rec.Status::Open);

                    if not confirm('Are you sure you want to request file?') then exit;
                    Rec.Status := Rec.Status::Requested;
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
                PromotedCategory = Process;
                Visible = true;

                trigger OnAction()
                begin
                    Rec.TestField(Overdue, true);
                    if Rec.Status = Rec.Status::Open then
                        error('This action is not applicable to open documents.');
                    if Rec.Overdue = false then Error('This action is only applicable to overdue files.');
                    if not Confirm('Are you sure you want to recall this request?') then exit;
                    Rec.status := Rec.Status::Open;
                    Rec.Modify;
                    Message('Request opened scuccessfully.');
                end;
            }

            separator(Action3)
            {
            }

        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        DocumentControl;
        //File number not editable
        // if Rec."File Request User ID" <> '' then
        //     fieldeditable := false;
        // if Rec."File Request User ID" = '' then
        //     fieldeditable := true;

        //move to not editable if user not in same Dpt

        UserStations.Reset;
        UserStations.SetRange("User Id", Rec."File Request User ID");
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
    var
        MyNotification: Notification;
    begin

        DocumentControl;
        //IF "File MVT Date"<>0D THEN CurrPage.EDITABLE:=FALSE;
        /*IF Rec."File MVT User ID"<>'' THEN
          fieldeditable:=FALSE;
        IF Rec."File MVT User ID"='' THEN
          fieldeditable:=TRUE;*/
        //trigger OnValidate()

        //begin
        if Rec.Overdue = true then begin
            MyNotification.Message := 'This File Request is Overdue being held by' + ' ' + Rec."File Requested By" + ' ' + 'you may recall it.';
            MyNotification.Scope := NotificationScope::LocalScope;
            MyNotification.Send();
        end;
        //end;


    end;

    procedure DocumentControl()
    begin

        if Rec.Status <> Rec.Status::Open then begin
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
        FileMovementTracker: Record "File Location";
        ApprovalsSetup: Record "File Stations";
        RecallVisible: boolean;
        CurrPageEditable: Boolean;
        Showlist: Record "File Tracker";
        EntryNo: Integer;
        UserStations: Record "User Stations";
        MeminfoEdit: Boolean;

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
}


