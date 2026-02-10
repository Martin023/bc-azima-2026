page 52186525 "HR 360 Appraisal Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions,Appraisal,,,,Approvals';
    SourceTable = "HR Appraisal Header";


    layout
    {
        area(content)
        {
            group("HR Appraisal Header")
            {
                field("Appraisal No"; Rec."Appraisal No")
                {
                    ApplicationArea=all;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Appraisal Date"; Rec."Appraisal Date")
                {
                    ApplicationArea=all;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Importance = Promoted;
                    ApplicationArea=all;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Importance = Promoted;
                    ApplicationArea=all;
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ApplicationArea=all;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea=all;
                }
                // field(Picture; Rec.Picture)
                // {
                //     Editable = false;
                // }
                field(Department; Rec.Department)
                {
                    ApplicationArea=all;

                }
                field("Supervisor Employee No"; Rec."Supervisor Employee No")
                {
                    ApplicationArea=all;
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                    Editable = false;
                    ApplicationArea=all;
                }
                field("Supervisor Job Title"; Rec."Supervisor Job Title")
                {
                    Editable = false;
                    ApplicationArea=all;
                }
                // field("Supervisor UserID"; Rec."Supervisor UserID")
                // {
                //     Editable = false;
                // }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    Editable = true;
                    ApplicationArea=all;
                }
                field("Evaluation Period Start"; Rec."Evaluation Period Start")
                {
                    ApplicationArea=all;
                }
                field("Evaluation Period End"; Rec."Evaluation Period End")
                {
                    ApplicationArea=all;
                }
                // field("Appraisal Method"; Rec."Appraisal Method")
                // {

                //     trigger OnValidate()
                //     begin

                //         //Testfields
                //         Rec.TestField(Status, rec.Status::Open);
                //         Rec.TestField("Appraisal Method");

                //         if Confirm(Text0003, false, Rec."Appraisal Method") = false then begin
                //             Error('Process aborted, Press F5 to discard changes');
                //         end else begin
                //             //Delete Lines
                //             HRAppLines.Reset;
                //             HRAppLines.SetRange(HRAppLines."Appraisal No", Rec."Appraisal No");
                //             HRAppLines.SetRange(HRAppLines."Appraisal Period", Rec."Appraisal Period");
                //             HRAppLines.SetRange(HRAppLines."Employee No", Rec."Employee No");
                //             if HRAppLines.Find('-') then begin
                //                 HRAppLines.DeleteAll;
                //                 //Subpage Visibility
                //                 fn_ShowSubPages;
                //             end;

                //         end;
                //     end;
                // }
                field("Appraisal Stage"; Rec."Appraisal Stage")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea=all;
                }
                field("Appraisal Quarters"; Rec."Appraisal Quarters")
                {
                    Editable = false;
                    ApplicationArea=all;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea=all;
                }
            }
            part(PersonalObjectives; "HR 360 Appraisal Lines - PG")
            {
                ApplicationArea=all;
                ShowFilter = false;
                SubPageLink = "Appraisal No" = FIELD("Appraisal No"),
                              "Appraisal Period" = FIELD("Appraisal Period"),
                              "Employee No" = FIELD("Employee No");
            }
            part(JobSpecificObjectives; "HR 360 Appraisal Lines - JS")
            {
                ApplicationArea=all;
                ShowFilter = false;
                SubPageLink = "Appraisal No" = FIELD("Appraisal No"),
                              "Appraisal Period" = FIELD("Appraisal Period"),
                              "Employee No" = FIELD("Employee No");
            }
            part(EmployeeSubordinatesObjectives; "HR 360 Appraisal Lines - ES")
            {
                ApplicationArea=all;
                ShowFilter = false;
                SubPageLink = "Appraisal No" = FIELD("Appraisal No"),
                              "Appraisal Period" = FIELD("Appraisal Period"),
                              "Employee No" = FIELD("Employee No");

            }
            part(PeerObjectives; "HR 360 Appraisal Lines - EP")
            {
                ApplicationArea=all;
                ShowFilter = false;
                SubPageLink = "Appraisal No" = FIELD("Appraisal No"),
                              "Appraisal Period" = FIELD("Appraisal Period"),
                              "Employee No" = FIELD("Employee No");

            }
            part(ExternalSourcesObjectives; "HR 360 Appraisal Lines - ExS")
            {
                ApplicationArea=all;
                ShowFilter = false;
                SubPageLink = "Appraisal No" = FIELD("Appraisal No"),
                              "Appraisal Period" = FIELD("Appraisal Period"),
                              "Employee No" = FIELD("Employee No");

            }
        }
        area(factboxes)
        {
            systempart(Control43; Outlook)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action1000000008)
            {
                Caption = 'Functions';
                // action("Load Appraisal Sections")
                // {
                //     Image = CreateInteraction;
                //     Promoted = true;
                //     PromotedCategory = Category5;

                //     trigger OnAction()
                //     begin
                //         //Rec.TestField("Job Title");
                //         Rec.TestField(Status, rec.Status::Open);
                //         Rec.TestField("Appraisal Stage", Rec."Appraisal Stage"::"Target Setting");


                //         if Confirm(Text0001, false) = false then exit;

                //         //Job Specific
                //         HRAppEvalAreas.Reset;
                //         HRAppEvalAreas.SetRange(HRAppEvalAreas."Categorize As", HRAppEvalAreas."Categorize As"::"Job Specific");
                //         HRAppEvalAreas.SetRange(HRAppEvalAreas."Assign To", Rec."Job Title");
                //         HRAppEvalAreas.SetRange(HRAppEvalAreas."Appraisal Period", Rec."Appraisal Period");
                //         HRAppEvalAreas.SetRange(HRAppEvalAreas.Blocked, false);
                //         if HRAppEvalAreas.Find('-') then begin
                //             HRAppLines.Reset;
                //             HRAppLines.SetRange(HRAppLines."Appraisal No", Rec."Appraisal No");
                //             HRAppLines.SetRange(HRAppLines."Appraisal Period", Rec."Appraisal Period");
                //             HRAppLines.SetRange(HRAppLines."Employee No", Rec."Employee No");
                //             HRAppLines.SetRange(HRAppLines."Categorize As", HRAppLines."Categorize As"::"Job Specific");
                //             if HRAppLines.Find('-') then begin
                //                 HRAppLines.DeleteAll;
                //                 fn_LoadSections;
                //             end else begin
                //                 fn_LoadSections;
                //             end;
                //         end else begin
                //             //if no sections are found
                //             Error(Text0002, Rec."Job Title", Rec."Appraisal Period");
                //         end;

                //         //360 Sections
                //         case Rec."Appraisal Method" of
                //             Rec."Appraisal Method"::"360 Appraisal":
                //                 begin
                //                     fn_Load360Sections;
                //                 end;
                //         end;
                //     end;
                // }
                action("HR Targets")
                {

                }
                // action(SendSupervisor)
                // {
                //     Caption = 'Send to Supervisor';
                //     Image = ReOpen;
                //     Promoted = true;
                //     PromotedCategory = Category5;

                //     trigger OnAction()
                //     begin
                //         Rec.TestField("Appraisal Stage", Rec."Appraisal Stage"::"Target Setting");
                //         Rec.TestField("Employee No");

                //         if Confirm('Send to supervisor?', false) = false then exit;

                //         Rec."Appraisal Stage" := Rec."Appraisal Stage"::"Target Approval";
                //         Message('Appraisal sent to supervisor');
                //     end;
                // }
                // action(ReturnAppraisee)
                // {
                //     Caption = 'Return to Appraisee';
                //     Image = ReopenCancelled;
                //     Promoted = true;
                //     PromotedCategory = Category5;

                //     trigger OnAction()
                //     begin
                //         Rec.TestField("Appraisal Stage", Rec."Appraisal Stage"::"Target Approval");

                //         if Confirm('Return to appraisee?', false) = false then exit;

                //         Rec."Appraisal Stage" := Rec."Appraisal Stage"::"Target Setting";
                //         Message('Appraisal returned to appraisee');
                //     end;
                // }
                // action(ReturnSupervisor)
                // {
                //     Caption = 'Return to Supervisor';
                //     Image = Return;
                //     Promoted = true;
                //     PromotedCategory = Category5;

                //     trigger OnAction()
                //     begin
                //         Rec.TestField("Appraisal Stage", Rec."Appraisal Stage"::"End Year Evalauation");

                //         if Confirm('Return to supervisor?', false) = false then exit;

                //         Rec."Appraisal Stage" := Rec."Appraisal Stage"::"Target Approval";
                //         Message('Appraisal returned to supervisor');
                //     end;
                // }
                // action(ApproveTargets)
                // {
                //     Caption = 'Approve Targets';
                //     Image = Approval;
                //     Promoted = true;
                //     PromotedCategory = Category5;

                //     trigger OnAction()
                //     begin
                //         /*
                //         Rec.TESTFIELD("Appraisal Stage","Appraisal Stage"::"Target Approval");
                //         Rec.TESTFIELD("Employee No");

                //         IF CONFIRM('Approve targets?',FALSE) = FALSE THEN EXIT;

                //         "Appraisal Stage":="Appraisal Stage"::"End Year Evalauation";
                //         MESSAGE('Appraisal targets approved');
                //         */

                //     end;
                // }
                action(SendApprovalRequest)
                {
                    Caption = 'Send To Supervisor';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    ApplicationArea=all;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        Rec.TestField("Employee No");
                        Rec."Appraisal Stage" := Rec."Appraisal Stage"::"Target Approval";
                        Rec.Modify;
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);



                        //if Confirm('Send to supervisor?', false) = false then exit;


                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;
                    ApplicationArea=all;

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
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;
                    ApplicationArea=all;

                    trigger OnAction()
                    var
                        // // //ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
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
                    RunPageLink = "Header No." = field("Appraisal No");
                    RunPageView = where(Types = CONST(comment));
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        /*
      //GET APPLICANT DETAILS FROM HR EMPLOYEES TABLE AND COPY THEM TO THE GOAL SETTING TABLE
      HREmp.RESET;
      IF HREmp.GET("Employee No") THEN
      BEGIN
          "Employee Name":=HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
          "Date of Employment":=HREmp."Date Of Join";
          "Global Dimension 1 Code":=HREmp."Dimension 1 Code";
          "Global Dimension 2 Code":=HREmp."Dimension 2 Code";
          "Job Title":=HREmp."Job ID";
          "Contract Type":= HREmp."Contract Type" ;
          "User ID":=HREmp."User ID";
          //Supervisor
          //Supervisor:=HREmpCard.GetSupervisor("User ID");
          //Superisor ID
          //"Supervisor ID":=HREmpCard.GetSupervisorID("User ID");
          HREmp.CALCFIELDS(HREmp.Picture);
          Picture:=HREmp.Picture;


      END ELSE
      BEGIN
          ERROR('Employee No'+' '+"Employee No"+' '+'is not assigned to any employee. Consult the HR Officer so as to be setup as an employee')
      END;


         */
        //Show Hide Subpages

        fn_ShowSubPages;

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Insert current appraisal period
        HRLookupVal.Reset;
        HRLookupVal.SetRange(HRLookupVal.Type, HRLookupVal.Type::"Appraisal Period");
        if HRLookupVal.Find('-') then begin
            Rec."Appraisal Period" := HRLookupVal.Code;
        end else begin
            Error('No appraisal period have been defined');
        end;

        // Rec.Reset;
        // Rec.SetRange(Rec."User ID", UserId);
        // //Rec.SetRange(Rec.Status);
        // if xRec.Find('-') then
        //     Error('Your application no' + ' ' + xRec."Appraisal No" + 'is still  pending.')
    end;




    trigger OnOpenPage()
    begin
        HRSetup.Reset();

        HRSetup.SetRange("Max Appraisal Rating", HRAppLines."Max Target Score");
        if hrsetup.FindFirst() then begin
            HRAppLines."Max Target Score" := HRSetup."Max Appraisal Rating";
            //HRAppLines."Min. Target Score" := hrsetup."Min Appraisal Rating";
        end;
        if rec."Appraisal Stage" = rec."Appraisal Stage"::"Target Approval" then
            CurrPage.Editable := false;
    end;


    var
        HRAppEvalAreas: Record "HR Appraisal Eval Areas";
        HRAppLines: Record "HR Appraisal Lines";
        Text0001: Label 'Load Appraisal Sections?. \\NB: Existing Lines will be deleted';
        HRAppLines2: Record "HR Appraisal Lines";
        HREmp: Record "HR Employees";
        HREmpCard: Page "HR Employee Card";
        HRAppHeader: Record "HR Appraisal Header";
        Text0002: Label 'No job specific sections for [Job ID: %1] are defined for the appraisal period %2';
        LastLineNo: Integer;
        HRJobResp: Record "HR Job Responsiblities";
        HRSetup: Record "HR Setup";
        HREmp2: Record "HR Employees";
        OpenApprovalEntriesExist: Boolean;
        SubPageVisible: Boolean;
        Text0003: Label 'Change Appraisal Method to [%1]? \\NB: Existing Lines will be deleted';
        HRLookupVal: Record "HR Lookup Values";
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;



    //[Scope('OnPrem')]
    procedure enableDisable() enableDisable: Boolean
    begin
        enableDisable := false;
    end;

    //[Scope('OnPrem')]
    procedure fn_LoadSections()
    begin
        //Load Job Specific Evaluation Sections

        repeat
            //Get last no.
            HRAppLines2.Reset;
            if HRAppLines2.Find('+') then begin
                LastLineNo := HRAppLines2."Line No";
            end else begin
                LastLineNo := 1;
            end;
            HRAppLines.Init;
            HRAppLines."Line No" := LastLineNo + 1;
            HRAppLines."Appraisal No" := Rec."Appraisal No";
            HRAppLines."Appraisal Period" := Rec."Appraisal Period";
            HRAppLines."Employee No" := Rec."Employee No";
            HRAppLines."Categorize As" := HRAppEvalAreas."Categorize As";
            HRAppLines."Sub Category" := HRAppEvalAreas."Sub Category";
            HRAppLines."Perfomance Goals and Targets" := HRAppEvalAreas.Description;
            HRAppLines."Unit of Measure" := HRAppEvalAreas."Unit of Measure";
            HRAppLines.Insert;
        until HRAppEvalAreas.Next = 0;
    end;

    //[Scope('OnPrem')]
    procedure fn_Load360Sections()
    begin

        //Employee's Subordinates
        HRAppEvalAreas.Reset;
        HRAppEvalAreas.SetRange(HRAppEvalAreas."Categorize As", HRAppEvalAreas."Categorize As"::"Employee's Subordinates");
        HRAppEvalAreas.SetRange(HRAppEvalAreas."Appraisal Period", Rec."Appraisal Period");
        if HRAppEvalAreas.Find('-') then begin
            HRAppLines.Reset;
            HRAppLines.SetRange(HRAppLines."Appraisal No", Rec."Appraisal No");
            HRAppLines.SetRange(HRAppLines."Appraisal Period", Rec."Appraisal Period");
            HRAppLines.SetRange(HRAppLines."Employee No", Rec."Employee No");
            HRAppLines.SetRange(HRAppLines."Categorize As", HRAppLines."Categorize As"::"Employee's Subordinates");
            if HRAppLines.Find('-') then begin
                HRAppLines.DeleteAll;
                fn_LoadSections;
            end else begin
                fn_LoadSections;
            end;
        end;

        //Employee's Peers
        HRAppEvalAreas.Reset;
        HRAppEvalAreas.SetRange(HRAppEvalAreas."Categorize As", HRAppEvalAreas."Categorize As"::"Employee's Peers");
        HRAppEvalAreas.SetRange(HRAppEvalAreas."Appraisal Period", Rec."Appraisal Period");
        if HRAppEvalAreas.Find('-') then begin
            HRAppLines.Reset;
            HRAppLines.SetRange(HRAppLines."Appraisal No", Rec."Appraisal No");
            HRAppLines.SetRange(HRAppLines."Appraisal Period", Rec."Appraisal Period");
            HRAppLines.SetRange(HRAppLines."Employee No", Rec."Employee No");
            HRAppLines.SetRange(HRAppLines."Categorize As", HRAppLines."Categorize As"::"Employee's Peers");
            if HRAppLines.Find('-') then begin
                HRAppLines.DeleteAll;
                fn_LoadSections;
            end else begin
                fn_LoadSections;
            end;
        end;

        //External Sources (Vendors and Customers)
        HRAppEvalAreas.Reset;
        HRAppEvalAreas.SetRange(HRAppEvalAreas."Categorize As", HRAppEvalAreas."Categorize As"::"External Sources");
        HRAppEvalAreas.SetRange(HRAppEvalAreas."Appraisal Period", Rec."Appraisal Period");
        if HRAppEvalAreas.Find('-') then begin
            HRAppLines.Reset;
            HRAppLines.SetRange(HRAppLines."Appraisal No", Rec."Appraisal No");
            HRAppLines.SetRange(HRAppLines."Appraisal Period", Rec."Appraisal Period");
            HRAppLines.SetRange(HRAppLines."Employee No", Rec."Employee No");
            HRAppLines.SetRange(HRAppLines."Categorize As", HRAppLines."Categorize As"::"External Sources");
            if HRAppLines.Find('-') then begin
                HRAppLines.DeleteAll;
                fn_LoadSections;
            end else begin
                fn_LoadSections;
            end;
        end;
    end;

    //[Scope('OnPrem')]
    procedure fn_ShowSubPages()
    begin
        //Visbility of Subpages
        if Rec."Appraisal Method" <> Rec."Appraisal Method"::"360 Appraisal" then begin
            SubPageVisible := false;
        end else begin
            SubPageVisible := true;
        end;
    end;
}

