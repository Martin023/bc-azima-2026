page 52185494 "Funds Management Activity"
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "Funds Management Cue";

    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            cuegroup("Banking")
            {
                Caption = 'General';
                ShowCaption = false;

                field("Interbank Not Posted"; Rec."Interbank Not Posted")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Interbank Not Posted field.';
                }
                field("Interbank Pending Approval"; Rec."Interbank Pending Approval")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Interbank Pending Approval field.';
                }

            }
            // cuegroup("Totals")
            // {
            //     field("Approved Interbank Transfers"; rec."Approved Interbank Transfers")
            //     {
            //         DrillDownPageId = "Account Transfer List";
            //         Image = Cash; 
            //         ApplicationArea = Basic, Suite;
            //         ToolTip = 'Specifies the value of the Approved Interbank Transfers field.';
            //     }
            //     field("Pending Payment"; rec."Pending Payments")
            //     {
            //         DrillDownPageId = "Payment Vouchers List";
            //         Image = Cash;
            //         ApplicationArea = Basic, Suite;
            //         ToolTip = 'Specifies the value of the Pending Payment field.';
            //     }
            //}

            cuegroup("Advance")
            {
                ShowCaption = True;
                field("Other Advance Not Posted"; Rec."Other Advance Not Posted")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Other Advance Not Posted field.';
                }
                field("Other Advance Pending Approval"; Rec."Other Advance Pending Approval")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Other Advance Pending Approval field.';
                }
            }
            cuegroup("PCV")
            {
                ShowCaption = True;
                field("PCV Not Posted"; Rec."PCV Not Posted")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the PCV Not Posted field.';
                }
                field("PCV Pending Approval"; Rec."PCV Pending Approval")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the PCV Pending Approval field.';
                }
                field("PV Not Posted"; Rec."PV Not Posted")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the PV Not Posted field.';
                }
                field("PV Pending Approval"; Rec."PV Pending Approval")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the PV Pending Approval field.';
                }
            }
            cuegroup("Requisition")
            {
                ShowCaption = True;
                field("Requisitions Not Posted"; Rec."Requisitions Not Posted")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Requisitions Not Posted field.';
                }
                field("Requisitions Pending Approval"; Rec."Requisitions Pending Approval")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Requisitions Pending Approval field.';
                }
            }
            cuegroup("Staff")
            {
                ShowCaption = True;

                field("Staff Claim Not Posted"; Rec."Staff Claim Not Posted")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Staff Claim Not Posted field.';
                }
                field("Staff Claim Pending Approval"; Rec."Staff Claim Pending Approval")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Staff Claim Pending Approval field.';
                }
                field("Staff TA Not Posted"; Rec."Staff TA Not Posted")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Staff TA Not Posted field.';
                }
                field("Staff TA Pending Approval"; Rec."Staff TA Pending Approval")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Staff TA Pending Approval field.';
                }
                field("Staff Travel Not Posted"; Rec."Staff Travel Not Posted")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Staff Travel Not Posted field.';
                }
                field("Staff Travel Pending Approval"; Rec."Staff Travel Pending Approval")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Staff Travel Pending Approval field.';
                }
            }
            cuegroup("Store")
            {
                ShowCaption = True;
                field("Store Req. Not Posted"; Rec."Store Req. Not Posted")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Store Req. Not Posted field.';
                }
                field("Store Req. Pending Approval"; Rec."Store Req. Pending Approval")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Store Req. Pending Approval field.';
                }
            }
            // field(SystemCreatedAt; Rec.SystemCreatedAt)
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the SystemCreatedAt field.';
            // }
            // field(SystemCreatedBy; Rec.SystemCreatedBy)
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the SystemCreatedBy field.';
            // }
            // field(SystemId; Rec.SystemId)
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the SystemId field.';
            // }
            // field(SystemModifiedAt; Rec.SystemModifiedAt)
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the SystemModifiedAt field.';
            // }
            // field(SystemModifiedBy; Rec.SystemModifiedBy)
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the SystemModifiedBy field.';
            // }
            cuegroup("Work Advance")
            {

                ShowCaption = True;
                field("Work Advance Retire Not Posted"; Rec."Work Advance Retire Not Posted")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Work Advance Retire Not Posted field.';
                }
                field("Work Advance Retire Pending"; Rec."Work Advance Retire Pending")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Work Advance Retire Pending field.';
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Cues SetUp")
            {
                ApplicationArea = Basic;
                Caption = 'Set up Cues';
                Image = Setup;
                ToolTip = 'Set up Cues related to the role';
                trigger OnAction()
                var
                    CuesAndKpis: Codeunit "Cues And KPIs";
                    CueRecoredref: RecordRef;
                begin
                    CueRecoredref.GetTable(Rec);
                    CuesAndKpis.OpenCustomizePageForCurrentUser(CueRecoredref.Number);
                end;
            }

        }
    }
    trigger OnOpenPage()
    begin
        if not rec.Get() then begin
            rec.Init();
            Rec.Insert()
        end;
    end;

}
