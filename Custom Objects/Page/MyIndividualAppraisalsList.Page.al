page 52185655 "My Individual Appraisals List"
{
    Caption = 'My Individual Appraisals';
    PageType = List;
    SourceTable = "HR Individual Targets Header";
    CardPageID = "HR Individual Appraisal Card";
    ApplicationArea = Basic;
    UsageCategory = Lists;
    Editable = false;
    PromotedActionCategories = 'New,Process,Report,Views';

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
            action("Refresh Period Info")
            {
                ApplicationArea = Basic;
                Caption = 'Refresh Period Info';
                Image = RefreshLines;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Appraisal: Record "HR Individual Targets Header";
                    UpdateCount: Integer;
                begin
                    if not Confirm('Refresh Review Sequence and Period Info for appraisals with missing data?', false) then
                        exit;

                    UpdateCount := 0;
                    Appraisal.Reset;
                    Appraisal.CopyFilters(Rec);
                    if Appraisal.FindSet then begin
                        repeat
                            if (Appraisal."Review Sequence No" = 0) and (Appraisal."Appraisal Period" <> '') then begin
                                Appraisal.SyncWithAppraisalPeriod();
                                UpdateCount += 1;
                            end;
                        until Appraisal.Next = 0;
                    end;

                    Message('%1 appraisal(s) updated.', UpdateCount);
                    CurrPage.Update(false);
                end;
            }
            action("Open Appraisal")
            {
                ApplicationArea = Basic;
                Caption = 'Open Appraisal';
                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PAGE.Run(PAGE::"HR Individual Appraisal Card", Rec);
                end;
            }
            action("Create New Appraisal")
            {
                ApplicationArea = Basic;
                Caption = 'Create New Appraisal';
                Image = New;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    NewAppraisal: Record "HR Individual Targets Header";
                begin
                    NewAppraisal.Init;
                    NewAppraisal.Insert(true);
                    PAGE.Run(PAGE::"HR Individual Appraisal Card", NewAppraisal);
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        HREmp: Record "HR Employees";
        CurrentEmpNo: Code[20];
    begin
        HREmp.Reset;
        HREmp.SetRange("User ID", UserId);
        if HREmp.FindFirst then begin
            CurrentEmpNo := HREmp."No.";
            Rec.SetRange("Employee No", CurrentEmpNo);
        end else begin
            Rec.SetRange("Employee No", 'DUMMY_NONEXISTENT');
        end;
    end;
}
