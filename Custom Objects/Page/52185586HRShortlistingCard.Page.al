page 52185586 "HR Shortlisting Card"
{
    DeleteAllowed = false;
    //InsertAllowed = false;
    //ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Shortlist,Interview';
    SourceTable = "HR Employee Requisitions";
    SourceTableView = WHERE("Approval Status" = CONST(Approved),
                            Closed = CONST(false));

    layout
    {
        area(content)
        {
            group("Employee Requisition Details")
            {
                Caption = 'Employee Requisition Details';
                field("Requisition No."; Rec."Requisition No.")
                {
                    ApplicationArea = Basic;
                    Editable=false;
                }
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    editable=false;
                }
                field("Job Description"; Rec."Job Description")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Job Grade"; Rec."Job Grade")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Requisition Date"; Rec."Requisition Date")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                    editable=false;
                }
                field("Employment Type"; Rec."Employment Type")
                {
                    ApplicationArea = Basic;
                    editable=false;
                }
                field("Vacant Positions"; Rec."Vacant Positions")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Required Positions"; Rec."Required Positions")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    editable=false;
                }
                field("No. of Job Applications"; Rec."No. of Job Applications")
                {
                    ApplicationArea = Basic;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = Basic;
                    editable=false;
                }
                field("Reason For Request"; Rec."Reason For Request")
                {
                    ApplicationArea = Basic;
                    editable=false;
                }
                field("Closing Date"; Rec."Closing Date")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    editable=false;
                }
                field("Requisition Type"; Rec."Requisition Type")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    editable=false;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Completion Status"; Rec."Completion Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
            }
            part(Shortlisted; "HR Shortlisting Lines")
            {
                ApplicationArea = Basic;
                SubPageLink = "Employee Requisition No" = FIELD("Requisition No.");
            }
        }
        area(factboxes)
        {
            systempart(Control1102755001; Outlook)
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Applicants)
            {
                Caption = 'Applicants';
                action("&ShortList Applicants")
                {
                    ApplicationArea = Basic;
                    Caption = '&ShortList Applicants';
                    Image = SelectField;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Rec.TestField("Completion Status", Rec."Completion Status"::Open);

                        // VALIDATE THAT JOB REQUIREMENTS EXIST
                        if Confirm('Shortlist Applicants for Employee Requisition %1 - %2?', false, Rec."Requisition No.", Rec."Job Description") = false then exit;

                        HRJobRequirements.Reset;
                        HRJobRequirements.SetRange(HRJobRequirements."Job ID", Rec."Job ID");
                        if HRJobRequirements.Count = 0 then begin
                            Error('Job Requirements for the job %1 have not been setup. Please define job requirements before shortlisting.', Rec."Job ID");
                        end;

                        // DELETE ALL RECORDS FROM THE SHORTLISTED APPLICANTS TABLE
                        HRShortlistedApplicants.Reset;
                        HRShortlistedApplicants.SetRange(HRShortlistedApplicants."Employee Requisition No", Rec."Requisition No.");
                        HRShortlistedApplicants.DeleteAll;

                        // GET JOB APPLICANTS
                        HRJobApplications.Reset;
                        HRJobApplications.SetRange(HRJobApplications."Employee Requisition No", Rec."Requisition No.");
                        if not HRJobApplications.Find('-') then begin
                            Error('No Applicants have applied for this Job. Cannot proceed with shortlisting.');
                        end;
                        
                        // CHECK IF APPLICANTS HAVE QUALIFICATIONS
                        found := 0;
                        HRJobApplications.FindFirst;
                        repeat
                            AppQualifications.Reset;
                            AppQualifications.SetRange("Application No", HRJobApplications."Job Application No.");
                            if AppQualifications.FindFirst() then
                                found += 1;
                        until HRJobApplications.Next = 0;
                        
                        if found = 0 then begin
                            Error('None of the applicants have qualifications entered. Please add applicant qualifications before shortlisting.');
                        end;
                        
                        if found < HRJobApplications.Count then begin
                            if not Confirm('%1 out of %2 applicants have qualifications entered. Continue with shortlisting?', false, found, HRJobApplications.Count) then
                                exit;
                        end;

                        // RESET ALL APPLICANTS TO NOT QUALIFIED
                        HRJobApplications.FindFirst;
                        repeat
                            HRJobApplications.Qualified := false;
                            HRJobApplications.Modify;
                        until HRJobApplications.Next = 0;

                        // MOVE TO FIRST RECORD AGAIN AND START SHORTLISTING
                        HRJobApplications.FindFirst;
                        repeat
                            Qualified := true;
                            if HRJobRequirements.Find('-') then begin
                                StageScore := 0;
                                Rec.Score := 0;
                                repeat
                                    // CHECK IF APPLICANT HAS THIS QUALIFICATION
                                    AppQualifications.Reset;
                                    AppQualifications.SetRange("Application No", HRJobApplications."Job Application No.");
                                    AppQualifications.SetRange("Qualification Type", HRJobRequirements."Qualification Type");
                                    AppQualifications.SetRange("Qualification Code", HRJobRequirements."Qualification Code");
                                    
                                    if AppQualifications.FindFirst then begin
                                        // APPLICANT HAS THIS QUALIFICATION - ADD SCORE
                                        if AppQualifications."Score ID" > 0 then
                                            Rec.Score += AppQualifications."Score ID"
                                        else if HRJobRequirements."Minimum Score" > 0 then
                                            Rec.Score += HRJobRequirements."Minimum Score"
                                        else
                                            Rec.Score += 1; // DEFAULT SCORE FOR MATCH
                                    end else begin
                                        // APPLICANT DOESN'T HAVE THIS QUALIFICATION
                                        if HRJobRequirements.Mandatory then begin
                                            // MANDATORY REQUIREMENT NOT MET - DISQUALIFY
                                            Qualified := false;
                                        end;
                                    end;
                                until HRJobRequirements.Next = 0;
                            end;
                            
                            // INSERT INTO SHORTLISTED APPLICANTS TABLE
                            HRShortlistedApplicants."Employee Requisition No" := Rec."Requisition No.";
                            HRShortlistedApplicants."Job Application No" := HRJobApplications."Job Application No.";
                            HRShortlistedApplicants."Stage Score" := Rec.Score;
                            HRShortlistedApplicants.Qualified := Qualified;
                            HRShortlistedApplicants."First Name" := HRJobApplications."First Name";
                            HRShortlistedApplicants.Validate(HRShortlistedApplicants."First Name");

                            HRShortlistedApplicants."Middle Name" := HRJobApplications."Middle Name";
                            HRShortlistedApplicants.Validate(HRShortlistedApplicants."Middle Name");

                            HRShortlistedApplicants."Last Name" := HRJobApplications."Last Name";
                            HRShortlistedApplicants.Validate(HRShortlistedApplicants."Last Name");
                            HRShortlistedApplicants."ID No" := HRJobApplications."ID Number";
                            HRShortlistedApplicants.Gender := HRJobApplications.Gender;
                            HRShortlistedApplicants."Marital Status" := HRJobApplications."Marital Status";
                            HRShortlistedApplicants.Insert;

                            HRJobApplications.Modify;

                        until HRJobApplications.Next = 0;

                        // MARK QUALIFIED APPLICANTS AS QUALIFIED IN JOB APPLICATIONS TABLE
                        HRShortlistedApplicants.SetRange(HRShortlistedApplicants.Qualified, true);
                        if HRShortlistedApplicants.Find('-') then
                            repeat
                                HRJobApplications.Get(HRShortlistedApplicants."Job Application No");
                                HRJobApplications.Qualified := true;
                                HRJobApplications.Modify;
                            until HRShortlistedApplicants.Next = 0;

                        // SHOW SUMMARY MESSAGE
                        HRShortlistedApplicants.Reset;
                        HRShortlistedApplicants.SetRange("Employee Requisition No", Rec."Requisition No.");
                        HRShortlistedApplicants.SetRange(Qualified, true);
                        Message('Shortlisting Completed Successfully!\Job: %1\Total Applicants: %2\Qualified: %3\Disqualified: %4', 
                                Rec."Job ID", 
                                HRJobApplications.Count, 
                                HRShortlistedApplicants.Count,
                                HRJobApplications.Count - HRShortlistedApplicants.Count);

                    end;
                }
                action("Shortlisting Panel")
                {
                    ApplicationArea = Basic;
                    Image = SalesPerson;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Shortlisting Panel";
                    RunPageLink = "Requisition No." = FIELD("Requisition No.");
                }
                // action("Interview Results[Case360 Docs]")
                // {
                //     ApplicationArea = Basic;
                //     Image = Document;
                //     Promoted = true;
                //     PromotedCategory = New;

                //     trigger OnAction()
                //     begin
                //         DMS.Reset;
                //         DMS.SetRange(DMS.Key, DMS.Key::"Interview Results");
                //         if DMS.Find('-') then begin
                //             HyperLink(DMS."url path" + Rec."Requisition No.");
                //         end;
                //     end;
                // }
            }
             action(Interview )
                {
                    ApplicationArea = Basic;
                    Caption = 'Interview Details';
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "HR Job Interview";
                    //RunPageLink = "Requisition No." = FIELD("Requisition No.");
                }
        }
    }

    var
        HRJobRequirements: Record "HR Job Requirements";
        AppQualifications: Record "HR Applicant Qualifications";
        HRJobApplications: Record "HR Job Applications";
        Qualified: Boolean;
        StageScore: Decimal;
        HRShortlistedApplicants: Record "HR Shortlisted Applicants";
        MyCount: Integer;
        RecCount: Integer;
        HREmpReq: Record "HR Employee Requisitions";
        Text19057439: Label 'Short Listed Candidates';
        found: Integer;
        DMS: Record EDMS;
}

