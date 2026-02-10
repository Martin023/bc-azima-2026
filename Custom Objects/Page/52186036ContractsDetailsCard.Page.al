page 52186036 "Contracts Details Card"
{
    Caption = 'Contract';
    DeleteAllowed = false;
    PageType = Document;
    SourceTable = Contracts;
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    PromotedActionCategories = 'New, Process, Reports, Workflows,Files,Case Forwarding';

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = GeneralSectionEdit;
                field("Contract No"; Rec."Contract No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date of Request"; Rec."Date of Request")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Party to The Contract"; Rec."Party to the Contract")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    Caption = 'Parties To The Contract';
                    MultiLine = True;
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    trigger OnValidate()
                    begin
                        if Rec."Contract Type" = Rec."Contract Type"::" " then begin
                            Visiblelease := false;
                            FieldEditable := False;
                            LeaseEditable := false;
                            LeaseVisible := false;
                            OtherVisible := false;
                        end
                        else
                            if Rec."Contract Type" = Rec."Contract Type"::lease then begin
                                Visiblelease := true;
                                FieldEditable := False;
                                LeaseVisible := true;
                                OtherVisible := false;
                            end
                            else
                                if Rec."Contract Type" = Rec."Contract Type"::"annual maintenance" then begin
                                    Visiblelease := false;
                                    FieldEditable := true;
                                    LeaseVisible := false;
                                    OtherVisible := false;
                                end
                                else
                                    if Rec."Contract Type" = Rec."Contract Type"::"service agreement" then begin
                                        Visiblelease := false;
                                        FieldEditable := true;
                                        LeaseVisible := false;
                                        OtherVisible := false;
                                    end
                                    else
                                        if Rec."Contract Type" = Rec."Contract Type"::"Non Disclosure Agreement" then begin
                                            Visiblelease := false;
                                            FieldEditable := true;
                                            LeaseVisible := false;
                                            OtherVisible := false;
                                        end
                                        else
                                            if Rec."Contract Type" = Rec."Contract Type"::"Data Protection Agreement" then begin
                                                Visiblelease := false;
                                                FieldEditable := true;
                                                LeaseVisible := false;
                                                OtherVisible := false;
                                            end
                                            else
                                                if REC."Contract Type" = Rec."Contract Type"::Other then begin
                                                    Visiblelease := false;
                                                    FieldEditable := true;
                                                    LeaseVisible := false;
                                                    OtherVisible := true;

                                                end;
                    end;
                }
                field("Other Contract Type Description"; Rec."Other Contract Type Descr.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Type Of Service"; Rec."Type Of Service")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = FieldEditable;
                    trigger OnValidate()
                    begin
                        UpdateControls;
                    end;
                }
                // field("Nature Of Service"; Rec."Nature Of Service")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Enabled = NatureOfService;
                //     Visible = false;
                // }
                field("Contract Description"; Rec."Contract Description")
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = True;
                }
                field("Contractor Type"; Rec."Contractor Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contractor No"; Rec."Contractor No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contractor Name"; Rec."Contractor Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Contractor Description"; Rec."Contractor Description")
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                }
                field("Company Number"; Rec."Company Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Place of Business"; Rec."Place of Business")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = LeaseEditable;
                }
                field("Pyhsical Address"; Rec."Physical Address")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = LeaseEditable;
                }
                field("Tel No."; Rec."Tel No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = LeaseEditable;
                }

                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        Duration := '';

                        if (Rec."Start Date" <> 0D) then
                            Duration := HRCodeunit.DetermineAge(Rec."Start Date", Rec."End Date");
                        Rec."Contract Period" := HRCodeunit.DetermineAge(Rec."Start Date", Rec."End Date");
                    end;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    var
                        MyNotification: Notification;
                    begin
                        Duration := '';
                        if (Rec."Start Date" <> 0D) then
                            //Duration := HRCodeunit.DetermineAge(Rec."Start Date", Rec."End Date");
                            Rec."Contract Period" := HRCodeunit.DetermineAge(Rec."Start Date", Rec."End Date");
                        if Rec."End Date" <= Today then begin
                            MyNotification.Message := 'Contract No. %1 has expired!';
                            MyNotification.Scope := NotificationScope::LocalScope;
                            MyNotification.Send();
                        end;
                    end;
                }
                // field(Duration; Rec.Duration)
                // {
                //     Caption = 'Duration';
                //     Editable = false;
                // }
                field("Contract Period"; Rec."Contract Period")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Advocate Name"; Rec."Advocate Name")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                // field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Defect Liability Period"; Rec."Defect Liability Period")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = DefectLiabilityPeriodeditable;
                // }
                // field("Support Period"; Rec."Support Period")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Warranty Period"; Rec."Warranty Period")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Payment Terms"; Rec."Payment Terms")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Board Approval Date"; Rec."Board Approval Date")
                // {"
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Responsible Employee"; Rec."Responsible Employee")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Responsible Employee Name"; Rec."Responsible Employee Name")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("User Department"; Rec."User Department")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contract Amount"; Rec."Contract Sum")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Balance"; Rec."Total Balance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Termination Clause"; Rec."Termination Clause")
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = True;
                }
                field("Renewal Clause"; Rec."Renewal Clause")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                    Visible = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Branch Code';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                Field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Caption = ' Acitivity Code';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        UpdateControls;
                    end;
                }
                field("Contract Status"; Rec."Contract Status")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Terminated; Rec.Terminated)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Expired; Rec.Expired)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Lease Details")
            {
                Visible = LeaseVisible;
                field("L.R No."; Rec."L.R No.")
                {
                    Caption = 'Land Reference Number';
                    Editable = False;
                }
                field("Unit"; Rec."Unit Code")
                {
                    Editable = false;
                }
                field("Floor"; Rec."Floor Code")
                {
                    Editable = false;
                }
                field("Area Sqft"; Rec."Area Sqft")
                {
                    Editable = false;
                }
                field("Lease Start Date"; Rec."Lease Start Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = VisibleLease;
                }
                field("Lease End Date"; Rec."Lease End Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = VisibleLease;
                }
                field("Lease Period"; Rec."Lease Period")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = VisibleLease;
                }
                field("Billing Frequency"; Rec."Billing Frequency")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = VisibleLease;
                }
                field("Escalation For Leases"; Rec."Escalation For Leases")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = VisibleLease;
                }
                field("Escalation Start Date"; Rec."Escalation Start Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = VisibleLease;
                }
                field("Lease Amount"; Rec."Lease Amount Inc VAT")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = VisibleLease;
                }
            }
            part("Contract Milestone Entries"; Milestones)
            {
                SubPageLink = "Contract No" = FIELD("Contract No");
                ApplicationArea = Basic, Suite;
                //Visible = false;
            }
            group("Case Forwarding")
            {
                //Editable = ForwardingEditable;
                field("Send/Forward to"; Rec."Send/Forward to")
                {
                    Editable = ForwardingEditable;
                }
                field("Originating Department"; Rec."Originating Department")
                {
                    Caption = 'Originating Department';
                    Editable = false;
                }
                field("Current Departmrnt"; Rec."Current Department")
                {
                    Caption = 'Current Department';
                    Editable = false;
                }
            }
            group(Termination)
            {
                Editable = TerminationEdit;
                field("Date of Execution"; Rec."Date of Excecution")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Termination Reason"; Rec."Termination Reason")
                {
                    ApplicationArea = Basic, Suite;
                    ColumnSpan = 100;
                    MultiLine = true;
                }
            }
        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(52185942), "No." = field("Contract No");
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
                Visible = NOT IsOfficeAddin;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Co&mments")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "Comment Sheet";
            }
            action("Sub Contracts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sub Contracts';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Sub Contract";
                RunPageLink = "Header Contract No." = FIELD("Contract No");
            }
            // action("Upload Files")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Upload Files';
            //     Enabled = UploadFiles;
            //     Image = FileContract;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     //Visible = false;

            //     trigger OnAction()
            //     var
            //         //SkyFileManagement: Codeunit "Sky File Management";
            //         FileLocation: Text;
            //         SkyTempBlob: Record "Sky TempBlob";
            //         FileName: Text;
            //         ContractDocuments: Record "Contract Documents";
            //         Document: Text;
            //         SelectionTxt: Label '&Upload Indemnity,&Upload Contract,&Upload SLA';
            //     begin
            //         if (Rec.Status <> Rec.Status::New) and (Rec.Status <> Rec.Status::"Pending Approval") then
            //             Error('Status must not be %1', Format(Rec.Status));


            //         Selection := StrMenu(SelectionTxt);


            //         if Selection = 0 then begin
            //             Message('Operation aborted!');
            //         end;

            //         if Selection = 1 then begin
            //             Document := 'Indemnity File';
            //             ContractDocuments.Get('INDEMNITY');
            //             FileName := ContractDocuments."File Location" + '\Indemnity_' + Rec."Contract No" + '.pdf';
            //         end;

            //         if Selection = 2 then begin
            //             Document := 'Contract File';
            //             ContractDocuments.Get('CONTRACT');
            //             FileName := ContractDocuments."File Location" + '\Contract_' + Rec."Contract No" + '.pdf';
            //         end;
            //         if Selection = 3 then begin
            //             Document := 'SLA File';
            //             ContractDocuments.Get('SLA');
            //             FileName := ContractDocuments."File Location" + '\SLA_' + Rec."Contract No" + '.pdf';
            //         end;
            //         // if Selection <> 0 then begin
            //         //     FileLocation := SkyFileManagement.OpenFileDialog(Document, '*.pdf', '');
            //         //     SkyFileManagement.BLOBImportFromServerFile(SkyTempBlob, FileLocation);

            //         //     if Exists(FileName) then begin
            //         //         if not Confirm('There is already another ' + Document + ' that has been uploaded, uploading this one will replace the other one! Would you like to continue?') then
            //         //             Message('Operation aborted!')
            //         //         else begin
            //         //             Erase(FileName);
            //         //             SkyFileManagement.BLOBExportToServerFile(SkyTempBlob, FileName);
            //         //             Message('Indemnity File Uploaded Successfully');
            //         //         end;
            //         //     end else begin
            //         //         SkyFileManagement.BLOBExportToServerFile(SkyTempBlob, FileName);
            //         //         Message('%1 Uploaded Successfully', Document);
            //         //     end;
            //         // end;
            //     end;
            // }
            // action("Download Files")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Download Files';
            //     Image = ExportAttachment;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     //Visible = false;
            //     trigger OnAction()
            //     var
            //         //SkyFileManagement: Codeunit "Sky File Management";
            //         FileLocation: Text;
            //         SkyTempBlob: Record "Sky TempBlob";
            //         FileName: Text;
            //         ContractDocuments: Record "Contract Documents";
            //         Document: Text;
            //         SelectionTxt: Label '&Download Indemnity,&Download Contract,&Download SLA';
            //         Name: Text;
            //     begin
            //         Selection := StrMenu(SelectionTxt);
            //         if Selection = 0 then begin
            //             Message('Operation aborted!');
            //         end;

            //         if Selection = 1 then begin
            //             Document := 'Indemnity';
            //             ContractDocuments.Get('INDEMNITY');
            //             FileName := ContractDocuments."File Location" + '\Indemnity_' + Rec."Contract No" + '.pdf';
            //             Name := 'Indemnity_' + Rec."Contract No" + '.pdf';
            //         end;

            //         if Selection = 2 then begin
            //             Document := 'Contract';
            //             ContractDocuments.Get('CONTRACT');
            //             FileName := ContractDocuments."File Location" + '\Contract_' + Rec."Contract No" + '.pdf';
            //             Name := 'Contract_' + Rec."Contract No" + '.pdf';
            //         end;
            //         if Selection = 3 then begin
            //             Document := 'SLA';
            //             ContractDocuments.Get('SLA');
            //             FileName := ContractDocuments."File Location" + '\SLA_' + Rec."Contract No" + '.pdf';
            //             Name := 'SLA_' + Rec."Contract No" + '.pdf';
            //         end;
            //         //here
            //         // if Selection <> 0 then begin
            //         //     if Exists(FileName) then
            //         //         Download(FileName, Document, '', 'Text file(*.pdf)|*.pdf', Name)
            //         //     else
            //         //         Message('The file you are looking for is not available');
            //         // end;
            //     end;
            // }

            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
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
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
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
                    Enabled = SendApproval;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                        ContractDocuments: Record "Contract Documents";
                        FileName: Text;
                    begin
                        //Rec.TestField("Type Of Service");
                        // TESTFIELD("Nature Of Service");
                        Rec.TestField("Start Date");
                        Rec.TestField("End Date");
                        Rec.TestField("Contractor Type");
                        Rec.TestField("Contractor No");
                        Rec.TestField(Address);
                        Rec.TestField("Tel No.");
                        if Rec."Type Of Service" = Rec."Type Of Service"::Services then begin
                            //Rec.TestField("Defect Liability Period");
                            //Rec.TestField("Warranty Period");
                        end;
                        if Rec."Type Of Service" = Rec."Type Of Service"::Goods then begin
                            // Rec.TestField("Support Period");
                        end;
                        //Rec.TestField("Payment Terms");
                        //Rec.TestField("Board Approval Date");
                        //Rec.TestField("Responsible Employee");
                        //Rec.TestField("User Department");
                        //Rec.TestField(Remarks);
                        Rec.TestField(Status, Rec.Status::New);

                        //ContractDocuments.Get('CONTRACT');
                        //FileName := ContractDocuments."File Location" + '\Contract_' + Rec."Contract No" + '.pdf';


                        Rec.TestField(Status, Rec.Status::New);
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);

                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CancelApproval;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        Rec.TestField(Status, Rec.Status::"Pending Approval");
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;

                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        approvalsMgmt: Codeunit 1535;
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action("Terminate Contract")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Terminate Contract';
                    Enabled = TerminateContract;
                    Image = CarryOutActionMessage;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField("Termination Reason");
                        Rec.TestField(Status, Rec.Status::Approved);
                        if Confirm('Are you sure you want to Terminate This Contract?') then begin
                            Rec.Terminated := true;
                            Rec."Contract Status" := Rec."Contract Status"::"Terminated";
                            Rec.Modify;
                            Message('Contract Number %1 has been Terminated', Rec."Contract No");
                        end;
                    end;
                }
                action("View Contract")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'View Contract';
                    Image = View;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    trigger OnAction()
                    begin

                        Contract.RESET;
                        Contract.setrange("Contract No", Rec."Contract No");
                        if Contract.Find('-') then begin
                            if Rec."Contract Type" = Rec."Contract Type"::" " then begin
                                Error('Please Select Contract Type');
                            end
                            else
                                if Rec."Contract Type" = Rec."Contract Type"::lease then begin
                                    Report.Run(Report::"Lease Contract Report", true, false, Contract);
                                end
                                else
                                    if Rec."Contract Type" = Rec."Contract Type"::"Non Disclosure Agreement" then begin
                                        Report.Run(Report::"NDA Contract", true, false, Contract);
                                    end
                                    else
                                        if Rec."Contract Type" = Rec."Contract Type"::"Data Protection Agreement" then begin
                                            Report.Run(Report::"DPA Contract", true, false, Contract);
                                        end;
                        end;
                    end;
                }
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
                    RunPageLink = "Header No." = field("Contract No");
                    RunPageView = where(Types = CONST(comment));
                }
                action("Return Documents")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Return;
                    Promoted = true;
                    PromotedCategory = Category6;

                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        if Rec."Send/Forward to" = Rec."Current Department" then Error('You cannot return this document to %1 while its already in %1', Rec."Send/Forward to");
                        Comments.Reset();
                        Comments.SetRange("Header No.", Rec."Contract No");
                        if Comments.FindLast() then begin
                            if Comments."Commented By" <> UserId then Error('Kindly leave a comment');
                            if Comments.Comment = '' then Error('Kindly leave a comment');
                        end else
                            Error('Kindly add a comment');
                        if not Confirm('Are you sure you want to return this document?') then exit;
                        if Rec."Originating Department" = Rec."Send/Forward to" then begin
                            // Rec."Originator Status" := Rec."Originator Status"::Returned;
                            // Rec."Recepient Status" := Rec."Recepient Status"::Returned;

                            CFPage.InsertTracker(Rec."Contract No", Rec."Send/Forward to", true, UserId, CurrentDateTime);
                            Rec."Current Department" := Rec."Send/Forward to";
                            Rec.Modify();
                            Message('Case sent successfully');
                        end
                        else begin
                            Error('You Can Only Return to the Originating Department!');
                        end;
                    end;
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
                        Comments.SetRange("Header No.", Rec."Contract No");
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
                        CFPage.InsertTracker(Rec."Contract No", Rec."Send/Forward to", true, UserId, CurrentDateTime);
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
                    RunPageLink = "Header No." = field("Contract No");
                }
            }
            group(Documents)
            {
                action("Upload File")
                {
                    Promoted = true;
                    PromotedCategory = Category5;
                    Image = Documents;

                    trigger OnAction()
                    var
                        myInt: Integer;
                        Base64Convert: Codeunit "Base64 Convert";
                        TempBlob: Codeunit "Temp Blob";
                        InStr: InStream;
                        ApplicantMember: Record Members;
                        Outstream: OutStream;
                        InputFile: File;
                        EDMSFunctions: Codeunit "EDMS Functions";
                        ContractFile: Record "Contract Files";
                        FileName: Text;
                        FileContentsB64: Text;
                    begin
                        if Rec."Contract No" <> '' then begin
                            FileName := EDMSFunctions.PickEDMSFile(TempBlob);
                            TempBlob.CreateInStream(InStr);
                            FileContentsB64 := Base64Convert.ToBase64(InStr);
                            if FileName <> '' then begin
                                // InputFile.Open(FileName);
                                // InputFile.CreateInStream(InStr);
                                ContractFile.Blob.CreateOutStream(Outstream);
                                CopyStream(Outstream, InStr);
                                // InputFile.Close();
                                // Message('Intostream');
                                // InputFile.WriteMode(true);
                                // InputFile.Create(FileName);
                                // InputFile.CreateOutStream(Outstream);
                                ContractFile.Blob.CreateInStream(InStr);
                                CopyStream(Outstream, InStr);
                                // InputFile.Close();
                            end;
                        end;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        UpdateControls();
    end;

    trigger OnAfterGetRecord()
    begin
        Duration := '';

        if (Rec."Start Date" <> 0D) then
            Duration := HRCodeunit.DetermineAge(Rec."Start Date", Rec."End Date");
    end;

    trigger OnInit()
    begin
        SupportPeriodEditable := true;
        WarrantyPeriodeditable := true;
        //DefectLiabilityPeriodeditable := true;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;

    end;
    // trigger OnOpenPage()
    // var
    //     OfficeMgt: Codeunit "Office Management";
    //     HasFilters: Boolean;
    // begin
    //     HasFilters := Rec.GetFilters() <> '';
    //     //Rec.SetSecurityFilterOnRespCenter();
    //     if HasFilters and not Rec.Find() then
    //         if Rec.FindFirst() then;
    //     IsOfficeAddin := OfficeMgt.IsAvailable();
    //     IsOfficeAddin := true;
    // end;

    var
        IsOfficeAddin: Boolean;
        ContMilestones: Record Milestones;
        ContMilestones2: Record "Contract Cycle Stage";
        StageNo: Integer;
        CopyContr: Record Contracts;
        ChkContLastStage: Record "Contract Cycle Stage";
        LastStage: Boolean;
        Expectations: Record "Contract Expectation Details";
        AllStages: Record "All Stages Per Contract";
        Invoiced: Boolean;
        DefectLiabilityPeriodeditable: Boolean;
        SupportPeriodEditable: Boolean;
        WarrantyPeriodeditable: Boolean;
        //OnAfterGetCurrRecord: Integer;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        ApprovalsMgmt: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        Duration: Text[100];
        HRCodeunit: Codeunit "HR Codeunit";
        Selection: Integer;
        NatureOfService: Boolean;
        GeneralSectionEdit: Boolean;
        UploadFiles: Boolean;
        SendApproval: Boolean;
        CancelApproval: Boolean;
        TerminateContract: Boolean;
        TerminationEdit: Boolean;
        VisibleLease: Boolean;
        Contract: Record Contracts;
        Customers: Record Customer;
        FieldEditable: Boolean;
        LeaseEditable: Boolean;
        LeaseVisible: Boolean;
        OtherVisible: Boolean;
        CaseTracker: Record "CF Tracker";
        CFPage: Page "DMU CF Page";
        CFStations: Record "CF Station Actions";
        Comments: Record Comments;
        ForwardingEditable: Boolean;
    //SkyFileManagement: Codeunit "Sky File Management";

    //[Scope('OnPrem')]

    procedure UpdateControls()
    begin

        if Rec."Type Of Service" = Rec."Type Of Service"::Goods then
            NatureOfService := false;
        if Rec."Type Of Service" = Rec."Type Of Service"::Services then
            NatureOfService := true;

        if Rec.Status = Rec.Status::New then begin
            GeneralSectionEdit := true;
            UploadFiles := true;
            SendApproval := true;
            TerminateContract := false;
            CancelApproval := false;
            TerminationEdit := false;
        end;

        if Rec.Status = Rec.Status::Approved then begin
            GeneralSectionEdit := false;
            UploadFiles := false;
            SendApproval := false;
            TerminateContract := true;
            CancelApproval := false;
            TerminationEdit := true;
        end;

        if Rec.Status = Rec.Status::"Pending Approval" then begin
            GeneralSectionEdit := false;
            UploadFiles := false;
            SendApproval := false;
            TerminateContract := false;
            CancelApproval := true;
            TerminationEdit := false;
        end;

        if Rec.Status = Rec.Status::Rejected then begin
            GeneralSectionEdit := false;
            UploadFiles := false;
            SendApproval := false;
            TerminateContract := false;
            CancelApproval := false;
            TerminationEdit := false;
        end;

        if Rec.Terminated = true then begin
            TerminationEdit := false;
            GeneralSectionEdit := false;
            UploadFiles := false;
            SendApproval := false;
            TerminateContract := false;
            CancelApproval := false;
            TerminationEdit := false;
        end;
    end;
}

