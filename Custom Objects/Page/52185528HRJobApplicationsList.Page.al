page 52185528 "HR Job Applications List"
{
    CardPageID = "HR Job Applications Card";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Applicant,Functions,Print';
    SourceTable = "HR Job Applications";
    UsageCategory = Lists;
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                Editable = false;
                ShowCaption = false;
                field("Job Application No."; Rec."Job Application No.")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
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
                    Caption = 'Job Applied For';
                }
                field("Job Applied for Description"; Rec."Job Applied for Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Description';
                }
                field("Document Status"; Rec."Document Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                }
                field("Current Approver ID"; Rec."Current Approver ID")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1; Links)
            {
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group("Import/Export")
            {
                Caption = 'Import/Export';
                action("Download Template")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Download Template';
                    Image = ExportFile;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Download the CSV template for importing job applications';

                    trigger OnAction()
                    var
                        TempBlob: Codeunit "Temp Blob";
                        OutStr: OutStream;
                        InStr: InStream;
                        FileName: Text;
                    begin
                        FileName := 'JobApplicationsTemplate.csv';
                        
                        TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
                        
                        OutStr.WriteText('JobApplicationNo,DateApplied,ApplicantType,EmployeeRequisitionNo,JobAppliedFor,JobAppliedforDescription,');
                        OutStr.WriteText('FirstName,MiddleName,LastName,FirstLanguageRWS,FirstLanguageRead,FirstLanguageSpeak,FirstLanguageWrite,');
                        OutStr.WriteText('SecondLanguageRWS,SecondLanguageRead,SecondLanguageSpeak,SecondLanguageWrite,IDNumber,AdditionalLanguage,');
                        OutStr.WriteText('Gender,PostCode,PostalAddress,ResidentialAddress,HomePhoneNumber,CellPhoneNumber,WorkPhoneNumber,EMail,');
                        OutStr.WriteText('MaritalStatus,Disabled,DateOfBirth,Ag,Citizenship,CitizenshipDetails,Status,ProposedSalary,RejectionReason');
                        OutStr.WriteText();
                        
                        OutStr.WriteText('APP-SAMPLE-001,2026-07-15,External,REQ001,JOB001,Software Developer,John,Michael,Doe,English,Yes,Yes,Yes,');
                        OutStr.WriteText('Swahili,Yes,Yes,Yes,12345678,French,Male,00100,P.O. Box 123,123 Main Street,0201234567,0712345678,');
                        OutStr.WriteText('0201234568,john.doe@example.com,Single,No,1990-01-15,36,Kenyan,,Unqualified,50000,');
                        OutStr.WriteText();
                        
                        TempBlob.CreateInStream(InStr, TextEncoding::UTF8);
                        DownloadFromStream(InStr, 'Download Template', '', 'CSV Files (*.csv)|*.csv', FileName);
                    end;
                }
                action("Import Job Applications")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Import Job Applications';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = XMLport "Job Application";
                    ToolTip = 'Import job applications from CSV file using the template';
                }
            }
        }
        area(Navigation)
        {
            group(Email)
            {
                action("Email Recepient")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Recepient Email';
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        //IF CONFIRM('Send this Requisition for Approval?',TRUE)=FALSE THEN EXIT;
                        if not Confirm(Text003, false) then exit;

                        //TestField(Qualified, Qualified::"0");
                        // HRJobApplications.SetRange(HRJobApplications."Job Application No.", Rec."Job Application No.");
                        // CurrPage.SetSelectionFilter(HRJobApplications);
                        // if HRJobApplications.Find('-') then
                        //     repeat
                        //HRJobApplications.TestField(HRJobApplications."E-Mail");
                        SendExternalEmail();
                        //until HRJobApplications.Next = 0;

                        Message('All Applicant  candidates have been sent alerts');
                        Rec."Sent Email" := True;
                        Rec.Modify(true);
                    end;

                }
            }
        }
    }

    var
        HRJobApplications: Record "HR Job Applications";
        Text001: Label 'Are you sure you want to Upload Applicants Details to the Employee Card?';
        Text002: Label 'Are you sure you want to Send an Interview Application?';
        emailcod: Codeunit EmailCodeunit;
        text003: Label 'Are you sure you want to Send Email Recepient Of Applications';
        HREmailParameters: Record "HR E-Mail Parameters";
        EmailMsg: Codeunit "Email Message";

        EmailRecipientList: List of [Text];
        AttachmentInstream: InStream;
        Application: Record "HR Job Applications";
        Email: Codeunit Email;
        AttachmentOutstream: OutStream;
        Temp: Codeunit "Temp Blob";
        msg: text;
        subject: text;
        username: text;
        emailbody: label 'Dear <b>%1</b>, <br><h>';

    procedure SendExternalEmail()
    var
        UserEmail: text;

    begin
        if rec.status = rec.status::Unqualified then begin
            msg := 'Thank you for your interest in working with Azima SACCO. Your application was carefully evaluated for consideration. However, this time you were not successful. Kindly try next time we have an opening.';
            Subject := 'Rejection Offer';
        end else
            if rec.status = rec.status::Approved then begin
                msg := 'Thank you for your interest in working with Azima SACCO. Your application was carefully evaluated for consideration and was  successful';
                Subject := 'Acceptance Offer';
            end;


        HRJobApplications.Reset();
        HRJobApplications.SetRange("Job Application No.", rec."Job Application No.");
        HRJobApplications.SetRange("Sent Email", false);
        if HRJobApplications.Find('-') then begin
            repeat
                UserEmail := HRJobApplications."E-Mail";
                username := HRJobApplications.FullName;
                EmailMsg.AppendToBody(StrSubstNo(emailbody, username));
                EmailMsg.Create(UserEmail, subject, msg);
                Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
            until HRJobApplications.Next() = 0;
        end;

    end;
}


