// SKYCHART v0.0.1
const DEBUG = false;

function log(msg, obj) {
    if (!DEBUG) return;
    if (obj !== undefined)
        console.log('[SKYCHART]', msg, obj);
    else
        console.log('[SKYCHART]', msg);
}

// SINGLE INIT GUARD
if (!window.__bcChartInit) {
    window.__bcChartInit = true;
    log('INIT START');
    initUI();
}

function initUI() {
    log('INIT UI');
    if (window.__bcUIInitialized) return;

    const host = document.getElementById('controlAddIn');
    if (!host) {
        log('RETRY');
        setTimeout(initUI, 50);
        return;
    }

    window.__bcUIInitialized = true;
    log('UI READY');

    host.innerHTML = '<div id="chart-wrapper"><canvas id="chart-canvas"></canvas></div>';

    if (window.Microsoft) {
        log('SIGNAL READY');
        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('Ready', []);
    }

    window.addEventListener('resize', () => {
        if (window.__chart) window.__chart.resize();
    });
}

// RENDER CHART
window.RenderChart = function (json) {
    log('RENDER');
    if (!json || json.trim() === '') {
        fail('EMPTY CONFIG');
        return;
    }

    let config;
    try {
        config = JSON.parse(json);
        log('CONFIG PARSED', config);
    } catch (e) {
        fail('INVALID JSON');
        return;
    }

    const canvas = document.getElementById('chart-canvas');
    if (!canvas) {
        fail('CANVAS NOT FOUND');
        return;
    }

    if (typeof Chart === 'undefined') {
        fail('CHART.JS NOT LOADED');
        return;
    }

    if (window.__chart) window.__chart.destroy();

    // ADD CLICK HANDLER FOR DRILLDOWN
    if (!config.options) config.options = {};
    config.options.onClick = function(event, elements) {
        if (elements.length > 0) {
            const element = elements[0];
            const datasetIndex = element.datasetIndex;
            const index = element.index;
            const chart = window.__chart;
            
            const category = chart.data.labels[index];
            const series = chart.data.datasets[datasetIndex].label;
            const value = chart.data.datasets[datasetIndex].data[index];
            
            log('DRILLDOWN', { category, series, value });
            
            if (window.Microsoft) {
                Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('OnDrillDown', [category, series, value]);
            }
        }
    };

    try {
        window.__chart = new Chart(canvas.getContext('2d'), config);
        log('RENDERED');
    } catch (e) {
        fail('RENDER FAILED');
    }
};

// UPDATE CHART
window.UpdateChart = function (json) {
    log('UPDATE');
    if (!window.__chart) {
        log('NO CHART - RENDER');
        window.RenderChart(json);
        return;
    }

    if (!json || json.trim() === '') {
        fail('EMPTY CONFIG');
        return;
    }

    let config;
    try {
        config = JSON.parse(json);
        log('CONFIG PARSED');
    } catch (e) {
        fail('INVALID JSON');
        return;
    }

    try {
        const chart = window.__chart;
        if (config.data) {
            if (config.data.labels) chart.data.labels = config.data.labels;
            if (config.data.datasets) chart.data.datasets = config.data.datasets;
        }
        if (config.options) Object.assign(chart.options, config.options);
        chart.update();
        log('UPDATED');
    } catch (e) {
        log('UPDATE FAILED - RENDER');
        window.RenderChart(json);
    }
};

// EXPORT TO PNG
window.ExportToPNG = function () {
    log('EXPORT PNG');
    if (!window.__chart) {
        fail('NO CHART');
        return;
    }

    try {
        const canvas = document.getElementById('chart-canvas');
        const dataUrl = canvas.toDataURL('image/png');
        log('PNG COMPLETE');
        if (window.Microsoft) {
            Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('OnExportComplete', [dataUrl, 'PNG']);
        }
    } catch (e) {
        fail('PNG FAILED');
    }
};

// EXPORT TO CSV
window.ExportToCSV = function () {
    log('EXPORT CSV');
    if (!window.__chart) {
        fail('NO CHART');
        return;
    }

    try {
        const chart = window.__chart;
        const labels = chart.data.labels;
        const datasets = chart.data.datasets;
        
        let csv = 'Category';
        datasets.forEach(ds => { csv += ',' + ds.label; });
        csv += '\n';
        
        labels.forEach((label, index) => {
            csv += label;
            datasets.forEach(ds => { csv += ',' + (ds.data[index] || 0); });
            csv += '\n';
        });
        
        log('CSV COMPLETE');
        if (window.Microsoft) {
            Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('OnExportComplete', [csv, 'CSV']);
        }
    } catch (e) {
        fail('CSV FAILED');
    }
};

function fail(message) {
    log('FAIL', message);
    if (window.Microsoft) {
        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('OnChartError', [message]);
    }
}