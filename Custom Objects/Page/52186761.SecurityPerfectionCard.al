page 52186761 "Security Perfection Card"
{
    ApplicationArea = All;
    Caption = 'Security Perfection Card';
    PageType = Card;
    SourceTable = "Security Perfection";
    PromotedActionCategories = 'Creation, New, Templates, Approval, Instructions,Communication, Process, External';
    DeleteAllowed = false;
    Editable = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = PageEditable;
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = false;
                }
                // field("Security No."; Rec."Security No.")
                // {
                //     ToolTip = 'Specifies the value of the Security No. field.';
                //     ShowMandatory = true;
                // }
                // field("Property No."; Rec."Property Number")
                // {
                //     ToolTip = 'Specifies the value of the Property No. field.';
                //     Editable = false;
                // }
                field("Loan No."; Rec."Loan No.")
                {
                    ToolTip = 'Specifies the value of the Loan No. field.';
                    //Editable = false;
                }
                // field("Loan Type"; Rec."Loan Type")
                // {
                //     ToolTip = 'Specifies the value of the Loan Type field.';
                //     Editable = False;
                // }
                field("Loan Name"; Rec."Loan Name")
                {
                    Caption = 'Loan Type';
                    ToolTip = 'Specifies the value of the Loan Name field.';
                    Editable = False;
                }
                field("Amount"; Rec."Amount")
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.';
                    Editable = false;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.';
                    Editable = false;
                }

                // field("Amount to be Charged"; Rec."Amount To Charge")
                // {
                //     ToolTip = 'Specifies the value of the Amount to be Charged field.';
                //     Editable = false;
                // }
                field("Loan Offer Letter Date"; Rec."Loan Offer Letter Date")
                {
                    ToolTip = 'Specifies the value of the Loan Offer Letter No. field.';
                    Editable = false;
                }
                field("Lending Unit"; Rec."Lending Unit")
                {
                    ToolTip = 'Specifies the value of the Lending Unit field.';
                    Editable = false;
                }
                // field("Loan Name"; Rec."Loan Name")
                // {
                //     ToolTip = 'Specifies the value of the Loan Name field.';
                //     Editable = False;
                // }
                // field("Collateral Types"; Rec."Collateral Types")
                // {
                //     ToolTip = 'Specifies the value of the Collateral Types field.';
                //     Editable = False;
                // }
                // field("Spousal Consent"; Rec."Spousal Consent")
                // {
                //     ToolTip = 'Specifies the value of the Spousal Consent field.';
                //     Editable = False;
                // }
                // field("Land Control Board Consent"; Rec."Land Control Board Consent")
                // {
                //     ToolTip = 'Specifies the value of the Land Control Board Consent field.';
                //     Editable = False;
                // }
                // field("Charge Type"; Rec."Charge Type")
                // {
                //     ToolTip = 'Specifies the value of the Charge Type field.';
                //     Editable = false;
                // }
                // field("Market Value"; Rec."Market Value")
                // {
                //     ToolTip = 'Specifies the value of the Market Value field.';
                //     Editable = false;
                // }
                // field("Force Sale Value"; Rec."Force Sale Value")
                // {
                //     ToolTip = 'Specifies the value of the Force Sale Value field.';
                //     Editable = false;
                // }
                // field("Next Valuation Date"; Rec."Next Valuation Date")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Visible = false;
                // }
                field("Law Firm Handling the Matter"; Rec."Law Firm Hanlding the Matter")
                {
                    Caption = 'Law Firm Handling the Matter';
                    ToolTip = 'Specifies the value of the Law Firm Hanlding the Matter field.';
                    //Editable = False;
                }
                field("Law Firm Address"; Rec."Law Firm Address")
                {
                    ToolTip = 'Specifies the value of the Law Firm Address field.';
                    //Editable = False;
                }
                field("Law Firm Physical Address"; Rec."Law Firm Physical Address")
                {
                    ToolTip = 'Specifies the value of the Law Firm Physical Address field.';
                    //Editable = False;
                }
                field("Law Firm Email"; Rec."Law Firm E-mail")
                {
                    ToolTip = 'Specifies the value of the Law Firm Email field.';
                    //Editable = False;
                }
                field("Fees Payable to the firm"; Rec."Fees Payable to the firm")
                {
                    ToolTip = 'Specifies the value of the Fees Payable to the firm field.';
                    Editable = False;
                }
                field("Status of the Fees"; Rec."Status of the Fees")
                {
                    ToolTip = 'Specifies the value of the Status of the Fees field.';
                    Editable = False;
                }
                field("Date of Issuance Instructions"; Rec."Date of Issuance Instructions")
                {
                    ToolTip = 'Specifies the value of the Date of Issuance of Instructions field.';
                }
                field("Collateral Owner"; Rec."Collateral Owner")
                {
                    ToolTip = 'Specifies the value of the Collateral Owner field.';

                }


                // field(Remarks; Rec.Remarks)
                // {
                //     ToolTip = 'Specifies the value of the Remarks field.';
                // }
                field("Valuation Comments"; Rec."Valuation Comments")
                {
                    Caption = 'Comments';
                    Tooltip = 'Specifies the value of the Valuation Comments field.';
                }

                // field("Perfection Attachements"; Rec."Perfection Attachements")
                // {
                //     Caption = 'Attachments';
                //     ToolTip = 'Specifies the value of the Perfection Attachements field.';
                //     Editable = true;
                //     MultiLine = true;
                // }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                    Editable = false;
                }
                field("Branch Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Branch Code field.';
                    Editable = false;

                }
                field("Activity Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Activity Code field.';
                    Editable = false;
                }
                field("Status"; Rec."Status")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                    // trigger OnValidate()
                    // begin
                    //     UpdatePageControls;
                    // end;
                }

                // field("Discharged"; Rec."Discharged")
                // {
                //     Editable = false;
                // }
                // field("Discharged On"; Rec."Discharged On")
                // {
                //     Editable = false;
                // }
                field("Created at"; Rec."Created at")
                {
                    Editable = false;
                }
                field("Created By"; Rec."Created by")
                {
                    Editable = false;
                }
                field("Perfection Stage"; Rec."Perfection Stage")
                {
                    Editable = false;
                }
                // field("Return Comment"; Rec."Return Comments")
                // {
                //     Editable = TRUE;
                //     MultiLine = TRUE;
                // }
                field("SMS Sent"; Rec."SMS Sent")
                {
                    Visible = VisibleRegistration;
                    Editable = false;
                }
                field("Email Sent"; Rec."Email Sent")
                {
                    Caption = 'Internal E-Mail Sent';
                    Visible = VisibleRegistration;
                    Editable = false;
                }
                field("Law Firm E-Mail Sent"; Rec."Law Firm E-Mail Sent")
                {
                    //Visible = VisibleRegistration;
                    Editable = false;
                }
                field("Large Text"; Rec."Large Lext")
                {

                }
            }
            group(Summary)
            {
                Caption = 'Instructions';

                field("Perfection Summary"; RichText)
                {
                    Caption = 'Instructions';
                    ToolTip = 'Specifies the value of the Perfection Summary field.';
                    Editable = true;
                    MultiLine = true;
                    ExtendedDataType = RichContent;
                    trigger OnValidate()
                    begin
                        Rec.SaveRichText(RichText);
                    end;
                }
            }
            group("Chargor Details")
            {
                Caption = 'Other Details';
                Editable = False;
                field("Security Category"; Rec."Security Category")
                {
                }
                field("Chargor/Owner Name"; Rec."Chargor/Owner Name")
                { }
                field("Chargor/Owner KRA PIN"; Rec."Chargor/Owner KRA PIN")
                { }
                field("Chargor/Owner ID No"; Rec."Chargor/Owner ID No")
                { }
                field("Chargor Phone No."; Rec."Chargor Phone No.")
                { }
                field("Date of Collateral registration"; Rec."Date of Coll. registration")
                {
                    Caption = 'Date of Collateral Registration';
                    ToolTip = 'Specifies the value of the Date of Collateral registration upon purchase.';
                }
                field("Collateral Description"; Rec."Collateral Description")
                { }
                field("Lease/Ownership Exp. Date"; Rec."Lease/Ownership Exp. Date")
                { }
                field("Property Location"; Rec."Property Location")
                {
                }
                field("Date of Manufucture"; Rec."Date of Manufucture")
                {
                }
            }

            // Part("Registered Securities"; "Collateral Register - List")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Security Perfection Lines';
            //     SubPageLink = "Loan No." = field("Loan No.");
            //     Editable = false;
            // }
            part("Perfection Lines"; "Perfection Lines")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Perfection Lines';
                SubPageLink = "Loan No." = field("Loan No.");
                Editable = false;
            }
            part("Loan Collaterals"; "Loan Collaterals")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Loan Collaterals Attached to the Loan';
                SubPageLink = "Loan No" = field("Loan No.");
                Editable = false;
            }

            part("File Actions"; "Perfection File Actions")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'File Actions';
                SubPageLink = "Perfection No." = field("No.");
                //Visible = True;
                Editable = ForwardingEditable;
            }
            group("Security Dates")
            {
                Caption = 'Registration Dates';
                Editable = ForwardingEditable;

                Field("Perfected"; Rec."Perfected")
                {
                    ToolTip = 'Specifies the value of the Perfected field.';
                    Editable = false;
                }
                field("Perfected By"; Rec."Perfected By")
                {
                    ToolTip = 'Specifies the value of the Perfected By field.';
                    Editable = false;
                }
                field("Date of Internal Registration"; Rec."Date Perfected")
                {
                    ApplicationArea = All;
                    Caption = 'Date of Internal Registration';
                    Editable = False;
                }
                field("Date of External Registration"; Rec."Date of External Registration")
                {
                    ApplicationArea = All;
                    Caption = 'Date of External Registration';
                    //Editable = RegistrationEdiatable;
                }
                field("Comments"; Rec."Return Comments")
                {
                    Editable = TRUE;
                    MultiLine = TRUE;
                }
                field("Valuation Report"; Rec."Valuation Report")
                {
                    MultiLine = True;
                }
                // field("Discharge Date"; Rec."Discharge Date")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Date of Discharge';
                //     //Editable = RegistrationEdiatable;
                // }
                field("Concatenated Property"; Rec."Concatenated Property")
                {
                    //Editable = false;
                    Multiline = true;
                }
            }
        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = Const(52187050), "No." = field("No.");
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
                //Visible = NOT IsOfficeAddin;
            }
        }
    }
    actions
    {
        area(Creation)
        {
            // action("Co&mments")
            // {
            //     Caption = 'Comments';
            //     ApplicationArea = Basic, Suite;
            //     RunObject = Page "Comment Sheet";
            //     Visible = AtLegal;
            // }
            action("Send E-Mail to Law Firm")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category8;
                Image = SendMail;
                trigger OnAction()
                begin
                    // if Rec."Law Firm E-Mail Sent" then
                    //     Message('Email already sent to Law Firm!');
                    // if Rec."Law Firm E-Mail" = '' then
                    //     Error('Law Firm E-Mail is Required!');

                    // Rec.TestField(Rec."Law Firm E-Mail");
                    // Rec.TestField(Rec."Law Firm Hanlding the Matter");
                    // Rec.TestField(Rec."Law Firm Address");
                    // Rec.TestField(Rec."Law Firm Physical Address");

                    SecurityPerfection.RESET;
                    SecurityPerfection.SETRANGE("No.", Rec."No.");
                    if SecurityPerfection.Find('-') then begin
                        Report.Run(Report::"Instruction Template - Perfc", true, false, SecurityPerfection);
                        if Confirm('Do you want to send an email to the Law Firm?') then
                            SendEmailWithAttachment(rec."Law Firm E-Mail");
                    end;
                    Rec."Law Firm E-Mail Sent" := true;
                    Message('Email sent Successfully!');
                end;
            }
            action("Send for Approval")
            {
                ApplicationArea = All;
                Caption = 'Send for Approval';
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                var
                    CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";

                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    Rec.TestField("Loan No.");
                    Rec.TestField("Member No.");
                    Rec.TestField("Member Name");
                    Rec.TestField("Law Firm Hanlding the Matter");
                    Rec.TestField("Collateral Owner");

                    //if Rec."Collateral Owner" = Rec."Collateral Owner"::Chargor then
                    //Rec.TestField("Chargor/Owner Name");
                    //Rec.TestField("Chargor Phone No.");

                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approvals';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }
            action("Cancel")
            {
                ApplicationArea = All;
                Caption = 'Cancel';
                Promoted = true;
                PromotedCategory = Category4;
                Image = Cancel;
                trigger OnAction()
                begin
                    Rec."Status" := Rec."Status"::Canceled;
                    Rec.Modify;
                    MESSAGE('File Cancelled');
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
                PromotedCategory = Category4;
                Image = ReOpen;

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Open then
                        Error('Document is already open');
                    if not Confirm('Are you sure you want to re-open this document?') then exit;
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify;
                    Message('Document Reopened Sucessfully.');
                end;
            }
            action("Instruction Template")
            {
                ApplicationArea = All;
                Caption = 'Instruction Template';
                Promoted = true;
                PromotedCategory = Category5;
                Image = Template;
                trigger OnAction()
                begin
                    SecurityPerfection.RESET;
                    SecurityPerfection.SETRANGE("No.", Rec."No.");
                    if SecurityPerfection.Find('-') then begin
                        Report.Run(Report::"Instruction Template - Perfc", true, false, SecurityPerfection);
                    end;
                end;
            }
            action("Template")
            {
                ApplicationArea = All;
                Caption = 'Template';
                Promoted = true;
                PromotedCategory = Category5;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    SecurityPerfection.RESET;
                    SecurityPerfection.SETRANGE("No.", Rec."No.");
                    //SecurityPerfection.SetRange("No.", Rec."Security No.");
                    if SecurityPerfection.Find('-') then begin
                        Report.Run(Report::"Perfection Template II", true, false, SecurityPerfection);
                    end;
                end;
            }
            action("Execution Form")
            {
                ApplicationArea = All;
                Caption = 'Execution Form';
                Promoted = true;
                PromotedCategory = Category5;
                Image = Template;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    SecurityPerfection.RESET;
                    SecurityPerfection.SETRANGE("No.", Rec."No.");
                    //SecurityPerfection.SetRange("No.", Rec."Security No.");
                    if SecurityPerfection.Find('-') then begin
                        Report.Run(Report::"Execution Form", true, false, SecurityPerfection);
                    end;
                end;
            }
            // action("Discharge Templates")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Discharge Templates';
            //     Promoted = true;
            //     PromotedCategory = Report;
            //     Image = Template;
            //     trigger OnAction()
            //     begin
            //         if Rec."Perfection Stage" = Rec."Perfection Stage"::"Registered" then
            //             SecurityPerfection.RESET;
            //         SecurityPerfection.SETRANGE("No.", Rec."No.");
            //         if SecurityPerfection.Find('-') then begin
            //             Report.Run(Report::"Discharge Template", true, false, SecurityPerfection);
            //         end;
            //     end;
            // }
            action("Return to Credit")
            {
                ApplicationArea = All;
                Caption = 'Return to Credit';
                Promoted = true;
                PromotedCategory = Process;
                Image = Return;
                trigger OnAction()
                begin
                    //Rec.TestField(Status, Rec.Status::Approved);
                    //Rec.TestField("Return Comments");
                    if Confirm('Are you sure you want to return this file to Credit?') then begin
                        if Rec."Perfection Stage" = Rec."Perfection Stage"::Registered then
                            Error('Security Already Registered!')
                        else
                            Clear(FileActions);
                        FileActions.Init();
                        FileActions."Perfection No." := Rec."No.";
                        FileActions."Action On File" := FileActions."Action On File"::"At Credit";
                        FileActions.Date := Today;
                        FileActions."Captured By" := UserId;
                        FileActions."Captured On" := CURRENTDATETIME;
                        FileActions.Insert();
                        Message('File Actions Lines Updated');
                        Rec."Perfection Stage" := Rec."Perfection Stage"::"At Credit";
                        Rec.Modify;
                        MESSAGE('File Sent to Credit');
                    end;
                end;
            }
            action("At Legal")
            {
                ApplicationArea = All;
                Caption = 'Security At Legal';
                Promoted = true;
                PromotedCategory = Process;
                Image = Check;
                trigger OnAction()
                begin
                    //Rec.Testfield(Rec.Status, Rec.Status::Approved);
                    if Rec."Perfection Stage" = Rec."Perfection Stage"::Registered then
                        Error('Security Already Registered!');
                    if confirm('Do you want to set this security at Legal?') then
                        Clear(FileActions);
                    FileActions.Init();
                    //FileActions.Delete;
                    FileActions."Perfection No." := Rec."No.";
                    FileActions."Action On File" := FileActions."Action On File"::"At Legal";
                    FileActions.Date := Today();
                    FileActions."Captured By" := UserId;
                    FileActions."Captured On" := CURRENTDATETIME;
                    FileActions.Insert();
                    Message('File Actions Lines Updated');
                    Rec."Perfection Stage" := Rec."Perfection Stage"::"At Legal";
                    Rec.Modify();
                    Message('File Status Set to Legal.');
                end;
            }
            action("At Legal - Pending Instructions to Advocate")
            {
                ApplicationArea = All;
                Caption = 'At Legal - Pending Instructions to Advocate';
                Promoted = true;
                PromotedCategory = Process;
                Image = Check;
                trigger OnAction()
                begin
                    //Rec.Testfield(Rec.Status, Rec.Status::Approved);
                    if confirm('Do you want to set this security at Legal?') then
                        if Rec."Perfection Stage" = Rec."Perfection Stage"::Registered then
                            Error('Security Already Registered!') else begin
                            Clear(FileActions);
                            FileActions.Init();
                            FileActions."Perfection No." := Rec."No.";
                            FileActions."Action On File" := FileActions."Action On File"::"At Legal - Pending Instructions to Advocate";
                            FileActions.Date := Today();
                            FileActions."Captured By" := UserId;
                            FileActions."Captured On" := CURRENTDATETIME;
                            FileActions.Insert();
                            Message('File Actions Lines Updated');

                            Rec."Perfection Stage" := Rec."Perfection Stage"::"At Legal - Pending Instructions to Advocate";
                            Rec.Modify();
                            Message('File is At Legal - Pending Instructions to Advocate.');
                        end;

                end;
            }
            action("At Legal - Pending Execution")
            {
                ApplicationArea = All;
                Caption = 'At Legal - Pending Execution';
                Promoted = true;
                PromotedCategory = Process;
                Image = Register;
                trigger OnAction()
                begin
                    //Rec.Testfield(Rec.Status, Rec.Status::Approved);
                    if confirm('Do you want to set this security at Legal?') then
                        if Rec."Perfection Stage" = Rec."Perfection Stage"::Registered then
                            Error('Security Already Registered!') else begin
                            Clear(FileActions);
                            FileActions.Init();
                            FileActions."Perfection No." := Rec."No.";
                            FileActions."Action On File" := FileActions."Action On File"::"At Legal - Pending Execution";
                            FileActions.Date := Today();
                            FileActions."Captured By" := UserId;
                            FileActions."Captured On" := CURRENTDATETIME;
                            FileActions.Insert;
                            Message('File Actions Lines Updated');
                            Rec."Perfection Stage" := Rec."Perfection Stage"::"At Legal - Pending Execution";
                            Rec.Modify();
                            Message('File is At Legal - Pending Execution.');
                        end;
                end;
            }
            action("Send to Advocate")
            {
                ApplicationArea = All;
                Caption = 'Send to Advocate';
                Promoted = true;
                PromotedCategory = Process;
                //Image = Send;

                trigger OnAction()
                begin
                    //Rec.Testfield(Rec.Status, Rec.Status::Approved);
                    if confirm('Are you sure you want to send this file to Advocate?') then
                        if Rec."Perfection Stage" = Rec."Perfection Stage"::Registered then
                            Error('Security Already Registered!') else begin
                            Clear(FileActions);
                            FileActions."Perfection No." := Rec."No.";
                            FileActions."Action On File" := FileActions."Action On File"::"At Advocate";
                            FileActions.Date := Today();
                            FileActions."Captured By" := UserId;
                            FileActions."Captured On" := CURRENTDATETIME;
                            FileActions.Insert();
                            Message('File Actions Lines Updated');

                            Rec."Perfection Stage" := Rec."Perfection Stage"::"At Advocate";
                            Rec.Modify;
                            MESSAGE('File is at Advocate');
                        end;
                end;
            }
            action("At Advocate - Charge Preparation")
            {
                ApplicationArea = All;
                Caption = 'Advocate - Charge Preparation';
                Promoted = true;
                PromotedCategory = Process;
                Image = Register;

                trigger OnAction()
                begin
                    //Rec.Testfield(Rec.Status, Rec.Status::Approved);
                    if confirm('Are you sure you want to send this file to Advocate?') then
                        if Rec."Perfection Stage" = Rec."Perfection Stage"::Registered then
                            Error('Security Already Registered!') else begin
                            Clear(FileActions);
                            FileActions.Init();
                            FileActions."Perfection No." := Rec."No.";
                            FileActions."Action On File" := FileActions."Action On File"::"At Advocate - Charge Preparation";
                            FileActions.Date := Today();
                            FileActions."Captured By" := UserId;
                            FileActions."Captured On" := CURRENTDATETIME;
                            FileActions.Insert();
                            Message('File Actions Lines Updated');

                            Rec."Perfection Stage" := Rec."Perfection Stage"::"At Advocate - Charge Preparation";
                            Rec.Modify;
                            MESSAGE('File is at Advocate for Charge Preparation');
                        end;
                end;
            }
            action("At Advocate - Pending Registration")
            {
                ApplicationArea = All;
                Caption = 'Advocate - Pending Registration';
                Promoted = true;
                PromotedCategory = Process;
                Image = Register;

                trigger OnAction()
                begin
                    //Rec.Testfield(Rec.Status, Rec.Status::Approved);
                    if confirm('Are you sure you want to send this file to Advocate?') then
                        if Rec."Perfection Stage" = Rec."Perfection Stage"::Registered then
                            Error('Security Already Registered!') else begin
                            Clear(FileActions);
                            FileActions.Init();
                            FileActions."Perfection No." := Rec."No.";
                            FileActions."Action On File" := FileActions."Action On File"::"At Advocate Pending Registration";
                            FileActions.Date := Today();
                            FileActions."Captured By" := UserId;
                            FileActions."Captured On" := CURRENTDATETIME;
                            FileActions.Insert();
                            MESSAGE('File Actions Lines Updated');

                            Rec."Perfection Stage" := Rec."Perfection Stage"::"At Advocate Pending Registration";
                            Rec.Modify;
                            Message('File is at Advocate Pending Registration');
                        end;
                end;
            }
            action("Return from Advocate")
            {
                ApplicationArea = All;
                Caption = 'Return from Advocate';
                Promoted = true;
                PromotedCategory = Process;
                Image = Return;
                trigger OnAction()
                begin
                    //Rec.Testfield(Rec.Status, Rec.Status::Approved);
                    if Confirm('Are Security Documents Back from External Advocates?')
                    then
                        if Rec."Perfection Stage" = Rec."Perfection Stage"::Registered then
                            Error('Security Already Registered!') else begin
                            Clear(FileActions);
                            FileActions.Init();
                            FileActions."Perfection No." := Rec."No.";
                            FileActions."Action On File" := FileActions."Action On File"::"At Legal";
                            FileActions.Date := Today;
                            FileActions."Captured By" := UserId;
                            FileActions."Captured On" := CURRENTDATETIME;
                            FileActions.Insert();
                            MESSAGE('File Actions Lines Updated');
                            Rec."Perfection Stage" := Rec."Perfection Stage"::"At Legal";
                            Rec.Modify();
                            MESSAGE('File is back from Advocate');
                        end;
                end;

            }
            action("Perfect Security")
            {
                ApplicationArea = All;
                Caption = 'Register Security';
                Promoted = true;
                PromotedCategory = Process;
                Image = Check;

                trigger onAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    if Rec."Perfection Stage" = Rec."Perfection Stage"::Registered then
                        Error('Security Already Registered!')
                    else begin
                        if confirm('Would you like to register the security?') then begin
                            FileActions.Init();
                            FileActions."Perfection No." := Rec."No.";
                            FileActions."Action On File" := FileActions."Action On File"::Registered;
                            FileActions.Date := Today();
                            FileActions."Captured By" := UserId;
                            FileActions."Captured On" := CURRENTDATETIME;
                            FileActions.Insert;
                            MESSAGE('File Actions Lines Updated');
                        end
                        else
                            exit;

                        // PerfectionLines.RESET;
                        // PerfectionLines.SETRANGE("Loan No.", Rec."Loan No.");
                        // //PerfectionLines.Init();
                        // if PerfectionLines.FindSet() then begin
                        //     repeat
                        //         PerfectionLines.Perfected := true;
                        //         PerfectionLines.Modify;
                        //     until PerfectionLines.Next = 0;
                        // end;
                        SecuritiesRegister.Reset();
                        SecuritiesRegister.SetRange("Loan No.", Rec."Loan No.");
                        if SecuritiesRegister.Find('-') then begin
                            //SecuritiesRegister.ModifyAll("Collateral Perfected", true);
                            repeat
                                SecuritiesRegister."Collateral Perfected" := true;
                                SecuritiesRegister.Modify;
                            until SecuritiesRegister.Next = 0;
                            Message('Collateral Perfected');
                        end;

                        PerfectionLines.RESET;
                        PerfectionLines.SETRANGE("Loan No.", Rec."Loan No.");
                        if PerfectionLines.find('-') then begin
                            repeat
                                PerfectionLines.Perfected := true;
                                PerfectionLines.Modify;
                            until PerfectionLines.Next = 0;
                        end;

                        Rec."Perfection Stage" := Rec."Perfection Stage"::Registered;
                        Rec."Perfected" := true;
                        Rec."Perfected By" := UserId;
                        Rec."Date Perfected" := TODAY;
                        Rec.Modify;

                        //Rec."Email Sent" := true;
                        Rec.Modify();
                        MESSAGE('Security Registered');
                        //CurrPage.Close();
                    end;
                end;
            }
            action("Send SMS")
            {
                Caption = 'Send SMS to Loanee/Chargor';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category6;
                Image = MailAttachment;
                trigger OnAction()
                var
                    myInt: Integer;
                begin

                    Rec.TestField(Status, Rec.Status::Approved);
                    Rec.Testfield("Perfection Stage", Rec."Perfection Stage"::Registered);
                    Rec.TestField(Perfected, true);
                    Rec.TestField("Date of External Registration");
                    Rec.TestField("Date Perfected");
                    Rec.TestField("Concatenated Property");

                    if Rec."Collateral Owner" = Rec."Collateral Owner"::" " then
                        Error('Collateral Owner field is Required!')
                    else
                        if Rec."Collateral Owner" = Rec."Collateral Owner"::Loanee then begin

                            Members.Reset();
                            Members.SetRange("No.", Rec."Member No.");
                            if Members.Find('-') then begin
                                if Members."Phone No." <> '' then begin
                                    if Confirm('Do you want to send an SMS to the Loanee?') then
                                        //msg := 'Dear, ' + Rec."Member Name" + ', This is to formally inform you that the ' + Format(Rec."Charge Type") + ' over ' + 'Property Number - ' + Rec."Property Number" + ' ' + 'which you offered as collateral for' + ' ' + Rec."Loan Name" + ' ' + 'was successfully registered in favour of Kenpipe SACCO on the' + ' ' + FORMAT(Rec."Date Perfected") + '. ' + 'The same was charged at Kshs. ' + Format(Rec."Amount To Charge") + '.';
                                        msg := 'Dear, ' + Rec."Member Name" + ', this is to formally inform you that the ' + Rec."Concatenated Property" + ' ' + 'which you offered as collateral for' + ' ' + Rec."Loan Name" + ' ' + 'was successfully registered in favour of Kenpipe SACCO on' + ' ' + FORMAT(Rec."Date of External Registration") + '. ';
                                    SendSMS.SendSms(Source::"Security Perfection", Members."Phone No.", msg, ' ', ' ', false, 0, false, 'CBS', Rec."Security No.", 'CBS', Rec."Date Perfected");
                                end
                                else if Members."Transactional Mobile Number" <> ' ' then begin
                                    //msg := 'Dear, ' + Rec."Member Name" + ', \This is to formally inform you that the ' + Format(Rec."Charge Type") + ' over ' + 'Property Number - ' + Rec."Property Number" + ' ' + 'which you offered as collateral for' + ' ' + Rec."Loan Name" + ' ' + 'was successfully registered in favour of Kenpipe SACCO on the' + ' ' + FORMAT(Rec."Date Perfected") + '. ' + 'The same was charged at Kshs. ' + Format(Rec."Amount To Charge") + '.';
                                    msg := 'Dear, ' + Rec."Member Name" + ', this is to formally inform you that the ' + Rec."Concatenated Property" + ' ' + 'which you offered as collateral for' + ' ' + Rec."Loan Name" + ' ' + 'was successfully registered in favour of Kenpipe SACCO on' + ' ' + FORMAT(Rec."Date of External Registration") + '. ';
                                    SendSMS.SendSms(Source::"Security Perfection", Members."Transactional Mobile Number", msg, ' ', ' ', false, 0, false, 'CBS', Rec."Security No.", 'CBS', Rec."Date Perfected");
                                end
                                else
                                    Error('Member Phone Number is Required!');
                            end;
                        end
                        else
                            if Rec."Collateral Owner" = Rec."Collateral Owner"::Chargor then begin
                                if Rec."Chargor Phone No." <> ' ' then begin
                                    if Confirm('Do you want to send SMS to the Chargor') then
                                        msg := 'Dear ' + Rec."Chargor/Owner Name" + ',\' + ' please note that the ' + FORMAT(Rec."Charge Type") + 'over Property No. ' + Rec."Property Number" + 'which you offered as collateral for' + ' ' + Rec."Loan Name" + ' ' + 'for ' + Rec."Member Name" + ' was successfully registered in favour of Kenpipe SACCO on the' + ' ' + FORMAT(Rec."Date Perfected") + '. ' + 'The same was charged at Kshs. ' + Format(Rec."Amount To Charge") + '.';
                                    SendSMS.SendSms(Source::"Security Perfection", Rec."Chargor Phone No.", msg, ' ', ' ', false, 0, false, 'CBS', Rec."Security No.", 'CBS', Rec."Date Perfected");
                                end
                                else
                                    Error('Chargor Phone Number is Required!');
                            end;
                    Rec."SMS Sent" := true;
                    Rec.Modify();
                    MESSAGE('SMS Sent Successfully!');
                end;
            }
            action("Send E-Mail")
            {
                Caption = 'Send E-Mail to Lending Unit';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category6;
                Image = Email;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    NotificationSetup.RESET;
                    NotificationSetup.SetRange(Notification, NotificationSetup.Notification::"Lending Units", NotificationSetup.Notification::"Legal");
                    NotificationSetup.SetRange("Send Email", true);
                    if NotificationSetup.Find('-') then begin

                        repeat
                            UserSetup.Reset();
                            UserSetup.SetRange("User ID", NotificationSetup."user id");
                            if UserSetup.FindFirst() then begin

                                msg := 'Dear' + ' ' + NotificationSetup."Responsibility Centre" + ' /' + 'This is to bring to your attention that the collateral for loan number ' +
                                Rec."Loan No." + ' has been successfully registered.\' + 'Please take necessary action\. Thank you.';
                                EmailManager.Create(UserSetup."E-Mail", 'Collateral Perfection', msg, true);
                                Email.Send(EmailManager, Enum::"Email Scenario"::Default);
                            end;
                        until NotificationSetup.NEXT = 0;
                    end;
                    Rec."Email Sent" := true;
                    Rec.Modify;
                    Message('Email Sent Successfully!');
                end;
            }

            // action("Discharge Security")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Discharge Security';
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     trigger OnAction()
            //     begin

            //         Rec.TestField(Status, Rec.Status::Approved);
            //         Rec.Testfield("Perfection Stage", Rec."Perfection Stage"::Registered);
            //         Rec.TestField(Perfected, true);
            //         if Confirm('Do you want to discharge the Security and avail it for collection by loanee at lending unit?') then begin

            //             FileActions.Init();
            //             FileActions."Perfection No." := Rec."No.";
            //             FileActions."Action On File" := FileActions."Action On File"::Discharged;
            //             FileActions.Date := Today();
            //             FileActions.Insert;
            //             MESSAGE('File Actions Lines Updated');
            //         end;

            //         Rec."Perfection Stage" := Rec."Perfection Stage"::"Discharged";
            //         Rec."Discharged" := true;
            //         Rec."Discharged On" := CURRENTDATETIME;
            //         Rec."Discharged By" := UserId;
            //         Rec.Modify;

            //         Members.Reset();
            //         Members.SetRange("No.", Rec."Member No.");
            //         if Members.Find('-') then begin
            //             if Members."Phone No." <> '' then begin
            //                 if Confirm('Do you want to send an SMS to the member?') then
            //                     msg := 'Dear, ' + Rec."Member Name" + ', this is to formally inform you that the ' + Format(Rec."Charge Type") + ' over ' + 'Property Number - ' + Rec."Property Number" + ' ' + 'which you offered as collateral for' + ' ' + Rec."Loan Name" + ' ' + 'was successfully registered in favour of Kenpipe SACCO on the' + ' ' + FORMAT(Rec."Date of Registration") + '. ' + 'The same was charged at Kshs. ' + Format(Rec."Amount To Charge") + '.';
            //                 SendSMS.SendSms(Source::"Security Perfection", Members."Phone No.", msg, ' ', ' ', false, 0, false, 'CBS', Rec."Security No.", 'CBS', Rec."Date of Registration");
            //             end
            //             else begin
            //                 msg := 'Dear, ' + Rec."Member Name" + ', this is to formally inform you that the ' + Format(Rec."Charge Type") + ' over ' + 'Property Number - ' + Rec."Property Number" + ' ' + 'which you offered as collateral for' + ' ' + Rec."Loan Name" + ' ' + 'was successfully registered in favour of Kenpipe SACCO on the' + ' ' + FORMAT(Rec."Date of Registration") + '. ' + 'The same was charged at Kshs. ' + Format(Rec."Amount To Charge") + '.';
            //                 SendSMS.SendSms(Source::"Security Perfection", Members."Transactional Mobile Number", msg, ' ', ' ', false, 0, false, 'CBS', Rec."Security No.", 'CBS', Rec."Date of Registration");
            //             end
            //         end;
            //         Rec."SMS Sent" := true;
            //         Rec.Modify();
            //         MESSAGE('Security Registered');
            //         CurrPage.Close();

            //         MESSAGE('Security Discharged. Now available for collection at respective lending Unit');
            //         CurrPage.Close();
            //     end;
            // }
        }
    }

    trigger OnOpenPage();
    begin
        if UserSetup.Get(Rec."Created By") then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            Rec."Responsibility Center" := UserSetup."Responsibility Centre";

        end;
        //Rec.Modify;
        Rec."Created By" := UserId;
        Rec."Perfected By" := UserId;
        begin
            UpdatePageControls;
        end;


        if Rec.Status = Rec.Status::Open then begin
            //CurrPage.Editable := true
            PageEditable := true;
            ForwardingEditable := true;
        end
        else begin
            //CurrPage.Editable := false;
            PageEditable := false;
            ForwardingEditable := true;
        end;

        if Rec."Perfection Stage" = Rec."Perfection Stage"::"At Legal" then begin
            AtLegal := True;
        end
        else begin
            AtLegal := false;
        end;
        if Rec.Perfected = True then begin
            VisibleRegistration := True;
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        RichText := Rec.GetRichText(Rec);

    end;

    trigger OnAfterGetRecord()
    begin
        RichText := Rec.GetRichText(Rec);
    end;



    trigger OnNextRecord(Steps: Integer): Integer
    begin
        UpdatePageControls;
    end;

    // trigger OnOpenPage()
    // begin
    //     UpdatePageControls;
    // end;

    Procedure UpdatePageControls()
    begin
        if Rec."Perfection Stage" = Rec."Perfection Stage"::"Registered" then
            RegistrationEdiatable := true
        else
            RegistrationEdiatable := false;
    end;

    procedure SendEmailWithAttachment(var emailadress: Code[50])
    var
        ReportExample: Report "Instruction Template - Perfc";
        SecurityPerfection: Record "Security Perfection";
        Email: Codeunit Email;
        EmailMsg: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        InStr: Instream;
        OutStr: OutStream;
        ReportParameters: Text;
        TxtRecipientsList: List of [Text];

    begin

        ReportParameters := ReportExample.RunRequestPage();
        TempBlob.CreateOutStream(OutStr);
        // SecurityPerfection.RESET;
        // SecurityPerfection.SETRANGE("No.", Rec."No.");
        // if SecurityPerfection.Find('-') then
        Report.SaveAs(Report::"Instruction Template - Perfc", ReportParameters, ReportFormat::Pdf, OutStr);
        TempBlob.CreateInStream(InStr);

        TxtRecipientsList.Add(emailadress);
        EmailMsg.Create(emailadress, 'Security Perfection Instruction', 'Greetings, Please find the above intrsuctions for your firm and have someone collect them from our offices. Thank you.');
        EmailMsg.AddAttachment('FileName.pdf', 'PDF', InStr);
        Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
    end;

    procedure SendEmails()
    var
        myInt: Integer;
        email: codeunit Email;
        userset: Record "User Setup";
        Collateral: record "Securities Register";

        Filename: Text;
        usermail: Text;
        username: text;
        instr: InStream;
        emailbody: Label 'Dear <b>%1</b>, <br> <P>find Documents to be approved</P> <h>';

    begin
        Collateral.Reset();
        collateral.setrange(Collateral."No.", rec."Security No.");
        if collateral.findfirst then begin
            userset.Reset();
            userset.SetRange("User ID", Collateral."Captured By");
            if userset.FindFirst() then begin
                usermail := userset."E-Mail";
                username := userset."Full Name";
                Message(username);
            end;
        end;

        //EmailMsg.Create(usermail, 'Dear, ' + UserSetup."Full Name" + 'this is to inform you about the registration of ' + Rec."Security No." +  '.', true);
        EmailMsg.Create(usermail, 'Request to approve', '', true);
        EmailMsg.AppendToBody(StrSubstNo(emailbody, username));
        // if UploadIntoStream('Select the file', '', 'This files|*.jpg;*.pdf;*.docx;*.png', Filename, instr) then
        //     EmailMsg.AddAttachment(Filename, '', instr)
        // else
        Message('There was an error in uploading %1', GetLastErrorText());
        if email.Send(EmailMsg) then
            Message('Email sent successfully')
        else
            Message('There was an error in sendingmail,%1', GetLastErrorText());
    end;

    // procedure concatenatepropertyforSMS()
    // var
    //     myInt: Integer;
    //     HeaderRec: Record "Security Perfection";
    //     LinesRec: Record "Perfection Lines";
    //     Concatenatedproperty: Text;
    //     begin
    //         HeaderRec.RESET;
    //         HeaderRec.SETRANGE(Perfected, false);
    //         if HeaderRec.Find('-') then begin
    //             LinesRec.RESET;
    //             LinesRec.SETRANGE("Loan No.", Rec."Loan No.");
    //             if LinesRec.FindSet() then begin
    //                 repeat
    //                     Concatenatedproperty += LinesRec."Property No." + ', ';
    //                 until LinesRec.NEXT = 0;
    //             end;
    //         end;
    //         Message(Concatenatedproperty);
    //     end;

    Var
        UserSetup: Record "User Setup";
        SecuritiesRegister: Record "Securities Register";
        SecurityPerfection: Record "Security Perfection";
        VarVariant: Variant;
        RegistrationEdiatable: Boolean;
        AtLegal: Boolean;
        FileActions: Record "Perfection File Action";
        SendSMS: Codeunit SendSms;
        msg: Text;
        Source: enum "SMS Source";
        Members: Record Members;
        PageEdit: Boolean;
        OpenApprovalEntriesExist: boolean;
        DocMustbePending: Label 'This application request must be Pending';
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        VisibleRegistration: Boolean;
        EmailMsg: Codeunit "Email Message";
        PerfectionLines: Record "Perfection Lines";
        EmailManager: Codeunit "Email Message";
        Email: Codeunit Email;
        NotificationSetup: Record "Notification EmSms setup";
        ForwardingEditable: Boolean;
        PageEditable: Boolean;
        RichText: Text;

}