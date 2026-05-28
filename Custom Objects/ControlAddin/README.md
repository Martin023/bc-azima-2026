# SkyChart - Business Central Chart.js Integration

A production-ready, DRY charting library for Business Central using Chart.js.

## Features

✅ **Point-Based Builder Pattern** - Add data points semantically, no manual array management  
✅ **Version-Safe Tooltips** - Works with Chart.js v2 and v3  
✅ **Locale-Aware Formatting** - Respects BC user language and regional settings  
✅ **Stacked Charts** - With automatic percentage calculation  
✅ **Dual Axes** - Primary and secondary Y-axes for different scales  
✅ **Flexible Tooltips** - Currency, basic (count), or percentage formatting  
✅ **Chart Titles** - Professional titles with `SetTitle()` method  
✅ **Drilldown Support** - Click events with category, series, and value  
✅ **Dynamic Refresh** - Update charts without full re-render  
✅ **Duplicate-Safe** - Automatic handling of duplicate data points  
✅ **CardPart Optimized** - 250px default height for Role Centers  
✅ **Mixed Chart Types** - Combine bars and lines on same chart (NEW v3.0)  
✅ **Animation Control** - Customize duration and easing from AL (NEW v3.0)  
✅ **Export Functionality** - Export to PNG or CSV (NEW v3.0)  
✅ **Color Themes** - 8 professional themes: default, pastel, vibrant, corporate, earth, ocean, sunset, monochrome (NEW v3.0)  
✅ **Legend Control** - Position or hide legend (NEW v3.0)  
✅ **Axis Labels** - Custom X and Y axis labels (NEW v3.0)  
✅ **Data Labels** - Show values on chart points (NEW v3.0)  
✅ **Horizontal Bars** - Horizontal bar chart orientation (NEW v3.0)  
✅ **Time Series** - Proper date/time axis support (NEW v3.0)  
✅ **Zero JavaScript Changes** - All logic in AL, JS is just a renderer  

## Quick Start

```al
local procedure DrawChart()
var
    Builder: Codeunit "sky Chart Builder";
    Json: Text;
begin
    // 1. Initialize
    Builder.Init(Enum::"sky Chart Type"::Bar);
    Builder.SetLocale('en-KE');
    Builder.SetTitle('Sales Overview'); // NEW: Chart title

    // 2. Add data points (duplicate-safe)
    Builder.AddPoint('JAN', 'SALES', 10000, 'rgba(54,162,235,0.8)', false);
    Builder.AddPoint('JAN', 'COSTS', 6000, 'rgba(255,99,132,0.8)', true);

    // 3. Configure
    Builder.EnableDualAxis();
    Builder.EnableCurrencyTooltipAuto('KES ');

    // 4. Render
    Json := Builder.Build();
    CurrPage.Chart.RenderChart(Json);
end;
```

## API Reference

### Initialization

```al
Builder.Init(ChartType: Enum "sky Chart Type")
```
Must be called first. Chart types: `Bar`, `Line`, `Pie`, `Doughnut`, `Radar`

### Data Points

```al
Builder.AddPoint(Category: Text; Series: Text; Value: Decimal; Color: Text; UseSecondaryAxis: Boolean)
```
Add a single data point. Automatically manages series and categories.

```al
Builder.AddPointWithType(Category: Text; Series: Text; Value: Decimal; Color: Text; UseSecondaryAxis: Boolean; ChartType: Enum "sky Chart Type")
```
**NEW v3.0:** Add point with specific chart type (for mixed charts - bar + line).

**Example:**
```al
Builder.AddPoint('Q1', 'Revenue', 50000, 'rgba(54,162,235,0.8)', false);
```

### Axes

```al
Builder.EnableDualAxis()
```
Enable left (y) and right (y1) Y-axes for different scales.

```al
Builder.EnableStacked()
```
Enable stacked bar/line chart mode.

