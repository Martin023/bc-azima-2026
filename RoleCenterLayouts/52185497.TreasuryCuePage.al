page 52185497 "Treasury Cue Page"
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "Treasury Cue Table";
    RefreshOnActivate = True;

    layout
    {
        area(content)
        {
            cuegroup(General)
            {
                ShowCaption = true;
                //CuegroupLayout = Wide;
                // field("Tenants List"; Rec."Tenants List")
                // {
                //     Image = none;
                //     ApplicationArea = All;
                //     DrillDownPageId = "Tenant List";
                // }
                field("Sales Invoice"; Rec."Sales Invoice")
                {
                    ApplicationArea = All;

                    DrillDownPageId = "Posted Sales Invoices";
                }

                field(Receipt; Rec.Receipt)
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Posted Receipt List";
                }
                // field("TC Transactions"; Rec."TC Transactions")
                // {
                //     Caption = 'Treasury and Cashier Transactions This month';
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of Treasury and Cashier Transactions This month';
                //     DrillDownPageId = "Treasury Cashier List";
                // }
                field("Tenant Invoicing"; Rec."Invoicing of Tenants")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of Tenant Invoicing';
                    DrillDownPageId = "Customer List";
                    Editable = false;
                }
                field("External Conf. Hall Clients"; Rec."External Conf. Hall Clients")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of External Conf. Hall Clients';
                    DrillDownPageId = "MNS Conf & Meetings Appl List";
                    Editable = false;
                }
                field("Invoicing of Parking"; Rec."Invoicing of Parking")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of Invoicing of Parking';
                    DrillDownPageId = "Parking Space List";
                    Editable = false;
                }

            }
            cuegroup(Summary)
            {
                Caption = 'Investments';
                field("Investments and Money Market"; Rec."Investments and Money Market")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sacco Investments.';
                }
                field("Matured Investments"; Rec."Matured Investments")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sacco Investments.';
                }
                // field("Petty Cash Payments"; Rec."Petty Cash Payments")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Petty Cash payments';
                // }

                // field("Cash Flow Forecasts"; Rec."Cash Flow Forecasts")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Main Treasury.';
                // }

                // field("Cash Flow Manual Expenses"; Rec."Cash Flow Manual Revenue")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Cash flow manual revenue.';
                // }

            }
        }
    }
    actions
    {
        area(processing)
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

    trigger OnOpenPage();
    begin
        if not rec.Get() then begin
            rec.Init();
            rec.Insert();
        end;
    end;

    trigger OnAfterGetCurrRecord()

    begin
        CalcDailyCashierTrans();
    end;

    local procedure CalcDailyCashierTrans()
    var
        CashierTransactionsToday: Decimal;
        CashierTransactionsCU: Codeunit CustomCuesCodeunit;
    begin
        rec."Cashier Transactions Today" := CashierTransactionsCU.CalcDailyCashierTrans();
        rec."TC Transactions" := CashierTransactionsCU.TreasuryTransThisMonth();
    end;


}

