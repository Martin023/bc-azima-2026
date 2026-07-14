page 52186542 "HR Appraisal Period Setup"
{
    PageType = List;
    SourceTable = "HR Appraisal Period";
    SourceTableView = SORTING("Appraisal Period");
    ApplicationArea = Basic;
    UsageCategory = Lists;
    PromotedActionCategories = ' , , , ,Closure';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Period Description"; Rec."Appraisal Period Description")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Cycle Stage"; Rec."Appraisal Cycle Stage")
                {
                    ApplicationArea = Basic;
                }
                field("Review Sequence No"; Rec."Review Sequence No")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Year"; Rec."Appraisal Year")
                {
                    ApplicationArea = Basic;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic;
                }
                field("Date Opened"; Rec."Date Opened")
                {
                    ApplicationArea = Basic;
                }
                field("Date Closed"; Rec."Date Closed")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Sync All Appraisals")
            {
                Caption = 'Sync All Appraisals';
                Image = RefreshLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Update all individual appraisals to match the current cycle stage and dates of this period';

                trigger OnAction()
                var
                    IndivTargetHeader: Record "HR Individual Targets Header";
                    UpdatedCount: Integer;
                begin
                    if not Confirm('This will update ALL individual appraisals for Year %1 - Review %2 to match the current Cycle Stage (%3). Continue?', 
                        true, Rec."Appraisal Year", Rec."Review Sequence No", Format(Rec."Appraisal Cycle Stage")) then
                        exit;

                    UpdatedCount := 0;
                    IndivTargetHeader.Reset;
                    IndivTargetHeader.SetRange("Appraisal Year", Rec."Appraisal Year");
                    IndivTargetHeader.SetRange("Review Sequence No", Rec."Review Sequence No");
                    IndivTargetHeader.SetFilter(Status, '<>%1', IndivTargetHeader.Status::Posted);
                    if IndivTargetHeader.FindSet(true) then begin
                        repeat
                            IndivTargetHeader."Appraisal Cycle Stage" := Rec."Appraisal Cycle Stage";
                            IndivTargetHeader."Period Start Date" := Rec."Period Start Date";
                            IndivTargetHeader."Period End Date" := Rec."Period End Date";
                            IndivTargetHeader."Appraisal Period" := Rec."Appraisal Period Description";
                            IndivTargetHeader.Modify;
                            UpdatedCount += 1;
                        until IndivTargetHeader.Next = 0;
                    end;

                    Message('%1 individual appraisal(s) synchronized successfully.', UpdatedCount);
                end;
            }
            action("Close Period")
            {
                Caption = 'Close Period';
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Do you want to close this appraisal period? This action cannot be reversed.', true) = false then exit;
                    
                    Rec.TestField(Closed, false);
                    Rec.Closed := true;
                    Rec."Date Closed" := Today;
                    Rec.Modify;
                    
                    Message('Appraisal Period successfully closed.');
                end;
            }
            action("Reopen Period")
            {
                Caption = 'Reopen Period';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Do you want to reopen this appraisal period?', true) = false then exit;
                    
                    Rec.TestField(Closed, true);
                    Rec.Closed := false;
                    Rec."Date Closed" := 0D;
                    Rec.Modify;
                    
                    Message('Appraisal Period successfully reopened.');
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        CheckUserPermissions;
    end;

    procedure CheckUserPermissions()
    var
        ChangePermission: Record "Status Change Permissions.";
    begin
        ChangePermission.Reset;
        ChangePermission.SetRange("User ID", UserId);
        ChangePermission.SetRange("Appraisal Setup", true);
        if not ChangePermission.Find('-') then
            Error('You do not have permissions to view, modify or delete appraisal period records. Contact system administrator for assistance. User: %1', UserId);
    end;
}