```al
Builder.SetXAxisLabel(Label: Text)
```
**NEW v3.0:** Set X-axis label.

```al
Builder.SetYAxisLabel(Label: Text)
```
**NEW v3.0:** Set Y-axis label.

```al
Builder.EnableTimeSeries(TimeUnit: Text)
```
**NEW v3.0:** Enable time series mode. TimeUnit: day, week, month, quarter, year.

### Tooltips

```al
Builder.EnableBasicTooltip()
```
**NEW:** Basic number formatting (no currency). Use for counts, quantities, or percentages.

```al
Builder.EnableCurrencyTooltipAuto(Symbol: Text)
```
Version-safe currency tooltip (Chart.js v2 + v3). Use for monetary values.

```al
Builder.EnableStackedPercentageTooltip()
```
Show value + percentage of stack (1 decimal place).

```al
Builder.EnableStackedPercentageTooltipWithDecimals(Decimals: Integer)
```
Custom decimal places for percentage.

```al
Builder.EnableCurrencyStackedPercentageTooltip(Symbol: Text)
```
Currency + percentage for stacked charts.

### Chart Title

```al
Builder.SetTitle(Title: Text)
```
**NEW:** Set chart title for professional appearance.

### Animation Control (NEW v3.0)

```al
Builder.SetAnimationDuration(DurationMs: Integer)
```
Set animation duration in milliseconds (0 to disable).

```al
Builder.SetAnimationEasing(Easing: Text)
```
Set easing function: linear, easeInOutQuart, easeOutBounce, etc.

```al
Builder.DisableAnimation()
```
Disable animations completely for instant rendering.

### Legend Control (NEW v3.0)

```al
Builder.SetLegendPosition(Position: Text)
```
Position legend: top, bottom, left, right.

```al
Builder.HideLegend()
```
Hide the legend completely.

### Data Labels (NEW v3.0)

```al
Builder.EnableDataLabels()
```
Show values directly on chart points/bars.

### Chart Orientation (NEW v3.0)

```al
Builder.MakeHorizontal()
```
Make bar chart horizontal (useful for long category names).

### Color Themes (NEW v3.0)

```al
Builder.ApplyTheme(ThemeName: Text)
```
Apply professional color theme: default, pastel, vibrant, corporate, earth, ocean, sunset, monochrome.

```al
Builder.GetThemeColor(Index: Integer): Text
```
Get color from current theme by index (0-7).

### Locale

```al
Builder.SetLocale(LanguageTag: Text)
```
Set IETF language tag (e.g., `'en-US'`, `'en-KE'`, `'fr-FR'`).

```al
Builder.SetLocaleFromBC()
```
Automatically use BC user's language.

```al
Builder.SetNumberFormat(DecimalSep: Text; ThousandsSep: Text)
```
Custom decimal and thousands separators.

### Build & Render

```al
Json := Builder.Build()
```
Returns Chart.js configuration JSON ready for rendering.

```al
CurrPage.Chart.RenderChart(Json)
```
Initial render (destroys existing chart if present).

```al
CurrPage.Chart.UpdateChart(Json)
```
**NEW:** Update existing chart without full re-render (smoother, faster).

```al
CurrPage.Chart.ExportToPNG()
```
**NEW v3.0:** Export chart as PNG image (base64 encoded).

```al
CurrPage.Chart.ExportToCSV()
```
**NEW v3.0:** Export chart data to CSV format.

## Examples

### Dual Axis Chart with Title
```al
Builder.Init(Enum::"sky Chart Type"::Bar);
Builder.SetTitle('Sales vs Margin Analysis');
Builder.AddPoint('JAN', 'SALES', 10000, 'rgba(54,162,235,0.8)', false);
Builder.AddPoint('JAN', 'MARGIN %', 15, 'rgba(255,99,132,0.8)', true);
Builder.EnableDualAxis();
Builder.EnableCurrencyTooltipAuto('$');
```

