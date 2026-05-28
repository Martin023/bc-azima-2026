controladdin ChartAddIn
{
    RequestedHeight = 250;
    MinimumHeight = 200;
    VerticalStretch = true;
    HorizontalStretch = true;
    Scripts = '../scripts/chart.js', '../scripts/chart-engine.js';
    StyleSheets = '../styles/chart.css';

    event Ready();
    event OnChartError(ErrorMessage: Text);
    event OnDrillDown(Category: Text; Series: Text; Value: Decimal);
    event OnExportComplete(DataUrl: Text; ExportType: Text);

    procedure RenderChart(ConfigJson: Text);
    procedure UpdateChart(ConfigJson: Text);
    procedure ExportToPNG();
    procedure ExportToCSV();
}
