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

            cuegroup("Mobile Transactions")
            {
                ShowCaption = true;
                field("Mobile Transaction"; Rec."Mobile Transactions")
                {
                    Caption = 'Mobile Transactions';
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

            usercontrol(BankingChart; ChartAddIn)
            {
                ApplicationArea = All;

                trigger Ready()
                begin
                    DrawBankingChart();
                end;

                trigger OnChartError(ErrorMessage: Text)
                begin
                    Message('CHART ERROR: %1', ErrorMessage);
                end;

                trigger OnDrillDown(Category: Text; Series: Text; Value: Decimal)
                begin
                    HandleDrilldown(Category, Series, Value);
                end;

                trigger OnExportComplete(DataUrl: Text; ExportType: Text)
                begin
                    HandleExport(DataUrl, ExportType);
                end;
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

            action(RefreshChart)
            {
                ApplicationArea = All;
                Caption = 'Refresh Chart';
                Image = Refresh;
                // Promoted = true;
                // PromotedCategory = Process;

                trigger OnAction()
                begin
                    CurrPage.BankingChart.UpdateChart(BuildBankingChart());
                end;
            }

            action(ExportPNG)
            {
                ApplicationArea = All;
                Caption = 'Export Chart';
                Image = Picture;
                // Promoted = true;
                // PromotedCategory = Process;

                trigger OnAction()
                begin
                    CurrPage.BankingChart.ExportToPNG();
                end;
            }

            action(ExportCSV)
            {
                ApplicationArea = All;
                Caption = 'Export Data';
                Image = Excel;
                // Promoted = true;
                // PromotedCategory = Process;

                trigger OnAction()
                begin
                    CurrPage.BankingChart.ExportToCSV();
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

    local procedure DrawBankingChart()
    begin
        CurrPage.BankingChart.RenderChart(BuildBankingChart());
    end;

    local procedure BuildBankingChart(): Text
    var
        Builder: Codeunit "sky Chart Builder";
    begin
        Builder.Init(Enum::"sky Chart Type"::Bar);
        Builder.SetTitle('BANKING ACTIVITIES OVERVIEW');
        Builder.ApplyTheme('corporate');
        Builder.SetLegendPosition('bottom');
        Builder.SetXAxisLabel('ACTIVITY TYPE');
        Builder.SetYAxisLabel('COUNT');
        Builder.EnableDataLabels();
        Builder.SetAnimationDuration(1200);
        Builder.SetAnimationEasing('easeOutBounce');

        Builder.AddPoint('CASHIER', 'TOTAL TRANSACTIONS', Rec."T/Cashier Transactions", Builder.GetThemeColor(0), false);
        Builder.AddPoint('CASHIER', 'TRANSACTIONS', Rec."Cashier Transactions", Builder.GetThemeColor(1), false);

        Builder.AddPoint('ACCOUNTS', 'SAVINGS', Rec."Savings Accounts", Builder.GetThemeColor(0), false);
        Builder.AddPoint('ACCOUNTS', 'EFT TRANSFERS', Rec."EFT Transfer List", Builder.GetThemeColor(1), false);
        Builder.AddPoint('ACCOUNTS', 'POSTED TRANSFERS', Rec."Posted Account Transfers", Builder.GetThemeColor(2), false);
        Builder.AddPoint('ACCOUNTS', 'OVERDRAFTS', Rec."Authorized Bank Overdrafts", Builder.GetThemeColor(3), false);
        Builder.AddPoint('ACCOUNTS', 'CLOSURES', Rec."Banking Closure", Builder.GetThemeColor(4), false);

        Builder.AddPoint('ATM', 'APPROVED', Rec."Approved ATM", Builder.GetThemeColor(0), false);
        Builder.AddPoint('ATM', 'TRANSACTIONS', Rec."ATM Transactions", Builder.GetThemeColor(1), false);

        Builder.AddPoint('MOBILE', 'TRANSACTIONS', Rec."Mobile Transactions", Builder.GetThemeColor(0), false);

        Builder.AddPoint('CHEQUES', 'CLEARED', Rec."Cleared Cheques", Builder.GetThemeColor(0), false);
        Builder.AddPoint('CHEQUES', 'BOOKS APPROVED', Rec."Approved Cheque Books", Builder.GetThemeColor(1), false);
        Builder.AddPoint('CHEQUES', 'BANKERS APPROVED', Rec."Approved Banker's Cheques", Builder.GetThemeColor(2), false);

        Builder.AddPoint('PERIODIC', 'SALARIES', Rec."Processed Salaries", Builder.GetThemeColor(0), false);
        Builder.AddPoint('PERIODIC', 'STO SUCCESS', Rec."Successful Standing Orders", Builder.GetThemeColor(1), false);
        Builder.AddPoint('PERIODIC', 'STO PARTIAL', Rec."Partial Deduction STO", Builder.GetThemeColor(2), false);
        Builder.AddPoint('PERIODIC', 'STO FAILED', Rec."Unsuccessful Standing Order", Builder.GetThemeColor(3), false);

        Builder.AddPoint('PORTAL', 'STANDING ORDERS', Rec."Portal Standing Orders", Builder.GetThemeColor(0), false);
        Builder.AddPoint('PORTAL', 'DEPENDENCY APPS', Rec."Open Dependacy Application", Builder.GetThemeColor(1), false);

        Builder.EnableBasicTooltip();

        exit(Builder.Build());
    end;

    local procedure HandleDrilldown(Category: Text; Series: Text; Value: Decimal)
    begin
        Message('CATEGORY: %1\nSERIES: %2\nVALUE: %3', Category, Series, Value);
    end;

    local procedure HandleExport(DataUrl: Text; ExportType: Text)
    var
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
        FileName: Text;
    begin
        if ExportType = 'PNG' then begin
            FileName := 'BankingChart_' + Format(CurrentDateTime, 0, '<Year4><Month,2><Day,2>_<Hours24><Minutes,2><Seconds,2>') + '.png';
            Message('PNG EXPORT COMPLETE\nFILENAME: %1\nDATA LENGTH: %2', FileName, StrLen(DataUrl));
        end else if ExportType = 'CSV' then begin
            FileName := 'BankingData_' + Format(CurrentDateTime, 0, '<Year4><Month,2><Day,2>_<Hours24><Minutes,2><Seconds,2>') + '.csv';
            TempBlob.CreateOutStream(OutStr);
            OutStr.WriteText(DataUrl);
            TempBlob.CreateInStream(InStr);
            DownloadFromStream(InStr, 'EXPORT BANKING DATA', '', 'CSV FILES (*.csv)|*.csv', FileName);
        end;
    end;
}