### Stacked Chart with Percentages
```al
Builder.Init(Enum::"sky Chart Type"::Bar);
Builder.SetTitle('Quarterly Revenue by Product');
Builder.AddPoint('Q1', 'Hardware', 45000, 'rgba(54,162,235,0.8)', false);
Builder.AddPoint('Q1', 'Software', 32000, 'rgba(255,99,132,0.8)', false);
Builder.AddPoint('Q1', 'Services', 23000, 'rgba(75,192,192,0.8)', false);
Builder.EnableStacked();
Builder.EnableCurrencyStackedPercentageTooltip('KES ');
```

### Count/Quantity Chart (No Currency)
```al
Builder.Init(Enum::"sky Chart Type"::Line);
Builder.SetTitle('Order Volume by Month');
Builder.AddPoint('JAN', 'Orders', 145, 'rgba(54,162,235,0.8)', false);
Builder.AddPoint('FEB', 'Orders', 178, 'rgba(54,162,235,0.8)', false);
Builder.AddPoint('MAR', 'Orders', 203, 'rgba(54,162,235,0.8)', false);
Builder.EnableBasicTooltip(); // No currency symbol
```

### Drilldown Support
```al
// In page layout
trigger OnDrillDown(Category: Text; Series: Text; Value: Decimal)
begin
    // Navigate to filtered page
    SalesHeader.SetRange("Posting Date", GetDateFromCategory(Category));
    Page.Run(Page::"Sales Orders", SalesHeader);
end;
```

### Dynamic Refresh
```al
// In page action
action(Refresh)
{
    trigger OnAction()
    begin
        CurrPage.Chart.UpdateChart(BuildChartJson()); // Smooth update
    end;
}
```

### Mixed Chart Types (NEW v3.0)
```al
Builder.Init(Enum::"sky Chart Type"::Bar);
Builder.SetTitle('Sales & Trend');
Builder.ApplyTheme('vibrant');

// Sales as bars
Builder.AddPoint('JAN', 'Sales', 45000, Builder.GetThemeColor(0), false);

// Trend as line (mixed type)
Builder.AddPointWithType('JAN', 'Trend', 47000, Builder.GetThemeColor(1), false, Enum::"sky Chart Type"::Line);
```

### Color Themes (NEW v3.0)
```al
Builder.Init(Enum::"sky Chart Type"::Bar);
Builder.ApplyTheme('ocean'); // or: pastel, vibrant, corporate, earth, sunset, monochrome

Builder.AddPoint('Q1', 'Revenue', 50000, Builder.GetThemeColor(0), false);
Builder.AddPoint('Q1', 'Costs', 32000, Builder.GetThemeColor(1), false);
```

### Horizontal Bars (NEW v3.0)
```al
Builder.Init(Enum::"sky Chart Type"::Bar);
Builder.MakeHorizontal(); // Perfect for long category names
Builder.AddPoint('Very Long Product Name', 'Sales', 45000, 'rgba(54,162,235,0.8)', false);
```

### Data Labels (NEW v3.0)
```al
Builder.Init(Enum::"sky Chart Type"::Bar);
Builder.EnableDataLabels(); // Show values on bars/points
Builder.AddPoint('JAN', 'Sales', 45000, 'rgba(54,162,235,0.8)', false);
```

### Time Series (NEW v3.0)
```al
Builder.Init(Enum::"sky Chart Type"::Line);
Builder.EnableTimeSeries('day'); // or: week, month, quarter, year
Builder.AddPoint('2026-01-15', 'Sales', 45000, 'rgba(54,162,235,0.8)', false);
Builder.AddPoint('2026-01-16', 'Sales', 52000, 'rgba(54,162,235,0.8)', false);
```

