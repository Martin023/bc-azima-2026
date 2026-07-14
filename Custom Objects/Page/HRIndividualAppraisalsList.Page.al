page 52186156 "HR Individual Appraisals List"
{
    Caption = 'Individual Appraisals - All';
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
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                    ApplicationArea = Basic;
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
                field("Appraisee Submitted"; Rec."Appraisee Submitted")
                {
                    ApplicationArea = Basic;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = Basic;
                }
                field("Source Department Target No"; Rec."Source Department Target No")
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
                action("Show Open")
                {
                    ApplicationArea = Basic;
                    Caption = 'Show Open';
                    Image = FilterLines;

                    trigger OnAction()
                    begin
                        Rec.SetRange(Status, Rec.Status::Open);
                        CurrPage.Update(false);
                    end;
                }
                action("Show Pending Approval")
                {
                    ApplicationArea = Basic;
                    Caption = 'Show Pending Approval';
                    Image = FilterLines;

                    trigger OnAction()
                    begin
                        Rec.SetRange(Status, Rec.Status::"Pending Approval");
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
                        Rec.SetRange("Supervisor ID");
                        Rec.SetRange("Responsibility Center");
                        CurrPage.Update(false);
                    end;
                }
            }
        }
    }
}
