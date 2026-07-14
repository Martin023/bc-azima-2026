page 52185653 "Supervisor Appraisals List"
{
    Caption = 'My Team Appraisals';
    PageType = List;
    SourceTable = "HR Individual Targets Header";
    CardPageID = "HR Individual Appraisal Card";
    ApplicationArea = Basic;
    UsageCategory = Lists;
    Editable = false;
    PromotedActionCategories = 'New,Process,Report,Views,Filters';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal No"; Rec."Appraisal No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Caption = 'Department';
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Year"; Rec."Appraisal Year")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Cycle Stage"; Rec."Appraisal Cycle Stage")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Appraisal Date"; Rec."Appraisal Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = Rec.Status = Rec.Status::Approved;
                }
                field("Appraisee Submitted"; Rec."Appraisee Submitted")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisee Submission Date"; Rec."Appraisee Submission Date")
                {
                    ApplicationArea = Basic;
                }
                field("Has Disagreements"; Rec."Has Disagreements")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = Rec."Has Disagreements";
                }
                field("Unresolved Discussions"; Rec."Unresolved Discussions")
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = Rec."Unresolved Discussions" > 0;
                }
                field("Total Targeted Score"; Rec."Total Targeted Score")
                {
                    ApplicationArea = Basic;
                }
                field("Total Achieved Score"; Rec."Total Achieved Score")
                {
                    ApplicationArea = Basic;
                }
                field("Total Agreed Rating"; Rec."Total Agreed Rating")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Open Appraisal Card")
            {
                ApplicationArea = Basic;
                Caption = 'Open Appraisal Card';
                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PAGE.Run(PAGE::"HR Individual Appraisal Card", Rec);
                end;
            }
        }
        area(navigation)
        {
            group(Filters)
            {
                Caption = 'Filters';
                action("Show Pending My Review")
                {
                    ApplicationArea = Basic;
                    Caption = 'Show Pending My Review';
                    Image = FilterLines;

                    trigger OnAction()
                    begin
                        Rec.SetRange(Status, Rec.Status::"Pending Approval");
                        CurrPage.Update(false);
                    end;
                }
                action("Show In Discussion")
                {
                    ApplicationArea = Basic;
                    Caption = 'Show In Discussion';
                    Image = Interaction;

                    trigger OnAction()
                    begin
                        Rec.SetRange(Status, Rec.Status::Discussed);
                        CurrPage.Update(false);
                    end;
                }
                action("Show Approved")
                {
                    ApplicationArea = Basic;
                    Caption = 'Show Approved';
                    Image = Approve;

                    trigger OnAction()
                    begin
                        Rec.SetRange(Status, Rec.Status::Approved);
                        CurrPage.Update(false);
                    end;
                }
                action("Show All")
                {
                    ApplicationArea = Basic;
                    Caption = 'Show All';
                    Image = ClearFilter;

                    trigger OnAction()
                    begin
                        Rec.SetRange(Status);
                        FilterToMySupervisees();
                        CurrPage.Update(false);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        FilterToMySupervisees();
    end;

    local procedure FilterToMySupervisees()
    var
        HREmp: Record "HR Employees";
        CurrentEmpNo: Code[20];
    begin
        HREmp.Reset;
        HREmp.SetRange("User ID", UserId);
        if HREmp.FindFirst then begin
            CurrentEmpNo := HREmp."No.";
            Rec.SetRange("Supervisor ID", UserId);
        end else begin
            Rec.SetRange("Supervisor ID", 'DUMMY_NONEXISTENT');
        end;
    end;
}
