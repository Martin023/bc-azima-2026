page 52186078 "Legal Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = Legal;
    PromotedActionCategories = 'Document,Home,New,Creation,Advocate,Approval,Process,E-mail';

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = "Case TypeEditable";
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Case is ADR"; Rec.ADR)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = True;
                    trigger OnValidate()
                    begin
                        if Rec.ADR = true then begin
                            EditableADR := TRUE;
                            Rec."Case Status" := Rec."Case Status"::ADR;
                        end;
                        if Rec.ADR = FALSE then begin
                            EditableADR := FALSE;
                            Rec."Case Status" := Rec."Case Status"::Open;
                        end;
                    end;
                }
                field("Type of ADR"; Rec."Type of ADR")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = "Plaintiff TypeEditable";
                    Editable = EditableADR;
                }
                field("Case Number"; Rec."Case Number")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Plaintiff TypeEditable";
                    ShowMandatory = True;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if Rec."Case Number" = '' then Error('This number field cannot be empty');
                    end;
                }
                field("Adivsory"; Rec."Advisory")
                {
                    Caption = 'Advisory';
                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    begin
                        if Rec."Advisory" = true then begin
                            AdvisoryEditable := true;
                        end
                        else begin
                            AdvisoryEditable := false;
                        end;
                    end;
                }
                field("Summary of Advisory"; Rec."Summary of advisory")
                {
                    Editable = AdvisoryEditable;
                    MultiLine = true;
                    ApplicationArea = Basic, Suite;
                    //Editable = "Plaintiff TypeEditable";
                    ShowMandatory = True;
                    ColumnSpan = 100;
                }
                field("Predicted Outcome"; Rec."Predicted Outcome")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date of filing the suit"; Rec."Date of Filing the suit")
                {
                    Caption = 'Date of filing the suit';
                    ApplicationArea = Basic, Suite;
                    Editable =  "Case TypeEditable";
                    ShowMandatory = True;
                }
                field("Action Duration Start Date"; Rec."Action Duration Start Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = False;
                }
                field("Action Duration End  Date"; Rec."Action Duration End  Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Case Duration"; Rec."Case Duration")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Caption = 'Case Duration (Days)';
                }
                field("Matter Code"; Rec."Matter Code")
                {
                    Caption = 'Matter Code';
                    ApplicationArea = Basic, Suite;
                    //ShowMandatory = True;
                    //Editable = EditableADR;
                }
                field("Type of Court"; Rec."Case Description")
                {
                    Caption = 'Type of Court';
                    ApplicationArea = Basic, Suite;
                    Editable = False;
                    
                }
                field("Case Category"; Rec."Case Category")
                {
                    Caption = 'Case Category';
                    ApplicationArea = Basic, Suite;
                    Editable = "Plaintiff TypeEditable";
                    ShowMandatory = True;
                    trigger OnValidate()
                    begin
                        if Rec."Case Category" = Rec."Case Category"::External then begin
                            CaseSummaryVisible := true;
                        end
                        else
                            if Rec."Case Category" = Rec."Case Category"::Internal then begin
                                CaseSummaryVisible := false;
                            end;
                    end;
                }
                field("Law Firm"; Rec."Law Firm")
                {
                    Caption = 'Advocate No';
                    ApplicationArea = Basic, SUite;
                    Editable = false;
                    ShowMandatory = True;
                }
                field("Lawyer"; Rec."Lawyer")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Caption = 'Advocate Name';
                }
                field("Advocate E-Mail"; Rec."Advocate E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = false;
                }

                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Plaintiff TypeEditable";
                    //Editable = false;
                    ShowMandatory = True;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Plaintiff TypeEditable";
                    //Editable = false;
                    ShowMandatory = True;
                }
                // field("Type of Court"; Rec."Type of Court")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Budgeted Cost"; Rec."Budgeted Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Plaintiff TypeEditable";
                    //ShowMandatory = True;
                }
                field("Fees Saved"; Rec."Fees Saved")
                {
                    ApplicationArea = Basic, Saved;
                }
                
                field("Legal Fees"; Rec."Legal Fees")
                {
                    ApplicationArea = Basic, SUite;
                    Editable = "Plaintiff TypeEditable";
                    ShowMandatory = True;
                }
                field("Contingent Liabilities"; Rec."Contigent Liabilities")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Plaintiff TypeEditable";
                    ShowMandatory = True;
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    ApplicationArea = Basic, Suites;
                    Editable = False;
                }
                //field("Description of Complaint"; Rec."Description of Complaint")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = "Description of ComplaintEditable";
                // }
                // field("Contingent Liabilities"; Rec."Contigent Liabilities")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Name of Case"; Rec."Name of Case")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Plaintiff TypeEditable";
                    ShowMandatory = True;
                }
                field("Case Summary"; Rec."Case Summary")
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                    Caption = 'Instructions';
                    Editable = "Plaintiff TypeEditable";
                    //Editable = CaseSummaryVisible;
                    ColumnSpan = 100;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        PageControl();
                    end;
                }
                field("Pleadings in Summary"; Rec."Pleadings in Summary")
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                    Editable = "Plaintiff TypeEditable";
                    ShowMandatory = True;
                }
                // field("ADR"; Rec.ADR)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                // }

                // field("Plaintiff Type"; Rec."Plaintiff Type")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = "Plaintiff TypeEditable";
                // }
                // field(Plaintiff; Rec.Plaintiff)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = "PlaintiffEditable";
                // }
                // field(Others; Rec.Others)
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field(Name; Rec.Name)
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Accused Type"; Rec."Accused Type")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = "Plaintiff TypeEditable";
                //     //Editable = "Accused TypeEdtable";
                // }
                // field("Accused Employee"; Rec."Accused Employee")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = "Accused EmployeeEditable";
                // }
                // field("Accused Name"; Rec."Accused Name")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = "Plaintiff TypeEditable";
                // }
                // field("Reporter Type"; Rec."Reporter Type")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = "Reporter TypeEditable";
                // }
                // field(Reporter; Rec.Reporter)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = ReporterEditable;
                // }
                // field("Reporter Name"; Rec."Reporter Name")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Action Duration Start Date"; Rec."Action Duration Start Date")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = "Action Duration Start DateEditable";
                // }
                // field("Action Duration End  Date"; Rec."Action Duration End  Date")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = "Action Duration End  DateEditable";
                // }
                // field("Case Duration"; Rec."Case Duration")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                // }
                // field("Body Handling The Complaint"; Rec."Body Handling The Complaint")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = "Body Handling The ComplaintEditable";
                // }
                // field("Body Name"; Rec."Body Name")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field(Signatory; Rec.Signatory)
                {
                    ApplicationArea = Basic, Suite;
                    //Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Branch Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Branch field.';
                    Editable = false;
                }
                field("Activity Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Department field.';
                    Editable = false;
                }
                // field("User ID"; Rec."User ID")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Total Cost"; Rec."Total Cost")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    trigger OnValidate()
                    begin
                        //DocumentControl;
                        UpdatePageControls;
                    end;
                }
                field("Case Status"; Rec."Case Status")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Created at"; Rec."Created at")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Case Outcome"; Rec."Case Outcome")
                {
                    ApplicationArea = Basic, Suite;
                }

            }
            part("Legal Line"; "Legal Line")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Status List';
                SubPageLink = No = FIELD("No."), "Case Number" = FIELD("Case Number");
                //SubPageLink = No = field("Case Number");
                Visible = true;
                //Editable = TRUE;
                //Editable = "Case TypeEditable";
            }
            part(Control9; "Verdict List")
            {
                Caption = 'Verdict List';
                ApplicationArea = Basic, Suite;
                SubPageLink = "No" = FIELD("Case Number");
                //SubPageLink = "No" = FIELD("No.");
                Visible = true;
                //Editable = TRUE;
                //Editable = "Case TypeEditable";
            }
            part("Upcoming Matters"; "Upcoming Matters")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Upcoming Matters';
                //SubPageLink = "Record ID" = FIELD("No."), "Case Number" = Field("Case Number");
                SubPageLink = "Record ID" = field("Case Number"), No = field("No.");
                //SubPageLink = "Case Number" = Field("Case Number");
                //Visible = true;
                //Editable = TRUE;
                //Editable = "Case TypeEditable";
            }
            // field("Policy Description"; Rec."Policy Description")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
            // field("Recommended Action"; Rec."Recommended Action")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
            // field("Disciplinary Remarks"; Rec."Disciplinary Remarks")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
            field(Comments; Rec.Comments)
            {
                ApplicationArea = Basic, Suite;
                MultiLine = true;
                //Editable = false;
                Editable = "Case TypeEditable";
            }
        }
    }

    actions
    {
        area(creation)
        {
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

                    Legal.RESET;
                    Legal.SETRANGE("No.", Rec."No.");
                    if Legal.Find('-') then begin
                        Report.Run(Report::"Instruction Template Ltg", true, false, Legal);
                        if Confirm('Do you want to send an email to the Law Firm?') then
                            SendEmailWithAttachment(rec."Advocate E-Mail");
                    end;
                    Rec."Law Firm E-Mail Sent" := true;
                    Message('Email sent Successfully!');
                end;
            }
            action("Case Cost")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Case Cost';
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                RunObject = Page "Case Cost List";
                RunPageLink = Code = FIELD("No.");
            }
            action(Advocate)
            {
                ApplicationArea = Basic, Suite;
                Image = Addresses;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                RunObject = Page "Advocate List";
                RunPageLink = No = FIELD("No.");
                Scope = Repeater;
            }
            // action("Damages List")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Contingent Liabilities';
            //     Image = Agreement;
            //     Promoted = true;
            //     PromotedCategory = Category7;
            //     PromotedIsBig = true;
            //     RunObject = Page "Damages List";
            //     RunPageLink = "No." = FIELD("No.");
            // }
            action("Create Case")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Create Case';
                Image = ReopenCancelled;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    if Rec."Case Status" = Rec."Case Status"::Ongoing then begin
                        Error('Case is Ongoing!');
                    end
                    else
                        if Confirm('Are you sure you want to this create this case?"') then begin
                            Rec."Case Status" := Rec."Case Status"::Ongoing;
                            Rec.Modify;
                            Message('Case Number %1 has been marked as Ongoing', Rec."Case Number");
                        end;
                end;
            }
            action("ADR")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'ADR';
                Image = ReopenCancelled;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = true;
                Trigger OnAction()
                begin
                    Rec.TestField("Case Status", Rec."Case Status"::Ongoing);
                    Rec.TestField(Status, Rec.Status::Approved);
                    if Rec.ADR = TRUE then begin
                        Error('Case Was initiated as ADR!')
                    end;

                    if Rec."Case Status" = Rec."Case Status"::ADR then begin
                        Error('ADR can only be initiated once');
                    end;
                    if Confirm('Are you sure you want to Set this case Under ADR?') then begin
                        Rec."Case Status" := Rec."Case Status"::ADR;
                        Rec.ADR := true;
                        Rec.Modify;
                        Message('Case Number %1 has been marked as "ADR"', Rec."Case Number");
                    end;
                end;
            }
            action(Close)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Close';
                Image = ReopenCancelled;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction()
                begin
                    Rec.TestField("Case Status", Rec."Case Status"::OnGoing);
                    Rec.TestField(Status, Rec.Status::Approved);
                    if REc."Case Status" = Rec."Case Status"::Closed then begin
                        Error('Case Was Closed!')
                    end
                    else
                        if Confirm('Are you sure you want to this case as closed?"') then begin
                            Rec."Case Status" := Rec."Case Status"::Closed;
                            Rec."Action Duration End  Date" := Today;
                            Rec."Case Duration" := Rec."Action Duration End  Date" - Rec."Action Duration Start Date";
                            Rec.Modify;
                            Message('Case Number %1 has been marked as closed', Rec."Case Number");
                        end;
                end;
            }
            // action(Appeal)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = ' Appeal';
            //     Image = ReopenCancelled;
            //     Promoted = true;
            //     PromotedCategory = Category6;
            //     PromotedIsBig = true;
            //     Visible = true;

            //     trigger OnAction()
            //     begin
            //         Rec.TestField("Case Status", Rec."Case Status"::Closed);
            //         Rec.TestField(Status, Rec.Status::Approved);

            //         if Rec.Appealed = true then begin
            //             Error('A case can only be Appealed once');
            //         end;

            //         if Confirm('Are you sure you want to Apeal this case?"') then begin
            //             Rec."Case Status" := Rec."Case Status"::Closed;
            //             Rec.Appealed := true;
            //             Rec.Modify;
            //             Message('Case Number %1 has been marked as "Under Appeal"', Rec."Case Number");
            //         end;
            //     end;
            // }

            action("Case Witness")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Case Witness';
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                RunObject = Page "Witness Line";
                RunPageLink = "Case No" = FIELD("Case Number");
                Scope = Repeater;
            }
            action("Instruction Template")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Instruction Template';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                //RunObject = Report "Instruction Template Ltg";
                trigger OnAction()
                begin
                    Legal.RESET;
                    Legal.SetRange("No.", Rec."No.");
                    Legal.SETRANGE("Case Number", Rec."Case Number");

                    if Legal.Find('-') then begin
                        //Rec.TestField("Case Category", Rec."Case Category"::External);
                        Report.Run(Report::"Instruction Template Ltg", true, false, Legal);
                    end;
                end;
            }
        }
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                // action(Delegate)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Delegate';
                //     Image = Delegate;
                //     Promoted = true;
                //     PromotedCategory = Category6;
                //     Visible = OpenApprovalEntriesExistForCurrUser;

                //     trigger OnAction()
                //     var
                //     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                //     begin
                //         ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                //     end;
                // }
                action(Comment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }

            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;



                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        Rec.Testfield("Case Number");
                        //Rec.TestField("Case Summary");
                        Rec.TestField(Status, Rec.Status::Open);
                        // Rec.TestField("Old No.");
                        // Rec.TestField("Old Case Number");
                        Rec.TESTField("Name of Case");
                        Rec.Testfield("Date of Filing the suit");
                        //Rec.Testfield("Matter Code");
                        Rec.Testfield("Law Firm");
                        Rec.Testfield("Address");
                        Rec.TestField("City");
                        //Rec.TestField("Legal Fees");
                        Rec.testfield("Contigent Liabilities");
                        Rec.TestField("Name of Case");

                        if Rec."Case Category" = Rec."Case Category"::External then
                        REC.TestField("Case Summary");
                        Rec.TestField("Legal Fees");

                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);

                        // legal.RESET;
                        // legal.SETRANGE("Case Number", Rec."Case Number");
                        // if legal.Find('-') then

                        // begin
                        // Rec.TestField("Case Status", Rec."Case Status"::"Open");
                        // IF rec.Status = rec.Status::Approved then
                        // begin 
                        //     rec."Case Status" := rec."Case Status"::"In Progress";
                        //     rec.Modify;
                        //     Message('Case Number %1 approved and is now in Progress', Rec."Case Number");
                        // end;
                        //end;               
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
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category6;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action("Re-Open Document")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category6;
                    Image = ReOpen;

                    trigger OnAction()
                    begin
                        if Rec.Status = Rec.Status::Open then
                            Error('Document is Open!');
                        if not Confirm('Are you sure you want to re-open this document?') then exit;
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                        Message('Document Reopened Sucessfully.');
                    end;
                }
                action(Action52)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        UpdatePageControls;
    end;

    trigger OnOpenPage()
    begin
        UpdatePageControls;
        PageControl;

        // if Rec."Advisory" = true then begin
        //     AdvisoryEditable := true;
        // end
        // else begin
        //     AdvisoryEditable := false;
        // end;

    end;

    procedure SendEmailWithAttachment(var emailadress: Code[50])
    var
        ReportExample: Report "Instruction Template Ltg";
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
        Report.SaveAs(Report::"Instruction Template Ltg", ReportParameters, ReportFormat::Pdf, OutStr);
        TempBlob.CreateInStream(InStr);

        TxtRecipientsList.Add(emailadress);
        EmailMsg.Create(emailadress, 'Litigation Instruction', 'Greetings, Please find the above intrsuctions for your firm and have someone collect them from our offices. Thank you.');
        EmailMsg.AddAttachment('FileName.pdf', 'PDF', InStr);
        Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
    end;




    var
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        "Plaintiff TypeEditable": Boolean;
        // PlaintiffEditable: Boolean;
        // "Description of ComplaintEditable": Boolean;
        // "Accused EmployeeEditable": Boolean;
        // "Accused TypeEdtable": Boolean;
        // ReporterEditable: Boolean;
        // "Reporter TypeEditable": Boolean;
        // "Body Handling The ComplaintEditable": Boolean;
        // "Date of ComplaintEditable": Boolean;
        // "Action Duration Start DateEditable": Boolean;
        // "Action Duration End  DateEditable": Boolean;
         "Case TypeEditable": Boolean;
        CaseSummaryVisible: Boolean;

    //[Scope('OnPrem')]
    procedure PageControl()
    begin
        if Rec."Case Status" = Rec."Case Status"::ADR then begin
            Editable := EditableADR;
        end;
    end;

    procedure UpdatePageControls()
    begin
        /* IF Status<>Status::Approved THEN BEGIN
           "Payment Release DateEditable" :=FALSE;
           "Cheque No.Editable" :=FALSE;
           "Cheque TypeEditable" :=FALSE;
           "Invoice Currency CodeEditable" :=TRUE;
         END ELSE BEGIN
          "Payment Release DateEditable" :=TRUE;
          "Cheque TypeEditable" :=TRUE;
          "Invoice Currency CodeEditable" :=FALSE;
          PaymodeEditable:=TRUE;
          BankEditabl:=TRUE;
          OnBehalfEditable:=TRUE;
          RespEditabl:=TRUE;

         END;*/
        if Rec.Status = Rec.Status::Open then begin
            "Plaintiff TypeEditable" := true;
            // PlaintiffEditable := true;
            // "Description of ComplaintEditable" := true;
            // "Accused TypeEdtable" := true;
            // "Accused EmployeeEditable" := true;
            // ReporterEditable := true;
            // "Reporter TypeEditable" := true;
            // "Reporter TypeEditable" := true;
            // "Body Handling The ComplaintEditable" := true;
            "Case TypeEditable" := true;
        end else
            if Rec.Status = Rec.Status::Approved then begin
                //CaseSummaryVisible := False;
                 "Plaintiff TypeEditable" := false;
                // PlaintiffEditable := false;
                // "Description of ComplaintEditable" := false;
                // "Accused TypeEdtable" := false;
                // "Accused EmployeeEditable" := false;
                // ReporterEditable := false;
                // "Reporter TypeEditable" := false;
                // "Reporter TypeEditable" := false;
                // "Body Handling The ComplaintEditable" := false;
                "Case TypeEditable" := false;
            end else begin
                if Rec.Status = Rec.Status::Pending then begin
                    "Plaintiff TypeEditable" := true;
                    // PlaintiffEditable := true;
                    // "Description of ComplaintEditable" := true;
                    // "Accused TypeEdtable" := true;
                    // "Accused EmployeeEditable" := true;
                    // ReporterEditable := true;
                    // "Reporter TypeEditable" := true;
                    // "Reporter TypeEditable" := true;
                    // "Body Handling The ComplaintEditable" := true;
                    "Case TypeEditable" := true;

                end else begin

                    if Rec."Case Status" = Rec."Case Status"::Closed then begin
                        "Case TypeEditable" := false;

                    end else begin

                        // if Rec."Case Status" = Rec."Case Status"::ADR then begin
                        //     "Case TypeEditable" := false;
                        // end else begin

                        if Rec.Status = Rec.Status::Open then begin
                            //CaseSummaryVisible := TRUE;
                            "Plaintiff TypeEditable" := true;
                            // PlaintiffEditable := true;
                            // "Description of ComplaintEditable" := true;
                            // "Accused TypeEdtable" := true;
                            // "Accused EmployeeEditable" := true;
                            // ReporterEditable := true;
                            // "Reporter TypeEditable" := true;
                            // "Reporter TypeEditable" := true;
                            // "Body Handling The ComplaintEditable" := true;
                            // "Action Duration Start DateEditable" := true;
                            // "Action Duration End  DateEditable" := true;
                            "Case TypeEditable" := true;
                        end;
                        if Rec."Case Category" = Rec."Case Category"::External then begin
                            CaseSummaryVisible := true
                        end
                        else
                            CaseSummaryVisible := false;
                    end;
                end;
            end;
    end;
    //end;

    // procedure SendEmailWithAttachment(var emailadress: Text[50])
    // var
    //     ReportExample: Report "Tenant Statement";
    //     Email: Codeunit Email;
    //     EmailMsg: Codeunit "Email Message";
    //     TempBlob: Codeunit "Temp Blob";
    //     InStr: Instream;
    //     OutStr: OutStream;
    //     ReportParameters: Text;
    //     TxtRecipientsList: List of [Text];
    // begin

    //     ReportParameters := ReportExample.RunRequestPage();
    //     TempBlob.CreateOutStream(OutStr);
    //     Report.SaveAs(Report::"Tenant Statement", ReportParameters, ReportFormat::Pdf, OutStr);
    //     TempBlob.CreateInStream(InStr);

    //     TxtRecipientsList.Add(emailadress);
    //     EmailMsg.Create(emailadress, 'Subject-Statement', 'Body-Sending Tenant Statement');
    //     EmailMsg.AddAttachment('FileName.pdf', 'PDF', InStr);
    //     Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
    // end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Legal: Record Legal;
        AdvisoryEditable: Boolean;
        EditableADR: Boolean;
}

