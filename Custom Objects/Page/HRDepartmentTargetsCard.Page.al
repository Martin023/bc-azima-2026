Page 52185448 "HR Department Targets Card"
{
    Caption = 'HR Department Targets Card';
    PageType = Card;
    SourceTable = "HR Department Targets Header";
    ApplicationArea = Basic;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Target No"; Rec."Target No")
                {
                    ApplicationArea = Basic;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = Basic;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Year"; Rec."Appraisal Year")
                {
                    ApplicationArea = Basic;
                }
                field("Target Date"; Rec."Target Date")
                {
                    ApplicationArea = Basic;
                }
                field("HOD Employee No"; Rec."HOD Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("HOD Name"; Rec."HOD Name")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Financial Targeted Score"; Rec."Financial Targeted Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Financial Achieved Score"; Rec."Financial Achieved Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Customer Target Score"; Rec."Customer Target Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Customer Achieved Score"; Rec."Customer Achieved Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Training Target Score"; Rec."Training Target Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Training Achieved Score"; Rec."Training Achieved Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Service Delivery Target Score"; Rec."Service Delivery Target Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Service Delivery Achieved"; Rec."Service Delivery Achieved")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Unachieved Targets"; Rec."Unachieved Targets")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = Basic;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
            }
            part("Financial Targets"; "Department Target Lines")
            {
                Caption = 'Financial Targets';
                SubPageLink = "Department Target No" = FIELD("Target No"),
                              "Perspective Code" = CONST(2);
            }
            part("Customer Targets"; "Department Target Lines")
            {
                Caption = 'Customer Targets';
                SubPageLink = "Department Target No" = FIELD("Target No"),
                              "Perspective Code" = CONST(4);
            }
            part("Training Targets"; "Department Target Lines")
            {
                Caption = 'Training Targets';
                SubPageLink = "Department Target No" = FIELD("Target No"),
                              "Perspective Code" = CONST(3);
            }
            part("Service Delivery Targets"; "Department Target Lines")
            {
                Caption = 'Service Delivery Targets';
                SubPageLink = "Department Target No" = FIELD("Target No"),
                              "Perspective Code" = CONST(1);
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Send for Approval")
            {
                Caption = 'Send for Approval';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Send these Department Targets for Approval?', true) = false then exit;

                    Rec.TestField("Target No");
                    Rec.TestField("Department Code");
                    Rec.TestField("HOD Employee No");
                    Rec.Status := Rec.Status::"Pending Approval";
                    Rec.Modify;
                end;
            }
            action("Approve")
            {
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Approve these Department Targets?', true) = false then exit;

                    Rec.Status := Rec.Status::Approved;
                    Rec."Approved By" := UserId;
                    Rec."Approved Date" := Today;
                    Rec.Modify;
                end;
            }
            action("Reopen")
            {
                Caption = 'Reopen';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Reopen these Department Targets?', true) = false then exit;

                    Rec.Status := Rec.Status::Open;
                    Rec."Approved By" := '';
                    Rec."Approved Date" := 0D;
                    Rec.Modify;
                end;
            }
            action("Close")
            {
                Caption = 'Close';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Close these Department Targets?', true) = false then exit;

                    Rec.TestField(Status, Rec.Status::Approved);
                    Rec.Status := Rec.Status::Closed;
                    Rec.Modify;
                end;
            }
            action("Print")
            {
                Caption = 'Print';
                Image = PrintForm;
                Promoted = true;
                PromotedCategory = Process;
            }
        }
    }
}