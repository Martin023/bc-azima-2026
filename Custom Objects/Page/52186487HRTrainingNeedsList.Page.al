page 52186487 "HR Training Needs List"
{
    CardPageID = "HR Training Needs Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "HR Training Needs";
    Caption = 'Training Needs List';
    ApplicationArea = Basic;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                Editable = false;
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = Rec.Status = Rec.Status::Approved;
                }
                field("Training Category"; Rec."Training Category")
                {
                    ApplicationArea = Basic;
                }
                field("Training Type"; Rec."Training Type")
                {
                    ApplicationArea = Basic;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Need Source"; Rec."Need Source")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Total Costs"; Rec."Total Costs")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755003; Outlook)
            {
                ApplicationArea = Basic;
            }
            systempart(Control1102755005; Notes)
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Show Open")
            {
                ApplicationArea = Basic;
                Caption = 'Open';
                Image = FilterLines;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.SetFilter(Status, '%1|%2', Rec.Status::New, Rec.Status::"Pending Approval");
                    CurrPage.Update(false);
                end;
            }
            action("Show Approved")
            {
                ApplicationArea = Basic;
                Caption = 'Approved';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.SetRange(Status, Rec.Status::Approved);
                    CurrPage.Update(false);
                end;
            }
            action("Show All")
            {
                ApplicationArea = Basic;
                Caption = 'All';
                Image = ClearFilter;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.SetRange(Status);
                    CurrPage.Update(false);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        // DEFAULT: SHOW ONLY ACTIVE (NEW + PENDING) — NOT YET APPROVED OR REJECTED
        Rec.SetFilter(Status, '%1|%2', Rec.Status::New, Rec.Status::"Pending Approval");
    end;
}

