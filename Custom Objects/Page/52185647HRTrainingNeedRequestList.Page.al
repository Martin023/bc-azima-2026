page 52185647 "HR Training Need Request List"
{
    PageType = List;
    SourceTable = "HR Training Need Request";
    CardPageID = "HR Training Need Request Card";
    Caption = 'Training Need Requests List';
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
            action("Create New Request")
            {
                ApplicationArea = Basic;
                Caption = 'Create New Request';
                Image = New;
                Promoted = true;
                PromotedCategory = New;

                trigger OnAction()
                var
                    HRTrainingNeedRequest: Record "HR Training Need Request";
                begin
                    HRTrainingNeedRequest.Init;
                    HRTrainingNeedRequest.Insert(true);
                    PAGE.Run(PAGE::"HR Training Need Request Card", HRTrainingNeedRequest);
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        Employee: Record "HR Employees";
    begin
        Employee.Reset;
        Employee.SetRange("User ID", UserId);
        if Employee.FindFirst then begin
            if Employee."Department Code" <> '' then begin
                Rec.SetRange("Department Code", Employee."Department Code");
            end;
        end;
    end;
}
