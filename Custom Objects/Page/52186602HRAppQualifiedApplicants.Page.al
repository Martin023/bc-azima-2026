page 52186602 "HR  App Qualified Applicants1"
{
    CardPageID = "HR Job Applicants Qualified Ca";
    Editable = false;
    PageType = List;
    SourceTable = "HR Job Applications";
    SourceTableView = WHERE(Qualified = CONST(true));// "Approval Status" = FILTER(Approved), Uploaded = CONST(false));
    ApplicationArea = Basic;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job Application No."; Rec."Job Application No.")
                {
                    ApplicationArea = Basic;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = Basic;
                }
                field("Date Applied"; Rec."Date Applied")
                {
                    ApplicationArea = Basic;
                    StyleExpr = TRUE;
                }
                field("Employee Requisition No"; Rec."Employee Requisition No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Application Ref. No.';
                }
                field("Job Applied For"; Rec."Job Applied For")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job ID';
                }
                field("Job Applied for Description"; Rec."Job Applied for Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Description';
                }
                field(Qualified; Rec.Qualified)
                {
                    ApplicationArea = Basic;
                }
                field(Uploaded; Rec.Uploaded)
                {
                    ApplicationArea = Basic;
                }
                field("From Time"; Rec."From Time")
                {
                    ApplicationArea = Basic;
                }
                field("To Time"; Rec."To Time")
                {
                    ApplicationArea = Basic;
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Interview Invitation Sent"; Rec."Interview Invitation Sent")
                {
                    ApplicationArea = Basic;
                }
                field("Rejection Reason"; Rec."Rejection Reason")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Applicant)
            {
                Caption = 'Applicant';
                action("Send Interview Invitation")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Interview Invitation';
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        FN: Text;
                    begin
                        //TestField(Qualified, Qualified::"1");
                        //TESTFIELD("Date of Interview");
                        //TESTFIELD("From Time");
                        //TESTFIELD("To Time");
                        //TESTFIELD(Venue);


                        FN := Rec."First Name" + ' ' + Rec."Middle Name" + ' ' + Rec."Last Name";
                        if not Confirm(Text002, false, FN) then exit;



                        if Rec."Interview Invitation Sent" = true then Error('Applicant has already been notified');

                        HRJobApplications.SetRange(HRJobApplications."Job Application No.", Rec."Job Application No.");
                        CurrPage.SetSelectionFilter(HRJobApplications);

                        if HRJobApplications.Find('-') then
                            //GET E-MAIL PARAMETERS FOR JOB APPLICATIONS
                            HREmailParameters.Reset;
                        HREmailParameters.SetRange(HREmailParameters."Associate With", HREmailParameters."Associate With"::"Interview Invitations");
                        if not HREmailParameters.Find('-') then Error('Please setup Email Parameters');
                        begin
                            repeat
                                HRJobApplications.TestField(HRJobApplications."E-Mail");
                                EmailMsg.Create(HRJobApplications."E-Mail",'Interview Invitation','You have been Invited for an Interview');

                                Email.Send(EmailMsg,Enum::"Email Scenario"::Default);
                            until HRJobApplications.Next = 0;

                            Rec."Interview Invitation Sent" := true;
                            Rec.Modify;
                            Message('%1 has been invited for the Interview Invitation via E-Mail ', FN)
                        end;
                    end;
                }
                action("Job Interview details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Interview details';
                    Image = ApplicationWorksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HR Job Interview";
                    RunPageLink = "Applicant No" = FIELD("Job Application No.");
                }
                action("Job Applicant Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Applicant Card';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HR Job Applications Card";
                    RunPageLink = "Job Application No." = FIELD("Job Application No.");
                }
                action("Applicant Qualifications")
                {
                    ApplicationArea = Basic;
                    Caption = 'Applicant Qualifications';
                    Image = QualificationOverview;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Page "HR Applicant Qualifications";
                    RunPageLink = "Application No" = FIELD("Job Application No.");
                }
                action("Applicant Referees")
                {
                    ApplicationArea = Basic;
                    Caption = 'Applicant Referees';
                    Image = ContactReference;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Page "HR Applicant Referees";
                    RunPageLink = "Job Application No" = FIELD("Job Application No.");
                }
                action("Applicant Hobbies")
                {
                    ApplicationArea = Basic;
                    Caption = 'Applicant Hobbies';
                    Image = Holiday;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Page "HR Applicant Hobbies";
                    RunPageLink = "Job Application No" = FIELD("Job Application No.");
                }
                action("Upload to Employees")
                {
                    ApplicationArea = Basic;
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Report "HR Applicant to Employee";
                    Visible = true;

                    trigger OnAction()
                    begin
                        //REPORT.Run(report::"HR Applicant to Employee",rec);
                        //REPORT.Run(Number [, ReqWindow] [, SystemPrinter] [, Record])
                    end;
                }
            }
        }
    }

    var
        Text001: Label 'Are you sure you want to upload "%1" to the Employee List?';
        Text002: Label 'Are you sure you want to Send this Interview invitation to\%1?';
        HRJobApplications: Record "HR Job Applications";
        //SMTP: Codeunit "SMTP Mail";
        CTEXTURL: Text[30];
        HREmailParameters: Record "HR E-Mail Parameters";
        Interview: Record "HR Job Interview";
        fn: Text;
        Email: Codeunit Email;
        EmailMsg: Codeunit "Email Message";

}

