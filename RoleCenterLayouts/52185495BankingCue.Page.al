page 52185495 "Banking Activities"
{
    PageType = CardPart;
    SourceTable = "Banking Cue";
    ApplicationArea = Basic;
    UsageCategory = Lists;
    Caption = 'Activities';

    layout
    {
        area(content)
        {
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
                    Image = None;
                }
                field("Cashier Transactions"; Rec."Cashier Transactions")
                {
                    ApplicationArea = Basic;
                    Image = None;
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
                    Image = None;
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

            cuegroup("Mobile Transactions")
            {
                ShowCaption = true;
                field("Mobile Transaction"; Rec."Mobile Transactions")
                {
                    Caption = 'Azima Chapaa';
                    ApplicationArea = Basic;
                    Image = None;
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
                    Image = None;

                }
                field("Standing Order"; Rec."Partial Deduction STO")
                {
                    ApplicationArea = Basic;
                    Image = None;

                }
                field("Standing Orders"; Rec."Unsuccessful Standing Order")
                {
                    ApplicationArea = Basic;
                    Image = None;
                }
            }
            cuegroup("Members Portal")
            {
                ShowCaption = True;
                field("Portal Standing Orders"; Rec."Portal Standing Orders")
                {
                    ApplicationArea = Basic;
                    // Image = None;
                }
                field("Portal Depedancy Applications"; Rec."Open Dependacy Application")
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


