page 52187237 "M-Smart Member Edit"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    UsageCategory = Administration;
    PromotedActionCategories = 'New,Process,Reports,Creation,Workflows,Views,M-Smart Actions,EDMS';
    SourceTable = "M-Smart Member Edit";
    Caption = 'M-Smart Member Edit Request';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Mwalimu Smart Document"; Rec."Mwalimu Smart Document")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    Editable = IsNotSentBackToMSmart;
                }
                field("Responsible Officer"; Rec."Responsible Officer")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Type of Edit"; Rec."Type of Edit")
                {
                    ApplicationArea = All;
                    Editable = IsNotSentBackToMSmart;
                }
                field("Edit Information"; Rec."Edit Information")
                {
                    ApplicationArea = All;
                    MultiLine = True;
                    Editable = IsNotSentBackToMSmart;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }

                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
            }
            group("M-Smart")
            {
                Caption = 'M-Smart Information';
                field("Sent Back to M-Smart"; Rec."Sent Back to M-Smart")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action("Edit Member")
            {
                ApplicationArea = All;
                Image = Edit;
                Promoted = true;
                PromotedCategory = New;
                Visible = (IsNotSentBackToMSmart and not (IsBBFUpdate)) and not ((Rec.Status = Rec.Status::Rejected));

                trigger OnAction()
                var
                    SystemEdits: Record "System Edits";
                    EditMember: Record Members;
                    SystemEditsCodeunit: Codeunit "System Editss";
                    Action: Option SetFilter,PostChanges;
                    RecRef: RecordRef;
                    NewRecRef: RecordRef;
                    SystemEditsPage: Page "System Edits Card";
                    EditsHelper: Record "Edits Helper";
                begin
                    SystemEdits.SetRange("M-Smart No", Rec."No.");

                    if SystemEdits.FindFirst then begin
                        Page.Run(Page::"System Edits Card", SystemEdits);

                    end else begin
                        SystemEdits.Reset;

                        SystemEdits.Init;

                        SystemEdits."Table ID" := database::Members;
                        SystemEdits.Validate("Table ID");

                        SystemEdits."M-Smart No" := Rec."No.";
                        SystemEdits."Request Source" := SystemEdits."Request Source"::"M-Smart";
                        SystemEdits.Status := SystemEdits.Status::Open;

                        IF SystemEdits.Insert(true) then begin
                            SystemEdits."Innitiating Officer" := 'Mwalimu Smart';
                            SystemEdits.Modify(true);

                            // Filters
                            SystemEditsCodeunit.Setfilters(SystemEdits."Table ID", SystemEdits."No.", false, Rec."Member No.");

                            EditMember.SetFilter("No.", Rec."Member No.");

                            // Set Filter Fields
                            // Record fields**
                            RecRef.Open(SystemEdits."Table ID");
                            RecRef.Copy(EditMember);
                            NewRecRef.Open(SystemEdits."Table ID");
                            NewRecRef.Copy(EditMember);
                            SystemEditsCodeunit.SetFilterFields(SystemEdits."Table ID", SystemEdits."No.", Action::SetFilter, RecRef, NewRecRef);

                            EditsHelper.Init();
                            EditsHelper."Record No." := Rec."Member No.";
                            EditsHelper."Edits Header No." := SystemEdits."No.";
                            EditsHelper.Insert();

                            EditMember.Reset;
                            EditMember.SetRange("No.", Rec."Member No.");

                            if EditMember.FindFirst() then begin
                                EditMember."Marked For Edits" := true;
                                EditMember.Modify();
                            end;

                            Page.Run(Page::"System Edits Card", SystemEdits);

                        end;
                    end;
                end;
            }

            action("Next of KIN")
            {
                ApplicationArea = Basic, Suite;
                Image = Relationship;
                Promoted = true;
                PromotedCategory = New;
                Caption = 'BBF/Nominee Update';
                Visible = (IsNotSentBackToMSmart and IsBBFUpdate) and not (Rec.Status = Rec.Status::Rejected);
                trigger OnAction()
                var
                    DepApplication: Record "Dependancies Applications";

                    SeriesSetup: Record "Credit Nos. Series";
                    NoSeriesMgt: Codeunit NoSeriesManagement;
                    NewNo: Code[20];
                    NewNoSeriesCode: Code[20];
                begin
                    DepApplication.SetRange("M-Smart No", Rec."No.");
                    DepApplication.SetFilter(Status, '=%1|%2', DepApplication.Status::Open, DepApplication.Status::Pending);

                    if DepApplication.FindFirst then begin
                        Page.Run(Page::"Dependancies Applications Card", DepApplication);

                    end else begin
                        DepApplication.Reset;

                        DepApplication.Init;

                        // SeriesSetup.Get;
                        // SeriesSetup.TestField(SeriesSetup."Dependancy Application Nos.");
                        // NoSeriesMgt.InitSeries(SeriesSetup."Dependancy Application Nos.", SeriesSetup."Dependancy Application Nos.", 0D, NewNo, NewNoSeriesCode);

                        // DepApplication."No." := NewNo;
                        // DepApplication."No. Series" := NewNoSeriesCode;
                        DepApplication."No." := Rec."No.";
                        DepApplication."No. Series" := '';
                        DepApplication."Source Application" := DepApplication."Source Application"::"Mwalimu Smart";

                        DepApplication."Application Date" := Today;
                        DepApplication."Application Time" := Time;
                        DepApplication."Account Type" := DepApplication."Account Type"::"Single Member Account";
                        DepApplication."Member No." := Rec."Member No.";
                        DepApplication.Validate("Member No.");
                        DepApplication.Description := Rec."Edit Information";
                        DepApplication."M-Smart No" := Rec."No.";
                        DepApplication."Auto Assign Task" := true;

                        DepApplication.Status := DepApplication.Status::Open;

                        if DepApplication.Insert(true) then begin
                            Page.Run(Page::"Dependancies Applications Card", DepApplication);

                        end;

                    end;
                end;
            }
            group("M-Smart Integration")
            {
                action("M-Smart Comment")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Comment;
                    Promoted = true;
                    PromotedCategory = Category7;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("No.");
                    RunPageView = where(Types = CONST(comment));
                    // RunPageMode = Create;

                    Visible = IsNotSentBackToMSmart and not (Rec.Status = Rec.Status::Rejected);
                }
                action("Send Back to M-Smart")
                {
                    ApplicationArea = all;
                    Image = Return;
                    Promoted = true;
                    PromotedCategory = Category7;

                    Visible = IsNotSentBackToMSmart and not (Rec.Status = Rec.Status::Rejected);

                    trigger OnAction()
                    var
                        Comments: Record Comments;
                    begin
                        Comments.Reset;
                        Comments.SetRange("Header No.", Rec."No.");
                        Comments.SetAscending("Entry No.", true);

                        if Comments.FindLast then begin
                            if (Comments."Commented By" <> UserId) then begin
                                Error('Comment is required before sending the application back to M-Smart');
                            end else begin
                                if Confirm('This application will be sent back to M-Smart for editing. Are you sure you want to proceed?') then begin
                                    Rec."Sent Back to M-Smart" := true;
                                    Rec.Modify;

                                    Message('Comment has been sent back to M-Smart');

                                    CurrPage.Close();
                                end;
                            end;
                        end else begin
                            Error('Comment is required before sending the application back to M-Smart');
                        end;
                    end;
                }
            }

            group("EDMS Integration")
            {
                action("Import")
                {
                    ApplicationArea = All;
                    Caption = 'Import File';
                    Promoted = true;
                    PromotedCategory = Category8;
                    Image = Import;

                    trigger OnAction()
                    var
                        Base64Convert: Codeunit "Base64 Convert";
                        TempBlob: Codeunit "Temp Blob";
                        InStr: InStream;
                        ApplicantMember: Record Members;

                        EDMSFunctions: Codeunit "EDMS Functions";
                        FileName: Text;
                        FileContentsB64: Text;

                        IDNumber: Text;
                        ApplicationType: Label 'ME'; // Member Edit
                        PFNumber: Text;
                    begin
                        if Rec."No." <> '' then begin
                            FileName := EDMSFunctions.PickEDMSFile(TempBlob);

                            TempBlob.CreateInStream(InStr);
                            FileContentsB64 := Base64Convert.ToBase64(InStr);

                            if FileContentsB64 <> '' then begin
                                UploadToEDMS(Rec, FileName, FileContentsB64);
                            end;
                        end else begin
                            Error('Application No. is required for EDMS document upload');
                        end;
                    end;
                }
                action("EDMS File List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = Category8;

                    trigger OnAction()
                    var
                        EDMSFiles: Record "EDMS Files";
                    begin
                        EDMSFiles.Reset;

                        if Rec."Mwalimu Smart Document" <> '' then begin
                            EDMSFiles.SetFilter("Application No.", '=%1|%2', Rec."No.", Rec."Mwalimu Smart Document");
                        end else begin
                            EDMSFiles.SetFilter("Application No.", '=%1', Rec."No.");
                        end;

                        EDMSFiles.SetRange("EDMS Data Class Name", EDMSFiles."EDMS Data Class Name"::MemberFile);

                        Page.Run(Page::"EDMS Files List", EDMSFiles);
                    end;
                }
            }

            group(Workflows)
            {
                action("Comment")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Comment;
                    Promoted = true;
                    PromotedCategory = Category5;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("No.");
                    RunPageView = where(Types = CONST(comment));
                    // RunPageMode = Create;

                    Visible = not (Rec.Status = Rec.Status::Rejected);
                }
                action(Cancel)
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Request';
                    Promoted = true;
                    PromotedCategory = Category5;
                    Image = Reject;

                    Visible = not (Rec.Status = Rec.Status::Rejected);

                    trigger OnAction()
                    var
                        Comments: Record Comments;
                    begin
                        Rec.TestField(Status, Rec.Status::Open);

                        Comments.Reset;
                        Comments.SetRange("Header No.", Rec."No.");
                        Comments.SetAscending("Entry No.", true);

                        if Comments.FindLast then begin
                            if (Comments."Commented By" <> UserId) then begin
                                Error('Comment is required before rejecting the application');
                            end else begin
                                if Confirm('Are you sure you want to reject this member edit request?') then begin
                                    Rec.Status := Rec.Status::Rejected;
                                    Rec.Modify(true);
                                    Message('Application rejected sucessfully.');

                                    CurrPage.Close();
                                end;
                            end;
                        end else begin
                            Error('Comment is required before rejecting the application');
                        end;
                    end;
                }

                action(Reopen)
                {
                    ApplicationArea = All;
                    Caption = 'Reopen Request';
                    Promoted = true;
                    PromotedCategory = Category5;
                    Image = ReOpen;

                    Visible = (Rec.Status = Rec.Status::Rejected);

                    trigger OnAction()
                    var
                        Comments: Record Comments;
                    begin
                        Rec.TestField(Status, Rec.Status::Rejected);

                        Rec.Status := Rec.Status::Open;
                        Rec.Modify(true);
                        Message('Application re-opened sucessfully.');
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if Rec."Sent Back to M-Smart" then begin
            IsNotSentBackToMSmart := false;
        end else begin
            IsNotSentBackToMSmart := true;
        end;


    end;

    procedure UploadToEDMS(Rec: Record "M-Smart Member Edit"; FileName: Text; FileContentsB64: Text)
    var
        ApplicantMember: Record Members;
        EDMSFunctions: Codeunit "EDMS Functions";

        IDNumber: Text;
        ApplicationType: Label 'ME'; // Member Edit
        PFNumber: Text;
    begin
        ApplicantMember.Reset;

        ApplicantMember.SetRange("No.", Rec."Member No.");

        if ApplicantMember.FindFirst then begin
            if ApplicantMember."Primary Identification Type" = ApplicantMember."Primary Identification Type"::"ID Number" then begin
                IDNumber := ApplicantMember."Primary Identification";
            end else
                if ApplicantMember."Secondary Identification Type" = ApplicantMember."Secondary Identification Type"::"ID Number" then begin
                    IDNumber := ApplicantMember."Secondary Identification";
                end else begin
                    IDNumber := ApplicantMember."Primary Identification";
                end;

            if ApplicantMember."Payroll/Staff No." <> '' then begin
                PFNumber := ApplicantMember."Payroll/Staff No.";
            end else begin
                PFNumber := IDNumber;
            end;

            EDMSFunctions.EDMSMemberFileUpload(
                IDNumber,
                ApplicantMember.Name,
                ApplicationType,
                PfNumber,
                ApplicantMember."No.",
                Rec."No.",
                FileName,
                FileContentsB64
            );
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        IsBBFUpdate := not (Rec."Type of Edit" = Rec."Type of Edit"::Biodata);
    end;

    var
        GlobalFunctions: Codeunit "Global Functions";
        IsNotSentBackToMSmart: Boolean;
        IsBBFUpdate: Boolean;
}