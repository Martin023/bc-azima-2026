page 52185529 "HR Job Applications Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions,Other Details,Job Details,,,Approvals';
    SourceTable = "HR Job Applications";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Job Application No."; Rec."Job Application No.")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Date Applied"; Rec."Date Applied")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Applicant Type"; Rec."Applicant Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                group(Control39)
                {
                    ShowCaption = false;
                    grid(Control38)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Control21)
                        {
                            ShowCaption = false;
                            field("Employee Requisition No"; Rec."Employee Requisition No")
                            {
                                ApplicationArea = Basic;
                                Caption = 'Application Reff No.';
                                Importance = Promoted;
                            }
                            field("Job Applied For"; Rec."Job Applied For")
                            {
                                ApplicationArea = Basic;
                                Caption = 'Position Applied For';
                                Editable = false;
                                Enabled = true;
                                Importance = Promoted;
                                ShowMandatory = true;
                            }
                            field("Job Applied for Description"; Rec."Job Applied for Description")
                            {
                                ApplicationArea = Basic;
                                Editable = false;
                                ShowCaption = false;
                                showmandatory = true;
                            }
                        }
                    }
                }
                group(Control18)
                {
                    ShowCaption = false;
                    grid(Control15)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Control16)
                        {
                            ShowCaption = false;
                            field("First Name"; Rec."First Name")
                            {
                                ApplicationArea = Basic;
                                Importance = Promoted;
                                StyleExpr = TRUE;
                                ShowMandatory = true;
                            }
                            field("Middle Name"; Rec."Middle Name")
                            {
                                ApplicationArea = Basic;
                                Importance = Promoted;
                                StyleExpr = TRUE;
                                ShowMandatory = true;
                            }
                            field("Last Name"; Rec."Last Name")
                            {
                                ApplicationArea = Basic;
                                Importance = Promoted;
                                StyleExpr = TRUE;
                            }
                            field(Initials; Rec.Initials)
                            {
                                ApplicationArea = Basic;
                                StyleExpr = TRUE;
                            }
                        }
                    }
                }
                group(Control20)
                {
                    ShowCaption = false;
                    grid(Control19)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Control17)
                        {
                            ShowCaption = false;
                            field("First Language (R/W/S)"; Rec."First Language (R/W/S)")
                            {
                                ApplicationArea = Basic;
                                Caption = '1st Language (R/W/S)';
                                Importance = Promoted;
                                StyleExpr = TRUE;
                                ShowMandatory = true;
                            }
                            field("First Language Read"; Rec."First Language Read")
                            {
                                ApplicationArea = Basic;
                                Caption = 'Read';
                            }
                            field("First Language Write"; Rec."First Language Write")
                            {
                                ApplicationArea = Basic;
                                Caption = 'Write';
                            }
                            field("First Language Speak"; Rec."First Language Speak")
                            {
                                ApplicationArea = Basic;
                                Caption = 'Speak';
                            }
                            field("Second Language (R/W/S)"; Rec."Second Language (R/W/S)")
                            {
                                ApplicationArea = Basic;
                                Caption = '2nd Language (R/W/S)';
                                Importance = Promoted;
                            }
                            field("Second Language Read"; Rec."Second Language Read")
                            {
                                ApplicationArea = Basic;
                                Caption = 'Read';
                            }
                            field("Second Language Write"; Rec."Second Language Write")
                            {
                                ApplicationArea = Basic;
                                Caption = 'Write';
                            }
                            field("Second Language Speak"; Rec."Second Language Speak")
                            {
                                ApplicationArea = Basic;
                                Caption = 'Speak';
                            }
                            field("ID Number"; Rec."ID Number")
                            {
                                ApplicationArea = Basic;
                                ShowMandatory = true;
                            }
                            field("Additional Language"; Rec."Additional Language")
                            {
                                ApplicationArea = Basic;
                            }
                        }
                    }
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = Basic;
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Residential Address"; Rec."Residential Address")
                {
                    ApplicationArea = Basic;
                }
                field("Home Phone Number"; Rec."Home Phone Number")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    BlankZero = true;
                }
                field("Cell Phone Number"; Rec."Cell Phone Number")
                {
                    ApplicationArea = Basic;
                }
                field("Work Phone Number"; Rec."Work Phone Number")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    ShowMandatory = true;

                }
                field(Disabled; Rec.Disabled)
                {
                    ApplicationArea = Basic;
                }
                group(Control37)
                {
                    ShowCaption = false;
                    grid(Control36)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Control35)
                        {
                            ShowCaption = false;
                            field("Date Of Birth"; Rec."Date Of Birth")
                            {
                                ApplicationArea = Basic;
                                ShowMandatory = true;
                            }
                            field(Ag; Rec.Ag)
                            {
                                ApplicationArea = Basic;
                                Caption = 'Age';
                                Editable = false;
                                Importance = Promoted;
                            }
                        }
                    }
                }
                group(Control5)
                {
                    ShowCaption = false;
                    grid(Control2)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Control1)
                        {
                            ShowCaption = false;
                            field(Citizenship; Rec.Citizenship)
                            {
                                ApplicationArea = Basic;
                            }
                            field("Country Details"; Rec."Citizenship Details")
                            {
                                ApplicationArea = Basic;
                                Editable = false;
                                ShowCaption = false;
                            }
                        }
                    }
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic;
                }
                // field("Document Status"; Rec."Document Status")
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                //     Style = Attention;
                //     StyleExpr = TRUE;
                //}
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Proposed Salary"; Rec."Proposed Salary")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Rejection Reason"; Rec."Rejection Reason")
                {

                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755008; Outlook)
            {
                ApplicationArea = Basic;
            }
            systempart(Control3; Links)
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Other Details")
            {
                Caption = 'Other Details';
                action(Qualifications)
                {
                    ApplicationArea = Basic;
                    Caption = 'Qualifications';
                    Image = QualificationOverview;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Applicant Qualifications";
                    RunPageLink = "Application No" = FIELD("Job Application No.");
                }
                action(Referees)
                {
                    ApplicationArea = Basic;
                    Caption = 'Referees';
                    Image = ContactReference;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "HR Applicant Referees";
                    RunPageLink = "Job Application No" = FIELD("Job Application No.");
                }
                action(Hobbies)
                {
                    ApplicationArea = Basic;
                    Caption = 'Hobbies';
                    Image = Holiday;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "HR Applicant Hobbies";
                    RunPageLink = "Job Application No" = FIELD("Job Application No.");
                }
            }
            // group("Job Details")
            // {
            //     Caption = 'Job Details';
            // action(Requirements)
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Requirements';
            //     Image = Card;
            //     Promoted = true;
            //     PromotedCategory = Category6;
            //     RunObject = Page "HR Job Requirement Lines";
            //     RunPageLink = "Job ID" = FIELD("Job Applied For");
            // }
            // action(Responsibilities)
            // {
            // Veri    ApplicationArea = Basic;
            //     Caption = 'Responsibilities';
            //     Image = JobResponsibility;
            //     Promoted = true;
            //     PromotedCategory = Category6;
            //     RunObject = Page "HR Job Responsiblities Lines";
            //     RunPageLink = "Job ID" = FIELD("Job Applied For");
            // }

            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //TESTFIELD("No of Posts");
                        /*TESTFIELD("Document No.");
                        TESTFIELD(Description);
                        TESTFIELD("Interest Due Date");*/
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);

                        // Rec."Approval Status" := Rec."Approval Status"::Approved;
                        // Rec.MODIFY;
                        //MESSAGE('Employee requisition Approved Now the job can be advertised');


                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

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
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
            }
            // action(Approvals)
            // {


            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Information Verified';
            //     Enabled = NOT OpenApprovalEntriesExist;
            //     Image = SendApprovalRequest;
            //     Promoted = true;
            //     PromotedCategory = Category9;

            //     trigger OnAction()

            //     var
            //         CustomApprovals: Codeunit "Custom Approvals Codeunit";
            //         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            //     begin

            //         VarVariant := Rec;
            //         if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
            //             CustomApprovals.OnSendDocForApproval(VarVariant);

            //         if rec.Status = rec.Status::Approved then
            //             CurrPage.Editable := false;
            //     end;




            // }
            action("Import Job Applications")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Import Job Applications';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = XMLport "Job Application";

                trigger OnAction()
                begin



                end;

            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //"Applicant Type":="Applicant Type"::Internal;
    end;

    trigger OnOpenPage()
    begin
        if rec.Status = rec.Status::Approved then
            CurrPage.Editable := false;
    end;

    var
        HRJobApplications: Record "HR Job Applications";
        //SMTP: Codeunit "SMTP Mail";
        HREmailParameters: Record "HR E-Mail Parameters";
        Employee: Record "HR Employees";
        Text19064672: Label 'Shortlisting Summary';
        DAge: Text[100];
        Text0000: Label '                     ';
        VarVariant: Variant;
        OpenApprovalEntriesExist: boolean;
        DocMustbePending: Label 'This application request must be Pending';
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
}

