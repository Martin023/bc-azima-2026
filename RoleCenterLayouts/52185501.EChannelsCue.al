page 52185501 "E-Channels Cue"
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "E-Channels Cue Table";

    layout
    {
        area(content)
        {
            cuegroup(Activities)
            {
                ShowCaption = false;
                CuegroupLayout = wide;
                // field("M-Banking Applications Pending Approval"; Rec."M-BankingAppsPendingApproval")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the MBanking Applications field.';
                // }
                // field("M-bBnking Registered Users"; Rec."M-Banking Registered Users")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Mbanking Registered Users field.';
                // }
                field("Disbursed Mobile Loans"; Rec."Disbursed Mobile Loans")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of disbursed mobile loans.';
                    AutoFormatExpression = '1,KSh ';
                    AutoFormatType = 10;
                    Editable = false;
                    DrillDownPageId = "Sky Mobile Loans";
                }
            }
            cuegroup("Transactions")
            {
                cuegroup(MBanking)
                {
                    Caption = 'M-Banking';
                    field("Pending Mobile Transactions"; Rec."Pending Mobile Transactions")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Pending Mobile Transactions field.';
                    }
                    field("Posted Mobile Transactions"; Rec."Posted Mobile Transactions")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Posted Mobile Transactions';
                    }
                }

                // cuegroup(ATM)
                // {
                //     Caption = 'ATM';
                //     field("Pending ATM Transactions"; Rec."Pending ATM Transactions")
                //     {
                //         ApplicationArea = All;
                //         ToolTip = 'Specifies the value of the Pending ATM Transactions field.';
                //     }
                //     field("Posted ATM Transactions"; Rec."Posted ATM Transactions")
                //     {
                //         ApplicationArea = All;
                //         ToolTip = 'Specifies the value of the Posted ATM Transactions';
                //     }
                // }
            }
            cuegroup("Loans")
            {

                // field("Mortagage Requisitions"; Rec."Mortagage Requisitions")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Mortagage Requisitions field.';
                // }
                // field("MBanking Loan Application List"; rec."Msacco Loan Application List")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the MBanking Loan Application List field.';
                //     DrillDownPageId = "MBanking Loan Application List";
                // }

            }
            // cuegroup("Virtual Members")
            // {
            //     field("Created Virtual Members"; Rec."Created Virtual Members")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the value of the Created Virtual Members field.';
            //     }
            // }
            // cuegroup("BusinessAccounts")
            // {
            //     field("Business Accounts"; Rec."Business Accounts")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the value of the Business Accounts field.';
            //     }
            // }

            // cuegroup("Mortgage")
            // {
            //     field("Actioned Morgage"; Rec."Actioned Morgage")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the value of the Actioned Morgage field.';
            //     }
            //     field("Insurance Actioned"; Rec."Insurance Actioned")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the value of the Insurance Actioned field.';
            //     }
            //     field("Insurance Requisition "; Rec."Insurance Requisition")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the value of the Insurance Requisition  field.';
            //     }
            // }
            // cuegroup("Internet Banking")
            // {
            //     field("Online Loans"; Rec."Online Loans")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the value of the Online Loans field.';
            //     }
            //     field("Internet Banking Transactions"; Rec."Internet Banking Transactions")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the value of the Internet Banking Transactions field.';
            //     }
            //     field("Internet Banking Users"; Rec."Internet Banking Users")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the value of the Internet Banking Users field.';
            //     }
            // }
            // cuegroup("Web Portal")
            // {
            //     field("Onboarded Web Portal Members"; Rec."Onboarded Web Portal Members")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the value of the Onboarded Web Portal Members field.';
            //     }
            //     field("Web Portal Users"; Rec."Web Portal Users")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the value of the Web Portal Users field.';
            //     }
            //     field("Checkoff Advice"; Rec."Checkoff Advice")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the value of the Checkoff Advice field.';
            //         DrillDownPageId = "Sky Checkoff Advice";
            //     }
            // }
            // cuegroup("PESA")
            // {
            //     field("PESA  Agent Transactions"; Rec."PESA  Agent Transactions")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the value of the PESA  Agent Transactions field.';
            //     }
            //     field("PESA  Agent Withdrawals"; Rec."PESA  Agent Withdrawals")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the value of the PESA  Agent Withdrawals field.';
            //     }
            //     field("PESA Agents"; Rec."PESA Agents")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the value of the PESA Agents field.';

            //     }

            // }
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

