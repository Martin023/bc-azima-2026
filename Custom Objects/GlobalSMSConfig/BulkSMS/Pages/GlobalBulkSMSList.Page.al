page 52186095 "Global Bulk SMS List"
{
    PageType = List;
    SourceTable = "Global Bulk SMS Header";
    Caption = 'Global Bulk SMS Campaigns';
    CardPageId = "Global Bulk SMS Card";
    UsageCategory = Lists;
    ApplicationArea = All;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Campaign No."; Rec."Campaign No.")
                {
                    ApplicationArea = All;
                }
                field("Campaign Name"; Rec."Campaign Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    StyleExpr = StatusStyle;
                }
                field("Total Recipients"; Rec."Total Recipients")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Sent Count"; Rec."Sent Count")
                {
                    ApplicationArea = All;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Failed Count"; Rec."Failed Count")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    StyleExpr = Rec."Failed Count" > 0;
                }
                field("Pending Count"; Rec."Pending Count")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created DateTime"; Rec."Created DateTime")
                {
                    ApplicationArea = All;
                }
                field("Sent DateTime"; Rec."Sent DateTime")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(NewCampaign)
            {
                ApplicationArea = All;
                Caption = 'New Campaign';
                Image = New;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    NewHeader: Record "Global Bulk SMS Header";
                    CampaignCard: Page "Global Bulk SMS Card";
                begin
                    NewHeader.Init();
                    NewHeader.Insert(true);

                    CampaignCard.SetRecord(NewHeader);
                    CampaignCard.Run();
                end;
            }
            action(OpenCampaign)
            {
                ApplicationArea = All;
                Caption = 'Open';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    CampaignCard: Page "Global Bulk SMS Card";
                begin
                    CampaignCard.SetRecord(Rec);
                    CampaignCard.Run();
                end;
            }
            action(DeleteCampaign)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Image = Delete;

                trigger OnAction()
                begin
                    if Confirm('Delete campaign %1?', false, Rec."Campaign Name") then begin
                        Rec.Delete(true);
                        CurrPage.Update(false);
                    end;
                end;
            }
        }
        area(Navigation)
        {
            action(ViewRecipients)
            {
                ApplicationArea = All;
                Caption = 'Recipients';
                Image = CustomerList;
                RunObject = page "Global Bulk SMS Line List";
                RunPageLink = "Campaign No." = field("Campaign No.");
            }
            action(ViewFilters)
            {
                ApplicationArea = All;
                Caption = 'Filters';
                Image = FilterLines;
                RunObject = page "Global Bulk SMS Filter List";
                RunPageLink = "Campaign No." = field("Campaign No.");
            }
            action(ViewTokens)
            {
                ApplicationArea = All;
                Caption = 'Tokens';
                Image = CodesList;
                RunObject = page "Global Bulk SMS Token List";
                RunPageLink = "Campaign No." = field("Campaign No.");
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        case Rec.Status of
            Rec.Status::Draft:
                StatusStyle := 'Standard';
            Rec.Status::Generating:
                StatusStyle := 'Attention';
            Rec.Status::Ready:
                StatusStyle := 'Favorable';
            Rec.Status::Sending:
                StatusStyle := 'Attention';
            Rec.Status::Completed:
                StatusStyle := 'Favorable';
            Rec.Status::Cancelled:
                StatusStyle := 'Unfavorable';
        end;
    end;

    var
        StatusStyle: Text;
}
