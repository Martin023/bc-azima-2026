page 52186105 "Appealed Legal Card"
{
    PageType = Card;
    SourceTable = "Appeals Table";
    DeleteAllowed = true;
    PromotedActionCategories = 'Document,Home,New,Creation,Advocate,Approval,Process';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Case Number"; Rec."Case Number")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Plaintiff TypeEditable";
                    ShowMandatory = True;
                }
                field("Old No."; Rec."Old No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Plaintiff TypeEditable";
                    ShowMandatory = True;
                }
                field("Old Case Number"; Rec."Old Case Number")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Advisory; Rec."Advisory")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Advisory';
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
                    MultiLine = true;
                    ApplicationArea = Basic, Suite;
                    //Editable = "Plaintiff TypeEditable";
                    Editable = AdvisoryEditable;
                    //ShowMandatory = True;
                }
                field("Predicted Outcome"; Rec."Predicted Outcome")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Plaintiff TypeEditable";
                    ShowMandatory = True;
                }
                field("Date of filing the suit"; Rec."Date of Filing the suit")
                {
                    Caption = 'Date of filing the suit';
                    ApplicationArea = Basic, Suite;
                    Editable = "Plaintiff TypeEditable";
                    ShowMandatory = True;
                }
                field("Case Type"; Rec."Case Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Case TypeEditable";
                    ShowMandatory = True;
                    
                }
                field("Case Description"; Rec."Case Description")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ShowMandatory = True;
                }
                field("Case Category"; Rec."Case Category")
                {
                    Caption = 'Case Category';
                    ApplicationArea = Basic,Suite;
                    Editable = "Plaintiff TypeEditable";
                    ShowMandatory = True;
                    trigger OnValidate()
                    begin
                        if Rec."Case Category" =  Rec."Case Category"::External then 
                        begin
                            CaseSummaryVisible := true;
                        end
                        else
                        if Rec."Case Category" = Rec."Case Category"::Internal then
                        begin
                            CaseSummaryVisible := false;
                        end;
                    end;
                }
                field("Law Firm"; Rec."Law Firm")
                {
                    ApplicationArea = Basic, SUite;
                    Editable = "Plaintiff TypeEditable";
                    ShowMandatory = True;
                }
                field("Lawyer"; Rec."Lawyer")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    //Editable = "Plaintiff TypeEditable";
                }
                field(Address;Rec.Address)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Plaintiff TypeEditable";
                    ShowMandatory = True;
                }
                field(City;Rec.City)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Plaintiff TypeEditable";
                    ShowMandatory = True;
                }
                // field("Type of Court"; Rec."Type of Court")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = "Plaintiff TypeEditable";
                //     ShowMandatory = True;
                // }
                field("Budgeted Cost"; Rec."Budgeted Cost")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Plaintiff TypeEditable";
                    //ShowMandatory = True;
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
                //field("Description of Complaint"; Rec."Description of Complaint")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = "Description of ComplaintEditable";
                // }
                // field("Pleadings in Summary"; Rec."Pleadings in Summary")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Status of the Case"; Rec."Case Status")
                // {
                //     ApplicationArea = Basic, Suite;
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
                    Editable = CaseSummaryVisible;

                }
                field("Pleadings in Summary"; Rec."Pleadings in Summary")
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                    Editable = "Plaintiff TypeEditable";
                    ShowMandatory = True;
                }

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
                //     Editable = "Accused TypeEdtable";
                // }
                // field("Accused Employee"; Rec."Accused Employee")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = "Accused EmployeeEditable";
                // }
                // field("Accused Name"; Rec."Accused Name")
                // {
                //     ApplicationArea = Basic, Suite;
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
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Global Dimension 1"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Global Dimension 2"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                // field("Total Cost"; Rec."Total Cost")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
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
                // field(Appealed; Rec.Appealed)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                // }
            }
            // part("Appeal Line"; "Appealed Lines")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Appeal Lines';
            //     SubPageLink = No = FIELD("Case Number"), "Appeal No" = FIELD("No.");
                
            //     //Visible = true;
            //     //Editable = true;
            // }
            part("Legal Line"; "Legal Line")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Legal Line';
                SubPageLink = No = FIELD("Case Number");
                Visible = true;
                //Editable = true;
            }
            part(Control9; "Verdict List")
            {
                Caption = 'Verdict List';
                ApplicationArea = Basic, Suite;
                SubPageLink = No = FIELD("Case Number");
                //Visible = true;
                //Editable = true;
                //Editable = UseLines;
            }
            part("Upcoming Matters"; "Upcoming Matters")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Upcoming Matters';
                SubPageLink = "Record ID" = FIELD("Case Number"), No = FIELD("No.");
                Visible = true;
                Editable = TRUE;
            }
            field(Comments; Rec.Comments)
            {
                ApplicationArea = Basic, Suite;
                MultiLine = true;
                Editable = True;
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
        }
    }

    actions
    {
        area(creation)
        {
            action("Case Cost")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Case Cost';
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                RunObject = Page "Case Cost List";
                RunPageLink = Code = FIELD("Case Number");
            }
            action(Advocate)
            {
                ApplicationArea = Basic, Suite;
                Image = Addresses;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                RunObject = Page "Advocate List";
                RunPageLink = No = FIELD("Case Number");
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
            //     RunPageLink = "Case No" = FIELD("Case Number");
            // }
            // action(Appeal)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = ' Appeal';
            //     Image = ReopenCancelled;
            //     Promoted = true;
            //     PromotedCategory = Category5;
            //     PromotedIsBig = true;
            //     Visible = true;

            //     trigger OnAction()
            //     begin
            //         Rec.TestField("Case Status", Rec."Case Status"::Closed);

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
                    Rec.TestField("Case Status", Rec."Case Status"::"Open");

                    if Confirm('Are you sure you want to this create this case?"') then begin
                        Rec."Case Status" := Rec."Case Status"::Ongoing;
                        Rec.Modify;
                        Message('Case Number %1 has been marked as On going', Rec."Case Number");
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
                    Rec.TestField("Case Status", Rec."Case Status"::Open);
                    Rec.TestField("Case Status",Rec."Case Status"::Ongoing);

                    if Rec."Case Status" = Rec."Case Status"::ADR then begin
                        Error('ADR can only be initiated once');
                    end;

                    if Confirm('Are you sure you want to Set this case Under ADR?') then begin
                        Rec."Case Status" := Rec."Case Status"::ADR;
                        Rec.ADR := true;
                        Rec.Modify;
                        Message('Case Number %1 has been marked as "Under Appeal"', Rec."Case Number");
                    end;

                end;

            }
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
            // action("Instruction Template")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Instruction Template';
            //     Promoted = true;
            //     PromotedCategory = Report;
            //     PromotedIsBig = true;
            //     trigger OnAction()
            //     begin
            //         Legal.RESET;
            //         Legal.SETRANGE("Case Number", Rec."Case Number");
            //         if Legal.Find('-') then begin
            //             Report.Run(Report::"Instruction Template Ltg", true, false, Legal);
            //         end;
            //     end;
            // }
            // action("Pending Hearing")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Pending Hearing';
            //     Image = ReopenCancelled;
            //     Promoted = true;
            //     PromotedCategory = Category5;
            //     PromotedIsBig = true;
            //     Visible = true;

            //     trigger OnAction()
            //     begin
            //         Rec.TestField("Case Status", Rec."Case Status"::Open);

            //         if Confirm('Are you sure you want to this case as Pending Hearing?"') then begin
            //             Rec."Case Status" := Rec."Case Status"::"Pending Hearing";
            //             Rec.Modify;
            //             Message('Case Number %1 has been marked as Pending Hearing', Rec."Case Number");
            //         end;
            //     end;
            //}
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
                    Rec.TestField("Case Status", Rec."Case Status"::Ongoing);
                    //Rec.TESTFIELD("Case Verdict");
                    if Confirm('Are you sure you want to this case as closed?"') then begin
                        Rec."Case Status" := Rec."Case Status"::Closed;
                        Rec."Action Duration End  Date" := TODAY;
                        Rec.Modify;
                        Message('Case Number %1 has been marked as closed', Rec."Case Number");
                    end;
                end;
            }
            action("Instruction Template")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Instruction Template';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    Legal.RESET;
                    Legal.SETRANGE("Case Number", Rec."Case Number");
                    if Legal.Find('-') then
                    begin
                        Rec.TestField("Case Category", Rec."Case Category"::External);
                        Report.Run(Report::"Instruction Template Ltg",true,false,Legal);
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
                //     PromotedCategory = Category4;
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
                        Rec.TestField(Status, Rec.Status::New);
                        Rec.TestField("Old No.");
                        Rec.TestField("Old Case Number");
                        Rec.TESTField("Name of Case");
                        Rec.Testfield("Date of Filing the suit");
                        Rec.Testfield("Case Type");
                        Rec.Testfield("Law Firm");
                        Rec.Testfield("Address");
                        Rec.TestField("City");
                        Rec.TestField("Legal Fees");
                        Rec.testfield("Contigent Liabilities");
                        Rec.TestField("Name of Case");


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
    end;

    var
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        "Plaintiff TypeEditable": Boolean;
        PlaintiffEditable: Boolean;
        "Description of ComplaintEditable": Boolean;
        "Accused EmployeeEditable": Boolean;
        "Accused TypeEdtable": Boolean;
        ReporterEditable: Boolean;
        "Reporter TypeEditable": Boolean;
        "Body Handling The ComplaintEditable": Boolean;
        "Date of ComplaintEditable": Boolean;
        "Action Duration Start DateEditable": Boolean;
        "Action Duration End  DateEditable": Boolean;
        "Case TypeEditable": Boolean;
        CaseSummaryVisible: Boolean;

    //[Scope('OnPrem')]
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


        if Rec.Status = Rec.Status::Approved then begin
            "Plaintiff TypeEditable" := false;
            PlaintiffEditable := false;
            "Description of ComplaintEditable" := false;
            "Accused TypeEdtable" := false;
            "Accused EmployeeEditable" := false;
            ReporterEditable := false;
            "Reporter TypeEditable" := false;
            "Reporter TypeEditable" := false;
            "Body Handling The ComplaintEditable" := false; 
            "Case TypeEditable" := false;

        end else begin
        if Rec.Status = Rec.Status::"Pending Approval" then begin
            "Plaintiff TypeEditable" := true;
            PlaintiffEditable := true;
            "Description of ComplaintEditable" := true;
            "Accused TypeEdtable" := true;
            "Accused EmployeeEditable" := true;
            ReporterEditable := true;
            "Reporter TypeEditable" := true;
            "Reporter TypeEditable" := true;
            "Body Handling The ComplaintEditable" := true;
            "Case TypeEditable" := true;

        end else begin
            if Rec.Status = Rec.Status::New then begin
                "Plaintiff TypeEditable" := true;
                PlaintiffEditable := true;
                "Description of ComplaintEditable" := true;
                "Accused TypeEdtable" := true;
                "Accused EmployeeEditable" := true;
                ReporterEditable := true;
                "Reporter TypeEditable" := true;
                "Reporter TypeEditable" := true;
                "Body Handling The ComplaintEditable" := true;
                "Action Duration Start DateEditable" := true;
                "Action Duration End  DateEditable" := true;
                "Case TypeEditable" := true;
            end;
        end;

            if Rec."Case Category" = Rec."Case Category"::External then begin
                CaseSummaryVisible := true
            end
            else
                CaseSummaryVisible := false;
        end;
    end;


    var
        Legal: Record Legal;
        UseLines: Boolean;
        AdvisoryEditable: Boolean;
}


