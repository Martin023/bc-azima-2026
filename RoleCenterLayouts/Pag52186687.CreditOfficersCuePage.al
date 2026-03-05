namespace MNS.MNS;
using System.Visualization;

page 52186687 "Credit Officers Cue Page"
{
    Caption = 'Credit Officers Cue Page';
    PageType = CardPart;
    SourceTable = "Credit Officers Cue Table";
    ApplicationArea = All;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            cuegroup("Loans")
            {
                ShowCaption = true;
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
            cuegroup("Totals")
            {
                ShowCaption = true;
                //CuegroupLayout = wide;
                // field("Total Members Savings' Account Balance"; Rec."Total Members Savings' Account Balance")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Total Cashier Transactions"; Rec."T/Cashier Transactions")
                {
                    ApplicationArea = Basic;
                    // Image = None;
                }
                field("Cashier Transactions"; Rec."Cashier Transactions")
                {
                    ApplicationArea = Basic;
                    // Image = None;
                }
                // field("Total Processed Salaries"; Rec."Total Processed Salaries")
                // {
                //     ApplicationArea = Basic;
                // }

                // field("Total EFT Transfers"; Rec."Total EFT Transfers")
                // {
                //     ApplicationArea = Basic;
                // }
            }
            cuegroup("Banking Activities")
            {
                ShowCaption = true;
                field("Savings Accounts"; Rec."Savings Accounts")
                {
                    ApplicationArea = Basic;
                    // Image = None;
                }
                field("EFT Trasfers"; Rec."EFT Transfer List")
                {
                    ApplicationArea = Basic;
                    // Image = None;
                }
                field("Posted Account Tranfers"; Rec."Posted Account Transfers")
                {
                    ApplicationArea = Basic;
                    // Image = None;
                }
                field("Authorized Bank Overdrafts"; Rec."Authorized Bank Overdrafts")
                {
                    ApplicationArea = Basic;
                    // Image = None;
                }
                field("Banking Closure"; Rec."Banking Closure")
                {
                    ApplicationArea = Basic;
                    style = Unfavorable;
                    // Image = None;
                }
                // field("Bonds"; Rec."Active Bonds")
                // {
                //     ApplicationArea = Basic;
                // }
            }

            cuegroup("ATM Management")
            {
                ShowCaption = true;
                field("Approved ATM Applications"; Rec."Approved ATM")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Transactions"; Rec."ATM Transactions")
                {
                    ApplicationArea = Basic;
                }

            }

            cuegroup("M-Hela Management")
            {
                ShowCaption = true;
                field("M-Hela Transactions"; Rec."M-Hela Transactions")
                {
                    ApplicationArea = Basic;
                    // Image = None;
                }

            }

            

            cuegroup("Cheques")
            {
                ShowCaption = True;
                field("Cleared Cheque"; Rec."Cleared Cheques")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Cheque Books"; Rec."Approved Cheque Books")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Banker's Cheques"; Rec."Approved Banker's Cheques")
                {
                    ApplicationArea = Basic;
                }
            }

            cuegroup("Periodic Activities")
            {
                ShowCaption = True;
                field("Processed Salaries"; Rec."Processed Salaries")
                {
                    ApplicationArea = Basic;
                    // Image = None;
                }
                field("SStanding Order"; Rec."Successful Standing Orders")
                {
                    ApplicationArea = Basic;
                    // Image = None;

                }
                field("Standing Order"; Rec."Partial Deduction STO")
                {
                    ApplicationArea = Basic;
                    // Image = None;

                }
                field("Standing Orders"; Rec."Unsuccessful Standing Order")
                {
                    ApplicationArea = Basic;
                    // Image = None;
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

}



