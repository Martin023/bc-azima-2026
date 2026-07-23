page 52185782 "HR CEO Goals List"
{
    Caption = 'CEO Goals';
    PageType = List;
    SourceTable = "HR CEO Goals Header";
    CardPageID = "HR CEO Goals Card";
    ApplicationArea = Basic;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Goal No."; Rec."Goal No.")
                {
                    ApplicationArea = Basic;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Period Description"; Rec."Appraisal Period Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Period';
                }
                field("Appraisal Year"; Rec."Appraisal Year")
                {
                    ApplicationArea = Basic;
                }
                field("Review Sequence No."; Rec."Review Sequence No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sequence';
                    ToolTip = 'Q1=1, Q2=2, Q3=3, Q4=4';
                }
                field("Appraisal Cycle Stage"; Rec."Appraisal Cycle Stage")
                {
                    ApplicationArea = Basic;
                }
                field("CEO Name"; Rec."CEO Name")
                {
                    ApplicationArea = Basic;
                }
                field("Total Goal Lines"; Rec."Total Goal Lines")
                {
                    ApplicationArea = Basic;
                }
                field("Total HOD Assignments"; Rec."Total HOD Assignments")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = Rec."Total HOD Assignments" > 0;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = Rec.Status = Rec.Status::Approved;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field("Created Date"; Rec."Created Date")
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
            action("New CEO Goals")
            {
                ApplicationArea = Basic;
                Caption = 'New';
                Image = New;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    NewGoal: Record "HR CEO Goals Header";
                begin
                    NewGoal.Init();
                    NewGoal.Insert(true);
                    PAGE.Run(PAGE::"HR CEO Goals Card", NewGoal);
                end;
            }
            action("Show Open")
            {
                ApplicationArea = Basic;
                Caption = 'Open';
                Image = FilterLines;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.SetRange(Status, Rec.Status::Open);
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
}
