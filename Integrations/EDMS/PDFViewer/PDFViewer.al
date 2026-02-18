controladdin "PDFV2 PDF Viewer"
{
    Scripts = 'bc-azima-2026/Integrations/EDMS/PDFViewer/Vendor/jquery-3.7.1.min.js', 'bc-azima-2026/Integrations/EDMS/PDFViewer/Vendor/pdfobject-2.3.0.min.js', 'bc-azima-2026/Integrations/EDMS/PDFViewer/script.js';
    StartupScript = 'bc-azima-2026/Integrations/EDMS/PDFViewer/Startup.js';
    StyleSheets = 'bc-azima-2026/Integrations/EDMS/PDFViewer/stylesheet.css';

    MinimumHeight = 400;
    MinimumWidth = 100;
    // MaximumHeight = 2000;
    // MaximumWidth = 4000;
    HorizontalStretch = true;
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalShrink = true;

    event ControlAddinReady();
    procedure LoadPDF(PDFDocument: Text; IsFactbox: Boolean)
    procedure SetVisible(IsVisible: Boolean)
}