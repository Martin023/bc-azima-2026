page 52186781 "DMU Cues"
{
    PageType = CardPart;
    SourceTable = "DMU Cue";
    ApplicationArea = Basic;
    UsageCategory = Lists;
    Caption = 'Activities';
    RefreshOnActivate = true;


    layout
    {
        area(content)
        {
            cuegroup(Control36)
            {
                CueGroupLayout = Wide;
                ShowCaption = false;
                
                // field("Outstanding Loan Balances"; Rec."Outstanding Loan Balances")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Total Outstanding Loans (ALL)';

                //     Image = Cash;
                //     ToolTip = 'Specifies the total amount of Loan Balances';
                //     trigger OnDrillDown()
                //     begin
                //         Page.Run(Page::"Loan Posted List")
                //     end;
                // } 

            }
            cuegroup("Case Forwarding")
            {
                //CuegroupLayout = Wide;
                field("Open Attachments";Rec."Open Attachments")
                {
                    ApplicationArea = Basic;
                    DrillDownPageId = "Recovery & Attachment List";
                    
                }
                field("CF Headers Pending Reversal";Rec."CF Headers Pending Reversal")
                {
                    ApplicationArea = Basic;
                    DrillDownPageId = "Received Cases";
                    
                }
                field("CF Fall off Headers Pending";Rec."CF Fall off Headers Pending")
                {
                    ApplicationArea = Basic;
                    DrillDownPageId = "Received Cases";
                }
                field("Alerts Escalations";Rec."Alerts Escalations")
                {
                    ApplicationArea = Basic;
                    DrillDownPageId = "Received Cases";
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
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;

    end;

    trigger OnAfterGetRecord()
    begin
        CalculateCues();
    end;

    var
        CustomCuesCodeunit: Codeunit CustomCuesCodeunit;

    local procedure CalculateCues()
    begin
        //Rec."Total Loans Disbursed" := CustomCuesCodeunit.GetLoansDisbursedCurrentMonth;
        //rec."Total Loans paid this month" := CustomCuesCodeunit.TotalLoansPaidThisMonth();
        // Rec."Total Loans Disb. This Month" := CustomCuesCodeunit.GetLoansDisbursedCurrentMonth;
        // rec."Total Loans paid this month" := CustomCuesCodeunit.TotalLoansPaidThisMonth();
        // rec."Total Interest paid this month" := CustomCuesCodeunit.TotalInterestPaidThisMonth();
    end;

}

