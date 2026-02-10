controladdin "PDFV2 PDF Viewer - Metropol"
{
    Scripts = 'bc-kenpipe-2024/Integrations/CRB/Metropol/PDFViewer/Vendor/jquery-3.7.1.min.js', 'bc-kenpipe-2024/Integrations/CRB/Metropol/PDFViewer/Vendor/pdfobject-2.3.0.min.js', 'bc-kenpipe-2024/Integrations/CRB/Metropol/PDFViewer/script.js';
    StartupScript = 'bc-kenpipe-2024/Integrations/CRB/Metropol/PDFViewer/Startup.js';
    StyleSheets = 'bc-kenpipe-2024/Integrations/CRB/Metropol/PDFViewer/stylesheet.css';

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