### Export Functionality (NEW v3.0)
```al
// In page layout
trigger OnExportComplete(DataUrl: Text; ExportType: Text)
begin
    if ExportType = 'PNG' then
        Message('PNG ready: %1 chars', StrLen(DataUrl))
    else if ExportType = 'CSV' then
        DownloadFromStream(InStr, 'Export', '', 'CSV|*.csv', 'data.csv');
end;

// In page action
action(ExportPNG)
{
    trigger OnAction()
    begin
        CurrPage.Chart.ExportToPNG();
    end;
}

action(ExportCSV)
{
    trigger OnAction()
    begin
        CurrPage.Chart.ExportToCSV();
    end;
}
```

### Animation Control (NEW v3.0)
```al
Builder.Init(Enum::"sky Chart Type"::Bar);
Builder.SetAnimationDuration(2000); // 2 seconds
Builder.SetAnimationEasing('easeOutBounce'); // Bouncy animation
// Or disable: Builder.DisableAnimation();
```

### Axis Labels (NEW v3.0)
```al
Builder.Init(Enum::"sky Chart Type"::Bar);
Builder.SetXAxisLabel('Product Category');
Builder.SetYAxisLabel('Sales Amount (KES)');
Builder.SetLegendPosition('bottom');
```

## Architecture

```
┌─────────────────────────────────────────┐
│  AL Layer (Business Logic)              │
│  ├─ Builder Pattern (DRY)               │
│  ├─ Type-safe Enum                      │
│  ├─ Locale Management                   │
│  └─ Version-Safe Callbacks              │
├─────────────────────────────────────────┤
│  JavaScript Layer (Rendering)           │
│  ├─ Initialization Guard                │
│  ├─ Error Handling                      │
│  └─ Chart.js Integration                │
├─────────────────────────────────────────┤
│  CSS Layer (Presentation)               │
│  └─ Responsive Layout                   │
└─────────────────────────────────────────┘
```

## Design Principles

1. **AL is authoritative** - All business logic in AL, JS is dumb renderer
2. **DRY** - Point-based API eliminates data duplication
3. **Version-safe** - Defensive callbacks work across Chart.js versions
4. **Locale-aware** - Respects BC language and regional settings
5. **AppSource-ready** - No hardcoded values, fully configurable
6. **Crash-resistant** - Duplicate key handling, null checks, fallbacks
7. **Performance-optimized** - UpdateChart() for smooth refreshes

## What's New in v2.0

| Feature | Description | Impact |
|---------|-------------|--------|
| **Duplicate Key Fix** | `AddPoint()` checks `ContainsKey()` before adding | ✅ No more runtime crashes |
| **Flexible Tooltips** | `EnableBasicTooltip()` for counts/quantities | ✅ Proper formatting per data type |
| **Chart Titles** | `SetTitle()` method | ✅ Professional appearance |
| **Drilldown Events** | `OnDrillDown` trigger with category/series/value | ✅ Navigate to detail pages |
| **Dynamic Refresh** | `UpdateChart()` method | ✅ Smooth updates without flicker |
| **CardPart Height** | 250px default (was 400px) | ✅ Better Role Center fit |

## Files

- `controladdin/ChartAddIn.al` - Control add-in definition (with drilldown event)
- `scripts/chart.js` - Chart.js library (v4.5.1)
- `scripts/chart-engine.js` - Rendering engine (with UpdateChart support)
- `styles/chart.css` - Responsive styling
- `chartcodeunits/skyChartBuilder.al` - Builder codeunit (with title support)
- `chartcodeunits/skyChartColors.al` - Color helper codeunit
- `chartenums/skyChartType.al` - Chart type enum
- `chartenums/skyChartColor.al` - Color enum
- `examples/example-usage/Pag96006.skyExampleSalesChart.al` - Dual axis with drilldown
- `examples/example-usage/Pag96007.skyStackedChartExample.al` - Stacked with refresh
- `examples/example-permissionsets/` - Permission sets

## License

MIT License - See Chart.js license for library terms.
