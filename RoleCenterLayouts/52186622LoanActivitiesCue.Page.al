page 52186622 "Loan Processing Activities"
{
    PageType = CardPart;
    SourceTable = "Loan Cue";
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
                //     DrillDownPageId = "Loans Posted";
                //     Image = Cash;
                //     ToolTip = 'Specifies the total amount of Loan Balances';
                // }
                field("Outstanding Loan Balances"; Rec."Outstanding Loan Balances")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Total Outstanding Loans (ALL)';

                    Image = Cash;
                    ToolTip = 'Specifies the total amount of Loan Balances';
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"Loan Posted List")
                    end;
                }
                // field("Outstanding Interest Balances"; Rec."Outstanding Interest Balances")
                // {
                //     ApplicationArea = Basic, Suite;
                //     DrillDownPageID = "Loans Interest";
                //     Image = Cash;
                //     ToolTip = 'Specifies the total amount of Loan Interest Balances';
                // }
                field("Total Outstanding Interest"; rec."Total Outstanding Interest")
                {
                    Caption = 'Total Interests charged (ALL)';
                    ApplicationArea = Basic, Suite;
                    Image = Cash;
                    ToolTip = 'Specifies the total amount of Loan Interest Balances';

                    trigger OnDrillDown()
                    var
                        CustomCuesCodeunit: Codeunit CustomCuesCodeunit;
                    begin
                        CustomCuesCodeunit.DrillDownInterestBalances();
                    end;
                }
                field("Total Loans Disb. This Month"; Rec."Total Loans Disb. This Month")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Cash;
                    ToolTip = 'Specifies the total amount of Loans Disbursed this month';
                    trigger OnDrillDown()
                    var
                        CustomCuesCodeunit: Codeunit CustomCuesCodeunit;
                    begin
                        CustomCuesCodeunit.DrillDownLoansDisbursedCurrentMonth();
                    end;
                }
                field("Total Loans Repaid"; Rec."Total Loans paid this month")
                {
                    ApplicationArea = Basic, Suite;

                    Image = Cash;
                    ToolTip = 'Specifies the total amount of Loans Repaid this month';
                    trigger OnDrillDown()
                    var
                        CustomCuesCodeunit: Codeunit CustomCuesCodeunit;
                    begin
                        CustomCuesCodeunit.DrillDownLoansPaidThisMonth();
                    end;
                }
                field("Total Interest Paid"; Rec."Total Interest paid this month")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Credit Ledger Entries";
                    Image = Cash;
                    ToolTip = 'Specifies the total amount of Loans Disbursed this month';
                    trigger OnDrillDown()
                    var
                        CustomCuesCodeunit: Codeunit CustomCuesCodeunit;
                    begin
                        CustomCuesCodeunit.DrillDownInterestPaidThisMonth();
                    end;
                }
                // field("Total Loans Disbursed"; Rec."Total Loans Disbursed")
                // {
                //     ApplicationArea = Basic, Suite;
                //     // DrillDownPageID = "Loan Posted List";
                //     Image = Cash;
                //     ToolTip = 'Specifies the total amount of Loans Disbursed this month';
                //     trigger OnDrillDown()
                //     var
                //         CustomCuesCodeunit: Codeunit CustomCuesCodeunit;
                //     begin
                //         CustomCuesCodeunit.DrillDownLoansDisbursedCurrentMonth();
                //     end;
                // }

            }
            cuegroup("Loan Processing")
            {
                //CuegroupLayout = Wide;
                field("Applied Loans"; Rec."Applied Loans")
                {
                    ApplicationArea = Basic;
                    AutoFormatType = 11;
                }
                field("Appraised Loans"; Rec."Appraised Loans")
                {
                    ApplicationArea = Basic;
                    AutoFormatType = 11;
                    Caption = 'Pending Approvals';
                }
                field("Loan Approvals"; Rec."Approved Loans")
                {

                }
                field("Rejected Loans"; Rec."Rejected Loans")
                {
                    ApplicationArea = Basic;

                }
                field("Deffered Loans"; Rec."Deffered Loans")
                {
                    ApplicationArea = Basic;
                    Image = Document;
                }
            }



            cuegroup("Loan Processed")
            {
                ShowCaption = true;
                field("Disbursed Loans"; Rec."Disbursed Loans")
                {
                    ApplicationArea = Basic;
                    image = none;
                    LookupPageId = "Loan Posted List";
                    DrillDownPageId = "Loan Posted list";
                }
                field("Overdue Loans"; Rec."Overdue Loans")
                {
                    Image = Document;
                    Style = Unfavorable;
                    ApplicationArea = Basic;
                }

            }
            cuegroup(Membership)
            {
                ShowCaption = true;
                field("Active Members"; Rec."Active Members")
                {
                    ApplicationArea = Basic, Suite;
                    image = none;
                }
                field("Dormant Members"; Rec."Dormant Members")
                {
                    ApplicationArea = Basic, Suite;
                    image = none;
                }
            }
            cuegroup("Withdrawal Notices")
            {
                ShowCaption = true;
                field("Withdrawals Notices"; Rec."Withdrawals Notices")
                {
                    ApplicationArea = Basic, Suite;
                    AutoFormatType = 11;
                }
            }
            cuegroup("Channels")
            {
                ShowCaption = true;

                field("Open Loans from Portal"; Rec."Loans from Portal")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Displays the total number of open loan applications submitted through the Members Portal.';
                }

                field("Open Loans from APP"; Rec."Loans from APP")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Displays the total number of open loan applications submitted via the Mobile App.';
                }

                field("Pending Approval"; Rec."Channels Pending Approval")
                {
                    ApplicationArea = Basic;
                    Caption = 'Pending Approvals';
                }
                field("Approved Loans"; Rec."Channels Approved Loans")
                {
                    ApplicationArea = Basic;
                }
                field("Open Loan Variations"; Rec."Open Loan Variation")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Shows the count of loan variation requests submitted by members.';
                    DrillDownPageId = "Variations List";
                }

                field("Open Deposit Variations"; Rec."Open Deposit Variation")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Shows the count of deposit variation requests submitted by members.';
                    DrillDownPageId = "Savings Variations List";
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
        Rec."Total Loans Disb. This Month" := CustomCuesCodeunit.GetLoansDisbursedCurrentMonth;
        rec."Total Loans paid this month" := CustomCuesCodeunit.TotalLoansPaidThisMonth();
        rec."Total Interest paid this month" := CustomCuesCodeunit.TotalInterestPaidThisMonth();
    end;

}

