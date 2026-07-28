page 52185840 "Checkoff Header"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Checkoff Header";
    PromotedActionCategories = 'New,Process,Reports,Approvals,,Report,EDMS,MKey';

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = EditGeneral;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("CheckOff Type"; Rec."CheckOff Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = EditCheckoff;
                    ShowMandatory = true;
                }

                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = EditCheckoff;
                    ShowMandatory = true;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                    ValuesAllowed = Customer;
                    Editable = EditCheckoff;
                }

                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = EditCheckoff;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = EditCheckoff;
                }
                field("Posting Period"; Rec."Posting Period")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Loan Cutoff Date"; Rec."Loan Cutoff Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = EditCheckoff;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Time Entered"; Rec."Time Entered")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                // field("Vendor No"; Rec."Vendor No")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    ShowMandatory = true;
                    Visible = false;
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = EditCheckoff;
                    ShowMandatory = true;
                }
                field("Scheduled Amount"; Rec."Scheduled Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = EditCheckoff;
                }
                field("Total Count"; Rec."Total Count")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Count Not Validated"; Rec."Total Count Not Validated")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posted Records"; Rec."Posted Records")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Sms Sent"; Rec."Sms Sent")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
            part(Control22; "Checkoff Lines")
            {
                ApplicationArea = Basic;
                Editable = EditCheckoff;
                SubPageLink = "Checkoff Header" = FIELD("No.");
            }
        }
        area(factboxes)
        {
            systempart(Control19; Outlook)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control20; Notes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control21; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(processing)
        {



            //
            action("Import Checkoff")
            {
                ApplicationArea = Basic, Suite;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //Enabled = EditGeneral;
                trigger OnAction()
                var

                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    if Rec."CheckOff Type" = Rec."CheckOff Type"::" " then
                        Error('Ensure checkoff type is selected before proceeding.');

                    if Rec."CheckOff Type" = Rec."CheckOff Type"::Savings then
                        Xmlport.Run(xmlport::"Savings BP", true, true)
                    else
                        if Rec."CheckOff Type" = Rec."CheckOff Type"::Loans then
                            Xmlport.Run(xmlport::"Loans BP", true, true) else
                            if (Rec."CheckOff Type" = Rec."CheckOff Type"::"Short term Loans") or (Rec."CheckOff Type" = Rec."CheckOff Type"::"Long term Loans") then
                                Xmlport.Run(xmlport::"Lumpsum BP", true, true) else
                                Xmlport.Run(52185499, true, true)

                end;

            }
            action("Checkoff Buffer")
            {
                ApplicationArea = Basic, Suite;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //Enabled = EditGeneral;

                RunObject = page "Checkoff Buffer";
                RunPageLink = "Checkoff No" = field("No.");
            }
            action("Validate Buffer")
            {
                ApplicationArea = Basic, Suite;
                Image = Accounts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //Enabled = EditGeneral;

                trigger OnAction()
                var
                    MsgValidate: Label 'Validation Successful';
                begin

                    Rec.TestField(Posted, false);
                    Rec.Testfield(Status, Rec.Status::Open);
                    if Rec."CheckOff Type" = Rec."CheckOff Type"::" " then
                        Error('Ensure checkoff type is selected before proceeding.');
                    PeriodicCheckoff.NewCheckoffValidate(Rec);
                end;
            }
            action("Reset Posting Date")
            {
                ApplicationArea = Basic, Suite;
                Image = ChangeDate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = false;

                trigger OnAction()
                begin
                    if not Rec.Posted then begin
                        Rec."Posting Date" := Today;
                        Rec.Modify;
                        Message('Transaction date updated');
                    end else
                        Error('Transaction already posted');
                end;

            }
            //
            action("Generate Lines")
            {
                ApplicationArea = Basic, Suite;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Txt0000: Label 'Checkoff Successfully Generated';
                begin
                    Rec.CalcFields("Posted Records");
                    if Rec."Posted Records" > 0 then
                        Error(Err002);

                    if rec."CheckOff Type" <> rec."CheckOff Type"::Savings then
                        rec.TestField("Loan Cutoff Date");

                    PeriodicActy.GenerateCheckoff(Rec);

                    Message(Txt0000);
                end;
            }
            action("Re-Open")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category4;
                Image = ReOpen;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to re-open this document?', false) = true then begin
                        Rec.TestField(Posted, false);
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                    end;
                end;
            }
            action(Post)
            {
                ApplicationArea = Basic, Suite;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.TestField(Posted, false);
                    Usersetup.get(UserId);

                    IF (Rec."Posting Date" < Usersetup."Allow Posting From") and (Rec."Posting Date" > Usersetup."Allow Posting From") THEN
                        ERROR('%1 is not within the range of posting dates.', Rec."Posting Date");
                    Rec.TestField(Status, Rec.Status::Approved);
                    if Rec.Status = Rec.Status::Approved then begin
                        if not confirm('Are you sure you want to post?') then exit;

                        Rec.CalcFields("Scheduled Amount");
                        if Customer.Get(Rec."Account No.") then begin
                            Customer.CalcFields(Customer."Balance (LCY)");
                            if ((Customer."Balance (LCY)" + Rec."Scheduled Amount") > Customer."Credit Limit (LCY)") and (Customer."Credit Limit (LCY)" <> 0) then
                                Error('The allowable Credit balance of %1 has been exceeded', Customer."Credit Limit (LCY)");
                        end;

                        if rec.Posted = false then
                            PeriodicActy.NewPostCheckoff(Rec, false)
                        else
                            Error(Txt0000);
                    end else
                        Error(Error001);

                    CurrPage.Close();


                    //Generate Mkey
                    GenerateMkey()
                end;
            }
            action(PostBulk)
            {
                ApplicationArea = Basic, Suite;
                Image = Post;
                Promoted = true;
                Caption = 'Post Bulk';
                PromotedCategory = Process;

                trigger OnAction()
                var
                    LedgerEntr: record "G/L Entry";
                    CheckoffLines: Record "Checkoff Lines";
                begin
                    if Rec.Status = Rec.Status::Approved then begin
                        LedgerEntr.Reset();
                        LedgerEntr.SetRange("Document No.", rec."No.");
                        if LedgerEntr.FindFirst() then begin

                            CheckoffLines.reset;
                            CheckoffLines.SetRange("Checkoff Header", Rec."No.");
                            CheckoffLines.SetRange(Posted, false);
                            if not CheckoffLines.FindFirst() then begin
                                rec.Posted := true;
                                rec.Modify;
                                Message('Checkoff has been posted');
                                exit;
                            end;
                        end;

                        Usersetup.get(UserId);
                        if not confirm('Are you sure you want to post this checkoff via a batch process?') then exit;
                        if (Rec."Posting Date" < Usersetup."Allow Posting From") or (Rec."Posting Date" > Usersetup."Allow Posting to") then
                            ERROR('%1 is not within the range of posting dates.', Rec."Posting Date");
                        Rec.CalcFields("Scheduled Amount", "Posted Records");
                        if Customer.Get(Rec."Account No.") then begin
                            Customer.CalcFields(Customer."Balance (LCY)");
                            if ((Customer."Balance (LCY)" + Rec."Scheduled Amount") > Customer."Credit Limit (LCY)") and (Customer."Credit Limit (LCY)" <> 0) then
                                Error('The allowable Credit balance of %1 has been exceeded', Customer."Credit Limit (LCY)");
                        end;
                        if Rec."Posted Records" <> 0 then
                            Error('This transaction has entries that have been partly posted.');
                        if rec.Posted = false then begin
                            PeriodicActy.NewPostCheckoff(Rec, true);
                            //Generate Mkey
                            GenerateMkey();
                        end else
                            Error(Txt0000);
                    end else
                        Error(Error001);
                    CurrPage.Close();
                end;
            }
            separator(Action37)
            {

            }
            action("CheckOff Report")
            {
                ApplicationArea = Basic, Suite;
                Image = Report2;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CheckoffHeader.Reset;
                    CheckoffHeader.SetRange(CheckoffHeader."No.", Rec."No.");
                    if CheckoffHeader.Find('-') then
                        REPORT.Run(Report::"Checkoff Report", true, false, CheckoffHeader);
                end;
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    //Enabled = rec.Status = Rec.Status::Open;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    //Enabled = EditGeneral;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    begin

                        if Rec.Status <> Rec.Status::Open then
                            Error(DocMustbeOpen);

                        Rec.TestField("Document No.");
                        Rec.TestField(Description);
                        Rec.TestField(Amount);
                        // Rec.TestField("Employer Code");
                        Rec.TestField("Posting Date");
                        Rec.TestField("CheckOff Type");

                        if rec."CheckOff Type" = rec."CheckOff Type"::Loans then
                            rec.TestField("Loan Cutoff Date");

                        VarVariant := Rec;
                        if Confirm('Are you sure you want to send this document for approval?') then begin
                            if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                                CustomApprovals.OnSendDocForApproval(VarVariant);
                        end else
                            Message('Process aborted!');
                        CurrPage.Close();
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        if Rec.Status <> Rec.Status::Pending then
                            Error(DocMustbePending);

                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);

                        CurrPage.Close();
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page 658;
                        approvalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action("Open Document")
                {
                    ApplicationArea = Basic, Suite;
                    Image = OpenJournal;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    trigger OnAction()
                    begin
                        Rec.TestField(Posted, false);
                        Rec.TestField(Status, Rec.Status::Approved);
                        if Confirm('Are you sure you want to open the document?', false) = false then
                            exit;
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                        Message('Document open Successfuly');

                        CurrPage.Close();
                    end;
                }

                action(Commentss)
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    Caption = 'Comment';
                    PromotedCategory = Category4;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("No.");
                    RunPageView = where(Types = CONST(comment));
                }
                action(Refresh)
                {
                    ApplicationArea = Basic, Suite;
                    Image = Refresh;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        CurrPage.Update();
                    end;
                }
                action("Send Underpayment Notification")
                {
                    ApplicationArea = Basic, Suite;
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        CheckoffLines: record "Checkoff Lines";
                        SendSMS: codeunit SendSms;
                        Members: record Members;
                        SMSSource: enum "SMS Source";
                        Msg: text[1000];
                        Loans: record Loans;
                    begin
                        if rec."Sms Sent" then Error('Notification has already been sent.');
                        rec.TestField(Posted);
                        CheckoffLines.Reset();
                        CheckoffLines.SetRange("Checkoff Header", Rec."No.");
                        CheckoffLines.setfilter("Loan Underpayment amount", '>0');
                        if CheckoffLines.FindFirst() then begin
                            repeat
                                if Loans.get(CheckoffLines."Loan No.") then begin
                                    if Members.get(Loans."Member No.") then begin
                                        if Members."First Name" <> '' then
                                            Msg := 'Dear ' + Members."First Name" + ', We have received your checkoff and your ' + Loans."Loan Product Type Name" + ' has been underpaid by KES ' + Format(round(CheckoffLines."Loan Underpayment amount"), 1)
                                        else
                                            Msg := 'Dear ' + Members.Name + ', We have received your checkoff and your ' + Loans."Loan Product Type Name" + ' has been underpaid by KES ' + Format(round(CheckoffLines."Loan Underpayment amount"), 1);

                                        SendSMS.SendSms(SMSSource::LOAN_DEFAULTED, Members."Phone No.", msg, Loans."Loan Account", '', true, 0, false, 'CBS', Members."No.", 'CBS')
                                    end;
                                end;
                            until CheckoffLines.Next() = 0;
                        end
                        else begin
                            CheckoffLines.Reset();
                            CheckoffLines.SetRange("Checkoff Header", Rec."No.");
                            if CheckoffLines.FindFirst() then begin
                                repeat
                                    if Loans.get(CheckoffLines."Loan No.") then begin
                                        if Loans."Outstanding Interest" > 0 then begin
                                            if Members.get(Loans."Member No.") then begin
                                                if Members."First Name" <> '' then
                                                    Msg := 'Dear ' + Members."First Name" + ', We have received your checkoff and your ' + Loans."Loan Product Type Name" + ' has been underpaid by KES ' + Format(Loans."Outstanding Interest")
                                                else
                                                    Msg := 'Dear ' + Members.Name + ', We have received your checkoff and your ' + Loans."Loan Product Type Name" + ' has been underpaid by KES ' + Format(Loans."Outstanding Interest");

                                                SendSMS.SendSms(SMSSource::LOAN_DEFAULTED, Members."Phone No.", msg, Loans."Loan Account", '', true, 0, false, 'CBS', Members."No.", 'CBS')
                                            end;
                                        end;
                                    end;
                                until CheckoffLines.Next() = 0;
                            end;
                        end;
                        rec."Sms Sent" := true;
                        rec.Modify();
                        Message('Notifications sent successfully!');
                    end;
                }

            }

            // group("EDMS Integration")
            // {
            //     action("Import")
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Import File';
            //         Promoted = true;
            //         PromotedCategory = Category7;
            //         Image = Import;

            //         trigger OnAction()
            //         var
            //             Base64Convert: Codeunit "Base64 Convert";
            //             TempBlob: Codeunit "Temp Blob";
            //             InStr: InStream;

            //             EDMSFunctions: Codeunit "EDMS Functions";
            //             FileName: Text;
            //             FileContentsB64: Text;

            //             IDNumber: Text;
            //             ApplicationType: Label 'MA'; // Member Application
            //             PFNumber: Text;
            //         begin

            //             if Rec."No." <> '' then begin
            //                 FileName := EDMSFunctions.PickEDMSFile(TempBlob);

            //                 TempBlob.CreateInStream(InStr);
            //                 FileContentsB64 := Base64Convert.ToBase64(InStr);

            //                 if FileContentsB64 <> '' then begin
            //                     // UploadToEDMS(Rec, FileName, FileContentsB64);
            //                 end;
            //             end else begin
            //                 Error('Application No. is required for EDMS document upload');
            //             end;
            //         end;
            //     }
            //     action("EDMS File List")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Image = Documents;
            //         Promoted = true;
            //         PromotedCategory = Category7;

            //         RunObject = page "EDMS Files List";
            //         RunPageLink = "Application No." = field("No.");
            //         // RunPageMode = Create;
            //     }
            // }
            action("Generate MKey")
            {
                ApplicationArea = Basic, Suite;
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Category8;
                Caption = 'Employer Change Request';

                trigger OnAction()
                var
                    MkeyHeader: Record "MKey Forwarding";
                begin
                    // if not Rec."MKey Generated" then begin
                    rec.TestField(posted, false);
                    if not Confirm('Are you sure you want to generate?') then exit;
                    if GenerateMkey() then
                        Message('MKey Header generated successfully')
                    else
                        Message('No entries with unmatching employer codes found found');

                    Rec."MKey Generated" := true;
                    Rec.Modify();
                    // end else begin
                    //     MkeyHeader.Reset();
                    //     MkeyHeader.SetRange("CheckOff Header No.", Rec."No.");
                    //     if MkeyHeader.FindFirst() then begin
                    //         if MkeyHeader."Case Closed" then
                    //             Message('Mkey has already been generated Mkey No: %1, Status Case Closed.', MkeyHeader."No.")
                    //         else
                    //             Message('Mkey has already been generated Mkey No: %1.', MkeyHeader."No.");
                    //     end else
                    //         Message('Mkey has already been generated.');
                    // end;
                end;
            }
        }

    }

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
        SetUpdateControl;

    end;

    trigger OnInit()
    begin
        //SetUpdateControl;
    end;

    trigger OnOpenPage()
    begin
        // if (Rec.Status = Rec.Status::Approved) or (Rec.Status = Rec.Status::Pending) then
        //     CurrPage.Editable := false;
        // CurrPage.Update;
        SetUpdateControl;
    end;

    var
        PeriodicActy: Codeunit "Periodic Activities";
        DocMustbeOpen: Label 'This application request must be open';
        DocMustbePending: Label 'This application request must be Pending';
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        DateCaption: Boolean;
        EditCheckoff: Boolean;
        EditCheckoffLine: Boolean;
        Customer: Record customer;
        Txt0000: Label 'Checkoff has been posted';
        Percentage: Decimal;
        Error001: Label 'Document must be Approved';
        Err002: Label 'There are entries that have been posted you cannot generate lines';
        CheckoffHeader: Record "Checkoff Header";
        EditGeneral: Boolean;
        PeriodicCheckoff: Codeunit "Periodic Activities";
        CheckoffBuffer: Record "Checkoff Buffer";
        Usersetup: Record "User Setup";

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;

    local procedure SetUpdateControl()
    begin
        EditCheckoff := true;
        EditGeneral := true;

        if (Rec.Status = Rec.Status::Open) then begin
            EditCheckoff := true;
            EditGeneral := true;
        end else begin
            EditCheckoff := false;
            EditGeneral := false;
        end;

        // if (Rec.Status = Rec.Status::Approved) or (Rec.Status = Rec.Status::Pending) then
        //     CurrPage.Editable := false;

        //CurrPage.UPDATE;
    end;

    local procedure GenerateMkey(): Boolean
    var
        CheckoffLines: Record "Checkoff Lines";
        MkeyHeader: Record "MKey Forwarding";
        MKeyLines: Record "MKey Lines";
        Members: Record Members;
        HeaderEexists: Boolean;
        CheckOffBuffer: Record "Checkoff Buffer";
    begin
        HeaderEexists := false;

        CheckoffLines.Reset();
        CheckoffLines.SetRange("Checkoff Header", Rec."No.");
        if CheckoffLines.Find('-') then begin
            repeat
                if Members.Get(CheckoffLines."Member No.") then begin
                    CheckOffBuffer.Reset();
                    CheckOffBuffer.SetRange("Member No.", Members."No.");
                    CheckOffBuffer.SetRange("Checkoff No", Rec."No.");
                    if CheckOffBuffer.FindFirst() then begin
                        if CheckOffBuffer."Employer Code" <> Members."Employer Code" then begin
                            if not HeaderEexists then begin
                                MkeyHeader.Init();
                                MkeyHeader."CheckOff Header No." := Rec."No.";
                                if MkeyHeader.Insert(true) then
                                    HeaderEexists := true;
                            end;

                            if not MKeyLines.Get(MkeyHeader."No.", Members."No.") then begin
                                MKeyLines.Init();
                                MKeyLines."Header No." := MkeyHeader."No.";
                                MKeyLines."Member No. " := Members."No.";
                                MKeyLines."New Employer Code" := CheckOffBuffer."Employer Code";
                                MKeyLines.Validate("Member No. ");
                                MKeyLines.Insert(true);
                            end;
                        end;
                    end;
                end;
            until CheckoffLines.Next() = 0;
        end;

        exit(HeaderEexists);
    end;


}

