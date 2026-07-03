page 52185651 "Training Need Requests - All"
{
    PageType = List;
    SourceTable = "HR Training Need Request";
    CardPageID = "HR Training Need Request Card";
    Caption = 'All Training Need Requests';
    ApplicationArea = Basic;
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Request No."; Rec."Request No.")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Training Category"; Rec."Training Category")
                {
                    ApplicationArea = Basic;
                }
                field("Training Type"; Rec."Training Type")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Employees"; Rec."No. of Employees")
                {
                    ApplicationArea = Basic;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = Rec.Priority = Rec.Priority::Critical;
                }
                field(Justification; Rec.Justification)
                {
                    ApplicationArea = Basic;
                }
                field("Requested By Name"; Rec."Requested By Name")
                {
                    ApplicationArea = Basic;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = Basic;
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = Basic;
                }
                field("Proposed Start Date"; Rec."Proposed Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Proposed End Date"; Rec."Proposed End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Official Training Need No."; Rec."Official Training Need No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control2; Outlook)
            {
                ApplicationArea = Basic;
            }
            systempart(Control3; Notes)
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Create Official Training Need")
            {
                ApplicationArea = Basic;
                Caption = 'Create Official Training Need';
                Image = NewDocument;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = Rec.Status = Rec.Status::New;

                trigger OnAction()
                var
                    HRTrainingNeeds: Record "HR Training Needs";
                    HRTrainingNeedRequest: Record "HR Training Need Request";
                begin
                    if not Confirm('Create an official training need from this request?', false) then
                        exit;

                    HRTrainingNeeds.Init;
                    HRTrainingNeeds.Insert(true);
                    HRTrainingNeeds.Description := Rec.Description;
                    HRTrainingNeeds."Training Category" := Rec."Training Category";
                    HRTrainingNeeds."Training Type" := Rec."Training Type";
                    HRTrainingNeeds.Other := Rec.Other;
                    HRTrainingNeeds."Need Source" := Rec."Need Source";
                    HRTrainingNeeds."Start Date" := Rec."Proposed Start Date";
                    HRTrainingNeeds."End Date" := Rec."Proposed End Date";
                    HRTrainingNeeds.Location := Rec."Preferred Location";
                    HRTrainingNeeds."Other Provider" := Rec."Preferred Provider";
                    HRTrainingNeeds."Responsibility Center" := Rec."Department Code";
                    HRTrainingNeeds."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                    HRTrainingNeeds."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                    HRTrainingNeeds.Modify(true);

                    Rec.Status := Rec.Status::"Converted to Official Need";
                    Rec."Official Training Need No." := HRTrainingNeeds.Code;
                    Rec.Modify(true);

                    Message('Official Training Need %1 created successfully.', HRTrainingNeeds.Code);

                    PAGE.Run(PAGE::"HR Training Needs Card", HRTrainingNeeds);
                end;
            }
            action("Mark as Under Review")
            {
                ApplicationArea = Basic;
                Caption = 'Mark as Under Review';
                Image = ViewDetails;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = Rec.Status = Rec.Status::New;

                trigger OnAction()
                begin
                    if not Confirm('Mark this request as under review?', false) then
                        exit;

                    Rec.Status := Rec.Status::"Under Review";
                    Rec.Modify(true);
                    Message('Request marked as under review.');
                end;
            }
            action("Reject Request")
            {
                ApplicationArea = Basic;
                Caption = 'Reject Request';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = (Rec.Status = Rec.Status::New) or (Rec.Status = Rec.Status::"Under Review");

                trigger OnAction()
                begin
                    if not Confirm('Reject this training need request?', false) then
                        exit;

                    Rec.Status := Rec.Status::Rejected;
                    Rec.Modify(true);
                    Message('Request rejected.');
                end;
            }
        }
    }
}
