page 52186556 "HR Job Applicants Qualified Ca"
{
    Caption = 'HR Job Applicants Qualified Card';
    DeleteAllowed = false;
    Description = 'HR Job Applicants Qualified Card';
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "HR Job Applications";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Job Application No."; Rec."Job Application No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Qualified; Rec.Qualified)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = AttentionAccent;
                    StyleExpr = TRUE;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Applied"; Rec."Date Applied")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Job Applied for Description"; Rec."Job Applied for Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                // label("Interview Details")
                // {
                //     Caption = 'Interview Details';
                //     Style = StrongAccent;
                //     StyleExpr = TRUE;
                // }
            }

            group("Interview Details")
            {
                field("Date of Interview"; Rec."Date of Interview")
                {
                    ApplicationArea = Basic;
                    Style = StandardAccent;
                    StyleExpr = TRUE;
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
                field("Total Score After Interview"; Rec."Total Score After Interview")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Is Employee"; Rec."Is Employee")
                {

                }
                field(Reason; Rec.Reason)
                {

                }
            }
        }
    }

    actions
    {
        area(creation)
        {

            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    /*TESTFIELD("No of Posts");
                    TESTFIELD("Responsibility Center");

                    CALCFIELDS("No. of Requirements");
                    IF "No. of Requirements" = 0 THEN  ERROR('Please Specify the Job Requirements');
                     CALCFIELDS("No. of Responsibilities");

                    IF "No. of Responsibilities" = 0 THEN ERROR('Please Specify the Job Responsibilities');
                     */
                    if Confirm('Send this Job Applicant for Approval?', true) = false then exit;
                    //AppMgmt.SendQualifiedAplicantApprovalReq(Rec);

                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Request';
                Image = CancelAllLines;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    if Confirm('Cancel Approval Request?', true) = false then exit;
                    //AppMgmt.CancelEmpChangeDetailsRequest(Rec,TRUE,TRUE);
                end;
            }
            action(Approve)
            {
                ApplicationArea = Basic;
                Caption = 'Approve';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    rec.TestField("Date of Interview");
                    rec.TestField("From Time");
                    rec.TestField("To Time");
                    rec.TestField(Venue);
                    Rec."Approval Status" := rec."Approval Status"::Approved;
                    Rec.Modify;
                end;
            }
        }
    }

    var
        HRJobApplicants: Record "HR Job Applications";
}

