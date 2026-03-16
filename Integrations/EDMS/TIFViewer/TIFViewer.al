controladdin "TIF Viewer"
{
    Scripts =
    'bc-azima-2026/Integrations/EDMS/TIFViewer/Vendor/jsPDF.js',
    'bc-azima-2026/Integrations/EDMS/TIFViewer/Vendor/jquery-3.7.1.min.js',
    'bc-azima-2026/Integrations/EDMS/TIFViewer/Vendor/pdfobject-2.3.0.min.js',
    'bc-azima-2026/Integrations/EDMS/TIFViewer/Vendor/tiff.min.js',
    'bc-azima-2026/Integrations/EDMS/TIFViewer/script.js';
    StartupScript = 'bc-azima-2026/Integrations/EDMS/TIFViewer/Startup.js';
    StyleSheets = 'bc-azima-2026/Integrations/EDMS/TIFViewer/stylesheet.css';

    MinimumHeight = 400;
    MinimumWidth = 100;
    // MaximumHeight = 2000;
    // MaximumWidth = 4000;
    HorizontalStretch = true;
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalShrink = true;

    event ControlAddinReady();
    procedure LoadTIF(TIFDocument: Text)
    procedure SetVisible(IsVisible: Boolean)
}