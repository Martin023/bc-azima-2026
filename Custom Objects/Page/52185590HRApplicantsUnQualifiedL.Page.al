page 52185590 "HR Applicants UnQualified L1"
{
    CardPageID = "HR Applicants UnQualified Card";
    PageType = List;
    SourceTable = "HR Job Applications";
    SourceTableView = WHERE(Qualified = FILTER(false));
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
                    Editable=false;
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
                action("Send Regret Alert")
                {
                    Caption = 'Send Regret Alert';
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        //IF CONFIRM('Send this Requisition for Approval?',TRUE)=FALSE THEN EXIT;

                        if not Confirm(Text003, false) then exit;

                        //TestField(Qualified, Qualified::"0");
                        HRJobApplications.SetRange(HRJobApplications."Job Application No.", Rec."Job Application No.");
                        CurrPage.SetSelectionFilter(HRJobApplications);
                        if HRJobApplications.Find('-') then
                            //GET E-MAIL PARAMETERS FOR JOB APPLICATIONS
                            HREmailParameters.Reset;
                        HREmailParameters.SetRange(HREmailParameters."Associate With", HREmailParameters."Associate With"::"Regret Notification");
                        if HREmailParameters.Find('-') then begin
                            repeat
                                HRJobApplications.TestField(HRJobApplications."E-Mail");
                                // SMTP.CreateMessage(HREmailParameters."Sender Name", HREmailParameters."Sender Address", HRJobApplications."E-Mail",
                                // HREmailParameters.Subject, 'Dear' + ' ' + HRJobApplications."First Name" + ' ' + HREmailParameters.Body + ' ' + HRJobApplications."Job Applied for Description" + ' ' + 'applied on' + ' ' + Format("Date Applied") + ' ' + HREmailParameters."Body 2", true);
                                // //HREmailParameters."Body 2"+' '+ FORMAT("Date Applied")+'. '+
                                // // HREmailParameters.Body,TRUE);
                                // SMTP.Send();
                                // emailcod.SendRejectionEmail();
                            until HRJobApplications.Next = 0;

                            Message('All Unqualified  candidates have been sent regret alerts');
                        end;
                    end;
                }
            }
        }
    }

    var
        Text001: Label 'Are you sure you want to Upload Applicants Details to the Employee Card?';
        Text002: Label 'Are you sure you want to Send this Interview invitation?';
        HRJobApplications: Record "HR Job Applications";
        //here//SMTP: Codeunit "SMTP Mail";
        emailcod: Codeunit EmailCodeunit;
        CTEXTURL: Text[30];
        HREmailParameters: Record "HR E-Mail Parameters";
        Text003: Label 'Are you sure you want to Send Regret Notification?';
}

