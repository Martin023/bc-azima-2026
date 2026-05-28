codeunit 52185437 "sky Chart Builder"
{
    var
        Config: JsonObject;
        Data: JsonObject;
        Options: JsonObject;
        Scales: JsonObject;
        Labels: List of [Text];
        SeriesNames: List of [Text];
        SeriesColors: Dictionary of [Text, Text];
        SeriesAxis: Dictionary of [Text, Boolean];
        SeriesTypes: Dictionary of [Text, Text];
        Points: Dictionary of [Text, Dictionary of [Text, Decimal]];
        Initialized: Boolean;
        IsStacked: Boolean;
        LocaleTag: Text;
        DecimalSeparator: Text;
        ThousandsSeparator: Text;
        ChartTitle: Text;
        HasTitle: Boolean;
        AnimationDuration: Integer;
        AnimationEasing: Text;
        LegendPosition: Text;
        ShowDataLabels: Boolean;
        IsHorizontal: Boolean;
        CurrentTheme: Text;

    procedure Init(ChartType: Enum "sky Chart Type")
    begin
        ClearAll();
        Initialized := true;
        IsStacked := false;
        HasTitle := false;
        IsHorizontal := false;
        ShowDataLabels := false;
        LocaleTag := 'en-US';
        DecimalSeparator := '.';
        ThousandsSeparator := ',';
        AnimationDuration := 1000;
        AnimationEasing := 'easeInOutQuart';
        LegendPosition := 'top';
        CurrentTheme := 'default';
        Config.Add('type', LowerCase(Format(ChartType)));
        Options.Add('maintainAspectRatio', false);
        Options.Add('responsive', true);
    end;

    procedure AddPoint(Category: Text; Series: Text; Value: Decimal; Color: Text; UseSecondaryAxis: Boolean)
    var
        SeriesPoints: Dictionary of [Text, Decimal];
    begin
        RequireInit();
        if not Labels.Contains(Category) then
            Labels.Add(Category);
        if not SeriesNames.Contains(Series) then begin
            SeriesNames.Add(Series);
            SeriesColors.Add(Series, Color);
            SeriesAxis.Add(Series, UseSecondaryAxis);
        end;
        if not Points.ContainsKey(Series) then begin
            Clear(SeriesPoints);
            Points.Add(Series, SeriesPoints);
        end;
        SeriesPoints := Points.Get(Series);
        if SeriesPoints.ContainsKey(Category) then
            SeriesPoints.Set(Category, Value)
        else
            SeriesPoints.Add(Category, Value);
        Points.Set(Series, SeriesPoints);
    end;

    procedure AddPointWithType(Category: Text; Series: Text; Value: Decimal; Color: Text; UseSecondaryAxis: Boolean; ChartType: Enum "sky Chart Type")
    begin
        AddPoint(Category, Series, Value, Color, UseSecondaryAxis);
        if not SeriesTypes.ContainsKey(Series) then
            SeriesTypes.Add(Series, LowerCase(Format(ChartType)))
        else
            SeriesTypes.Set(Series, LowerCase(Format(ChartType)));
    end;

    procedure EnableDualAxis()
    begin
        Scales.Add('y', CreateAxis(false, false));
        Scales.Add('y1', CreateAxis(true, false));
        Options.Add('scales', Scales);
    end;

    procedure EnableStacked()
    begin
        IsStacked := true;
        Scales.Add('x', CreateStackedAxis());
        Scales.Add('y', CreateAxis(false, true));
        Options.Add('scales', Scales);
    end;

    procedure SetXAxisLabel(Label: Text)
    var
        XAxis: JsonObject;
        XTitle: JsonObject;
        XToken: JsonToken;
        ScalesToken: JsonToken;
    begin
        // ENSURE SCALES EXISTS IN OPTIONS
        if Options.Contains('scales') then begin
            Options.Get('scales', ScalesToken);
            Scales := ScalesToken.AsObject();
        end;

        if not Scales.Contains('x') then
            Scales.Add('x', CreateStackedAxis());
        Scales.Get('x', XToken);
        XAxis := XToken.AsObject();
        XTitle.Add('display', true);
        XTitle.Add('text', Label);
        XAxis.Replace('title', XTitle);
        Scales.Replace('x', XAxis);
        
        if Options.Contains('scales') then
            Options.Replace('scales', Scales)
        else
            Options.Add('scales', Scales);
    end;

    procedure SetYAxisLabel(Label: Text)
    var
        YAxis: JsonObject;
        YTitle: JsonObject;
        YToken: JsonToken;
        ScalesToken: JsonToken;
    begin
        // ENSURE SCALES EXISTS IN OPTIONS
        if Options.Contains('scales') then begin
            Options.Get('scales', ScalesToken);
            Scales := ScalesToken.AsObject();
        end;

        if not Scales.Contains('y') then
            Scales.Add('y', CreateAxis(false, false));
        Scales.Get('y', YToken);
        YAxis := YToken.AsObject();
        YTitle.Add('display', true);
        YTitle.Add('text', Label);
        YAxis.Replace('title', YTitle);
        Scales.Replace('y', YAxis);
        
        if Options.Contains('scales') then
            Options.Replace('scales', Scales)
        else
            Options.Add('scales', Scales);
    end;

    procedure EnableTimeSeries(TimeUnit: Text)
    var
        XAxis: JsonObject;
        TimeConfig: JsonObject;
    begin
        XAxis.Add('type', 'time');
        TimeConfig.Add('unit', TimeUnit);
        XAxis.Add('time', TimeConfig);
        Scales.Add('x', XAxis);
        Options.Replace('scales', Scales);
    end;

    procedure SetTitle(Title: Text)
    begin
        ChartTitle := Title;
        HasTitle := true;
    end;

    procedure SetAnimationDuration(DurationMs: Integer)
    begin
        AnimationDuration := DurationMs;
    end;

    procedure SetAnimationEasing(Easing: Text)
    begin
        AnimationEasing := Easing;
    end;

    procedure DisableAnimation()
    begin
        AnimationDuration := 0;
    end;

    procedure SetLegendPosition(Position: Text)
    begin
        LegendPosition := Position;
    end;

    procedure HideLegend()
    begin
        LegendPosition := 'none';
    end;

    procedure EnableDataLabels()
    begin
        ShowDataLabels := true;
    end;

    procedure MakeHorizontal()
    begin
        IsHorizontal := true;
    end;

    procedure ApplyTheme(ThemeName: Text)
    begin
        CurrentTheme := ThemeName;
    end;

    procedure GetThemeColor(Index: Integer): Text
    var
        Themes: Codeunit "sky Chart Themes";
    begin
        exit(Themes.GetThemeColor(CurrentTheme, Index));
    end;

    procedure EnableBasicTooltip()
    var
        Plugins, Tooltip, Callbacks : JsonObject;
        CallbackCode: Text;
    begin
        CallbackCode := 'function(ctx){var val=(ctx.parsed?ctx.parsed.y:ctx.value)||0;return ctx.dataset.label+": "+val.toLocaleString("' + LocaleTag + '");}';
        Callbacks.Add('label', CallbackCode);
        Tooltip.Add('callbacks', Callbacks);
        Plugins.Add('tooltip', Tooltip);
        Options.Add('plugins', Plugins);
    end;

    procedure EnableCurrencyTooltipAuto(Symbol: Text)
    var
        Plugins, Tooltip, Callbacks : JsonObject;
        CallbackCode: Text;
    begin
        CallbackCode := 'function(ctx){var val=(ctx.parsed?ctx.parsed.y:ctx.value)||0;return ctx.dataset.label+": ' + Symbol + '"+val.toLocaleString("' + LocaleTag + '");}';
        Callbacks.Add('label', CallbackCode);
        Tooltip.Add('callbacks', Callbacks);
        Plugins.Add('tooltip', Tooltip);
        Options.Add('plugins', Plugins);
    end;

    procedure EnableStackedPercentageTooltip()
    begin
        EnableStackedPercentageTooltipWithDecimals(1);
    end;

    procedure EnableStackedPercentageTooltipWithDecimals(Decimals: Integer)
    var
        Plugins, Tooltip, Callbacks : JsonObject;
        CallbackCode: Text;
    begin
        CallbackCode := 'function(ctx){var val=(ctx.parsed?ctx.parsed.y:ctx.value)||0;var total=0;var dataIndex=ctx.dataIndex;ctx.chart.data.datasets.forEach(function(ds){if(ds.data[dataIndex])total+=ds.data[dataIndex];});var pct=total>0?(val/total*100):0;return ctx.dataset.label+": "+val.toLocaleString("' + LocaleTag + '")+" ("+pct.toFixed(' + Format(Decimals) + ')+"%)"}';
        Callbacks.Add('label', CallbackCode);
        Tooltip.Add('callbacks', Callbacks);
        Plugins.Add('tooltip', Tooltip);
        Options.Add('plugins', Plugins);
    end;

    procedure EnableCurrencyStackedPercentageTooltip(Symbol: Text)
    var
        Plugins, Tooltip, Callbacks : JsonObject;
        CallbackCode: Text;
    begin
        CallbackCode := 'function(ctx){var val=(ctx.parsed?ctx.parsed.y:ctx.value)||0;var total=0;var dataIndex=ctx.dataIndex;ctx.chart.data.datasets.forEach(function(ds){if(ds.data[dataIndex])total+=ds.data[dataIndex];});var pct=total>0?(val/total*100):0;return ctx.dataset.label+": ' + Symbol + '"+val.toLocaleString("' + LocaleTag + '")+" ("+pct.toFixed(1)+"%)";}';
        Callbacks.Add('label', CallbackCode);
        Tooltip.Add('callbacks', Callbacks);
        Plugins.Add('tooltip', Tooltip);
        Options.Add('plugins', Plugins);
    end;

    procedure SetLocale(LanguageTag: Text)
    begin
        LocaleTag := LanguageTag;
    end;

    procedure SetLocaleFromBC()
    var
        WindowsLanguage: Record "Windows Language";
    begin
        if WindowsLanguage.Get(GlobalLanguage()) then
            LocaleTag := WindowsLanguage."Abbreviated Name"
        else
            LocaleTag := 'en-US';
    end;

    procedure SetNumberFormat(DecimalSep: Text; ThousandsSep: Text)
    begin
        DecimalSeparator := DecimalSep;
        ThousandsSeparator := ThousandsSep;
    end;

    procedure Build(): Text
    var
        Result: Text;
        LabelArray: JsonArray;
        DatasetArray: JsonArray;
        Series: Text;
        Category: Text;
        Dataset: JsonObject;
        Values: JsonArray;
        SeriesPoints: Dictionary of [Text, Decimal];
        Plugins: JsonObject;
        PluginToken: JsonToken;
        Title: JsonObject;
        Legend: JsonObject;
        Animation: JsonObject;
    begin
        RequireInit();
        if IsHorizontal then
            Config.Replace('type', 'bar');

        foreach Category in Labels do
            LabelArray.Add(Category);

        foreach Series in SeriesNames do begin
            Clear(Values);
            SeriesPoints := Points.Get(Series);
            foreach Category in Labels do begin
                if SeriesPoints.ContainsKey(Category) then
                    Values.Add(SeriesPoints.Get(Category))
                else
                    Values.Add(0);
            end;
            Dataset := CreateDataset(Series, SeriesColors.Get(Series), SeriesAxis.Get(Series), Values);
            DatasetArray.Add(Dataset);
        end;

        Data.Add('labels', LabelArray);
        Data.Add('datasets', DatasetArray);

        if not Options.Contains('plugins') then begin
            Clear(Plugins);
            Options.Add('plugins', Plugins);
        end else begin
            Options.Get('plugins', PluginToken);
            Plugins := PluginToken.AsObject();
        end;

        if HasTitle then begin
            Title.Add('display', true);
            Title.Add('text', ChartTitle);
            Plugins.Replace('title', Title);
        end;

        if LegendPosition = 'none' then
            Legend.Add('display', false)
        else begin
            Legend.Add('display', true);
            Legend.Add('position', LegendPosition);
        end;
        Plugins.Replace('legend', Legend);

        if ShowDataLabels then
            AddDataLabelsPlugin(Plugins);

        Animation.Add('duration', AnimationDuration);
        Animation.Add('easing', AnimationEasing);
        Options.Replace('animation', Animation);

        if IsHorizontal then
            Options.Add('indexAxis', 'y');

        Config.Add('data', Data);
        Config.Add('options', Options);
        Config.WriteTo(Result);
        exit(Result);
    end;

    local procedure CreateDataset(Label: Text; Color: Text; SecondaryAxis: Boolean; Values: JsonArray): JsonObject
    var
        D: JsonObject;
    begin
        D.Add('label', Label);
        D.Add('backgroundColor', Color);
        D.Add('borderColor', Color);
        D.Add('data', Values);
        D.Add('yAxisID', SecondaryAxis ? 'y1' : 'y');
        if SeriesTypes.ContainsKey(Label) then
            D.Add('type', SeriesTypes.Get(Label));
        if IsStacked then
            D.Add('stack', 'stack0');
        exit(D);
    end;

    local procedure AddDataLabelsPlugin(var Plugins: JsonObject)
    var
        DataLabels: JsonObject;
    begin
        DataLabels.Add('display', true);
        DataLabels.Add('anchor', 'end');
        DataLabels.Add('align', 'top');
        DataLabels.Add('formatter', 'function(value){return value.toLocaleString("' + LocaleTag + '");}');
        Plugins.Add('datalabels', DataLabels);
    end;

    local procedure CreateAxis(Right: Boolean; Stacked: Boolean): JsonObject
    var
        A: JsonObject;
    begin
        A.Add('type', 'linear');
        A.Add('position', Right ? 'right' : 'left');
        if Stacked then
            A.Add('stacked', true);
        exit(A);
    end;

    local procedure CreateStackedAxis(): JsonObject
    var
        A: JsonObject;
    begin
        A.Add('stacked', true);
        exit(A);
    end;

    local procedure RequireInit()
    begin
        if not Initialized then
            Error('BUILDER.INIT MUST BE CALLED FIRST');
    end;
}
